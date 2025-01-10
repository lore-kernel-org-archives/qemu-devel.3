Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50B0E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK2y-000197-So; Fri, 10 Jan 2025 13:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2r-0000ZS-E5
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2p-0001Dn-3u
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=InB+d98viNQRxuvtICKG8ck6jnh084gdrT4/wIgZzao=;
 b=XpcsOCQ9r0fUut2TIV7b+HTK4NwtN0fg2Zc1UIpAmRJbX41oTGDskO9jFsxBcHSza+nUh2
 5AFMzwL/sUk0FPEvuUSQNsTcie8/IxXS07silrnRPqDLOqgJmlF5/OwfxzaeVFRLWM0/cH
 IecYnIwaneCKHo5ToWYJcLedO0OpQ9g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-_XQtdgh1NcG1UI1IpoZB4Q-1; Fri, 10 Jan 2025 13:47:40 -0500
X-MC-Unique: _XQtdgh1NcG1UI1IpoZB4Q-1
X-Mimecast-MFC-AGG-ID: _XQtdgh1NcG1UI1IpoZB4Q
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aabf8e856e2so249462866b.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534859; x=1737139659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=InB+d98viNQRxuvtICKG8ck6jnh084gdrT4/wIgZzao=;
 b=sAuJWvJ5v3JypNpv0f8LikjzfkcjWk6vHubCJDfqwMa19CM6eHb7k00+WpSyz7qcZw
 hkGQktYcR0Vdm+SzQ0ADy7zk0IcnxDsFasP42RJ+3aB27zCZkcllv4HDLc1mrs7tMwJA
 pHGxNJ9ILtNYk3ltYWHwZB0qVuzt9DNI6xPltxfP9IqQGmV5c8mmh17FYsCtFus8tNdH
 A/H4RgU6NLpBHt99rxCchwVolsf5OGLfcxVd37GeIkMvyY3aUnLFP3XwigGD49feeHZu
 pATcJypseGKJEBF+1dAye1scel+7eWudgHph0Oil6bVOj65X+xBgv1r8ktPEHuS8exRR
 I9nw==
X-Gm-Message-State: AOJu0Yw8pree1wjvFKkaoJIgEsHE8d+EQVxZpA31/PsqSm5qHmZ5Xan+
 GveoYkq7l/Si/ExmLcas8PvcaVRoaPPvUhXw7s+wCLZNlPqhYEG21SViWhNAdQuj9g45AwtLQIL
 Be4ZNIJ5rgSZWXukb6gPHprEM+HJJGoCtEPSGpExxGLRDW/4bpw5Wjy0nghED9/u0y5aEPWlLIR
 T61VZ2/HbJsy1DQnjOuGCJpq7p9QTI5R9WllWf+z8=
X-Gm-Gg: ASbGncv5xU0cI3NLVOCOHgUhHSMJwj7/cVmJTlqL+D3tmPtZZEr6vqQVicL2T/9QIwU
 qEMdijCinCPKy/evf8tMJzfvNBnCH0hl/xaDOPXtRf/Qae2W769jxf3FmSYDGoiTt9DaDotbO5Q
 Fqx8nDMu78XD0P2Uki1vTE5FDTNBdEksnNsFhMg+RDlsUJWZv7tfFGUeUsZZY0BaM58avoNNt2c
 vKEswEKdmjeNXnGaXlwj0qoEe1JnZ6RxUMwJ7+vFk+7Uw6VUirclALZRgs=
X-Received: by 2002:a05:6402:400b:b0:5d0:e63e:21ca with SMTP id
 4fb4d7f45d1cf-5d972e1c0d3mr11387890a12.19.1736534858884; 
 Fri, 10 Jan 2025 10:47:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7ym9xWJ3fuQQ9Y7UtIIw9DV1pHPm+O1GGbaXXBAacoVfbsIU03xjaY1IS5zV+X7psX/TmnQ==
X-Received: by 2002:a05:6402:400b:b0:5d0:e63e:21ca with SMTP id
 4fb4d7f45d1cf-5d972e1c0d3mr11387876a12.19.1736534858442; 
 Fri, 10 Jan 2025 10:47:38 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99008c366sm1937639a12.17.2025.01.10.10.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 32/38] i386/topology: Update the comment of
 x86_apicid_from_topo_ids()
Date: Fri, 10 Jan 2025 19:46:13 +0100
Message-ID: <20250110184620.408302-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Update the comment of x86_apicid_from_topo_ids() to match the current
implementation,

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20241219110125.1266461-5-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/topology.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index b2c8bf2de15..21b65219a5c 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -121,9 +121,10 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
 }
 
 /*
- * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
+ * Make APIC ID for the CPU based on topology and IDs of each topology level.
  *
- * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
+ * The caller must make sure the ID of each level doesn't exceed the width of
+ * the level.
  */
 static inline apic_id_t x86_apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
                                                  const X86CPUTopoIDs *topo_ids)
-- 
2.47.1


