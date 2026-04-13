Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08942F34C49
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCH19-0004bF-CX; Mon, 13 Apr 2026 09:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCH18-0004b7-Eu
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:07:54 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCH16-00042F-TE
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:07:54 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d70c30767so903294f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 06:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776085670; x=1776690470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T+polFJXIRW8YuYLuBeq5TCrPMFMgIHh/5hqcgt2EOQ=;
 b=S+ZS6OvWrgV5EClTXdBRIu+N3lSNJDqGR4mXus5QvfDXP5fZMGSmn/MaE0L6DiSi7e
 /Ie4O3yten/3Vpuy447kRYvUfPTJHqFWcHta+TRTHyGYQBB/dCkDsi640BP9pqzJBp2j
 YhYOsuBittuVOQ8IO/ukudFCAz/PHfAitSCKUQZYvEhkzH0SFLXTlJAs4NWMS9daBVsv
 XeG9EgK9Ik6+bqR6dbuWKW2z+bHR3czFfzWuP+/c1i6APBOANJn+nhvGUQEcXJSrefHl
 P5l/uiRy4I3sOJW7EWN0zU9aDuUpjsREm4lYP8If+u8RPwhVBZ5ZhAceW9/7muFWb7x1
 2zWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776085670; x=1776690470;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+polFJXIRW8YuYLuBeq5TCrPMFMgIHh/5hqcgt2EOQ=;
 b=en5ulMTg77AdJxGBtcznh1GWG2X1vRwJDfzE42tXCxc9MQKe7hyJi/4PQHcEzdx3yC
 NClDnBTqVDL1m3yYJ0E6Rd8naxrXCvDprDGaUbAO+8FOkwOtzCAWLYxuKCOiHP4Zqbl2
 mSk7AApaLXtb+/br+ZbBS790u91CeOhIe0sYeIttgtdWuFMt96v9P0HPWeztnp/7WXpx
 HfXlnwInmyrBFld/JInIwUQkSSr7QOks3QRdVLQHfTDbS/Zw+C8s79OJKhi+LE1qOxWL
 DLgWVCmfJwgsDynkJMvF8tMF35bWEdA7bVCGl+2y6/5lZQOo8zx2CBsICyls0eViAnxb
 CoSA==
X-Gm-Message-State: AOJu0YzPj7jTyJSGw8qyCyFPEDY59YqxjIYOn+vygGtR8kznWZ+2R6aI
 9fkygG7TKQCeDiw21YY3QaPEYC0Kpi/Et3qQoKzp6lh3G+x1/IvPsNIoudo+etpFWrwaCruZRMn
 U+o0UwRA=
X-Gm-Gg: AeBDiet0a7Z10Yo6896ltCJgalubNAkWbD7Gt5gRPNiqKKSILtRx/Ddyy7EeFzAE41k
 nwsmwabdccpmMX6QdFkvNPFNXqA2KLkDr1ZbabW9zbD8Pc048gQuWSccHq/9v0C6gcG9Ux/PVJN
 9rxhc/BOca8vSWOMrbhnpwvDEgnVNFGv0IyQPWGhMUVavVmRmqHquTS5iJESaBrzbJe5Gn+OuQl
 hQSA5hOtEBRT97uqXLGH5OJ3Vt6JT4hv0/WUuYxEvHIT73D9AFTrLK9RvkItYOj699/hxe6itd0
 DGpTO6K8YOzSpHLEA964nCcoZ8feOc9dN3FQ5wOnIbVYeLnzS9UwElhrXyTwGYMlK5hEfSgdQ8N
 TB91YrDBaYQMuqEl6Cw/2zLwX2UM+HgY6thYKX6CILAV1QbybxFift2JzNs7UPyBk0yzH4+qQjx
 /dIn0Irx2KzSsjStEbKwiN0kKYBByKN7t+p7ZyUEanPhdRFT5K8S28ZixDpF/O3Y1RDiGEAvKx
X-Received: by 2002:a5d:5d03:0:b0:437:7719:ca82 with SMTP id
 ffacd0b85a97d-43d6491fef7mr18361158f8f.3.1776085670379; 
 Mon, 13 Apr 2026 06:07:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63de2e4csm34608412f8f.2.2026.04.13.06.07.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 06:07:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0?] target/i386: Mandate monitor 'info lapic' take a
 vCPU ID argument
Date: Mon, 13 Apr 2026 15:07:48 +0200
Message-ID: <20260413130748.6631-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

With SMP configurations, using the 'current vCPU' under the
monitor isn't recommended, as it changes during runtime. Better
to specify which vCPU we want to monitor by its index. Deprecate
the default of 'info lapic', mentioning an argument is expected,
so we can remove this unpredictable behavior one day.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
The other command with this unpredictable behavior is 'info tlb'
which we'll deal with differently, after the v11.0 release.
---
 docs/about/deprecated.rst | 6 ++++++
 target/i386/cpu-apic.c    | 2 ++
 hmp-commands-info.hx      | 3 +--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index a6d6a713265..a62da93259a 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -169,6 +169,12 @@ The ``stopcapture`` command is deprecated and will be removed in a future releas
 
 The ``info capture`` command is deprecated and will be removed in a future release.
 
+``info lapic`` without ``apic-id`` argument (since 11.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+When no APIC ID is provided, ``info lapic`` defaults to the current vCPU.
+This behavior is now deprecated, the ID will be mandatory in a future release.
+
 Host Architectures
 ------------------
 
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index eaa10ad2a3d..9ca569f62b8 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -97,6 +97,8 @@ void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
             cpu_synchronize_state(cs);
         }
     } else {
+        monitor_printf(mon, "Not specifying the local apic id is deprecated"
+                       " (using the current CPU one)\n");
         cs = mon_get_cpu(mon);
     }
 
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 74c741f80e2..e4206d329fc 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -118,8 +118,7 @@ ERST
         .name       = "lapic",
         .args_type  = "apic-id:i?",
         .params     = "[apic-id]",
-        .help       = "show local apic state (apic-id: local apic to read, default is which of current CPU)",
-
+        .help       = "show local apic state (apic-id: local apic to read)",
         .cmd        = hmp_info_local_apic,
     },
 #endif
-- 
2.53.0


