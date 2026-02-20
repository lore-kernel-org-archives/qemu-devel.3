Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9E1C5AE49
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXc-0000S5-QL; Fri, 20 Feb 2026 14:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXb-0000Ri-BQ
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:55 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXZ-0001Q5-F3
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617107; x=1772221907; i=lukasstraub2@web.de;
 bh=Wgs8JnPLwSHCXYAOpefvV8N7YHva0erDF8oWhWNsX3A=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=iqpwWuY9lChQ+Sipsrc0k4IJ1RmvKP19W+WdQNJPlFYpB0wB+UfPx/k/lnQlcerj
 aQ0wdDhWrnl1fHHVB0+1QG8FKH2YXDi/ALSrj0q7qF5Uo8R/9ExOE/ly1GADqghVW
 qNwrUuo4po4nfU/G2ivFc6hI8gQfkFLTUL2GDKVKlLOoDHPTZHrKw+s0Jx0b+hbiV
 lTi/ofPNz1axD82r5V5SsGDqbPo0BTC3WJuY+AggJG8eUT87R71qQtOvmJazT6nXM
 xoeAkNf1jq87wJE003ZGN9Tx6ckE4ftKW15lLP8Lr027GcCPa4Hqpoor6sJfCgzQ5
 OIYWmkdUJv0/YO/1TQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSZMD-1wI1Pu0hFR-00SCq9; Fri, 20
 Feb 2026 20:51:47 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:23 +0100
Subject: [PATCH v10 01/19] MAINTAINERS: Add myself as maintainer for COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-1-bfe67d422ef1@web.de>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
In-Reply-To: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=637; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=MPZRkh7CVx78Nod7CaK6mwPKVKcE6Kz1AKvpzLXE0w8=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtN1Djxy09VQPOstEohDZT/VARKbfQKA2Evl
 UIrQevPRMeJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TQAKCRA1qwsonF2y
 WOX9D/47jtJEkKXhKtNHRLBr+Uoa2yxdU1FbrNeeUXMeD3V0Ct+s9EspfO4wKUGDFScEarcGhNJ
 J+YSqnvO5bWWISQE3Qf1Md63DCa40wtBCoxXRYl+xX6UjogV1OKittLsVaxyCVXAVSwQbDosrlZ
 4ivq8+g5UQdRFIoti+KH/mJg4aPusu0v6lK0QXZ3DkomSfEAC/tOFfBvZaLFF/ZLT8kACCFXdJh
 C8ASss5k9BOIoZcht3NGDF+vvWoBVZehTynOK58itCiz1ZnSfHTwEQVhZRgQApIpPyjETE2/zsI
 LSVhUBBVbGXG6+DErZBjA1W+vheM0eXXDmCOEs8rbdHmZr4lcpU/NH8C17H2sm8Zb9be77KuTbj
 bmJRlyBbfuESnPvzvCl6/Mjz5AwyL3BcQmkJ6zVkG7p4MmZJfnC1Z7V4P17hvB5yLXavsObgo7f
 JZPkMMy6rng0mRcugowHgPEpp8Y0/JdheuaLBF9WQGVvj732wl6tYgc11sMIW+StEK+wX/3+WQl
 1ghN57uieiLEtfd631BKK9gowxs2GpV4Tq/XUJBsbSySX037UxmiJP/jIqsEibauRXteLaBjX89
 mulrGVViSLDLhmmyyeuS74u31alrlL+dnl9zwaCjj6Ep1nHKkz1XJWRyu6rfxHwkrsib7c2wdOf
 Ca2e6uSvs1Sy7gw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:7hZ1BlI1D02PYMWaAf6161g5GsVW02UE27VywCCjEKSFIa0wJ9s
 LIr/To41Rm4FMztk7s0axBEVYtzjnc0231dp0PQf8qpZzemp9F5rHWlrioCusydyDO+RztA
 zJeatw3q4Yw5W3GGqefpvSSuNp21X3OLFYRXWkkrr65s48WPQywuU1oxT+OuEKZ00cWtLen
 mWh0qO7tNH64D9hrbuVNA==
UI-OutboundReport: notjunk:1;M01:P0:yCwPVwUn6k8=;yzAWA+BOZ2iTTnl39D8rmwR3B1U
 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
 h+RBmpww=
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

I am ready to maintain it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0c481e2125d81298a52caf7f7b51c3e4f026d85..2458241e3cd45673d7228a3fec=
f2fe94f3b51b77 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3866,6 +3866,7 @@ F: qapi/yank.json
=20
 COLO Framework
 M: Hailiang Zhang <zhanghailiang@xfusion.com>
+M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*
 F: include/migration/colo.h

=2D-=20
2.39.5


