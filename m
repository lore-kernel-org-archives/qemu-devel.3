Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC3ECEF14D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 11:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy81B-0002zP-2N; Tue, 08 Oct 2024 07:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sy819-0002yd-Rr
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 07:04:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sy815-0002pt-GG
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 07:04:37 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNCmj1dZlz6G8t9;
 Tue,  8 Oct 2024 19:03:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 775521404F9;
 Tue,  8 Oct 2024 19:04:31 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Oct
 2024 13:04:30 +0200
Date: Tue, 8 Oct 2024 12:04:29 +0100
To: David Woodhouse <dwmw2@infradead.org>
CC: <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Hilber
 <peter.hilber@opensynergy.com>, "Mohamed Abuelfotoh, Hazem"
 <abuehaze@amazon.com>, paul <paul@xen.org>
Subject: Re: [PATCH v4] hw/acpi: Add vmclock device
Message-ID: <20241008120429.00000603@Huawei.com>
In-Reply-To: <64144cfa550c54bee25c7be0cc3101cb1d1b1967.camel@infradead.org>
References: <64144cfa550c54bee25c7be0cc3101cb1d1b1967.camel@infradead.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 07 Oct 2024 14:53:54 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> The vmclock device addresses the problem of live migration with
> precision clocks. The tolerances of a hardware counter (e.g. TSC) are
> typically around =B150PPM. A guest will use NTP/PTP/PPS to discipline that
> counter against an external source of 'real' time, and track the precise
> frequency of the counter as it changes with environmental conditions.
>=20
> When a guest is live migrated, anything it knows about the frequency of
> the underlying counter becomes invalid. It may move from a host where
> the counter running at -50PPM of its nominal frequency, to a host where
> it runs at +50PPM. There will also be a step change in the value of the
> counter, as the correctness of its absolute value at migration is
> limited by the accuracy of the source and destination host's time
> synchronization.
>=20
> The device exposes a shared memory region to guests, which can be mapped
> all the way to userspace. In the first phase, this merely advertises a
> 'disruption_marker', which indicates that the guest should throw away any
> NTP synchronization it thinks it has, and start again.
>=20
> Because the region can be exposed all the way to userspace, applications
> can still use time from a fast vDSO 'system call', and check the
> disruption marker to be sure that their timestamp is indeed truthful.
>=20
> The structure also allows for the precise time, as known by the host, to
> be exposed directly to guests so that they don't have to wait for NTP to
> resync from scratch.
>=20
> The values and fields are based on the nascent virtio-rtc specification,
> and the intent is that a version (hopefully precisely this version) of
> this structure will be included as an optional part of that spec. In the
> meantime, a simple ACPI device along the lines of VMGENID is perfectly
> sufficient and is compatible with what's being shipped in certain
> commercial hypervisors.
>=20
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Hi David,

A couple of drive by comments (as we all love those!)

Jonathan

> ---

> diff --git a/hw/acpi/vmclock-abi.h b/hw/acpi/vmclock-abi.h
> new file mode 100644
> index 0000000000..19cbf85efd
> --- /dev/null
> +++ b/hw/acpi/vmclock-abi.h
> @@ -0,0 +1,186 @@


> +#endif /*  __VMCLOCK_ABI_H__ */
> diff --git a/hw/acpi/vmclock.c b/hw/acpi/vmclock.c
> new file mode 100644
> index 0000000000..e7df047c33
> --- /dev/null
> +++ b/hw/acpi/vmclock.c

> +
> +void vmclock_build_acpi(VmclockState *vms, GArray *table_data,
> +                        BIOSLinker *linker, const char *oem_id)
> +{
> +    Aml *ssdt, *dev, *scope, *method, *addr, *crs;
> +    AcpiTable table =3D { .sig =3D "SSDT", .rev =3D 1,
> +                        .oem_id =3D oem_id, .oem_table_id =3D "VMCLOCK" =
};
> +
> +    /* Put VMCLOCK into a separate SSDT table */
> +    acpi_table_begin(&table, table_data);
> +    ssdt =3D init_aml_allocator();
> +
> +    scope =3D aml_scope("\\_SB");
> +    dev =3D aml_device("VCLK");
> +    aml_append(dev, aml_name_decl("_HID", aml_string("AMZNC10C")));

Nice _HID :)

> +    aml_append(dev, aml_name_decl("_CID", aml_string("VMCLOCK")));
> +    aml_append(dev, aml_name_decl("_DDN", aml_string("VMCLOCK")));
> +
> +    /* Simple status method */
> +    method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
> +    addr =3D aml_local(0);
> +    aml_append(method, aml_store(aml_int(0xf), addr));
> +    aml_append(method, aml_return(addr));
> +    aml_append(dev, method);

It's static so you should be able to do:
aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));



> +
> +    crs =3D aml_resource_template();
> +    aml_append(crs, aml_qword_memory(AML_POS_DECODE,
> +                                     AML_MIN_FIXED, AML_MAX_FIXED,
> +                                     AML_CACHEABLE, AML_READ_ONLY,
> +                                     0xffffffffffffffffULL,
> +                                     vms->physaddr,
> +                                     vms->physaddr + VMCLOCK_SIZE - 1,
> +                                     0, VMCLOCK_SIZE));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    aml_append(scope, dev);
> +    aml_append(ssdt, scope);
> +
> +    g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);
> +    acpi_table_end(linker, &table);
> +    free_aml_allocator();
> +}

> +static Property vmclock_device_properties[] =3D {
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vmclock_device_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->vmsd =3D &vmstate_vmclock;
> +    dc->realize =3D vmclock_realize;
> +    device_class_set_props(dc, vmclock_device_properties);

Probably a silly question but why register no properties?
Is that any different to not registering them?
+ a quick look suggests not all class_init functions
set them.



> +    dc->hotpluggable =3D false;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +}
> +
> +static const TypeInfo vmclock_device_info =3D {
> +    .name          =3D TYPE_VMCLOCK,
> +    .parent        =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(VmclockState),
> +    .class_init    =3D vmclock_device_class_init,
> +};
> +
> +static void vmclock_register_types(void)
> +{
> +    type_register_static(&vmclock_device_info);
> +}
> +
> +type_init(vmclock_register_types)


