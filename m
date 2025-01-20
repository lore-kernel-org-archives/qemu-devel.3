Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0DBC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 16:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZugy-0004p8-Lz; Mon, 20 Jan 2025 11:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tZugt-0004ob-Do
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 11:31:56 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tZugp-0007ct-NS
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 11:31:54 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ab34a170526so676746566b.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 08:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737390710; x=1737995510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t/+3j/VbAnvty6PPbjZXEv6+6kI/aTPexZ9QKyJKZvo=;
 b=tKP0wIgvbKQdvLomU95cgwsF764QSYSpWC6QW6KVg5s3x5EaQ6t89jTXqHm/5Khw8o
 Qu4auPs2YaWDifGZGIJQ2UTeD+zQ2mWRru2CUrVixYPPk30mkE5Qe/m1x0u/7NFdKKP2
 AmUeqfUL/XvWVqMukjnbxFbyfK0DP803tpvGRxMZdAROLutuApbN0RXTvYWnR8fUIV5R
 rIzrnwRiOJTztGkN4HZb5luM9GpIVQT2s/2iS91WZ43zBkNmH7qZdKhY1M80Rwp6W8Lm
 M/hphdqJyLAwG0MCyvoGa0yQ2GW0dderieH3nsMLF6k4Bb7CLCQm1UJpgr8MtDlwU/Gt
 PzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737390710; x=1737995510;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/+3j/VbAnvty6PPbjZXEv6+6kI/aTPexZ9QKyJKZvo=;
 b=aiCNufYNsZv6N5UZaz/GSk8K1e9TY443k+Ku3QteqF0D1CsfZm7XuhiLwQS3SO8eFb
 JHYk9fB8SQsZw6wcZPqoF+v774LqYL7J50/nE2atw6Q3tlP8L/AyhfmWKD1Ycf86zvdo
 2LbcXnOb8LsNR7qDgEJIGEfYgBk4s/6IeOoj09fOS4Py3eMx1o2XBwoFTEXcylloOvzp
 LOhXmj2SBSLHtJayKB4BvT0sWZa9mjNIGr4P4Ds+oQlNylCIE9twYP7+Rwwo4foPCFnJ
 M8l3hoBBDUZ7UOuB/IdWv+5WkLYZB+N/S0oVkNat9BWwK20rJw4psMffZSzg2j0cPjda
 r/qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0yC3hprjMy+vNGiIhcNEPYVxGwMp41cFkgceezr58leym5Jp/JtXEq7LKTqxMM8PltBQAg6HWE9uq@nongnu.org
X-Gm-Message-State: AOJu0YzihSvMrd64D908w96UJ2E6Pwv4ssnmkqX04XFBLf7U6S/qYqCZ
 dzFUXmwvH0RLGH9NuggJGfATfGakqO+Wb7NYMtV6O5wdpLanrQP+vyL0/mcBo5g=
X-Gm-Gg: ASbGnctbIZktJPCVMsNqKT8qJqBvxARjHpyCEYEaIMyZEwqRTuTkHDqekYRGidtlXrj
 /KeA+vLgMH5vS4VuG08jWnRD2kmzwAnC6+hES5K86rlC0iT0QAgFim1FQwrLo7YE5rQCp35BS23
 QPqelMASZa4UIs1anPsOxeV0A9v7wkKyoDB+ypzMw/C2ppDGCs5lwG50RopiNZ09rwS3CpwN27X
 icPAOZxEz+ldk1YEDOz0ujn/RuQRG19ENjARoVak9XyORuCnh2dRrSbTsuqH750XkGv
X-Google-Smtp-Source: AGHT+IE6zytdzEnk/3kQ0UJ57d8A2WX15BSl8IynJB+eYPSo4wMj2nl3plrk1Mp+LllnmfupGBnYjg==
X-Received: by 2002:a17:907:2d0b:b0:aa5:225f:47d9 with SMTP id
 a640c23a62f3a-ab38b166602mr1474433966b.29.1737390709688; 
 Mon, 20 Jan 2025 08:31:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f2911fsm630517966b.120.2025.01.20.08.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 08:31:49 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3BD535F780;
 Mon, 20 Jan 2025 16:31:48 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger
 Eric <eric.auger@redhat.com>, felipe@nutanix.com, iggy@theiggy.com, Warner
 Losh <imp@bsdimp.com>, Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe
 <jgg@nvidia.com>, jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Max Chou <max.chou@sifive.com>, Mark
 Burton <mburton@qti.qualcomm.com>, mdean@redhat.com,
 mimu@linux.vnet.ibm.com, "Ho, Nelson" <nelson.ho@windriver.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Phil =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU Community Call 21/01/25 agenda items?
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 20 Jan 2025 16:31:48 +0000
Message-ID: <87jzapphu3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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


Hi,

The KVM/QEMU community call is at:

https://meet.jit.si/kvmcallmeeting
@
21/01/2025 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

