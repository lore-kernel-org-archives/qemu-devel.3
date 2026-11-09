Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3D6606A33F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nUXzKmPF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQPk8-00028x-6h; Mon, 09 Nov 2026 08:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xQPk5-00028R-5z
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:49:01 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xQPk3-0006IS-I7
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:49:00 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4922523d1afso482435f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 05:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794232137; x=1794836937; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mBFqf+XWMy401nIzWVFPWpHPmD6ZZ/kspHrXJZFFk20=;
 b=nUXzKmPFwOHBtmKmeEzXQFSQ0Sa/P0hABy0RuO3+qRIZAo547ZJBQqbsj2Nt51zo9X
 C3TZZUyFUl5izUU3bsuzIJN5Jx8Tsr+h24C0bNJmGGcEfVbt/3C5w4yHSbj/iBvoslBm
 B8hq9yqryou9V53+YOmTOE944tS+cF0z24EQRk5Xd7N0KW/hIK6a6jvUo9rPryGAQ7nc
 7quErmvtjTfjqtHlCkntqL6V3Pzd6fDwj1DU3NFcp85WRM/3M5835WC9A7S8dpIrS1WF
 nMDaT1IJvSYqpQdxuYOEnK4oAas4ZBvr4A6N85A6Sd4Hmhlt8H+sBArov0BlrNWUFtIo
 5GZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794232137; x=1794836937;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mBFqf+XWMy401nIzWVFPWpHPmD6ZZ/kspHrXJZFFk20=;
 b=Sb/J6QY77vpOFHhrghGJ/y9cqoRLeF0MvoevDNykp/5OesQNLH5M7kFFe4UqJdC3I8
 kIzLDJPD16RN3UFy11owTLVm1tucS/d0YV85VIy2q32mZ8kCUA0NVSrTqmUgLZOHFXyn
 eFPIeomHpQOKFOvQQ2VL3S5rc3Ptq77wLsOxuhVgZV3+pZyohvIz/SxZFEn2fpPV12Bv
 zTySa0Oc7OZ5DZZrRig2YJh4F6X/uaY6MnYVRO7kM1mrCr20Nhv/8e15r5rzQoTO8NSs
 fXncQ8SW21APal9CjvaV8VLGF4uHkfMbKV99FQaOVnoet9HLAivCwZtZ1fzLAYJ/o5EK
 R4HA==
X-Forwarded-Encrypted: i=1;
 AL+hErEcOqsD4fdnQl1J5p5LjbPmH4U0NRdVtXpCBy3TPcMMNPfyvkfKKp7DLj4673mvGARExAJcpWuvgI0R@nongnu.org
X-Gm-Message-State: APuU4Z9/bCgRIqLeIDQ2FrGnEd6zySPWi4lJTu64nhEbvoDnPkS32jq5
 EU3ukGK24gy6s8vs5jzZecW8AaKAIBEmT9xP+3OG/sXk01p95XEwFsLNwX0BFkhM/jM=
X-Gm-Gg: AYBFou1WFVo/SzHgswyDh8iagRItO7KVsAbQtDtP9Vi7ebocPtmyI8LujnSFeGwZZqo
 urorOiVUMKjoDcM71IRkJov8AEZxPBSX0RMXZ7v0CC/CRtSrhQBjvWfB+RSdxfmgLcALSU8AiHV
 Caz5eJZCpy7Y/bN4eBFHDqTxRjQOVp8OfKPaF15ns3cU+QqPj3oSiLKp/zezUiAF79S/+JTTEcj
 Sh54g+HThMVrDhkbycLCd1lPcGue4gp9K7qSySX02YiIInXrXSsTCMjYF+if4ph+PkU+8hcyO9/
 1522Xt49UcAd/E65MdTKitAEQJZF18smujltqzdbjKDRxuk76TOF5rK/qljKm005cFq8nhXz6x9
 kAgBsUPmMjrl4L3Hu02eMd8V23SAt2JU1j80phSTQ2R/2apPgZN2ofHBkvO+wlzhAwJQfLCeQlv
 guRqpVtZL8GZNIYqSA9P0BjwWkzxF/LcOpxpfKCQKBoD0MbAnhxawzHaMp+b1JUaKm7lVLSIndm
 4ZssEikzi1DasC88/RkekdAD6I3+KRQDhJVbgCYY14o/z1LPcbiC85T41DMyiGUNuXH8z9ZtEFF
 F43gizWJdz11xoteqeuAyFhEMUzp
X-Received: by 2002:a5d:64e6:0:b0:492:b5d9:feb9 with SMTP id
 ffacd0b85a97d-4958363c2c1mr8069446f8f.30.1794232137461; 
 Mon, 09 Nov 2026 05:48:57 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49592f3a7bdsm8200207f8f.1.2026.11.09.05.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 05:48:56 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 459505F7DC;
 Mon, 09 Nov 2026 13:48:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, Chris
 Wedgwood <cw@f00f.org>, dbarboza@qti.qualcomm.com, Demi Marie Obenour
 <demiobenour@gmail.com>, dhedde@kalrayinc.com, Eric Blake
 <eblake@redhat.com>, eblot@rivosinc.com, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Elena
 Ufimtseva <elena.ufimtseva@oracle.com>, Auger Eric
 <eric.auger@redhat.com>, felipe@nutanix.com, helge.deller@googlemail.com,
 Alyssa Ross <hi@alyssa.is>, iggy@theiggy.com, Warner Losh
 <imp@bsdimp.com>, jacob.oursland@gmail.com, Jan Kiszka
 <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>, Joao Martins
 <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>, matthieu@minio.io, Max Chou
 <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>, "Ho,
 Nelson" <nelson.ho@windriver.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, utsingh@redhat.com, Wei Wang <wei.w.wang@intel.com>,
 z.huo@139.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 zwu.kernel@gmail.com
Subject: No community call this week
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Mon, 09 Nov 2026 13:48:55 +0000
Message-ID: <87bj7ycdyw.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

People will be travelling for KVM Forum so I figured it was worth
skipping this week. See some of you in Vancouver ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

