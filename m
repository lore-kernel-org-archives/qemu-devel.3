Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0BAC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 13:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhpf2-0007ce-S1; Fri, 01 Aug 2025 09:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uhpAu-0000RZ-Co
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 08:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uhpAs-0008Dh-FC
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 08:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754052466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vK74VgwjVRYVxScqgxFCsc4WuhtXiMx5GVE9Xafoi1g=;
 b=hOrLxRKO53kobQm3dEs29oaNoti2oHohzoj64YLcwQzCjm0ImsybWquGrCyocMZ+3Xs0ZC
 HDfU1p0F/8Ykc50NSXZeL6pC9NteLefTkiKVB4+1V7HeDiCKEE0oXiF/m72ZiPSoNgneBW
 CJ+7yOO1UWG6BnMvYNetLMBzR+OBArE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-aNCQbElQO4-ehXuma-CVDw-1; Fri, 01 Aug 2025 08:47:45 -0400
X-MC-Unique: aNCQbElQO4-ehXuma-CVDw-1
X-Mimecast-MFC-AGG-ID: aNCQbElQO4-ehXuma-CVDw_1754052464
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451d3f03b74so10709025e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 05:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754052464; x=1754657264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vK74VgwjVRYVxScqgxFCsc4WuhtXiMx5GVE9Xafoi1g=;
 b=LjQPvyp0uWUtGOMTUnNgYnaAJ7FY7yjTRe2koO3THPlV0s8pxDEWWogzCLk5VnjsqY
 6AcjiXW+XQaqUrAzGuRPBda9xmU6SQIFbfG8tg0j6afqAKXmjjk3d7tPeI+Ov5l8gX/O
 NAPT4pC8kXd0hPx7yC682Ji+UxwhcyRlgg3NiCLIA/MADvjlGDEPlI7xddKimWQJvKLs
 sbz0rfdqjb+U1recIVKipFgjFNkFMAhkSBP7g9INfLsBMC5xhVmhFDf5r5kGqhlvumK4
 NPtuB99az0BfVa5H1U6aud+RQtUZFHtqBx/gtIwd8GH7v4xcDTZPVc3eYRUzuRlB/N1v
 zNoQ==
X-Gm-Message-State: AOJu0Yw0fz8B5k2hg6R1kUMKE7VOJE3BEH0Vkng4sRNDJeRttimkvkRz
 Gnz9Av++ktUmaQvrE5+oOVvb4EEv3GQIdDK8bvDS/7Hlg7Gxwm3wzhGWCoWlhldDv3sM2AKg1xL
 szkpEyKSENoPcnxIp90w0hKrll46GOLp+v4nsblPMFK6bQRg5VBceNNVkOBZKh7I5
X-Gm-Gg: ASbGncuvSE5yBH3CiwsSnw8DCyG+XDkghp3ZuUod2sKy1+ZUWcaFuELhogIBYB/Kq7z
 dayBx4CvWjkmGug7WsHJvLwCF1ARpAUj9x4WLscyaCdMV+Rt1JzN44vQCgpzQXSAUGQEOa+o/j5
 XQHXW5dAR98q/hWlPkJrzHwYsjrCUEP3MJfrnUTxDW0iHWw3FhZu+gu7aYxXYDFvvebkkYRT21l
 DHoE9wUNkHPa1p5VnHzAxOgLULOyxaDB3Hsavc1cLQrLe9YMp2Mbl8ZkmV2CaiHa+nmaAqD2CPv
 E7Zeaxkn5+vumu3v50JwuVZgw1zibw==
X-Received: by 2002:a05:600c:1d98:b0:441:d4e8:76c6 with SMTP id
 5b1f17b1804b1-45892be170dmr120438805e9.30.1754052463818; 
 Fri, 01 Aug 2025 05:47:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh5zczqRcH57ZtIL1tobg80Nw9jq2P7YgVV0jredjQp1RYYZuuwAP5QRAbkDxT6dnP0peLOw==
