Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF37606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gOoiQKhv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM1Vw-0008Am-Nz; Wed, 28 Oct 2026 07:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM1Vu-0008AA-Dv
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:08:14 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM1Vs-0001NY-V3
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:08:14 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-83bbcfba0ffso612413a34.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 04:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793185690; x=1793790490; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nr6rulvhGl4ps6/EhCTQXwqVyiVQeet7NB/sIVEyne4=;
 b=gOoiQKhvvVhw3pGd7Niebh3KbhhNWDlztH/QwyZwDbkjoHqyru+bMoEvOAc3+C0qXE
 A/2jdsipjURl6/hXGatmp/1FoalfGE3RWNdb/HG4xuJa9CvJ1iijyWONQUEHu13ABP1C
 xErRmNmlkNjNCgLBYj53sdquET/Fc3Xv5Sf7nuKrNIQ2MM6VT0ZUrlyBB1pti0bVam3+
 g1pBsQDI6aCtC/sffX3NHaG0SnmInNbNGfFubcpFkjGzsPigJGNOBuavpSBsfbQwRcL/
 KPB4bXHAj1jW2K+DGZzrBcd1jUOvXLYWQ9sb9egaGpH+ZYQJTAKSAL+K/tugVgBDk3RX
 t1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793185690; x=1793790490;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nr6rulvhGl4ps6/EhCTQXwqVyiVQeet7NB/sIVEyne4=;
 b=vvrfVWx6pM2uthSyINgMcOawD/zJ1LZeWzyzhlSiWULHWraaj69UnEcNRGNAiX8gJA
 RzuRHxVgBSiATtOOUv1u/Wo3PPUuymiM3AOwpYglD2oGLpw+OiU++5L7mTQM6RwO45+4
 N2MY17+tEe23Mj4PVsxq3vpthKJLUtJlaZZCPvZKvVYq9OZ54nyOaYpFFlwdFDYI+HRc
 +An4YAZEMY0d4299udwDuNgTAEMOoXZpbTlU8w/nvOpxpqSgyogRRHmK1e5TW1VsI+V5
 /EfDBG3kC+ms6Swp/s3jLBSlXs6LLQLc5pXY0diJfcpYB5xU8fSk2qIbRl89LT1mmc/r
 3q1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcdoNT1CSzl12xWFX+erlbqAOrhI3S8mscqhKx2tbty1swI5Pnx4bVRZgy6u36fUJD7xV7jwuSa5zV@nongnu.org
X-Gm-Message-State: AFq9FYKh9VBOvajCy5FjukYywlZwrI+8+upmS7gqPGrbMX1yrsWOD3+p
 4+qUNRN7SyX6hlBK5IUcT3QLw6Nh4aqYN7d32e8GSeYGgE37XnM5J3KUeFkIj5sPVQ4=
X-Gm-Gg: AYBFou0G5r4WCfI8S2Puvr8NngL9ArGhXsdcq33CERM9tkyHTBXvxeMOBztfWARtkvg
 iqHLBwt71cRjTqLKoD/ZwFITI1gZHvuuVCc6YNfNRx95NCLXGTWUl0LulDxJFKgf0CQQX9zplAS
 N94vewQEDb6WAbetmJR8wZNgKAXAlYEQydoQwMUt1/7iJb8Ab2lpcklNN7Q7fhCz/AVy5de3xCJ
 LiP8/UBsu524Z9/2685mPW3wwbFGWd1lmRYxgrqlemHXCv+nLTgNqLPLHrXDYDa1t2BG5y6QBHW
 Q/yMJIkcImh8QJvDfCnFeAOW9wFA9Pp5dCXcOx97dgLW9DpPynwpT/mkZeKJ2eandy0LGoi7/Pr
 Kp2C/kWvpkAD9INVRngkV0VhgHsDZ/gvh8IhiNMp7BI9lv9NkCGFDXx5oU5QMYxoiuLy873LZN7
 5+PZo5LmgiCOGOarrwlMX6yLKaTgJUKkvcCXavBckFdkaeqI4rQYATRly1INdezty2dBpQuo2pi
 pByaJDSeIwvCmLSm+/HoGS6YEfxqZMK/aDdBoAyJ3iCKRGRE31ebuE4vurNFvKrt6BkZMguSBsA
 U9126ohqz3yk3zoi4XAGfx3VW9m7FS9dRIRZqj2cIpRZ
X-Received: by 2002:a05:6808:1b27:b0:53c:7298:3598 with SMTP id
 5614622812f47-56382b885d6mr1221824b6e.31.1793185690473; 
 Wed, 28 Oct 2026 04:08:10 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-563c5a4d8b7sm864007b6e.8.2026.10.28.04.08.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 04:08:10 -0700 (PDT)
Message-ID: <7f2fb4fe-887f-449b-9a08-c65375077551@linaro.org>
Date: Wed, 28 Oct 2026 06:08:08 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Initialize SMCR_EL1.EZT0 for linux-user
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Samyuktha K <samyu@qti.qualcomm.com>,
 Sritam Paltasingh <spaltasi@qti.qualcomm.com>
References: <20261026175220.85545-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261026175220.85545-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 12:52, Philippe Mathieu-Daudé wrote:
> On SME2 systems, Linux sets SMCR_EL1.EZT0 in cpu_enable_sme2()
> to allow user space to access ZT0.
> 
> linux-user already initializes SMCR_EL1.LEN and FA64 to match the
> kernel's setup, but leaves EZT0 clear (see commit 3aad4bc8beb9
> "target/arm: Add zt0_excp_el to DisasContext"). Set EZT0 when SME2
> is present to keep the emulated EL1 state consistent with Linux.
> 
> This has no functional effect because CONFIG_USER_ONLY omits the
> ZT0 trap checks.
> 
> Reported-by: Samyuktha K<samyu@qti.qualcomm.com>
> Suggested-by: Sritam Paltasingh<spaltasi@qti.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/arm/cpu.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

