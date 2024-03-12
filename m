Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0B6C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5hx-0008SY-1o; Tue, 12 Mar 2024 13:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk5hv-0008SN-8z
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 13:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk5ht-0002hO-LI
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 13:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710263668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1VCZN46NWcj5S9HthzW9vZvsQBJ96s3KYdr/dNzsH5c=;
 b=Aj/hCkPaL8wexs5OJGYfqaYMSSQmlinF5YrnYFFiW5TUDzj3LbY7ZicFGYPlKUm+USCwoU
 yqqEl7orw9xGwRTNBtxnZeMOZ3eX7YErS4pM+hJOwWMEyxDHRfWwjznQM2J/Hhaewq7q9W
 09Z31ElZEX+8OeQ8n92ZIV4PvEQ61Hg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-e8ufA2EfNL6sJb-_Y17jMA-1; Tue, 12 Mar 2024 13:14:27 -0400
X-MC-Unique: e8ufA2EfNL6sJb-_Y17jMA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-412db0e24aeso944185e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 10:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710263666; x=1710868466;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1VCZN46NWcj5S9HthzW9vZvsQBJ96s3KYdr/dNzsH5c=;
 b=tfZ3YhmEuAVMVSVDxRrqVUcwe46h156s0F9de6Ks9/n7k3sxVEHXWe5MDIppSKpD1a
 m3gwFhOL7A0zhs/GUdc3GQmOA+N9Qd5pgPFxKGV8V6Zu9CXc7EYKTBxddxB+UtemTDwN
 CFrETL8nvH+JalIZvWD2vIfhcPVrs5wIZpuKfotcUfqTGcOBxfeJGA1ZkW1fL3Taoy35
 zSb4pY16r/bLhN6Rz5lcsRI5II5OoVUmsCZlFMeE88d7QkU+XBcqHOPWU2n6QqMk81SY
 RJ2bpKb6mIt8hzVrGr7vZ1dzimw1kitoTBYZOf0bFieQ1Di5PUxYpoNM4e0EimGrnTXi
 Smzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPaIKUuCGkLye2GRX8y9Q7zJUiVnaDtiXZ0VeIcqR7TfzjgH9UjnqzOyJq7RTRdl97TlNLovfffIrLhsD+dguqghKbt3c=
X-Gm-Message-State: AOJu0YwG8H+9FP18jKgQqT9Kbj1nx0e5FKEKVn7j9AGSLwwuAZQ1IAgq
 pfG1erH+8ixheqr8IAJDOXEcqMQkHXYJh6yEwRrsFIlz6euICQZxlW+CpGOslvK8M/w6gT5ds+5
 jjIgQNSZ5JNGasxLj0YBs4K1ETlCHdvo1jZV166gHOcK21uULrSnt
X-Received: by 2002:a05:600c:3109:b0:413:1bb9:1b9e with SMTP id
 g9-20020a05600c310900b004131bb91b9emr3213680wmo.21.1710263665899; 
 Tue, 12 Mar 2024 10:14:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz9DZZCNXE2k9LyP4PdfNxJdbhZvUzl2YbV1MgfEJ1WTo1PBhVNj0G3DLzYk1tfe0qMG7hPA==
X-Received: by 2002:a05:600c:3109:b0:413:1bb9:1b9e with SMTP id
 g9-20020a05600c310900b004131bb91b9emr3213649wmo.21.1710263665322; 
 Tue, 12 Mar 2024 10:14:25 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 fb4-20020a05600c520400b00413294ddb72sm7863394wmb.20.2024.03.12.10.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:14:24 -0700 (PDT)
Date: Tue, 12 Mar 2024 13:14:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?iso-8859-1?B?IkRhbmllbCBQIC4gQmVycmFuZ+ki?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5] pc: q35: Bump max_cpus to 4096 vcpus
Message-ID: <20240312131413-mutt-send-email-mst@kernel.org>
References: <20240228143351.3967-1-anisinha@redhat.com>
 <8F921979-45DC-4235-9F6E-8F54DDE33FB7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8F921979-45DC-4235-9F6E-8F54DDE33FB7@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Mar 12, 2024 at 12:04:37PM +0530, Ani Sinha wrote:
> 
> 
> > On 28-Feb-2024, at 20:03, Ani Sinha <anisinha@redhat.com> wrote:
> > 
> > Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to allow up to 4096 vCPUs")
> > Linux kernel can support upto a maximum number of 4096 vcpus when MAXSMP is
> > enabled in the kernel. At present, QEMU has been tested to correctly boot a
> > linux guest with 4096 vcpus using the current edk2 upstream master branch that
> > has the fixes corresponding to the following two PRs:
> > 
> > https://github.com/tianocore/edk2/pull/5410
> > https://github.com/tianocore/edk2/pull/5418
> > 
> > The changes merged into edk2 with the above PRs will be in the upcoming 2024-05
> > release. With current seabios firmware, it boots fine with 4096 vcpus already.
> > So bump up the value max_cpus to 4096 for q35 machines versions 9 and newer.
> > Q35 machines versions 8.2 and older continue to support 1024 maximum vcpus
> > as before for compatibility reasons.
> > 
> > If KVM is not able to support the specified number of vcpus, QEMU would
> > return the following error messages:
> > 
> > $ ./qemu-system-x86_64 -cpu host -accel kvm -machine q35 -smp 1728
> > qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested (1728) exceeds the recommended cpus supported by KVM (12)
> > qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus requested (1728) exceeds the recommended cpus supported by KVM (12)
> > Number of SMP cpus requested (1728) exceeds the maximum cpus supported by KVM (1024)
> > 
> > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Julia Suvorova <jusual@redhat.com>
> > Cc: kraxel@redhat.com
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> 
> Ping .. who is picking this up? The soft code freeze starts today?


I did.

> > ---
> > hw/i386/pc_q35.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > Changelog:
> > v5: mention the PRs in the commit message. Add tags.
> > v4: tweaked commit message as per suggestion from danpb explicitly
> > stating that 4096 vcpus work with edk2 fixes that are going to be
> > available in the coming edk2 release.
> > v3: bump up to 4096 vcpus. It has now been tested to work with edk2.
> > See RH Jira: https://issues.redhat.com/browse/RHEL-22202
> > v2: bump up the vcpu number to 1856. Add failure messages from ekd2 in
> > the commit description.
> > 
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index 45a4102e75..df63a92b78 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -350,7 +350,7 @@ static void pc_q35_machine_options(MachineClass *m)
> >     m->default_nic = "e1000e";
> >     m->default_kernel_irqchip_split = false;
> >     m->no_floppy = 1;
> > -    m->max_cpus = 1024;
> > +    m->max_cpus = 4096;
> >     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
> >     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
> >     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
> > @@ -371,6 +371,7 @@ static void pc_q35_8_2_machine_options(MachineClass *m)
> > {
> >     pc_q35_9_0_machine_options(m);
> >     m->alias = NULL;
> > +    m->max_cpus = 1024;
> >     compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
> >     compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
> > }
> > -- 
> > 2.42.0
> > 


