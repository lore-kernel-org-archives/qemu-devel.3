Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5E8C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 08:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfFFj-0004TU-PD; Wed, 28 Feb 2024 03:25:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rfFFf-0004Sj-O4
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:25:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rfFFb-0000hH-A1
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709108712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PMcbSI2eFj/4+uTsm6U1a8a5nzik8IKxCw0yyyd+piM=;
 b=VCimnATmE6TtTGBfdEh6brXvMULOc7dGSW9p3ldcv4jUfYtMtoJGq8Fcjwzod7kPuJ0gdm
 3C+bN1+HRIqug1qY3pZG3v/7L2AuoX6woGk4HKZgn++pENlsQE7sWQpCw6dctMEcLsXBpa
 ZYhFU/R5vl6zYbOamuWCVSHJBf6d9+A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-ZgpLAAfvP9ugK83WA7j7zQ-1; Wed, 28 Feb 2024 03:25:10 -0500
X-MC-Unique: ZgpLAAfvP9ugK83WA7j7zQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-412a805f783so11937915e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 00:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709108709; x=1709713509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PMcbSI2eFj/4+uTsm6U1a8a5nzik8IKxCw0yyyd+piM=;
 b=NWsTlmgJ9C/Bx7zSEj+pEuqNeeUWESVk8Z9BznSSmeGYjfvmRCdt+pWkaAYp6QtJa0
 ij12YXIkYB/o9+ZcLabGyhRW8lm5JTUsggjCKEWFWn31CRpsMIflgO/3rInwAEUA86Mt
 u7HzW/dAxzVmCHaMxCHwC2LGu3BccxCMDGDw11OsX9NybboV+h+xEWMcI8MmADPaH/3f
 wxp1YEgfv5BJgJUXp/1ueKzoidunInO9+k8RoHURQSNlsVm0K/z5WyN480/QgckeLJ9i
 frICz1YWynGBYXxohiE49XtcGzBosWiw89DGzR1LoYyiOsKLe5TlQernAKMGc9dStKSm
 oohA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+tq4kyC+us9TrTQqcJmZWuyGcFH7U9iFZ6WN3aop97TeBp9MVJy2b+XZZOBr9M/w8MHfU2a76+73eRKHu4x2D1BYi9rQ=
X-Gm-Message-State: AOJu0YxZ/a6kgeqr/frplq/WWHtrEcraivPl+T7Fz3j7H2QgHaARwICn
 UXitwki5vM1o88MHrERAz/kxCPEzMAAS64ai8EuwuXyoW1HGzW/xk28pexUCHp0E4rp9F22UQnZ
 O6/khlsaVy8qNmMQjTPFMSh6s2eg2RfCBTJ9SlRa4p+Lu3Va3By9V
X-Received: by 2002:a05:600c:4708:b0:412:a333:1d36 with SMTP id
 v8-20020a05600c470800b00412a3331d36mr6456830wmo.32.1709108709717; 
 Wed, 28 Feb 2024 00:25:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLwtUUSIXR5qnN96pRO9wawfFh06U6FrdcOA93/OWlgejy9W7v2yLug+/dkDH1YGO6vsE9rQ==
X-Received: by 2002:a05:600c:4708:b0:412:a333:1d36 with SMTP id
 v8-20020a05600c470800b00412a3331d36mr6456809wmo.32.1709108709360; 
 Wed, 28 Feb 2024 00:25:09 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 jw21-20020a05600c575500b004126afe04f6sm1313531wmb.32.2024.02.28.00.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 00:25:08 -0800 (PST)
Date: Wed, 28 Feb 2024 09:25:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 kraxel@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4] pc: q35: Bump max_cpus to 4096 vcpus
Message-ID: <20240228092507.7250bac8@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240221140227.3886-1-anisinha@redhat.com>
References: <20240221140227.3886-1-anisinha@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 21 Feb 2024 19:32:27 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to all=
ow up to 4096 vCPUs")
> Linux kernel can support upto a maximum number of 4096 vCPUS when MAXSMP =
is
> enabled in the kernel. At present, QEMU has been tested to correctly boot=
 a
> linux guest with 4096 vcpus with edk2 pending various upstream EDK2 fixes
> which will probably be in the 2024-05 release to be released in the coming
> months. With current seabios firmware, it boots fine with 4096 vcpus alre=
ady.
> So bump up the value max_cpus to 4096 for q35 machines versions 9 and new=
er.
> Q35 machines versions 8.2 and older continue to support 1024 maximum vcpus
> as before for compatibility reasons.
>=20
> If KVM is not able to support the specified number of vcpus, QEMU would
> return the following error messages:
>=20
> $ ./qemu-system-x86_64 -cpu host -accel kvm -machine q35 -smp 1728
> qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested (17=
28) exceeds the recommended cpus supported by KVM (12)
> qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus requ=
ested (1728) exceeds the recommended cpus supported by KVM (12)
> Number of SMP cpus requested (1728) exceeds the maximum cpus supported by=
 KVM (1024)
>=20
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Julia Suvorova <jusual@redhat.com>
> Cc: kraxel@redhat.com
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

=46rom ACPI point of view, it can support upto 4096 logical cpus
(for more we would need to reconsider how to generate CPU descriptions
as well as hotplug).

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc_q35.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> Changelog:
> v4: tweaked commit message as per suggestion from danpb explicitly
> stating that 4096 vcpus work with edk2 fixes that are going to be
> available in the coming edk2 release.
> v3: bump up to 4096 vcpus. It has now been tested to work with edk2.
> See RH Jira: https://issues.redhat.com/browse/RHEL-22202
> v2: bump up the vcpu number to 1856. Add failure messages from ekd2 in
> the commit description.
>=20
>=20
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index d346fa3b1d..ae60e6b919 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -366,7 +366,7 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->default_nic =3D "e1000e";
>      m->default_kernel_irqchip_split =3D false;
>      m->no_floppy =3D 1;
> -    m->max_cpus =3D 1024;
> +    m->max_cpus =3D 4096;
>      m->no_parallel =3D !module_object_class_by_name(TYPE_ISA_PARALLEL);
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
> @@ -387,6 +387,7 @@ static void pc_q35_8_2_machine_options(MachineClass *=
m)
>  {
>      pc_q35_9_0_machine_options(m);
>      m->alias =3D NULL;
> +    m->max_cpus =3D 1024;
>      compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
>      compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
>  }


