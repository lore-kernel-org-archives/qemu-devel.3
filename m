Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3643C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu43-0001hG-D7; Sat, 22 Jun 2024 02:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3W-0000YE-2u
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3U-0006VM-Iy
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719037015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6kgcszkIT3GM5bTEqMS2S12kBtO09xKPPZC9hsjUhfM=;
 b=MaKxDaUPR3pz+J2B7MAA2/5k75RaahVBVNKV+Q0zLuVCKuKx2M8XgWyPCXAjj9ZkCLxIE0
 44bGN7Xe7vaE1u47npseMeIYZH4tpVt1wpiHJG/elJJXNZCDvLWBiA4Rm8slSvcPkVpriJ
 eZ7sbDR434xDFW0XtWkUpflCE8yCEtA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-4XOuxGkAMA-h0Edus5TUYQ-1; Sat, 22 Jun 2024 02:16:54 -0400
X-MC-Unique: 4XOuxGkAMA-h0Edus5TUYQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ec01fa1a72so21765631fa.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719037012; x=1719641812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6kgcszkIT3GM5bTEqMS2S12kBtO09xKPPZC9hsjUhfM=;
 b=J/ha6YMaLREQhkxs4+qfioMaChfwJywlfQScq98NZmSKXp82OI1Louj7qWMMRCVjFx
 gsG89x8RvVvtRkDIKd44u6AoYgvtw0TrWhrSxBZ7K5NYJlHc7XMSqP+odYMyxci1L3dc
 8MBVmiB0+pwPthEDv8cPX/idESmsYn+YfmS931guNJdTyHetW2Qj5c8R6CtrMe7Y2iEZ
 RWBNgIYS70srFhFJCBt+Ak/4s12skciLJMpMEDl2XbGBUsIDQJ1zuQTWilJyXP4CpG/O
 DmVtgxwpZ2pBg6s5CBTGkvi5e01mv7Kk+nGGIdEm01aFKy7XItpCrkXgMM3lo4DPBX5z
 aLpg==
X-Gm-Message-State: AOJu0YwarNBaysgpEqjlhGKMkIbbZCP0HJOS6K0qLB3MCv5oBE1+CWyx
 PoTIHxB+O0z/mJjcEJXOR2Tkf35aWPaNv2s8U2FLMOch09H7BZ+1QeF/dp74xsq3lOA0TPupt3i
 a8Kbx8mBJxEJGL7k0e3HUtVqnu4GA9R2PnToiL6ZiGQm2g0Pv8ZNGvEg6XK1c3evcciawOohluz
 1IFuyPz7PcDyNs4MTcyAvHgDAGl0mAgqyUEAI6
X-Received: by 2002:a2e:9cc6:0:b0:2eb:120c:1a59 with SMTP id
 38308e7fff4ca-2ec3cebac4cmr65032191fa.16.1719037011936; 
 Fri, 21 Jun 2024 23:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRHpGateCfynEPcimtoRhBKddgFfkGNYbKz7L76MZw+ekvh9BvIUWmyq5IOpdIrTVuUKetHw==
X-Received: by 2002:a2e:9cc6:0:b0:2eb:120c:1a59 with SMTP id
 38308e7fff4ca-2ec3cebac4cmr65032131fa.16.1719037011563; 
 Fri, 21 Jun 2024 23:16:51 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d30bd5f1asm1853019a12.37.2024.06.21.23.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:16:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roman Kiryanov <rkir@google.com>
Subject: [PULL 22/23] exec: avoid using C++ keywords in function parameters
Date: Sat, 22 Jun 2024 08:15:56 +0200
Message-ID: <20240622061558.530543-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622061558.530543-1-pbonzini@redhat.com>
References: <20240622061558.530543-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Roman Kiryanov <rkir@google.com>

to use the QEMU headers with a C++ compiler.

Signed-off-by: Roman Kiryanov <rkir@google.com>
Link: https://lore.kernel.org/r/20240618224553.878869-1-rkir@google.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 1be58f694c9..d7591a60d9f 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -945,7 +945,7 @@ struct MemoryListener {
      * the current transaction.
      */
     void (*log_start)(MemoryListener *listener, MemoryRegionSection *section,
-                      int old, int new);
+                      int old_val, int new_val);
 
     /**
      * @log_stop:
@@ -964,7 +964,7 @@ struct MemoryListener {
      * the current transaction.
      */
     void (*log_stop)(MemoryListener *listener, MemoryRegionSection *section,
-                     int old, int new);
+                     int old_val, int new_val);
 
     /**
      * @log_sync:
-- 
2.45.2


