Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1774C25B7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9xP-0000qb-Lv; Thu, 23 May 2024 11:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wt-00089n-I0
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wr-0004vd-Sa
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtNMjeo30umZmHsb3OdqLgoNlGtwryuHoombtfhUSBM=;
 b=Q+sDLC8WOt0k7eyWu+jR1OxA0qdKwGWCXW6u94gpEQF1CDDUt1REAKub/waxYZ7Qax0bxe
 vw3u3ybM+CIzwwgEDdlZerHt4gM1YsO4P0LnyuapTj3q7ecYQvcls0PqTlxgNDRWDYFO7k
 dsYB0iYMF5Q/ywX7Znzhr+7jZK9BfeA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-fV-aEknhNyKV7vAPPq3UGg-1; Thu, 23 May 2024 11:01:39 -0400
X-MC-Unique: fV-aEknhNyKV7vAPPq3UGg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59eea00cafso147623166b.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476497; x=1717081297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xtNMjeo30umZmHsb3OdqLgoNlGtwryuHoombtfhUSBM=;
 b=fEkCrNTldjiVkGvMNIzzqSdWcWWi2kyop+0rW0ECqJfi7PwmgZzzzOnr3csiWq5eGX
 RdGpWgD/mJs8Iwp7jV2juMcHmTHY4UKwsyU2UewLhOp17LLh3ljtMpZl/rgcsVUdLSbZ
 Crs30sxJnG1Rx8PB8PDpznzrOkh/LbC93Im/dHQ89RnAktn0NV2UEbrLyPDCYa0k+lQK
 MInZershq7n7VjiAlANL/wLby4EDentzKN7jMDyV1ALMnlJPhrDTiVf8czmxDz0jNVJq
 P29aFyUX17CZfArRG7PyltHsDd+wUhtxkW+HdqHrVUe3LSMvvrzcNO3kwh++Rbw697Pa
 2Plw==
X-Gm-Message-State: AOJu0YzOV09vpEz4dsgsbicdiEs9ZzenZD7D4u5nxDqPMIyYGzk6g0Lo
 YU0FYVgj+caWJJax8sl7wSor2whwEPj5bx9ghF+kGT/Us8YwZ68mg3VFBG9D5Iaflu3Ajstz00F
 JkOhNEnXQ59KRfpfaFbPr+/YqmpPkBv07gfsCvlJXGaZfqKm2wGFziPIGUR//VpFFkPwdRnyb1Y
 4SHP/IuW+wjN9uNMGlHGZXzOwmv+xCOZxJRVCS
X-Received: by 2002:a17:906:71da:b0:a62:2ef9:141 with SMTP id
 a640c23a62f3a-a622ef902a2mr411232966b.8.1716476496941; 
 Thu, 23 May 2024 08:01:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ1x7xnI163X9uaPg6C1hBgi1X7gfiWcXEUJxWmMCqrUCjI8TvjxfA6Xezwdub5LyZ8/D5TQ==
X-Received: by 2002:a17:906:71da:b0:a62:2ef9:141 with SMTP id
 a640c23a62f3a-a622ef902a2mr411228166b.8.1716476495839; 
 Thu, 23 May 2024 08:01:35 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6214655b23sm422810366b.165.2024.05.23.08.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:01:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: donsheng <dongsheng.x.zhang@intel.com>, Chao Gao <chao.gao@intel.com>,
 qemu-stable@nongnu.org
Subject: [PULL 23/23] target-i386: hyper-v: Correct kvm_hv_handle_exit return
 value
Date: Thu, 23 May 2024 17:00:36 +0200
Message-ID: <20240523150036.1050011-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523150036.1050011-1-pbonzini@redhat.com>
References: <20240523150036.1050011-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: donsheng <dongsheng.x.zhang@intel.com>

This bug fix addresses the incorrect return value of kvm_hv_handle_exit for
KVM_EXIT_HYPERV_SYNIC, which should be EXCP_INTERRUPT.

Handling of KVM_EXIT_HYPERV_SYNIC in QEMU needs to be synchronous.
This means that async_synic_update should run in the current QEMU vCPU
thread before returning to KVM, returning EXCP_INTERRUPT to guarantee this.
Returning 0 can cause async_synic_update to run asynchronously.

One problem (kvm-unit-tests's hyperv_synic test fails with timeout error)
caused by this bug:

When a guest VM writes to the HV_X64_MSR_SCONTROL MSR to enable Hyper-V SynIC,
a VM exit is triggered and processed by the kvm_hv_handle_exit function of the
QEMU vCPU. This function then calls the async_synic_update function to set
synic->sctl_enabled to true. A true value of synic->sctl_enabled is required
before creating SINT routes using the hyperv_sint_route_new() function.

If kvm_hv_handle_exit returns 0 for KVM_EXIT_HYPERV_SYNIC, the current QEMU
vCPU thread may return to KVM and enter the guest VM before running
async_synic_update. In such case, the hyperv_synic test’s subsequent call to
synic_ctl(HV_TEST_DEV_SINT_ROUTE_CREATE, ...) immediately after writing to
HV_X64_MSR_SCONTROL can cause QEMU’s hyperv_sint_route_new() function to return
prematurely (because synic->sctl_enabled is false).

If the SINT route is not created successfully, the SINT interrupt will not be
fired, resulting in a timeout error in the hyperv_synic test.

Fixes: 267e071bd6d6 (“hyperv: make overlay pages for SynIC”)
Suggested-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Dongsheng Zhang <dongsheng.x.zhang@intel.com>
Message-ID: <20240521200114.11588-1-dongsheng.x.zhang@intel.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index f2a3fe650a1..b94f12acc2c 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -81,7 +81,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
          */
         async_safe_run_on_cpu(CPU(cpu), async_synic_update, RUN_ON_CPU_NULL);
 
-        return 0;
+        return EXCP_INTERRUPT;
     case KVM_EXIT_HYPERV_HCALL: {
         uint16_t code = exit->u.hcall.input & 0xffff;
         bool fast = exit->u.hcall.input & HV_HYPERCALL_FAST;
-- 
2.45.1


