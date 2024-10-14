Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A71CFC52C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 09:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0HWT-0005G8-KQ; Mon, 14 Oct 2024 05:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t0HWR-0005Fr-QG
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 05:37:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t0HWO-0006Yh-PP
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 05:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728898666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qr1rGtffKijcUEwIMWOKeHYRGLEGo1XfQ+k49h3MgI8=;
 b=KnOVcG8S9zpGjYYgBcGi0b5/KjRibdHt6g3S442SGEPDRc2xS2kY+9GGYq4gQJtDkqvywz
 KpEcP7P4MqRv0LFr9loAFwcXZ2Yiqwbmy1NN4lEGu/TUCb4tsdHkiBNu8VKjvh92vFZhDm
 re61os6GQ7CWEr7+LW7X3SFLinn5kRg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-7xx_mBRPPYKmGBvQd2paUg-1; Mon, 14 Oct 2024 05:37:45 -0400
X-MC-Unique: 7xx_mBRPPYKmGBvQd2paUg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4312acda5f6so9919515e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 02:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728898664; x=1729503464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qr1rGtffKijcUEwIMWOKeHYRGLEGo1XfQ+k49h3MgI8=;
 b=l7IHPIUraFBI5Wcj2fYOtp+rA5HHNI8h8vPFNiR8ZjCu4v32CMMZ+IwjFUa0ZqLOp8
 F0DPcgZIKSnR9dVyBENX1Z12EPARaWb1vVd2FvHGjzTKqmYBKeVt2Xd1Au7GlYa/XUtJ
 iH8WzMABsS0dix06hXjlPd6EVncaa6beXGmBGR22swOw8uGHHL/M+tprwequqCu4DKQf
 AOsodDi52YQkRQSGiM9WD+CQeLxqQNRhSQRhcFrcCXEpzWbhM/Z1w5cwH0jVGVGhwhFf
 AqeTj2lY/NbZqHwhqDWTrgX7SfeklNFvZ9e4uC5LmbeR0UW0O+y3JS28qEzVIk2eSr1/
 XwBQ==
X-Gm-Message-State: AOJu0YxpNDo/4L3sIebLjn1CaCAZKliQK/iU1BzaH9jLbabV9YoBu/c+
 81LyPvmLiYdU4Ggt7TIf+5n92uH6FlVeKp71uHojbd0OCNAgB0JxPLEGkIRGG8jQC7wBkh/rmtc
 DataBtR96lq38R66MxSnOoeRoEZ+Yv/oVwLe9x+Q/iMPFojv/i5A+
X-Received: by 2002:a05:600c:4e8a:b0:426:602d:a246 with SMTP id
 5b1f17b1804b1-4311df55eccmr104833525e9.32.1728898663906; 
 Mon, 14 Oct 2024 02:37:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGundn36qH8OLHx+TKmzLh1QmMEcsyp21Hz6mbUALhzGzEsTna1GC144wLxKQe1moZIHq2Nw==
X-Received: by 2002:a05:600c:4e8a:b0:426:602d:a246 with SMTP id
 5b1f17b1804b1-4311df55eccmr104833215e9.32.1728898663471; 
 Mon, 14 Oct 2024 02:37:43 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430ccf43da8sm147965895e9.11.2024.10.14.02.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 02:37:42 -0700 (PDT)
Date: Mon, 14 Oct 2024 11:37:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: maobibo <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, salil.mehta@huawei.com, "Michael S. Tsirkin"
 <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Keqian Zhu
 <zhukeqian1@huawei.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Gavin Shan <gshan@redhat.com>, Vishnu Pajjuri
 <vishnu@os.amperecomputing.com>, Xianglai Li <lixianglai@loongson.cn>,
 Miguel Luis <miguel.luis@oracle.com>, Shaoqin Huang <shahuang@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PULL v2 40/61] hw/acpi: Update GED _EVT method AML with CPU scan
Message-ID: <20241014113740.6f8305be@imammedo.users.ipa.redhat.com>
In-Reply-To: <ac9244d8-660a-ade6-9987-352c3c646a76@loongson.cn>
References: <cover.1721731723.git.mst@redhat.com>
 <549c9a9dcbc1592ea79496f7b3ab234f366adeba.1721731723.git.mst@redhat.com>
 <ac9244d8-660a-ade6-9987-352c3c646a76@loongson.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, 14 Oct 2024 16:52:55 +0800
