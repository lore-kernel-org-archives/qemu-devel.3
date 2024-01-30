Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F6DC47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 22:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUwQB-0006eA-0q; Tue, 30 Jan 2024 17:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rUwQ8-0006ds-VT
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 17:17:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rUwPu-0001ly-Uz
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 17:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706653034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j0v0CMOCukSqMBLlPOWhg/qFfqS//OoKrxUIH/oIz3Y=;
 b=SSWaqFCktbsa4zX4FydgfuJkK0cDQ2awr4G9490/GPrkiRFOcFLteKfF/gUS1itsagQi8S
 Dh264tGLGTVINuE/rcK2WDP4BB3HudZoL5LOHF6qRfag5nz4oSb64+NdHVKbxX83UbSMvm
 neiPaMhghOvr+S0mZnHgzIHUkJxaD4U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-SMdPmU_pOBKEf4jZvxxX6w-1; Tue, 30 Jan 2024 17:17:13 -0500
X-MC-Unique: SMdPmU_pOBKEf4jZvxxX6w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33af0c634afso1057555f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 14:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706653032; x=1707257832;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j0v0CMOCukSqMBLlPOWhg/qFfqS//OoKrxUIH/oIz3Y=;
 b=q41JwaD8ZLTOJuW1THg6FricZiKeRH7BwJkfi7oIdBP7DzZfqJMe3SAu2Eu1BYt1lW
 jHL4GM3eii7JgMoOvDbiLc08DG7poh7VJAqCuwOmmQ1JI2qdFrAsTOCXWyZbBKRQzsjL
 1J/0loDaAz9SH98ZYfKEyh8sfljTjrh2+igAwzI3XVF7WuguY/RNQiOKTMaNY8w2UoQ6
 SCgPxod44MYXOkpBfKcgzg+2Gus6ir/poS8APiXTs7fi1+2Otpa+JhZvqh8BZLzWFa61
 7xMv1DFbx3wHRjZrJuS2yy6BFR1uyfzLvtjYzWLU/yOFfIqgP+StktMbLjE4sNPHSNg3
 nbBQ==
X-Gm-Message-State: AOJu0YyuVumojvinqr1/Jm1Ftbj15gitvUmoqA19b12C8iG5k/qkLy0B
 LBs6eUtRfY9cY+sWKEskHiL6g/ma3IFVRs3OaNX8Ui6tWmwNqAUcIkkC+d4quGPNQ7OyGTLgq11
 UMSF3zIjcSO8tVvOGZcBebddTeHfklZNGn7dgHV+cIUXFh69TjMRQ
X-Received: by 2002:adf:ca84:0:b0:337:c4b3:e03e with SMTP id
 r4-20020adfca84000000b00337c4b3e03emr6538932wrh.1.1706653032110; 
 Tue, 30 Jan 2024 14:17:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJjjkmF/sxAxhf2BO2zu7KW6Mk8dcXAW98hkmbgpoCcR8beHz0PDi40yeZ3aRV2lgqTDUIVw==
X-Received: by 2002:adf:ca84:0:b0:337:c4b3:e03e with SMTP id
 r4-20020adfca84000000b00337c4b3e03emr6538924wrh.1.1706653031686; 
 Tue, 30 Jan 2024 14:17:11 -0800 (PST)
Received: from redhat.com ([2.52.129.159]) by smtp.gmail.com with ESMTPSA id
 p7-20020a5d4587000000b0033af670213dsm3475297wrq.110.2024.01.30.14.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 14:17:10 -0800 (PST)
Date: Tue, 30 Jan 2024 17:17:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: =?iso-8859-1?Q?=22Daniel_P=2E_Berrang=E9=22?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] pc: q35: Bump max_cpus to 1728 vcpus
Message-ID: <20240130171615-mutt-send-email-mst@kernel.org>
References: <20240130164428.35955-1-anisinha@redhat.com>
 <ZbkoOAPo7gmFZw4g@redhat.com>
 <4CEF526A-5B22-41EA-8634-D4BB5871B739@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4CEF526A-5B22-41EA-8634-D4BB5871B739@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Jan 30, 2024 at 10:39:51PM +0530, Ani Sinha wrote:
> 
> 
> > On 30-Jan-2024, at 22:17, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > 
> > On Tue, Jan 30, 2024 at 10:14:28PM +0530, Ani Sinha wrote:
> >> Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to allow up to 4096 vCPUs")
> >> Linux kernel can support upto a maximum number of 4096 vCPUS when MAXSMP is
> >> enabled in the kernel. QEMU has been tested to correctly boot a linux guest
> >> with 1728 vcpus both with edk2 and seabios firmwares. So bump up the max_cpus
> >> value for q35 machines versions 9 and newer to 1728. Q35 machines versions
> >> 8.2 and older continue to support 1024 maximum vcpus as before for
> >> compatibility.
> > 
> > Where does the 1728 number come from ?
> > 
> > Did something break at 1729, or did the test machine simply not
> > have sufficient resources to do practical larger tests ?
> 
> Actual limit currently is 1856 for EDK2. The HPE folks tested QEMU with edk2 and QEMU fails to boot beyond that limit.
> There are RH internal bugs tracking this and Gerd is working on it from RH side [1].
> 
> We would ultimately like to go to 8192 vcpus for SAP HANA but 1728 vcpus is our immediate target for now. If you want, I can resend the patch with 1856 since that is currently the tested limit.
> 
> 1. https://issues.redhat.com/browse/RHEL-22202

What is requested here is that you document the source of the number whatever
it is in a code comment and commit log.


> 
> > 
> >> 
> >> If KVM is not able to support the specified number of vcpus, QEMU would
> >> return the following error messages:
> >> 
> >> $ ./qemu-system-x86_64 -cpu host -accel kvm -machine q35 -smp 1728
> >> qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested (1728) exceeds the recommended cpus supported by KVM (12)
> >> qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus requested (1728) exceeds the recommended cpus supported by KVM (12)
> >> Number of SMP cpus requested (1728) exceeds the maximum cpus supported by KVM (1024)
> >> 
> >> Cc: Daniel P. Berrangé <berrange@redhat.com>
> >> Cc: Igor Mammedov <imammedo@redhat.com>
> >> Cc: Michael S. Tsirkin <mst@redhat.com>
> >> Cc: Julia Suvorova <jusual@redhat.com>
> >> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >> ---
> >> hw/i386/pc_q35.c | 3 ++-
> >> 1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> >> index f43d5142b8..bfa627a70b 100644
> >> --- a/hw/i386/pc_q35.c
> >> +++ b/hw/i386/pc_q35.c
> >> @@ -375,7 +375,7 @@ static void pc_q35_machine_options(MachineClass *m)
> >>     m->default_nic = "e1000e";
> >>     m->default_kernel_irqchip_split = false;
> >>     m->no_floppy = 1;
> >> -    m->max_cpus = 1024;
> >> +    m->max_cpus = 1728;
> >>     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
> >>     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
> >>     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
> >> @@ -396,6 +396,7 @@ static void pc_q35_8_2_machine_options(MachineClass *m)
> >> {
> >>     pc_q35_9_0_machine_options(m);
> >>     m->alias = NULL;
> >> +    m->max_cpus = 1024;
> >>     compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
> >>     compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
> >> }
> >> -- 
> >> 2.42.0
> >> 
> > 
> > With regards,
> > Daniel
> > -- 
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 


