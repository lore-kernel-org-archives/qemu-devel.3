Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B599DFF885C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 14:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGdgo-00082Y-Sk; Sat, 25 Apr 2026 10:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wGdgm-00081L-8S; Sat, 25 Apr 2026 10:08:56 -0400
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wGdgf-0005p3-BI; Sat, 25 Apr 2026 10:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1777126119; x=1777730919; i=lukasstraub2@web.de;
 bh=yLwczgFpCwFgm6oydAmEBdlnsQvAtj1UxAtBQ/ZZjCQ=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=aMBr/xVAWx2ellIO4U6RfxM2+zy5At3eXGhcWsj9HcZ5h0lS9h75LBsoOFbNxfna
 4B+v7wRBnuW01shKbTxb0deAWqZ4IaR6GR5Etnz2ZC1n7DYNuunBI/0rFZ2p1im+g
 GBXjAgLNHL3aIUgSacZlo8GwAnQtf3cegxfZXOSgm5qopdERPJUXEWyYiJCAtF7O2
 FhCD7tmM7JI/nvxjBeL38cpbJE+ZYJAlPdhmWDzDZlfD742/hufdcKCxstAfaQszg
 RFSilDec66OBsFQD38TjXYG1FEf2ybArBogTxantB9BAS/+GuIOy4J4aGuCkavsvd
 JcmEOULxr1uhp8H1pQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1u6d-1vEwD00axF-00wUDd; Sat, 25
 Apr 2026 16:08:39 +0200
From: Lukas Straub <lukasstraub2@web.de>
Date: Sat, 25 Apr 2026 16:08:23 +0200
Subject: [PATCH 2/2] MAINTAINERS: Rename Replication -> COLO block replication
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260425-replication_maintainer-v1-2-f6ab019ff0ca@web.de>
References: <20260425-replication_maintainer-v1-0-f6ab019ff0ca@web.de>
In-Reply-To: <20260425-replication_maintainer-v1-0-f6ab019ff0ca@web.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Zhang Chen <zhangckid@gmail.com>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=577; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=/YFANDmiWyJqq3aSe1dRlt8OV1oyCnfAra6Gb5fwMC4=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBp7MrlXSsGu+HYISEDjb/SBHbOb3Rui6hfqqQvZ
 VeckG57gRSJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaezK5QAKCRA1qwsonF2y
 WE1+D/9zxJGHyjqFnvTzc1k0rXE9PDIUABlu6oFMrKnWibl8t+1WChMATUppBa9/5sqeSRcKsDW
 PqKzWBBGMLK40VstkCQknxSTjyyS16W7Hj7kT59rj2IlYWoQvHWa2DAa928vRbzbf4Je/OgsWVL
 Au860cDVxASdZ9btVqXEaPLdBInajzwzeI9maJeljJ8JHhimW6bZn5bv0kNNNKfINN7TAwdx1gr
 Mf9Erjx5gyun8if4bOGJuAdPVx3nhf2gf36sttA50JD4EDfeUuZWVFgx6iQOGMia9+p6EbGTSNp
 xs+EEgEhpyrn+0mxyXtPYPJH+bYMvUo7UUHJ7bUi/Kzejzh93hbjbhLfY3NzvcFyEuKMCK67PRi
 JUpzK4c+c+jVMD6P/aYb+/AGGRapicWhaFbHwZ03YKixPi78l2sbMqlNFujkhDN0OKdnNQ69KVZ
 gTsbdvMgWDEfu6FGcPCUYoQxHHXDBbDUqH9K9PIkGyNLs/dyINO2acaH9gYqrN9BfNRYRDy1Xdu
 yHlqsWvRTNqZmgroaKhxCmdIRxH3fEzH1Rk26F0tff6JzBbB0//nVwaz0jn+tuAEX8W67f1mb5k
 SSY6Jr3iCsbBdbJa5jtpkzHjhcJtBw7IE5MeZsHLXusaejTBuhtRHdTfowotn9VffMD2KOzjv3l
 M0sAZLNqtbCbuBg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:z4fax841pZhgLPHS9bMC3re1hxH/3e/9AyMOy2TICZwEPmPuFVQ
 5q7vnDYEWmt2SUBYEI2CNyxLwuT/Rhr9tUOOnBtMz5wLfAM8D/lZ/6BSrHxRVljChdblgNM
 uec4tz9H9X+fp2XAO6p93klLXOP1ITs/rtI+2x2kEcDmfjXbil+dTzM3kAQxlFeTLrCKPie
 X95ZXA2yMDVrBxeC2uSJQ==
UI-OutboundReport: notjunk:1;M01:P0:63P2JLm7AI4=;NbVLX+6IwoQzyk4dv8DKa5qTFUu
 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
 UEGIl6ZCXG3kjtTRWtqzhUu3j74f+MFSbQNE=
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
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

Give it a more descriptive name.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 39f4982b1fcd12264ffeb9396db48356c00f96df..efc534fa5871bddedc560f2345=
0bf62e27fa1e11 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4383,7 +4383,7 @@ F: subprojects/libvduse/
 F: block/export/vduse-blk.c
 F: block/export/vduse-blk.h
=20
-Replication
+COLO block replication
 M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: replication*

=2D-=20
2.39.5


