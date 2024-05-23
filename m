Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26B3C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 17:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sACZJ-0006TU-AB; Thu, 23 May 2024 13:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sACYx-000658-5J
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:49:12 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sACYo-0003ig-Ph
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:49:08 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f32a3b9491so15563855ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716486540; x=1717091340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Py+IWCEA+58Br6wfdzxyAKl2e4AQZdRZm/N5DBOTD9w=;
 b=eh33dUjNM5vdXPrae62VbQonypdE7oR+ZSh1/RqhunUzsyyu/QQEtWnhlnbOIEgjiE
 WgfzEQJLGd6FhzazsPRKuKkrb0ch9GPbd5DJBCqqmMLmj1jTWtlGee9ZL4dMq3OO98Vy
 h0HQN9Kdij/+lBun3Ouqhl95gAuEjGIzwwYm1Oe5ZUBZB1lnJs7MkLb0H5S6EQ8AByN5
 WiQ5OfvkNaEI59aTSgx8sbtKuqG1ZaYMdIDFix9zy+osvStt6dFuUDWx1ej1WOXTRe6j
 nulvLje2oryP7OevYUupifoqo0S2beTKTPDO+NAHkWT9jb38f92cumQsQaT5OfteCz2Y
 vMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716486540; x=1717091340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Py+IWCEA+58Br6wfdzxyAKl2e4AQZdRZm/N5DBOTD9w=;
 b=mAndAxNWa/nqa9bQpaLR3dAkGfoRXQgFEPUOB0a+xQrx9iqp8X/1BZmTyVa3FXEeEw
 TKEw3Wx4mfd8Of0k6vz32hvUbwbKCUlzl9TqTioUJZsfhrDdKMPeK8lcokpaqAtlNLGg
 yTf0Vv92RtpepGQvWmY4oQqzO3jE7SuCkBJGrXrfFaOXaG74l/kWNKsGv+BiOLQGZEy3
 RjlMLYRwOh887SDWDcstdq2dTgzbONbSWmt5QJYoIhG/3XmhvBKOCyJlryNFGbLMf+y4
 SZGDO6Uoy+gj5unZIpHgJ3BJT1AGl9aWUbsoqLZkZVs1Ty9x51DkNT8om6/rrOs7Ghgs
 HZVg==
X-Gm-Message-State: AOJu0YwQFCNa6FGZKummYmHUj8zJqgZ00mUMQet03/RTP0ayY79qaLfH
 ifZnHXz8yhFziiBMVHUh0atuCJnkWmNzhjR/ObsmvYJNPlO0pRaZqliXRA==
X-Google-Smtp-Source: AGHT+IGUU65s+ThjrpW2GkGrCtHEGF5MHJn9d7jgIeQXnhn8qdEYnubOYSC43+E2eDUvC9354XVJ6A==
X-Received: by 2002:a17:902:f9cb:b0:1f3:4bb7:5e16 with SMTP id
 d9443c01a7336-1f44873387bmr600065ad.32.1716486540365; 
 Thu, 23 May 2024 10:49:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 10:49:00 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, armbru@redhat.com, mst@redhat.com,
 Fan Ni <fan.ni@samsung.com>, Svetly Todorov <svetly.todorov@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 14/14] hw/mem/cxl_type3: Allow to release extent superset
 in QMP interface
Date: Thu, 23 May 2024 10:44:54 -0700
Message-ID: <20240523174651.1089554-15-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523174651.1089554-1-nifan.cxl@gmail.com>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x629.google.com
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

Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 60cbaa9bb6..284db94182 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1946,7 +1946,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
                            "cannot release extent with pending DPA range");
                 return;
             }
-            if (!cxl_extents_contains_dpa_range(&dcd->dc.extents, dpa, len)) {
+            if (!ct3_test_region_block_backed(dcd, dpa, len)) {
                 error_setg(errp,
                            "cannot release extent with non-existing DPA range");
                 return;
-- 
2.43.0


