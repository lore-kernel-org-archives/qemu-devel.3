Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8CACD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 07:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slNpW-0007jM-UX; Tue, 03 Sep 2024 03:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slNpV-0007im-Q1
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 03:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slNpT-0008Ry-Dj
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 03:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725347992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YOrLfsvwEiISGQ8ZVlVc7TwmstdfG5ZkvLyeiD+k0Nw=;
 b=inAxloYD69QopmOXlfY6AlVLmhAO8KKIOElBPuSgibocWg97qke+OEam5KLYk0vaZbPWgl
 tPLkpa58mEnt3C5CuKYw+687uS/YQuOFGUi3x+EgWjMyvJEJ31bt59J41Lab0kQ2e82nto
 /sb4nz26gXavlk4+lu0IDKAK6BPcUpI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-57xJpZu6PqC7YZLRxZq_Jw-1; Tue, 03 Sep 2024 03:19:51 -0400
X-MC-Unique: 57xJpZu6PqC7YZLRxZq_Jw-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-6c8f99fef10so5501792a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 00:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725347990; x=1725952790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YOrLfsvwEiISGQ8ZVlVc7TwmstdfG5ZkvLyeiD+k0Nw=;
 b=tVVLDVyjMq4m019f6Gto6uoEHYEHy+6TR8cj1HHvHakgYUYSDlNySqLm6ojDVHEEi4
 Z+p0wUb1Idm3nHdNiFT+lGKJhbJ+CB0cU/qMrBz++7fi/9B5Q3GQZ2A0oK0aqFwniLsU
 MU2ZWaVR0N4QcGUTpBy/fTBQQVf5LxA8tHIoB3/oIIpT1d7wSjqMG3S0RteDOH4WXG3T
 x3TdSP86rcAGRK3b0mKjJPwLyuLMTHK0V8EBgbMLoNvclsfsukcNFaSWISTwL0Fib1oI
 QFQk1QNwiuZ7ikuZU+5wW/C5o7j9GcYyfNtPhHZgWZLVA3Z/Vf8CZuYCZwlo9g+awR4Q
 NVZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNxqZ7sDIIxh3fPV4D6/c71uzxU/r96juK1WDhW6PNMziwxQ8pS93BU0dJy8Xuz4/BMwv6VjQQuqKo@nongnu.org
X-Gm-Message-State: AOJu0Yz1m6L9tkeeW+igky4901ksWu7LvW/oBsqo1UkmpXuBlAGC4RvO
 CwlO8tEStvYMbtDe6wTEzAO8Obsf2144SwYwp38ziAx3OYL5KDCVrtX+NgHiSqBUBZywupGWoiV
 QQ/rbrCcgbmO9bdRa5QfhYf7F40RtIhU77KJR+AuTlyvyAXcDo0DX
X-Received: by 2002:a05:6a20:d528:b0:1cc:df9e:bc3a with SMTP id
 adf61e73a8af0-1cecdf31af7mr10436596637.31.1725347990265; 
 Tue, 03 Sep 2024 00:19:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCtdTBTFQyE7fvIl3BTOHoJBqKRt6B/bdPcHyK151s5Dto+GOmrjnCdQmjQ+SgSc4wKXHDQQ==
X-Received: by 2002:a05:6a20:d528:b0:1cc:df9e:bc3a with SMTP id
 adf61e73a8af0-1cecdf31af7mr10436584637.31.1725347989886; 
 Tue, 03 Sep 2024 00:19:49 -0700 (PDT)
Received: from localhost.localdomain ([115.96.207.26])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-715e55b9cfbsm8083651b3a.93.2024.09.03.00.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 00:19:49 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH] kvm/i386: fix a check that ensures we are running on host
 intel CPU
Date: Tue,  3 Sep 2024 12:49:42 +0530
Message-ID: <20240903071942.32058-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

is_host_cpu_intel() returns TRUE if the host cpu in Intel based. RAPL needs
Intel host cpus. If the host CPU is not Intel baseed, we should report error.
Fix the check accordingly.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 11c7619bfd..503e8d956e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2898,7 +2898,7 @@ static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
      * 1. Host cpu must be Intel cpu
      * 2. RAPL must be enabled on the Host
      */
-    if (is_host_cpu_intel()) {
+    if (!is_host_cpu_intel()) {
         error_report("The RAPL feature can only be enabled on hosts\
                       with Intel CPU models");
         ret = 1;
-- 
2.42.0


