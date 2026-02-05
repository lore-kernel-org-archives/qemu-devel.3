Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22D7EC1EAD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 12:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnyO5-0006wn-PN; Thu, 05 Feb 2026 07:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnyO4-0006wc-Aa
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 07:23:08 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnyO2-0000Yb-GI
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 07:23:08 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b8d7f22d405so126761666b.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 04:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770294185; x=1770898985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kuYrUiRBrAVMf7ZBWeK7ZQ0HIrHRw4wT69PCHop86Q=;
 b=bUFCz91LgCoz9TUf8016YkCoT4YxadjL24d7+i+0vtm8IH38LM953ty3ST8TvRH8ez
 Kys1L0KhiHihky36bM/kD455ziWBgcSR6IeqTp3dghPQzdIH8kpgt9Ede3B36GAJj6om
 W9KngBguz4f+6mne8yCd9h/OTYOFjVOaF/w85PWpKbMbb+KWyO6spKTSfU1NvU9i6QPk
 SpJlT9dIFQMG7KQXMnvL3uK/bpe7u3WEgR28IgEiHXtKnZLyudLUop4x5pWMUHVyY9yt
 xUvvZNJaJx3I0EI2wxq+QhNEwWjPFFMWal34hU3z/7U1sZWTaeTIBgypHRcklSaVQJMS
 Kpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770294185; x=1770898985;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9kuYrUiRBrAVMf7ZBWeK7ZQ0HIrHRw4wT69PCHop86Q=;
 b=BJm0xOZ/63G9s8zSWoQPoDZ7xHzS3OPsc5Wnz7hgg0gmzVRhAWbdVL9pXGynBnSgR8
 9Gbpz+jKjqYkr4gqJDJwYSL4pNUqHYgrYRkpogoLRvt5Es9JpL9kSHdFVbT0IM8PAFVe
 bjc6tN6DBHM+/fD4oNa5HY7Y3Ljmuh/0Oc75+w0cCdTfzQtIEcbcVZoOjCVLpC0MTkhs
 R9hT0zgPAEMksip/ma/iEHIxKdiij5Jw0WtGxZj7SLbdFWXkgtKVL9TRH0OWi5nzq0jh
 rpToZsSJUCCxDVLR0GSfoPO3E/My3h2pMJ0CgzbLjxusGFVph4ig9AJlqTCIcVuPNX2W
 NqJw==
X-Gm-Message-State: AOJu0YzDqGU6pmpIZzI+PcMfAoKyWCveDrFvFqZi7mGYx+Qd3yFFFPux
 D/oN5iqM4C2YeSeSX/ImSfA8V3TfTwBzUD45iyB3gsN8LlHrOQwq0bNxYgIpjEazBjg=
X-Gm-Gg: AZuq6aLtRFXv59MQaqAO6M6t8zQnyR9ADA8LNyqg6+GSOaRcOkSq9gCnGGWLjt53UuQ
 u6p5ojafM+rRzr3RA0jiswimlq+kY4ZA9RXdlHTXMljMrPl8wgo2YeXfKm51QMESJnX5wrgPVjk
 /iPeSQgLk1JFIJUxVpmexDIjV/bvhdowqNTxjm7J9g3X/ecqRikcx64y2qMNc719vTDJrXhFSYE
 j/DMYnmjitymF8WCYnmQDiZazqKY9y0EOv1rRD39dFBUpAk1ktLxIJdwYBAYuX3RNyj5w+iwY/x
 3zP4FW+uyqDqao/JymjhKsyzrvi0B1hd12BVRMKh8goarSXym0P49eTgqyN6IIk5ZzC133/mS/Z
 lIsj8OU8emmvj61C2GaZnBIqlJ7vgaq8NZeglX6Ul/71vxPKuI/U5wA7EDc9bxQRPFOykde/jMj
 7GX/SKq0S6yak=
X-Received: by 2002:a17:907:3e06:b0:b87:6d6b:1366 with SMTP id
 a640c23a62f3a-b8e9f3c8cf2mr422463066b.41.1770294184476; 
 Thu, 05 Feb 2026 04:23:04 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fef0006sm224128566b.41.2026.02.05.04.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 04:23:03 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 28E925F798;
 Thu, 05 Feb 2026 12:23:02 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] target/arm: implement FEAT_E2H0
In-Reply-To: <3e6ab807-37df-40ba-840e-4693071691f7@linaro.org> (Richard
 Henderson's message of "Thu, 5 Feb 2026 07:43:40 +1000")
References: <20260204131353.2977855-1-alex.bennee@linaro.org>
 <3e6ab807-37df-40ba-840e-4693071691f7@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Thu, 05 Feb 2026 12:23:02 +0000
Message-ID: <877bsrnzvd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Richard Henderson <richard.henderson@linaro.org> writes:

> On 2/4/26 23:13, Alex Benn=C3=A9e wrote:
>> FEAT_E2H0 is a formalisation of the existing behaviour of HCR_EL2.E2H
>> being programmable to switch between EL2 host mode and the
>> "traditional" nVHE EL2 mode. This implies at some point we might want
>> to model CPUs without FEAT_E2H0 which will always have EL2 host mode
>> enabled.
>> There are two values to represent no E2H0 systems of which 0b1110
>> will
>> make HCR_EL2.NV1 RES0 for FEAT_NV systems. For FEAT_NV2 the NV1 bit is
>> always valid.
>> Message-ID: <20260130181648.628364-1-alex.bennee@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> v2
>>    - new helper and properly handling NV1
>> ---
<snip>
>
>> @@ -3801,10 +3802,13 @@ static void do_hcr_write(CPUARMState *env, uint6=
4_t value, uint64_t valid_mask)
>>               valid_mask |=3D HCR_GPF;
>>           }
>>           if (cpu_isar_feature(aa64_nv, cpu)) {
>> -            valid_mask |=3D HCR_NV | HCR_NV1 | HCR_AT;
>> +            valid_mask |=3D HCR_NV | HCR_AT;
>> +            if (!cpu_isar_feature(aa64_noe2h0_and_nv1_res0, cpu)) {
>> +                valid_mask |=3D HCR_NV1;
>> +            }
>>           }
>>           if (cpu_isar_feature(aa64_nv2, cpu)) {
>> -            valid_mask |=3D HCR_NV2;
>> +            valid_mask |=3D HCR_NV1 | HCR_NV2;
>
> Why add NV1 here?

My reading was if you had FEAT_NV2 then HCR_NV1 was always valid
whatever E2H0 might say. Unless we can validate we don't get
contradictory ID values elsewhere?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

