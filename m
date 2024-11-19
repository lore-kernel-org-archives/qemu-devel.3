Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CB8D6C290
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 20:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDUVI-0000FK-J4; Tue, 19 Nov 2024 15:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDUVA-0000Eq-Ui
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 15:07:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDUV7-0005bM-Ho
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 15:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732046821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Np4UlSQlr88qjZrwbuPKd+cKL1Tqjiwys0Duh9tUh3g=;
 b=gm2XgMJnD8mcNTf9QYBO0HWYFZLLmRhmNY5Ysb1dRtX0yeDBC1jVjIbrgd/nAS1C+LVmIi
 QU584pmVJbuWPEO8k5qTewHn8JV4fMFnazOGZVoaTWA/whU6rVvp71u5PXFC5hUKfY7NKO
 OjJusyy3RcVREzABlr4avHeObfgdovo=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-ER9Yjy5TNtWDTYSwciAusA-1; Tue, 19 Nov 2024 15:07:00 -0500
X-MC-Unique: ER9Yjy5TNtWDTYSwciAusA-1
X-Mimecast-MFC-AGG-ID: ER9Yjy5TNtWDTYSwciAusA
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3e60dde7ea4so1161054b6e.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 12:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732046819; x=1732651619;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Np4UlSQlr88qjZrwbuPKd+cKL1Tqjiwys0Duh9tUh3g=;
 b=VkAW+3/roqhlDbW59qBMvTGK6H3w0YL5KQLmEAT2DQ5yUOQtQ9vUCAGODPYvCo1zdK
 0nS5biuXkKLCQxMawnVerzH34ENtuf7XQCLUreuGsjA9DNHUdwnuex2yT+UWU3FloFmG
 kjpuDvO6OTWXTux+Qh9gY/n1Y4DfHEtmUHUjblyctYRxSg2GCLEts18odR/05oIpbzUG
 NEeMFtL8aM+SDJNKQaNpXZ1NzJb8rV5xuR9MVGImOycLs2ePrHXCcGixUL+k8vuEa9Tq
 kOAIGgQOd0E2L2LvF8qWGPwzc4+02Rmn1F8s4aHeF7VFpqHzQtMxa1QlTdMD/s/ibRz8
 WAMg==
X-Gm-Message-State: AOJu0YwD6gWG5d5lK299JPCliCixPa2fcvG/ON1YhqP7tLEk2d1RDMkS
 KwyOH4F53ARQ8t49YDG+xgZP/Vj/5RiRP4coI08kfCXsT+DVF0UgtFdMQOVUlg55fHlAOQ/XEz3
 Wae4sl1c3xm2DlJLxxKuqy/oGbLHzFIRob3VKsiPIxpAkAUQT+8J6
X-Received: by 2002:a05:6808:1b0f:b0:3e7:a494:ae6d with SMTP id
 5614622812f47-3e7eb7d920amr55386b6e.42.1732046819117; 
 Tue, 19 Nov 2024 12:06:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoASNwSf+IZQAksXHRnQVseoBeu7Oh04RAkf0DfoXW08BNBf0Lo0gVv1i34fJZxK5dOiAcjA==
X-Received: by 2002:a05:6808:1b0f:b0:3e7:a494:ae6d with SMTP id
 5614622812f47-3e7eb7d920amr55341b6e.42.1732046818719; 
 Tue, 19 Nov 2024 12:06:58 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d4380b34e0sm41746d6.22.2024.11.19.12.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 12:06:58 -0800 (PST)
Date: Tue, 19 Nov 2024 15:06:55 -0500
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 5/5] qom: Make container_get() strict to always walk or
 return container
Message-ID: <Zzzv32xlLAH4O5Ig@x1n>
References: <20241118221330.3480246-1-peterx@redhat.com>
 <20241118221330.3480246-6-peterx@redhat.com> <ZzvIZ4EL92hEk4wC@x1n>
 <CABgObfamYxtgX7SubOd8OvA5w70xQ5uesJ1TuPoTK9onVO+58w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgObfamYxtgX7SubOd8OvA5w70xQ5uesJ1TuPoTK9onVO+58w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Nov 19, 2024 at 09:09:16AM +0100, Paolo Bonzini wrote:
> Il mar 19 nov 2024, 00:06 Peter Xu <peterx@redhat.com> ha scritto:
> 
> > On Mon, Nov 18, 2024 at 05:13:30PM -0500, Peter Xu wrote:
> > > When used incorrectly, container_get() can silently create containers
> > even
> > > if the caller may not intend to do so.  Add a rich document describing
> > the
> > > helper, as container_get() should only be used in path lookups.
> > >
> > > Add one object_dynamic_cast() check to make sure whatever objects the
> > > helper walks will be a container object (including the one to be
> > returned).
> > > It is a programming error otherwise, hence assert that.
> > >
> > > It may make container_get() tiny slower than before, but the hope is the
> > > change is neglictable, as object_class_dynamic_cast() has a fast path
> > just
> > > for similar leaf use case.
> >
> > Just a heads up: out of curiosity, I tried to see whether the fast path hit
> > that I mentioned here (mostly, commit 793c96b54032 of Paolo's), and it
> > didn't..
> >
> > It's fundamentally because all TypeImpl was allocated dynamically from
> > heap, including its type->name.
> 
> 
> Ah, that was supposed to be the difference between type_register() and
> type_register_static().

Ah... looks like they're the same now? As type_register_static() looks like
a wrapper of type_register().

I gave it a shot on booting a Linux guest with some pretty generic devices,
and see how much the pointer check hit.  Until I got the root login prompt,
I got 8 hits out of 35488.  So it's indeed hard to yet hit.. at least with
the current code base. :(

> 
> Perhaps type->name could be allocated with g_intern_string()? And then if
> object_dynamic_cast() is changed into a macro, with something like
> 
> #define qemu_cache_interned_string(s) \
>   (__builtin_constant_p(s) \
>    ? ({ static const char *interned; \
>         interned = interned ?: g_intern_static_string(s); }) \
>    : g_intern_string(s))
> 
> as the third parameter. This allows object_dynamic_cast() to use a simple
> pointer equality for type name comparison, and the same can be applied to
> object_class_dynamic_cast().

Interesting to know this facility!  Though, IIUC this may:

  - For builtin-consts, it grows 8 bytes for each call sites on the binary
    generated, even if (I think...) most of the sites are slow paths, and
    there're plenty of such calls..

  - For non-builtin strings, g_intern_string() will add one more hash
    operation for the whole string (and per discussed previously, looks
    like the string can be not always short..).

So I'm not 100% sure yet if this is what we want.

Do we have known places that we care a lot on object[_class]_dynamic_cast()
performance?  I can give it some measurement if there is, otherwise I'm
guessing whatever changes could fall into the noise.. then we can also
leave that for later, knowing that the fast path will hardly hit for now,
but that shouldn't be a major issue either, I assume.

> 
> Whatever we do, we should do it before Rust code starts using
> object_dynamic_cast!

Thanks!

-- 
Peter Xu


