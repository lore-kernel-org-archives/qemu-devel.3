Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24902606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DQOa9Uir;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ql1gNzg6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMlSN-0008Lg-UD; Fri, 30 Oct 2026 08:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xMlSK-0008KU-O3
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:11:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xMlSF-0007Lu-0z
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793362288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=huheSnuaAH41QXuP+wJKnnRPWFroH2JWTjHVE5i6hXA=;
 b=DQOa9UirA6se8ZCtd6+NTOnhD+doNcFc0nnF7SrxG0Z5hU6s9serkhqSYEbgiXgwZw06OF
 hZgx5XaA3oeXgcATPEpShBrCsyeOnFA/WaOQiZUlSliLje0nVI6mY7COfw+SoFzZpyXpMB
 6EFPzdJC+ekBxnQl7+b8bjR/3OIUOMI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-I9lRbuZlPPKNJoWhrIJNqQ-1; Fri, 30 Oct 2026 08:11:26 -0400
X-MC-Unique: I9lRbuZlPPKNJoWhrIJNqQ-1
X-Mimecast-MFC-AGG-ID: I9lRbuZlPPKNJoWhrIJNqQ_1793362286
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ae6fda7a00so723099a91.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 05:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793362286; cv=none;
 d=google.com; s=arc-20260327;
 b=bJyLzwpw44iwXOq3swYrYlogDKn5Fjru11ulyLKUvqJ13D9ux9K6rjdBniYaGyVcVp
 Zn/f5iUfjaRFT7SMT4Js5oRrZBvfRoEqwgMu4il9SD9haD09Yo0tdd7NtD/DLnIwJoi2
 LCg5XmU9zGjRz+HWAtNHb7ctwej27bMiXhnIGNfKay6vmkgHtJffv+7fDC0Uj3lyXvKR
 WfG3UerOlVo/nxossSvdVDFuKak0AVk0o0Zx522BitvuQCE/+BeWa5j/BDsG7e9LkP/T
 JxC+DawXKvIrtgLfLS/Ev6Kb1Inllc25cSMQtk2hbk0KsW6O2s+Ix908BN7aKn0sLuKd
 obeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=huheSnuaAH41QXuP+wJKnnRPWFroH2JWTjHVE5i6hXA=;
 fh=oA53rlS4uZfqg/RaN6lstJP99cXxfObZD8vmkwJu3Ys=;
 b=EhWYAzScQyeMHLsamFw6iDVvEy843afxhsznOEC6OSE326D0Xi92XekypMs6v8TNAi
 Ctqt6UyaMj10j39S+2NSNMk7RSC4EZNj8Z9UoSAr4VWTt7Q9MgQVwE5jt+R2zyP0nhGm
 IoKPaHcmMt1vsRmI0HI0dFwB/97t8AZqOGhIbORobSQHWqwHzI1yDyG7VJHKQUrhuZz6
 zvsrRFvdVT3T9aRVjCK0DM2QMpVcrhe7wQ8RbG1aNyTbLxq13VM/P4SFyykYkhHOMtlq
 xwxGfOBpwmIUoAdsXhYqA7yJ/zHBAPHYsraL4TEm4c9rRHb9VxaLuu+GuNBupFNAaUQO
 +K1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793362286; x=1793967086; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=huheSnuaAH41QXuP+wJKnnRPWFroH2JWTjHVE5i6hXA=;
 b=Ql1gNzg6i0EXCTUbvYFr1hU4JTggIpQgsjGaxwoslX9f5g7yNjGBv8IXytuAVEWIwa
 Il2LZfVrHxKXmtVbV0tltdZncWovMWbJtS0XWDhIcQjzz56x2yhV95WdMttIs/uE96YX
 NCG2d99R88Nd2JvIZyomMMrRdxpN23gfdIG6khNgGrR8ZpiS/R/5L6M1/sAl3Gj2syqU
 7XNQJ9QHFjP6cKzXABPu8JzJ+cpuoQHo4RpkjyKL+eoUMGY9Gz0Ly/OA1XW1yJ8nTtbr
 KN7BI8LNM32nPi5OBFV4tNu+SdZRrIGAophsTzHOi1JICXPiei4rWKAfPkibXGQUnSAN
 QE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793362286; x=1793967086;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=huheSnuaAH41QXuP+wJKnnRPWFroH2JWTjHVE5i6hXA=;
 b=fPXW05V1C56UY8C6y62kQbH4gswdsCrN74jOLam5SE97nPmrosDWKv14UxgjFvk988
 4nC9q2Iih5DTgPxiHqYk5HV+0FLSsBSJDoLkg8Vtbjusx1iMePOc/itWfzDMo6LWkwJ6
 7UpDnHi1bemTqUCw9gMKANS5osE1h+0nJ7ehRSl/wns2KSh++b1zLkm48E1Ly+w9r/W4
 rfAZOl3o30DKkyu0Fgfthme2gJPdg5gkQ4jL5P1utgPA7aXwfS6okDF62NuU6fLeYbdM
 +ghOVsgwj/E4wvOi2EWdXzBEjRkdIj5jrC+zCArrsFL9/QVzEynHbvJqpHeXldFPaiKb
 54mg==
