Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D8D606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=COG+/+hG;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kjGfMb6g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIrzP-0006ph-L9; Mon, 19 Oct 2026 14:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryu-0006Vy-27
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryr-0005rh-GG
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792434064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M19r5WuxN7wvAW9brJF3ugoKQeVERy7dE+Mtvf+bc9c=;
 b=COG+/+hG6b67QVQOCTFLjv1xBXddLKu9pF3R9TXye8oAFihWnhFMeA5RpW6LbPny1idj+h
 Fr64yFme+tzcODjXuXVrAZFVJKSpsrdNiWvD3r4TpOeLFlMqyoCDZkXfn8LUkEym/fgYiK
 kZagHo9n07cUTsExTU/Sz24jTcl/Cfo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-y6aKPdtFPwqIGHRczOIKKQ-1; Mon, 19 Oct 2026 18:21:02 +0000
X-MC-Unique: y6aKPdtFPwqIGHRczOIKKQ-1
X-Mimecast-MFC-AGG-ID: y6aKPdtFPwqIGHRczOIKKQ_1792434061
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49953abe51fso18872685e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 11:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792434061; x=1793038861; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M19r5WuxN7wvAW9brJF3ugoKQeVERy7dE+Mtvf+bc9c=;
 b=kjGfMb6gISFb4J+5hmEmRaZeQJZU48YBQwW+mH9/c5U1bFbthhMcyKa4AhykdhiFJS
 ogIeHXTisQlq8A/T5QtN5n42LZJeoWxDxDH6pZwTVaHaeFLNKSuEBb5L80+bc9KjaBK8
 rHR16sTlWpk+8yO8fz/y0loCHZCVkNMcTmwJZwyUnJm6Tj0fviA1wYQFrlYYvby/Rm3O
 LBCwQUHSR7ISqT8OAIz00F62jOD8E7ZTevQDUKM2RRznsdPV/hM3uUBQYUhWSV8Nq3+r
 QzHS0hV/h8lBU5T4R7P5cE6RkhKREWvf4Yaafpzz9+3saulRXMoO8ZFGqFNiyItS7lBW
 v8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792434061; x=1793038861;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M19r5WuxN7wvAW9brJF3ugoKQeVERy7dE+Mtvf+bc9c=;
 b=hn8Th1T6NlBUPsex7BvGPHtv4mN3eoofb9VH/KSbQ1W/SqtPoK40qTkuCdOjjxu2gx
 pNygKuF6a/2l5MC3SJ/kXMZGDI/4kTycbKtaeYImhW7HYjyfy6cbCFtwpGqOFzkUDppG
 flwDZXFppB0d5Klgp/V1Tqh44ksVIKdNHm0C+pgKZwy6leXL8dY1bIj5KkJDXMpxE+2X
 jWKUrnE9TYbjfJbT+7zkFU3xk/cAi3O+Hi4DfRNCcKGFm0KIT1ojdkSQDFqOzl1/Pd/d
 LeyomSBzXQkDz7q8JnBhnFJjBfVWyJTzb0GdAaYWV99CLpl9HM9YjEYgJ3MCjMfDRQ11
 WQnw==
X-Gm-Message-State: AFq9FYIMdQwMrvVW+6EOLNb+lphEtXgTdL7UoPb6kGL6OMPp13jHFLLc
 UNUGfAihZS7ragJVX/cjzqG9X493CZL7XcclhhDglOqC+LrnXlHU9VR4zDthwLKCahU52V3L1kH
 qjI3ZMmE+l53kE399kBXOsj+0f7HCF9+Yledv1TSLWW1q19mc57cGdCxC
