Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0516FCAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 19:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3JEP-0007UQ-Ut; Mon, 29 Sep 2025 15:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3JEM-0007U3-EP
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 15:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3JEI-0004tb-EQ
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 15:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759172887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6i0nVanfDujpYn//cEXKWgfyzyv69/ASXLJkx8rKto=;
 b=QROChcx+fzImJMReQNHUqK+KRRyQeV5XBQPt0Dcx9C102KkXbZN7+CrisG8tieMbW6BC/q
 khXk64WwmfpqvnBH0Ak1eTuw4y2Ii69CisB2OwJ8y+Xgkl8aa5rAY0OC/4s70vtiCWGKOR
 qNno5c6Gzh/WuDFJ5d2ZZRlwNM4WofM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-0gdmSRkRMSWCYlefMJkh6A-1; Mon, 29 Sep 2025 15:08:06 -0400
X-MC-Unique: 0gdmSRkRMSWCYlefMJkh6A-1
X-Mimecast-MFC-AGG-ID: 0gdmSRkRMSWCYlefMJkh6A_1759172885
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-797ab35807eso125967646d6.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 12:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759172885; x=1759777685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V6i0nVanfDujpYn//cEXKWgfyzyv69/ASXLJkx8rKto=;
 b=UCStf1LmfU4YDlCbfbcDeHh6nL8mgBVhbnBeHufoTOQpg8dYb3m9BJXUY+SpUWWl4u
 XPv8cofA1EutkDRLw3+TEExoF6IxXaUr9gC882OnFM5N0MJZ/pZcO3GKGS1CUnFUAof1
 Gg9mdsVhAVfQ4JgjcwutlbrpbuivYfB77Z/vnBS+BXNqIFWORH2gRPz1tB8fa4G6/vmE
 3S+/If8MYZWqOcb7zfXKPvFR6OEKbFNdPHoDsi2kBXZOzyOVChWfXtkeOyVKW8WQIhe+
 NMdeWW5iEtwe68nUJnJPxlE5McSCKu96AcK6K4YefysC54/40Utmv/MWDKeswZYVaf6n
 4u+Q==
X-Gm-Message-State: AOJu0YytCTmT4pFacIncepAssvZo+DY9J0oYECt+tj1iPdt7kNrxMwDo
 mZEVry87Ap+dE7Jx9TR8XZjEAfhIv6MIGRn7XWT8lMPFWyRDC2WwycoJtaFXsBPN2jDAcUXvXD4
 TpU1pZ/iN8bz8rGWMZ7TIL+slq0CKF8CKh49iVzXMD+nsIV5kz2yUcZc4Vsd3mC1SblpwDz9KT/
 7o2M6mTMhNpvl7VbrMIym+jLzGZw9QgHtrX1MvtA==
X-Gm-Gg: ASbGnctlxVdL8J/iD6XT3yk+90WKNi0hZmqfqDUlSvwSjl252bxV4yMP8L+P2OuUAJB
 VzT/v88MY1q5iP+vD1xqr3T0tBGhGtVhmzQYTEcq0OXheHnJ1oCMaIFAfgJ8m4xOOxoPJotddT8
 gOxiWfLl6ClC8zBfRhBx5hD4uC6/RykuXR8XDWc+rUzMyD0nXmDnyomgPA7CZZNnDOlfaZw15nk
 KEAi27JRsdYKODa079JsppfZej65DLhkYtXyoJeqXh1rIJguXs8zuJIXHVXSoGwm07Tb7apMcIC
 7kAD250XCX6maNXT8RnjF04Rl0Olq/oF
X-Received: by 2002:a05:6214:d62:b0:80a:71ea:38df with SMTP id
 6a1803df08f44-80a71ea39b5mr208194666d6.43.1759172884853; 
 Mon, 29 Sep 2025 12:08:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE+64ikqAdcPFOFM810wShTDGO76ItxX0fewMNqlUu8SMb2QmHTD5iEbFZ53s6ShZPj9CQfg==
X-Received: by 2002:a05:6214:d62:b0:80a:71ea:38df with SMTP id
 6a1803df08f44-80a71ea39b5mr208194076d6.43.1759172884218; 
 Mon, 29 Sep 2025 12:08:04 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-80142f5d6d1sm79626296d6.33.2025.09.29.12.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 12:08:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>,
 peterx@redhat.com
Subject: [PATCH 1/3] qht: Zero-initialize qht_map
Date: Mon, 29 Sep 2025 15:07:59 -0400
Message-ID: <20250929190801.931989-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250929190801.931989-1-peterx@redhat.com>
References: <20250929190801.931989-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QEMU almost always do this across the tree except QHT.  This prepares for
rcu to track double free.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 util/qht.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/qht.c b/util/qht.c
index 208c2f4b32..872d9f9cec 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -441,7 +441,7 @@ static struct qht_map *qht_map_create(size_t n_buckets)
     struct qht_map *map;
     size_t i;
 
-    map = g_malloc(sizeof(*map));
+    map = g_malloc0(sizeof(*map));
     map->n_buckets = n_buckets;
 
     map->n_added_buckets = 0;
-- 
2.50.1


