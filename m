Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86559C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKFJ-000451-SZ; Tue, 06 May 2025 11:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFF-0003v2-04
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFC-0002Bw-5a
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9vSwA81SihvCRaCKXFvFqvfbb/E9O4HmkXwtQOqDzbM=;
 b=Qh2KSiOFOKC3yQwcRfk+P4TKxTGCppm5Whw2DLsMJEMs0KTEd/COG2p9YUITOqWFXIeEJt
 XvUqJnpzS0xqXFrMUNZMGHGC6zhDDRCpLyyr2EvBCWRH5gOg+12RyJdqMnfSwDPpCHXnDz
 e3jlr1Wf4GG2X7XdzsUcgYOhNmGk7kI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-7YM5T6r4N8iQSR6bUbqPxw-1; Tue, 06 May 2025 11:30:04 -0400
X-MC-Unique: 7YM5T6r4N8iQSR6bUbqPxw-1
X-Mimecast-MFC-AGG-ID: 7YM5T6r4N8iQSR6bUbqPxw_1746545403
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf446681cso34071135e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545402; x=1747150202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9vSwA81SihvCRaCKXFvFqvfbb/E9O4HmkXwtQOqDzbM=;
 b=TQzhAnI/+UcfSlMfzT98Wi3K0TCEeRPN31S59UMeTqkbC1cqcCIKwbh7fj0TnP3bt3
 ypgUVsaG4/xiic24Aj65fvJpTQ+Nwx4AOutZlzNRVivfQmtiQ6gExL/Il+VW1sw+ewwh
 69rHn2YlnCf3vgb7QVz5/ajR2ZnXJn40PQFE+0Ml8GwQ/lV4UUnCU6XYynZLFkZJRVEM
 mOMbkZBEzyWZ1gp4u0Zr5xp8CdY942obnzheHmjOsxTUhwrHu3Kil4BxLO90gH0aD1EK
 wYiXfW500GEfiI2w4TuvcEbfnAyZzYA3ApLf53C7CBJuQfyh1Pe1Rs0cfpQePu9Mzmhr
 5tHw==
X-Gm-Message-State: AOJu0YyYe0POzUW41eiZC2EV1tzUNLwv+Rm9UgdkNjOcXOdF/GOLY/LQ
 61j0qfx+HADmXlo/4XjUxYSxp8ZpbwL42fmwRJhwjqiNfBI50Pcmv+gawuot/QKwfyoOURlcaM1
 yBpN/G5Ju/pgHmAKXT4pjjfeGlfZlGNEYQoIMzVjOluGsARLWOTpyf1Y300P4oncC8KE3Vi5V0e
 tac/WzDoqJdhf1p0RDYdmBYW5n47yfhmycXyR/
X-Gm-Gg: ASbGncv6hhK6cER5xlsD3yL7T0abd06NTRRnV2O8Ok52m0jkWYeM4gJtiE0x4mF3Woh
 rda58fkdESl9438KlYDvEioxcMCmGWgOnoPQ06pbfdcOzm/pcHG0OxYlvZuMxhleB6pYlBlbDvh
 KYcH3ewRAgCQaA250x3MJwGYVmBB9Nb6RbGpjHeBVYzd9MHVjLg9WoOF1zfeNXP35v08vqUjvkN
 5kLHnHROjhclwqtWYCeCiV+ZThMT7THAhW2YyN6vUcIV0ghraZOTjV94zfqUbCK+DaH6geN7p0Y
 B9Dz4a5SNrrZEmM=
X-Received: by 2002:a05:600c:8419:b0:43d:db5:7af8 with SMTP id
 5b1f17b1804b1-441c49237c7mr95730745e9.21.1746545402298; 
 Tue, 06 May 2025 08:30:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsSj0CvmZ1L7+6M5xyZzR/YBrM73Onn3dY/HKTsX7hFhP3tinZQGgbNWwrFiHBQbuYJo/3jQ==
X-Received: by 2002:a05:600c:8419:b0:43d:db5:7af8 with SMTP id
 5b1f17b1804b1-441c49237c7mr95730535e9.21.1746545401879; 
 Tue, 06 May 2025 08:30:01 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2af4546sm221953435e9.22.2025.05.06.08.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:29:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: [PULL 16/30] target/arm/helper.c: Fix type conflict of GLib function
 pointers
Date: Tue,  6 May 2025 17:29:11 +0200
Message-ID: <20250506152927.222671-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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
Link: https://lore.kernel.org/r/7d56c82382e8b4f1694b6d7883b2ce3084fdc72d.1745820062.git.ktokunaga.mail@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7fb6e886306..c7ff9f657ca 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -222,7 +222,7 @@ static void count_cpreg(gpointer key, gpointer opaque)
     }
 }
 
-static gint cpreg_key_compare(gconstpointer a, gconstpointer b)
+static gint cpreg_key_compare(gconstpointer a, gconstpointer b, gpointer d)
 {
     uint64_t aidx = cpreg_to_kvm_id((uintptr_t)a);
     uint64_t bidx = cpreg_to_kvm_id((uintptr_t)b);
@@ -246,7 +246,7 @@ void init_cpreg_list(ARMCPU *cpu)
     int arraylen;
 
     keys = g_hash_table_get_keys(cpu->cp_regs);
-    keys = g_list_sort(keys, cpreg_key_compare);
+    keys = g_list_sort_with_data(keys, cpreg_key_compare, NULL);
 
     cpu->cpreg_array_len = 0;
 
-- 
2.49.0


