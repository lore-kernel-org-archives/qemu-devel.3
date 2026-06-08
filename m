Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7962DCD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWVkO-0000WE-Lv; Mon, 08 Jun 2026 04:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wWVkN-0000Vs-09
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 04:54:15 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wWVkL-0000a9-CK
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 04:54:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490ac10e337so36909095e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 01:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780908851; x=1781513651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o4uun0tI5Mju2x9TfTBRiK/YOP5Jf2gLUQv2HzM9idM=;
 b=nOvMEslvFArIZr37hKtWqKCtv5FXTzo5mN3iemplAOq4HNQ6PrOyvgaSqZMRt1eut1
 fisUShH4rqwnuIVB++xOg+Cbor4WQjqDUyxDGRBS9gUMSTeC1Zafhcf8cyichYkVVUCs
 Luo9KAtEVO0KagFb0nb5HnmiwaUEyVKH9lHn+ItVMvzyNauoGmJnHTe2mTVk9tZlyQ6V
 OJcoDNA5049g/NROrA1/WA+zpgzEc/ekq7uOiu9cNZBb0d46eP874zn0ny3DPVxBWOHO
 9DB7Vagm0PIU+XHJw7bfnZSD0SJshWfc+6aOeh911wMTE4sY+hbd58oRRb26GfDhjQbl
 Tjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780908851; x=1781513651;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4uun0tI5Mju2x9TfTBRiK/YOP5Jf2gLUQv2HzM9idM=;
 b=Ey/sbWZhcsc9AoX7nn8EiuOwLDWQ1Ed69Uj47izbTLIOxSjj80gntEzIGVcJYcs1XS
 8VjolvJCStyPUZfST+qJjBcxXPDVsiTxoCUnCReDytNP5/1BOR92tpLmNUOnegaCYP6H
 zrJVyTP9THuv2frhCsdLpGvnZQeIxh1pNZW1zDm1HGEhwIZlh+w9hT0mOoiFNoG+9Pz2
 pUKugh8//48sVhjNkmN6Gw6tnxOSUq0JzP/eSiWOV+sgLNo35CIxCOeMnEO5YLh6tGiY
 8so/oZkzOojoJoGb90tdfgNBfXHzAeVr1pwOavKUucCRgiqlkCqFiOLlF8bM3bXKTZNf
 fTuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ86mFclTSxVGK9JEExjGbPnDoJNHIjERvEDO2UlbYA12kGGCa7ThurDtwqfui3xOzc7q+9KgNsaJW79@nongnu.org
X-Gm-Message-State: AOJu0Yy84imlyx+OXBoYn5ZmxNw81AIopUF5LclnWn+MNXrTZjZ82rAA
 EN6aPKkLuLaeqAWzOuvT/048gu/9G6+8UOhjBdnVZi1kz/hC4SdD0sPRmFC3l2pLAsg=
X-Gm-Gg: Acq92OFrqOJv2qMiyf/kDTJ7vgUNQi0KR/3DognDMuzQK9u9oCs+/1dh1cJbITd7i6+
 DFBgoTa2RGFEQwOvfiQCOYiCDaqX5tu9J92F4JMkTTApas63rBWB9hk+pohkRXykXhrww1pmrsL
 pYPdU7iljbslEdOsUdcpMPE2BN3qZphQT/cG331adyfizejeoZvJHykQ/r/CmoL/Oc29Ma4fOfK
 6Uam6qoVrJxJw4+CsapSPUWuQfmaSbG/VWHtj9gdzsu+d+DNHSHtbrQx0qkQpwJDirPVacuDu+u
 yApttrcv9rvBbHsXqN8tzDq47sK2IXsl6sNm/4+Q5251bl0Eb5qkzmF5TV91lbZrj/yirtOlDXM
 j2Im2TQyhqHrUnDpssSrLTmoJ+eLBjs+Z0Pnm6/l1kISQvOrW1hwraj92/AdGYxtlZTHFt+W5pU
 A3lpTe7BlfIjT7y8FaGAr8VfuvMz+9bEiGrw==
X-Received: by 2002:a05:600c:5488:b0:490:9d1b:f07f with SMTP id
 5b1f17b1804b1-490c25b1277mr280581095e9.12.1780908851451; 
 Mon, 08 Jun 2026 01:54:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3e59f5sm400500105e9.14.2026.06.08.01.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 01:54:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 803BD5F9CE;
 Mon, 08 Jun 2026 09:54:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 cw@f00f.org, Demi
 Marie Obenour <demiobenour@gmail.com>, dhedde@kalrayinc.com, Eric Blake
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
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU community call 9/6/2026 agenda items?
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Mon, 08 Jun 2026 09:54:09 +0100
Message-ID: <87a4t52z0u.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi,

The KVM/QEMU community call is at:

https://meet.jit.si/kvmcallmeeting
@
09/06/2026 14:00 UTC

Are there any agenda items for the sync-up?

Potential topics:

  - worth syncing on the AI relaxation RFC?
  - following up on the security process discussion?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

