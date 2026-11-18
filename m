Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0879606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Js72x2gx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTiiV-00026v-W4; Wed, 18 Nov 2026 11:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xTii0-00024F-L9
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 11:40:34 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xTihy-00086Z-R1
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 11:40:32 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1083676f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 08:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795020027; x=1795624827; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Qj9O5BafqD5AqBLi6VM7UVywZd5JUQes68/kr9jEnRs=;
 b=Js72x2gxu1BJ+vc9+wuvfE353Pwcl8ZK1Yo+v9SJPLWAlS93p2mA0Wfucn7LBdzMNm
 7L5YjnbakkFJ9p7sOqjaxhp0EAH3BveVHuZwXQByKGioYXCaL+bfvmHVKdDeCQ60MGec
 NaQGFDj50+51DlgymidnQxLN8ggfih5i8VpXm90RANwQBnr/xmZLzsjDmc0ZyzIeaT6q
 /3r73yr4sshlfxjORJ66gSoAYOToOA+S0RtpX3Nk/kLOmYPsGzw8ugrnUHv+hg1kJUmq
 Ibgvct0oWnn93uGVG89P6tfoAtAIH38Wqnst93WK9trYMODhoAjgOZt+Uc/EPr9fQTt1
 Tlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795020027; x=1795624827;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Qj9O5BafqD5AqBLi6VM7UVywZd5JUQes68/kr9jEnRs=;
 b=D7cTikXYBW13CDEfTQmiXazZianNw+AQkmIXWSXG9pPw2CspeMnGtMBPcAFUeqzY1D
 K0GciYIQ9gzzilDXlS2w+uvBRcEY1o3XpudRS1gAsZWWi/uldIMtoV6hBX1sLnP0sE8n
 ++AIBS3zkfFdmp90MVOebc1ve2biEyVWfhFc8VCcbPaUjoDuPFROtnQ/8dkw9yu4bunX
 I2tGMzHmsCiQHcghGeqdQu34hOG+JeXT0idYUxF/WYcbUQOSNrIMrCnRCr8iS5z6xMl+
 Z2J0nZPKYdZgwng3UYJZFUlXQllpfOMnJ9Ry5cRuPvc+QAZQTzbgXPsLnDTd1xyL6DcF
 jdZA==
X-Forwarded-Encrypted: i=1;
 AL+hErF7+D27clZslXNE8XLKJDtcDHvKA4gqTJwKR3o0h8FCLL76OZOsFUoDxEU5ii0Vzc0E2LXHlS8EKdUJ@nongnu.org
X-Gm-Message-State: APuU4Z87ljlgmdUK1iUVEkYGdvOivIo4TCttFneu0nd2vyatTkk/WI5c
 Wvtpqc+pZrUi5JgDACn7jQoRMWkjFcAOJRxc+dj7hT2Sa2Wu7n3zTdG4nV9J2FSk/zg=
X-Gm-Gg: AZFdTZdfmBV2dQrDa6wPdCTui3Kak1vELfpKXM5F2Q2X6HD9TXwQqLj8LFO7+YY1556
 EBEAUwYzx5JI7cNyesHhmDPyJ/78GjpJt4ph1DZREYqbz0bOQxrp/GjbVbye/qO6W9uLnbQgXP6
 d3miPWCsQzmRUeaQ3y8W8WjH9JtnAXdpLUdXH0dD24lT/GC+6N52NGJHzzzMiIA68RP9gXTqKQ1
 ZdmIbq+FketMH4kI3FUQ0WP6poUo8c7MA56RWYaMPODNo3y4OJ4vt7m76HSE81mGJDhVMRh7Emu
 nLdpSiz6ZZcSyAgHRA8lgvZ4WCk3S71UsG7EKnR7v4b6KxCLjl0H5wrOMog7yfsbkS+V5arfnXx
 /29t5W2/fzeyCN2d2GzhZ0O5SdTU4Ap6N02x5BNzn/quoqWvRZk1OWCaQmdexd5keMVuPWqmNf+
 W6E7wm379GTN7P053QXuxfK122U251vfQU8aT2d4xloguTrgEEQHoc+W2Zqb7MpqHUjAT3ryOHO
 E3EYUs9oWbbNDySRXF2WQ1s2/Wngn9j67To6DUfjYRz+YFATT6UPAdznId4Sw3Tb1i8M+5QaCQP
 QGvY5gI09CsIdsScXx/nXhAADQKM
X-Received: by 2002:a05:6000:46cf:b0:48c:414f:cc12 with SMTP id
 ffacd0b85a97d-4a63a7a1409mr5073668f8f.40.1795020027244; 
 Wed, 18 Nov 2026 08:40:27 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a655608733sm5249835f8f.22.2026.11.18.08.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 08:40:26 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 20B9B5F857;
 Wed, 18 Nov 2026 16:40:25 +0000 (GMT)
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
 "zwu.kernel@gmail.com" <zwu.kernel@gmail.com>, Peter Xu <peterx@redhat.com>
Subject: KVM/QEMU community call 24/11/2026 @ 14:00 UTC
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Wed, 18 Nov 2026 16:40:25 +0000
Message-ID: <87tsle5c06.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hi,

The KVM/QEMU community call is at:

https://meet.jit.si/kvmcallmeeting
@
24/11/2026 14:00 UTC

We have one agenda item already and I suspect it will take the whole
session. As a follow-up from the maintainers summit and Paolo's series:

  Message-ID: <20261118104150.599535-1-pbonzini@redhat.com>
  Date: Wed, 18 Nov 2026 11:41:46 +0100
  Subject: [PATCH v5 0/4] docs/devel, AGENTS.md: a completely new policy on=
 AI-generated contributions
  From: Paolo Bonzini <pbonzini@redhat.com>

to discuss the potential policy change on AI submissions and how far it
should go.

If there are any other urgent topics please let me know.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

