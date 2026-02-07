Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2CDEE0ADC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 12:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voh8n-0007GH-LH; Sat, 07 Feb 2026 07:10:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1voh8i-0007Fa-NM
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:10:17 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1voh8g-000387-PU
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:10:16 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35621aa8c7fso132187a91.2
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 04:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770466213; x=1771071013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRvq4zI7MIK6rCqCt35/LJLjg5NnaBCJ0/CBYvfVPw8=;
 b=O6yL/A9C80lt4wDTjHRHZ8sOiHWXKCmm02XLO57mhcYwDqlmz/JPOwiJ0SXf7Qi2gF
 /7siuQZEh/duC7j5Gh9swRf7qfcClam8nU6oRQrN4eC5dlCVDJL9451SdmdZHzVJywhL
 faxbO2vWbqdpf/lkhi03QVyzaV7Gh2BmvQWgQoPxII7jt2ZOSifOJBfC8Hv7ecxpOaVZ
 Ds/hMKYJyHLaZBFf855aCyAswhiyywUfQR3Ci5ns9Nd2s2B5mqDX1oBE/fGH4NCL6Kq6
 Ky31r3jMjoiZsPCwbrE67tGrnf65YA6hMbvH8D82RHJJo2DMyZLQMnardvZvQdjwZtQ+
 UQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770466213; x=1771071013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yRvq4zI7MIK6rCqCt35/LJLjg5NnaBCJ0/CBYvfVPw8=;
 b=reRhcDEEcoQEVKBbQU79tAz9oqE1BfUPfziHyilWwBWzWeQUptblrqdcGgABKeEhT1
 GW/BHdGpII9/43nUsvrSSK09ycCSfNkoKfaRZuPLiwUszCWwGyGZh56BshArcTD/ahxF
 /M4POsU9C7G49eYNgQnzRo0h0UVaKv0jvYBnUJmegIl2Mal419ufhEE3dIBj4TDSiA4e
 AIHFWIoL9ngdfEnrpG8Z4MXylPMvIgD6lbLrCTpYs9wlDP08qHt+zxSq8HTOVKx+Y64z
 Lv/6PeQ822MhAe2pihZZuflHI0P/MMX2CHHjYAhnFXlRVQLm5HagZ1/F+aQ6YLi96t96
 WJfg==
X-Gm-Message-State: AOJu0Ywt/LHvtkvrTTA6rS2i00WmWb0atzIVpHkk4X0tvO0GMhqCHAhO
 Ih4bnFp7f84h3NhmYH4VE/l0EZVsYvE1vwSqq0JuZ8AHwMJ/tNVDRGaG
X-Gm-Gg: AZuq6aKFtLnw3/h4qdxPUBuCb//UZa0leR/qIj30yTW+zE8rCPBYm9pxJPRVP1gSnCF
 BBxZ6hbW3wxm839VYAMfvflXA6GZK6tBACbb2WsHKOtrVaHI22/lGgza37fNhiuVeM7XwPpkqUF
 cuJcQOJwkPP7IPviAyuOYfivCBzYNo7Wo3AB/0dG1bnZBNcwgeoqrVUDJUUedG3qcez0Tg831ZS
 1t2EqLXTxS2OQ5J8f0nmofStNYUVYESl/Eowe8h4/Jb4Y1EVcF0KL0JVURFtTCDwzkC0XGVxSJg
 hPVQLnxmbxBAkDZH5YD59QumpgubuBwIpbow6MQ/tuE+26q5lTiB0Oaq13Znlj13lwDw/vcd2q+
 f5pjcbk78+5lTAoTV1zxM81ajQnC/ZGi9Anbio47QSSyGWD3dfX1cReTXJWgWaPnHEql28gUrHV
 x2E+gjCmoI62uBw5MX1TXKxD1/A1dBRM9o/Tzi
X-Received: by 2002:a17:90b:3945:b0:356:1edc:b64 with SMTP id
 98e67ed59e1d1-3561edc1183mr1148725a91.8.1770466212791; 
 Sat, 07 Feb 2026 04:10:12 -0800 (PST)
Received: from brian.. (n058152022104.netvigator.com. [58.152.22.104])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b30f899csm2178530a91.3.2026.02.07.04.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 04:10:12 -0800 (PST)
From: Brian Song <hibriansong@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hibriansong@gmail.com, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 stefanha@redhat.com, fam@euphon.net, bernd@bsbernd.com
Subject: [Patch v4 6/7] fuse: add 'io-uring' option
Date: Sat,  7 Feb 2026 20:09:00 +0800
Message-ID: <20260207120901.17222-7-hibriansong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260207120901.17222-1-hibriansong@gmail.com>
References: <20260207120901.17222-1-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=hibriansong@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch adds a new storage export option for storage-export-daemon
to enable FUSE-over-io_uring via 'io-uring=on|off' (default: off).

