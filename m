Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F207C5DF70
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 17:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvexg-0000JO-3q; Sun, 16 Aug 2026 13:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvexe-00009X-Ca
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:54 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvexc-0003DC-PR
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:54 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso28528265ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 10:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786902471; x=1787507271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u3GrUm1TBcvSPpyf6hmkJd1nY4lbRyzlWNa4cSw3wVA=;
 b=sOgYhwToriny31lZXMUwVzK/zV5qn6Nt5cxFpGKibcJOddNueXzEaQApOXFLZyvIBw
 OXyiTvhQvBANLd71djDhOyNls+BER8uk33oTO4SkDU2A9UZ669fyp2qBT4plHRvKgbtk
 GvxGcj/kuucA7oyWF9U+7yNEQqOfBsJi+NQ3wqSWJbmD6cxBX2++qZhZqxBjWWmO3T4W
 /vgD0XRRj2tDrO39ODtId5vEUX3Pac07jI76RJrVc1/CJsS4xggJqr7J/rtUMeokeAnF
 eUysxbIad2ZYyy6jiaDC/Fo0PTmpNN0HkEI6w6vaMc/rl0+sr9GoN8/TtOpbYL88pYaL
 Ei1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786902471; x=1787507271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u3GrUm1TBcvSPpyf6hmkJd1nY4lbRyzlWNa4cSw3wVA=;
 b=Xn7zhPig3dPA/I6FTVEXiTwVwkPQpuWKCpTfdoJsuLyvg4rFHf83ViWZN9G9TbqSzm
 823hhi8Ptar94m7LqmOXkIHigekPGPuD3J7AQKL2J3XyPMHmmX5xgapD2UGgJC/SnYMV
 gPArvrBAzmi4d2Hah5KWbi4BVYLQXDs/w/nmttkg1u3vqOnKlP5PGl2TLfmiAgT0iGcX
 v/y108o7G6AZttyx9J7Nzw48UOSVoHPO0c4KacmR8YD6/35OZDgWae1Me3IMQpSv9Uoe
 kQNPGYizXSEnbZDVTo3Oks8A51B844dURzDJNPTNOS/nwoY+Euu+BEmSWWThbxNtjMS4
 GPOg==
X-Gm-Message-State: AOJu0YxLR/aXhZz4inwsixDeuHaR3fveQRuPmlj5OozNJCoQYzg20feG
 dzybtM99OhoVwEjWEqUpwNMP0bp+4G54Aym82N/O8c8XTvPh43Iwmw2XKMKNng==
X-Gm-Gg: AR+sD10RGSL1ZbhVAoB6YPqc2Ni4Zwv60WekksULGDjhR3WB1S8MoooZYMEQlLwYl9r
 nD6tHqy4vP8cgFAc4xuiJMQxpD2c+2wQaNo6C0xOw/WmRJiqfaT9625CB9C52LYaUQzDtqniY1w
 B4RKWbtRjjCB5yQwvyxqDO6S17vmPFcCo/FRQJGTD9pUAplko0ulyVg2Dk3ePFpaSIERs29qqgA
 Twh19cj8+OJeCg/Vhai1CvtLhYMXEnTxloYy+AiFrhDqACWF/mH29Hv3nu2+RP6Zr4hnzcIB0YP
 dixorLrnDOyq6INHJYDmBVM74MiuxGaggqQu1iwjTj6ySSDmeSoiEBvTzQluSZ75IwtdOPF0uXm
 EXrM3RSR2soXEGbTbql1apeVSsaWCPfNQTF5/dueIxsVhd4N9icDlZKxzJZRdpgugBuMK3VuUzZ
 1EAG93j+eMQIIr54/YOTDl5Z9uCARr34vskc2/HcPcDDumXVQAqqWw1inN4pmm1bYLwFBF+GL18
 4VlJ6hgT/3bwpo=
X-Received: by 2002:a17:902:ce86:b0:2c8:f34c:82c0 with SMTP id
 d9443c01a7336-2d3b0aeeb6cmr200501005ad.2.1786902471338; 
 Sun, 16 Aug 2026 10:47:51 -0700 (PDT)
Received: from setun ([223.228.54.80]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320ead105a9sm28343674eec.31.2026.08.16.10.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 10:47:50 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v5 11/11] docs/migration: Add documentation for fast snapshot
 load feature
Date: Sun, 16 Aug 2026 23:16:31 +0530
Message-ID: <20260816174631.1547811-12-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816174631.1547811-1-aadeshveer07@gmail.com>
References: <20260816174631.1547811-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pl1-x62e.google.com
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
Reviewed-by: Peter Xu <peterx@redhat.com>
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


