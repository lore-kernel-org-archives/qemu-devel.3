Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E506C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrYF-0002zL-Or; Sat, 08 Jun 2024 04:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYE-0002yI-NQ
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYD-0000IG-9X
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FY/b9ZJxXQtXE7IYTUEDi/lb+onz2CG5Vy49ypNFS2w=;
 b=FgTfhwrqqH0jGlQQo+OfYHOfRQVf6jms0z1bv7pZVOPvmCI+MC+MlFUf0QEWkuB95HqHDS
 +pi5433K9no7PypjDyXJc+VUdDVtuhsEs+0uWvnNoksdJh943MBxhN8HKsW3uRaJZ0ccdp
 wODWCspviyjlR+Io4ioftoPJ0ex7FWU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-nUxZVjQmPs-jj-duG2Ej8g-1; Sat, 08 Jun 2024 04:35:47 -0400
X-MC-Unique: nUxZVjQmPs-jj-duG2Ej8g-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57c718807b2so59569a12.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835745; x=1718440545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FY/b9ZJxXQtXE7IYTUEDi/lb+onz2CG5Vy49ypNFS2w=;
 b=h4MTntSSmynqqldJWmyUChNG0QcA/v2IZSm4XkpTlP7rTu6rImAcURJD9mAnfg2uv7
 QbKbZM7fB1Huz4JxT1A2diwd04V+6XeMQwYCKOY0ZKK3LvtLxqwW2+Ey87UXJAK2nwJV
 Dk3yLKCfZXiuTeKpgOX/u9Lku99pPn5rDCUAypzPHoFqh823HVs2DAiN2eubUf0QVrR9
 keNKRGzBDf3LFcHMPfcpmioZOCYG7Kl5CTY4hWCCmszm+Tt2a7O0PoIVlUE0HjzYtdx/
 iMj5hlHaJUyc0CY1aOAlxag+rf58Uogzs8KweFPKxHQYl576Kiyt+FXtBTkfoLuag5tG
 rKOA==
X-Gm-Message-State: AOJu0YzGoB6HM4t3bMXIaixxxXVS97lBX8Ur88giYbszV5/qaySfYA8a
 wyX+EHAw3UAr7VfVcvmVadUr6KXYgLQl7psALhOJUi09ZMOwNOobkpdn3UPza4BzpUgx19HfptO
 JjVz/7v/lQqkr80ctnQ1FxE5d6arPud1z6gJzmxXvM58VO7NqVOeowsVwEe0zU0I43AVMbHKuNq
 IgaBNSyjxU/cdgrRs4mu+0mLAowj4bYESNuYgs
X-Received: by 2002:a50:8719:0:b0:57a:2ae5:70e7 with SMTP id
 4fb4d7f45d1cf-57c5086e02dmr2439357a12.7.1717835745312; 
 Sat, 08 Jun 2024 01:35:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUf+r0mjElDoTcAdv8axH856ydtyAiqxkmtY5U4/SZ73mogqfYBWsMMeoo+dzlj9a2f2hzZg==
X-Received: by 2002:a50:8719:0:b0:57a:2ae5:70e7 with SMTP id
 4fb4d7f45d1cf-57c5086e02dmr2439345a12.7.1717835744992; 
 Sat, 08 Jun 2024 01:35:44 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aadf9d086sm3919298a12.18.2024.06.08.01.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xin Li <xin3.li@intel.com>,
	Shan Kang <shan.kang@intel.com>
Subject: [PULL 34/42] vmxcap: add support for VMX FRED controls
Date: Sat,  8 Jun 2024 10:34:07 +0200
Message-ID: <20240608083415.2769160-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
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

From: Xin Li <xin3.li@intel.com>

Report secondary vm-exit controls and the VMX controls used to
save/load FRED MSRs.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Message-ID: <20231109072012.8078-5-xin3.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/kvm/vmxcap | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index 3fb4d5b3425..44898d73c2e 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -24,6 +24,7 @@ MSR_IA32_VMX_TRUE_EXIT_CTLS = 0x48F
 MSR_IA32_VMX_TRUE_ENTRY_CTLS = 0x490
 MSR_IA32_VMX_VMFUNC = 0x491
 MSR_IA32_VMX_PROCBASED_CTLS3 = 0x492
+MSR_IA32_VMX_EXIT_CTLS2 = 0x493
 
 class msr(object):
     def __init__(self):
@@ -219,11 +220,21 @@ controls = [
             23: 'Clear IA32_BNDCFGS',
             24: 'Conceal VM exits from PT',
             25: 'Clear IA32_RTIT_CTL',
+            31: 'Activate secondary VM-exit controls',
             },
         cap_msr = MSR_IA32_VMX_EXIT_CTLS,
         true_cap_msr = MSR_IA32_VMX_TRUE_EXIT_CTLS,
         ),
 
+    Allowed1Control(
+        name = 'secondary VM-Exit controls',
+        bits = {
+            0: 'Save IA32 FRED MSRs',
+            1: 'Load IA32 FRED MSRs',
+            },
+        cap_msr = MSR_IA32_VMX_EXIT_CTLS2,
+        ),
+
     Control(
         name = 'VM-Entry controls',
         bits = {
@@ -237,6 +248,7 @@ controls = [
             16: 'Load IA32_BNDCFGS',
             17: 'Conceal VM entries from PT',
             18: 'Load IA32_RTIT_CTL',
+            23: 'Load IA32 FRED MSRs',
             },
         cap_msr = MSR_IA32_VMX_ENTRY_CTLS,
         true_cap_msr = MSR_IA32_VMX_TRUE_ENTRY_CTLS,
-- 
2.45.1