X-Received: by 2002:a05:600c:1d98:b0:441:d4e8:76c6 with SMTP id
 5b1f17b1804b1-45892be170dmr120438495e9.30.1754052463360; 
 Fri, 01 Aug 2025 05:47:43 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953cff16sm103229375e9.19.2025.08.01.05.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 05:47:42 -0700 (PDT)
Date: Fri, 1 Aug 2025 14:47:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v2 6/6] kvm: i386: irqchip: take BQL only if there is an
 interrupt
Message-ID: <20250801144741.1f9dc351@fedora>
In-Reply-To: <8edc80d5-49a0-4e4d-82c4-e4a18eb78304@redhat.com>
References: <20250730123934.1787379-1-imammedo@redhat.com>
 <20250730123934.1787379-7-imammedo@redhat.com>
 <8edc80d5-49a0-4e4d-82c4-e4a18eb78304@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 1 Aug 2025 12:26:26 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> The patch is not wrong but complicates things more than it should.
> 
> Also, as we do more of these tricks it may be worth adding wrapper APIs 
> for interrupt_request access, but that needs to be done tree-wide so you 
> can do it separately.

Thanks,
I'll respin this with minimal changes for this series
and post another one on top with tree wide refactoring as suggested

> 
> On 7/30/25 14:39, Igor Mammedov wrote:
> >      if (cpu->interrupt_request & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
> > +        if (!kvm_pic_in_kernel()) {
> > +            bql_lock();
> > +            release_bql = true;
> > +        }  
> 
> This bql_lock() is not needed, all the writes in the "if" are local to 
> the current CPU.
> 
> When the outer bql_lock() was added, cpu_interrupt() was not thread-safe 
> at all, and taking the lock was needed in order to read 
> cpu->interrupt_request.  But now it is ok to read outside the lock, 
> which you can use to simplify this patch a lot.
> 
> >          if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
> >              !(env->hflags & HF_SMM_MASK)) {
> >              cpu->exit_request = 1;  
> 
> A patch that changes all these accesses to 
> qatomic_set(&cpu->exit_request, 1), tree-wide, would be nice.
> 
> > +        if (cpu->interrupt_request & CPU_INTERRUPT_HARD) {  
> 
> This should be qatomic_read(&cpu->interrupt_request).  Not a blocker for 
> now, but this is where I would suggest adding a wrapper like 
> cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD).
> 
> > +            if (!release_bql) {
> > +                bql_lock();
> > +                release_bql = true;
> > +            }  
> 
> With the above simplification, this can be done unconditionally.
> 
> > +            /* Try to inject an interrupt if the guest can accept it */
> > +            if (run->ready_for_interrupt_injection &&
> > +                (cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
> > +                (env->eflags & IF_MASK)) {
> > +                int irq;
> > +
> > +                cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;  
> 
> Reads and writes to cpu->interrupt_request still take the BQL, which is 
> consistent with include/hw/core/cpu.h, so yeah here the bql_lock() is 
> needed.
> 
> Like above, writing it's a data race with readers outside the BQL, so 
> qatomic_read()/qatomic_set() would be needed to respect the C standard. 
> Even better could be to add a function cpu_reset_interrupt_locked() that 
> does
> 
>     assert(bql_locked());
>     qatomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
> 
> But neither of these wrappers (which should be applied tree-wide) are an 
> absolute necessity for this series.
> 
> > @@ -5531,7 +5540,14 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
> >   
> >           DPRINTF("setting tpr\n");
> >           run->cr8 = cpu_get_apic_tpr(x86_cpu->apic_state);
> > +        /*
> > +         * make sure that request_interrupt_window/cr8 are set
> > +         * before KVM_RUN might read them
> > +         */
> > +        smp_mb();  
> 
> This is not needed, ->cr8 is only read for the same CPU (in 
> kvm_arch_vcpu_ioctl_run).
> 
> > +    }
> >   
> > +    if (release_bql) {
> >           bql_unlock();
> >       }  
> 
> And since release_bql is not needed anymore, the bql_unlock() can be 
> left where it was.
> 
> Paolo
> 
> >   }  
> 


