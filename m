Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E52EA8121
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpohk-0005E7-RX; Tue, 10 Feb 2026 09:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohW-000573-L1
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:50 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohU-0005kh-M0
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770733599; x=1771338399; i=lukasstraub2@web.de;
 bh=4LaXbTl0THXOahwuMttIKN3IotOqiTe82gAMkr3oLpI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=u7FKdO99YYFZnvmWLxzK33ENZNnjFFwJP5U+P6dz0tJSiZIDDSNHq9am2SDNCWVW
 ygQ6UzlG4PeUz3+4Pvy1j7NGGILLky3b6wM18xGWbGHYneDdWnb60AmIgE85ChPAK
 0kVMgx5XkD0FUhyEseu8VI50MJ1vfllPIF8lyfKbJtST4/7/LuA59aPckEJAtwDov
 sT2TZammESEoaMW572E1owcnYaspOI2H1SAFWiUlkiBy0JeEY6AxQbH6iSeAhsgUn
 zxVtlzXQQB0sAPAWbXRi25todqUQN8/N0qvvvtWH/66PT3xmEgTJm5c1SmVWOUkp/
 DD29/IwBCspztD5n6Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mi537-1vKtrC2N9N-00q4wp; Tue, 10
 Feb 2026 15:26:39 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 15:26:14 +0100
Subject: [PATCH v7 02/18] MAINTAINERS: Remove Hailiang Zhang from COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v7-2-23bd32f36828@web.de>
References: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
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
 h=from:subject:message-id; bh=Q+MgSdFh34hx+cFCgJDYFMQn9ZkaS5SNN9GtvvR6EzU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi0AblB+4FR3vKPtz3pTw8JAXwR/F2JKbiJkGU
 NbGHfSErkmJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtAGwAKCRA1qwsonF2y
 WKOzD/9aBMwcI2YG9kXc8grfyw19r1r76/WDTvCb07nvKSpSPQUoArJhXT3jjGjwZPFL2/Eof8i
 xzm84MEJP6KivE0BHe6R8Vv62LcWDwfsCVYEwkhkbzYKg/VxzFTQg9g9jHB+L4ThdFdDY2fYCxo
 k5HG/FeqEBLIB0DClsBIfTcuRnEzzIasgqWI8XGEpEvAxIdP/pk9e1xJqtq1R1eLyXax6CU897L
 bvXhHAUgbKbOsGVf2J2rpdsIcJsb0uq02MhPMEC8cyxNxKt8OvabpOY0slUzBCwU7QLttuqauML
 T+iS04KCc81Ov4LTdD1swRjN7L+nnFXgvAk+zaiylaSjhZomJGav7M+xc4E9zhpzh++BxJ8TVJR
 a+TJRyqQBEfmFGz2hoh1WtQQp7wViD3JJF1XB4PQaSdgP4aSU4HS9SSR56H3Wfu69jpZmja8iMw
 sniIgIdMxQROMczckH83MPVelotSmkmhL3na6JvQwRTyo9uWUi9pThuw/PA4qjK/jew9mNEW4If
 JKpPSRUitIFQjq3Pvl2cnOBRrkelaOJ8Syso75R/f5epsYqODN3WNmb6avV8GZv7hL+JmGwSBsX
 HFRWZUS52Mf0OoXm9Bpah/g53TX0l2BiJP3H8lUMaBoN2gb3E9vWp/JCmVJM4zYwKRb/6WSgZcK
 AcFkPZWrb3kEc2Q==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:/sIM1q6Pjl+woVtEPR9K8VlQlDzjZP5aT286nEPFlGuEiA4gl6M
 9LSQUDG+UvKk9G5FxD3/lsvzroZVNbgMX6IJlmmsgK4dWBW6VFsKF1akb808vB8lIrml6Yh
 029Om6PBALW+NuVDxzEBZYQsBn8EM4PWp+rtdqrU7QL983nb1+f222jyMMZzQlgFFSJG/+L
 8eRV7M55yh2F8ZRwynwgw==
UI-OutboundReport: notjunk:1;M01:P0:fJ1C/RjPehg=;pqLCmjP+9AXEEpHlzq3xS0T9gg2
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index feaa4e47082499b3c7c9eee1a0e1a1fa28f70e2b..356e3a7889f9ab45f002f16511=
2322e6fb5a1967 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3856,7 +3856,6 @@ F: include/qemu/yank.h
 F: qapi/yank.json
=20
 COLO Framework
-M: Hailiang Zhang <zhanghailiang@xfusion.com>
 M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*

=2D-=20
2.39.5


