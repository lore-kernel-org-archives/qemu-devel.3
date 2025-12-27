Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6B4E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQpP-0000wh-Dt; Sat, 27 Dec 2025 04:43:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vZQpJ-0000w5-AV
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:43:09 -0500
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vZQpH-00033d-EO
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:43:09 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 43E0660DC8
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 10:43:04 +0100 (CET)
Received: (qmail 21120 invoked by uid 990); 27 Dec 2025 09:43:04 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sat, 27 Dec 2025 10:43:04 +0100
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>
Subject: [RFC PATCH] plugins: bump plugin API version
Date: Sat, 27 Dec 2025 10:42:38 +0100
Message-ID: <20251227094240.6652-1-neither@nut.email>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-2.999999) MIME_GOOD(-0.1)
 R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.599999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=Ce5GsQlnyuY2KkJr7uLnAP6VnfjSGQVL3ktgiV37Wd4=;
 b=mB5BAifDo0rXZ8BHCw9zzjqMPN5Np8QXWmB3iYN0b2am9A5BlI6vd7h0IY/aa1Qzny3YD8ZTXe
 UHI+axpi5jkxc5eCEJFmYctspatgyKcWyogTn0JMemyzmMXR0F03Zz+Job20ni6VNzJV9kqTNzDD
 jqivuVnm57CIjqx7bRJ9X/UGvvdONkKHqZk0mjRQ+42kaxujMHxAqq/pmpAPkEmE+XrUea35iYQ5
 b2T5Sm/V4AC3gv8RcrMtohUIDWILgUuLZvdMMfnLB9rcPpp6qP7dfCI0Vg6evUXULrKE3uod+K4d
 Zk/jvkMfSd0wBH7dVaY7cWOk0lxdN3qoYWg8aXAw/SWylTe1cgkTvo5gog4GYJ37JMVqzm1gUMLo
 E36zvn2nbxEOgR7ubmIb21Ddt+XaMUpfr8N91ujLZImhY9D8CVjDKuZIqZrTysA7InSFEorj78jg
 +VvG9UiB3bhAg9jaTiR69j/XQrCUGYMtxE7Wd9UTcfXSP8PioN5VWPvbBI84mNjPPycYa+1Uq78H
 ArwXd9gLoe6gHPoKpj9qKKdBPqaSaBemm6TqmEtzHXHrcoIbPToRDyu7tBUTMIWoyf2eluVxQiEQ
 smjW5QJdLQT7qPasOaJTYYZVb4b30z9nyVtX3zFrBIzfUni+FBLFuwlkvT3QntqiPk3P0KQSMI36
 o=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We introduced a new function `qemu_plugin_register_vcpu_discon_cb` as
well as some types since v5.

Signed-off-by: Julian Ganz <neither@nut.email>

--

I should probably have included this in my patch series introducing the
register function in question instead of noticing that the API version
was not bumped with 10.2.0 after the fact.
---
 include/qemu/qemu-plugin.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 60de4fdd3f..b445c26389 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -72,11 +72,14 @@ typedef uint64_t qemu_plugin_id_t;
  * - added qemu_plugin_write_memory_hwaddr
  * - added qemu_plugin_write_register
  * - added qemu_plugin_translate_vaddr
+ *
+ * version 6:
+ * - qemu_plugin_register_vcpu_discon_cb
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 5
+#define QEMU_PLUGIN_VERSION 6
 
 /**
  * struct qemu_info_t - system information for plugins
-- 
2.51.2


