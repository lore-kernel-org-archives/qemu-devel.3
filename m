Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFADC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 21:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmKeY-0000ni-Nz; Mon, 18 Mar 2024 17:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rmKeV-0000mj-Ls
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:36:15 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rmKeR-0004oz-Kt
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:36:15 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5a2f:0:640:431a:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 0E46E60B23;
 Tue, 19 Mar 2024 00:36:08 +0300 (MSK)
Received: from davydov-max-nux.yandex-team.ru (unknown
 [2a02:6b8:b081:b660::1:2d])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id pZLCWv3IeqM0-sk804VA8; Tue, 19 Mar 2024 00:36:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710797767;
 bh=KAQ7bIK/33QGf3xImcTyGRwGSGrbYVHgYfFl9Kfrcqg=;
 h=Cc:Message-Id:References:Date:In-Reply-To:Subject:To:From;
 b=LWNCB3VX3w12vYCCuei811xkkiLknPTUrCKYBxSP1St5Rq5yAMK2meT6BO9CkyQg/
 xPM4L+OhxWbTyhP2kCH961a5aL9TJ4HSWBTsTotDxSt8+86l1Afpbrm3OmPv4fyZ0b
 VJO/0EdS6LZKDBTrrLGAzIaM7hdXyxo9GUetgKT4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: davydov-max@yandex-team.ru, vsementsov@yandex-team.ru,
 peter.maydell@linaro.org, jsnow@redhat.com, philmd@linaro.org,
 armbru@redhat.com, peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
Subject: [PULL v2 1/4] qom: add default value
Date: Tue, 19 Mar 2024 00:35:47 +0300
Message-Id: <20240318213550.155573-2-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318213550.155573-1-davydov-max@yandex-team.ru>
References: <20240318213550.155573-1-davydov-max@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

qmp_qom_list_properties can print default values if they are available
as qmp_device_list_properties does, because both of them use the
ObjectPropertyInfo structure with default_value field. This can be useful
when working with "not device" types (e.g. memory-backend).

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qom/qom-qmp-cmds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 7c087299de..e91a235347 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -212,6 +212,7 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
         info->name = g_strdup(prop->name);
         info->type = g_strdup(prop->type);
         info->description = g_strdup(prop->description);
+        info->default_value = qobject_ref(prop->defval);
 
         QAPI_LIST_PREPEND(prop_list, info);
     }
-- 
2.34.1


