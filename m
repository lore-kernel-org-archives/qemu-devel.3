Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE18F606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hlWUWMCI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNbra-00068n-1k; Sun, 01 Nov 2026 15:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbrK-00067b-22
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:08:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbrG-0005u5-HL
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793563727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=3QayGsb20ORPjnjpJVIWbXa0vwu2Zx3E+D9AF44ldyw=;
 b=hlWUWMCIEBfAo+dTXUBMuUWRrBIizJ3egncxPnmexqeeuB2YMGLY3jFqf2zVU3pYdbNZ/g
 1MgqeFIQivqIcqR4q0A7Rwj/+GhmghOcWT52x4viaVp2lnFBjgo6biprHTsBjWY9dl6Olw
 UyefQq5cUfRPxoVgZE735BZNNhz+5Hw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-2zE9XaLbMxqdAeWTtl2FYw-1; Sun,
 01 Nov 2026 15:08:43 -0500
X-MC-Unique: 2zE9XaLbMxqdAeWTtl2FYw-1
X-Mimecast-MFC-AGG-ID: 2zE9XaLbMxqdAeWTtl2FYw_1793563719
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE00A1955BFE; Sun,  1 Nov 2026 20:08:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5729A7E0; Sun,  1 Nov 2026 20:08:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 00A1E21E6A04; Sun, 01 Nov 2026 21:08:28 +0100 (CET)
Resent-To: 17746591750@163.com, pasic@linux.ibm.com, alistair@alistair23.me,
 rathc@linux.ibm.com, graf@amazon.com, stefanb@linux.vnet.ibm.com,
 FangSheng.Huang@amd.com, xen-devel@lists.xenproject.org,
 michael.roth@amd.com, luc@lmichel.fr, lixianglai@loongson.cn,
 maobibo@loongson.cn, pbarbuda@microsoft.com, yoshinori.sato@nifty.com,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 john.levon@nutanix.com, thanos.makatos@nutanix.com, kfting@nuvoton.com,
 den@openvz.org, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, phil@philjordan.eu,
 tangtao1634@phytium.com.cn, chao.liu@processmission.com, jiri@resnulli.us,
 sam@rfc1149.net, anisa.su@samsung.com, alex@shazbot.org, farosas@suse.de,
 mohamed@unpredictable.fr, kvm@vger.kernel.org, linux-cxl@vger.kernel.org,
 alistair.francis@wdc.com, anthony@xenproject.org,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com, palmer@dabbelt.com,
 rbolshakov@ddn.com, foss@defmacro.it, sebastian.huber@embedded-brains.de,
 fam@euphon.net, jiaxun.yang@flygoat.com, lizhijian@fujitsu.com,
 atar4qemu@gmail.com, edgar.iglesias@gmail.com, jasowangio@gmail.com,
 liwei1518@gmail.com, npiggin@gmail.com, zhangckid@gmail.com,
 titusr@google.com, wuhaotsh@google.com, arei.gonglei@huawei.com,
 berto@igalia.com, mark.cave-ayland@ilande.co.uk, junjie.cao@intel.com,
 zhao1.liu@intel.com, its@irrelevant.dk, clg@kaod.org, conor@kernel.org,
 david@kernel.org, jic23@kernel.org, kbusch@kernel.org,
 mchehab+huawei@kernel.org, sstabellini@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, zhenwei.pi@linux.dev, adityag@linux.ibm.com,
 alifm@linux.ibm.com, amachhiw@linux.ibm.com, borntraeger@linux.ibm.com,
 brueckner@linux.ibm.com, farman@linux.ibm.com, harshpb@linux.ibm.com,
 iii@linux.ibm.com, jjherne@linux.ibm.com, milesg@linux.ibm.com,
 mjrosato@linux.ibm.com
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Sun, 01 Nov 2026 21:08:28 +0100
Resent-Message-ID: <87zevs1fib.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  John Snow
 <jsnow@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Kostiantyn
 Kostiuk
 <kkostiuk@redhat.com>,  Eric Blake <eblake@redhat.com>,  David Hildenbrand
 <david@kernel.org>,  Igor Mammedov <imammedo@redhat.com>,  "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,  Jason Wang <jasowangio@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,  kvm@vger.kernel.org,  Alberto
 Garcia <berto@igalia.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>,  Jonathan Cameron <jic23@kernel.org>,
 Junjie Cao <junjie.cao@intel.com>,  Anisa Su <anisa.su@samsung.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,  Jagannathan Raman
 <jag.raman@oracle.com>,  John Levon <john.levon@nutanix.com>,  Thanos
 Makatos <thanos.makatos@nutanix.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,  Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-block@nongnu.org,  linux-cxl@vger.kernel.org,
 qemu-s390x@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Sergio
 Lopez <slp@redhat.com>,  qemu-arm@nongnu.org,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org,  Song Gao <17746591750@163.com>,  Bibo Mao
 <maobibo@loongson.cn>,  Xianglai Li <lixianglai@loongson.cn>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,  Nicholas Piggin
 <npiggin@gmail.com>,  Harsh Prateek Bora <harshpb@linux.ibm.com>,  Amit
 Machhiwal <amachhiw@linux.ibm.com>,  qemu-ppc@nongnu.org,  Zhang Chen
 <zhangckid@gmail.com>,  Li Zhijian <lizhijian@fujitsu.com>,  Alistair
 Francis <alistair@alistair23.me>,  Alexander Graf <graf@amazon.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,  zhenwei pi
 <zhenwei.pi@linux.dev>,  Ani Sinha <anisinha@redhat.com>,  Luc Michel
 <luc@lmichel.fr>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  Jamin
 Lin
 <jamin_lin@aspeedtech.com>,  Kane Chen <kane_chen@aspeedtech.com>,  Samuel
 Tardieu <sam@rfc1149.net>,  "Denis V. Lunev" <den@openvz.org>,  FangSheng
 Huang <FangSheng.Huang@amd.com>,  Tyrone Ting <kfting@nuvoton.com>,  Hao
 Wu <wuhaotsh@google.com>,  Keith Busch <kbusch@kernel.org>,  Klaus Jensen
 <its@irrelevant.dk>,  Jesper Devantier <foss@defmacro.it>,  Aditya Gupta
 <adityag@linux.ibm.com>,  Glenn Miles <milesg@linux.ibm.com>,  Conor
 Dooley <conor@kernel.org>,  Sebastian Huber
 <sebastian.huber@embedded-brains.de>,  Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,  Jason Herne
 <jjherne@linux.ibm.com>,  Titus Rwantare <titusr@google.com>,  Stefano
 Stabellini <sstabellini@kernel.org>,  Anthony PERARD
 <anthony@xenproject.org>,  Peter Xu <peterx@redhat.com>,  Chinmay Rath
 <rathc@linux.ibm.com>,  Hendrik Brueckner <brueckner@linux.ibm.com>,
 xen-devel@lists.xenproject.org,  Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,  Fam Zheng <fam@euphon.net>,
 Farhan Ali <alifm@linux.ibm.com>,  Alex Williamson <alex@shazbot.org>,
 Tao Tang <tangtao1634@phytium.com.cn>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Fabiano Rosas <farosas@suse.de>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Artyom Tarasenko
 <atar4qemu@gmail.com>,  Yoshinori Sato <yoshinori.sato@nifty.com>,  Jiri
 Pirko <jiri@resnulli.us>,  Eric Auger <eric.auger@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v7 38/65] qom: convert scalar properties to QAPI-aware
 registration
