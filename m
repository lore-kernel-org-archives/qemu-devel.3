Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931C1FF8860
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 14:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGdgm-00081M-Fg; Sat, 25 Apr 2026 10:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wGdgg-000809-Qt; Sat, 25 Apr 2026 10:08:52 -0400
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wGdgY-0005nr-Gg; Sat, 25 Apr 2026 10:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1777126118; x=1777730918; i=lukasstraub2@web.de;
 bh=4hLJ/9b+Fc8Wa1uMiW84UxT5o5ilXi1bQq3mxgqd6FA=;
 h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=MDj4rw3pxudLsVO0yOmTNYnjsGT1o9jxQg0RtW5wWSnxoLYZTtMsQXCVgSG2kfKx
 lvUs4Ir/cKZMFEH4UtFosaU66mCJGxgH55sfyoyWibsPDVDG32iiOODE45kqftVoJ
 9iOqgFrpFV9Mom6KExtr1y8SjxCXx97YqIwpnTItyRTwXbX4EGBpAC4gEr4zM2pKS
 R5WpUAz4IoWl+F69zdnAuLvhYOEUDojGDgNzFeM7qxwGlD/847SoUUDFliaotdkIJ
 mNw030VDpwp7BOddMJHJQstbmYUPFSMBDtlPh9wvi/8vhXSSTct+xroozByhluMoo
 Qn3x6d5jQDebippDJQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7gbY-1vLppc2fMA-00v6VS; Sat, 25
 Apr 2026 16:08:38 +0200
From: Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH 0/2] MAINTAINERS: Add myself as maintainer for replication
Date: Sat, 25 Apr 2026 16:08:21 +0200
Message-Id: <20260425-replication_maintainer-v1-0-f6ab019ff0ca@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIANXK7GkC/x2M0QpAQBBFf0XzbIvFFr8iaVqDKZZmNyn5d5OH8
 3Dq3PtAJGGK0GUPCF0c+QgqZZ6BXzEsZHhSB1tYV9S2MULnxh6TduOOHJJCYnwzuwp93SI50PE
 pNPP9H/fD+35n4LjPaAAAAA==
X-Change-ID: 20260425-replication_maintainer-c5f63ac49ae6
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Zhang Chen <zhangckid@gmail.com>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=874; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=DE51gRVKYYeWwmctRbOJhxHqAsv12XybDrikaZSq0u4=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBp7Mrlpv5GEzueGL4+/YPSWBv/wfOv0r2cFsIom
 eZpgOWgIkeJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaezK5QAKCRA1qwsonF2y
 WH9zD/9S73G7HvEeZ+NwXmY9BSTVXlXrhiO2VoRzfSgOPZXG6uNCpzCbVTqo6BCNquMkjOdA8Jy
 CIyeW1AxbWhhMI6V1V+AaiqpnI6VJMPDmlZSDJThUMv2InycT/+wWX0iFuYgxYuKxhpO+FSGISY
 UCi3phDh0THzP2Q15SuQjMWDqZtptK8ANbrU5YX2rO33LMVgIV3M3DE5ONU9ksiw3b8B3rVEBkx
 9xZKpU6IZKoXIP7ih6elufufYVvNGgt3cko5TSRink3QnvDv25y8FNv5+47gC5pP/wLVgj069FM
 vRUJ62JVjY3ZAnuEurf1qrvvNHSnRdCbRAWTHLHQ2NBLhYX36O3zXA1sRuxp+j5AmnzhB8tnugJ
 0hFqV8ptV63ucpqqAjqP/NBVCCkT/lHm0GpaKHucuGp9QYGyOe4unk8/RkkM4pE069X5Zb2218R
 5juA4m+vfvyUJQW7hxdj9TSnGMieDsqHr13i4NmGoqDdFrZC5yLWwRVACi5WoxA6XRPYObn3DeJ
 XwOHC3KwLdE7hWdOZ52pvwhx3MwNNsEJKohuGjVHP9F8ATDe3CaAsFxswMJinh33uAMrjIBZOKD
 iv30FPZCIclukgJ52ZRpwk/mEbG4e4rGkNU98s2rC/TrvYWXrFT/EtxGYUlQysN57w6mBDvUc27
 /zJZOMadxHns35A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:0/G01WM2Qn66j4wHNcnxjbj1x/736KtkJL7eNZtKBYo4fQYT0e4
 QvlTmKs5fDhchdMsm12NJZE+AFA1VuUjQkfc0j4Y071NLebKHTJJlzL9xbPJe7Uw8ea7mDJ
 oBCPScsZKCtqA9t956ns4ijSycaVh5G+YEWnVCBc4cSxbCUDt/ND/LHPefkXH+tTujOh872
 htmq1w0AOmfLqYo93Mfbg==
UI-OutboundReport: notjunk:1;M01:P0:seOSpnKDwq4=;oklTBtliiewx4868s1vjNj2GK9z
 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
 2HUeuTGaHlHZ2D/IC0ldINqA==
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

I recently took up maintainership for the orphaned COLO migraion component=
.
Here I take over maintainership for replication which is another important
component for COLO.

To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
Lukas Straub (2):
      MAINTAINERS: Add myself as maintainer for replication
      MAINTAINERS: Rename Replication -> COLO block replication

 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
=2D--
base-commit: 4bde339ecb41b16e90810233ba5ee2fa87bd443f
change-id: 20260425-replication_maintainer-c5f63ac49ae6

Best regards,
=2D-=20
Lukas Straub <lukasstraub2@web.de>


