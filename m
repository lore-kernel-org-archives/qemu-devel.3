Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72788CAC58F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLNW-0003Ky-J5; Sat, 13 Sep 2025 04:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLN4-0001yV-L9
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLN2-0005KP-QC
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M/f46ar4NQt0D82z+vsB//+J/IGWmriKTQDbJURGYEg=;
 b=W+7QIurI34AjYbFnvnrulgbtpzoKq8516Y+ekKXh/de7QUOBp4XQ6BNHWyXbNZ833qhS74
 6LxJP8iwkWJV5ol/ulOZITcubod+m6Q1Sdl5GxfPNdBqWz6dhx3HlwYsPQU/gJq7s8fhsB
 U8qMeREkHVfSOQu+YGJLdyjuqrU4eWU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-r-q_KDPFNMqWyAvOmla7lg-1; Sat, 13 Sep 2025 04:12:29 -0400
X-MC-Unique: r-q_KDPFNMqWyAvOmla7lg-1
X-Mimecast-MFC-AGG-ID: r-q_KDPFNMqWyAvOmla7lg_1757751148
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45de27bf706so12817075e9.0
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751147; x=1758355947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M/f46ar4NQt0D82z+vsB//+J/IGWmriKTQDbJURGYEg=;
 b=d4heeFHPolxLFaZEbjZ56sDxlOkG31CaaQnhXBRjee6f0Rv/NIGDsv4w6NmnV+ekCp
 gThkib6xQOFDvg+DjolGwkQkmf6ucXj1xuzT2ljfhodjeHtkW0lh2JDQcDcLJZrioJXZ
 essd8JZ2KDoM2rfCyLcUfkiHF5rPaUljvUmgKU9Lwf38Fz9mo2FB9/le/go/DmrFp/S8
 Rde4d+bFrADe1ZEE4p4P2FVM+AmzsZ0rKI5sYSFtS5Y3Nh4UklQi0RkHPJSdAEHwsp3f
 QZKQiec2KoO1qjg+TdiNBmMGd3FSw3i5SihXGpMuGnMUKr8lIMfLivpbqCYMLtrdys/u
 CM7w==
X-Gm-Message-State: AOJu0YwUg/CtnJRFHdLLibPpSH2+5bR44h4nSpyZzd9hc856mtSYfFUm
 mWSHnDkQxWliU35BkcTDvEeONGJXFKvGZ1js7TgrI47/XcG2ZhtIPdOAILQW3fxbBPEc9bVI8jd
 0D8ZbMvH/uzGt9RqSOJ8bdLkstMo/4l5R62fV6mopo2OWjJV8y64nvhbZP8jTwl1aRAOgZvWQ7r
 hejBPxAsY3X0OT/XDP92/wWTwPc8XkbbhWCu2eKqRi
X-Gm-Gg: ASbGncuSCaip1e2O6FhjeRYuW8KiwHSbnE/hvvGrNPS8mP/sqX/zP9u7xDZjcBhrLoL
 q1Bj/ACu0kWJXvkMESky0tEIannB7VjzStQyrPaL4EOOziSNG47hTgp9qtBBPuF8YzKaQXw0gLH
 Q8WauhkIo7Y7ciEvAVfzHni39rbvU6YBxBgwfSVPaunkaiCiE7vxmsG3tXqkWxHztanIPDCEUMF
 K16AKauahoToTdH9mv4vT8P8rPKk6oCpt4+2xehebd58S/xO9vlP7N79EPcayRGbZKJLJ53YBac
 GmfAws6o+2LB3OgJqufkW7ZC3v0xlhTgxjYGHilKLIyF1ar0rqeqxCL6h4ixAyr3Fxlf65AAkux
 SIvZWL2JOgCT7lyDkzuU4ysh5kvHwzFUaApt90JaL4ok=
X-Received: by 2002:a05:600c:190d:b0:45f:28c9:4261 with SMTP id
 5b1f17b1804b1-45f28c94362mr6143975e9.20.1757751146879; 
 Sat, 13 Sep 2025 01:12:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFccGLYb1kgD9rsY9/uhSVBamxYu66kvpVDifLnQ5iBklVhgSMB1dnQ1HwmXJ/YeydsTu+KtA==
X-Received: by 2002:a05:600c:190d:b0:45f:28c9:4261 with SMTP id
 5b1f17b1804b1-45f28c94362mr6143785e9.20.1757751146440; 
 Sat, 13 Sep 2025 01:12:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e8f4d644adsm590429f8f.52.2025.09.13.01.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:12:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 59/61] accel/kvm: Switch to check KVM_CAP_GUEST_MEMFD and
 KVM_CAP_USER_MEMORY2 on VM
Date: Sat, 13 Sep 2025 10:09:40 +0200
Message-ID: <20250913080943.11710-60-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

It returns more accruate result on checking KVM_CAP_GUEST_MEMFD and
KVM_CAP_USER_MEMORY2 on VM instance instead of on KVM platform.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250728115707.1374614-2-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d13156bee87..633b72bde2d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2776,8 +2776,8 @@ static int kvm_init(AccelState *as, MachineState *ms)
 
     kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
     kvm_guest_memfd_supported =
-        kvm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
-        kvm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
+        kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
+        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
         (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
     kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
 
-- 
2.51.0


