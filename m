Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815EFC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Yl9-0000wh-9c; Thu, 02 May 2024 11:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Yl2-0000vZ-H2
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Yl0-0002O6-Os
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714665242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zpuIfHd1pI+7vJT1eF7UBY58QTQrgHV52BgrnbSJIjI=;
 b=dT8p81BANOnxHDCiy+h2Roh8o9NT6qu7hHDdU+IFi/TFdpxKinCOEY5KU0jiFDsgd0p8HU
 Mp9yyF68R2bJv5d73Uj6hGiYdalALgz5D+BvEVzEoxzJHdfZJdxYSVy4i9yf+ROqJh5wqZ
 TBB8mQU7VUto+ImGik4c8n0WhRiSsvc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-rL5WaxKeOtCYCvsr5N6UYg-1; Thu, 02 May 2024 11:54:00 -0400
X-MC-Unique: rL5WaxKeOtCYCvsr5N6UYg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-572146eeed3so936584a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714665238; x=1715270038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zpuIfHd1pI+7vJT1eF7UBY58QTQrgHV52BgrnbSJIjI=;
 b=Oh/QsVfoXGPU6QpwHc6MkAnluQsbjo6xgrLm7HfLSa8K4peFMQU75Noxt1VlN4XUk7
 hsFI5brSTg2e6NeFzGFD0hFIBAxtfKUbtx9GNaiei03MCWzSLcJFC2Zy+Y+N6sUinH1E
 YozztpMvvTYweQ1mIfWHhiUYOuLADWSe/tlXR1zCGnorcKndKOvRe3aSfB/zrjuxpXql
 JtMiu8NrHnbTedZeEPa0PaQA27UX30DLdC8+h5T7Piis3MgtwBeskq9gWuLzWW8kUtDo
 uGcMf4UYUrhBVofoGWAhcUF577HyrZNHi3quySfDTsUHDmerYDlHQuM/TX0tLaC7Wb1X
 HC2g==
X-Gm-Message-State: AOJu0YwFennoMCRj3jcw92j1Rr1tVm9PrvDnBLr6tTDZzUgLVnUY5gtF
 t4Jjk4cn5gZjyDgbN/7cT3WJtSlYLvgBjd0789sncBdKINX4luRLBewDDAQhFfKcVnFUfYU0AXY
 rehZiogeP59KfrVI4abFUqfYauWB+V9aRcLoie24LHAJ099+H8I5zzlWJ1RB/xacZ7qAPiPXLgL
 SxJ0B+/Q+dGl1uvmSD3OG/LlgTCt5AITrqPEpK
X-Received: by 2002:a50:8acf:0:b0:572:404f:5199 with SMTP id
 k15-20020a508acf000000b00572404f5199mr3924476edk.5.1714665238422; 
 Thu, 02 May 2024 08:53:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrs4kA4vJBcXcm7Gg0HtbOS5cldCbqgzuZwnaSMejoqdyd37NMRo90fFmGHS9DhEg9iNihpg==
X-Received: by 2002:a50:8acf:0:b0:572:404f:5199 with SMTP id
 k15-20020a508acf000000b00572404f5199mr3924462edk.5.1714665237993; 
 Thu, 02 May 2024 08:53:57 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 ee53-20020a056402293500b0056fede24155sm656982edb.89.2024.05.02.08.53.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 08:53:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/13] monitor: remove MonitorDef from typedefs.h
Date: Thu,  2 May 2024 17:53:27 +0200
Message-ID: <20240502155331.109297-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502155331.109297-1-pbonzini@redhat.com>
References: <20240502155331.109297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

MonitorDef is defined by hmp-target.h, and all users except one already
include it; the reason why the stubs do not include it, is because
hmp-target.h currently can only be used in files that are compiled
per target.  However, that is easily fixed.  Because the benefit of
having MonitorDef in typedefs.h is very small, do it and remove the
type from typedefs.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/monitor/hmp-target.h | 11 +++++++----
 include/qemu/typedefs.h      |  1 -
 stubs/target-monitor-defs.c  |  3 +--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index d78e979f053..b679aaebbff 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -25,11 +25,10 @@
 #ifndef MONITOR_HMP_TARGET_H
 #define MONITOR_HMP_TARGET_H
 
+typedef struct MonitorDef MonitorDef;
+
+#ifdef COMPILING_PER_TARGET
 #include "cpu.h"
-
-#define MD_TLONG 0
-#define MD_I32   1
-
 struct MonitorDef {
     const char *name;
     int offset;
@@ -37,6 +36,10 @@ struct MonitorDef {
                              int val);
     int type;
 };
+#endif
+
+#define MD_TLONG 0
+#define MD_I32   1
 
 const MonitorDef *target_monitor_defs(void);
 int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 2b1948a19ac..b71a36d02b2 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -75,7 +75,6 @@ typedef struct MemoryRegionSection MemoryRegionSection;
 typedef struct MigrationIncomingState MigrationIncomingState;
 typedef struct MigrationState MigrationState;
 typedef struct Monitor Monitor;
-typedef struct MonitorDef MonitorDef;
 typedef struct MSIMessage MSIMessage;
 typedef struct NetClientState NetClientState;
 typedef struct NetFilterState NetFilterState;
diff --git a/stubs/target-monitor-defs.c b/stubs/target-monitor-defs.c
index ac07b19064c..35a0a342772 100644
--- a/stubs/target-monitor-defs.c
+++ b/stubs/target-monitor-defs.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
-
-const MonitorDef *target_monitor_defs(void);
+#include "monitor/hmp-target.h"
 
 const MonitorDef *target_monitor_defs(void)
 {
-- 
2.44.0


