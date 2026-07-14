Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF1EC44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjdxD-0007AU-2b; Tue, 14 Jul 2026 10:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwy-0006gQ-Lu
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:17:33 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdww-0002fq-RU
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:17:32 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so3023016a91.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784038649; x=1784643449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PqcGrgmKaIPs+t/tbnDgVo9n56qGlWCzwPaKeCT0WGA=;
 b=lobb+ABQjyXq8+S1hXA6tu5Z7NHMxUHwQKeEgqAhpW0+ecbHiItHF5vs7ZUaXcbBLF
 xD+1SyCaG8/9TO+dXbPAVQUB3GQNfqzWkAyK4oS5rc27XUIQrctt11Iv7scUxlcuOBWT
 YgzAZdiZBj6nstJIflP2CaplGjEDZbZtj/S0buY/L8kD14gnI4vPYSyT7xgpva9TRt9k
 RCah1bj9d7c6nwTVPG61vxVQDKuCab3eiHHNDj8aY8TcpfTzq8Ak2/JrNwcEkCvAk6GT
 HM78at/13ZWa/AjzuY6NUxcf8U6IKneVgRpyQpwRZGn/szbnwS91WkpFc329rstjVJhN
 IGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784038649; x=1784643449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PqcGrgmKaIPs+t/tbnDgVo9n56qGlWCzwPaKeCT0WGA=;
 b=DjY12wvhhjruhk6160kJAMx9jLLcUPlLeBKpc3UjAarmIaPYaHiYm2yfK5AlvM6DCb
 UDQR7566dtz2YzKe3xkiaN4d7WMj98zQxm7dFc64vg2E/CHyCEgNkzOh1bQrntrAKe61
 uFGXtjPyxSqXf0Vym/5434jbQAmkwNtm1P0YpOC52hWxGZ71DPMzSMj18mj6518xYYBz
 Nb3ShoTmOxazBQZTvaAAC3VabDgl5wLPWOHLo0YIcX2kLRy9NVggeX9Fb58RflTL8qfn
 /Y5E6fW+dp/GR59Cv+sfWEc4Sgyf1wuVHy7SfyKngPspifyMMvngZn4ng0vLoCCgA/+I
 dwhg==
X-Gm-Message-State: AOJu0Yzc4Dpcb7C9rKsdAJV5ExpJdZOEn4h2t9xm6v7S1h990AxBwfp2
 UFp0LhAxTgQDqx2th+3S45YkYgDbQ1LAvqR/TPdPBqH4uc77j/Y6bYOi+dh8S/xs
X-Gm-Gg: AfdE7cleRc2Lfusq4imlJrI2wR/nxxXr7Eyha54mVT+svKGt4BYpqBBshKk9DakAN+v
 qnR7Hok7Q6JhM0uvXBZEEix0znj7eJY2RjDRH5xuQZfjGyrCLXIaahB0u4UP2T9+p2w4ARMzJid
 UaAHSfPEkB8j07vJnewJfCiY+3HjyJORvwgskVZA8QPe6URrcH3XhCq3wJAo7wozH6pY38ua36w
 AF+1rUgGAJQARh2RP3mfvloX3nLhL4sm4pE802fsek6YECzVqFS8OBThVvE3r19TaGmd3rIdA2S
 tNTVfhh9N5z/ZENQx57AeIFuThwJ5yMmhc2epLTqGuuKpwbv1bJepLWoTT3Ss73kVCG9TSZph+1
 4dWMFyeU5QDtMpcR4OLbvqRup97lgFDRqEUISFZhowgNrIJjL5INgI7UjtIodG7nYhuIc01hFB8
 ywD6iC48eomNTSx3Np6NQ4eMCxVGeE0ZHFbK8pcpRsNQ==
X-Received: by 2002:a17:90b:2e47:b0:35f:b6a1:8d27 with SMTP id
 98e67ed59e1d1-38e1af04765mr2489114a91.18.1784038649337; 
 Tue, 14 Jul 2026 07:17:29 -0700 (PDT)
