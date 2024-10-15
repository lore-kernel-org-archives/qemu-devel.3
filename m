Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824C7D216AD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iN7-0005u2-8X; Tue, 15 Oct 2024 10:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iN3-0005qe-Hc
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iMz-0003JT-Qe
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJ4qfhZxsv3YBzmqYAVoQoEA6or3SG9mpeat+so4UiY=;
 b=IXGfkD9fvYJmT3zvTe9BWbCxGQvIrckdlYwwn4IIDDotusvEQwwl3RA/2RKaWTz3wCFwD4
 88YxVxq7eirihbzDnxCUgMFbrCECDyP7GU9lfMM60/mgApixdAfB9KNtJG9Z5ZvbOb+Xkr
 z2vYbBF3HPpMcdacJJDulDXC1S2TXCY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-65W-W4KMM2CysmbbEjtXTA-1; Tue, 15 Oct 2024 10:17:48 -0400
X-MC-Unique: 65W-W4KMM2CysmbbEjtXTA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4312731c7bfso16857195e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001866; x=1729606666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJ4qfhZxsv3YBzmqYAVoQoEA6or3SG9mpeat+so4UiY=;
 b=NADxYlNBO3mZwNAwmdKPYvH7oLTvljdmIqpL3Dw8fcWyhRvZhimFnLaYWsyba4sByf
 s7P54mkEq57rvBrJ8BlD+HLFs2wvTciYH796D84rKMTSZ1Mi8C5x00n43nN/9Cz8eUAT
 T3WkVs/igxyj9H+I7xu4R7/jOXv+igcXeyYjFTe6rPlGetdyZLKWMIVa/NXVYD7a5veO
 lMmyWzFKz2Z6WUcihmvzD5P37X2LZ04mHYFc3RE7VUfjwHnWF4+spuH020H+dT3yxBOi
 p7KgvqmJ75/hdb5fHeFXeexne4XKBxlA7ZAND9BU6Aa+YeSzWzN4L/vZagJmabrr2vg3
 soHw==
X-Gm-Message-State: AOJu0Yx2jp25nUw9Iw4LM8Z9mY+UXl8lAGswmqpJTTpJ8jYtd+lv2pe0
 GieU8TP+X+MaXhmlhyKPqmzZiJ+71q/DBT4oqKzHp45wtM6NpUVXBsqnDus8ONnZs8V5dSPqeg7
 RztR1ANkp5pa26udJGQ7mOYYSk/PLKOF6xAMeRtA5r3MtRT3JzL9mMv38mgtQzS+KDvRyMJtuVO
 AOkgA2SE/lC/eTgayWUX2EA1iIm/dlW/6IMFsVXHs=
X-Received: by 2002:a5d:5f93:0:b0:374:c640:8596 with SMTP id
 ffacd0b85a97d-37d86be330dmr398396f8f.32.1729001864948; 
 Tue, 15 Oct 2024 07:17:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3Wlag/oTN06aQXI+u8JbXu+pytr6tgRnHWPC+UgC7HhxNauijCS4dqweQd2VUaCho+C/zkA==
X-Received: by 2002:a5d:5f93:0:b0:374:c640:8596 with SMTP id
 ffacd0b85a97d-37d86be330dmr398374f8f.32.1729001864429; 
 Tue, 15 Oct 2024 07:17:44 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc12dbcsm1712144f8f.96.2024.10.15.07.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:17:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Jan Richter <jarichte@redhat.com>
Subject: [PULL 09/25] target/i386: Make sure SynIC state is really updated
 before KVM_RUN
Date: Tue, 15 Oct 2024 16:16:55 +0200
Message-ID: <20241015141711.528342-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

'hyperv_synic' test from KVM unittests was observed to be flaky on certain
hardware (hangs sometimes). Debugging shows that the problem happens in
hyperv_sint_route_new() when the test tries to set up a new SynIC
route. The function bails out on:

 if (!synic->sctl_enabled) {
         goto cleanup;
 }

but the test writes to HV_X64_MSR_SCONTROL just before it starts
establishing SINT routes. Further investigation shows that
synic_update() (called from async_synic_update()) happens after the SINT
setup attempt and not before. Apparently, the comment before
async_safe_run_on_cpu() in kvm_hv_handle_exit() does not correctly describe
the guarantees async_safe_run_on_cpu() gives. In particular, async worked
added to a CPU is actually processed from qemu_wait_io_event() which is not
always called before KVM_RUN, i.e. kvm_cpu_exec() checks whether an exit
request is pending for a CPU and if not, keeps running the vCPU until it
meets an exit it can't handle internally. Hyper-V specific MSR writes are
not automatically trigger an exit.

Fix the issue by simply raising an exit request for the vCPU where SynIC
update was queued. This is not a performance critical path as SynIC state
does not get updated so often (and async_safe_run_on_cpu() is a big hammer
anyways).

Reported-by: Jan Richter <jarichte@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20240917160051.2637594-4-vkuznets@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/hyperv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index b94f12acc2c..70b89cacf94 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -80,6 +80,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
          * necessary because memory hierarchy is being changed
          */
         async_safe_run_on_cpu(CPU(cpu), async_synic_update, RUN_ON_CPU_NULL);
+        cpu_exit(CPU(cpu));
 
         return EXCP_INTERRUPT;
     case KVM_EXIT_HYPERV_HCALL: {
-- 
2.46.2


