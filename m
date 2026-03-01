Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8F5FD0047
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmID-0001Ux-7i; Sun, 01 Mar 2026 14:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmI3-0001MN-ST
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:20 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmI1-0003Za-N9
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392609; x=1772997409; i=lukasstraub2@web.de;
 bh=ulLSVe9J/4FxIZugf2W3Tsb5eFQh8fOd29S7Dgc9JTM=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=lv+/2mkhhALP58Q0TLNpr0s/YX3+5z+eyEer3dzyzva4o9e2Iwmbk9HLghaPwYTQ
 5A3loQgC8bvMuppRPeE92vZ6Hj36AZYZXLrxIdwKPvdYriibTqBWSILIeOhQUchrD
 M6AJANtJPrQ9MtbFAzAkAHg12uBknxCDjUCMGok9D+u4v1F1vw6QwU3hoFxB979o6
 osCVOqxp0VilQNmij4pY+K+cVq0huDcghCQK2L7f3sLyegMHF74XLvkYhvYlvWz/W
 pVdvtDOCuvOBAC8xBGvBqfSyswAZPas+iYvQ3Ncc7sf96xG1zHNglhurEUgX3qRAJ
 ifIzg0blWYpiI22SoQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1JAm-1vzXRL1QNO-007Yuu; Sun, 01
 Mar 2026 20:16:49 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:27 +0100
Subject: [PATCH v11 02/21] MAINTAINERS: Remove Hailiang Zhang from COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-2-a9701e795d7a@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=KCRVBGcCfPDGLbGpOm74X3+VG1Zpq3Yt87JPJ+cVEVQ=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCcL7yU0HKUaT59I1jYxNolAzSuCcsdTD7gf
 xyaxuWhHRWJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQnAAKCRA1qwsonF2y
 WGZdD/9DASha2s3J9+AdRWheoOpiCx3hwlEvhiiT9TTA+JQSt/0vzjzRLurkEA2WPTvwi1Sn1JS
 MuVwOT5Ar3amc/an2QQv10gSo3ecO1fU1RYAf1arhotFssoOAjkLwwkO0NUmWg55VL43PHbMK/H
 LpBhs8zVQ/LXPMX335BBB/39n7OtxzSXdXnjA8cjOPNKxYDWyp8APzyekVCS3pOHRWoBSh6DBC6
 wzplQRVVSk1DSzpQX4y2N9oS8oJ5FT/iSKnr8SsA5mOMZ88wPO94Gf+meIMhQ3YpmnkpYQyq5NO
 bJxuoLmEFPvdE3GHsZ2us9nLEIWQ9xtaDgTKlv4auuV0CFXzpLXE800Ryu/OY92NVs4MU5vYJ7S
 k4fCUES2v2AHxKkzBK5O/ud+X4gCnZzeR2boUEABMBDDz10Gx0F7l/gvQkjkFtuS8EpvwXNQMgj
 cgxGuA1ukvFHpRAC7pkJQVnoJn+Tc3mSVNHGwatQSkuFi2fq/q0VwEXV02bH83yX6AF9403M3YB
 9CtrQKR5BFCkOLjHToxNpTeg08EqJDcWCi5LUv6AKxudRLVNzSPgdMqFfw5MLdrdhnWyB7McDZN
 iwOIj9+Bt7K0V5SlV5VYExkSrfevsqS9iwZYYGd9B5LanBvBxUNahdM/4hrfD+INBRh346Nokb0
 94FJRFtzoE2DeaQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:CMVlNGGC13YxcxYldA5zDwDQtmGrOu8r6Cf+nM4cntbwxwB2KKt
 K9UrFsIvTBaMZ1L3RY23qvBFiz+IqV3km7s852iK/ABTDBbNwzfpWcEEm74EWGh90E0nzLe
 Ol1OKQzl6d3DfsLJRtkJVq3j86yHwAo0yyTO5syK3sf8UeMhlvb3EqcjKGHApOldzyZudP6
 jNba7b05DOD7XKrvXl8ng==
UI-OutboundReport: notjunk:1;M01:P0:2ARu0jofNKQ=;qYaa1Ni47g1Th4Gtg1I1QFLYKIP
 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
 2TMxSjMjcTW8JcGASEENEXUmA0QEJ
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


