Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45ABACF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlGC-0005Wm-A2; Fri, 04 Oct 2024 12:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGA-0005RC-UV
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlG9-00067G-7h
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DZTXKevYJ6TeDBJAdOHGKQp8DOkIyrthfbjQsPm68c=;
 b=XwCf5lojGTcFNmILh753S83uI/KqOkBXZoZWv++TByTnnzvDoVhVWRaQ0WZVobo+1G465h
 S9i68SJJOEwrlliX0PWFiLb8a7Wq5VuWIENiIJ9XKp5i3WeaKLQTiHQhznab2q4KOzWWwK
 JgX9xxeirOuYhwbpwrAXFgstWV+Q4Jc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-fdi-kfLJPryeR6Os9uyUEw-1; Fri, 04 Oct 2024 12:34:27 -0400
X-MC-Unique: fdi-kfLJPryeR6Os9uyUEw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37cdb213bf9so1326911f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059665; x=1728664465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0DZTXKevYJ6TeDBJAdOHGKQp8DOkIyrthfbjQsPm68c=;
 b=ZlsRU+bK6LMKYnVG6PUemXAh5ocY9B0yBlr0kD1Xpv8CZWDNZHrkjXKk6Pn2rUzFOQ
 v9+nCY9+iCKGSr4aMM6pH31T12CttNbq374On1I2j/aOsdgVcFf+NHmQ6BoFx8XaEGB0
 WCQJClQJh3KDyCXubgv9fmSDwYK9jKAnVpzylN9HzwBPg82bp/2XG8Af2TNFuhkp6JL3
 tKx6/ppdDDYCZKKpwSMrG17UABRTqMIwAgR4kgcW/gXGr6EHyhvklGXJw+i8KKaJuup+
 gnDtfm0fEa483lJJQJEA7lLD1bEYfBSWY80LbqKZUSaPqJZDrZh8/9XkYX1JD/I3IcPU
 O8zQ==
X-Gm-Message-State: AOJu0YxH45vc/dGnnRTRLAvfkciagDkjG0oDVRuAcib+XrMdziTf7HEx
 tFbI+4nsu2E5Q6IDrdcEfFpcb0cIPZ5w94CP/pTqFyQSIXgZEEYrh4UhtNNkJFpoVladT5MXKxF
 F78+BeKzGQDG/TNA3lJQfgarGDgQ2qfQXTZBijoShIv/rOvA4ybk2JRpWto92KZVarjsV7/X7kx
 eJJplPK8kMDnOgf5eNxxN6aA5Jov9RGH8w7nVSYAM=
X-Received: by 2002:a5d:4411:0:b0:374:c4c2:fc23 with SMTP id
 ffacd0b85a97d-37d0eae97femr2470600f8f.56.1728059665524; 
 Fri, 04 Oct 2024 09:34:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhmU1pcEhazEpV1PzQmh2gleuyBf0/8ZCTdKEXCRHbfcm7xEX+99Czmi/WlkmBEf69wsyNhw==
X-Received: by 2002:a5d:4411:0:b0:374:c4c2:fc23 with SMTP id
 ffacd0b85a97d-37d0eae97femr2470583f8f.56.1728059665020; 
 Fri, 04 Oct 2024 09:34:25 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1691b4c1sm35191f8f.45.2024.10.04.09.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:34:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Xin Li (Intel)" <xin@zytor.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 02/23] target/i386: Add VMX control bits for nested FRED support
Date: Fri,  4 Oct 2024 18:33:54 +0200
Message-ID: <20241004163415.951106-3-pbonzini@redhat.com>
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

Add definitions of
  1) VM-exit activate secondary controls bit
  2) VM-entry load FRED bit
which are required to enable nested FRED.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Link: https://lore.kernel.org/r/20240807081813.735158-3-xin@zytor.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 85ef7452c04..31f287cae05 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1435,7 +1435,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "vmx-exit-save-efer", "vmx-exit-load-efer",
                 "vmx-exit-save-preemption-timer", "vmx-exit-clear-bndcfgs",
             NULL, "vmx-exit-clear-rtit-ctl", NULL, NULL,
-            NULL, "vmx-exit-load-pkrs", NULL, NULL,
+            NULL, "vmx-exit-load-pkrs", NULL, "vmx-exit-secondary-ctls",
         },
         .msr = {
             .index = MSR_IA32_VMX_TRUE_EXIT_CTLS,
@@ -1450,7 +1450,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "vmx-entry-ia32e-mode", NULL, NULL,
             NULL, "vmx-entry-load-perf-global-ctrl", "vmx-entry-load-pat", "vmx-entry-load-efer",
             "vmx-entry-load-bndcfgs", NULL, "vmx-entry-load-rtit-ctl", NULL,
-            NULL, NULL, "vmx-entry-load-pkrs", NULL,
+            NULL, NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-- 
2.46.1


