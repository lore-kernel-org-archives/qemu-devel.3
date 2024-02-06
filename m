Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71CCC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 22:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXUDP-0007kH-Kq; Tue, 06 Feb 2024 17:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXUDP-0007jR-2L
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 17:46:55 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXUDN-0000CK-Jp
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 17:46:54 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-216f774c827so21891fac.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 14:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707259612; x=1707864412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v4dqOfZcyZir5PmfaUZp5kfKY5B4/JZGvIMHiMcUuP8=;
 b=KJxye92rBeKgW75/VId/YOXT3l8fa/MTVdrQeZ63rvbTEUwu0fqr+kE/O1lfGoN+A+
 mLbxPP97m69e3OStDxMSdabmYqUxIMlPDHVRex47vzT8wfrjO7qHfTS/O6tb4rLWfKbp
 WBDaKpv0klgQBJxIJ3qB5x6Ob049KKraQU/G+z01dAFMRHpB4nwOXkA4r/+P6tphwI4j
 /gZi5DdYskFP12Vc7rc8ZwYmEe7fZEF5E8MryIWvnGvy/F98UE5qd+LRwndpR/lhX8N8
 mJ42zJKvLMk0lA2X/blh4Rzw1JmCcGIuLj8PFF2MRvG1bpWENXasVDG3VIsJ7u1AEgm8
 17rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707259612; x=1707864412;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v4dqOfZcyZir5PmfaUZp5kfKY5B4/JZGvIMHiMcUuP8=;
 b=DAB+xPzqHrGQZC6M4MavlakbIS59qoC278407+4jEZq7v158QchnP6zF2y5Kf9Wwra
 VKYJW3MK1otyTHX5JeHOMYSYWhx9DO02J4A2j6lJgl3lW6rqdGJIRiYEZH3nnBsTGjRh
 OqYwhdAx4ha/odgAPHJ8d67krV31xtdIOIXc0pBTqRBdf3xX4TBJDtHfdtP71xV56xhw
 aojZiDPbuLENw+vO/h6AimwJ402yH7zFV9/TjQLlBjXOadig4S9HucpTu2mH13y35t2S
 8borPTD+lMBujkMaAQqe5NGoAObNxHI5aOsadZyyxKYrmABR0ElWUxuxCtTkyBzlDC7R
 8tqA==
X-Gm-Message-State: AOJu0YzOLPiXTk6EphriU4XufhALx7hQcaxq+jwUeZUWPpI03nXn4+X3
 Gt7fVlbqYV6+RnlEknrswBRsm9PwC1h15PTpFEUFcgL4TRD+M+uuAZx2HkFPc2Q=
X-Google-Smtp-Source: AGHT+IGXwr4nblmdloqZkxIfp6WkJxRTRVTvFr99UN7MrQnJR9TeZ7pGF7/60rJpQAAeQ5DLzyRrnA==
X-Received: by 2002:a05:6870:3911:b0:219:47c0:d46a with SMTP id
 b17-20020a056870391100b0021947c0d46amr4488079oap.16.1707259612195; 
 Tue, 06 Feb 2024 14:46:52 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWZM/rnSz863a4G0BgrpR+MmklcvaYYnWlHPIo0nNtafZGdh7wzLttuit+bT1i754ClpC6unTZjoo0YEV1eu9uCr2VKCgtdcbRNhIrzJSDnsBWemWVHsweC2Pc=
Received: from [192.168.0.100] ([43.252.112.200])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a634912000000b005cda7a1d72dsm2688606pga.74.2024.02.06.14.46.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 14:46:51 -0800 (PST)
Message-ID: <0df76ba8-7631-4095-8748-eda66054a642@linaro.org>
Date: Wed, 7 Feb 2024 08:46:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] util/bufferiszero: improve scalar variant
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Alexander Monakov <amonakov@ispras.ru>, qemu-devel@nongnu.org
Cc: Mikhail Romanov <mmromanov@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240206204809.9859-1-amonakov@ispras.ru>
 <20240206204809.9859-7-amonakov@ispras.ru>
 <0b532b64-296a-43a6-bec9-6450eb411a65@linaro.org>
In-Reply-To: <0b532b64-296a-43a6-bec9-6450eb411a65@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

On 2/7/24 08:34, Richard Henderson wrote:
> On 2/7/24 06:48, Alexander Monakov wrote:
>> -        /* Otherwise, use the unaligned memory access functions to
>> -           handle the beginning and end of the buffer, with a couple
>> +        /* Use unaligned memory access functions to handle
>> +           the beginning and end of the buffer, with a couple
>>              of loops handling the middle aligned section.  */
>> -        uint64_t t = ldq_he_p(buf);
>> -        const uint64_t *p = (uint64_t *)(((uintptr_t)buf + 8) & -8);
>> -        const uint64_t *e = (uint64_t *)(((uintptr_t)buf + len) & -8);
>> +        uint64_t t = ldq_he_p(buf) | ldq_he_p(buf + len - 8);
>> +        typedef uint64_t uint64_a __attribute__((may_alias));
>> +        const uint64_a *p = (void *)(((uintptr_t)buf + 8) & -8);
>> +        const uint64_a *e = (void *)(((uintptr_t)buf + len - 1) & -8);
> 
> You appear to be optimizing this routine for x86, which is not the primary consumer.
> 
> This is going to perform very poorly on hosts that do not support unaligned accesses (e.g. 
> Sparc and some RISC-V).

I beg your pardon, I mis-read this.  You're only replacing the byte loops, which will be 
more-or-less identical, modulo unrolling, when unaligned access is not supported.  But 
will be much improved if some unaligned access support is available (e.g. MIPS LWL+LWR).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


