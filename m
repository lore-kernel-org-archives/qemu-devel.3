Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A797C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh8js-0006K0-6g; Mon, 04 Mar 2024 08:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rh8jp-0006JB-Oi
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:52:17 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rh8jk-0002JQ-Lo
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:52:17 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 21C38608F8;
 Mon,  4 Mar 2024 16:52:06 +0300 (MSK)
Received: from davydov-max-nux.yandex-team.ru (unknown
 [2a02:6b8:b081:b709::1:23])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jpeXWn4Id0U0-SZ0SdoVs; Mon, 04 Mar 2024 16:52:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709560325;
 bh=KAQ7bIK/33QGf3xImcTyGRwGSGrbYVHgYfFl9Kfrcqg=;
 h=Cc:Message-Id:References:Date:In-Reply-To:Subject:To:From;
 b=s69yzKhEeoRTmZUDOAQTTx/aMDM4IikT3dtI8liye0r4o7fRG2BSS03vH+mE6nDoO
 OnZXYHCh3dyM3sq3KgDvoebFnGw60n0qHV/YHJP9yK+gtVVdmy/XJgynJM+spurmVe
 AdstMuTXJSqAjlvzEcDIEHzb2feVKmS60ypa/g5U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: davydov-max@yandex-team.ru, vsementsov@yandex-team.ru,
 peter.maydell@linaro.org, jsnow@redhat.com, philmd@linaro.org,
 armbru@redhat.com
Subject: [PULL 1/4] qom: add default value
Date: Mon,  4 Mar 2024 16:51:42 +0300
Message-Id: <20240304135145.154860-2-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304135145.154860-1-davydov-max@yandex-team.ru>
References: <20240304135145.154860-1-davydov-max@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


