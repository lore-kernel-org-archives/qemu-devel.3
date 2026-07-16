Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369B8C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 10:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkJ5n-0001kx-Hl; Thu, 16 Jul 2026 06:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkJ5i-0001kV-Se
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 06:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkJ5g-00047f-91
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 06:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784196794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jb9JybTwmMn50n8A61sJVkC46Mf14LxaFDeQ6cC5Es0=;
 b=gzrq5lLs4+ji3DDcmwVvu/3/RLOguKgwNnc7GlvV7cwcCkucfT9yBrLxGB0y5E2nSwioGP
 h1a4+jBYu0mbPwmivDVtdrUpOw8dfG2gR/pD7wnMxPGlQ/D0em/jDwRn0LoWzvAlCguYkg
 j/pHaTWivjtXW7iNVjKFvxgYexLITpI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-xQg7SQ7-NIOtwEOpvaSwBw-1; Thu,
 16 Jul 2026 06:13:10 -0400
X-MC-Unique: xQg7SQ7-NIOtwEOpvaSwBw-1
X-Mimecast-MFC-AGG-ID: xQg7SQ7-NIOtwEOpvaSwBw_1784196789
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85771195608E; Thu, 16 Jul 2026 10:13:09 +0000 (UTC)
Received: from berrange.com (unknown [10.44.34.221])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 702491955F78; Thu, 16 Jul 2026 10:13:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 0/2] Record maintainer/reviewer Git Lab handles
Date: Thu, 16 Jul 2026 11:13:03 +0100
Message-ID: <20260716101305.1484991-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
Missing GitLab handle for maintainer 'Akihiko Odaki'
Missing GitLab handle for maintainer 'Alano Song'
Missing GitLab handle for maintainer 'Albert Esteve'
Missing GitLab handle for maintainer 'Alberto Garcia'
Missing GitLab handle for maintainer 'Alejandro Jimenez'
Missing GitLab handle for maintainer 'Aleksandar Rikalo'
Missing GitLab handle for maintainer 'Alessandro Di Federico'
Missing GitLab handle for maintainer 'Alexandre Iooss'
Missing GitLab handle for maintainer 'Alexandre Ratchov'
Missing GitLab handle for maintainer 'Alexey Kardashevskiy'
Missing GitLab handle for maintainer 'Amit Shah'
Missing GitLab handle for maintainer 'Andrew Jeffery'
Missing GitLab handle for maintainer 'Anirudh Srinivasan'
Missing GitLab handle for maintainer 'Anton Johansson'
Missing GitLab handle for maintainer 'Antony Pavlov'
Missing GitLab handle for maintainer 'Ari Sundholm'
Missing GitLab handle for maintainer 'Artyom Tarasenko'
Missing GitLab handle for maintainer 'Aurelien Jarno'
Missing GitLab handle for maintainer 'BALATON Zoltan'
Missing GitLab handle for maintainer 'Ben Chaney'
Missing GitLab handle for maintainer 'Bernhard Beschow'
Missing GitLab handle for maintainer 'Bibo Mao'
Missing GitLab handle for maintainer 'Brad Smith'
Missing GitLab handle for maintainer 'Canokeys.org'
Missing GitLab handle for maintainer 'Chris Rauer'
Missing GitLab handle for maintainer 'Christoph Muellner'
Missing GitLab handle for maintainer 'Clément Chigot'
Missing GitLab handle for maintainer 'Clément Mathieu--Drif'
Missing GitLab handle for maintainer 'Collin Walling'
Missing GitLab handle for maintainer 'Corey Minyard'
Missing GitLab handle for maintainer 'Darren Kenny'
Missing GitLab handle for maintainer 'Denis V. Lunev'
Missing GitLab handle for maintainer 'Dmitry Fleytman'
Missing GitLab handle for maintainer 'Dmitry Osipenko'
Missing GitLab handle for maintainer 'Dorjoy Chowdhury'
Missing GitLab handle for maintainer 'Doru Blânzeanu'
Missing GitLab handle for maintainer 'Elena Ufimtseva'
Missing GitLab handle for maintainer 'Eric Farman'
Missing GitLab handle for maintainer 'Eugenio Pérez'
Missing GitLab handle for maintainer 'FangSheng Huang'
Missing GitLab handle for maintainer 'Farhan Ali'
Missing GitLab handle for maintainer 'Felipe Balbi'
Missing GitLab handle for maintainer 'Francisco Iglesias'
Missing GitLab handle for maintainer 'Frederic Konrad'
Missing GitLab handle for maintainer 'Gaurav Sharma'
Missing GitLab handle for maintainer 'Gautam Gala'
Missing GitLab handle for maintainer 'Giuseppe Lettieri'
Missing GitLab handle for maintainer 'Glenn Miles'
Missing GitLab handle for maintainer 'Gonglei'
Missing GitLab handle for maintainer 'Haixu Cui'
Missing GitLab handle for maintainer 'Halil Pasic'
Missing GitLab handle for maintainer 'Hao Wu'
Missing GitLab handle for maintainer 'Hari Bathini'
Missing GitLab handle for maintainer 'Hendrik Brueckner'
Missing GitLab handle for maintainer 'Hervé Poussineau'
Missing GitLab handle for maintainer 'Hongren (Zenithal) Zheng'
Missing GitLab handle for maintainer 'Huacai Chen'
Missing GitLab handle for maintainer 'Hyman Huang'
Missing GitLab handle for maintainer 'Ilya Dryomov'
Missing GitLab handle for maintainer 'Ilya Leoshkevich'
Missing GitLab handle for maintainer 'Ilya Maximets'
Missing GitLab handle for maintainer 'Jagannathan Raman'
Missing GitLab handle for maintainer 'Jamin Lin'
Missing GitLab handle for maintainer 'Jan Kiszka'
Missing GitLab handle for maintainer 'Jared Rossi'
Missing GitLab handle for maintainer 'Jason Herne'
Missing GitLab handle for maintainer 'Jean-Christophe Dubois'
Missing GitLab handle for maintainer 'Jesper Devantier'
Missing GitLab handle for maintainer 'Jeuk Kim'
Missing GitLab handle for maintainer 'Jiaxun Yang'
Missing GitLab handle for maintainer 'Jiri Pirko'
Missing GitLab handle for maintainer 'Jiri Slaby'
Missing GitLab handle for maintainer 'Joe Komlodi'
Missing GitLab handle for maintainer 'Joel Stanley'
Missing GitLab handle for maintainer 'John Levon'
Missing GitLab handle for maintainer 'Jonathan Cameron'
Missing GitLab handle for maintainer 'Kane Chen'
Missing GitLab handle for maintainer 'Kashyap Chamarthy'
Missing GitLab handle for maintainer 'Keith Busch'
Missing GitLab handle for maintainer 'Kohei Tokunaga'
Missing GitLab handle for maintainer 'Kuan-Wei Chiu'
Missing GitLab handle for maintainer 'Kyle Evans'
Missing GitLab handle for maintainer 'Leif Lindholm'
Missing GitLab handle for maintainer 'Liu Zhiwei'
Missing GitLab handle for maintainer 'LIU Zhiwei'
Missing GitLab handle for maintainer 'Li-Wen Hsu'
Missing GitLab handle for maintainer 'Li Zhijian'
Missing GitLab handle for maintainer 'Luc Michel'
Missing GitLab handle for maintainer 'Lukas Straub'
Missing GitLab handle for maintainer 'Mads Ynddal'
Missing GitLab handle for maintainer 'Magnus Kulke'
Missing GitLab handle for maintainer 'Maksim Davydov'
Missing GitLab handle for maintainer 'Marcelo Tosatti'
Missing GitLab handle for maintainer 'Mark Kanda'
Missing GitLab handle for maintainer 'Markus Armbruster'
Missing GitLab handle for maintainer 'Mathieu Poirier'
Missing GitLab handle for maintainer 'Matthew Rosato'
Missing GitLab handle for maintainer 'Matyas Bobek'
Missing GitLab handle for maintainer 'Mauro Carvalho Chehab'
Missing GitLab handle for maintainer 'Max Filippov'
Missing GitLab handle for maintainer 'Michael Ellerman'
Missing GitLab handle for maintainer 'Michael Rolnik'
Missing GitLab handle for maintainer 'Milan Zamazal'
Missing GitLab handle for maintainer 'Nabih Estefan'
Missing GitLab handle for maintainer 'Niek Linnenbank'
Missing GitLab handle for maintainer 'Ninad Palsule'
Missing GitLab handle for maintainer 'Palmer Dabbelt'
Missing GitLab handle for maintainer 'Patrick Leis'
Missing GitLab handle for maintainer 'Paul Durrant'
Missing GitLab handle for maintainer 'Pavel Pisa'
Missing GitLab handle for maintainer 'Pedro Barbuda'
Missing GitLab handle for maintainer 'Peter Lieven'
Missing GitLab handle for maintainer 'Phil Dennis-Jordan'
Missing GitLab handle for maintainer 'Philipp Tomsich'
Missing GitLab handle for maintainer 'Portia Stephens'
Missing GitLab handle for maintainer 'Ran Wang'
Missing GitLab handle for maintainer 'Raphael Norwitz'
Missing GitLab handle for maintainer 'Reinoud Zandijk'
Missing GitLab handle for maintainer 'Richard W.M. Jones'
Missing GitLab handle for maintainer 'Roman Bolshakov'
Missing GitLab handle for maintainer 'Sai Pavan Boddu'
Missing GitLab handle for maintainer 'Sairaj Kodilkar'
Missing GitLab handle for maintainer 'Samuel Tardieu'
Missing GitLab handle for maintainer 'Samuel Thibault'
Missing GitLab handle for maintainer 'Sergio Lopez'
Missing GitLab handle for maintainer 'Song Gao'
Missing GitLab handle for maintainer 'Sourabh'
Missing GitLab handle for maintainer 'Sourabh Jain'
Missing GitLab handle for maintainer 'Sriram Yagnaraman'
Missing GitLab handle for maintainer 'Stafford Horne'
Missing GitLab handle for maintainer 'Steven Lee'
Missing GitLab handle for maintainer 'Strahinja Jankovic'
Missing GitLab handle for maintainer 'Subbaraya Sundeep'
Missing GitLab handle for maintainer 'Sunil V L'
Missing GitLab handle for maintainer 'Sven Schnelle'
Missing GitLab handle for maintainer 'Thanos Makatos'
Missing GitLab handle for maintainer 'Titus Rwantare'
Missing GitLab handle for maintainer 'Tomita Moeko'
Missing GitLab handle for maintainer 'Tony Krowiak'
Missing GitLab handle for maintainer 'Troy Lee'
Missing GitLab handle for maintainer 'Tyrone Ting'
Missing GitLab handle for maintainer 'Vikram Garhwal'
Missing GitLab handle for maintainer 'Viktor Prutyanov'
Missing GitLab handle for maintainer 'Vincenzo Maffione'
Missing GitLab handle for maintainer 'Viresh Kumar'
Missing GitLab handle for maintainer 'WANG Xuerui'
Missing GitLab handle for maintainer 'Wei Liu'
Missing GitLab handle for maintainer 'Weiwei Li'
Missing GitLab handle for maintainer 'Xianglai Li'
Missing GitLab handle for maintainer 'Xie Yongji'
Missing GitLab handle for maintainer 'Yi Liu'
Missing GitLab handle for maintainer 'Yoshinori Sato'
Missing GitLab handle for maintainer 'Yuri Benditovich'
Missing GitLab handle for maintainer 'Zhang Chen'
Missing GitLab handle for maintainer 'Zhao Liu'
Missing GitLab handle for maintainer 'zhenwei pi'
Missing GitLab handle for maintainer 'Zhenzhong Duan'
Missing GitLab handle for maintainer 'Zhuoying Cai'
GitLab handles missing: 158 / present: 68

