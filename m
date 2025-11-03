Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479FDCCFA09
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 08:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFprf-0000wN-7s; Mon, 03 Nov 2025 03:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vFprS-0000vK-J6
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:24:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vFprF-0006k9-G0
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762158246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gp/+LkqJWGH4mhyeKJTlMe+UyDNiB1tC+xILd7IMXWg=;
 b=gMhNRX94W3p/CoCkMc/SawPssgqpZnyCCyJAFz5V0t9XESm5D8aJ6RKA5fkAEOGp95fUo7
 AnCXD0xN0Zl/O1OhB8OHWwsXIwlnEqSUaaYayM5oCs7pnBdNmrewY/UmnLgZloaht0fNtj
 txNpWGz4HLjGMx8fD/FqagkjF1cbtRI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-wYl7koQdMFanNBYbilBxhA-1; Mon,
 03 Nov 2025 03:24:03 -0500
X-MC-Unique: wYl7koQdMFanNBYbilBxhA-1
X-Mimecast-MFC-AGG-ID: wYl7koQdMFanNBYbilBxhA_1762158242
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE464195606E; Mon,  3 Nov 2025 08:24:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 620D71800452; Mon,  3 Nov 2025 08:24:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 17EF321E6779; Mon, 03 Nov 2025 09:23:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, vsementsov@yandex-team.ru,
 thuth@redhat.com, berrange@redhat.com, philmd@linaro.org,
 kchamart@redhat.com, mst@redhat.com, sgarzare@redhat.com
Subject: [PATCH v2 8/9] docs/interop/firmware: Literal block markup
Date: Mon,  3 Nov 2025 09:23:53 +0100
Message-ID: <20251103082354.3273027-9-armbru@redhat.com>
In-Reply-To: <20251103082354.3273027-1-armbru@redhat.com>
References: <20251103082354.3273027-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

A few doc comments show command line snippets.  The snippets are
indented, which is legible enough.  Actually formatting these with
Sphinx would fail with "Unexpected indentation", though.  We don't so
far.  Add suitable markup anyway.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 docs/interop/firmware.json | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 7ffa7697e4..da0362a2c0 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -308,12 +308,19 @@
 #     indicates whether there will be an associated NVRAM template
 #     present.  The preferred corresponding QEMU command line options
 #     are
+#
+#     ::
+#
 #         -drive if=none,id=pflash0,readonly=on,file=@executable.@filename,format=@executable.@format
 #         -machine pflash0=pflash0
+#
 #     or equivalent -blockdev instead of -drive.  When @mode is
 #     @combined the executable must be cloned before use and
 #     configured with readonly=off.  With QEMU versions older than
 #     4.0, you have to use
+#
+#     ::
+#
 #         -drive if=pflash,unit=0,readonly=on,file=@executable.@filename,format=@executable.@format
 #
 # @nvram-template: Identifies the NVRAM template compatible with
@@ -326,10 +333,17 @@
 #     typically used for persistently storing the non-volatile UEFI
 #     variables of a virtual machine definition.  The preferred
 #     corresponding QEMU command line options are
+#
+#     ::
+#
 #         -drive if=none,id=pflash1,readonly=off,file=FILENAME_OF_PRIVATE_NVRAM_FILE,format=@nvram-template.@format
 #         -machine pflash1=pflash1
+#
 #     or equivalent -blockdev instead of -drive.  With QEMU versions
 #     older than 4.0, you have to use
+#
+#     ::
+#
 #         -drive if=pflash,unit=1,readonly=off,file=FILENAME_OF_PRIVATE_NVRAM_FILE,format=@nvram-template.@format
 #
 # Since: 3.0
-- 
2.49.0