X-Gm-Message-State: AFq9FYKhzne2rn81Jo98oFdUC7f+5vVqaSXRdDARGm7vgQ8vEJ8xeSbf
 JSpagiR8DfcOA3l/SIro0MkH5GP/MrYbStXlQuAmoC8ZIg1Bd0ODbcQOu9wiGwrPhtCZZ7QkIFq
 WUrWff7wJYNbeU9wRUBGsF9RcGsKPm1StIeNCQQssRBI4hSHx0mS6MOxfKBJM67uxyF1xsuzZ6W
 6Ipk837jf4kTuLhDgBmTq95PDpwiGHuKc=
X-Gm-Gg: AYBFou0ZVnjd7k4zW9+kUEELdfRHcn/KbsZQYZVJPX3/SCFikoJpX/5erImflzaEIWn
 tVwLQSEm4gmvLbOPbZkbAJmvdc3WnCaTHEkpw8OzkoZVfQJDzNOa+emW+h7rKHtUE5XltdYUZ0U
 fl/Y/u3eUSWdw4dfyqlXyZmtmO1MwoIfilbQNs/vj951TQm0AE8YheG1Cq0YCdYC3XgSeb+p8CG
 myubjBY4v43n8Eff1ZlnGOJM0fH/0ybwI+UWfDReiDJZFl3oxzOrFIddgNM7eNytGA9AU5Qhn0e
 hw==
X-Received: by 2002:a17:90a:c2cc:b0:3a8:f70f:2437 with SMTP id
 98e67ed59e1d1-3ae8980bd04mr1669682a91.50.1793362285570; 
 Fri, 30 Oct 2026 05:11:25 -0700 (PDT)
X-Received: by 2002:a17:90a:c2cc:b0:3a8:f70f:2437 with SMTP id
 98e67ed59e1d1-3ae8980bd04mr1669589a91.50.1793362284955; Fri, 30 Oct 2026
 05:11:24 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
 <20261020-qom-qapi-v7-17-431a86b02b58@redhat.com>
 <871p97a4mf.fsf@pond.sub.org>
