Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C31BC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 14:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMT1U-0005SY-Md; Tue, 03 Jun 2025 10:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMT1Q-0005Np-JI
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMT1I-0003YV-NY
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748962418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XRRNiD5MgoCGmMOiPSVvj1hfA7gjwXlbge+n0451DdE=;
 b=Auc/fBS5/TDDQIzE/iOxoReJ72/DR1Lvfyq2shDrl9yqRhzxs3aqqcq7Q4luL3pgS3mBof
 4nNFzqaa0GyPTphXsFgptFsm9OTW+MZnvq1695CBIz9CgVqCEoRA3Rq8TsVthJWwJZkAQU
 bqqqgRYkXCmZr3RgM+GXpisxBG0Xb60=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-Lv-2o01dMGCaDd9oZ2h31g-1; Tue, 03 Jun 2025 10:53:37 -0400
X-MC-Unique: Lv-2o01dMGCaDd9oZ2h31g-1
X-Mimecast-MFC-AGG-ID: Lv-2o01dMGCaDd9oZ2h31g_1748962416
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4fb87fa4aso1500623f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 07:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748962416; x=1749567216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XRRNiD5MgoCGmMOiPSVvj1hfA7gjwXlbge+n0451DdE=;
 b=NYDHuNDLsU8qUL0QrVTlEDGaXwnwM2jCFBYaRTkK2uWyZqo7UwF51umwxQJNNTj7Bg
 jo3s530jgdFOMltRm2Ji49+9fkndYt0/FaZ1vG1TUha0zaVFsd28s4ifYqrFTE3aMPvG
 o8Y6swEEM4F64UIGNl6y++rllrrFbx9CHgYLh8kfxVwEpzDrjWzTawE0bF0HLZyD6PVu
 WwafsvJe5kbPg/MxtLq2IcXMjtRm2kOBrbV105u59u0kmVYhOfxbOOmvhxKFKf3EhhZ5
 K83ZAdRiM4CUcjZFRTXknGTym26HAJIhv2sz83GvLdPT4nsOyF7lc2QOSI+783v8zBgM
 RYnA==
X-Gm-Message-State: AOJu0Yz3Ir0l71zRHyO60XyCDR7+3Pbsc8Zy42a5OFECu9JyUBVMBE2u
 VgiYPbKJs8zjlIuTJtSgMEtdKxckWekS32ZbqOU4/C9ElXQtZXJu4VWtcTQ4jaefdpNIjq5LoD4
 DOX7uFpXNE4SV4I6UytX9xrmb5ye9WM9Fxg4WInqWj5ogF072qMAXv0Lh
X-Gm-Gg: ASbGncvAKUWGazmrJE8UJjy2dZIZ3myTxFa4k/w1jagzROrfGwyVpeANlFbkAmdangn
 vC7ldbArypupPKDPNy8FjnF/NDRPjt4mHnjnfCZfFYYY7FZRL9wxQdCVdMruBRLgfzgK53PV1rN
 rqp4DYgBzdIl+yA8PXZUURwYvBI2g6bKNW+FdwCu6XXuSfjUGgjrkYRegJDlopT5tL4Cgf+N8FV
 8+xSF7k0adNKkVdO4wmyrx4NgJQ5l9zl59/eH2Zywal6YU40ttdmyVTa10f2USA6ENRaJyYzZIy
 vRHfjUly5iBrCy5JqR8vB2488Qn3auBQ
X-Received: by 2002:a05:6000:381:b0:3a4:cf10:28f with SMTP id
 ffacd0b85a97d-3a4f7a3654fmr14818722f8f.31.1748962415896; 
 Tue, 03 Jun 2025 07:53:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFImbSI+AqyBvIlLR9+OB1Xdt0AJZFsa0u7lZ2q3VzdQLLaWFVa+4nzXgSsSabPNFhJDIVebA==
X-Received: by 2002:a05:6000:381:b0:3a4:cf10:28f with SMTP id
 ffacd0b85a97d-3a4f7a3654fmr14818700f8f.31.1748962415498; 
 Tue, 03 Jun 2025 07:53:35 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa21e4sm170115105e9.11.2025.06.03.07.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 07:53:35 -0700 (PDT)
Date: Tue, 3 Jun 2025 16:53:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf
 <kwolf@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>, Jason Wang
 <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH v4 04/19] target/i386/cpu: Remove X86CPU::check_cpuid field
Message-ID: <20250603165334.6b9a18ae@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250512083948.39294-5-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-5-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 12 May 2025 10:39:33 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The X86CPU::check_cpuid boolean was only set in the
> pc_compat_2_4[] array, via the 'check=3Doff' property.
> We removed all machines using that array, lets remove
> that CPU property and simplify x86_cpu_realizefn().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/cpu.h | 1 -
>  target/i386/cpu.c | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 4f8ed8868e9..0db70a70439 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2164,7 +2164,6 @@ struct ArchCPU {
>      uint8_t hyperv_ver_id_sb;
>      uint32_t hyperv_ver_id_sn;
> =20
> -    bool check_cpuid;
>      bool enforce_cpuid;
>      /*
>       * Force features to be enabled even if the host doesn't support the=
m.
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1ca6307c72e..cd4361b4227 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8174,7 +8174,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>          }
>      }
> =20
> -    if (x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cp=
uid)) {
> +    if (x86_cpu_filter_features(cpu, cpu->enforce_cpuid)) {
>          if (cpu->enforce_cpuid) {
>              error_setg(&local_err,
>                         accel_uses_host_cpuid() ?
> @@ -8813,7 +8813,6 @@ static const Property x86_cpu_properties[] =3D {
>      DEFINE_PROP_UINT8("hv-version-id-sbranch", X86CPU, hyperv_ver_id_sb,=
 0),
>      DEFINE_PROP_UINT32("hv-version-id-snumber", X86CPU, hyperv_ver_id_sn=
, 0),
> =20
> -    DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
>      DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
>      DEFINE_PROP_BOOL("x-force-features", X86CPU, force_features, false),
>      DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),


