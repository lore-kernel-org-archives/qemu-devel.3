Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC82BCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMjn-0004on-61; Wed, 24 Jun 2026 08:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcMjl-0004nX-II
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcMjj-0003yd-IN
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782304185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=U5ZQcPm9/Q0n00nOiMfyPLqMH1UFSoX7/5dQRPIwebo=;
 b=aTH1LRn5ZIToI1q18c7PFINT70oBWsFZ99UCRI49Z5XW2i2r/vXSlpUW4mf9MzqP973LC4
 nZ1qTJRGxLZiGU8DlPJLfmOIKHqRjLhaaLVbeXNWWSx5+wfVYitZgeKz3AmzTJdg7kzT/K
 vesafsPkmbjlddVjvuRs8LlmXTnqCPw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-x8jTbmrcMmuBQOQBQMZVpA-1; Wed,
 24 Jun 2026 08:29:41 -0400
X-MC-Unique: x8jTbmrcMmuBQOQBQMZVpA-1
X-Mimecast-MFC-AGG-ID: x8jTbmrcMmuBQOQBQMZVpA_1782304180
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AEC919540D6; Wed, 24 Jun 2026 12:29:40 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46B6C180057F; Wed, 24 Jun 2026 12:29:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/2] Record maintainer/reviewer Git Lab handles
Date: Wed, 24 Jun 2026 13:29:34 +0100
Message-ID: <20260624122936.2706393-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

When triaging GitLab issues, whether regular bugs or security
disclosures, we need to be able to assign suitable accounts.

We can only assign Git Lab handles for accounts that are members
of the QEMU group, or QEMU repository with the "Reporter" role
or higher.

Currently one needs to run 'get_maintainer.pl -f <file>' to get
the maintainer / reviewer names & emails, and then look in the
GitLab members page to see if there is a match.

This simplifies that by including the GitLab handle alongside
the email addresses:

The GitLab account handle -> real name mapping is stored in
separate files .gitlab-map-auto & .gitlab-map-manual to avoid
redundancy in the MAINTAINERS file. The former file is
auto-generated and catches 99% of the mappings, the latter is
for manual fixups.

With this series applied as is, we get the following stats

