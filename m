Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C87CD10380
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 21:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t45QL-0005fE-8R; Thu, 24 Oct 2024 17:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t45QF-0005dX-OP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t45QC-0005YA-Vu
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729805467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h5qDUbT0oI/ii3wep25YhtJ0lpIyWNP4aqcokwUdLXo=;
 b=V3XPPWa/RwDQXoZZ1GmjkzSlKSBoLMJIywQJpkcOw1GDB2Od5ClJBaELjO3jm/caqScHCb
 WIpcBmNmXMfYTmFwGN0M+MldlyLDsLTBfXSMOWUany21KAM2RWS5GTgfwV10hDtny7B2Wa
 bJRsXoL3yKlud/1tdtSXhgtEOc9/6ZA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-rHNI_zGZN3OM1ViNBm0c7g-1; Thu, 24 Oct 2024 17:31:06 -0400
X-MC-Unique: rHNI_zGZN3OM1ViNBm0c7g-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-460dd31b4c1so20491691cf.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 14:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729805465; x=1730410265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h5qDUbT0oI/ii3wep25YhtJ0lpIyWNP4aqcokwUdLXo=;
 b=RbmDk25tLd52eTskvKqWIHWKT64MnvANl6PwqYxjlhXw5MeocRJYwL9/dN0Dw3yokC
 0F488vRr7BadMAF9XhZNSd93Jy0/WhlFoTLk0EUXPniEv0348EhnPVjwbAvGajWAPjoc
 xmcPxKkgwhBK77AH8aiQoVa+1AcroV09/ScDfHvU5K3Wi/rNDJD5L854Kk5yXIDzCKFb
 qH/r0eON95r+RXH3ylGRGYnn58LFZ7GBc70wE0acGXpzkFEB39vrHJzH0M8ilFPooVBR
 nMiv0RFMImoFlmrNGoTt9UtbGXUHXkDBZDbQLNQuRSBtgHlCBAcP2TFEuv26JPl39AEe
 Y8eg==
X-Gm-Message-State: AOJu0YzuL+fwXoRpuSygfeAZZtGSHs1iEmdStxRrMfloL6KlQPut3vGd
 ooQEARPVUi+X68T+l/DhHg3w0QI/vWvG9zYhuQ8W1mz/+HQR86wCC7o5dQdy4Ianyz3q3tlfrgN
 RwgnnEMQaNIJJd1RgQnaQzEpd2RgcGCZ+i5LNpkT667ZpiJYT48CR92MIMK70aUjH8VJP+r3UPQ
 vXKhuPi8WBT22+axOB5vXY5zinkfatNZH/FA==
X-Received: by 2002:a05:622a:14cc:b0:45e:ff67:e058 with SMTP id
 d75a77b69052e-46114715486mr89951351cf.44.1729805464947; 
 Thu, 24 Oct 2024 14:31:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9Ya/zv4qjiQLCLXoG1QByfJGhOsaXZRQq+Kw5POUEhex2J1GYkXh31NxoWNv1VOfKsrT/Sw==
X-Received: by 2002:a05:622a:14cc:b0:45e:ff67:e058 with SMTP id
 d75a77b69052e-46114715486mr89951091cf.44.1729805464543; 
 Thu, 24 Oct 2024 14:31:04 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3c3a434sm55465091cf.19.2024.10.24.14.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 14:31:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 3/8] migration: Unexport ram_mig_init()
Date: Thu, 24 Oct 2024 17:30:51 -0400
Message-ID: <20241024213056.1395400-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241024213056.1395400-1-peterx@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

It's only used within migration/.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 1 -
 migration/ram.h          | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index df57be6b5e..e8490e3af5 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -39,7 +39,6 @@ void precopy_add_notifier(NotifierWithReturn *n);
 void precopy_remove_notifier(NotifierWithReturn *n);
 int precopy_notify(PrecopyNotifyReason reason, Error **errp);
 
-void ram_mig_init(void);
 void qemu_guest_free_page_hint(void *addr, size_t len);
 bool migrate_ram_is_ignored(RAMBlock *block);
 
diff --git a/migration/ram.h b/migration/ram.h
index bc0318b834..0d1981f888 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -44,6 +44,7 @@ extern XBZRLECacheStats xbzrle_counters;
     INTERNAL_RAMBLOCK_FOREACH(block)                   \
         if (!qemu_ram_is_migratable(block)) {} else
 
+void ram_mig_init(void);
 int xbzrle_cache_resize(uint64_t new_size, Error **errp);
 uint64_t ram_bytes_remaining(void);
 uint64_t ram_bytes_total(void);
-- 
2.45.0


