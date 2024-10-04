Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC30CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlGC-0005W0-3g; Fri, 04 Oct 2024 12:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlG7-0004jR-Ks
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlG5-00066Q-Ti
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUXOLixf54/Phpgl1bLqDDS7TZylxbd8N1kxNtuKv2s=;
 b=AcIF0AntI16NzRUjX/eOsh9RppQAv9oRQdqo3HjaHxJro+Eknd7HJcUetMgn8O777GqHLk
 EzglIrO+LyRcDbzVgrDyOoTWY29ZQGioCPXoxO5XFmg3YVnO9RGBhL3OjYBm2nKW3IPQRu
 O0QSIRYYKWncXNvr9vUJQtdu8d1SRIg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527---KYKEBQNUGgaixaPnpcpQ-1; Fri, 04 Oct 2024 12:34:24 -0400
X-MC-Unique: --KYKEBQNUGgaixaPnpcpQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb635b108so15828705e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059662; x=1728664462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gUXOLixf54/Phpgl1bLqDDS7TZylxbd8N1kxNtuKv2s=;
 b=DvtTT9LPVgjYsOl93qCOuManzDCUcfTkGrhnlzJ/ocDFi94YVkhuahmkJ1kWA/YNDi
 XacXL9xBBbRxZlo4SpdXEIElBJkCjJRMinFMVmVu2D7wf/yY3+Gmv2YxlCk/291dNuwW
 Z07zWmmZBY/Fp2ipkPjGHoB6S5oTrkjNq+TcqURyKRm1q8j8JMbXqG0W8LOLRV1BH2oS
 Zd0UzZDjb5ccHqf9Phzsd6nLuTLjXTqPc9pyKt8UoKacxQnbi9icndv36r4PbnyYxyzh
 twZlGs5LoWo4N7wOf6IhMYOC/qRebQR9km6BfkQG/4NW3wcyZSPf5DsVSKTGkVXd5Fpe
 731Q==
X-Gm-Message-State: AOJu0Yz51zlj0SxCAcqLDH3hUgLtwPbOMkq9iCcJCcgJxfGMAbv0V6pJ
 4hFBor9txce7/mC81NWiFa95qs2BVGpOZ4VSYveX5fivKpiXSbFswaMjtJAP1flPMoEUpgBPYES
 859OYOWZGx/nNQwGzRaIdieO4fsiHN/xNxPAK70MYz9AU2FTkCtn4PRrQBH0rN8r4IKT+LoteLG
 9Csw5h2d06UP2c96jhKIFeI8M2Zj2EMJ9rUG4AD/4=
X-Received: by 2002:a05:600c:19c6:b0:42f:8515:e47d with SMTP id
 5b1f17b1804b1-42f85ab68femr26865725e9.11.1728059662440; 
 Fri, 04 Oct 2024 09:34:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPJd52gdJpiVPDM77fyImR7BVciNpcbGpdeHcj90FBsrO9t6PfIvqSBP0CJH77WRqij9RSng==
X-Received: by 2002:a05:600c:19c6:b0:42f:8515:e47d with SMTP id
 5b1f17b1804b1-42f85ab68femr26865515e9.11.1728059661948; 
 Fri, 04 Oct 2024 09:34:21 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86b4a38bsm19419185e9.39.2024.10.04.09.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:34:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Xin Li (Intel)" <xin@zytor.com>
Subject: [PULL 01/23] target/i386: Delete duplicated macro definition
 CR4_FRED_MASK
Date: Fri,  4 Oct 2024 18:33:53 +0200
Message-ID: <20241004163415.951106-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
References: <20241004163415.951106-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: "Xin Li (Intel)" <xin@zytor.com>

Macro CR4_FRED_MASK is defined twice, delete one.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Link: https://lore.kernel.org/r/20240807081813.735158-2-xin@zytor.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 14edd57a37b..2bf37dd15e0 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -267,12 +267,6 @@ typedef enum X86Seg {
 #define CR4_FRED_MASK   0
 #endif
 
-#ifdef TARGET_X86_64
-#define CR4_FRED_MASK   (1ULL << 32)
-#else
-#define CR4_FRED_MASK   0
-#endif
-
 #define CR4_RESERVED_MASK \
 (~(target_ulong)(CR4_VME_MASK | CR4_PVI_MASK | CR4_TSD_MASK \
                 | CR4_DE_MASK | CR4_PSE_MASK | CR4_PAE_MASK \
-- 
2.46.1


