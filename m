Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C055606CEEC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LecFGQvd;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YpjBvO+f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNq8g-0008AB-Ug; Mon, 02 Nov 2026 06:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1xNq8e-00089n-Mc
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:23:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1xNq8c-0003Lr-VE
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793618621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TJsVwHPkqUDBFAPjLg5tLLg9PE7vEkkH9TzkagjJ7i8=;
 b=LecFGQvdleuve0X5zKd8GxNRL2hGeeDiW+qLaseBWKs0F+SQHuFHif5oxAtB/mgYV8h9PQ
 38/LWyWc9Fji4sBHnQ36DyJArZ14ho/B10SWQKFJs9/nK5vLC+ucXwGkU05UbVbZUV6pjQ
 Yz33xpHLzGX0V3N7RY2JKaMwUXgIhyQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-i9o-3ATHMAOU4ptDtKONwA-1; Mon, 02 Nov 2026 06:23:40 -0500
X-MC-Unique: i9o-3ATHMAOU4ptDtKONwA-1
X-Mimecast-MFC-AGG-ID: i9o-3ATHMAOU4ptDtKONwA_1793618619
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a211bff50bso20221735e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 03:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793618619; x=1794223419; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TJsVwHPkqUDBFAPjLg5tLLg9PE7vEkkH9TzkagjJ7i8=;
 b=YpjBvO+fcHacm3W5JTZG/TYnK00oSsW6Sp15FT8LIRlJ0GUpwzMY0PxQZ8wKMgQOvD
 qQ4vkz6KEC0ktjiSJD1usurqxp90z+yoY4FoJwpiMIDbsUg22FLQYgDWVGpMt79EtXUw
 fe78bCrdbtpYCjHZakkXLn9sKB7XGOb3Nj7Bu+IBQLAFGwzr2b/Zoy3EH86+9OfxbDmR
 0JUpwdorCYJXHV8P19yEigxByIue2JUzRdDTwfnc7CnL4qCK/ytUwoknFYho8sqfL8It
 J9qwO4dXAAEedOi014b3vwVw747bmredJvisEYvaWfLLZPx2nB0v4v65IOW6s66hIK1s
 U8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793618619; x=1794223419;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TJsVwHPkqUDBFAPjLg5tLLg9PE7vEkkH9TzkagjJ7i8=;
 b=03XpUCM9PghzODPcZc3T22j7Q2eh39awyZqTwBKqHyfqMu/yMd7HTT84LlFMWO/X+k
 Fp87Dx+lTXdWTxHGYmPgxSKQhE6ymLw/84EUtIrpy04AZXvHixF0p4KONKyPdDatnp5s
 shvwprepYNvgbLypnmn9IM4ITx3UQK3sZBJzi+n7KnDpTZKK6K1vahZHuL9Jxm7bhs7K
 PnIvW4go1TXnCqdaaytfcDj6BP8uuvoOly0cs8ejsoHT3uLxBlG5PSm0GGdHerWIlM/8
 Twm+Leh5HQyZNBGat5fnyl4OcKBa9r9DLJy24Me9T+HvlvawdbUbwVvfJ8ZExii+2NRf
 S94g==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5gq24iD+Ioy18YlEbWfsfDWgYNRjR4l3uoDTyO/yOsqH7inLBnZex/8rhv6awfZv5xPBRc0r4+ICs@nongnu.org
X-Gm-Message-State: AFq9FYJ7YM5NU43GsqFvh5UoHtBtAFN5GiNdzHumAv//U3nwuNyrG7mz
 rUud0Yp2PbfZlXxauKUBlF8sg+B7dwwL226B5sk2XhTXi6ONzBVAmWTaJJlkf9bKgHZrA73ell1
 KEqPyYnbzwwyCX0lu632pBeeQ1l5E/RivEYpo088MYrVSI4rsLDXXAKOa
X-Gm-Gg: AYBFou0kKkDu5Mv8dhGJG6LGjDBr8lGA4TZRN7oNzsJFZTkHILvAhM4pmWhuPbgC8fW
 8a95PI/DhZZXSEd89TknzDxT6vMV2QOY/GyuuBvxkkDGy/F+RXx4BmXSjm9BPUT35CjvkuEghlp
 DFjWuXsFTwq8dWcof+j9MUDSL2rjEWVWQKvumevGfqAlrWYJXA6vdH5f6d1y03YVQ+sqgtlimur
 wllTga441uga2wL8i8yO5N+yLve6TEglxBRZ/950uhuXv0LNKSZDltIoRHICEMut3Eq0xoHxdVz
 vmHeAEi49c0Yw/doieHOdR50zb2EHxZQtk0t72OA94h5Tsr2XsfOAKse/J1QNRR4Pcj3Z2Il/QG
 DZT6B7q+xvLoIj202LzDEurHo5oEPpPA=