In-Reply-To: <20261020-qom-qapi-v7-38-431a86b02b58@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Tue, 20 Oct 2026 14:45:55 +0400")
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
 <20261020-qom-qapi-v7-38-431a86b02b58@redhat.com>
Date: Fri, 30 Oct 2026 09:48:08 +0100
Message-ID: <87y0bfa81j.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

How did you create this patch?  It looks almost mechanical.

It misses a few conversions, almost certainly in code added since you
made this patch.  I can take care of them.

[...]

> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 1d91667fb880..bc178482b309 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -24,6 +24,7 @@
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-builtin-type-infos.h"
>  #include "hw/pci/msi.h"
>  #include "hw/pci/msix.h"
>  #include "hw/s390x/adapter.h"

Not needed; we already include "qapi/qapi-type-infos-common.h".

[...]

> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 6d421b990cef..64228a620e69 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -26,6 +26,7 @@
>=20=20
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-builtin-type-infos.h"
>  #include "qapi/visitor.h"
>  #include "hw/pci/pci.h"
>  #include "migration/vmstate.h"

Missing:

                                       PM_REG_FIELD(acpi_pci_hotplug.root),
                                       object_property_allow_set_link,
                                       OBJ_PROP_LINK_STRONG);
   -    object_class_property_add(oc, ACPI_PM_PROP_GPE0_BLK, "uint32",
   +    object_class_property_add_qapi(oc, ACPI_PM_PROP_GPE0_BLK, &uint32_t=
ype_info,
                                  ich9_pm_get_gpe0_blk,
                                  NULL, NULL, NULL);
        object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S3_DISABLED,

[...]

> diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
> index cca37202ffb2..7b4fd933a8fb 100644
> --- a/hw/xen/xen-pvh-common.c
> +++ b/hw/xen/xen-pvh-common.c
> @@ -9,6 +9,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
>  #include "qemu/units.h"
> +#include "qapi/qapi-builtin-type-infos.h"
>  #include "qapi/visitor.h"
>  #include "hw/core/boards.h"
>  #include "hw/core/irq.h"
> @@ -413,7 +414,7 @@ void xen_pvh_class_setup_common_props(XenPVHMachineCl=
ass *xpc)
>=20=20
>  #define OC_MEMMAP_PROP_BASE(c, prop_name, name)                         =
  \
>  do {                                                                    =
  \
> -    object_class_property_add(c, prop_name "-base", "uint64_t",         =
  \
> +    object_class_property_add_qapi(c, prop_name "-base", &uint64_type_in=
fo,\
>                                xen_pvh_get_ ## name ## _base,            =
  \
>                                xen_pvh_set_ ## name ## _base, NULL, NULL)=
; \
>      object_class_property_set_description(oc, prop_name "-base",        =
  \
> @@ -422,7 +423,7 @@ do {                                                 =
                     \
>=20=20
>  #define OC_MEMMAP_PROP_SIZE(c, prop_name, name)                         =
  \
>  do {                                                                    =
  \
> -    object_class_property_add(c, prop_name "-size", "uint64_t",         =
  \
> +    object_class_property_add_qapi(c, prop_name "-size", &size_type_info=
, \
>                                xen_pvh_get_ ## name ## _size,            =
  \
>                                xen_pvh_set_ ## name ## _size, NULL, NULL)=
; \
>      object_class_property_set_description(oc, prop_name "-size",        =
  \

Use of &size_type_info is not mechanical.  Better to be as mechanical as
possible in such a huge patch.

[...]

> diff --git a/qom/object.c b/qom/object.c
> index cc113c0810e7..9f9a2abfa08d 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -22,10 +22,10 @@
>  #include "qapi/string-output-visitor.h"
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/forward-visitor.h"
> +#include "qapi/qapi-builtin-type-infos.h"
>  #include "qapi/qapi-builtin-visit.h"
>  #include "qapi/compat-policy.h"
>  #include "qobject/qdict.h"
> -#include "qobject/qjson.h"

The deletion doesn't belong.

>  #include "qemu/id.h"
>  #include "qapi/qmp/qerror.h"
>  #include "trace.h"
> @@ -2449,7 +2449,7 @@ object_property_add_str(Object *obj, const char *na=
me,
>      prop->get =3D get;
>      prop->set =3D set;
>=20=20
> -    return object_property_add(obj, name, "string",
> +    return object_property_add_qapi(obj, name, &str_type_info,
>                                 get ? property_get_str : NULL,
>                                 set ? property_set_str : NULL,
>                                 property_release_data,
> @@ -2467,7 +2467,7 @@ object_class_property_add_str(ObjectClass *klass, c=
onst char *name,
>      prop->get =3D get;
>      prop->set =3D set;
>=20=20
> -    return object_class_property_add(klass, name, "string",
> +    return object_class_property_add_qapi(klass, name, &str_type_info,
>                                       get ? property_get_str : NULL,
>                                       set ? property_set_str : NULL,
>                                       NULL,
> @@ -2519,7 +2519,7 @@ object_property_add_bool(Object *obj, const char *n=
ame,
>      prop->get =3D get;
>      prop->set =3D set;
>=20=20
> -    return object_property_add(obj, name, "bool",
> +    return object_property_add_qapi(obj, name, &bool_type_info,
>                                 get ? property_get_bool : NULL,
>                                 set ? property_set_bool : NULL,
>                                 property_release_data,
> @@ -2536,7 +2536,7 @@ object_class_property_add_bool(ObjectClass *klass, =
const char *name,
>      prop->get =3D get;
>      prop->set =3D set;
>=20=20
> -    return object_class_property_add(klass, name, "bool",
> +    return object_class_property_add_qapi(klass, name, &bool_type_info,
>                                       get ? property_get_bool : NULL,
>                                       set ? property_set_bool : NULL,
>                                       NULL,

Missing:

   @@ -2929,7 +2930,7 @@ object_class_property_add_bool_ptr(ObjectClass *kl=
ass, const char *name,
            setter =3D property_class_set_bool_ptr;
        }

   -    return object_class_property_add(klass, name, "bool",
   +    return object_class_property_add_qapi(klass, name, &bool_type_info,
                                         getter, setter, NULL, (void *)offs=
et);
    }

> @@ -2945,8 +2945,8 @@ object_property_add_uint8_ptr(Object *obj, const ch=
ar *name,
>          setter =3D property_set_uint8_ptr;
>      }
>=20=20
> -    return object_property_add(obj, name, "uint8",
> -                               getter, setter, NULL, (void *)v);
> +    return object_property_add_qapi(obj, name, &uint8_type_info,
> +                                    getter, setter, NULL, (void *)v);
>  }
>=20=20
>  ObjectProperty *

Missing:

   @@ -2969,7 +2970,7 @@ object_class_property_add_uint8_ptr(ObjectClass *k=
lass, const char *name,
            setter =3D property_class_set_uint8_ptr;
        }

   -    return object_class_property_add(klass, name, "uint8",
   +    return object_class_property_add_qapi(klass, name, &uint8_type_info,
                                         getter, setter, NULL, (void *)offs=
et);
    }

> @@ -2986,8 +2986,8 @@ object_class_static_property_add_uint8_ptr(ObjectCl=
ass *klass,
>          setter =3D property_set_uint8_ptr;
>      }
>=20=20
> -    return object_class_property_add(klass, name, "uint8",
> -                                     getter, setter, NULL, (void *)v);
> +    return object_class_property_add_qapi(klass, name, &uint8_type_info,
> +                                          getter, setter, NULL, (void *)=
v);
>  }
>=20=20
>  ObjectProperty *
> @@ -3006,8 +3006,8 @@ object_property_add_uint16_ptr(Object *obj, const c=
har *name,
>          setter =3D property_set_uint16_ptr;
>      }
>=20=20
> -    return object_property_add(obj, name, "uint16",
> -                               getter, setter, NULL, (void *)v);
> +    return object_property_add_qapi(obj, name, &uint16_type_info,
> +                                    getter, setter, NULL, (void *)v);
>  }
>=20=20
>  ObjectProperty *

Missing:

   @@ -3030,7 +3031,7 @@ object_class_property_add_uint16_ptr(ObjectClass *=
klass, const char *name,
            setter =3D property_class_set_uint16_ptr;
        }

   -    return object_class_property_add(klass, name, "uint16",
   +    return object_class_property_add_qapi(klass, name, &uint16_type_inf=
o,
                                         getter, setter, NULL, (void *)offs=
et);
    }

> @@ -3047,8 +3047,8 @@ object_class_static_property_add_uint16_ptr(ObjectC=
lass *klass,
>          setter =3D property_set_uint16_ptr;
>      }
>=20=20
> -    return object_class_property_add(klass, name, "uint16",
> -                                     getter, setter, NULL, (void *)v);
> +    return object_class_property_add_qapi(klass, name, &uint16_type_info,
> +                                          getter, setter, NULL, (void *)=
v);
>  }
>=20=20
>  ObjectProperty *
> @@ -3067,8 +3067,8 @@ object_property_add_uint32_ptr(Object *obj, const c=
har *name,
>          setter =3D property_set_uint32_ptr;
>      }
>=20=20
> -    return object_property_add(obj, name, "uint32",
> -                               getter, setter, NULL, (void *)v);
> +    return object_property_add_qapi(obj, name, &uint32_type_info,
> +                                    getter, setter, NULL, (void *)v);
>  }
>=20=20
>  ObjectProperty *

Missing:

   @@ -3091,7 +3092,7 @@ object_class_property_add_uint32_ptr(ObjectClass *=
klass, const char *name,
            setter =3D property_class_set_uint32_ptr;
        }

   -    return object_class_property_add(klass, name, "uint32",
   +    return object_class_property_add_qapi(klass, name, &uint32_type_inf=
o,
                                         getter, setter, NULL, (void *)offs=
et);
    }

> @@ -3108,8 +3108,8 @@ object_class_static_property_add_uint32_ptr(ObjectC=
lass *klass,
>          setter =3D property_set_uint32_ptr;
>      }
>=20=20
> -    return object_class_property_add(klass, name, "uint32",
> -                                     getter, setter, NULL, (void *)v);
> +    return object_class_property_add_qapi(klass, name, &uint32_type_info,
> +                                          getter, setter, NULL, (void *)=
v);
>  }
>=20=20
>  ObjectProperty *
> @@ -3128,8 +3128,8 @@ object_property_add_uint64_ptr(Object *obj, const c=
har *name,
>          setter =3D property_set_uint64_ptr;
>      }
>=20=20
> -    return object_property_add(obj, name, "uint64",
> -                               getter, setter, NULL, (void *)v);
> +    return object_property_add_qapi(obj, name, &uint64_type_info,
> +                                    getter, setter, NULL, (void *)v);
>  }
>=20=20
>  ObjectProperty *

Missing:

   @@ -3152,7 +3153,7 @@ object_class_property_add_uint64_ptr(ObjectClass *=
klass, const char *name,
            setter =3D property_class_set_uint64_ptr;
        }

   -    return object_class_property_add(klass, name, "uint64",
   +    return object_class_property_add_qapi(klass, name, &uint64_type_inf=
o,
                                         getter, setter, NULL, (void *)offs=
et);
    }

> @@ -3169,8 +3169,8 @@ object_class_static_property_add_uint64_ptr(ObjectC=
lass *klass,
>          setter =3D property_set_uint64_ptr;
>      }
>=20=20
> -    return object_class_property_add(klass, name, "uint64",
> -                                     getter, setter, NULL, (void *)v);
> +    return object_class_property_add_qapi(klass, name, &uint64_type_info,
> +                                          getter, setter, NULL, (void *)=
v);
>  }
>=20=20
>  typedef struct {

[...]

> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index b2c7260c80a4..3a36fa4d0b95 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -3266,7 +3266,7 @@ sev_snp_guest_class_init(ObjectClass *oc, const voi=
d *data)
>      x86_klass->adjust_cpuid_features =3D sev_snp_adjust_cpuid_features;
>      x86_klass->kvm_type =3D sev_snp_kvm_type;
>=20=20
> -    object_class_property_add(oc, "policy", "uint64",
> +    object_class_property_add_qapi(oc, "policy", &uint64_type_info,
>                                sev_snp_guest_get_policy,
>                                sev_snp_guest_set_policy, NULL, NULL);
>      object_class_property_add_str(oc, "guest-visible-workarounds",

Missing:

   @@ -3290,7 +3290,7 @@ sev_snp_guest_class_init(ObjectClass *oc, const vo=
id *data)
        object_class_property_add_bool(oc, "secure-tsc",
                                      sev_snp_guest_get_secure_tsc,
                                      sev_snp_guest_set_secure_tsc);
   -    object_class_property_add(oc, "tsc-frequency", "uint32",
   +    object_class_property_add_qapi(oc, "tsc-frequency", &uint32_type_in=
fo,
                                  sev_snp_guest_get_tsc_frequency,
                                  sev_snp_guest_set_tsc_frequency, NULL, NU=
LL);
    }

[...]