Received: from setun ([2405:201:502b:3014:cc0c:536:1b1e:6def])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm97329733eec.14.2026.07.14.07.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 07:17:28 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v3 11/11] docs/migration: Add documentation for fast snapshot
 load feature
Date: Tue, 14 Jul 2026 19:45:47 +0530
Message-ID: <20260714141547.1268000-12-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714141547.1268000-1-aadeshveer07@gmail.com>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add documenatation for fast snapshot load covering an overview, the
architecture, usage and limitations.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 docs/devel/migration/fast-snapshot-load.rst | 81 +++++++++++++++++++++
 docs/devel/migration/features.rst           |  1 +
 2 files changed, 82 insertions(+)
 create mode 100644 docs/devel/migration/fast-snapshot-load.rst

diff --git a/docs/devel/migration/fast-snapshot-load.rst b/docs/devel/migration/fast-snapshot-load.rst
new file mode 100644
index 0000000000..0c0dc676fb
--- /dev/null
+++ b/docs/devel/migration/fast-snapshot-load.rst
@@ -0,0 +1,81 @@
+==================
+Fast Snapshot Load
+==================
+
+Overview
+========
+Fast snapshot load is an extension of the postcopy migration feature
+to disk loads.
+
+Unlike a usual snapshot load, which requires all VM data (RAM as well
+as device states) to be loaded into host RAM from the snapshot file
+for the guest to run, fast snapshot load uses postcopy infrastructure
+to load in only the required device states and load RAM pages on
+demand. The idea is to start the guest and serve its page faults on
+the go, reducing the perceived resume time for large snapshots.
+
+Architecture
+============
+This feature combines postcopy migration and mapped-ram capabilities
+to load RAM pages on demand. It is done by catching guest faults using
+Linux ``userfaultfd`` and loading the page by calculating the offset
+of its location in the snapshot file using mapped-ram capabilities.
+
+Fault Thread
+------------
+The fault thread uses Linux ``userfaultfd`` to catch page faults caused
+by guest and directly load the page from the snapshot file. It is
+very similar to network postcopy fault thread, with primary difference
+being it loads pages directly by reading from the snapshot file.
+
+Eager Thread
+------------
+Eager thread iterates over all pages in RAM and loads each page not
+yet loaded by fault thread. It is required as unlike network postcopy
+where majority of RAM has already been loaded via precopy, here entire
+RAM is waiting to be loaded. If there is no eager loading thread each
+page will only be loaded when it is required by guest. In case there
+are some background pages that are never/rarely accessed by guest,
+the system will be locked in migration state indefinitely.
+
+Synchronization
+---------------
+In order to make sure both of these threads do not load the same page
+twice potentially overwriting and corrupting user RAM, a bitmap is
+used (``RAMBlock->pending_bmap``) which tracks the pages claimed to
+be loaded by threads. This prevents race condition when one thread
+is loading the page and other one tries to do the same.
+
+Usage
+=====
+
+Simply enable ``mapped-ram`` and ``postcopy-ram`` capabilities on
+the destination:
+
+.. code-block:: text
+
+    migrate_set_capability mapped-ram on
+    migrate_set_capability postcopy-ram on
+
+Use a ``file:`` URI for migration:
+
+.. code-block:: text
+
+    migrate_incoming file:/path/to/snapshot/file
+
+Limitations
+===========
+
+ - Multifd
+    Fast snapshot load is currently incompatible with ``multifd``
+    capability. While ``mapped-ram`` allows for parallel disk I/O,
+    coupling it with ``postcopy`` capability requires additional
+    infrastructure.
+
+ - Host OS support
+    Because this feautre essentially depends on ``userfaultfd``
+    to trap page faults, it is supported only on Linux hosts.
+
+ - vhost-user
+    Fast snapshot load does not currently support ``vhost-user``
+    backends.
diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
index 9aef79e7fa..23c2a93173 100644
--- a/docs/devel/migration/features.rst
+++ b/docs/devel/migration/features.rst
@@ -11,6 +11,7 @@ Migration has plenty of features to support different use cases.
    vfio
    virtio
    mapped-ram
+   fast-snapshot-load
    CPR
    qpl-compression
    uadk-compression
-- 
2.55.0


