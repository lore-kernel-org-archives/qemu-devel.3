Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193BBFD45F8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 22:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvN5J-0002tr-Ok; Wed, 25 Feb 2026 17:10:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvN5G-0002q5-LK
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 17:10:18 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvN5E-0001IN-NW
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 17:10:18 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35691a231a7so26384a91.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 14:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772057415; x=1772662215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XtnC8ATacW2fyak6XWmaGr/e/LRzb0eYw275uy3HU+c=;
 b=ueNkN9NRmj7z2t3ZuiuLq3j28Yap1g4ZSIYFvS+w3MXtawCm3b6dk9hX91vrlpci4z
 Up3KTCrRVk8CFJiYVxTHkc86XiS9E/rxmvjVSCg/cgFrynPAgGvu2EnExaTG93yIL/gp
 fx3jtL3eMiwclSk9KK3sbE1sAVXRk+JSTwfbhiTeqlKYT+JTf9eWkAZPuWvD8tFLRKuE
 vxacvkPQedrbaMPgfl292sOuR+cyMbXPLh3DOks6ChpnqZ1WFJhg25h+dARgbqWl/Y0L
 MrN0YXUg8Yvj6yG/M0qK/WdkL8sDknetttDk9m7jInRYhP7ezmWoQEv7tqVln0DrhTMj
 VmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772057415; x=1772662215;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XtnC8ATacW2fyak6XWmaGr/e/LRzb0eYw275uy3HU+c=;
 b=Aujz6b9xZUeFluu6Ipg5UC6VZTx5XKT2CXOJXCfromW7vltjv5ycIDVOBI/Fv+4fcG
 BoRRZQkFrI7TXZ8/D+cYVQiufE071DR1PycJ0YTO3nJQ79gQX/3nbCFXKdq+/DSaRwK0
 p+iSs+2wxO4zxz4TGL/Hz7wJN2akJoGxg7dd/a/nsmSsEnSGdo4tRkjcFh51n+F2GqVA
 ZlVUdkFI1AJzjsuFF/dRFS1uh0+MgL2IclABygE60d01W27UHsv/0F/qboBnakKdrSl1
 WOtu7nAabbFYvGN8opkBcHMeHUmpFjR8It+5JMm98lvGp/pX7hpUoK/IKcj/3sZD6+F3
 zRFA==
X-Gm-Message-State: AOJu0YwN4352AogEOwnsl+yNgvamXqGTJwluQuHxaH50SRVD8UJ6rv3+
 eUO9gjR/CuMIR7DArGpNXFQFrUaXvMmw/2QSwTp/sMyGScS8D1CWGckvH2CirjigdZs=
X-Gm-Gg: ATEYQzzxwscdtI91mNCRkrMNgyxlJJs6WvV96F91mnPHlCFtquEkqt9pYXrnxBvg5PY
 FfBogopbcFMclAe1FP78yyIb4SMOEf6Ndffw5bQ/V1jlkWBFKOt3OGhZ49GxQ3JO54QlJYZoNv1
 +FM6+6Ht3oqe2vdCgC3xOqyc0ItY1AYB7QdiboVqvPmCssQaACcOQpy6QSz64s/ud/BqDdTIcl6
 y/LYtLbF8wZQLyYqGZKLZ+LZQqduedplKY21oXDZE43VvnB0//hHGXXQ6jvYMpF9SET43rjlh0r
 qoU4Yqg4mFETMrYn2ofTOV9M1oj8nPWW5MUBHvB05XWHkEzqP/I37rDC6CyBbcZny0Z+6s4d/la
 STZyPvTmDaJUG0wFAzFLert5Ukmthk3/p/LnMep32ymiWegYVO7Y8FwzC0tMtfGSqyKm+GMUkzh
 R2/WyDrHqrDPLud4To8Qcm6AdHnVDEa5/p7ZAFa+f5USq8jo9OWK/4v+eYvm7Gitf0o/ih
X-Received: by 2002:a17:90b:4c51:b0:354:e86a:3066 with SMTP id
 98e67ed59e1d1-3593d8e0623mr195437a91.0.1772057414832; 
 Wed, 25 Feb 2026 14:10:14 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35912e1137csm1177094a91.0.2026.02.25.14.10.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 14:10:14 -0800 (PST)
Message-ID: <b4f9ac23-d9cb-41f9-a28a-7559bb367dba@linaro.org>
Date: Wed, 25 Feb 2026 14:10:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 28/31] hw/arm/smmuv3: Select sec-sid from PCI property
 and validate SECURE_IMPL
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101907.2997408-1-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260221101907.2997408-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/21/26 2:19 AM, Tao Tang wrote:
> Parse each PCI device's sec-sid property during SMMU device initialization
> and cache it in SMMUDevice::sec_sid. Support "non-secure" and "secure",
> default to non-secure when unspecified, and reject invalid values with an
> explicit error. Use sdev->sec_sid in smmuv3_translate() to select the
> register bank instead of hardcoding the non-secure context.
> 
> Keep sec-sid parsing in smmu-common, and add a SMMUv3-specific validation
> hook to enforce architectural constraints: fail fast when sec-sid=secure
> while SMMU_S_IDR1.SECURE_IMPL is 0 or secure AS is not available.
> 
> Typically, SEC_SID is a system-defined attribute (e.g. sideband or tied-off)
> rather than something a PCIe endpoint can freely toggle in pre-RME scenario.
> So this PCI sec-sid property is used as a static platform/testing knob to
> drive the SMMU bank selection.
> 
> For future RME-DA + TDISP, this will need to become dynamic: the effective
> state for PCIe requests is derived from PCIe IDE/TDISP T/XT
> (e.g. SEC_SID = (XT || T) ? Realm : Non-secure), so we'll switch from a
> static property to a runtime per-device state update when that plumbing
> is added.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   hw/arm/smmu-common.c         | 37 ++++++++++++++++++++++++++++++++++++
>   hw/arm/smmuv3.c              | 34 ++++++++++++++++++++++++++++++++-
>   include/hw/arm/smmu-common.h |  2 ++
>   3 files changed, 72 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

