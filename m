Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE67606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Aqa7FbgG;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GhxhDXyM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKDcf-0008OX-DC; Fri, 23 Oct 2026 07:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xKDcb-00089r-Vl
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xKDcZ-0006Db-Kr
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792755578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BwZKJ1y9GJGdttliesnC6UNJffqn1NZdo/yH29SzxfQ=;
 b=Aqa7FbgG+y24GyAqMkXLrjublyxPemhdCvGAybNmKiR0JKJIM08rOFmhz8RUPT1S/oPtcE
 HvSEb2nUL8qJ9Ls9q2l3yzRH67H9Ig26L5X7U1MskK4yPoe81aDBWD8moPnxVR2Eb7K+dq
 zgiflRKszSi4EgaHr9Ory7liolUJzF8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-SzxWVJq-MLep_z8_kGiAjw-1; Fri, 23 Oct 2026 07:39:36 -0400
X-MC-Unique: SzxWVJq-MLep_z8_kGiAjw-1
X-Mimecast-MFC-AGG-ID: SzxWVJq-MLep_z8_kGiAjw_1792755576
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab868fe362so1354350a91.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 04:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792755576; cv=none;
 d=google.com; s=arc-20260327;
 b=TYX7qgYggZCyoQviUamICycLhKQRRdsOvQhDI3jDRva2XP/qp7BssG8+Q9Vw9jBTa8
 WdxQoJQEUFeEApi2iksfbUkG3DETlSSisu/vsIzjRfbGy+hN2/wABcbJ+GKrPG58jA2t
 dPbCQNI88Fhq0/WKmjhPtTxk54WMNNsA5QLKPFOkWcNvaMWMJckgmGjQjTiJD72kiPV4
 p7s97D5geA3I0ChX6JNSEPF/tswLq6INCEs8jmy09iqiFNulY0ln+NiBxYQgEAWBe31S
 6PseLkYrkQMpvPpmyJMWzzUDT0+2CqIHipqtf9FeCi6u70jLDpJ/JQrVXuN14xJ+ckVE
 HQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BwZKJ1y9GJGdttliesnC6UNJffqn1NZdo/yH29SzxfQ=;
 fh=69DzGMBtEw+voSHuD+7qm/v7hkBVuggeEhdPGcXxSfY=;
 b=MraVUwd87ex9Tj5vEgYQnsEe6yvF8tjeCs8oaM3dDvbzgGuhvJK/9LZHuzrsEP0XWE
 VElEDYZBNwywXH2EW97M8lFMEBY3Y7oynTinYZvWrz07ntJOy6q8KFMjMCuA46gAd38x
 DOtSCjLb3dZ5kpJJUHpHtiPyzVNrfhwyFoFFfCdo/THUew8F0JDMC8NGL9CaB0VNTpxm
 nhi2kz3bSpqLDJHwAUwTfsp2crEs/bttgr4ePrGpJVpmFpZFET01q+cFDwvSdgBpAvWH
 vlvusA3VzVC/VyFMqHjm5psmlbT0kPH4ifev5dot3YdJ/v5e1ZV+ygn4nYzaX8m4g5J6
 lIvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792755576; x=1793360376; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BwZKJ1y9GJGdttliesnC6UNJffqn1NZdo/yH29SzxfQ=;
 b=GhxhDXyMLuxxH8YgdW9MBO1mOC4PbXkDih7DHnO+btR7XafrUgms9QhJdsrZMuw33h
 Rlj7jraq/xVYqu7vHUUDTtcQWu21k2AGy9HaKMotP+RHQvypWvg1diLE8NapGghI04gj
 HMeJgFOklLh34gavp8+hlPjbsfgVuNjSw+Mnv4TqBcm7PuU2QHwNGzwCwHwW6RvccqSx
 UzCUO0vA6ZvJCcQTSEpIQSc2IH2cP6P6FIQ+Md78Rc7gS91JsyaP0eQxnX8HI8Ceg88w
 2SxXvKoI+eFIkfVwRrOa/nkzsdcbTg01AohMajcpAVjgpHI+a05ICkzrzwYAgy/D/ree
 akHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792755576; x=1793360376;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BwZKJ1y9GJGdttliesnC6UNJffqn1NZdo/yH29SzxfQ=;
 b=W4Rm47LwbqZrK1UfcwVvrT3khEEmXFHV9YqcCXAy+MvQl8Vbf97Y2eG7QunwYUBr+/
 S5/pzaoz69c9gTIgTh3DPN8BVyy6iW0Ww4TiXG3ThkV6wH4C0/a5iMiT0wgGbtjr0L/C
 Mxe4lwj3UPWyFp3Q9YvS5vLewa8t7PWzgCo3J2qrUtLoIvnDC4IefpbpV3OQfwc86Fid
 kpkeeozskM8wmyjW4rc99uqYNh+Y1Gb17bvKqHmAG/7JOacUUWo1QwhIMUNnvQSvP8fy
 3Va2zCpxI2OQyxMR2H6T8N1Q9WbxOmwBP4HhPNrvUxpbctE6DE4Joh1xvMFuaHgL2Pam
 V66A==
