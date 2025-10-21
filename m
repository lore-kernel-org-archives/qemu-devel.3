Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC91CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 18:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBGo3-0002co-Gp; Tue, 21 Oct 2025 14:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBGnz-0002bR-2s
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBGnw-0000Cq-7u
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761070188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PWyBcu85Qzt+QiSiRjojBT3ZvVL/2JPHnHYZ1qAfsXs=;
 b=hT+aIbnCHxM+kKngJjhEjZ8qc/0Cn6WZ9q9pfGhiEKlu4wNRWS80FNdWvmC+WD7CNMkj+F
 4sEKUeb9JapiIynMO0KBz3F4elTZhZhdfTB/uWb28iHU9ncTlweLCJPrbh2YxSah0Fva9S
 xWaFMvwLUS0cw/wgcmMoYXu/O2G9LLQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-as3U83GpOKGjJ5kOSROkVA-1; Tue, 21 Oct 2025 14:09:47 -0400
X-MC-Unique: as3U83GpOKGjJ5kOSROkVA-1
X-Mimecast-MFC-AGG-ID: as3U83GpOKGjJ5kOSROkVA_1761070186
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-78e30eaca8eso277224926d6.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 11:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761070186; x=1761674986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PWyBcu85Qzt+QiSiRjojBT3ZvVL/2JPHnHYZ1qAfsXs=;
 b=bs2Nzr80TNiDTDzpXZYb54FKmPOgR+YCXGW9/w4m/DHkKAWOQEml/kL2Kemtg2PbxZ
 J2vvsXixg6Pf5a4wt6/BeHVpbtVfOE24H/TQzHx3XHxNtLf/V6oviKANF6qwgRv5vLN8
 LRJFvn/2g5NTARwnfBDSct5g7AmnXPUc2DdLLh9Kwg4GfcUp33IUbYTecb6Y9m9UFOpG
 k2kF0//MfGwMV2bmwt2FUGJQi78ev0ozTd0rrSz5Bo4kQfQ59juRrfHx8FKJGxGm1jKm
 o5v2Mj36QeFVatt26MwI30rWIMTEQGkE830B0tiW/wlSTNZqFoxB5yw/aYqr93ks8H8r
 WybQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX7lRWYssRekblpu2c8c7eA4CtvUPjNtI98TPWRUoL19Eh7+m7PSMlBc6HqOthMhsFUUq4IBnBM/JH@nongnu.org
X-Gm-Message-State: AOJu0Yxlom9E0Hfa+XRA+H8KNNHoAEX2/tWst0hJZ+C7ieQrjzU6YJpy
 aWlRDQp8opXmATIFKek5N2oQwJVBNJTyiiFTh6xQw1gMvRl/k1dakOXEyEioM2xu/8GuTLCTwgQ
 7ds45uGw5V5+js1d9UxAnjEE3XfX94qYsc2PnDsxh8Bc2bND+jI1lgBha
X-Gm-Gg: ASbGncsVSQ4zuf5o0KxO5UpciQlz1IjMrrEjKpC5cxHrmbzZMV3fQ5N1R+fZmYny8Qx
 /HQrKG6MW+7+W7oVvYILyw+bVO+3KGJD/wftzKhl7mpvT4h9AJ/dxLzoi+uMNDtrSnCKJ/HajqZ
 7YAzKU5Ku8gaNB9YwSH9EFV438NbKXV9PVD/6VPSmkuiD3lUNTJvhqH7+fr7ZCpol/8Y0tEvvqB
 Ju5KKpIGu23HWQcbO7VJLLQ3YlaBPWC4Ao/+xo9TwegCFSXXU5KrFDb3+Rq0HckEcU0lBhe4Il+
 g5QlIl+1FdgL/CBhcz7Ia0M2NbBanCTdm9byE4Op4iHoafglM9mV9zEItgMb2anctLw=
X-Received: by 2002:a05:6214:518b:b0:87c:203e:69fe with SMTP id
 6a1803df08f44-87c20596becmr240193646d6.25.1761070186153; 
 Tue, 21 Oct 2025 11:09:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+NZSK68TFm9VxW/1d+sKYjnic7bUDGZTB6vsKCH18FBC9yOF2ig/TW2WktZeGBtCbMKMYig==
