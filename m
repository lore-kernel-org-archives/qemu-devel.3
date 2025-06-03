Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC29C5B552
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 21:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMZSI-0004wF-MY; Tue, 03 Jun 2025 17:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZSD-0004vT-LM
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZS7-00066b-N3
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748987147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wqJ6EVWbDs69t6vbg+iE8Fat+puqrDz2NSdIWjGRYbY=;
 b=Ecf3LPZvGLlGA5L7C5IfLFHlAx/ybsIQvhgZ2pGgqdNG4q2tK+/6WG6iy+FyBMO+8LKvK7
 zMEGBsAYSt0rzK3DA79DWn7Zfj0yVeGhypShbevOLsZ/ZTMJCsp6kt2Z/dtVuARh1DulkJ
 7v7eYWexGAiDQkaU0KQANnnMjd9Q524=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-gOqVD3fVNA-NJMq-d7VK8w-1; Tue, 03 Jun 2025 17:45:46 -0400
X-MC-Unique: gOqVD3fVNA-NJMq-d7VK8w-1
X-Mimecast-MFC-AGG-ID: gOqVD3fVNA-NJMq-d7VK8w_1748987145
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so142413f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 14:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748987143; x=1749591943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqJ6EVWbDs69t6vbg+iE8Fat+puqrDz2NSdIWjGRYbY=;
 b=FvVgLFy7B+ryO/7fwtp1dL5KHUeB2fo1phMjGTv/wtGmpXgGq7DEnantu8hGtVP3Bp
 bruR7FM4782krQQOwxLIMuXZQQ+iUl9oe4D0ctf/OOfe5TMdsiZU4P/QQqG919/h/NHM
 qgrH7k/T3cgGNumC4Zg3bNHq96nGGSZkZ9ltHlaGuLCIcGwKITLJRZ54m9qEAL0UGMq+
 08pGsf0mWOpiDpTQMg/LAI9FcGnRAJ/tCki5BMz1NILujJuh2ShxrIb7s0SJCcb/ybsj
 PXbwQ0xCXIw2/umQfP7mWWK/Tyi4ccCXhgK98RpyBEQxK27p/qIs5+ODESxrNM6bPmrU
 edvQ==
X-Gm-Message-State: AOJu0Yx/YfFJnKVzf3IWVIgWatnRXNue4bRjLUkbuVprwHc147Ao2RRJ
 kbmKkiG/tKF+dDgiJuejHmdfSeelioyBDiUPbAQbLI3IigDw6dwqkIpxt4B5PVEhwMeESwCLmms
 HVz2Eeuuut7BLTUY/4HzeItdVlxHBhmMu3bAY8m04rXTjScDbuWNFqrt6ZxPDMxZwKDKeX32a5b
 qm21ZDkHHXgRVWUyjBum2pYbrdCYAUkDHvyyyMeV48
X-Gm-Gg: ASbGncsQrkooP0KNgzUtLHAp6a0UOVLkSimoE5LSauOZ+9JsTUTYed5WvJ5IDJDKvJN
 yPfbf53aeiffYLP6ij6Nzx9bJhyUwySZ3mX3sd7p8hZ5xP1Mk81b6cxBZPBeBwaBdDXhRUqAgiF
 NGRvYyV1eU1IX0Fwq9EQLc/fjulqmSxedCwvlPYFCuvwdS3kpbnm1WtmJ8s04uXNVfMeIF6xK0p
 YZZs9VaucJG58MFwc4hZKPP90jiLpZ1f0tat+iAWhVMESeuwkKByc+tpg/O+Rcg/CTweyIUW0eI
 LNjABTAGgW8cXQ==
X-Received: by 2002:a05:6000:1448:b0:3a5:1360:6b34 with SMTP id
 ffacd0b85a97d-3a514169106mr3234290f8f.2.1748987143520; 
 Tue, 03 Jun 2025 14:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQQ1YvA2Mm+d/yvvkAOwLhDoWMXb5KiF9WnJ45XttALvet3DHtGLH7yBfWFzKtnYPt3HRIzQ==
X-Received: by 2002:a05:6000:1448:b0:3a5:1360:6b34 with SMTP id
 ffacd0b85a97d-3a514169106mr3234275f8f.2.1748987143019; 
 Tue, 03 Jun 2025 14:45:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa270csm178226665e9.16.2025.06.03.14.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 14:45:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Xin Li (Intel)" <xin@zytor.com>, qemu-stable@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 08/16] target/i386: Remove FRED dependency on WRMSRNS
Date: Tue,  3 Jun 2025 23:45:15 +0200
Message-ID: <20250603214523.131185-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603214523.131185-1-pbonzini@redhat.com>
References: <20250603214523.131185-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

WRMSRNS doesn't become a required feature for FERD, and Linux has
removed the dependency, as such remove it from Qemu.

Cc: qemu-stable@nongnu.org
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250103084827.1820007-2-xin@zytor.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c9bd3444e46..73403505c5d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1803,10 +1803,6 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_LKGS },
         .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
     },
-    {
-        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_WRMSRNS },
-        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
-    },
     {
         .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
         .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_SGX_LC },
-- 
2.49.0


