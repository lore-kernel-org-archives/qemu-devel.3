Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052A9C47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 17:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUrcz-0002cJ-TT; Tue, 30 Jan 2024 12:10:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rUrcw-0002c1-TA
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 12:10:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rUrci-0003KQ-Kj
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 12:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706634611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f4gyiL6GBsxrat1t5YGcpkO/qMN8yCeTRlhpWQp3Dqg=;
 b=DNHnnN0QITRewkHvaRXYCWAE0uNn4Ubsvdx/6gqDlF4I5NsjuPY9BdjRqA+KwFN1YDyOCu
 HEcBhTwvwnzAA9/GgYnB56oM8K7EPFY5dum4x/jvIqqhfWkBKsg0qBdJ3wRQ3SZyiYkWkF
 jej3+nKhyYjroJB+hXgbKKiU5mVFPrg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-Q3wtYW5BMsmPB6Lu-ypTmg-1; Tue, 30 Jan 2024 12:10:08 -0500
X-MC-Unique: Q3wtYW5BMsmPB6Lu-ypTmg-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6dde04e1b6aso2311626b3a.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 09:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706634607; x=1707239407;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f4gyiL6GBsxrat1t5YGcpkO/qMN8yCeTRlhpWQp3Dqg=;
 b=HUTF+XNUVKhkkhnGud2vkVws2RYdLozPG4ImuEPbDbIOVPn3E7AOymrVVai7PXQrwW
 Fil6OLV29hB/jsAoT2KBNwCgFpuOztrce6Fe0twgBWpkMHuxsGsb9BX/bNlMC6AptEmI
 WHT6toL0pKepYPUESUXKCWo/sS079U/5BPDQ40q5ihIwDi7fMeBINRVEiwkFwxHwU9I+
 k0ao/RCrQr/aQmzQ9ljkj5qs2zJP/ksAX4ksEJyk5Fb2pcgp7EXYt3hmiKhe1RzL5a6d
 HuiO9mGcQJfhbMId/COD0Y15i5bS90fyrScU/TTQyhGszxPuqnG2NzfpOkT23QjX4arF
 jtYg==
X-Gm-Message-State: AOJu0Yx0dkql4V1Uqjl+y755+E7Xqz1M7zSPxbglTuZ5FSVmLmS/fi+B
 9c807+D16W4fP2+lbjV2pbSdUOe5YkuL3G/XOPYRETSytBUzOTtGZ2i+Yb5UswxGchIiud2nbF3
 HvncnxLJuE4HnsFQIdXE0H7vRkIVaGRMdRh6XPOOsuWNbIQlMU2iv
X-Received: by 2002:a05:6a00:459b:b0:6db:e6b9:4cca with SMTP id
 it27-20020a056a00459b00b006dbe6b94ccamr4752676pfb.14.1706634607535; 
 Tue, 30 Jan 2024 09:10:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtD9hAYtKmp8IOq9BKPLMalTLv0HaCPe7XQr6KT+pLuxHJwJImJRG/LBu+8m4zXIVL0eAqsA==
X-Received: by 2002:a05:6a00:459b:b0:6db:e6b9:4cca with SMTP id
 it27-20020a056a00459b00b006dbe6b94ccamr4752653pfb.14.1706634607161; 
 Tue, 30 Jan 2024 09:10:07 -0800 (PST)
Received: from smtpclient.apple ([115.96.128.50])
 by smtp.gmail.com with ESMTPSA id
 d2-20020aa78682000000b006ddc5d8ecd7sm8002030pfo.32.2024.01.30.09.10.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jan 2024 09:10:06 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] pc: q35: Bump max_cpus to 1728 vcpus
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <ZbkoOAPo7gmFZw4g@redhat.com>
Date: Tue, 30 Jan 2024 22:39:51 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4CEF526A-5B22-41EA-8634-D4BB5871B739@redhat.com>
References: <20240130164428.35955-1-anisinha@redhat.com>
 <ZbkoOAPo7gmFZw4g@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 30-Jan-2024, at 22:17, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Tue, Jan 30, 2024 at 10:14:28PM +0530, Ani Sinha wrote:
>> Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to =
allow up to 4096 vCPUs")
>> Linux kernel can support upto a maximum number of 4096 vCPUS when =
MAXSMP is
>> enabled in the kernel. QEMU has been tested to correctly boot a linux =
guest
>> with 1728 vcpus both with edk2 and seabios firmwares. So bump up the =
max_cpus
>> value for q35 machines versions 9 and newer to 1728. Q35 machines =
versions
>> 8.2 and older continue to support 1024 maximum vcpus as before for
>> compatibility.
>=20
> Where does the 1728 number come from ?
>=20
> Did something break at 1729, or did the test machine simply not
> have sufficient resources to do practical larger tests ?

Actual limit currently is 1856 for EDK2. The HPE folks tested QEMU with =
edk2 and QEMU fails to boot beyond that limit.
There are RH internal bugs tracking this and Gerd is working on it from =
RH side [1].

We would ultimately like to go to 8192 vcpus for SAP HANA but 1728 vcpus =
is our immediate target for now. If you want, I can resend the patch =
with 1856 since that is currently the tested limit.

1. https://issues.redhat.com/browse/RHEL-22202


>=20
>>=20
>> If KVM is not able to support the specified number of vcpus, QEMU =
would
>> return the following error messages:
>>=20
>> $ ./qemu-system-x86_64 -cpu host -accel kvm -machine q35 -smp 1728
>> qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested =
(1728) exceeds the recommended cpus supported by KVM (12)
>> qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus =
requested (1728) exceeds the recommended cpus supported by KVM (12)
>> Number of SMP cpus requested (1728) exceeds the maximum cpus =
supported by KVM (1024)
>>=20
>> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Julia Suvorova <jusual@redhat.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> hw/i386/pc_q35.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index f43d5142b8..bfa627a70b 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -375,7 +375,7 @@ static void pc_q35_machine_options(MachineClass =
*m)
>>     m->default_nic =3D "e1000e";
>>     m->default_kernel_irqchip_split =3D false;
>>     m->no_floppy =3D 1;
>> -    m->max_cpus =3D 1024;
>> +    m->max_cpus =3D 1728;
>>     m->no_parallel =3D =
!module_object_class_by_name(TYPE_ISA_PARALLEL);
>>     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
>>     machine_class_allow_dynamic_sysbus_dev(m, =
TYPE_INTEL_IOMMU_DEVICE);
>> @@ -396,6 +396,7 @@ static void =
pc_q35_8_2_machine_options(MachineClass *m)
>> {
>>     pc_q35_9_0_machine_options(m);
>>     m->alias =3D NULL;
>> +    m->max_cpus =3D 1024;
>>     compat_props_add(m->compat_props, hw_compat_8_2, =
hw_compat_8_2_len);
>>     compat_props_add(m->compat_props, pc_compat_8_2, =
pc_compat_8_2_len);
>> }
>> --=20
>> 2.42.0
>>=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    =
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            =
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    =
https://www.instagram.com/dberrange :|