Plenty of those will have GitLab accounts, but are simply not members
of QEMU. Plenty more probably aren't registered with GitLab at all.

Short of emailing all of those people directly, I don't see a good
way to identify their GitLab accounts (if any), in order to invite
them to the QEMU project. I don't want to blindly invite accounts
which merely have the same name on GitLab as there's too much risk
of getting a mis-match.

Changed in v4:

 - Fixed misc typos
 - Remove unused awk variable

Changed in v3:

 - Validate handle in .gitlab-map-manual maps to one in
   .gitlab-map-auto
 - Validate real name in .gitlab-map-manual maps to one in
   MAINTANIERS
 - Fix stripping of quotes in names
 - Fix trailing whitespace

Changed in v2:

 - Don't store data in MAINTAINERS file, use a separate mapping
 - Don't require a --gitlab flag to get_maintainer.pl, always
   show the handle
 - Add scripts for updating & analysing the mappings

Daniel P. Berrangé (2):
  gitlab: introduce files mapping GitLab accounts to real names
  get_maintainer: add ability to report Git Lab handle

 .gitlab-map-auto          | 93 +++++++++++++++++++++++++++++++++++++++
 .gitlab-map-manual        | 18 ++++++++
 scripts/get_maintainer.pl | 51 +++++++++++++++++++--
 scripts/gitlab-map-check  | 51 +++++++++++++++++++++
 scripts/gitlab-map-update | 45 +++++++++++++++++++
 5 files changed, 254 insertions(+), 4 deletions(-)
 create mode 100644 .gitlab-map-auto
 create mode 100644 .gitlab-map-manual
 create mode 100755 scripts/gitlab-map-check
 create mode 100755 scripts/gitlab-map-update

-- 
2.55.0


