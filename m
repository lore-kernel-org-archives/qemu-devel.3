Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7514CC55171
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 02:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpzcP-0002oZ-5E; Fri, 31 Jul 2026 22:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzc5-0002TW-9I
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:38:20 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzc3-0002a3-KX
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:38:13 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38e347638adso2033687a91.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 19:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785551890; x=1786156690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PNV42ycjQBrAbERsecIeez8mURVQ70RaMpJO6wcrDxo=;
 b=bvjwdgxZpizVudt3oHPHledYX/2EvvawqxiP8yiLdJxuTVDlKa0bdPuYd4Sv4R0dRf
 1rlUB+/a3eNUemmmBzDTQysUZ0SOpDMBMT76ZI96pWU2mgDVh0tYAEyZgLENwgJ3nBlm
 3WUAcwlnAPjnXI0Ltn1J05OW0JxAILd8aAi14xz9ZCP/AjTGvDuWWHBu9Lb8QJ6AAMz/
 DrQ/+tcP7v5QWPLqpPUgIKdftNwP8gIxCMqd+Tvg7O5lnOqFFLfq+n79ABEUn4iB0Jko
 HZ86yvyzOAxEfDHaHnBAQtGPsQI6m/PBV8GqWP5RJNtKSvgCz2iyDD70G4e0mGN5FYHF
 v8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785551890; x=1786156690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PNV42ycjQBrAbERsecIeez8mURVQ70RaMpJO6wcrDxo=;
 b=HipebkVA9y72SeC7NSshjbWnw7cLwMfTFlMrvbmmt+yz455nqb8cTYTsUsK1PzAWz/
 tD7LgsKMmm3ebeDWfBffxYpp9sbWIeAuo4mCrFw6iXPrcW3CTvHhmCZ75KSxz+wduDhI
 RrQpawxwEnADrdM/h+06rbZirTfbXevfdv7E6+L8kapii4Pud6n7FNUXCRh1Mblp9FA7
 OCb+8HGjaW7ygtugOwxtXD6J+6A4uuhp8QhPjgObaQutGfWVkdyNRLWxxhmMbPi/453x
 WuQgGqU6EAWJEuZ3hGiv9P54PZJ9jPWR8JJK3UE4TIRDep9NpBR5nx5jHV6PW/Lrm3U0
 4mgw==
X-Gm-Message-State: AOJu0YzcdKk/ZVGq2hmYpOO7IWy15sPUOP5sqyJCCzE0a9bbP0FVyFie
 W5AKP+EBFjb4YHLee4jqUlzjV9rWN1DAvZLvTUsNVrGuj/Tx6HXCeZ//Tnmvrw==
X-Gm-Gg: AR+sD11qhNMrH0f/xdzuZgaXvAZO3Y+WWRPtgCebDjn8JlS3jTu4yHSi1fQYWwavOjl
 ioZAePX081lyVb5J/Grn9Q+93ETeF2G49hKb01JMSFeGyrH3onHgf7rLWEVzArSImHx8Wku9IKH
 jAKBuu4TmqhG3V/P0QENiEAznaHEVdDympy82xvMGJ17Mvv9h1V1cECs1PfCCkXW0TEZTbdxOxl
 A5QVuU8CWH41Z4NcwgtQFk5rCfVXYkmKBEWpCvalT0cK/SVF2VAMZx46/qFDAAUaygLmkGsRuUz
 4V3RBPTMZb2xBYbFBhzB6jl5GRt3KVKfNr0zXkiLvQrN/1O9VNiog7NosRiAYPbJHlov9voYlgR
 osmvBR63YtHQZtb5bMY8tpW9hAApL2kpNGbncVob3+puPSQskYCWiuZnkWOYwRjww/p05/iZtUc
 B3Hn+CqQ7LC4rIUveI0YlK/z3hrC9sF0+iuF0nDeeqe0GAEYmTH6Nn5QK7tKkFfzaMZ+9i3OTap
 ssUpfNefszKDuSS
X-Received: by 2002:a17:90b:5403:b0:38d:b36e:9813 with SMTP id
 98e67ed59e1d1-38fbc434501mr1955779a91.11.1785551890293; 
 Fri, 31 Jul 2026 19:38:10 -0700 (PDT)
Received: from setun ([223.228.61.127]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e47dsm15678889eec.3.2026.07.31.19.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 19:38:09 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v4 11/11] docs/migration: Add documentation for fast snapshot
 load feature
Date: Sat,  1 Aug 2026 08:06:28 +0530
Message-ID: <20260801023628.22665-12-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801023628.22665-1-aadeshveer07@gmail.com>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pj1-x102f.google.com
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
 docs/devel/migration/fast-snapshot-load.rst | 82 +++++++++++++++++++++
 docs/devel/migration/features.rst           |  1 +
 2 files changed, 83 insertions(+)
 create mode 100644 docs/devel/migration/fast-snapshot-load.rst

diff --git a/docs/devel/migration/fast-snapshot-load.rst b/docs/devel/migration/fast-snapshot-load.rst
new file mode 100644
index 0000000000..fe2361d6fe
--- /dev/null
+++ b/docs/devel/migration/fast-snapshot-load.rst
@@ -0,0 +1,82 @@
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
+to load in only the required device states and allows RAM pages to
+be loaded after the guest starts execution. The idea is to start the
+guest and serve its page faults on the go, reducing the perceived
+resume time for large snapshots.
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


