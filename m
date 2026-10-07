Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4912ACA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUWi-000193-2I; Wed, 07 Oct 2026 12:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xEUWd-00018l-7E
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:29:52 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xEUWb-0005hr-EW
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:29:51 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so42532965e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791390588; x=1791995388; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CqDfLs4Fkh2wfYupYC45OoaBjag+xwkCVwFYKG+sTm0=;
 b=CV4MXKnX4LvvDmOtSJdgMG7G44+OyH7RqfpKvWyRaD75usQd/063sjsUcqR0RGPm7a
 f/o4J9vIVgQfYZvs6kf1SoTE+JDL52liZTJfz9ho5R2dqjDEBBHG8nZ72kOQjyLbyF3/
 zL1yqQkkpBGeQaOlXYatnMzKcNpT51iR2v9qfkuNPJjx/0pznWlbqBcI6oh2p4M8FSHl
 zFEvMdSE8d3XNiTnJmOzksyiKG9uADi2YdojqbBL+dflfORVmYu9HT87KA+vUGxfsoDZ
 n27Rt+uL0HKVKs2FVCVn9w2ERIjgu7+L/yr6W0p/hPVqIQ01AFT7apbFY/FONN6Q7gOM
 6HSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791390588; x=1791995388;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CqDfLs4Fkh2wfYupYC45OoaBjag+xwkCVwFYKG+sTm0=;
 b=PR7DOKvv/6McTjg4c8csR88mD0Dr2RM/Od8J7G9ikcSN78p2+YZn1sZYG7U+eTrNdV
 DmKXvY/VVl6fvrxt25o9rDHArZrEy37PjQNI2tVSkIowmyZUnzbB3+RbGBWM9kdzClCH
 Rh/OsX6aoWxahKPBfSMIXJchTTJVm/EbeqS7sH8N17NWTn+AAhHdR7cwq1NAihbDiN2G
 j1Z+MHjkSuT/wgvjMvQsyS3T6kQyxuGEglNzmOSySMD/gqFJ9BCthsnBx9STgmhBidme
 b0UUQlxZzwW76izhndPgczNq5KUrbwy/wItHPVA78U/o8MBXcRd6ZNr0yDjIFkIaRObc
 8OSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw24lLyRP9XDyy0/9BgI9Ezc62StIxE5Ksh+bI7VRJxh3M2hvFBmEu80Uee3KxoVaoMGC2EWrsdoyhi@nongnu.org
X-Gm-Message-State: AFuF++nXzZCzZO/MhaMYTfk6ph+HnvpzTHQYvpoxRMNKo0OzlF2O19Ph
 u8ovFjJpXtWwfFWXgmZFyG42nPbNjmC+XcrwTEEZlVo0DQYZgSEc5PoYpH9rir9QId4=
X-Gm-Gg: AYBFou3rsuyVE0TZs5/CGE2pTWfBLQP7PpEgOq4EQ7lQeTwEUznAN8SOBS+NiQfdm9Y
 /yPFjOkPS5uigPks6BauHkt57dymemDA/f7n2bR/0iqI7v12R/fPOE66mlvxRbAFEUY2GsqQkwx
 nWZXOFZZSDjGL98CLXKlyeYuhKrVO07LqMnr+oS4C8R963KslkSZlWHTnYBWAfEn1cJjBRYWDuB
 D+9LAZTp+LcddRSNwnQCgMQabwlWH9zNNEgEf7K0t18w2rGwu5Z9/atwQ/Ex4BP5abu/T7JdWNZ
 N9MsNKivkKQIYYndNV1xuOiIqXeCJF4ebQ29BEzmrILnqKiac0vCA2mOP7CSAffoMjFmSiWsU12
 QvKjd+hK/dYogCQGJozCtxGYWOq8tPkMeo9d9kD3kyATh8d9Oam31E+QQ3SlLPUF9pYbMC4oWEo
 vhdyEhJaIuH1WZN15LQQNZVH4vLi6kV3dvwSutoyB7bU3jx6f99/2wAWjVUOCJkL+VU+DmHg==
X-Received: by 2002:a05:600c:a087:b0:4a0:1fe2:d4c8 with SMTP id
 5b1f17b1804b1-4a1802eabe2mr47058925e9.5.1791390587542; 
 Wed, 07 Oct 2026 09:29:47 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843bbe82sm2592235e9.13.2026.10.07.09.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 09:29:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7774B5F7C5;
 Wed, 07 Oct 2026 17:29:45 +0100 (BST)
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
 zwu.kernel@gmail.com, Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>,
 Ruslan Ruslichenko <ruslichenko.r@gmail.com>, Frederic.Konrad@amd.com,
 Luc.Michel@amd.com, edgar.iglesias@amd.com, francisco.iglesias@amd.com,
 Julianus Larson <julianus.larson@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukas =?utf-8?Q?J=C3=BCnger?=
 <lukas@jngr.org>
Subject: KVM/QEMU Community Call 13/10 agenda items?
User-Agent: mu4e 1.14.4-pre5; emacs 30.1
Date: Wed, 07 Oct 2026 17:29:45 +0100
Message-ID: <87fqyh79ty.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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


Hi,

The KVM/QEMU community call is at:

https://meet.jit.si/kvmcallmeeting
@
13/10/2026 14:00 UTC

I would like to propose a discussion that came out of Core Collective's
QEMU sub-group [1]:

  - Memory port interfaces for co-simulation
  - Dynamic machines / data driven machines
=20=20
This was discussed in relation to recent proposals to upstream some of
the features from the Xilinx downstream fork:

  From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
  Message-ID: <20260915160044.345788-1-ruslichenko.r@gmail.com>
  Date: Tue, 15 Sep 2026 18:00:24 +0200
  Subject: [PATCH v2 00/20] hw/core: Introduce Remote Port Co-simulation Pr=
otocol
  From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>

There is also a wider meta-question of where the best place to
co-ordinate engineering (and potentially funding) for these sort of
features is. Obviously CoreCollective is already a place to do this for
companies in the Arm eco-system but features that support co-simulation
are hopefully of interest to a number of the architectures.

Are there any other agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

[1] https://corecollective.dev/working-groups/virtualization/

