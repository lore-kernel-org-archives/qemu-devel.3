Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637F7C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 23:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXUjs-0006CD-Nd; Tue, 06 Feb 2024 18:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXUjr-0006Bg-Sj
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:20:27 -0500
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXUji-0005jX-0a
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:20:26 -0500
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-46d2085eeebso31929137.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 15:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1707261614; x=1707866414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrAT5QHTNwGXU+/ed1LMaREV4iyygAJT3lqN0TCwnd0=;
 b=Qjrme7xm7Ify6xqaVdc18c0Vuvcl49GWbdwJfCXlBiCXbAFQluU5ibMU+1jE4WnVUj
 0eafi0lOeAb8Dz8J5/QGElLs/CCEdyJ2tVuMeV46qlXhfGFqdECyQ08AgvZiYxPY9Ht5
 /tdCN8piEHGNRX6My0j3RXF4Dg8+8SOs+6XfxIt1UX4rpwWn9eVrOGCYz1m+DH+XKJW8
 IopZVlHgJmEuK8XAuay5Am07KLzpjm/rGXyFuoF6nJKplb2bA413iOiouBUSS9drfjdG
 45gGlYUj6idUeSwjcBH4I7fj9MWphgUo2jtgHspKF6QZZ1i7r8MGHe0AWR8CGr0fWJlM
 9MTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707261614; x=1707866414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DrAT5QHTNwGXU+/ed1LMaREV4iyygAJT3lqN0TCwnd0=;
 b=Oopf04zKzan7RsgU7hJIGQ1TPJP5VnclbLycLYNs/UcTf3HOyzOdIQjaPTUkISwlFy
 nvPDkLNTpYcIGtQlfNZ47NTXu2AC0K0OONVZA6AlOTrp5LDViR91nUlGwS0av+2lK2Vl
 dVdHg1VumrERi2sYKFaePzkMEHGvHhW38/hNeOg4VPjN3X0tCdqEg0uBLK39tUyquI5e
 uc5cYKngVgACyMGkVkplihVCWwkjmrkRFoeBQirnz77y0pNjT1HEFl4LQ2FfSg3WiTLv
 JJNbpwcUvGB0yxv15+LTmDswecOCdY0Q05JKsGaLNWlCVEFnV1KjVJK7a3cluX3NfCY8
 R0wQ==
X-Gm-Message-State: AOJu0YxTQRAuK9y4nWLkzuOg+b+P5GQ/TQVlu6BcPi3EgGHzo+12bOoO
 EQBJSZg/UU5OIFBiof+94LtsXa7r5sJWozL60YvnvtdXKj5xKQYlqFE7CE4G6i7b1/35GVLp67m
 O30s=
X-Google-Smtp-Source: AGHT+IEYKbYmrDerRepghez/tsmqx8LZ8LICBCgYDAoqBFh8RN/pOstJoSSeYMrU0zuiX8enD0ogSg==
X-Received: by 2002:a05:6102:3706:b0:46d:1ffd:d87d with SMTP id
 s6-20020a056102370600b0046d1ffdd87dmr981364vst.17.1707261614260; 
 Tue, 06 Feb 2024 15:20:14 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUb2H7+cC7SgzsDo5R674bYxAQR2vIK5PRl2ku2EQla+6MGSesIuPeVZ0ZwrqwbLqMa6OgBprANwDES0x60uN6fb6ejaIuFY2W4pHye/y5xs+/O
Received: from n231-230-216.byted.org ([130.44.215.112])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a67b60b000000b0046d20ce8886sm2352vsm.1.2024.02.06.15.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 15:20:13 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: qemu-devel@nongnu.org,
	farosas@suse.de,
	peterx@redhat.com
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 2/6] migration/multifd: Add zero pages and zero bytes counter
 to migration status interface.
Date: Tue,  6 Feb 2024 23:19:04 +0000
Message-Id: <20240206231908.1792529-3-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240206231908.1792529-1-hao.xiang@bytedance.com>
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=hao.xiang@bytedance.com; helo=mail-vs1-xe36.google.com
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

This change extends the MigrationStatus interface to track zero pages
and zero bytes counter.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 qapi/migration.json | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index ff033a0344..69366fe3f4 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -63,6 +63,10 @@
 #     between 0 and @dirty-sync-count * @multifd-channels.  (since
 #     7.1)
 #
+# @zero: number of zero pages (since 9.0)
+#
+# @zero-bytes: number of zero bytes sent (since 9.0)
+#
 # Features:
 #
 # @deprecated: Member @skipped is always zero since 1.5.3
@@ -81,7 +85,8 @@
            'multifd-bytes': 'uint64', 'pages-per-second': 'uint64',
            'precopy-bytes': 'uint64', 'downtime-bytes': 'uint64',
            'postcopy-bytes': 'uint64',
-           'dirty-sync-missed-zero-copy': 'uint64' } }
+           'dirty-sync-missed-zero-copy': 'uint64',
+           'zero': 'int', 'zero-bytes': 'int' } }
 
 ##
 # @XBZRLECacheStats:
@@ -332,6 +337,8 @@
 #           "duplicate":123,
 #           "normal":123,
 #           "normal-bytes":123456,
+#           "zero":123,
+#           "zero-bytes":123456,
 #           "dirty-sync-count":15
 #         }
 #      }
@@ -358,6 +365,8 @@
 #             "duplicate":123,
 #             "normal":123,
 #             "normal-bytes":123456,
+#             "zero":123,
+#             "zero-bytes":123456,
 #             "dirty-sync-count":15
 #          }
 #       }
@@ -379,6 +388,8 @@
 #             "duplicate":123,
 #             "normal":123,
 #             "normal-bytes":123456,
+#             "zero":123,
+#             "zero-bytes":123456,
 #             "dirty-sync-count":15
 #          },
 #          "disk":{
@@ -405,6 +416,8 @@
 #             "duplicate":10,
 #             "normal":3333,
 #             "normal-bytes":3412992,
+#             "zero":3333,
+#             "zero-bytes":3412992,
 #             "dirty-sync-count":15
 #          },
 #          "xbzrle-cache":{
-- 
2.30.2


