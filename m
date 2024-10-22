Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECAED1CDA1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 05:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t37MY-00038X-V9; Tue, 22 Oct 2024 01:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t37MW-00038I-0V
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 01:23:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t37MT-00045I-Uh
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 01:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729574596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9R4JegqmPUXx95smUUBPS73jO6rt+jFmtGrrCOl4y7A=;
 b=FwtEgVfshEarznSFKXrZv1Qj+pZzEgc1jRFDZvbfWOgDU1a5jldhfDc/8pB90UjC0eHQQg
 L1xKPFXa9oyVq8X2k4u/eanlwaFV1053VFb0oC0JMp1XctrUFc8/AG9i2y/rcHEsLdYhNX
 aI1/Fl15zNhnb3mO5CPfM7uoDbzxi24=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-HKob9jNZNLW4iofERIB1DQ-1; Tue, 22 Oct 2024 01:23:14 -0400
X-MC-Unique: HKob9jNZNLW4iofERIB1DQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43159c07193so46335215e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 22:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729574593; x=1730179393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9R4JegqmPUXx95smUUBPS73jO6rt+jFmtGrrCOl4y7A=;
 b=YK+6yeK0cSRldtab3iCok6uXtl4QkTU4pjHjAZ3Mzcp7luARhQ1zaNVPLfpd7XeZ9U
 er3QfG0CBZGg5m1j79/tGCvYb4S+4fgC75v5adixOdipxn34AH39uavIsG6w0P0guKyv
 jTWtgFh9MHPkUlUEIYusnIhkV+WfdmIBJvbNuF74ARpucfY9BNDCfAIGcLjyHdp1ubO3
 GXT4+ht5KGUxcdbhKICEUjNPIRIMUjffp6t1thyh9pB65hSSF1Yxg/D5+HNUP9+sIQGC
 fZ74yqVvg+PwulcdNMeVPHiU4UiNdPThPxP4zigxd4vajSZTB/av+SNOWSW1RuvzrUo0
 FV+Q==
X-Gm-Message-State: AOJu0YyNWW4JdLz3lmEBkT+uAmWn4f2sMZf9NERTmlNcZPfbrVy5HtrX
 FWPqJp7aaT9ZQaED2xG188gsDt70uhgpGGRRyldarmidVuLhR0wKFOW2LCLJ14BNV+CvOT6/cGG
 r1WdYs+gLh2zkxKAQPDZZ6DtoruwgQ4Za1EKvuY/vIJKDKrr+UtJTQgnIh0BZV+wJ4W/3J5aX9L
 aGs5JJQKle/8un6XXl3Zzmtt2kYrY=
X-Received: by 2002:a05:600c:3b9b:b0:431:562a:54be with SMTP id
 5b1f17b1804b1-43161627c0dmr162388795e9.9.1729574593265; 
 Mon, 21 Oct 2024 22:23:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYni3e127UIJn8X29NLGhal+BdZBq4gjjsuvOVg3UOp3MSSkKrqrmyyRHzERHE8LL7KCQJuaBut/qZ4w4cj24=
X-Received: by 2002:a05:600c:3b9b:b0:431:562a:54be with SMTP id
 5b1f17b1804b1-43161627c0dmr162388365e9.9.1729574592850; Mon, 21 Oct 2024
 22:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-11-pbonzini@redhat.com>
 <12b03ebb-6bc2-4ffe-99cc-4818b5d992ee@linaro.org>
In-Reply-To: <12b03ebb-6bc2-4ffe-99cc-4818b5d992ee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 Oct 2024 07:23:01 +0200
Message-ID: <CABgObfawNPijVE7FqdGpnpAZ2JM9puY6=PSivFR4GgbHTKE2Fg@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] qdev: make properties array "const"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

On Tue, Oct 22, 2024 at 6:31=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
> > -void qdev_property_add_static(DeviceState *dev, Property *prop)
> > +void qdev_property_add_static(DeviceState *dev, const Property *prop)
> >   {
> >       Object *obj =3D OBJECT(dev);
> >       ObjectProperty *op;
> > @@ -980,7 +980,7 @@ void qdev_property_add_static(DeviceState *dev, Pro=
perty *prop)
> >                                field_prop_getter(prop->info),
> >                                field_prop_setter(prop->info),
> >                                prop->info->release,
> > -                             prop);
> > +                             (Property *)prop);
>
> I like the overall patch idea, but I'm not keen on casting
> const to non-const. Should we adapt the callee -- here
> object_property_add() -- to also take a const argument?

This argument goes into prop->opaque and is passed to all
accessor/resolver/finalizers functions. So it would be a much larger
change because it needs to change all those functions from "void
*opaque" to "const void *opaque".

It would also be an issue because some finalizers write to the opaque
for good reason:

static void object_finalize_child_property(
    Object *obj, const char *name, void *opaque)
{
    Object *child =3D opaque;

    if (child->class->unparent) {
        (child->class->unparent)(child);
    }
    child->parent =3D NULL; // <--- here
    object_unref(child);
}

So, it's not great but it seems necessary. At least keeping the const
within qdev properties makes things "safer" within that realm.

Paolo