X-Gm-Message-State: AFq9FYIdXg/NFFDXHd+l2VAHqM1qsNB1Rq4ImBSXUtWtXfXPVoo5YxWg
 WC4YxrSuAPYk06RZe6++z2HM2Y/JEEYSjQkqbdouCqVXVvLssx+7XlUuyF3rr+JGVbVQzQtJkdU
 nfjt/wHt+3UdxqCu/z25zodJMxIeqhI9RKEdASrxgZGpV0UuuKV6PvibzeFFulkr3TzSDFmV2Vm
 IUwotfdmazrbUKC17bOH8mzX10HafYAVI=
X-Gm-Gg: AYBFou3wljc1bBWaGyeskLt+pEX9/XG56owIuRxd/1K2Vl48+YaAgM3BmwCa+Zu9Xop
 KDESMomAkRr0+td1HhwKzAwUzBuF/2wLtt1BKPRzuzA2P3wOwxEBGgQZRrIsMUcv9hOcTzc5St/
 RyKMlKUkM4a3koPCHJgT5e6hzV2qp4LNPOIErBJdvt8t6N8vzHDhDT/opSPD/RKQthuXHUJFNNb
 glrBefaX8jTaN86xY4Ajz3O6Qn2OwVwSp7ray35SmQ4Q2KfxeCi0DUzaGolCuVxYbHI7Fu8JPRL
 7A==
X-Received: by 2002:a17:90b:4d06:b0:3ac:ffb8:1809 with SMTP id
 98e67ed59e1d1-3adce45dd72mr1525622a91.39.1792755575441; 
 Fri, 23 Oct 2026 04:39:35 -0700 (PDT)
X-Received: by 2002:a17:90b:4d06:b0:3ac:ffb8:1809 with SMTP id
 98e67ed59e1d1-3adce45dd72mr1525520a91.39.1792755574796; Fri, 23 Oct 2026
 04:39:34 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
 <20261020-qom-qapi-v7-54-431a86b02b58@redhat.com>
 <atsxLV5YZo8dr-8G@redhat.com>
In-Reply-To: <atsxLV5YZo8dr-8G@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 23 Oct 2026 15:39:22 +0400
X-Gm-Features: AclHuK9JciU6rOmPmxGP7LAL0cKom9fJOgwoGNnQZ4aTaCAv64YMDSwyPsEK5ck
Message-ID: <CAMxuvazd7G_NBOM_c6BxZn5PFSw=XQUHueHqBoQQfpzPPgi9qA@mail.gmail.com>
Subject: Re: [PATCH v7 54/65] qdev: adjust PciDevfn declared type
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
 Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, 
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org,
 linux-cxl@vger.kernel.org, 
 qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Sergio Lopez <slp@redhat.com>, 
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
 Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Alistair Francis <alistair@alistair23.me>, Alexander Graf <graf@amazon.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, zhenwei pi <zhenwei.pi@linux.dev>, 
 Ani Sinha <anisinha@redhat.com>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Samuel Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>, 
 FangSheng Huang <FangSheng.Huang@amd.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Titus Rwantare <titusr@google.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, 
 Peter Xu <peterx@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Hendrik Brueckner <brueckner@linux.ibm.com>, xen-devel@lists.xenproject.org, 
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Fam Zheng <fam@euphon.net>, 
 Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, 
 Tao Tang <tangtao1634@phytium.com.cn>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Jiri Pirko <jiri@resnulli.us>, Eric Auger <eric.auger@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Fri, Oct 23, 2026 at 2:04=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Oct 20, 2026 at 02:46:11PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > PciDevfn is a bit special, since it accepts integer and string as
> > setter, but only output integer as getter.
> >
> > Unfortunately, we can't declare an alternate str|int QAPI type for it,
> > since: branch 'string' can't be distinguished from 'integer'
> >
> > Rather than declaring it as "str", use the common type instead.
> >
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/core/qdev-properties-system.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties=
-system.c
> > index 5bfdfe1ab9d9..3381de1144d6 100644
> > --- a/hw/core/qdev-properties-system.c
> > +++ b/hw/core/qdev-properties-system.c
> > @@ -904,7 +904,8 @@ static char *print_pci_devfn(Object *obj, const Pro=
perty *prop)
> >  }
> >
> >  const PropertyInfo qdev_prop_pci_devfn =3D {
> > -    .type  =3D "str",
> > +    /* The formatted string accepted by the setter is a CLI convenienc=
e. */
>
> IIUC, this is not limited to the CLI, it will work anywhere the JSON
> syntax is permitted which is both CLI and QMP.
>
> libvirt uses this string syntax:
>
>   -device '{"driver":"pcie-root-port","port":9,"chassis":2,"id":"pci.2","=
bus":"pcie.0","multifunction":true,"addr":"0x1.0x1"}' \
>
> > +    .type  =3D "int32",
> >      .description =3D "Slot and optional function number, example: 06.0=
 or 06",
>
>
> Changing the type to 'int32', where 99% of usage is input only
> and string based, is pretty unpleasant. Even more so that the
> description doesn't even mention encoding dev+function as an
> integer.

This is purely a metadata change, the setter still accepts both str &
int, so I don't think this change blocks this series. But I agree we
could do better.

There are multiple options. We could keep declaring the property as
str instead. In this case, the getter should probably return a string
for consistency and correctness. This might surprise some existing
users though.

We could introduce new properties like `devfn-str` and `devfn-int`
that alias the same value.

We could also introduce a new structured QAPI type.

Markus, what's your take?

thanks

>
> >      .print =3D print_pci_devfn,
> >      .get   =3D qdev_propinfo_get_int32,
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


