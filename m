Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85A6C54E60
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 20:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlxaE-0002D3-Ux; Sun, 17 Mar 2024 16:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaD-0002C3-4a
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaB-0002a1-G7
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710709094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYUowG+n3GNsgXqb2DaoNPh3LIqkGmyhv13NH0L54Fw=;
 b=MeVV0+E4GmKZtzbuSkqAWyaScAkaBJGGeJRKFaopTblM+3qwW7NExS1YAqWuBV9I8IKqqM
 QohaZ1Rufwr0LN1qM5+vD2bzkLHM3VD2n8TtE95nBZ/BzLrnNfHnZ3xPBDIj/s3cY921cz
 oNCuj3itES+WizW5su6bCZ9X7DLvrq0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-VIVV1DZ1NwS9VYbWReMSyg-1; Sun, 17 Mar 2024 16:58:12 -0400
X-MC-Unique: VIVV1DZ1NwS9VYbWReMSyg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-42f30752eb4so12381271cf.1
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 13:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710709092; x=1711313892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XYUowG+n3GNsgXqb2DaoNPh3LIqkGmyhv13NH0L54Fw=;
 b=NygyC4QlYAvFDARBi/Vz2rsJ6ubVMcYK5MR267ro83kWHX2upCERF1S61rqGj3jwEf
 tjpkeRqi+ZzIuEsuPO8qHBfTE4Eg/OAbnHf3kmXHeTm1kcAYwSCAqhUmE/H4Yuw4N75R
 /RUrkLgWpRK9Y3hdOmyu+4u2Pa/SdFGL/ZBAPIQDuDjGONojprkJ6CAEHIGsAS/CgKTp
 7CHSo+Wl5UtlNZOnxkZPeVWWy/BFtoi5l/8oGM3JLs9YbTzFxDMFRtog6ZUPEUgHNUBn
 zzB4FpYtVYeP6gaBlIJhu6TmCAH7tMcMOeViSLF4JnwjTmddxNReYxzFrgXtDt5E/q4F
 Wcjw==
X-Gm-Message-State: AOJu0YwykcfxljpqLR0gYke9OZyVwCP53tBQFkMvlnAgr2NtaohrUT3f
 a+tBU3cF0oM8YuRiPg85xI5harIwyoFz6Vs21l2mHLPKtxkmU/GHa4ZlPHJdxfvEUIEIAH0QPkc
 eAVepXTO3WHdRazAexeMSYaegrwFUmHuBRRTsjT8yZ3QUwTF2Emb5g/ZSVxHI5hD3PhGtPta73x
 BPUApeKEKHZZk4C/plpgKQmh/Nm7s/OyOFtA==
X-Received: by 2002:a05:6214:3d9a:b0:691:456f:415a with SMTP id
 om26-20020a0562143d9a00b00691456f415amr12266596qvb.4.1710709091702; 
 Sun, 17 Mar 2024 13:58:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZSJinvIUlCV+HoP3OhPxtYoNF8P+oixWGF4tk64l5jNNcKe4wk1uiJ8DcIQYEPd311LE8PA==
X-Received: by 2002:a05:6214:3d9a:b0:691:456f:415a with SMTP id
 om26-20020a0562143d9a00b00691456f415amr12266577qvb.4.1710709091248; 
 Sun, 17 Mar 2024 13:58:11 -0700 (PDT)
Received: from x1n.. ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ed8-20020ad44ea8000000b00691879d7a50sm2391566qvb.115.2024.03.17.13.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 13:58:10 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/10] physmem: Expose tlb_reset_dirty_range_all()
Date: Sun, 17 Mar 2024 16:57:56 -0400
Message-ID: <20240317205803.361163-4-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317205803.361163-1-peterx@redhat.com>
References: <20240317205803.361163-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In order to call tlb_reset_dirty_range_all() outside of
system/physmem.c, expose its prototype.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20240312201458.79532-2-philmd@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/exec-all.h | 1 +
 system/physmem.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index ce36bb10d4..3e53501691 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -655,6 +655,7 @@ static inline void mmap_unlock(void) {}
 
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
 void tlb_set_dirty(CPUState *cpu, vaddr addr);
+void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
 
 MemoryRegionSection *
 address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
diff --git a/system/physmem.c b/system/physmem.c
index 6cfb7a80ab..5441480ff0 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -819,7 +819,7 @@ found:
     return block;
 }
 
-static void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length)
+void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length)
 {
     CPUState *cpu;
     ram_addr_t start1;
-- 
2.44.0


