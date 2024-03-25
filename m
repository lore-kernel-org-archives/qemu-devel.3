Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56281C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 19:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ropdN-0001p8-RJ; Mon, 25 Mar 2024 15:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ropd7-0001aE-Oi
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:05:16 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ropd5-00051F-Rt
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:05:09 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e6aaa2f02cso2888087b3a.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 12:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711393506; x=1711998306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3xErw1D7pd0Oy+zBQHAytaYYoPYpk9Jd+HPJGbw/j8=;
 b=NXJ2Ne3wZR/lpP8NaQGH9wJPkXHAiBUutW6vIEBRDFKDWthdk0HFHGnS5VQocVunxQ
 ydXFHIPVQg/cwkVjv9aguararA07J0MXVg/SfwtPRHN823+3+zBljWgN8Tp72H++lWFV
 7h59R1dg7erWBVM5pImGeiDwQSZ+F3gViHIXYbykCWbWvgB1C3tuoE7bQ2Ymo1WF8rpV
 HwGklJQjMKAS56TADJ95SDO+N7opL3pyRdk+Xd9wUogySiD8HAbC4t2J0KlJXjlqGaqj
 NwVtN7uS0Fhw4iUwIepYfA3cGvRmdOATOcOE4oENNxecPDVw2SlyUmYmLUOkR0qRIYHx
 bt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711393506; x=1711998306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3xErw1D7pd0Oy+zBQHAytaYYoPYpk9Jd+HPJGbw/j8=;
 b=kd3MX0Co9oUUPPPOx7se2xVTxsYCtPFlPqFneQOmV1qnQoKd7lYngUW8Ed0U52l0U8
 AdGy1V8fjjhQ7YuI2to9/P/oOSnOEkNlPHVeWbJD6keZ90f+5ogZ/rL2KzPd4XVu+xv3
 6g1q+L5fXy7BjZqToAumaBQQqS6HkMeplD2pSbfQzQcCkG6vAr6tv57ekpXRLoeiv2q/
 /G4LJ+CUbsVqCyKALJYRxqkTNzGE6A0Qhfj+Oz/ywx7AyTmnpqN3vsA16Vec3HCqvsCu
 TYaxE3lEopaa9PfOY/ErXwMfJ8d3oIoVOJ4/DluobKb884uYAiKvlI/imeudIfiv3KqK
 Y0nw==
X-Gm-Message-State: AOJu0Yyub0s9C2jdfui6YnmNx5oSXbPXpvtJybDQFLdDSGQLwj+w3unr
 X0uffq9RqJ44FRiJ8iDgDy16TkBNPmc+FBlXXT+ZOJmyhVZrT/hTTNi/Rmxm
X-Google-Smtp-Source: AGHT+IGAoTYpamTa5d5OnaOZK4Ce1M2BOIOF3MtObyKz38nf/HynrGLAJSbsZFdb3lLdMdbSuUH8OA==
X-Received: by 2002:a05:6a20:12d5:b0:1a3:647b:b895 with SMTP id
 v21-20020a056a2012d500b001a3647bb895mr8351996pzg.47.1711393506060; 
 Mon, 25 Mar 2024 12:05:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:7bed:2ef:bead:18b])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a634c07000000b005f05c9ee8d3sm1722663pga.93.2024.03.25.12.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 12:05:05 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v6 12/12] hw/mem/cxl_type3: Allow to release extent superset
 in QMP interface
Date: Mon, 25 Mar 2024 12:02:30 -0700
Message-ID: <20240325190339.696686-13-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325190339.696686-1-nifan.cxl@gmail.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Fan Ni <fan.ni@samsung.com>

Before the change, the QMP interface used for add/release DC extents
only allows to release an extent whose DPA range is contained by a single
accepted extent in the device.

With the change, we relax the constraints.  As long as the DPA range of
the extent is covered by accepted extents, we allow the release.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 2628a6f50f..62c2022477 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1935,8 +1935,7 @@ static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
                            "cannot release extent with pending DPA range");
                 return;
             }
-            if (!cxl_extents_contains_dpa_range(&dcd->dc.extents,
-                                                dpa, len)) {
+            if (!ct3_test_region_block_backed(dcd, dpa, len)) {
                 error_setg(errp,
                            "cannot release extent with non-existing DPA range");
                 return;
-- 
2.43.0


