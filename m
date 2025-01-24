Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B334C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGFi-0006tK-72; Fri, 24 Jan 2025 04:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFc-0006nX-Ts
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFb-0003sl-0y
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uraIJgwBFUvUKFYLefg6yvOaMymHtIAJOis/mI8DgJQ=;
 b=Pjf0QlAfjLeY9UhU0/7/WRixQXzaRQnsuxbMm7ODqagAaNJRNfGheO8Ns0RdG6+55L58uX
 yw8W53p7sTF+1O8QIgL1+AsWuC4cHUt7+li8CXlVxXBiMpQP+WqQSnRMyrDilUGR4kBUUB
 0lrapI6y5q5GagOEekDLsnMrtIngpxM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-_7Spe-3zNHSpwCd5V8VdrA-1; Fri, 24 Jan 2025 04:45:16 -0500
X-MC-Unique: _7Spe-3zNHSpwCd5V8VdrA-1
X-Mimecast-MFC-AGG-ID: _7Spe-3zNHSpwCd5V8VdrA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361d4e8359so13275605e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711915; x=1738316715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uraIJgwBFUvUKFYLefg6yvOaMymHtIAJOis/mI8DgJQ=;
 b=J/gbxTcJKtBwXZNzcc01sDIlKUrewZIG16NMsMq2rKn98BvlQj+x5dUgaa6xdqEwyE
 vYYpg4oPcQZh59wMu9V78fmz4lA7IbcXf0N1mmFDk/ih54zD0E9oGx2G+xBEKvV/0Unb
 4TSX3dfkzLZnd995N5PJ8ux5/IELHoq4fcA3zS/XjNnSEc1ajVxiodKRCU18QRimNeXQ
 U8xyT6ucCXIkDwG8rZWFGV5I81m6u5v0ORYaFk3i4M8TY++vANSjg77gbrQYHkzWoI13
 Ib0YtlGkrpXfesmgs1Y5WjWq6TJir6OIXc6QhiXb4wCQgS6rrwPn9Qo47IINLcHBNxbh
 4Nvw==
X-Gm-Message-State: AOJu0Yx8Ihg9IVg9kn0KsMABMQ0LUFr+B3QTSrtVT+Hs4JD8BvtOVnVV
 hauu46bE/qmaEVUK80dpn78/nD0sXQibLhZlNRJYYmGQVhEdWxVxMEDijJTWZdGPVK1Q4wEJAY7
 uUaVenObnMmXt+mW9AK5r/PEoQSoxYxvt0LvomPC7l1Uj0w6JKw8KogLnmJcPrudgCW1J6BKRPq
 3c0JBVUz9BroiQcBbB96FagVewJ3hpU/MN89Z3n+0=
X-Gm-Gg: ASbGncu4dH3e3CJkWL5cHZuIuq5SrUndDQpM1WjasOaZ6ppciocbQXptR3MDSYaUPTG
 LKAGABnqpe6i1/Si1uan5IOkoQgXfopPIGvPRqGw+5AbaCHTlvq5JZL6YYgU/C4abRnmazV33j5
 a9+a6R9bleaNJvSmpZAMJxbq5rY8Uxe3wcNJ1QpA44r7rD6JwJgCnyAcFx6U2wA705iyWTw8vfM
 IE4PZn3s7eEwcr6VspiAZRSbWfMcdBB3JzcAxwXN/QV43ONUlaYGs4WqS9AUZPd4P88mXueVw==
X-Received: by 2002:a05:600c:601a:b0:42c:bb10:7292 with SMTP id
 5b1f17b1804b1-438a2114bc9mr173905545e9.1.1737711914875; 
 Fri, 24 Jan 2025 01:45:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGku2OYAFByGb551sRZ8gr87JWPufRNulZJt45pE6CAwNbhWGtiZU8/NyrCAG+vCt3ywoc4Yw==
X-Received: by 2002:a05:600c:601a:b0:42c:bb10:7292 with SMTP id
 5b1f17b1804b1-438a2114bc9mr173905265e9.1.1737711914361; 
 Fri, 24 Jan 2025 01:45:14 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd57517fsm19616805e9.38.2025.01.24.01.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tao Su <tao1.su@linux.intel.com>
Subject: [PULL 16/48] target/i386: Introduce SierraForest-v2 model
Date: Fri, 24 Jan 2025 10:44:10 +0100
Message-ID: <20250124094442.13207-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

From: Tao Su <tao1.su@linux.intel.com>

Update SierraForest CPU model to add LAM, 4 bits indicating certain bits
of IA32_SPEC_CTR are supported(intel-psfd, ipred-ctrl, rrsba-ctrl,
bhi-ctrl) and the missing features(ss, tsc-adjust, cldemote, movdiri,
movdir64b)

Also add GDS-NO and RFDS-NO to indicate the related vulnerabilities are
mitigated in stepping 3.

Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250121020650.1899618-2-tao1.su@linux.intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1b9c11022c4..6db8d6c9bab 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4549,6 +4549,25 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .model_id = "Intel Xeon Processor (SierraForest)",
         .versions = (X86CPUVersionDefinition[]) {
             { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "ss", "on" },
+                    { "tsc-adjust", "on" },
+                    { "cldemote", "on" },
+                    { "movdiri", "on" },
+                    { "movdir64b", "on" },
+                    { "gds-no", "on" },
+                    { "rfds-no", "on" },
+                    { "lam", "on" },
+                    { "intel-psfd", "on"},
+                    { "ipred-ctrl", "on"},
+                    { "rrsba-ctrl", "on"},
+                    { "bhi-ctrl", "on"},
+                    { "stepping", "3" },
+                    { /* end of list */ }
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.48.1