maobibo <maobibo@loongson.cn> wrote:

> Hi Salil,
>=20
> When I debug cpu hotplug on LoongArch system, It reports error like this:
>      ACPI BIOS Error (bug): Could not resolve symbol [\_SB.GED.CSCN],=20
> AE_NOT_FOUND
>      ACPI Error: Aborting method \_SB.GED._EVT due to previous error=20
> (AE_NOT_FOUND)
>      acpi-ged ACPI0013:00: IRQ method execution failed
>=20
>=20
> With this patch, GED CPU call method is "\\_SB.GED.CSCN", however in=20
> function build_cpus_aml(), its method name is "\\_SB.CPUS.CSCN".
>      method =3D aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
>      aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
>      aml_append(table, method);
>=20
> It seems that CPU scanning method name is not consistent between=20
> function build_cpus_aml() and build_ged_aml().
>=20
> Regards
> Bibo Mao
>=20
> On 2024/7/23 =E4=B8=8B=E5=8D=886:59, Michael S. Tsirkin wrote:
> > From: Salil Mehta <salil.mehta@huawei.com>
> >=20
> > OSPM evaluates _EVT method to map the event. The CPU hotplug event even=
tually
> > results in start of the CPU scan. Scan figures out the CPU and the kind=
 of
> > event(plug/unplug) and notifies it back to the guest. Update the GED AM=
L _EVT
> > method with the call to method \\_SB.CPUS.CSCN (via \\_SB.GED.CSCN)
> >=20
> > Architecture specific code [1] might initialize its CPUs AML code by ca=
lling
> > common function build_cpus_aml() like below for ARM:
> >=20
> > build_cpus_aml(scope, ms, opts, xx_madt_cpu_entry, memmap[VIRT_CPUHP_AC=
PI].base,
> >                 "\\_SB", "\\_SB.GED.CSCN", AML_SYSTEM_MEMORY);

it should be \\_SB.CPUS.CSCN

> >=20
> > [1] https://lore.kernel.org/qemu-devel/20240613233639.202896-13-salil.m=
ehta@huawei.com/
> >=20
> > Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> > Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > Tested-by: Xianglai Li <lixianglai@loongson.cn>
> > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> > Tested-by: Zhao Liu <zhao1.liu@intel.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > Message-Id: <20240716111502.202344-5-salil.mehta@huawei.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   include/hw/acpi/generic_event_device.h | 1 +
> >   hw/acpi/generic_event_device.c         | 3 +++
> >   2 files changed, 4 insertions(+)
> >=20
> > diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/g=
eneric_event_device.h
> > index e091ac2108..40af3550b5 100644
> > --- a/include/hw/acpi/generic_event_device.h
> > +++ b/include/hw/acpi/generic_event_device.h
> > @@ -87,6 +87,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
> >   #define GED_DEVICE      "GED"
> >   #define AML_GED_EVT_REG "EREG"
> >   #define AML_GED_EVT_SEL "ESEL"
> > +#define AML_GED_EVT_CPU_SCAN_METHOD "\\_SB.GED.CSCN"
> >  =20
> >   /*
> >    * Platforms need to specify the GED event bitmap
> > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_dev=
ice.c
> > index 4641933a0f..15b4c3ebbf 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -108,6 +108,9 @@ void build_ged_aml(Aml *table, const char *name, Ho=
tplugHandler *hotplug_dev,
> >                   aml_append(if_ctx, aml_call0(MEMORY_DEVICES_CONTAINER=
 "."
> >                                                MEMORY_SLOT_SCAN_METHOD)=
);
> >                   break;
> > +            case ACPI_GED_CPU_HOTPLUG_EVT:
> > +                aml_append(if_ctx, aml_call0(AML_GED_EVT_CPU_SCAN_METH=
OD));
> > +                break;
> >               case ACPI_GED_PWR_DOWN_EVT:
> >                   aml_append(if_ctx,
> >                              aml_notify(aml_name(ACPI_POWER_BUTTON_DEVI=
CE),
> >  =20
>=20


