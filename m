Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899F1E8307C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDSD-0007TL-30; Tue, 03 Feb 2026 05:16:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDS2-0007Cp-31
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:06 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDRy-0002DL-8r
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770113747; x=1770718547; i=lukasstraub2@web.de;
 bh=SIsYoIOUBzpJ4PEyh0nc52NL9mD2skAsvSA7Ee6VW9o=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=BXduZV9fTwcEAiegSjJIDl/LaxVauAMRIL3ZR1ttWyToAHH1ooHyTU25qNcY+5pb
 u2ofoL/jNaH47wbMnQfatVQ67IS9ziNqHui5XAnKmLgSN8tpcTr46cY9wYQjaoXX4
 bDSCzkEAyfJ9wmecxBl2YdyX8uLIbrDXJZO5I0Zab9XgRcVkivCXsOx9Zl/pq7WOt
 Hvbuz2erTJf65/DImcj5SGMAKTxykQ2lrV7PM+yUJxA7lUg7TfrvscVdGBjzGMfGC
 1uWZZ6KVTtD9kOR8UD4bbHLc/1lY7c3IFnZfOecH58juDfUeaOvdtqZDJBYnRUOLY
 U99MgGxKcDeu/1kszA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOUxo-1wD0Qf24p4-00Z0ts; Tue, 03
 Feb 2026 11:15:47 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 03 Feb 2026 11:15:08 +0100
Subject: [PATCH v5 02/16] MAINTAINERS: Remove Hailiang Zhang from COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260203-colo_unit_test_multifd-v5-2-57508b7389f6@web.de>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
In-Reply-To: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
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
 h=from:subject:message-id; bh=akLtAizr0Rulj9FVksSEosvDq4TvXIp7Un4kokIcchA=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpgcrP82jkoPOD5ZcF5gMq9QyRXc7AVWTZ9TC3f
 gK880dpxOmJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYHKzwAKCRA1qwsonF2y
 WBbGEACu3GZ/WcEyKgD5K9I/er+fIl3H5PKKdaCjwLO4x7fsagaVLv5leKJH96jrqWsIyKY+5LM
 YCi5OSVUvSRIJQaG8MDHHPR9qlyVUUeVWLs5lzVygHxhMZkrzTGIim2vWoIww0yWgE3MOmOyOIx
 pNHFeKyWCAZ+T75u1EdypbNtOkziq/4zlIm8fBQrnQ0HICK6lPUJYecJSA/jA3HOLS24ZCwvoES
 BnT5HXl/5bHu3/NcnCT6bCPnUDFv4Z1+JyEvAz5ydf/jXIV5Kw370eM2r6i2lcwWgyhibx054nz
 835pn21/Mpsj11k/y8Q9QIdDqlzJlt7jLrVgxxxMM4M0mumNE7lLdm2tKu2gYWttekPjGo2qKRf
 VSftu8uFn4zpGczTYpb0Gi+1XjeAZ5IWxCz4cSsrWZWqa9Dw3LRcpvuQ9bX3YZxkZGNdewpv95E
 WUgd1PBGYLqQ9cmASHYCa/X/5yUNGFJ+4FzGurH1jgBzGSmkfean0L5C9ozEzJ4k/wPFY3XODeI
 Ne/t3gU5C1H9nml2pT83OfS3o4sZNBJOgYrVfgd9O8SV4fMZfSNG+cK5Sqz+CKGvFY0HbCY0tBT
 Nbh3Z04EnmGTzAYW9S68lHfEXPAbNdOiQTkmj35NdNxyZ4mdd8eWYDfENhjkLWrccDSonBX2Axp
 vwyAoVN+UrYMsdA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:2QLKfSY0HcobEPzZ/3tTpcOdmdHZGoKASubIbMlcueHB8IEyry7
 jEt4knv3N2yzJm6DDpR+Tc/4b/buzS+dGa1VN6crFumZR4Qvbt59hWEaoZ9gGuEVtwEl4L+
 np3Itn0zVpAZL5J9AdL8lIrCpGzrbxaKVGjknrv44M+Vi9VqEofULR/6UmkKdnKxm7RniKG
 +u7MWjgGVmiEbqDjk6mJg==
UI-OutboundReport: notjunk:1;M01:P0:wBrpI2f80BQ=;QzK3wzjWsn3oMQLOo9GU9k23ADK
 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
 1/BPCUvbMSbyrwr9F0nq
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index a9b29cbd528633b25adb6ed7ab2162a2d11b179f..ea170280580af6e3ebc586c3cb=
9bf6e144b30c11 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3848,7 +3848,6 @@ F: include/qemu/yank.h
 F: qapi/yank.json
=20
 COLO Framework
-M: Hailiang Zhang <zhanghailiang@xfusion.com>
 M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*

=2D-=20
2.39.5


