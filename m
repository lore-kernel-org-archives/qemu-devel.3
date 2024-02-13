Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84560C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrsQ-0005wb-LZ; Tue, 13 Feb 2024 07:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZrsO-0005vR-6U
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:27:04 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZrsM-00073P-An
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:27:03 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2907a17fa34so3198470a91.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 04:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707827220; x=1708432020;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CbU2hgNRqQas1DZqBQYeN1tcHMhEa9TA6WKts3aui8Q=;
 b=cKt4dvJ1oJFM1pup/gDNpUxv4ZFTUw55om8DtMXnYpfi0sXtfgZ5M35Yfqh+YyK3BI
 06614WWrb/ppgMBhEz4R9b5T/+OsGS2d29/Hq6i9agSPWNIXzZjMH/U9FgxYw+QbvKkv
 UOIRek8Ih33kXIjMzwiOurhnnc16aw37sqw01IgsmmwwuhcmL1DSbvLcnRQa6jdIU3YF
 rtJfvGqKeuYmASwq1017JmMbV75SyqBECAs2pVF9alsqOzpRjcKY7D6H3Aa3TB3nfRUI
 BhnPqpLGcYES2+GJzpmumYFsVRxc900YjhTpzF3dQJUFKm2s66iCgYiulEfCzxODUTTd
 PDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707827220; x=1708432020;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CbU2hgNRqQas1DZqBQYeN1tcHMhEa9TA6WKts3aui8Q=;
 b=PQG2soAWcjX0E9zXIFxOWk1znw2uuJwqmcvuxPQrnPtphNTk65S8yI8C1OP5c/tAce
 a+y6nOAKFCEm+sIX4gHfhjznUSlhELNg92zOWSJYSTom/zBpcREU6IoMR6/oxF/7J31B
 WukuVk0FOpc1belvLgsOKoalBe1rn5acZtnH55sTlaQVarhPkU+fL71na2+k6LasQEuF
 4ILOd7tkKv5IoZ3AE7csBEukBteqWEITktBXfvWPVJ04VII+my9XBAedIehWIYtXEw2l
 SwHhcf3nOxR5mG+FAzl2S0NUBh7xDySSbvJRNlI4PuMh7IKN87wkvffpMkqSMzQfsJcq
 21Aw==
X-Gm-Message-State: AOJu0Yxz7KpuFTFAhMDiV/lZT5K9UoVgpfsplLDo/f6rVBjWfUZ6Awhf
 rQQO++oXIy3GSQc2R06zTLDsm0O/bnYvMMrA278TWKViWYLgmazNPQDGIwRbt6c=
X-Google-Smtp-Source: AGHT+IHy+1hneSCEEMqtK7mRqxtZrX/jRWJS75QwxTuuTZZr0VYUQ1m8/oyA9GVuVm1Cf+g8yguUrw==
X-Received: by 2002:a17:90a:bc94:b0:298:95b5:6570 with SMTP id
 x20-20020a17090abc9400b0029895b56570mr2949745pjr.12.1707827220367; 
 Tue, 13 Feb 2024 04:27:00 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWHp7GywnPvhXyTsCmux2Ch64Tj9K4p/05r7dZ/g1AH3xx0y3YX2oJIUn16RD3SPnToPdrvqZxnyNmsVtZoQ2WQTS+sLyHCD4m4xcIvd8TnhDqEjm7PsDNdPWKPNaKcWoCxuVU/EL2I6dQSOKfaLA40MrPFYNw7cYuFXLdyRVetsaTQUzCU2Le0hXhFj2ZzYhFHvizWI8R/a/lMDx8cRN2575vgcz4/kQL4GKqGn+TkZd7sEG+sVF4a1GcBwrJqDgxWkkJ+mbMulmnDTRUxJ4YWLMuiwyysSqOHloi5txjjshndo4FCrS4jOE4D1sFLtaXZjJe7JhEy4mGpG417tsQDu/i0LQixt2MklU5CJGrVlPLnQiTyNE3xflP5vLxZc72qyBGDX+NidAMqKeElis2KDsWCg9KAv2+utNkLpkj7uLeGknWo4ZPeiksyNeCGabx5RJL5P3EFErgctHt1GRE=
Received: from [157.82.207.134] ([157.82.207.134])
 by smtp.gmail.com with ESMTPSA id
 md23-20020a17090b23d700b00298c5ee3159sm162213pjb.49.2024.02.13.04.26.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 04:27:00 -0800 (PST)
Message-ID: <d128206e-e8b5-4928-85e6-8062155fbf68@daynix.com>
Date: Tue, 13 Feb 2024 21:26:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] pcie_sriov: Reuse SR-IOV VF device instances
Content-Language: en-US
To: minwoo.im@samsung.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20240212-reuse-v3-6-8017b689ce7f@daynix.com>
 <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
 <CGME20240212102210epcas2p4346c0dfc475ecee9f359d634eba46783@epcms2p8>
 <20240213085108epcms2p86672b5f11b0b4a22244256b85c66721c@epcms2p8>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240213085108epcms2p86672b5f11b0b4a22244256b85c66721c@epcms2p8>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/13 17:51, Minwoo Im wrote:
>> -----Original Message-----
>> From: qemu-block-bounces+minwoo.im.dev=gmail.com@nongnu.org <qemu-block-
>> bounces+minwoo.im.dev=gmail.com@nongnu.org> On Behalf Of Akihiko Odaki
>> Sent: Monday, February 12, 2024 7:21 PM
>> To: Philippe Mathieu-Daudé <philmd@linaro.org>; Michael S. Tsirkin
>> <mst@redhat.com>; Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Alex
>> Williamson <alex.williamson@redhat.com>; Cédric Le Goater <clg@redhat.com>;
>> Paolo Bonzini <pbonzini@redhat.com>; Daniel P. Berrangé <berrange@redhat.com>;
>> Eduardo Habkost <eduardo@habkost.net>; Sriram Yagnaraman
>> <sriram.yagnaraman@est.tech>; Jason Wang <jasowang@redhat.com>; Keith Busch
>> <kbusch@kernel.org>; Klaus Jensen <its@irrelevant.dk>
>> Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; Akihiko Odaki
>> <akihiko.odaki@daynix.com>
>> Subject: [PATCH v3 6/7] pcie_sriov: Reuse SR-IOV VF device instances
>>
>> Disable SR-IOV VF devices by reusing code to power down PCI devices
>> instead of removing them when the guest requests to disable VFs. This
>> allows to realize devices and report VF realization errors at PF
>> realization time.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Hello Akihiko,
> 
> I think this patch fixes the issue reported in [1].  The latest master branch
> also causes an object-related assertion error when we enable VF(s) and disable
> through sysfs over and over again (at least twice).  But this issue is also
> fixed with your patch.
> 
> **
> ERROR:../qom/object.c:753:object_finalize: assertion failed: (obj->parent == NULL)
> Bail out! ERROR:../qom/object.c:753:object_finalize: assertion failed: (obj->parent == NULL)

I'll note that in the next version.

> 
> Klaus,
> 
> If this patchset is applied, I think [1] can be dropped.  What do you think?

[1] should be kept. This patchset fixes use-after-free but double free 
[1] fixes still occurs.

Regards,
Akihiko Odaki

> 
> Thanks,
> 
> [1] https://lore.kernel.org/qemu-devel/20240109022953epcms2p54550dcfc9f831a515206513ae98e7511@epcms2p5/
> 