X-Gm-Gg: AYBFou318GanL39oBy4w/6zHOPRGMHmd1ClRCLidWncdwtnc6N5qjdmGmNFFkYdsCcr
 fHQDgeBlXBukJtWhfSVmN0Q8tM+GR8ADaPXt5h+yrBXHppDCpIAZ6qawxnyHgd/vQ4R41VbTdtK
 OL8XsxBIiNBkDT3GDoAl7Vt7KqPt9LXdUA8gmu9wktebdSKVO/c/kPQWhsZZCIe1OunCbDYHXuG
 fOw++Eem+dRVFZwEUhpimtYaHoUaw7s1DUddcnqLqgM1boGEwitHT+jZ2frtRWFNHfJBstPzng2
 op0g1cVOeGeS2x5EIYarKeKvcsV5pnbYmCDROCxOo7kaDS0gdMod0OCdtk02zh8dUDZ38ufTNAn
 neWdE3G0Nw1cBy6S6xvsOjqLLuqY3DAwH7rrt3tdqkLpv40No+fEogC5iKg==
X-Received: by 2002:a05:600c:8b6f:b0:4a1:cef3:fb3a with SMTP id
 5b1f17b1804b1-4a1d75f23e2mr161353435e9.9.1792434060656; 
 Mon, 19 Oct 2026 11:21:00 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6f:b0:4a1:cef3:fb3a with SMTP id
 5b1f17b1804b1-4a1d75f23e2mr161352935e9.9.1792434060145; 
 Mon, 19 Oct 2026 11:21:00 -0700 (PDT)
Received: from localhost
 (p200300cfd705ccf50633a9a8543b8b67.dip0.t-ipconnect.de.
 [2003:cf:d705:ccf5:633:a9a8:543b:8b67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cca30aa5sm12676305e9.2.2026.10.19.11.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 11:20:59 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 11/12] block: Add delay-report-ns and delay-stop-ns props
Date: Mon, 19 Oct 2026 20:20:27 +0200
Message-ID: <20261019182028.45305-12-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019182028.45305-1-hreitz@redhat.com>
References: <20261019182028.45305-1-hreitz@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These device properties allow setting up I/O latency thresholds for when
to report an I/O operation delay via QMP event (BLOCK_IO_DELAY) or when
to stop the VM.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/hw/block/block.h   |  8 +++-
 blockdev.c                 | 16 ++++++++
 hw/block/block.c           |  7 ++++
 tests/qemu-iotests/172.out | 76 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index df941df19f2..3edc33a0339 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -36,6 +36,8 @@ typedef struct BlockConf {
     BlockdevOnError werror;
     uint32_t num_stats_intervals;
     uint32_t *stats_intervals;
+    uint64_t delay_report_ns;
+    uint64_t delay_stop_ns;
 } BlockConf;
 
 static inline unsigned int get_physical_block_exp(BlockConf *conf)
@@ -83,7 +85,11 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
                             _conf.account_failed, ON_OFF_AUTO_AUTO),    \
     DEFINE_PROP_ARRAY("stats-intervals", _state,                        \
                      _conf.num_stats_intervals, _conf.stats_intervals,  \
-                     qdev_prop_uint32, uint32_t)
+                     qdev_prop_uint32, uint32_t),                       \
+    DEFINE_PROP_UINT64("delay-report-ns", _state, _conf.delay_report_ns,\
+                       0),                                              \
+    DEFINE_PROP_UINT64("delay-stop-ns", _state, _conf.delay_stop_ns,    \
+                       0)
 
 #define DEFINE_BLOCK_PROPERTIES(_state, _conf)                          \
     DEFINE_PROP_DRIVE("drive", _state, _conf.blk),                      \
diff --git a/blockdev.c b/blockdev.c
index 6e86c6262f9..90d94900645 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -496,6 +496,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
     BlockdevDetectZeroesOptions detect_zeroes =
         BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF;
     const char *throttling_group = NULL;
+    uint64_t delay_report_ns, delay_stop_ns;
 
     /* Check common options by copying from bs_opts to opts, all other options
      * stay in bs_opts for processing by bdrv_open(). */
@@ -580,6 +581,9 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
 
     read_only = qemu_opt_get_bool(opts, BDRV_OPT_READ_ONLY, false);
 