$ ./scripts/gitlab-map-check
Missing GitLab handle: Akihiko Odaki
Missing GitLab handle: Albert Esteve
Missing GitLab handle: Alberto Garcia
Missing GitLab handle: Alejandro Jimenez
Missing GitLab handle: Aleksandar Rikalo
Missing GitLab handle: Alessandro Di Federico
Missing GitLab handle: Alexandre Iooss
Missing GitLab handle: Alexandre Ratchov
Missing GitLab handle: Alexey Kardashevskiy
Missing GitLab handle: Amit Shah
Missing GitLab handle: Andrew Jeffery
Missing GitLab handle: Anthony PERARD
Missing GitLab handle: Anton Johansson
Missing GitLab handle: Antony Pavlov
Missing GitLab handle: Ari Sundholm
Missing GitLab handle: Artyom Tarasenko
Missing GitLab handle: Aurelien Jarno
Missing GitLab handle: BALATON Zoltan
Missing GitLab handle: Ben Chaney
Missing GitLab handle: Bernhard Beschow
Missing GitLab handle: Bibo Mao
Missing GitLab handle: Brad Smith
Missing GitLab handle: Canokeys.org
Missing GitLab handle: Chao Liu
Missing GitLab handle: Chinmay Rath
Missing GitLab handle: Christoph Muellner
Missing GitLab handle: Clément Chigot
Missing GitLab handle: Clément Mathieu--Drif
Missing GitLab handle: Collin Walling
Missing GitLab handle: Corey Minyard
Missing GitLab handle: Darren Kenny
Missing GitLab handle: Denis V. Lunev
Missing GitLab handle: Dmitry Fleytman
Missing GitLab handle: Dmitry Osipenko
Missing GitLab handle: Dorjoy Chowdhury
Missing GitLab handle: Doru Blânzeanu
Missing GitLab handle: Edgar E. Iglesias
Missing GitLab handle: Elena Ufimtseva
Missing GitLab handle: Eric Auger
Missing GitLab handle: Eric Farman
Missing GitLab handle: Eugenio Pérez
Missing GitLab handle: Farhan Ali
Missing GitLab handle: Felipe Balbi
Missing GitLab handle: Francisco Iglesias
Missing GitLab handle: Frederic Konrad
Missing GitLab handle: Gaurav Sharma
Missing GitLab handle: Gautam Gala
Missing GitLab handle: Gautam Menghani
Missing GitLab handle: Giuseppe Lettieri
Missing GitLab handle: Glenn Miles
Missing GitLab handle: Gonglei
Missing GitLab handle: Haixu Cui
Missing GitLab handle: Halil Pasic
Missing GitLab handle: Hao Wu
Missing GitLab handle: Hari Bathini
Missing GitLab handle: Hendrik Brueckner
Missing GitLab handle: Hervé Poussineau
Missing GitLab handle: Hongren (Zenithal) Zheng
Missing GitLab handle: Huacai Chen
Missing GitLab handle: Hyman Huang
Missing GitLab handle: Ilya Dryomov
Missing GitLab handle: Ilya Leoshkevich
Missing GitLab handle: Ilya Maximets
Missing GitLab handle: Jagannathan Raman
Missing GitLab handle: Jamin Lin
Missing GitLab handle: Jan Kiszka
Missing GitLab handle: Jared Rossi
Missing GitLab handle: Jason Herne
Missing GitLab handle: Jean-Christophe Dubois
Missing GitLab handle: Jesper Devantier
Missing GitLab handle: Jeuk Kim
Missing GitLab handle: Jiaxun Yang
Missing GitLab handle: Jiri Pirko
Missing GitLab handle: Jiri Slaby
Missing GitLab handle: Joe Komlodi
Missing GitLab handle: Joel Stanley
Missing GitLab handle: John Levon
Missing GitLab handle: Jonathan Cameron
Missing GitLab handle: Kane Chen
Missing GitLab handle: Kashyap Chamarthy
Missing GitLab handle: Keith Busch
Missing GitLab handle: Kohei Tokunaga
Missing GitLab handle: Kuan-Wei Chiu
Missing GitLab handle: Kyle Evans
Missing GitLab handle: Leif Lindholm
Missing GitLab handle: Liu Zhiwei
Missing GitLab handle: LIU Zhiwei
Missing GitLab handle: Li-Wen Hsu
Missing GitLab handle: Li Zhijian
Missing GitLab handle: Luc Michel
Missing GitLab handle: Lukas Straub
Missing GitLab handle: Maciej S. Szmigiero
Missing GitLab handle: Mads Ynddal
Missing GitLab handle: Magnus Kulke
Missing GitLab handle: Maksim Davydov
Missing GitLab handle: Marcelo Tosatti
Missing GitLab handle: Mark Kanda
Missing GitLab handle: Markus Armbruster
Missing GitLab handle: Mathieu Poirier
Missing GitLab handle: Matthew Rosato
Missing GitLab handle: Mauro Carvalho Chehab
Missing GitLab handle: Max Filippov
Missing GitLab handle: Michael Rolnik
Missing GitLab handle: Milan Zamazal
Missing GitLab handle: Nabih Estefan
Missing GitLab handle: Niek Linnenbank
Missing GitLab handle: Ninad Palsule
Missing GitLab handle: Palmer Dabbelt
Missing GitLab handle: Patrick Leis
Missing GitLab handle: Paul Durrant
Missing GitLab handle: Pavel Pisa
Missing GitLab handle: Pedro Barbuda
Missing GitLab handle: Peter Lieven
Missing GitLab handle: Peter Xu
Missing GitLab handle: Phil Dennis-Jordan
Missing GitLab handle: Philipp Tomsich
Missing GitLab handle: Ran Wang
Missing GitLab handle: Raphael Norwitz
Missing GitLab handle: Reinoud Zandijk
Missing GitLab handle: Richard W.M. Jones
Missing GitLab handle: Roman Bolshakov
Missing GitLab handle: Sai Pavan Boddu
Missing GitLab handle: Sairaj Kodilkar
Missing GitLab handle: Samuel Tardieu
Missing GitLab handle: Samuel Thibault
Missing GitLab handle: Sergio Lopez
Missing GitLab handle: Song Gao
Missing GitLab handle: Sourabh
Missing GitLab handle: Sourabh Jain
Missing GitLab handle: Sriram Yagnaraman
Missing GitLab handle: Stafford Horne
Missing GitLab handle: Stefano Stabellini
Missing GitLab handle: Steven Lee
Missing GitLab handle: Strahinja Jankovic
Missing GitLab handle: Subbaraya Sundeep
Missing GitLab handle: Sunil V L
Missing GitLab handle: Sven Schnelle
Missing GitLab handle: Tao Tang
Missing GitLab handle: Thanos Makatos
Missing GitLab handle: Titus Rwantare
Missing GitLab handle: Tomita Moeko
Missing GitLab handle: Tony Krowiak
Missing GitLab handle: Troy Lee
Missing GitLab handle: Tyrone Ting
Missing GitLab handle: Vikram Garhwal
Missing GitLab handle: Viktor Prutyanov
Missing GitLab handle: Vincenzo Maffione
Missing GitLab handle: Viresh Kumar
Missing GitLab handle: WANG Xuerui
Missing GitLab handle: Wei Liu
Missing GitLab handle: Weiwei Li
Missing GitLab handle: Xie Yongji
Missing GitLab handle: Yi Liu
Missing GitLab handle: Yonggang Luo
Missing GitLab handle: Yoshinori Sato
Missing GitLab handle: Yuri Benditovich
Missing GitLab handle: Zhang Chen
Missing GitLab handle: Zhao Liu
Missing GitLab handle: zhenwei pi
Missing GitLab handle: Zhenzhong Duan
Missing GitLab handle: Zhuoying Cai
GitLab handles missing: 161 / present: 57

Plenty of those will have GitLab accounts, but are simply not members
of QEMU. Plenty more probably aren't registered with GitLab at all.

Short of emailing all of those people directly, I don't see a good
way to identify their GitLab accounts (if any), in order to invite
them to the QEMU project. I don't want to blindly invite accounts
which merely have the same name on GitLab as there's too much risk
of getting a mis-match.

Changed in v2:

 - Don't store data in MAINTAINERS file, use a separate mapping
 - Don't require a --gitlab flag to get_maintainer.pl, always
   show the handle
 - Add scripts for updating & analysing the mappings

Daniel P. Berrangé (2):
  gitlab: introduce files mapping GitLab accounts to real names
  get_maintainer: add ability to report Git Lab handle

 .gitlab-map-auto          | 83 +++++++++++++++++++++++++++++++++++++++
 .gitlab-map-manual        | 18 +++++++++
 scripts/get_maintainer.pl | 42 ++++++++++++++++++--
 scripts/gitlab-map-check  | 23 +++++++++++
 scripts/gitlab-map-update | 44 +++++++++++++++++++++
 5 files changed, 206 insertions(+), 4 deletions(-)
 create mode 100644 .gitlab-map-auto
 create mode 100644 .gitlab-map-manual
 create mode 100755 scripts/gitlab-map-check
 create mode 100755 scripts/gitlab-map-update

-- 
2.54.0


