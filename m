Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD46DE9B34B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Hu-000515-Kl; Mon, 02 Mar 2026 05:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HU-0004rs-Qn
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:40 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HP-00061y-UY
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446414; x=1773051214; i=lukasstraub2@web.de;
 bh=ulLSVe9J/4FxIZugf2W3Tsb5eFQh8fOd29S7Dgc9JTM=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=UFH/f0o6nZ11+8Y3wm8KK5sLsv0k2WkzqjH1fkkukHvdRStMedS5f84D3xItQxpY
 1aHYAbNToB9D9q/Bd/YBUZi3N38HoKPg0lXsXElPZIberK1OMisSQsE1mVCiuIvrd
 SYy/d3Mqf/+WqM+KdOlr8gItX6NIEy4K8Du2XFGVlSJHXdi3OGG/hl7oHxcDX1/pW
 JhaRkTcnI9/egjIlz4/XoapPUuyweKahgWV4LXxuVP3bfKfrWA47QZMxM8VMnGoFT
 aGKDQ0WFLKMVLqc5CD6FuHiOwOlNDr22jR6a/8TjjqFr9kc1iZ5KpqYjRUSb115ow
 Ezt0eUq8SN7ZIXYZUg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoeY7-1vLScB1awb-00kFXb for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:34 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 02/21] MAINTAINERS: Remove Hailiang Zhang from COLO
 migration framework
Date: Mon,  2 Mar 2026 11:13:13 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-2-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=KCRVBGcCfPDGLbGpOm74X3+VG1Zpq3Yt87JPJ+cVEVQ=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAEISbYRup1EUrmTlq1XH1KXNzle0+Ru8RUt
 C/+10TnKCeJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBAAKCRA1qwsonF2y
 WGA6EACkAIv7vEyeZCV/ye5nirYmM1DOl5B4SYWJrIQ9h3Nb1ZgsxVokdkXsJduGAcLEKNp5zbF
 /8oVRjdWEvt/vvAVoWpihp3AAwp916wuG2iTvQ4b62xWrieKxz8i5xd19HBE9POPKrQc2MN3vHs
 or8I2sZLeCnFEDBQd9EtvCz0OdLO2hzme9YzSueTKLV8nUKsIVeN89XN8tu5Lr/RKImYq1gngYI
 c30XpCB9kY6ddA0Iw/zeTOHOoN1U67a9lNpt2ApG1UWo1fGsatdfYqYwyDmbyqk3bFupDr2bwwe
 82RWc/QEBr4HlYRHES3LsqfoYWaRYDpI29mfopEVlfMCywf1fLHK2jGAHGWc15x+bpR8YR+Lqc1
 eHo1ArfBjrRwDKFChSD8IyomSAZ4UnUV3EKCAv7+zBH7SBizFUYHu49pdiuGeuLpADqNnLZfXXi
 l3gt/3nwXLf+bs8knjgDfyAiQ5uyH3BTzhJ6d3UaGkHlh6Gh+A1Ady4l0T1v8n2iDHNoxheeFqa
 CM/DyN3nXKwUoGnwy2pphSgFyv6c+Ce8yUP00AkMll450ltVKyKiSPCwWL16l4GGMXlzE74pOrY
 UGQEYtB347RM2sksAtb8U8KI7ABusdAIqISC6UdQR0u7XyalyqWq7S04Um0IQooqI3m5DNJesAi
 CKossrM26gmn2mA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CYsp2I3eYYz47HKzsMys2oxf6xXtKmwSlTRKEc90JPGTUBDjDrj
 UoeGVkCqPJPjpGQ+gkIyKoGFfTM3kVxvfwCx6pKiFBk2LBrJXpB/EbHpIshRdJFJ2Ea7xFo
 avAvjb+PDm+XCUXTzc5R+SiyoVWPrdIkY98eG5gOsngp6kuLbwoaeo4m0Zj3ySrHkOXh+dQ
 z/yLRmcYdIPzu5mVuNk+g==
UI-OutboundReport: notjunk:1;M01:P0:+4/boquw/QY=;X4MV3a1mk/p0vRNXQDJ8rj6NOO1
 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
 fXht58hv7UPAUfryh7t8z5MdfWUBGCn+YnenI1
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
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