+    delay_report_ns = qemu_opt_get_number(opts, "delay-report-ns", 0);
+    delay_stop_ns = qemu_opt_get_number(opts, "delay-stop-ns", 0);
+
     /* init */
     if ((!file || !*file) && !qdict_size(bs_opts)) {
         BlockBackendRootState *blk_rs;
@@ -615,6 +619,8 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
         }
         bs = blk_bs(blk);
 
+        blk_set_delay_report_threshold(blk, delay_report_ns);
+        blk_set_delay_stop_threshold(blk, delay_stop_ns);
         bs->detect_zeroes = detect_zeroes;
 
         block_acct_setup(blk_get_stats(blk), account_invalid, account_failed,
@@ -3753,6 +3759,16 @@ QemuOptsList qemu_common_drive_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "whether to account for failed I/O operations "
                     "in the statistics",
+        },{
+            .name = "delay-report-ns",
+            .type = QEMU_OPT_NUMBER,
+            .help = "threshold in ns when to report an I/O operation "
+                    "delay via QMP event",
+        },{
+            .name = "delay-stop-ns",
+            .type = QEMU_OPT_NUMBER,
+            .help = "threshold in ns when to pause the VM because "
+                    "of an I/O operation delay",
         },
         { /* end of list */ }
     },
diff --git a/hw/block/block.c b/hw/block/block.c
index f187fa025d0..82d6f2e7980 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -249,6 +249,13 @@ bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
     blk_set_enable_write_cache(blk, wce);
     blk_set_on_error(blk, rerror, werror);
 
+    if (conf->delay_report_ns) {
+        blk_set_delay_report_threshold(blk, conf->delay_report_ns);
+    }
+    if (conf->delay_stop_ns) {
+        blk_set_delay_stop_threshold(blk, conf->delay_stop_ns);
+    }
+
     if (!block_acct_setup(blk_get_stats(blk), conf->account_invalid,
                           conf->account_failed, conf->stats_intervals,
                           conf->num_stats_intervals, errp)) {
diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index a023cd407de..97ba78a8d53 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -31,6 +31,8 @@ Testing:
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "288"
 
 
@@ -61,6 +63,8 @@ Testing: -fda TEST_DIR/t.qcow2
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -98,6 +102,8 @@ Testing: -fdb TEST_DIR/t.qcow2
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -113,6 +119,8 @@ Testing: -fdb TEST_DIR/t.qcow2
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "288"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -154,6 +162,8 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -169,6 +179,8 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -211,6 +223,8 @@ Testing: -fdb
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "288"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -226,6 +240,8 @@ Testing: -fdb
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "288"
 
 
@@ -256,6 +272,8 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -293,6 +311,8 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -308,6 +328,8 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "288"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -349,6 +371,8 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -364,6 +388,8 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -409,6 +435,8 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -446,6 +474,8 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -483,6 +513,8 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -498,6 +530,8 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -549,6 +583,8 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -564,6 +600,8 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -606,6 +644,8 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -621,6 +661,8 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -663,6 +705,8 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
@@ -678,6 +722,8 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -720,6 +766,8 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
@@ -735,6 +783,8 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -786,6 +836,8 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -801,6 +853,8 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -843,6 +897,8 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -858,6 +914,8 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -906,6 +964,8 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global floppy.drive=none0 -device
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -973,6 +1033,8 @@ Testing: -device floppy
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "288"
 
 Testing: -device floppy,drive-type=120
@@ -1000,6 +1062,8 @@ Testing: -device floppy,drive-type=120
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "120"
 
 Testing: -device floppy,drive-type=144
@@ -1027,6 +1091,8 @@ Testing: -device floppy,drive-type=144
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
 
 Testing: -device floppy,drive-type=288
@@ -1054,6 +1120,8 @@ Testing: -device floppy,drive-type=288
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "288"
 
 
@@ -1084,6 +1152,8 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "120"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -1121,6 +1191,8 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "288"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -1161,6 +1233,8 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,logical
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -1198,6 +1272,8 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physica
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-report-ns = 0 (0x0)
+                delay-stop-ns = 0 (0x0)
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
-- 
2.55.0


