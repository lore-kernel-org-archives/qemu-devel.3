Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C7FE9B34B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Nz-0006Yx-3A; Mon, 02 Mar 2026 05:20:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nw-0006Wi-5z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:20 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Np-0007GL-Qo
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446811; x=1773051611; i=lukasstraub2@web.de;
 bh=ulLSVe9J/4FxIZugf2W3Tsb5eFQh8fOd29S7Dgc9JTM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ThdL/hIV2ONU8KVGeeo6NiWNIKQ45cQqvHNL0+7HFKVbPdGpm9JGhrrIWD94+ayb
 bLbY4Zepa5rNfGQdRLg8qQv1NhmjSt/xdYTdjK/rlwnY6lputLxMVpUz6EgXlbcVU
 lUcCAQaH/7bSNjyR3a9OyNk9vk22kdXOEVV6yG8sETt8kfpXuZ11TTPBNhUqPZSL0
 eM0Il/sGAYbqWaJV7K6Mpdnl4Dr121jTWXURfwXIT3aI8KKjCJ/OL25gexDRk/GPV
 LF9uNRNv6uslZNRS3Uu8JLNjIx1ztjgl1OOrFXCp6hpFB3TjTB14bPq4nEVlqTnJy
 1Z0Q/zYT4sOHFosGVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N30ZN-1vXTK21Vd7-00t8JF; Mon, 02
 Mar 2026 11:20:11 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v11 02/21] MAINTAINERS: Remove Hailiang Zhang from COLO
 migration framework
Date: Mon,  2 Mar 2026 11:19:44 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-2-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=KCRVBGcCfPDGLbGpOm74X3+VG1Zpq3Yt87JPJ+cVEVQ=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQoAB0zg8Pdv3qU+R8qTzxkjbqcv3B2C42TW
 pR6+NyTUmyJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKAAKCRA1qwsonF2y
 WEV/EAC3SM0RU943j0cPzTyBeWH8PSa88BpJGUyfey2nMe79fwmNcxoYFPmHEsp9DZd+yEEEo0a
 J7y29NoqRYq+7fZAbUOAWkD2eDKHaPgIKxYBrFFkUVu0a3pau3M//hiX8f+eCfPsHdXS8r2S0ki
 BLQFSK0zl70SIu866PKXQRFd8dNJnKUphVuE64Hocs3b6FhS/O+pYoG6j58wAddfBBsSca+SUY7
 HvhkM+xWTk2e+zzjOk8fcrJ3pu2nu3p8qiK87W08azFYZBSekq/Y4IH9uYoAGm+uukAuCQ77KQi
 DffDbQ72Q/LV22CeTsUoKlidqDV8yp5TGmRVv9uun6bACQlpLrdOMTdFIopdXMq2SEvLzA3WXRX
 aWLgbCe03/DaG3kLfUKmWgf880r/VNwTX8z3i9qqkJ5/Wzue5x+rUc/7hRLIveknB1DgBobJNmc
 Z3/6TdQ/gZD9PQEritg8Oqtx9tAfseFCFAmSyXvycgTMwQM+O4CyvEipPjMVjoGbEvmHb4Fa583
 ABCyD3WALkw39/Xy657BZJnaRURh5GuedByTxYFLDudF/LmTiTe6p4EPRLSn8wqxGwOTi2t/tXR
 EQCh5ZP40JsoPdmuQoVrC4RcTdC75W5IIno3gOysRvpvBAJ3L+D09p675NexrBPBgu20CNtMvD3
 9x5KWBE/I/wUHjg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eYTsHV8LOPpKTY9Np/3wT3v/nG0eh2lBAyF/LBacmOQbZsV9SuT
 WatAGf2PcL1bmy54G04mFPy9d66ZOxEtKWUvx6v5gjXuhRsQVrDx1PFATsULkr2+vGHdTZ6
 6sUYYqSUz6EoLJeM5H035GrplvNcY3gRzbAm9EK5ncvCFCaE76oorp4M5rY2c3Jiin9zb0f
 esUTnxn+d7uib1yV4Rx+g==
UI-OutboundReport: notjunk:1;M01:P0:saibn9P5BaM=;CmPN4iwJiVTodd2g2eq6QKWGzEg
 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
 zEfW/t8Y=
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

His last email to the mailing list is from December 2021:
https://lore.kernel.org/qemu-devel/20211214075424.6920-1-zhanghailiang@xfu=
sion.com/

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ff592384b366acc823f19a6596ea8f32446763b2..aa8f795783ba936ce2521e08aa=
ca8de4a112ed33 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3869,7 +3869,6 @@ F: include/qemu/yank.h
 F: qapi/yank.json
=20
 COLO Framework
-M: Hailiang Zhang <zhanghailiang@xfusion.com>
 M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*

=2D-=20
2.39.5


