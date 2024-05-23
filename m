Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A7DC25B7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9x5-0000Gv-Mi; Thu, 23 May 2024 11:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9ws-00082T-M8
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wq-0004vX-VB
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N1Pn7vFXvHPKuSMjWiqdhpZacphlqMdCoJigV4EMHgs=;
 b=av0lIyjASPMUjPLJ8Eyu/7rPJpx4OqBrgnnceegxmJGKQAGyfCmmkl08Kpa+Ln1FyhECkn
 c+GsXsgAkn9zRmZmlWcdrzFU8uaACrKaUFoIpeeXxi3hXER1gX1z8buTL9qRSG8XFvGYJX
 FPVE5D7sEmDrI1CsG4m/CtcWvNTERbk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-g9D589kjPRSsJ5MD9jrcSA-1; Thu, 23 May 2024 11:01:35 -0400
X-MC-Unique: g9D589kjPRSsJ5MD9jrcSA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52389b09bb6so1078489e87.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476493; x=1717081293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1Pn7vFXvHPKuSMjWiqdhpZacphlqMdCoJigV4EMHgs=;
 b=l4pHrIjGg9NPIsa9L3KqBce8gYz67QjUTSs87M6zELlM2LoeOC/s7GbYQyIJ5aieJU
 dmU8rVXUJ20d8QM1We2xsEmYmiu1En/73k2S1xACkmbMe+ojC8r3vQjxTqCiEUfvh89k
 ln5SMEvsur+TSguIz4MYhZb1oA2JoaRPIJ5ZgMxmi2dEarIEAdXpUELQsT3daBQCSk5d
 aEsW2ZxSSDy+076Zfhtj7xaBmzKekDMBNtJA2NgeRU6N8axeSvDmsibNkekyXblbemJ5
 NfxHQ4ORGsJeGz62ql0kA/1H3mtptYMnIud3yZ8lDubvAn8Tuoe9ZPwUTzC3eoWaHER5
 j4uQ==
X-Gm-Message-State: AOJu0YwJVAkpGJyT1A/xAaykNVl7RVrNbrJ/yUUqEnH4wES74BA+8W4c
 piFE2qUje80xSwSljXqlRj4QRxPwo8BkmMe2S/OMnTUnZMgy7tudPxJ5CNLrJuTi3qUSZuZhod1
 8xGcGV3qfB+ncQVhJL6t3VQRE8c0eTSjJL9CFUcAGt/vhW5z04IDCyR/EXTmGdbeSvyULuGsoIb
 MZE2w/EvLI8iBKduJ6lCrgvyO3bdmdmVgZmzSZ
X-Received: by 2002:ac2:4831:0:b0:51d:a87e:27ec with SMTP id
 2adb3069b0e04-526bd6935camr3149314e87.9.1716476493169; 
 Thu, 23 May 2024 08:01:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWUvHz/WWG9n92xS9THX5XlIQgWnlW34CNhdGutSmy/oCptKLRru/5YxvHBMfmdMV5Q/2SjA==
X-Received: by 2002:ac2:4831:0:b0:51d:a87e:27ec with SMTP id
 2adb3069b0e04-526bd6935camr3149288e87.9.1716476492704; 
 Thu, 23 May 2024 08:01:32 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c2c7de4sm19809096a12.63.2024.05.23.08.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:01:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Babu Moger <babu.moger@amd.com>
Subject: [PULL 22/23] i386/cpu: Use CPUCacheInfo.share_level to encode
 CPUID[0x8000001D].EAX[bits 25:14]
Date: Thu, 23 May 2024 17:00:35 +0200
Message-ID: <20240523150036.1050011-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523150036.1050011-1-pbonzini@redhat.com>
References: <20240523150036.1050011-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

CPUID[0x8000001D].EAX[bits 25:14] NumSharingCache: number of logical
processors sharing cache.

The number of logical processors sharing this cache is
NumSharingCache + 1.

After cache models have topology information, we can use
CPUCacheInfo.share_level to decide which topology level to be encoded
into CPUID[0x8000001D].EAX[bits 25:14].

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Message-ID: <20240424154929.1487382-22-zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f91e1500266..bc2dceb647f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -478,20 +478,12 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
                                        uint32_t *eax, uint32_t *ebx,
                                        uint32_t *ecx, uint32_t *edx)
 {
-    uint32_t num_sharing_cache;
     assert(cache->size == cache->line_size * cache->associativity *
                           cache->partitions * cache->sets);
 
     *eax = CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
                (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
-
-    /* L3 is shared among multiple cores */
-    if (cache->level == 3) {
-        num_sharing_cache = 1 << apicid_die_offset(topo_info);
-    } else {
-        num_sharing_cache = 1 << apicid_core_offset(topo_info);
-    }
-    *eax |= (num_sharing_cache - 1) << 14;
+    *eax |= max_thread_ids_for_cache(topo_info, cache->share_level) << 14;
 
     assert(cache->line_size > 0);
     assert(cache->partitions > 0);
-- 
2.45.1


