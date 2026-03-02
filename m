Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639C2EA4E04
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 13:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx3m7-0001Pt-Br; Mon, 02 Mar 2026 08:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vx3m0-0001OU-DH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 08:57:24 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vx3ly-0002ui-Ky
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 08:57:24 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-65f89c40547so7882958a12.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 05:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772459841; x=1773064641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IyagXMrQ+DINadwuUr9I3V24JKOKEOPGo8HsFyeNYC8=;
 b=xwCVe4akBHdoJ11vPGnksMDXLp2rSHBKOPvDGomSfmH9QSzZ9JslwUuNYuOMrG88Vp
 N3C9tMigF3skGh3fpis2lqzK1K6gvBCiiSN65je9MIWlC8E/oqs2w4k1wtefCXfQwAnr
 vkgQr0CfYOjY6E0kO6XjJIUMm3RpZur/FD9YpVq/qerGjlzjps6ChPezquE/hbsGrhFb
 zetfozTEhpBRVhgKXdxevWnev00uP9ag6co1GOgRtCrKq3JbkXN7SneNEzrRkHKIQ/f+
 vPmCwMis6haE+SMGDTypMI2aEa5SQqxdenZQq/Hw6L+nzu6jygA2nNbsn3xzWFf5vU4P
 td0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772459841; x=1773064641;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IyagXMrQ+DINadwuUr9I3V24JKOKEOPGo8HsFyeNYC8=;
 b=ntGpFKn0yAw48P2p9v3m30JfcUbJ9U9mkecPaXOgdwC6G0O8Qq52O7Nl+NbV+tS3jd
 HcUdFmy4InckecAf1dCflo2zTWQdk9lloKI4hLMrvUNVIsMEBigsQseU3MA65mSmCG2t
 /GCCmyl8CkOf0HsnEQo/Avon5LHjc6sBVBZ6JTgE6PK9meiKLZQhd3YOTi/psmM/4DHw
 YOMEf58ov00gS31ZHF5G+K8LC2bc7Gq4Xs/WBKz2pZ2wwwGZobXjbLoYOWQ5soUZGkUR
 o/5KkOcqpV8pq7pfZgH2mCFQ0FLXhHTCx82LxLWWPPwB3yyrDFxBgufnUGs4CVF//WVd
 lNvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRBq+UAucA+yxV8VIXOqAlYPCpTyaRyAMZz9Dn20RluYsOtlsgoZtkAEnp2EGsj0vXuabYQTE6SVnh@nongnu.org
X-Gm-Message-State: AOJu0Yx1PRGfPI7Tvnw6cyJ60Xq4fGMIBSM2vouTF1AdmcFfVJDUa9FS
 veTLh0/LS5uLO+IdAtqKsZOhn/XGUWt9/4iLg7A1qPkx0RCxScP6MFd50hjzIVrUnLQ=
X-Gm-Gg: ATEYQzwCIkJ0/aKE8ziQjuTxXzQqXFVBbkISBR30N0gO8r+aCeyYLeB3XtBzZSQpxcG
 qxd3jclc9lzX/qcCN1EEE8+XJS7CVM6zRa73oR3yPKeVAo3QumiubEGJlarIZ9GCCz6wXDAQB7s
 OIAuzOl0mscXWRzvB9UiSbHRsaYi8dDm1GOBEetJPDhNsNPeVMW8B7K1CLD1ypibxAeoEKCtYWK
 EvEW8Or5d0pPtvMlVCqHMLlpN2YwkZ1DNyZNqn1OfT7szJyEMGKFBy7Dq1HZMFDwcKkY6faY/TE
 2Yiqhx0OPnsGf3VqhTzJV26dsMfpNSHwj44geJxzjyCmat8kRC5boX4DyedkyNHVoIW5esK8kf7
 lyYhiQReUfXVBaMuc51rXbhKNoQFMCuvPdOvicftClwJDjf/Vku/hCMoBfu6JwP0KJol9zdHsaf
 /ad1nVu41P1xTu7AhMc01f3XY=
X-Received: by 2002:a17:907:3e1c:b0:b93:8b4c:6b28 with SMTP id
 a640c23a62f3a-b938b4c6cd5mr526517966b.20.1772459840732; 
 Mon, 02 Mar 2026 05:57:20 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ab13558sm480893066b.5.2026.03.02.05.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 05:57:19 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BBC765F7BB;
 Mon, 02 Mar 2026 13:57:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org, Demi Marie
 Obenour <demiobenour@gmail.com>, dhedde@kalrayinc.com, Eric Blake
 <eblake@redhat.com>, eblot@rivosinc.com, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Elena
 Ufimtseva <elena.ufimtseva@oracle.com>, Auger Eric
 <eric.auger@redhat.com>, felipe@nutanix.com, Alyssa Ross <hi@alyssa.is>,
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>, Jan Kiszka
 <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>, Joao Martins
 <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>, Max Chou <max.chou@sifive.com>, Mark Burton
 <mburton@qti.qualcomm.com>, mdean@redhat.com, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU community call 3/3/2026 agenda items?
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Mon, 02 Mar 2026 13:57:18 +0000
Message-ID: <87fr6icp1d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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
03/03/2026 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

