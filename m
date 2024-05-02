Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5744C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 10:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2U71-0001uE-VA; Thu, 02 May 2024 06:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1s2U70-0001tJ-Lb
 for qemu-devel@nongnu.org; Thu, 02 May 2024 06:56:26 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1s2U6y-0002u8-T7
 for qemu-devel@nongnu.org; Thu, 02 May 2024 06:56:26 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a595199cb9bso187587766b.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 03:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714647383; x=1715252183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=yX6wT40cSYDRvlgdlMkFliIJ29iNHyEUKwWqPKnFBD0=;
 b=vYc1Rde66DDHtP50/gdsR9VX/0HHBpeAtMRryMKRDTtwybV9FlGCd2Swr9Lc4Si2i8
 Q1wK54cxi7auoCLU/1a/Umh/4pOqblWSUe6FxSu5NlDg/zi2soWvv37nBQ+lLDOsDiz7
 zSoMZRcYwdvZMe1sTWsBgEC7XE7hJ3NDhwvHsCSKBfBpJRG2Cvj94GgyCfkaBJ8gxQHz
 qvb7AYNnKX5KNwgkNRD31a7/PCx8NMm56N31JDdlAyn5clpSy+J8yey2avJLpnbMKPOT
 1z6TmHgYSnWEkgJ560nzEV82UXvootl1ceECeIbH3cnXU1JMFiHzeADzZJrY1jx24IgH
 6x2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714647383; x=1715252183;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yX6wT40cSYDRvlgdlMkFliIJ29iNHyEUKwWqPKnFBD0=;
 b=KfFKMnMeZnojK2wFr8okf1pUksxyP/iPyMKTKb41C0jlKWNp0wK5NYxw6vWSChzpNe
 wnEjtIkuUcV5zflo4Y8Ngmix3X2Uk6NcP1el5vGk8OKC3fbsDxu+ukdjO0KbaxSlY1iZ
 YP9XeTtKZ1UVFfOgT4VW1wKUmQ2ls8CzcWbVRGV7tKOre45ovXCHsm9vZWM9WP24whQ0
 gGFgn6bt1oXaT+d7GLOGKUZi/J1nWZvoGZIRbiTruudsi+Q1n0ag60dpcwHGoPluF9Lg
 znJV6EEj7y/8Qu+4wbw5fPUMwZaupwudpgszOxalBlLHTfrIx/brWCzPSFfg5hl12fEu
 Rqyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/ni662kGzq4GyYnCaSruhJ5gFILtYXkiUwb7PJJaZlNR0lvnjzLXWDlF6yG4m4I0L2QII3M/9VCXSk7yL20tnTZIQru8=
X-Gm-Message-State: AOJu0Yw4h5GCRl4feI0rjN82Rc1yJjlSoiFz0b2BfqDHvYEs6d91943R
 AmrU2a6LHSCDq514HeJxUglJYCnBJt0a7XArPv3rw9BwqBuoezf30hMtZ72WuOmfb/F0BSJ0MVk
 5Kd/W4Q==
X-Google-Smtp-Source: AGHT+IHlfatYJyFlMrblbYbwMFkR5GGNc+mzTGp+hCpkiDl0AKfhQBbNOhMKoMp9HxlZAzjQsFECyQ==
X-Received: by 2002:a17:906:6d1:b0:a51:9911:eba8 with SMTP id
 v17-20020a17090606d100b00a519911eba8mr3503331ejb.4.1714647382797; 
 Thu, 02 May 2024 03:56:22 -0700 (PDT)
Received: from [192.168.200.106] (83.11.37.15.ipv4.supernova.orange.pl.
 [83.11.37.15]) by smtp.gmail.com with ESMTPSA id
 i23-20020a17090671d700b00a52222f2b21sm421900ejk.66.2024.05.02.03.56.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 03:56:22 -0700 (PDT)
Message-ID: <5da6dcc6-2c00-483f-bf33-cbeb3d931f2e@linaro.org>
Date: Thu, 2 May 2024 12:56:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org,
 Leif Lindholm <quic_llindhol@quicinc.com>
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <f397f267-06d9-46c1-8acc-1c9ebf9c3773@linaro.org>
 <CAFEAcA8i_wU+RSRk+D1L8YKy72zHz4YFV20r2Z7m+3ARfzb51w@mail.gmail.com>
 <CAFEAcA_kHDGWVic=xRm4xOsi-cQC-fF5Z2FWRCrwe_E35KBmNw@mail.gmail.com>
 <753b3a55-9589-4dcb-b656-8b3025e847df@linaro.org>
 <cb2d4f21-8853-47af-a78f-e0db65460f46@linaro.org>
 <CAFEAcA_aN8ntxKuGPJ=M_Y3dLNjYEV-v--wK1hK8PyOxKSt=zA@mail.gmail.com>
 <CAFEAcA8+C1JcvF1WBN3ZkqbROZVTM9+UDnA5OaTNoOcKuBa4OQ@mail.gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Organization: Linaro
In-Reply-To: <CAFEAcA8+C1JcvF1WBN3ZkqbROZVTM9+UDnA5OaTNoOcKuBa4OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x632.google.com
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

W dniu 2.05.2024 o 12:37, Peter Maydell pisze:
>>   * what are the constraints on the Aff* fields (eg that kernel
>>     commit suggests Aff0 shouldn't be > 15)?

> This one is apparently related to GICv3 -- if the GIC doesn't
> implement RangeSelector support in ICC_SGI0R_EL1 and other
> places (advertised via GICD_TYPER.RSS and ICC_CTLR_EL1.SS) then
> there's no way to send an SGI to a CPU whose Aff0 is outside
> [0..15], and so you shouldn't build a system with Aff0 > 15.
> QEMU's GICv3 doesn't implement the RSS functionality (though it
> wouldn't be hard to add if we really cared), so we should also
> keep Aff0 in [0..15].

Arm/virt uses 8 cores/cluster on GICv2 and 16 cores/cluster on GICv3 as 
this is amount of SGI target-list bits available.

Arm/sbsa-ref goes with 8 cores per cluster by use of 
ARM_DEFAULT_CPUS_PER_CLUSTER.

> We have ARM_DEFAULT_CPUS_PER_CLUSTER = 8, which does keep us
> in that range. I don't think there's really a good reason for
> it to be 8 rather than 16: this might be legacy from GICv2?

GICv2 supported only 8 cores.


