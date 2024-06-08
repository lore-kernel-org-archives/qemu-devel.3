Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA663C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrY7-00028P-0i; Sat, 08 Jun 2024 04:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrY5-0001tJ-65
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrY3-0000Ew-Er
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nqavFuphqMVbYI4We65eN8l+lH7mqVtfHlioFfEELe8=;
 b=W0XZU3i3n3V4d7hlIhKGNUPHNgT43ScC6LxEDI3J3MEKeQf3/khBIOoitrRrlyRMHMrvUH
 VZ9krS/0rFgbXTyJCg3y9szBWpcGFyLVeuBcP2wT+bYLay74wmi5YMrwYPYXhu1mJEOoV2
 uaTVYFT0Fd6eKASbRbdMGbzxGq/gdZ8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-ejYSzSs3PtmPYaoHVaX1NQ-1; Sat, 08 Jun 2024 04:35:35 -0400
X-MC-Unique: ejYSzSs3PtmPYaoHVaX1NQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6ec06ed579so66148466b.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835734; x=1718440534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nqavFuphqMVbYI4We65eN8l+lH7mqVtfHlioFfEELe8=;
 b=K0dVSeS1gQyduAbkKb12B8DFVsOH8YbJREs9BDM7wC/iX5VSChwBhAkJNPnsmTz3uD
 q2yGIc1H5uBS4leX27py6usrgy5I/cTsgSO9jged9SSfLJJCSl5Q5raSWpjdq7bwFqzS
 x4KzjIIe2UqTVIAbZ+k2OO2zTFOtAxBigo7vuvtSW21QPHSc+NH9KxRZHHb930sGNeTH
 sCgpEoiRIEzsaJMuNmaiG1Oaf274YiJTSCAsP6Q1dddbLGyn5mWRQon5uiWpUBWSZpgp
 M8nKIlXhjyMP95JojcZLQrQwYMhre0b9vZ+rkTDU7dgztj5fWvPMJ+RNpDbg8S0IGJIH
 Pl8w==
X-Gm-Message-State: AOJu0YynTAm5tpT0AIq4XLC3UeCG+a0RwOvuWgOCrqyR2N1fhpj/N6kS
 2Vu5zxhD49mcAmUbv3q8QNn32mAq70tOim6PEWNYusHQXXzRtGjMaPB3J5eDjJVjXOXKtn5nVPs
 tFMp5SR3+sbFCl+6OsrGaIvY+8/i6QEgLtICpbHuZaKc5A1B1u2xtUpg/Xe4CR2o1xO7iiR9lgU
 ZjQHtun7pURNy1vqv0RXi9HmuNdGl32v9Aj8nI
X-Received: by 2002:a50:d74c:0:b0:57c:4d82:5f6e with SMTP id
 4fb4d7f45d1cf-57c509a5eb6mr2885978a12.38.1717835734083; 
 Sat, 08 Jun 2024 01:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaZu+Qw/LcW+VmZqQm7RXl3VewdAS0tu5VcsuCg2oUHUpYfC3E1QZbp/GBBcyP8VttRYwnQQ==
X-Received: by 2002:a50:d74c:0:b0:57c:4d82:5f6e with SMTP id
 4fb4d7f45d1cf-57c509a5eb6mr2885966a12.38.1717835733685; 
 Sat, 08 Jun 2024 01:35:33 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae13fff4sm4009336a12.53.2024.06.08.01.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PULL 29/42] i386/hvf: In kick_vcpu use hv_vcpu_interrupt to force
 exit
Date: Sat,  8 Jun 2024 10:34:02 +0200
Message-ID: <20240608083415.2769160-30-pbonzini@redhat.com>
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

When interrupting a vCPU thread, this patch actually tells the hypervisor to
stop running guest code on that vCPU.

Calling hv_vcpu_interrupt actually forces a vCPU exit, analogously to
hv_vcpus_exit on aarch64. Alternatively, if the vCPU thread
is not
running the VM, it will immediately cause an exit when it attempts
to do so.

Previously, hvf_kick_vcpu_thread relied upon hv_vcpu_run returning very
frequently, including many spurious exits, which made it less of a problem that
nothing was actively done to stop the vCPU thread running guest code.
The newer, more efficient hv_vcpu_run_until exits much more rarely, so a true
"kick" is needed before switching to that.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Message-ID: <20240605112556.43193-6-phil@philjordan.eu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 268c5734d5c..106ac5cbf62 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -215,6 +215,7 @@ static inline bool apic_bus_freq_is_known(CPUX86State *env)
 void hvf_kick_vcpu_thread(CPUState *cpu)
 {
     cpus_kick_thread(cpu);
+    hv_vcpu_interrupt(&cpu->accel->fd, 1);
 }
 
 int hvf_arch_init(void)
-- 
2.45.1