The initialization phase performs a protocol handshake via the legacy
/dev/fuse interface before transitioning to the io_uring mode.
If multiple IOThreads are configured, the export distributes the uring
queues to handle requests concurrently.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Brian Song <hibriansong@gmail.com>
---
 block/export/fuse.c                  | 3 +--
 docs/tools/qemu-storage-daemon.rst   | 7 +++++--
 qapi/block-export.json               | 5 ++++-
 storage-daemon/qemu-storage-daemon.c | 1 +
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index abae83041b..09642ccf5a 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -587,8 +587,7 @@ static int fuse_export_create(BlockExport *blk_exp,
     assert(blk_exp_args->type == BLOCK_EXPORT_TYPE_FUSE);

 #ifdef CONFIG_LINUX_IO_URING
-    /* TODO Add FUSE-over-io_uring Option */
-    exp->is_uring = false;
+    exp->is_uring = args->io_uring;
     exp->uring_queue_depth = FUSE_DEFAULT_URING_QUEUE_DEPTH;
 #else
     if (args->io_uring) {
diff --git a/docs/tools/qemu-storage-daemon.rst b/docs/tools/qemu-storage-daemon.rst
index 35ab2d7807..ad0f41a78f 100644
--- a/docs/tools/qemu-storage-daemon.rst
+++ b/docs/tools/qemu-storage-daemon.rst
@@ -78,7 +78,7 @@ Standard options:
 .. option:: --export [type=]nbd,id=<id>,node-name=<node-name>[,name=<export-name>][,writable=on|off][,bitmap=<name>]
   --export [type=]vhost-user-blk,id=<id>,node-name=<node-name>,addr.type=unix,addr.path=<socket-path>[,writable=on|off][,logical-block-size=<block-size>][,num-queues=<num-queues>]
   --export [type=]vhost-user-blk,id=<id>,node-name=<node-name>,addr.type=fd,addr.str=<fd>[,writable=on|off][,logical-block-size=<block-size>][,num-queues=<num-queues>]
-  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>[,growable=on|off][,writable=on|off][,allow-other=on|off|auto]
+  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>[,growable=on|off][,writable=on|off][,allow-other=on|off|auto][,io-uring=on|off]
   --export [type=]vduse-blk,id=<id>,node-name=<node-name>,name=<vduse-name>[,writable=on|off][,num-queues=<num-queues>][,queue-size=<queue-size>][,logical-block-size=<block-size>][,serial=<serial-number>]

   is a block export definition. ``node-name`` is the block node that should be
@@ -111,7 +111,10 @@ Standard options:
   that enabling this option as a non-root user requires enabling the
   user_allow_other option in the global fuse.conf configuration file.  Setting
   ``allow-other`` to auto (the default) will try enabling this option, and on
-  error fall back to disabling it.
+  error fall back to disabling it. Once ``io-uring`` is enabled (off by default),
+  the FUSE-over-io_uring-related settings will be initialized to bypass the
+  traditional /dev/fuse communication mechanism and instead use io_uring to
+  handle FUSE operations.

   The ``vduse-blk`` export type takes a ``name`` (must be unique across the host)
   to create the VDUSE device.
diff --git a/qapi/block-export.json b/qapi/block-export.json
index 9ae703ad01..37f2fc47e2 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -184,12 +184,15 @@
 #     mount the export with allow_other, and if that fails, try again
 #     without.  (since 6.1; default: auto)
 #
+# @io-uring: Use FUSE-over-io-uring.  (since 10.2; default: false)
+#
 # Since: 6.0
 ##
 { 'struct': 'BlockExportOptionsFuse',
   'data': { 'mountpoint': 'str',
             '*growable': 'bool',
-            '*allow-other': 'FuseExportAllowOther' },
+            '*allow-other': 'FuseExportAllowOther',
+            '*io-uring': 'bool' },
   'if': 'CONFIG_FUSE' }

 ##
diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index eb72561358..0cd4cd2b58 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -107,6 +107,7 @@ static void help(void)
 #ifdef CONFIG_FUSE
 "  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>\n"
 "           [,growable=on|off][,writable=on|off][,allow-other=on|off|auto]\n"
+"           [,io-uring=on|off]"
 "                         export the specified block node over FUSE\n"
 "\n"
 #endif /* CONFIG_FUSE */
--
2.43.0


