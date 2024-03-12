Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7791C54E49
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 06:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjvjI-0002Sq-Vr; Tue, 12 Mar 2024 02:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rjvjH-0002Po-DG
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 02:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rjvjD-0007p7-AP
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 02:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710225309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eBymwbgPeuBPCSYJOcJrGFVUmq22EB8PlJ1s5HaAJJI=;
 b=YlN7DmYhmYkqmO+ZIxog0xfrRavJCtCY7abDCVw0anGMbnX+kkmSTO8LRnMJ9cqp1KlQBq
 nO5/d/Gq51WF+mWFR53d+9jBIWr4eOH0fXl4UofVrgh8mDsXi3fTXvmq3yzjRxzjGKGSr7
 ngIhaKEiwY8rtmzo7d0cG/VdxwKzXUQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-J646YV62NqeMv-fTlBEBBw-1; Tue, 12 Mar 2024 02:34:54 -0400
X-MC-Unique: J646YV62NqeMv-fTlBEBBw-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5dbddee3694so3073625a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 23:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710225294; x=1710830094;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eBymwbgPeuBPCSYJOcJrGFVUmq22EB8PlJ1s5HaAJJI=;
 b=C3R8m7qqZcSurJqauZmHrB5v20b7AvBr723xUYVM/Kg6sSjWe1Z6iVv8qKFr1Ssedb
 Dx9bNFS6Pu4ZsEB4/KIVCbTT5qfkV/mIrO4uAjR5lPBEHX+XQ1iJlq2f1cpF2+GIAm5E
 LvrGC7Iv6wl6mkeemMaDAevoSN46mOM3JDFuMza4jlsuMZmOu29ChpHEZv4luQxDgbPs
 ggyKDUjkx9Y69Punc1JeCLqnkssE8SiVDdKxuYaD2OUYgiUdWfuswi6FJPhUq3ENDPXh
 5lkSVEVAKM7OuvAfTHl2NeCRnT3LXgNL23BwKJNxmQCmvhYyYn4QdFUQFldWNBMMAhxy
 RmQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEAMmRwGGjdxeF/Ysl5C+zn46YhYzihLC1nNOxVKcjF5/yjIpRzIbF4382lF/ZFkT/WE68jqGtQTxbRdq8MT0WKmixtbA=
X-Gm-Message-State: AOJu0YzgMn48vJtZbJ7T5pG8166YJLjw5fumwJHdZ87/G1SInBUWxvGj
 6eyTkBIX9Pt7WFedyorpKUdweRjlnx+tzYeUMGidQgTaBirawS4hP/0277VcgzfK8jhiuhM7s7E
 vJGrhZoO/bDc0PLEwP+up5PRuPftFoI6oP9j4h0oRx+QpdusUZI44
X-Received: by 2002:a17:90a:c586:b0:29a:9dd1:d45b with SMTP id
 l6-20020a17090ac58600b0029a9dd1d45bmr12430115pjt.3.1710225293708; 
 Mon, 11 Mar 2024 23:34:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrVgr4rNs1Y7D80gfJJ8vjkgKeB+HDYSv9r8IunYDqSt3uT/Kxn+9Mr+zfEA670hS4N88wMg==
X-Received: by 2002:a17:90a:c586:b0:29a:9dd1:d45b with SMTP id
 l6-20020a17090ac58600b0029a9dd1d45bmr12430095pjt.3.1710225293284; 
 Mon, 11 Mar 2024 23:34:53 -0700 (PDT)
Received: from smtpclient.apple ([115.96.117.102])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a17090a130300b0029b1ce04ca0sm4998537pja.32.2024.03.11.23.34.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Mar 2024 23:34:52 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v5] pc: q35: Bump max_cpus to 4096 vcpus
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240228143351.3967-1-anisinha@redhat.com>
Date: Tue, 12 Mar 2024 12:04:37 +0530
Cc: =?utf-8?Q?=22Daniel_P_=2E_Berrang=C3=A9=22?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8F921979-45DC-4235-9F6E-8F54DDE33FB7@redhat.com>
References: <20240228143351.3967-1-anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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



> On 28-Feb-2024, at 20:03, Ani Sinha <anisinha@redhat.com> wrote:
>=20
> Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to =
allow up to 4096 vCPUs")
> Linux kernel can support upto a maximum number of 4096 vcpus when =
MAXSMP is
> enabled in the kernel. At present, QEMU has been tested to correctly =
boot a
> linux guest with 4096 vcpus using the current edk2 upstream master =
branch that
> has the fixes corresponding to the following two PRs:
>=20
> https://github.com/tianocore/edk2/pull/5410
> https://github.com/tianocore/edk2/pull/5418
>=20
> The changes merged into edk2 with the above PRs will be in the =
upcoming 2024-05
> release. With current seabios firmware, it boots fine with 4096 vcpus =
already.
> So bump up the value max_cpus to 4096 for q35 machines versions 9 and =
newer.
> Q35 machines versions 8.2 and older continue to support 1024 maximum =
vcpus
> as before for compatibility reasons.
>=20
> If KVM is not able to support the specified number of vcpus, QEMU =
would
> return the following error messages:
>=20
> $ ./qemu-system-x86_64 -cpu host -accel kvm -machine q35 -smp 1728
> qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested =
(1728) exceeds the recommended cpus supported by KVM (12)
> qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus =
requested (1728) exceeds the recommended cpus supported by KVM (12)
> Number of SMP cpus requested (1728) exceeds the maximum cpus supported =
by KVM (1024)
>=20
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Julia Suvorova <jusual@redhat.com>
> Cc: kraxel@redhat.com
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Ping .. who is picking this up? The soft code freeze starts today?

> ---
> hw/i386/pc_q35.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> Changelog:
> v5: mention the PRs in the commit message. Add tags.
> v4: tweaked commit message as per suggestion from danpb explicitly
> stating that 4096 vcpus work with edk2 fixes that are going to be
> available in the coming edk2 release.
> v3: bump up to 4096 vcpus. It has now been tested to work with edk2.
> See RH Jira: https://issues.redhat.com/browse/RHEL-22202
> v2: bump up the vcpu number to 1856. Add failure messages from ekd2 in
> the commit description.
>=20
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 45a4102e75..df63a92b78 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -350,7 +350,7 @@ static void pc_q35_machine_options(MachineClass =
*m)
>     m->default_nic =3D "e1000e";
>     m->default_kernel_irqchip_split =3D false;
>     m->no_floppy =3D 1;
> -    m->max_cpus =3D 1024;
> +    m->max_cpus =3D 4096;
>     m->no_parallel =3D =
!module_object_class_by_name(TYPE_ISA_PARALLEL);
>     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
>     machine_class_allow_dynamic_sysbus_dev(m, =
TYPE_INTEL_IOMMU_DEVICE);
> @@ -371,6 +371,7 @@ static void =
pc_q35_8_2_machine_options(MachineClass *m)
> {
>     pc_q35_9_0_machine_options(m);
>     m->alias =3D NULL;
> +    m->max_cpus =3D 1024;
>     compat_props_add(m->compat_props, hw_compat_8_2, =
hw_compat_8_2_len);
>     compat_props_add(m->compat_props, pc_compat_8_2, =
pc_compat_8_2_len);
> }
> --=20
> 2.42.0
>=20


