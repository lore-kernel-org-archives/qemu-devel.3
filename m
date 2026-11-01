Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEF8606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=du+2YA9N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNbw3-0001mc-Q0; Sun, 01 Nov 2026 15:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbuw-00018a-2z
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:12:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbus-0006b0-4d
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793563953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=oNopvIrGwggCQ0510MgqgZL4xJk+ROUgtmVb33nxu5Y=;
 b=du+2YA9Nflw4J2Quok8v5zdQlDRCvaCHoAMdKGsvA9661afpN9Wj5Qhft8P80Oc4lhiudG
 aJixyjpNqqkLm1/zY/lD3do7Pe8DUN2PsSOha63zqhFuBwFx+ASwPQVOCUjRXR5QRtyMsq
 LpQEgV+x/xGTkGxiH82r9s0Zqa7H0oM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400--bl76eGfOWKWgGNyjcKPkw-1; Sun,
 01 Nov 2026 15:12:27 -0500
X-MC-Unique: -bl76eGfOWKWgGNyjcKPkw-1
X-Mimecast-MFC-AGG-ID: -bl76eGfOWKWgGNyjcKPkw_1793563943
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA7C11955BFE; Sun,  1 Nov 2026 20:12:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BF59767; Sun,  1 Nov 2026 20:12:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3331821E6A04; Sun, 01 Nov 2026 21:12:17 +0100 (CET)
Resent-To: pasic@linux.ibm.com, 17746591750@163.com, rathc@linux.ibm.com,
 alistair@alistair23.me, stefanb@linux.vnet.ibm.com, graf@amazon.com,
 xen-devel@lists.xenproject.org, FangSheng.Huang@amd.com, luc@lmichel.fr,
 michael.roth@amd.com, lixianglai@loongson.cn, maobibo@loongson.cn,
 pbarbuda@microsoft.com, yoshinori.sato@nifty.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, john.levon@nutanix.com,
 thanos.makatos@nutanix.com, kfting@nuvoton.com, den@openvz.org,
 elena.ufimtseva@oracle.com, jag.raman@oracle.com,
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
Resent-Date: Sun, 01 Nov 2026 21:12:17 +0100
Resent-Message-ID: <87a4ns1fby.fsf@pond.sub.org>
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
Subject: Re: [PATCH v7 64/65] qom: use QAPITypeInfo in object_property_get_enum
In-Reply-To: <20261020-qom-qapi-v7-64-431a86b02b58@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Tue, 20 Oct 2026 14:46:21 +0400")
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
 <20261020-qom-qapi-v7-64-431a86b02b58@redhat.com>
Date: Sun, 01 Nov 2026 17:15:34 +0100
Message-ID: <87mrrs7ck9.fsf@pond.sub.org>
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

> The typename parameter becomes a QAPITypeInfo pointer, and the
> validation compares prop->qapi_type against it instead of matching
> prop->type strings.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

[...]

> diff --git a/qom/object.c b/qom/object.c
> index 791d981dc689..40b569d4d574 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1775,7 +1775,7 @@ uint64_t object_property_get_uint(Object *obj, cons=
t char *name,
>  }
>=20=20
>  int object_property_get_enum(Object *obj, const char *name,
> -                             const char *typename, Error **errp)
> +                             const QAPITypeInfo *type_info, Error **errp)
>  {
>      char *str;
>      int ret;
> @@ -1785,10 +1785,10 @@ int object_property_get_enum(Object *obj, const c=
har *name,
>          return -1;
>      }
>=20=20
> -    if (!g_str_equal(prop->type, typename)) {
> +    if (prop->qapi_type !=3D type_info) {
>          error_setg(errp, "Property %s on %s is not '%s' enum type",
> -                   name, object_class_get_name(
> -                       object_get_class(obj)), typename);
> +                   name, object_class_get_name(object_get_class(obj)),
> +                   type_info->name);

How can this happen?  Or is it a programming error?

>          return -1;
>      }
>=20=20

[...]


