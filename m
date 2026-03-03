Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F5FEDA682
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRKF-0006Kd-7q; Tue, 03 Mar 2026 10:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxRK9-0006Gw-V8
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:06:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxRK6-0001zi-Ug
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772550369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+/1Ia0JDxT+wMwXWYRKbNyOnEImODRJtabXEfJLopJw=;
 b=INrskINz9MN9lQYBAGWsont48M0VwHX3WGuMHFF3u83+/rRwfLK3ZH7XdRFF09/+W2GNWm
 4teT72qwU5s6icM05rXDAlrCenS1+pGOkyTKySnap3PmMZA1BRCuFbzCrkr4OkG2OORt8+
 L2fKVRjBeXe8jereJySdLn0kOcDhpkQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-cPDTcwodPwGtS2I57XcDPA-1; Tue, 03 Mar 2026 10:06:06 -0500
X-MC-Unique: cPDTcwodPwGtS2I57XcDPA-1
X-Mimecast-MFC-AGG-ID: cPDTcwodPwGtS2I57XcDPA_1772550366
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cb37db8b79so4429671885a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 07:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772550365; x=1773155165; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+/1Ia0JDxT+wMwXWYRKbNyOnEImODRJtabXEfJLopJw=;
 b=FVvfZRWhpY0PkydHYkKESQiNy7uwRHHKVdEP3ntCQ+UHjvYZOycnujWRuOWe3HlhtH
 uWE/9eL8e3io3gf6GmXuFQwaF516ErTV6supTwUPhTpdCqSyGEd2dH45aKxGItpvTuOQ
 7BfPPSBMwLH4m9KUIlxBCAdqqsM3XJ4pWvCu1EV2MIHytlM5OcdqXYkwbPJveWZauupN
 Cb6spC/iXKbCaw01v6ulU+U9Q9qYBHtMEpUPRcaD9ln2FuUrrxMrNCU36e1XBBw5Aak4
 qzp5op1C2pD2TjG79WttWwI/0J/fLH8K02PWyKPXagRrPBss1kypw2CNUfUt2SAoTxe2
 7B0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772550365; x=1773155165;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+/1Ia0JDxT+wMwXWYRKbNyOnEImODRJtabXEfJLopJw=;
 b=sOQQudMvGnCKfTRdsYCqAJRV3noLVSjacXu9TY3IkAMAUOsP4YIx7xpxBjvYCyxMJS
 n4pTXB0kwFXlrnxImrjjsyWQwdcfWbBVXRoL/4huUfFdaoRujP5n4vEHVuWlsGNLe7/4
 h7MC0IVviGKA3k8f62cSRdGDWjXBYMnubdQQzxTEaz3bMNJ7sZVf0iIwp/0d66Gxbjui
 102XTcjpuA++/p0RxuQlrlBi6zTgp147BTSon1UZpe70yaRgb0vbxm5lO9lEe2Xrjez/
 Csfz0akFofQEeH3+za/5natUCcLMMv8h0MOMBWFAAqkyKwiDWZm/m16Ua7M1RheO+t4z
 g6qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL/FKzUVWIU1Hw5RMMnfTjmJkzQEfZPjE12iplG3Squy0TLTrCvq2ARbOw7Aq6IKI+pnpmg0mAlBXK@nongnu.org
X-Gm-Message-State: AOJu0Yw/dh1Sut9j/uWiDWiB3EeR5MCkBNqawdKOv5MO3VLPA81U+PGV
 JRMPGqwJgXXqI/y+Xr7+IpFXhfGtZtSpnbK/hsoNXgDomvBxp0ijwh4n9fqIiKz2B8CiD9y3wim
 KLR4Kyh7LCRa0XEqDCKe7tRfDN8yXl/l8aZlOte2ONhrvYcr8umIfjZMt
X-Gm-Gg: ATEYQzyjtBJNzjpWaaXXeSZmO1xoP7LpNlagdqsQKVVquNiBN7PviqqrhGREdui1w6Y
 V/XqINvunwwZ74ukI9dGvvkYRkC6qEe4SFQb7X16Zf9AHipdmd+kW9IQIfxy9c1itFY1Vg4Xte0
 xOb5yzRz0MdPGm2UMveT3e46HaO/sc4ysJOMAfC/jnriGuKR9TcIMatBHpOcDxlbvw1ZGpDCciE
 Jq2EvSnz0PVSusaCP6wQjq/jPfYIQovGFZD99UZ4NbXVqT1hFO9IwVr5dpanMf6mAlXwuXbbN9o
 qGsYilSGS7lIhVf7r8pcc46kmJp6zagqo3Rz9HznY5+VR6BAL0iCpGPrIjWpB8uygp54ao/1BWb
 D8x/kVo0VyJbmUA==
X-Received: by 2002:a05:620a:4015:b0:8cb:4d9b:6b48 with SMTP id
 af79cd13be357-8cbc8d6f18bmr1928605085a.6.1772550365546; 
 Tue, 03 Mar 2026 07:06:05 -0800 (PST)
X-Received: by 2002:a05:620a:4015:b0:8cb:4d9b:6b48 with SMTP id
 af79cd13be357-8cbc8d6f18bmr1928598185a.6.1772550365036; 
 Tue, 03 Mar 2026 07:06:05 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf6f93b5sm1399519585a.31.2026.03.03.07.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 07:06:03 -0800 (PST)
Date: Tue, 3 Mar 2026 10:05:52 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [PATCH v2 03/16] migration: make .post_save() a void function
Message-ID: <aab40Ou7EjkdYYv3@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-4-vsementsov@yandex-team.ru>
 <87ecm5u7wc.fsf@suse.de>
 <5be3da95-a636-4b50-8d68-17f363fc005b@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5be3da95-a636-4b50-8d68-17f363fc005b@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Feb 28, 2026 at 02:56:30AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 28.02.26 01:41, Fabiano Rosas wrote:
> > > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > > index 3695afd483..15578b3e28 100644
> > > --- a/include/migration/vmstate.h
> > > +++ b/include/migration/vmstate.h
> > > @@ -223,7 +223,15 @@ struct VMStateDescription {
> > >       bool (*post_load_errp)(void *opaque, int version_id, Error **errp);
> > >       int (*pre_save)(void *opaque);
> > >       bool (*pre_save_errp)(void *opaque, Error **errp);
> > > -    int (*post_save)(void *opaque);
> > > +
> > > +    /*
> > > +     * post_save() rarely used to free some temporary resources.
> > > +     * It's is called if .pre_save[_errp]() call was successful
> > > +     * (or .pre_save[_errp] handler absent), regardless success
> > > +     * or failure during fields and subsections save. If
> > > +     * .pre_save[_errp]() fails, .post_save() is not called.
> > > +     */
> > I would not mention usage directly and maybe also simplify the language
> > a bit. If there's doubt on the exact flow, people can read the code:
> > 
> >    /*
> >     * Unless .pre_save() fails, post_save() is called after saving
> >     * fields and subsections. It should not fail because at this point
> >     * the state has potentially already been transferred.
> >     */
> 
> 
> Agree, sounds good.

With the update, feel free to take:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