X-Received: by 2002:a05:600c:4e13:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4ac1228978cmr206755975e9.0.1793618619221; 
 Mon, 02 Nov 2026 03:23:39 -0800 (PST)
X-Received: by 2002:a05:600c:4e13:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4ac1228978cmr206755485e9.0.1793618618762; 
 Mon, 02 Nov 2026 03:23:38 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6c76507sm285021445e9.10.2026.11.02.03.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 03:23:38 -0800 (PST)
Date: Mon, 2 Nov 2026 12:23:36 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, David
 Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: qemu-system-x86_64 appears to have sgx-epc, but not
 memory-backend-epc
Message-ID: <20261102122336.2f564b26@imammedo>
In-Reply-To: <87ecdbbq93.fsf@pond.sub.org>
References: <87zew5j3iv.fsf@pond.sub.org> <ats0_RfeVugAofN9@redhat.com>
 <CAFEAcA_wabjzp0KF69-ay75QoOk=jE-TygrD-T-b60dw1iOs=g@mail.gmail.com>
 <attACqgQQ-Lxt5Pj@redhat.com> <87ecdbbq93.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 07:40:24 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Fri, Oct 23, 2026 at 11:44:10AM +0100, Peter Maydell wrote: =20
> >> On Fri, 23 Oct 2026 at 11:21, Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote: =20
> >> >
> >> > On Thu, Oct 22, 2026 at 02:58:16PM +0200, Markus Armbruster wrote: =
=20
> >> > > My build of qemu-system-x86_64 has device sgx-epc:
> >> > > =20
> >> > >  --> {"execute": "qom-list-types", "arguments": {"implements": "sg=
x-epc"}} =20
> >> > >  <-- {"return": [{"name": "sgx-epc", "parent": "device"}]}
> >> > >
> >> > > The device as a link property to a memory-backend-epc:
> >> > > =20
> >> > >  --> {"execute": "qom-list-properties", "arguments": {"typename": =
"sgx-epc"}} =20
> >> > >  <-- {"return": [...
> >> > >                  {"name": "memdev", "type": "link<memory-backend-e=
pc>"},
> >> > >                  ...]}
> >> > >
> >> > > However, type memory-backend-epc does not exist: =20
> >>  =20
> >> > There is some rather dubious code that conditionally registers
> >> > the type
> >> >
> >> > static void register_types(void)
> >> > {
> >> >     int fd =3D qemu_open_old("/dev/sgx_vepc", O_RDWR);
> >> >     if (fd >=3D 0) {
> >> >         close(fd);
> >> >
> >> >         type_register_static(&sgx_epc_backed_info);
> >> >     }
> >> > }
> >> >
> >> >
> >> > Normal practice is for types to be unconditionally registered.  Do we
> >> > have any examples outside of this SGX case where we conditionally
> >> > register types ?   Should we change this to follow normal practice ?=
 =20
> >>=20
> >> TYPE_MEMORY_BACKEND_MEMFD does the same. I did a quick grep for
> >> "calls to type_register not indented by exactly 4 spaces" and
> >> I think the other cases are "misindented" or "data-driven
> >> type registration" rather than trying to do things conditionally
> >> (but I didn't actually look at all of them, instead making
> >> guesses based on variable names, so maybe there's one or two
> >> more I missed).
> >>=20
> >> I guess maybe this is trying to work around the fact that the
> >> memory backend API doesn't give a backend any place to say
> >> "this is never going to work" early, because instance_init isn't
> >> allowed to fail, these objects aren't TYPE_DEVICE so they
> >> don't have "realize", and so the only other option is
> >> "fail every alloc call" ? =20
> >
> > The memory backends are all implementing the UserCreatable
> > interface, which provides a "complete" method where they
> > could gracefully report lack of the feature via 'errp'. =20
>=20
> Yes.
>=20
> > This is not obvious since UserCreatable is implemented in
> > the parent base class, but the subclasses could provide
> > their own  'complete' impl and chain up the parent impl =20
>=20
> David, Igor, can you clean this up?  Or would you like me to try?

Please go ahead, I'm not likely to have bandwidth for upstream ATM.=20


