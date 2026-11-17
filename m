Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F1D606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Fg8p4TBm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTMTT-000889-BH; Tue, 17 Nov 2026 11:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTMTS-00087t-7I
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 11:56:02 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTMTQ-0007so-JY
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 11:56:01 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3b3bf3bef9aso712576a91.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 08:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794934559; x=1795539359; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vNCAediImjDzyCQwv9bgOzJ09EId2KLVuKAW085iYNM=;
 b=Fg8p4TBm8kQYay73DOEc5N6YYEuBak6Aya4wZA1acdXN0ohzChBNikOpSQ+lx+XEc7
 A8MsEfmX/8Ayr5tbT2aCiFC2wus59PN3kfJX1EicDtzFuQhXMgbadpbPe1HwcO0Rj/nA
 2Axd+v34+eQaN4FaRNHGFtXKJXxr3bP5ZNXxtlxIbPHOC89Cqdmqyltt/eYk4uuB5Nl4
 oOjFf9aB/rOjMos6u2Whb/Z5y9qFGTsZr5PrlfjdDw266LVEQ1Ol/2TnLUivvrAxtPwA
 H/DOHLp8DAvh/qjkPTCzA7oB4zWKfU271CDGlosGizdsV7l4Ai1V7SnddMlmBRPls2Kl
 VQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794934559; x=1795539359;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vNCAediImjDzyCQwv9bgOzJ09EId2KLVuKAW085iYNM=;
 b=bls7VCaJg88tekNYGndpd3T2BB+WRdh5d7125FGH0BL/o+PFS+WdTcQVto/Dw5ymdd
 ZDEESgZIv31q1PWlJ2e0wPoa6kzeYE1PpDCqsqw5EGSbd6EZHlVFzhARINEpqg8tctPr
 n/T1WfDByJtNE1+ShM/fjWqSJQrDwaQ5gx9daYZfQedLdT/YE47WXqWGuT5BQrDQ6Oxr
 mCL4iydviB3g/6GZRlorTEGPuCYaglTzuZbcnchThxUwRpuy5Xtl2xmW+WIXTvdW/ioz
 sDU4Ge6aCp8Jo4fGcTmDao+j7uorR/8Pv8ixw6gfjX5UITdEOwI4QSeoR5Vv2vWOmxRX
 YIiw==
X-Forwarded-Encrypted: i=1;
 AL+hErGe/L77C1jmHi62VSrSqjGu68NZ4iQr85rVU7DlwZseYqzi01L02K2TaxQvFcbaLWuTgkSGgB7ioG4j@nongnu.org
X-Gm-Message-State: APuU4Z/2YWUGn5u0G6aBJcLRqLjtUtiK5LsNsfdWNwYvRWcrIA+K3Vlb
 ZBJaxAD0dy+XJiCggctE1R+8Ju+GIPAz0i9FTISjXFa+sO+4OzydrCbZ+dr7nP2vX9w=
X-Gm-Gg: AZFdTZeprxMSAP5PhCAiein8VggdYBIba1+8vcLVuiOCCguDBLvrVG3/kND6Ig83WAG
 HLpQsYpDZBPddynBM7lWY/qZmmItJbQxxZvwmYWvtoPIdu5HatiixsCmylQQk+Gd3q0Uh74soTW
 ZCeAFEZnyQW8pZEaTX14ITmN2Mn/6CNfZ25xAFyl3S5cNL4wL61frkh8HrNs7a3vaAx1pHpjSIu
 FClsF/IrKO/zDuFsRwuGbGWpqEexWAhDwHuCFEc3fu1VuDMGGMp9upNYuGgtG3n7mbn4qW2wKK8
 e9NM9FUK5KAKmUvojyhlWVW+qi57N8Bkmfr9B1AWCofDL1dl47n4xtLNUK5YjilECnt3HvrBblJ
 Tg6nkgyV1CyRCP8vr6w0MhPnWMIrBYxAIxSUJgewIKiahXiZOjoRPek9SGTB0XDFCsQ+KTTQmpg
 jnGjIv8aBPLzamdC9/LrDEDp+jcPRSFiryCU5H72bd5xHKvzG7WQD0F/4W+/48ectegITrQHUSw
 G5f33QLWJK92m/8kXL2ZzCuKQAA3bRAiN0RkWJPwShPOAtGrCXdCMqgSLboGxokqySFdFIav+c1
 YNaHVMn0q1ep+SariEu7ktGJQ2pPB0fumUqfotIBEcnwoie/XQMxYQcJgLqfgeg3KeZmG78=
X-Received: by 2002:a17:90b:4410:b0:3b1:12ba:867e with SMTP id
 98e67ed59e1d1-3b3d07a26dcmr15018a91.13.1794934558955; 
 Tue, 17 Nov 2026 08:55:58 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac606d8csm5129805a91.16.2026.11.17.08.55.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 08:55:57 -0800 (PST)
Message-ID: <ceb4c639-f85f-4d8e-a303-6b2eb689a3c3@linaro.org>
Date: Tue, 17 Nov 2026 08:55:55 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/22] Misc TCG & HW patches for 2026-11-17
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20261117092208.50442-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261117092208.50442-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 01:22, Philippe Mathieu-Daudé wrote:
> v2: Fixed mangled UTF8 in R-b tag (Marc-Andr=C3=A9 Lureau)
> 
> The following changes since commit 97c88c61d45dee6e1f9bc160a338048189846d28:
> 
>    Merge tag 'docs-security-devices-pull-request' ofhttps://gitlab.com/berrange/qemu into staging (2026-11-16 15:48:48 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20261117
> 
> for you to fetch changes up to f445ebd9d7fc1ea229821646d8d84c41b856da40:
> 
>    hw/virtio/virtio-iommu: Fix IOVA address lookup (2026-11-17 10:02:52 +0100)
> 
> Ignoring usual spurious checkpatch errors.
> 
> ----------------------------------------------------------------
> Misc fixes for 11.2
> 
> - Build system (obsolete Kconfig, QGA, illumos, macOS pvg)
> - Fix wrong constant encoding in the vector .vi immediate emitters on RISC-V TCG
> - USB device fixes (CCID card, U2F, MTP)
> - m25p80, virtio-iommu, Xen

Applied, thanks.

r~

