Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B510C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKFj-0004fZ-E2; Tue, 06 May 2025 11:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFJ-000455-JX
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFH-0002Cl-GD
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SfA/pb9Vrh0ctp/tNBaKwjaEFs5nICEyXk70PoakLy0=;
 b=SpwGwW1BRaAsZpWZrAvGUtYP/X5XVaVuR2lGCP/UUf/sUV56bs1v3Eh4mF2v9QIRe9yTUi
 xv7W5OBZxXK5O6MjFNNoIHJ0s5nP1aPIq++xQHSFidqkyrxRiY8RIayNSb4SOFG9W+U752
 jno3riL2DyKpRUtvpprpXgFS/QYGPDo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-MTY3zlduPy--Wvk9SwKxxg-1; Tue, 06 May 2025 11:30:08 -0400
X-MC-Unique: MTY3zlduPy--Wvk9SwKxxg-1
X-Mimecast-MFC-AGG-ID: MTY3zlduPy--Wvk9SwKxxg_1746545408
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a07a7b4298so2960980f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545407; x=1747150207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SfA/pb9Vrh0ctp/tNBaKwjaEFs5nICEyXk70PoakLy0=;
 b=qEKR0dF+0i9tHmvLtF6GOGdbh9/gqdIZg8PkDHiTkPsA7gzQIM1Nlrb7OQAXkRNpv2
 7Rf+CKBCFYT2kccESY7LqFlb8gJ95Szzg2XUFktcqG4qt+m8LVTNFLdZUVAvUwX2SJZj
 z5j5X6eochAGAGsvRqUtBGGMf2nHRvWBvTimwRTOxEgs5CcFsrCLf3FD4QjSRk0rKIpz
 bCNs1y4M05rCj4jQ1tKvxnRbNFK2w9jdCVMm+I/qXd3Q/E4Q57eLcdkzgbKexJ3P9TYQ
 SGKEvNOdrK6MG/ZoWyXLBX43UDoI/lFioIOFW/ZxZDx6rsK+4mojV2Kq8M5MhW9Y3CHe
 8rKw==
X-Gm-Message-State: AOJu0Yw2o9QCGYi2OaeRNxVRBSmj4oV2eEy3M9OK1No0/78hTFtQ9zRi
 4plR/2TiFpWJKJxwtcVHfYMKDsolKsVCCDKC6Uf7Er+22sbf5XQI2f0ydCF7R3H/rxk+LoRHfqv
 zuqHO5DRGABBKqJXYUMB6ve88e7zlVCgRjd3XR759z8XqD/B/ogOyTb+5xMN5XH5ajHwZ/pDC8c
 tpXUStiODqWFroA0N8xCwnlStMIB56P2BRIhEh
X-Gm-Gg: ASbGnctXFhhvYutZdbVookmTFcPQg4bcUzNaZA0XYdgBTu/TNg/Lk45ZKFbKZr9l89P
 N2zYtAnUbXhH+dGusP3INsNvDhBWl3mLyUa8gDjeWTMWmreEqp5FZUHWrxbFu4XRVI5cu55e/yU
 ccpVtdltS7R5Qxn8j2r2fwdeqTtzifgHT3z7lYdMJDXy86zNE5C2QIlNS7jRyyyNur6VVD8t+So
 /73Zt5/LtBXc3d8z1dVaNHLr89gk7ui/G4A0k2l2l7F1z3qQKSaj0j3uWrSyX8rvfV/dc1XKuTF
 +pJDNRKAqB+C5RM=
X-Received: by 2002:a5d:64cb:0:b0:3a0:8331:3380 with SMTP id
 ffacd0b85a97d-3a0ac0cb0damr2632298f8f.8.1746545407244; 
 Tue, 06 May 2025 08:30:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkLIP+ON78/RNW8/+M2HkGSkZ/mDg7+xgUBsfITnTwxKSu5mi/QxkbE/cKUwzm4jguAX6Lkg==
X-Received: by 2002:a5d:64cb:0:b0:3a0:8331:3380 with SMTP id
 ffacd0b85a97d-3a0ac0cb0damr2632276f8f.8.1746545406822; 
 Tue, 06 May 2025 08:30:06 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0b2c4a84csm1117268f8f.42.2025.05.06.08.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:30:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: [PULL 18/30] target/ppc: Fix type conflict of GLib function pointers
Date: Tue,  6 May 2025 17:29:13 +0200
Message-ID: <20250506152927.222671-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

On Emscripten, function pointer casts can result in runtime failures due to
strict function signature checks. This affects the use of g_list_sort and
g_slist_sort, which internally perform function pointer casts that are not
supported by Emscripten. To avoid these issues, g_list_sort_with_data and
g_slist_sort_with_data should be used instead, as they do not rely on
function pointer casting.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Link: https://lore.kernel.org/r/d917055d35f5ff7316ccdcbdf57af9a7bd85bf29.1745820062.git.ktokunaga.mail@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b0973b6df95..09a8d4ff721 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7115,7 +7115,7 @@ PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
 }
 
 /* Sort by PVR, ordering special case "host" last. */
-static gint ppc_cpu_list_compare(gconstpointer a, gconstpointer b)
+static gint ppc_cpu_list_compare(gconstpointer a, gconstpointer b, gpointer d)
 {
     ObjectClass *oc_a = (ObjectClass *)a;
     ObjectClass *oc_b = (ObjectClass *)b;
@@ -7183,7 +7183,7 @@ static void ppc_cpu_list(void)
 
     qemu_printf("Available CPUs:\n");
     list = object_class_get_list(TYPE_POWERPC_CPU, false);
-    list = g_slist_sort(list, ppc_cpu_list_compare);
+    list = g_slist_sort_with_data(list, ppc_cpu_list_compare, NULL);
     g_slist_foreach(list, ppc_cpu_list_entry, NULL);
     g_slist_free(list);
 
-- 
2.49.0


