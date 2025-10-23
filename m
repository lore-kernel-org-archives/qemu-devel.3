Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59A7CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 19:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC0X2-0006Wm-Qd; Thu, 23 Oct 2025 14:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC0X0-0006VU-AD
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:59:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC0Wy-0003D5-N2
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761245964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HRTTmoaq0zaDqH3fG/L/qN1Tnwdx1HwmDmOIEom+u00=;
 b=Pildkvs0siQdMGW5pRu1BOxyf4nTWR9PFtbioTEuVBoZ41NBWEXScmfkHgUMu/XCM5vvcG
 /s+DHyH+AJCPruWWNAAXSe4EEVaw3f+S8GEQ1z5uSJYxxXTiHSFEfPl9z7wEvKrH1CsGx+
 RmlUIV8izXSiNqVvOxFHNlhpdKn+Sp8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-Dz-76K7ZPGaJ_rW_SThutQ-1; Thu, 23 Oct 2025 14:59:22 -0400
X-MC-Unique: Dz-76K7ZPGaJ_rW_SThutQ-1
X-Mimecast-MFC-AGG-ID: Dz-76K7ZPGaJ_rW_SThutQ_1761245962
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4e8aafb21d6so34719901cf.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761245961; x=1761850761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HRTTmoaq0zaDqH3fG/L/qN1Tnwdx1HwmDmOIEom+u00=;
 b=A2C6SdSu0KAVngHXiRrbsDmjdrFyAC3aUk8BfIsOJNJxLURQ2/19HpLsVBkRhvZ3WU
 nVFw7RihM28HYlvXbu1WhNtlmuBGDnEIVCACJIl6XlacHXJpXkAMVvb6FKZaGjnRRR/8
 WJm6fa57aAqNIhJS3l598/+XnjdfXAYhJ9lmPe86S3y3NU+g070NbTf/+e+yFyazNzSx
 mXG4HbXXoJUebE7Tau98lCYOVmVq/TR4r5AkzvTNLES7wSbLE2oGgUGpM/qtSyDBSBgz
 AyZragaVvxTFU33/HH0vc3coC+atCmjhqYY9mAZQ+ZZa4N40doflNGI2I+ed2hhjnjfT
 Z9rA==
X-Gm-Message-State: AOJu0YzkEiTfClsq0L2T0frCuJHPQhoImaBzoD5qwrbXj7QW49aAIEEt
 XjhgU77Mm5+r5vw7FsJiAZOWlQ+iX8rA5vB3J1pbV8nfeksPHAE14Ox4gkWFWPpOxXkiHEIaM/8
 ZvZJjUf4/0hOY299MyzzJb0+IkmU4Usp3EPHWvPep4WuKcdo6nC6DYZld99aTUs4IhaXnX3Rvm/
 yc37FzbDE5yBoiIJZob/fbMy1HGTG9yY68SJQytw==
X-Gm-Gg: ASbGncuvU53eA0IVqLdX1CDmOFQekNyzCtPM80lEWOSsUvsvmExFEfvAy0rwE3DK4xN
 vwW7cdkssKQiEOoMu00b/2J6tQjQ5NhILlhbSb7iGjdLeyUmHkTVfn8jxVyzuF8wjjYtnWzgTNs
 SbamtQtZ9UrDaJUwwx3nFd4PwM0Y7wMwsEdQaqZhowYd4oTJ79/iKpGg00u+gpIwy9O5aZYM61M
 5d0oBF1d8+eDRcYMFr1JmxA7krKEDl1J+urHEPCXguw+06KE7hP2HehOYOokpyQw218ecfTTtTJ
 88IFj6rwRacNE0LnbzVxYazkR7voysJXJxzE2Xww7dHHqv/GYAHgMAJZEWdRcOIY
X-Received: by 2002:ac8:7f50:0:b0:4e8:999b:70a9 with SMTP id
 d75a77b69052e-4e89d4123dfmr287742991cf.72.1761245961453; 
 Thu, 23 Oct 2025 11:59:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtN2EKGQiuWXAwjxgnuReXI7clSUHSfILXljN56JpaXjq03cI9daFUDSu5aeYG80P7zIHwDg==
X-Received: by 2002:ac8:7f50:0:b0:4e8:999b:70a9 with SMTP id
 d75a77b69052e-4e89d4123dfmr287742501cf.72.1761245960702; 
 Thu, 23 Oct 2025 11:59:20 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c0ec61770sm213940585a.26.2025.10.23.11.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 11:59:20 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 3/8] kvm: Detect guest-memfd flags supported
Date: Thu, 23 Oct 2025 14:59:08 -0400
Message-ID: <20251023185913.2923322-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251023185913.2923322-1-peterx@redhat.com>
References: <20251023185913.2923322-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Detect supported guest-memfd flags by the current kernel, and reject
creations of guest-memfd using invalid flags.  When the cap isn't
available, then no flag is supported.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 1425dfd8b3..48a8f6424f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -108,6 +108,7 @@ static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
 static uint64_t kvm_supported_memory_attributes;
 static bool kvm_guest_memfd_supported;
+static uint64_t kvm_guest_memfd_flags_supported;
 static hwaddr kvm_max_slot_size = ~0;
 
 static const KVMCapabilityInfo kvm_required_capabilites[] = {
@@ -2781,6 +2782,11 @@ static int kvm_init(AccelState *as, MachineState *ms)
     kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
     kvm_guest_memfd_supported = kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
         kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
+    ret = kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_FLAGS);
+    if (ret > 0)
+        kvm_guest_memfd_flags_supported = (uint64_t)ret;
+    else
+        kvm_guest_memfd_flags_supported = 0;
     kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
 
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
@@ -4486,6 +4492,12 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
         return -1;
     }
 
+    if (flags & ~kvm_guest_memfd_flags_supported) {
+        error_setg(errp, "KVM does not support guest-memfd flag: 0x%"PRIx64,
+                   flags & ~kvm_guest_memfd_flags_supported);
+        return -1;
+    }
+
     fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
     if (fd < 0) {
         error_setg_errno(errp, errno, "Error creating KVM guest_memfd");
-- 
2.50.1


