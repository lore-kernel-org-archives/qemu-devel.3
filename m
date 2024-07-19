Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44908C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 07:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUiBL-00005w-95; Fri, 19 Jul 2024 03:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUiBJ-0008TB-KE
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:37:33 -0400
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUiBG-0002jy-Dp
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:37:33 -0400
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1721374648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XECesZ7DByLgWIc7w1r9c4McfNivtaSHbdOqaxbWuSk=;
 b=hwXpoQ407Oz+6RNilkbOf/556GVFQBUQMN2WLLujw2FN9POlKdl3x7CHWvT80HFH4FiY8J
 0n5EXrQsrzjF50TLy6cZM7y7iMaHzdW732pg9OR3mFt9SHWaSmiBPNLY3SSnHnbGmsfiDv
 veVzchwpo+bvTN7grjiRoumUL+FamhvxxDH1kXPUnWH6MbRHN3nBYOZzG0xz1NXCtAqk7S
 LirMPX0IsZIHto3KNmDy9bYu6N7VK4rFwKlJ2BmNf0IXSai+QYfVlmvlkutXMiaL2AMj4X
 vGfSfD94PywNFL1VlsOZMdQPMWkGznqeqX7QeAtrz4W2AXkLcnuNb+k4lZ7PCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1721374648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XECesZ7DByLgWIc7w1r9c4McfNivtaSHbdOqaxbWuSk=;
 b=79B2ZanTBnXFayu9ixtmLf6v3UUXloo8P29Pzl1f6sxYeFvrnNSnEED4/HUN9PNt9jwN3w
 /DhIXTS2KJBmdVAA==
Date: Fri, 19 Jul 2024 09:37:24 +0200
Subject: [PATCH v6 3/4] docs/interop/firmware.json: convert "Example" section
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240719-qapi-firmware-json-v6-3-c2e3de390b58@linutronix.de>
References: <20240719-qapi-firmware-json-v6-0-c2e3de390b58@linutronix.de>
In-Reply-To: <20240719-qapi-firmware-json-v6-0-c2e3de390b58@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721374646; l=835;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=M9V+m3AdmPGhAZNpMoYKV6vdkIe/MC+Bq+LGRyceM6Q=;
 b=B7XjsY4EdDYWHX1KggR9RKYg7TWie4jPEBFDFfQhZz9m8rnauFvzy2g8fKOXJPdcLR68gUutC
 /SQBATcibCtAlDGODCcLhkWwQACF+maLLUPkKva0/a46Ej5W8Wvhfj/
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Received-SPF: pass client-ip=193.142.43.55; envelope-from=t-8ch@linutronix.de;
 helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since commit 3c5f6114d9ff ("qapi: remove "Example" doc section")
the "Example" section is not valid anymore.
It has been replaced by the "qmp-example" directive.

This was not detected earlier as firmware.json was not validated.
As this validation is about to be added, adapt firmware.json.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 docs/interop/firmware.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index ae4179994479..57f55f6c5455 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -470,7 +470,7 @@
 #
 # Since: 3.0
 #
-# Examples:
+# .. qmp-example::
 #
 #     {
 #         "description": "SeaBIOS",

-- 
2.45.2


