Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A59C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 22:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twTsO-0004S1-Np; Sun, 23 Mar 2025 18:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twTsM-0004Rg-Fa
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:33:03 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twTsI-0005HT-GU
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:33:00 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-225df540edcso90840935ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 15:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742769175; x=1743373975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1dfBOWhIK0yRflxjnnMQn7Hmw4i1SlwuQ+2tR2ldUdw=;
 b=frhwQ/jwGKIB7+vLvZe7nIXcUXh0IZOk9Kvp8nJnoyQVWVkbRgH4Rt//f+Gspiq+BX
 8Oukr5EbyONz+2OuWTWymVe3MxdVVJqc5PGMCgg5StYcUZB9W9RdaGvDeKhL7pHvZ1UU
 B9Kf/7VP8n2qXsdxRR8uZJOY7B/2oQ8HxOYwN8YY0M6wAuPo5DTvnxIHAA+qtpzpH+xZ
 /VhjGFZ0H03lRcYUQBAlZvWUFws6LXRH/csJoef6FK0EZ0tOlx3/bf1XJE/M1hkjQGwa
 6pj9pQ+5rFrhsJVD0LUzwNwVow/B+rqaH0bq3hKY/y/8pj0tLlZtNv7Qz9cc+1YifZfR
 5eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742769175; x=1743373975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1dfBOWhIK0yRflxjnnMQn7Hmw4i1SlwuQ+2tR2ldUdw=;
 b=LjdyPKGCBlkg+1a3aeKxpznqyCUTT3lN1EqKygSOgJ5yid9gGeX3zsWe80mtN3sj/h
 f+VJVM2MrAa+/y6VXW3N1/FDbzt3pu+jhZrjIhBK/Rv/Nz9wa+dh3pMWAyx1IiV3whoI
 mQGMGEjDwWFGA51Bh13wibvudZKKucfLdHl0DjoEU5LiloiKnlr/pt+4sbFSVtTs/Lnj
 lXw3pEgsA3lbjMd6OP5BIt6euyPQKa9EPqhtN5PJJUooGFmQhQg4RvbTCu9Z/V2zOlkE
 zZ6/jlp1uv8rKA6ksWgd5nfrekt6vAT4oQDAzJ89klMtftHivGG+EfumwysR+pun7jeh
 aegQ==
X-Gm-Message-State: AOJu0Yzvng0vEBlt1DOM2tQ8pHXphj5sUQrDbFsDISfaHseW1rs543w0
 v+dgOk08Y1QfXe6oegvYnnPgtHcRU5Q06d8k0ad7PrdOdqwsPAyvzregzaFvoj2aiymGiCtPw1N
 9
X-Gm-Gg: ASbGncttMU3dgkJ8O66VePMu6HHHHxQddVHSRfmA127YrLezpyOO9DxmwULDnBdu7Xe
 SGG2JziWvE0Pu9ovSclQk1PihsXp3dM9TCOuPb4Mgosxbvpnu8lf2Ss2GXsywJWDxOyzsrqtV7L
 zonlpJih3iNdLj08HmHfr5OEh8bMzRbvAXdUNgCaT5lViiSgYWwLLkbQVA29Le5Zy+jbCzCh/Zc
 5MTDaF9FX3h61fOVvA7khJLdh5OEzSrjC4hrqS0fjEzI0OhVkt2spb+VQY4Lf9x01+hP6xyVaGD
 0Ld4VEHLxTkj8y6Q2c6wv8rbkJawPfgWH2DOR+SBytPi0uO343QqmkbupwdNRKat4dvZY/6HmI5
 8cqfe/z8t
X-Google-Smtp-Source: AGHT+IElpiOCEk2eWTFInA6qXcWit72OadL4QQQFuqmphfpLUK4yzmHYjqzP7yTSceo31WY+F0OTUQ==
X-Received: by 2002:a05:6a00:2382:b0:736:4e14:8ec5 with SMTP id
 d2e1a72fcca58-73905a2a70emr16678153b3a.11.1742769175051; 
 Sun, 23 Mar 2025 15:32:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390615804esm6534635b3a.133.2025.03.23.15.32.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 15:32:54 -0700 (PDT)
Message-ID: <6a651ddf-8a01-40bf-9d7a-126ba69d2f95@linaro.org>
Date: Sun, 23 Mar 2025 15:32:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] load_aout: replace bswap_needed with big_endian
To: qemu-devel@nongnu.org
References: <20250320124313.819222-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320124313.819222-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/20/25 05:43, Paolo Bonzini wrote:
> Targets know whether they are big-endian more than they know if
> the endianness is different from the host: the former is mostly
> a constant, at least in machine creation code, while the latter
> has to be computed with TARGET_BIG_ENDIAN != HOST_BIG_ENDIAN or
> something like that.
> 
> load_aout, however, takes a "bswap_needed" argument.  Replace
> it with a "big_endian" argument; even though all users are
> big-endian, it is cheap enough to keep the optional swapping
> functionality even for little-endian boards.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks, queued to tcg-next for 10.1.


r~

