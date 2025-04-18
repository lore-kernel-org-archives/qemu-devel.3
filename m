Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6A9C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 09:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5iOG-0000Xn-2S; Fri, 18 Apr 2025 05:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5iOA-0000WC-W6
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 05:52:04 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5iO7-0004Sp-FE
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 05:52:02 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so1733921f8f.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 02:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744969915; x=1745574715; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sRW2Z+u8s5/P5dIlcyOgmjGfvowI9yQ/5JBUpt8OXGQ=;
 b=OTM7Bhe6ShUB+AyO8Bqo/hxFSc9RzSvU0yjFba5nsKMdxzEf3Gb0OBC5PPjgyXMKtT
 VeZ4uhcDgBAG8IBFJn550xJZDas4LJPKP9RVpzjfxyC5scif2l/7XbSX4JmzYtPDwLwH
 UoUKV4hfP1/qPM7ifdSNOHBV8SxmRYOkJ0W9ArNs3wZYIp04rUjwkwGGvD7Yc+ZgnBjY
 G8Wo6ENC6jKI9aSM5soFMqwuKz+hf/25sJrB7UgzUEnKkC81hZaxkavNuO4+caQRt2XE
 ZqFHOB2h7zZWXJ1jeioPFQmXYB6LiVw4k1M6GofzZgpF47aXoflbL87DfMZNEynWZ6gI
 U8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744969915; x=1745574715;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sRW2Z+u8s5/P5dIlcyOgmjGfvowI9yQ/5JBUpt8OXGQ=;
 b=V52fNCXG57j/Sgzbh8uGw4zwDmeQ5GP+WZZOVflohJZeGlgKxhqTiBXFjsv6R7w4WI
 vLZjzFPRaL+nkw74ez/GuYjHfYZydsYIPz0UKbnYLJD8NtpDFEoPyo19FuC784TdYzSw
 FsvDp6upWiZZQeJu08+9COlAGdiBOJVwS8dAu4bF4rPVcsu5a/ccU46P3nID1LSGi713
 NGoo7/6eQUyaKRc/dsMRgQDR5oe4++Cju5eduQHnewaRQK27CHPXLEJ1G9A9XBnVLLhV
 K+VeZjWnBwYUL1lV3gojb1L5r4vzPWkoyByoyFqBhk3OYHp3Vp59wQWSH7L9wUmc3XPc
 kN0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWYq8liz94PvkoOASJHJ/st4/8+wT80mjztDzdUo7i2vz1LTx+8CLXf04MTGssRI2P3rILwJaFtW2/@nongnu.org
X-Gm-Message-State: AOJu0Yx6U1u63b7bgQy+/M2ui2culzkS3WudTIFYlBbL2ePDtZBTQ19k
 XgnUWwE9KZ2snjVbkHlTTQmHKe28fMh4ZYCQZ6FkheWxN7W8/GI/rn+YOOpl4/4=
X-Gm-Gg: ASbGncs/52Lo7R9Ur7afNUIPWMvOfbunXyshPzSjCFi5Votse2EsGYoo0R1JlaTxyg1
 f/hKsJhAyGuHsWS4EdNmrBNhGMOCa5LSbFRvJG8l9snynpSwhu5A5dTdBoRfX8t29lQNebbP9bP
 vANeFhJC9jjXS1J00a9PVxtBUcz8FpzTZtV2jQdbAkkMOdkDvrnjI4chs9Vo7yYoGHgPBn0yEYC
 /0AeK1K12GnmlOVdf7Fr7onkSp7VbwqzvZyzpYLvu3jz8T7lFoo/zZ0ADeX5V6PsIGXEBxacQS0
 W8VuScfzOAB8pdh8YMkC4ZjXvjyXx1EhS9fn/a2Cr9voqp1RYGKVY/DGda4HzwI5pnad0qGTnyJ
 BXSKtsVkS
X-Google-Smtp-Source: AGHT+IHtKK8FL9xDdm93n7yAz0+/VUOCHpF3jHNphM1cCbOEjbLSnn3qsyO179OXMEuY/Lkucd7VAw==
X-Received: by 2002:a05:6000:40de:b0:39e:e438:8e32 with SMTP id
 ffacd0b85a97d-39efbb09208mr1461886f8f.55.1744969915504; 
 Fri, 18 Apr 2025 02:51:55 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa420740sm2292836f8f.16.2025.04.18.02.51.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 02:51:54 -0700 (PDT)
Message-ID: <f6e39f49-2eb1-4f7c-bc0d-1cfc7bd60091@linaro.org>
Date: Fri, 18 Apr 2025 11:51:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] block: Update block to compile with Emscripten
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <9da41d784991f77e2c1f38d0781cd047b593e053.1744787186.git.ktokunaga.mail@gmail.com>
 <afe0abf1-2c33-47d8-bde6-8abc722eb212@linaro.org>
 <2d232dbc-4613-4352-8ede-3fd5dcefc32c@linaro.org>
 <CAEDrbUbQ2h1wj-KJqjYjcGPb4Pyp0te8ycy2DoJGENvT2+Mxcg@mail.gmail.com>
 <e7f66ec8-ee38-453d-a6de-4ed8d5a54268@linaro.org>
 <CAEDrbUYw2mp-UrYGXtEDSuwRP+8oC3nHq5s9VppGj=7f7_Gq_w@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAEDrbUYw2mp-UrYGXtEDSuwRP+8oC3nHq5s9VppGj=7f7_Gq_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 18/4/25 08:53, Kohei Tokunaga wrote:

> The following is the patch updates file-posix.c to solve this error:
> 
>   #ifndef HAVE_COPY_FILE_RANGE
> -static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
> -                             off_t *out_off, size_t len, unsigned int 
> flags)
> +ssize_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
> +                               off_t *out_off, size_t len, unsigned int 
> flags)
>   {
>   #ifdef __NR_copy_file_range
>       return syscall(__NR_copy_file_range, in_fd, in_off, out_fd,
> 

Yes, LGTM!