X-Received: by 2002:a05:6214:518b:b0:87c:203e:69fe with SMTP id
 6a1803df08f44-87c20596becmr240193136d6.25.1761070185576; 
 Tue, 21 Oct 2025 11:09:45 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87cf521be67sm73247866d6.16.2025.10.21.11.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 11:09:45 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:09:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PULL 02/45] migration: push Error **errp into
 vmstate_load_state()
Message-ID: <aPfMZ4ugzwbAy_93@x1.local>
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-3-peterx@redhat.com>
 <CAFEAcA_230hx7mFzo=jT07heROTvjO=q7B4B73+gO_KneC6EuA@mail.gmail.com>
 <aPex9SsQOup69DRI@x1.local>
 <CAFEAcA85DRf5918ea9N66+Z7M_vVGNy+-SdSx17E5MGOf_cbMA@mail.gmail.com>
 <aPe4yBqkPTiDiYXq@x1.local>
 <CAFEAcA8e7qKGm7vq-8TFC40VMfoGU_O5+U0rrKG+Z8M3fVdRfg@mail.gmail.com>
 <aPe9Z0IiEI6mzCdY@x1.local>
 <CAFEAcA_BAxh8BAYPAbPEp_P98gMUdZqZ=2XZHrmGQ+GyEViF_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_BAxh8BAYPAbPEp_P98gMUdZqZ=2XZHrmGQ+GyEViF_Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 21, 2025 at 06:22:55PM +0100, Peter Maydell wrote:
> On Tue, 21 Oct 2025 at 18:05, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Oct 21, 2025 at 05:49:51PM +0100, Peter Maydell wrote:
> > > I suppose so, but that seems like something in practice
> > > we make a lot of use of. It's really handy to be able to
> > > say "this is how you obtain the integer you wanted to put
> > > in the migration stream" -- we do a fair amount of that
> > > in target/arm/machine.c for instance. But those don't
> > > need to return a failure, I suppose.
> >
> > That's exactly what pre_save() / post_load() should do, IMHO.
> >
> > Taking example of the arm's case here:
> >
> > static int put_fpscr(QEMUFile *f, void *opaque, size_t size,
> >                      const VMStateField *field, JSONWriter *vmdesc)
> > {
> >     ARMCPU *cpu = opaque;
> >     CPUARMState *env = &cpu->env;
> >     uint32_t fpscr = vfp_fpcr_fpsr_needed(opaque) ? 0 : vfp_get_fpscr(env);
> >
> >     qemu_put_be32(f, fpscr);
> >     return 0;
> > }
> >
> > The .pre_save() should be exactly the logic that generalize whatever we
> > have had in QEMU's structs into a pure uint32_t, put that into a temp
> > u32. Then migration should be able to transfer that using whatever way it
> > prefers.  When using qemufile API, it should use vmstate_info_uint32 so as
> > to not open-code qemu_put_be32().
> 
> I think this is very ugly, because it means that the device state
> struct ends up with a pile of extra fields whose only purpose
> is to be temporarily used during migration. Having a function
> which does the "figure out the value at the point where we want it"
> is a much nicer API because it keeps the migration related
> complication in the migration code, and keeps it out of the
> data structures that all the rest of the code has to work with.

It'll be a temporary struct, can be allocated only in a pre_save() and
freed in a post_save(), for example.  And IIUC most of the devices do not
need it when there're already good representation of the data for migration
within the device object.  AFAICT, the latter is the common case.

> 
> > Now, we have a major issue with qemufile and all the APIs that bound to it
> > when we want to move the IO layers from qemufile to iochannels, exactly
> > because we lack such abstraction layer, where we mixed up "this is how you
> > obtain the integer" and "send this integer to the wire" operations in one
> > API.
> 
> Yeah, this is unfortunate. But I don't think the solution is
> to require a lot of extra device state struct fields to carry
> temporary data for migration. It would be better to have an
> API similar to the existing get/put functions but which
> passes the data back to the caller instead of calling
> qemu_put_be32() itself.

Yes.  I feel like what we said do not conflict with each other.

What you mentioned looks like a per-field version of VMSD's pre/post hooks,
so AFAIU get() is almost a post_load(), and put() is almost a pre_save(),
only that it will be per-vmsd-field, rather than per-vmsd.

The important part is IO path separations, IMHO.

Thanks,

-- 
Peter Xu


