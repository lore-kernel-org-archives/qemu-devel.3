Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE77C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 08:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCxE5-0004Ld-2d; Fri, 31 May 2024 04:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCxE3-0004L8-PQ
 for qemu-devel@nongnu.org; Fri, 31 May 2024 04:02:59 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCxE1-0001gC-Ig
 for qemu-devel@nongnu.org; Fri, 31 May 2024 04:02:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4202c1d19d5so17114965e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 01:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717142576; x=1717747376; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P60MOZ2WbS6bsT2WPQz1Cgly6t3sgd95GrQT3VO8LjE=;
 b=OtXfKpWrvyb9iUivNQUx1RkDCr0M3OSY6UDeDaE8VyVb5aEtMiX9yAuChl9kAN5Jz1
 LMV8DimTC2qPpIaCrVj1sZJ9iu6/pkIoDECmLepQBx7JJ7BDfPLIA7j0jPQt8PuBL/nu
 5SwPFHnmfainnIYsFUJykOpqqyGy3V/76wsaxP/Dp40y11Ff6Hy3m5pbeKI7wNfhn8MT
 Vt9BIFAk5yscXjE6BE/47RRER61fkFkL9UQCM3m5Hrg1b6Mx+BKQ5s5O1ZvvjEZj+ld7
 DOyuGHqLiNz/13RR3b58r18YloZEor7DTaz5zyNE2c5ezgApzW3usrAdeqflRXOMIC1x
 PVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717142576; x=1717747376;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P60MOZ2WbS6bsT2WPQz1Cgly6t3sgd95GrQT3VO8LjE=;
 b=fABD4NxkjoJKrCNu0r9DTjMU4cC5dziDsjsaO0JiUfbEa/LhmFIpEURCNCWv+oqf23
 4teTCzCRsyG3vNbpH623LyqdrOztsWsG93L9MQHvgNmm9mH43R+YZxrbhfnxcJCGknev
 9d8eAdjvXfoLZ4W9RpDqMRi647hG+nfakbRs0DdH7sCoeugkB/It840ERcJ3rkQr6QkG
 UTgmbN18gSMfBBRvs7L1aa27n9pnknaiKV++TGG+JNT79o3qT3VtJIs01rYH7htNOEGs
 kYvzRTODW5F8xW1KTMZw5oPpWvyPLK70xIpETdeQMPzSAC6LMQRlGp25mDGiBRaxV4RD
 wJCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMF72dTQcj7tmZriPk52TfsqlsTyHFmyMExxc+rgzY3IrOIN8gdNOyxRYEcgRfnUfpP0MLF/NyZO5WCVIolm/A7WOekd0=
X-Gm-Message-State: AOJu0YwkKkNbgH9NDD2UV47ZzbnXF8aQnFhJI53Mb8TKgHp+tNVfj5PF
 LFMukirvpzqfuQhPcuvLj/D4EBlOVt0uX7m3MZ8c4qIlImO7oENTJsnfgvvzcmU=
X-Google-Smtp-Source: AGHT+IHrxV+8vibYivquBSscH9fzfUeY3MQ43lZN89zCEyw9q2oswTGI+KIjqyJkHI6tBh4NKbX/3w==
X-Received: by 2002:a05:600c:4f46:b0:41f:f32c:e097 with SMTP id
 5b1f17b1804b1-4212e0763ebmr8183405e9.23.1717142575348; 
 Fri, 31 May 2024 01:02:55 -0700 (PDT)
Received: from [192.168.69.100] (sml13-h01-176-184-15-35.dsl.sta.abo.bbox.fr.
 [176.184.15.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b84adb4sm17052095e9.16.2024.05.31.01.02.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 01:02:54 -0700 (PDT)
Message-ID: <25097737-270b-4473-ab4b-35094e232b8e@linaro.org>
Date: Fri, 31 May 2024 10:02:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] osdep: Make qemu_madvise() return ENOSYS on
 unsupported OSes
To: David Hildenbrand <david@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com
References: <cover.1717140354.git.mprivozn@redhat.com>
 <4dc484ae240edf8df0de14edefc3c3a717a1c781.1717140354.git.mprivozn@redhat.com>
 <dfbdd318-705c-47a8-a192-10c5a8118f26@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <dfbdd318-705c-47a8-a192-10c5a8118f26@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 31/5/24 09:53, David Hildenbrand wrote:
> On 31.05.24 09:28, Michal Privoznik wrote:
>> Not every OS is capable of madvise() or posix_madvise() even. In
>> that case, errno should be set to ENOSYS as it reflects the cause
>> better. This also mimic what madvise()/posix_madvise() would
>> return if kernel lacks corresponding syscall (e.g. due to
>> configuration).
> 
> Yes and no. According to the man page
> 
> " EINVAL advice is not a valid."
> 
> if a particular MADV_* call is not implemented, we would get EINVAL, 
> which is really unfortunate ... to detect what is actually supported :(

Maybe skip "This also mimic what madvise()/posix_madvise()
would return if kernel lacks corresponding syscall (e.g. due
to configuration)." for clarity?

> For the patch here ENOSYS makes sense:
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 


