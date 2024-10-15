Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074B4D216AD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iNC-00068M-0T; Tue, 15 Oct 2024 10:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iN6-0005tu-Et
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iN4-0003Ka-RD
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RY5j2BgNkPWOvoXIyvVFOJpuemGVoag+XCdzDG+fnpA=;
 b=G651Gp5fd/JrVup0F4M78O/UrkRtXQbP0eDg3Lo1UJVRa+klSpl5RTkGsjkw5hNpwrxuL0
 ZyBZZQ6dEISZ7hLKNeOeGIMRVQNBjeGv7BBhhR1NxwCaAKq5LqYzmfoAXmeWxBSFPUeEmX
 1Na7aqbmHOhKQqLoe72VoRrk/GeUOjg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-uqlTzPX_NeWcKjP5y2Nsaw-1; Tue, 15 Oct 2024 10:17:50 -0400
X-MC-Unique: uqlTzPX_NeWcKjP5y2Nsaw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-431248c4380so22478385e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001869; x=1729606669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RY5j2BgNkPWOvoXIyvVFOJpuemGVoag+XCdzDG+fnpA=;
 b=szhgjNln2WTMLE07M+ris4I/SQQ2szPv35P3xWnLrq1WJf+8xvUonQcsYYL66LJ3IA
 v0vdxkMSBm8UqXIHZ2hqMx67Ymcsfbsy0KOLnnp8nZ9Ur9bSmM/7UkwQM+sSkhOHAkLI
 Q5Y7/z87/EOVQj+gqvIlN0/JRPFEx0MaHPZpzKYYwxtYpds2XbPKXtPJQWH7/P3gkvK1
 vriKw68Zgw2u50zp1A5dfZp0QwHYhMJCQ/f+z/OLYUV4mB6GN3cHSGMMgs+jPbaFwqhl
 AWhdoh5bnDkoO/DjfoEGVCEj7rmnM6mFZzVZnlaWvgBD3hq2xJ4Mqkdbx/MAOE+uMEBH
 tN+w==
X-Gm-Message-State: AOJu0YwTaPDlTtjxUgrAktWMbmBCMO5UM4Ql4np5BCh/p2Xg6ZPEleKK
 1WeT1Vn7vj2pn5wdAwh1Wgdb74yp4KgR6nkCQK7cfVezmFMwiZtO/HRIZjjzldC4/NviYLxhuF1
 GuP3rXjL9Ftz88UIJqvk0p3mt7/g10rxwndWTh6VZfMwxW2p0tbyD5MYXCS+mVZIdr34w2KYxGB
 ZSd4csMouAhcQmyb6XEBWRhBIe01G+p0cJDPgRxUk=
X-Received: by 2002:a05:600c:1c04:b0:42c:aeaa:6aff with SMTP id
 5b1f17b1804b1-4311ded42e9mr131288245e9.10.1729001869093; 
 Tue, 15 Oct 2024 07:17:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSLKnsD8MOzY41Lfj0L3+cOeMVc32gvO+OkiEQRaXPiDZi0bMmpAKE0Llezvq6/VVMOgzlnQ==
X-Received: by 2002:a05:600c:1c04:b0:42c:aeaa:6aff with SMTP id
 5b1f17b1804b1-4311ded42e9mr131287885e9.10.1729001868582; 
 Tue, 15 Oct 2024 07:17:48 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f569933sm19445605e9.13.2024.10.15.07.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:17:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PULL 10/25] docs/system: Add recommendations to Hyper-V
 enlightenments doc
Date: Tue, 15 Oct 2024 16:16:56 +0200
Message-ID: <20241015141711.528342-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

From: Vitaly Kuznetsov <vkuznets@redhat.com>

While hyperv.rst already has all currently implemented Hyper-V
enlightenments documented, it may be unclear what is the recommended set to
achieve the best result. Add the corresponding section to the doc.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20240917160051.2637594-5-vkuznets@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/i386/hyperv.rst | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
index 009947e3914..1c1de77feb6 100644
--- a/docs/system/i386/hyperv.rst
+++ b/docs/system/i386/hyperv.rst
@@ -283,6 +283,36 @@ Supplementary features
   feature alters this behavior and only allows the guest to use exposed Hyper-V
   enlightenments.
 
+Recommendations
+---------------
+
+To achieve the best performance of Windows and Hyper-V guests and unless there
+are any specific requirements (e.g. migration to older QEMU/KVM versions,
+emulating specific Hyper-V version, ...), it is recommended to enable all
+currently implemented Hyper-V enlightenments with the following exceptions:
+
+- ``hv-syndbg``, ``hv-passthrough``, ``hv-enforce-cpuid`` should not be enabled
+  in production configurations as these are debugging/development features.
+- ``hv-reset`` can be avoided as modern Hyper-V versions don't expose it.
+- ``hv-evmcs`` can (and should) be enabled on Intel CPUs only. While the feature
+  is only used in nested configurations (Hyper-V, WSL2), enabling it for regular
+  Windows guests should not have any negative effects.
+- ``hv-no-nonarch-coresharing`` must only be enabled if vCPUs are properly pinned
+  so no non-architectural core sharing is possible.
+- ``hv-vendor-id``, ``hv-version-id-build``, ``hv-version-id-major``,
+  ``hv-version-id-minor``, ``hv-version-id-spack``, ``hv-version-id-sbranch``,
+  ``hv-version-id-snumber`` can be left unchanged, guests are not supposed to
+  behave differently when different Hyper-V version is presented to them.
+- ``hv-crash`` must only be enabled if the crash information is consumed via
+  QAPI by higher levels of the virtualization stack. Enabling this feature
+  effectively prevents Windows from creating dumps upon crashes.
+- ``hv-reenlightenment`` can only be used on hardware which supports TSC
+  scaling or when guest migration is not needed.
+- ``hv-spinlocks`` should be set to e.g. 0xfff when host CPUs are overcommited
+  (meaning there are other scheduled tasks or guests) and can be left unchanged
+  from the default value (0xffffffff) otherwise.
+- ``hv-avic``/``hv-apicv`` should not be enabled if the hardware does not
+  support APIC virtualization (Intel APICv, AMD AVIC).
 
 Useful links
 ------------
-- 
2.46.2


