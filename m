Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B782C88E7F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6QF3-0003QO-BZ; Tue, 15 Sep 2026 06:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6QF1-0003QA-Hj
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:18:19 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6QEb-0003Bq-SH
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:18:18 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99dso78473a91.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 03:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789467470; x=1790072270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l5YVe05pjG97AGrI1ym/t5dZv++HeTZWtnHCxE2pueI=;
 b=VRWXaJ2Jp3af4lm0bt2mB1n9CBJ4rnKS5WUlWToTQMhPRDNnFBwxvLCWp2yxFhFDEk
 iiJWCpe3sEJhtyBzpCjj+6vePVZfn10L15ABClplEzTpeaE1TLAdOn+grGDNfOdvKNWT
 r8rpVM1vXgIkbLL58bK/FxC+jTbgDfN+8nF3/gZP3dlyk+LwD/JgV+J9EILNbiaqlhcg
 XqF8Y/qnT2duUKvFKruPgBDqD1s2+c7zhs7MEIb4rsxPmdqC9HLuut4/dq+nh67TjF6V
 Qxh8XXqDEnkoDhbf8Et6VKjCdXO7zstZluqaM661IaqOiciG2+N4EYaNx+9GC1dOFmf+
 P5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789467470; x=1790072270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l5YVe05pjG97AGrI1ym/t5dZv++HeTZWtnHCxE2pueI=;
 b=i3vPRhAoQPswoR6/Izcaik3thsd23dcO9zLTz0v/0jTE0lM4SZ3ap+RV/RXPVtXKhd
 y/8QVvvw6j9k3yGfLc1R2dY1X1qZK1VOlC6ZXviKD3l+E0pMuNFmRo5nm+Mii8hkD0nW
 GKN86RNPACB8oZ1riyaCqN3tN6JbmwyAryuRTbNOs94nx58yy1BLLhXd+iz4GO2wmm/I
 ZVj2p05iC5oe5gTO0cU4kPdTeiXOMwrqb84UEXFBHMjQTpV0Oo7eKPUWADJXyeHYjCSI
 sKH6cpuv40uhdusRvkFaZ5GyKV7YDEqG60pqOiUCCIL9ngY8QIwBclEmm9x6OSkzhlZC
 0oeg==
X-Gm-Message-State: AFuF++m/QgJIxiZ2s2DNatx/l+o9FHJcQPgG1mTzHRsmtOThY824PshF
 6e9OcEMNeQTmvTrUIIs2Cos4jOCxp80HP80hrOdgsInrJ0Zll+fG7ZAneR4/Wg==
X-Gm-Gg: AYBFou2zvwrSkbnyNJZ2hUtjsE3L9aY8CjwmbN6I9xTISeNY9e7YJgSDt7rM6IIFcRb
 asyRVTDD9XfkNnN226Ix1eNxCPL3KgdNYI/26ziAUeP9ImqXsSdDl2Mzls2pnqzxz+OK/kurLWN
 eza+H1wSJ6Fw7mDO7TGCMZhqFh9i5BAq7ESXHeSGvxydpdx7RIDcqRAoGL++Ez01G5UJJpddyP1
 eVwwEqSrepqlM985KsJHhmrjbFE5TuXIEyEHG5QYFzUZF3hEGc44q9iEzDdxicFPQX+VW/jZJNr
 dpKG/QJhirKAI7CklonsqLdbMxgnOhZfns10aYN1XxLtZnU6lQnQeHsPyobe41uO9aEZr4hGaWr
 sc9IJhFHd7j8NujKLKrArSPenfKfF0lNw4TmdYh8yeod8dRmWADgBJWP9O/J/vKhOG4soA7nbhh
 Np91Pu8P0asunjjikIx8cFs9v3gu5DqDFytQeenf9WwK4HIPAE+fi9De3CxSpGaf35WeZfWAisX
 t5+LzIGrFlKYdsFLQvRZbnyNck=
X-Received: by 2002:a17:90b:1d49:b0:398:deed:6e1d with SMTP id
 98e67ed59e1d1-39e10ce0123mr487016a91.5.1789467470275; 
 Tue, 15 Sep 2026 03:17:50 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdacba6bsm4416868a91.14.2026.09.15.03.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 03:17:49 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V17 11/13] monitor/hmp: display IOThread holders
Date: Tue, 15 Sep 2026 18:16:53 +0800
Message-ID: <20260915101655.3216101-12-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915101655.3216101-1-zhangckid@gmail.com>
References: <20260915101655.3216101-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=zhangckid@gmail.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Display holder information in info iothreads to aid manual debugging.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/hmp-cmds.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 91701ddf33..d7dd24d951 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -246,11 +246,31 @@ void hmp_info_iothreads(MonitorHMP *hmp, const QDict *qdict)
     IOThreadInfoList *info_list = qmp_query_iothreads(NULL);
     IOThreadInfoList *info;
     IOThreadInfo *value;
+    IOThreadHolderList *h;
 
     for (info = info_list; info; info = info->next) {
         value = info->value;
         monitor_hmp_printf(hmp, "%s:\n", value->id);
         monitor_hmp_printf(hmp, "  thread_id=%" PRId64 "\n", value->thread_id);
+        monitor_hmp_printf(hmp, "  holders=");
+        for (h = value->holders; h; h = h->next) {
+            IOThreadHolder *holder = h->value;
+
+            switch (holder->type) {
+            case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
+                monitor_hmp_printf(hmp, "[block-export: %s]",
+                                   holder->u.block_export.export_id);
+                break;
+            case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
+                monitor_hmp_printf(hmp, "[qom-path: %s]",
+                                   holder->u.qom_object.qom_path);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        }
+        monitor_hmp_printf(hmp, "\n");
+
         monitor_hmp_printf(hmp, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
         monitor_hmp_printf(hmp, "  poll-grow=%" PRId64 "\n", value->poll_grow);
         monitor_hmp_printf(hmp, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);
-- 
2.43.0


