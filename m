Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DF1CD6E5D
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 14:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTgza-0002aa-A0; Sun, 31 May 2026 10:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@sourceandstack.com>)
 id 1wTdUi-0005HL-Iw; Sun, 31 May 2026 06:34:12 -0400
Received: from sourceandstack.com ([159.223.220.208])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@sourceandstack.com>)
 id 1wTdUh-0004mj-4y; Sun, 31 May 2026 06:34:12 -0400
Received: from fedora.home (apoitiers-157-1-11-96.w90-5.abo.wanadoo.fr
 [90.5.14.96])
 by sourceandstack.com (Postfix) with ESMTPSA id 18B534803FA2;
 Sun, 31 May 2026 10:34:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceandstack.com 18B534803FA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sourceandstack.com;
 s=mail; t=1780223647;
 bh=iQuvtDg6EJdTgTQUoJkiURqdQpkaR8jmTXBZ/qqeu7w=;
 h=From:To:Cc:Subject:Date:From;
 b=qeSoOLZdvrJKfmjciAHqK6naxXbEh9cKTsK2zPz+1cs6jPVgJdC5QtlkZBeZXv38w
 FjU0F8sOumF7O/gmgmP9EuZQx65pKhdFjLIcCdCLNTnGQtJBBYZSeC+CSiPiTJ22qb
 PcFfV9pmYa9OnWC4//ja7zsssk3tTCDzdgvblBdg=
From: Christian Hergert <christian@sourceandstack.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,
 Christian Hergert <christian@sourceandstack.com>
Subject: [PATCH 0/1] -----BEGIN SSH SIGNATURE-----
Date: Sun, 31 May 2026 12:34:36 +0200
Message-ID: <20260531103437.2896462-1-christian@sourceandstack.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 18B534803FA2
X-Spamd-Result: default: False [3.90 / 15.00]; SUBJ_ALL_CAPS(3.00)[41];
 MID_CONTAINS_FROM(1.00)[]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[];
 ASN(0.00)[asn:3215, ipnet:90.5.0.0/17, country:FR];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_ZERO(0.00)[0];
 FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[apoitiers-157-1-11-96.w90-5.abo.wanadoo.fr:rdns];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; LOCAL_OUTBOUND(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action
X-Rspamd-Server: sourceandstack.com
Received-SPF: pass client-ip=159.223.220.208;
 envelope-from=christian@sourceandstack.com; helo=sourceandstack.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, SUBJ_ALL_CAPS=0.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 31 May 2026 10:18:13 -0400
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

7J2x6bWnGCPV5Pt6sAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
AAAAQN+I7C3v3pmZpDIZyAgcq5c1+4BDylqpsGbqFBhFpDLXcm/mWrZoJii3GK3Ce+qdGe
F1dW+FOyJOYsDar+YVyQM=
-----END SSH SIGNATURE-----
-----BEGIN SSH SIGNATURE-----
U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgn0Noijiu+xEWY4CvDD7yVv6k3T
7J2x6bWnGCPV5Pt6sAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
AAAAQBHUGCB70DC5aAkYJdtqoTAlDS3+N6kv0bmmZ15j9QKKFpx/fN4/JTA3hPxbubdeVr
mphBILleJBL2b565llIws=
-----END SSH SIGNATURE-----

Christian Hergert (1):
  block/vvfat: defer write commits to half-second timer

 block/vvfat.c | 130 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 125 insertions(+), 5 deletions(-)

-- 
2.54.0