In-Reply-To: <871p97a4mf.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 30 Oct 2026 16:11:12 +0400
X-Gm-Features: AclHuK9SdcKVottvuTeAWY4qSYFB8MXW7mNBnZIWRbyUXQq4NjRMq0jo7wIcSr4
Message-ID: <CAMxuvayHXMftaQP6X_14pAf63bjX8mXxsW4TsXnLf_wbOq6eUA@mail.gmail.com>
Subject: Re: [PATCH v7 17/65] qom: add object_{class_}property_add_qapi_enum
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
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
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Fri, Oct 30, 2026 at 2:02=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/qom/object.h | 74 ++++++++++++++++++++++++++++++++++++++++++
> >  qom/object.c         | 90 ++++++++++++++++++++++++++++++++++++++++++++=
+++++---
> >  2 files changed, 159 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index eb61d8842b80..e04be4caed57 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -2027,6 +2027,80 @@ ObjectProperty *object_class_property_add_enum(O=
bjectClass *klass,
> >                                      int (*get)(Object *, Error **),
> >                                      void (*set)(Object *, int, Error *=
*));
> >
> > +/**
> > + * struct QapiEnumProp: Descriptor for a property backed by a QAPI enu=
m type
> > + *
> > + * Binds a QOM object property to a QAPI enum, providing automatic
> > + * string<->int conversion through QAPI visitors and optional
> > + * default-value initialization during object instance init.
> > + *
> > + * Use the QAPI_ENUM_PROP() macro to construct instances inline.
> > + *
> > + * @name: property name exposed on the QOM object
> > + * @description: human-readable description (shown in ``-device help``=
, etc.)
> > + * @default_value: initial enum value applied via @set during instance=
 init,
> > + *                 or -1 (the QAPI_ENUM_PROP default) to skip initiali=
zation
> > + * @qapi_type: pointer to the generated QAPITypeInfo for the enum
> > + *             (provides the string<->int lookup table)
> > + * @get: getter that returns the current enum value as int, or -1 on e=
rror
> > + * @set: setter that receives the enum value as int; %NULL for read-on=
ly props
> > + */
> > +typedef struct QapiEnumProp {
> > +    const char *name;
> > +    const char *description;
> > +    const int default_value;
> > +    const QAPITypeInfo *qapi_type;
> > +    int (*get)(Object *, Error **);
> > +    void (*set)(Object *, int, Error **);
> > +} QapiEnumProp;
> > +
> > +#define QAPI_ENUM_PROP(...) ({                                        =
   \
> > +    static const QapiEnumProp _prop =3D {                             =
     \
> > +        .default_value =3D -1, __VA_ARGS__                            =
     \
> > +    };                                                                =
   \
> > +    &_prop; })
>
> This is a cute and reasonably well-known macro trick for optional
> keyword arguments in C.
>
> The example [*] below specifies all arguments.  What happens when we
> omit any?  They default to zero via default initializaion, except for
> .default_value, which defaults to -1.
>
> Trap for developers: some arguments aren't actually optional!  If you
> forget to specify @name or @qapi_type, the code compiles, but crashes at
> run time.
>
> Not a fan.

Agree (not a fan of C either). We could probably add more
static/runtime checks. Or clearly state that there is room for
improvements, or just drop it altogether - either as follow up or with
the series. I leave that up to you since you are going to respin it.
thanks!



>
> > +
> > +/**
> > + * object_property_add_qapi_enum:
> > + * @obj: the object to add a property to
> > + * @prop: property descriptor
> > + *
> > + * Add an enum property with QAPI type association.
> > + *
> > + * Returns: The newly added property on success, or %NULL on failure.
> > + */
> > +ObjectProperty *
> > +object_property_add_qapi_enum(Object *obj, const QapiEnumProp *prop);
> > +
> > +/**
> > + * object_class_property_add_qapi_enum:
> > + * @klass: the class object to add a property to
> > + * @prop: property descriptor
> > + *
> > + * Add an enum property with QAPI type association.
> > + *
> > + * Use the QAPI_ENUM_PROP() macro to construct the property descriptor
> > + * inline. If .default_value is not set, the property is not initializ=
ed
> > + * (default_value is -1). Otherwise, the setter is called with
> > + * default_value during object instance init.
> > + *
> > + * Example::
>
> [*]
>
> > + *
> > + *   object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
> > + *       .name =3D "policy",
> > + *       .description =3D "Set the NUMA policy",
> > + *       .default_value =3D HOST_MEM_POLICY_DEFAULT,
> > + *       .qapi_type =3D &HostMemPolicy_type_info,
> > + *       .get =3D my_get_policy,
> > + *       .set =3D my_set_policy,
> > + *   ));
> > + *
> > + * Returns: The newly added property on success, or %NULL on failure.
> > + */
> > +ObjectProperty *
> > +object_class_property_add_qapi_enum(ObjectClass *klass,
> > +                                    const QapiEnumProp *prop);
> > +
> >  /**
> >   * object_property_add_qapi:
> >   * @obj: the object to add a property to
>
> [...]
>


