Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A57C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Ykt-0000r1-4w; Thu, 02 May 2024 11:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Ykl-0000oC-86
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:53:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Yki-0002MM-Uu
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714665224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8kMiIjPcXCK6rVyGUD5f/LiuS9wbS5Ss3aEExZnLck=;
 b=NnxWE0y8gb0vxct7zGtmSQUuuCqOxQSkEoSo3dRmYGbjJsA9iUM6RQW5Lj+Z0Y9EqXMZhM
 d9WCpleX5BuW3eWWaRZ3zSKGTreRLTk9szFJhMFVpJs20hgApmJr+7/BGj2stiuOtHCb7c
 GuD8tUMyapC/0MtcsEgz5gobxauGDt8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-QrQ4QRgbNm-32EgHTcqP_g-1; Thu, 02 May 2024 11:53:42 -0400
X-MC-Unique: QrQ4QRgbNm-32EgHTcqP_g-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-572b993d8ffso668961a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714665221; x=1715270021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a8kMiIjPcXCK6rVyGUD5f/LiuS9wbS5Ss3aEExZnLck=;
 b=iLpYpHJJ7tnz79D2TZkyuytjf8MoAt446Ea9OI3wTX5LQ84kN9NVzFlYM7lmjLhPR1
 Znz1CPkAMu5uMXiw+v927q+L/QOKI7xemFc2LC6U+7AAlwRdIXkBGvai+OXHJUBQ042N
 SAVx/HJC9JwJcW20m4osuNdEfU9+OXoacuj/QH7s2lEatkOr6wNZxfD3PQ4QMO7UQ+Bh
 6y1I3IUlb/qyG9YO4qNtdU0cyXKpesrDD/R48VVENn06fOA5GoyPTPrIgpY8aZfnaTZ5
 5gKpPi06OHUjqbCDUBY5a3uwiBjP2nuPtTLPJYRxLvbJ2HFisS0Pd2RvUdy5wHnIrZsy
 szEA==
X-Gm-Message-State: AOJu0Yy4haQVFsNKinIV2hpBoUPWN5v95P1Hl+EXjWnDHY/K5eds2V2P
 ZOXEifQ7znGM3mM6C25Umpm7f8flW1rdO3sjXcDAC/hriwWbJMSt33+l7H2z8q1kPxNuFM+daEf
 zoXNO4Wt/JR6veNWmQUQeibIUEm8JraL6T2RANSMLOg33HBKqQx8bBGQevzqAk+IVBcAHzlg32Y
 BENYrgNBU100ptPb7uUhWNIsRuU55p5ZFS7NQm
X-Received: by 2002:a50:8aca:0:b0:56c:522f:53e1 with SMTP id
 k10-20020a508aca000000b0056c522f53e1mr2283655edk.17.1714665221435; 
 Thu, 02 May 2024 08:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo6mg01hmBODsUGJCUeguiwbjPalLzM3UicSNt6Y4jycoHlZCfBLGnvDff4piS5U/2oNvBjw==
X-Received: by 2002:a50:8aca:0:b0:56c:522f:53e1 with SMTP id
 k10-20020a508aca000000b0056c522f53e1mr2283644edk.17.1714665221081; 
 Thu, 02 May 2024 08:53:41 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 fd23-20020a056402389700b00572031756a8sm653037edb.16.2024.05.02.08.53.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 08:53:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/13] numa: remove types from typedefs.h
Date: Thu,  2 May 2024 17:53:21 +0200
Message-ID: <20240502155331.109297-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502155331.109297-1-pbonzini@redhat.com>
References: <20240502155331.109297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
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

Exactly nobody needs them there.  Place the typedef in the header
that defines the struct.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/typedefs.h | 2 --
 include/sysemu/numa.h   | 8 ++++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 66f0b146c8c..e0a0bc31e7f 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -81,8 +81,6 @@ typedef struct MSIMessage MSIMessage;
 typedef struct NetClientState NetClientState;
 typedef struct NetFilterState NetFilterState;
 typedef struct NICInfo NICInfo;
-typedef struct NodeInfo NodeInfo;
-typedef struct NumaNodeMem NumaNodeMem;
 typedef struct Object Object;
 typedef struct ObjectClass ObjectClass;
 typedef struct PCIBridge PCIBridge;
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 825cfe86bc1..04676141470 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -36,7 +36,7 @@ enum {
 
 #define UINT16_BITS       16
 
-struct NodeInfo {
+typedef struct NodeInfo {
     uint64_t node_mem;
     struct HostMemoryBackend *node_memdev;
     bool present;
@@ -45,12 +45,12 @@ struct NodeInfo {
     uint8_t lb_info_provided;
     uint16_t initiator;
     uint8_t distance[MAX_NODES];
-};
+} NodeInfo;
 
-struct NumaNodeMem {
+typedef struct NumaNodeMem {
     uint64_t node_mem;
     uint64_t node_plugged_mem;
-};
+} NumaNodeMem;
 
 struct HMAT_LB_Data {
     uint8_t     initiator;
-- 
2.44.0


