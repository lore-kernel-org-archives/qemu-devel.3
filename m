Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FE3C35FFC
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Mar 2025 17:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tw2PS-0001qS-Ei; Sat, 22 Mar 2025 13:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vitalif@yourcmc.ru>)
 id 1tw2PJ-0001ow-E8
 for qemu-devel@nongnu.org; Sat, 22 Mar 2025 13:13:16 -0400
Received: from yourcmc.ru ([195.209.40.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vitalif@yourcmc.ru>)
 id 1tw2PD-000844-DP
 for qemu-devel@nongnu.org; Sat, 22 Mar 2025 13:13:12 -0400
Received: from yourcmc.ru (localhost [127.0.0.1])
 by yourcmc.ru (Postfix) with ESMTP id BA843FE0665
 for <qemu-devel@nongnu.org>; Sat, 22 Mar 2025 20:13:00 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yourcmc.ru; s=mail;
 t=1742663580; bh=9uDOZjEexlGcL3ynBsI25GQSG1VyTl/mxaHnAsSTkDA=;
 h=Date:From:Subject:To;
 b=q/NxvFoYw4a0nZZODzwth5SoEYdUewr0mzeav8zXgkTyaSEBi+D8P049w1sUAawL5
 0Z4lAeTe658L/pf+3GXm/3QychF435bLvTte1z2IgCAqAciKNCZit6yNAgDdp6Ve4r
 7oRR409I+/t/Ufda98dqL/3GNsnzucq7FOiuWJXebyn+XweWVDZ5H0/owa88oY7C7t
 frq+kUuwkiE8RI2n5eN7Q9LEWCPM2goCPAoH54MiTAeCw25NsAU8ymFjH/VmM1OtkS
 umL88fEAdgMicpgRyKnWIX3Eg6oZ4LH+JX4/4bNwigrZsCXbI+5qIdqnrKYehOaZm6
 thVcOb1jjVOAg==
Received: from rainloop.yourcmc.ru (yourcmc.ru [195.209.40.11])
 by yourcmc.ru (Postfix) with ESMTPSA id 90ACCFE065E
 for <qemu-devel@nongnu.org>; Sat, 22 Mar 2025 20:13:00 +0300 (MSK)
MIME-Version: 1.0
Date: Sat, 22 Mar 2025 17:13:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.14.0
From: vitalif@yourcmc.ru
Message-ID: <bd5c6126f8c345b1eeac617d4023fa58@yourcmc.ru>
Subject: Can I contribute Vitastor block driver? Or maybe introduce a QAPI
 plugin system?
To: qemu-devel@nongnu.org
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=195.209.40.11; envelope-from=vitalif@yourcmc.ru;
 helo=yourcmc.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi!=0A=0AI'm the author of Vitastor SDS (https://vitastor.io/). My projec=
t is an opensource SDS with an architecture similar to Ceph, but simpler =
and faster - in the terms of latency, it's ~10x faster, it easily reaches=
 0.1ms T1Q1 latency with NVMe disks.=0A=0AI have a custom block driver fo=
r qemu (block/vitastor.c), currently I package it manually and provide my=
 own QEMU packages.=0A=0AI wanted to ask if I can submit this driver to y=
ou to package it upstream? It requires libvitastor_client library to buil=
d which is also currently available either in source form or from my repo=
sitories, is it fine?=0A=0AAnd actually, if that's a problem, another opt=
ion for me would be to use a hypothetical QAPI plugin system if QEMU had =
one - because, in fact, the only thing which is forcing me to rebuild QEM=
U is qapi/block-core.json. I have to patch it because, otherwise, the JSO=
N options of my block driver aren't accepted by QEMU. So if there was a w=
ay to dynamically load these qapi definitions it would allow me to make c=
ompatible *.so block driver builds easily, even though there's no "stable=
" API as I understand. I'd just need a separate build for every qemu vers=
ion, but that's not a problem for me :-). Or maybe such thing already exi=
sts and I just miss it?=0A=0AWhat do you think?=0A=0A-- =0AThanks in adva=
nce,=0A  Vitaliy Filippov

