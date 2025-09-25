Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06176CAC5B5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 20:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1sEK-0006W2-Gv; Thu, 25 Sep 2025 16:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v1sEG-0006Th-0r
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 16:06:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v1sE5-0004Rk-8q
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 16:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758830755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eB/XYbgfvXbN5ioKt4p03fBBYSSyMgUXJvx5vxqKiu4=;
 b=Pz56i84uYv1TggIMTN+bTonStlZB8KPCZhnvmF3fZA3mVkjjB/ssqpiLqVjPbKhXJu8Ed9
 Ruwti1wcVOrnktNTlFp8Zz/soBB03eiQ8qMEw67Xys3hK8/0iGaN9JyYWpKrHkBA4ppACc
 hHff0YDqmCAgFIfxmtjYHgkBGVpL49g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-_dxbv-7lNFKtqIfHxuoCPw-1; Thu, 25 Sep 2025 16:05:53 -0400
X-MC-Unique: _dxbv-7lNFKtqIfHxuoCPw-1
X-Mimecast-MFC-AGG-ID: _dxbv-7lNFKtqIfHxuoCPw_1758830753
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8217df6d44cso250322485a.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 13:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758830753; x=1759435553;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eB/XYbgfvXbN5ioKt4p03fBBYSSyMgUXJvx5vxqKiu4=;
 b=lkM3JaG2Uq0GFkbGWkQnDCCrwIo81QdSUWYgn8KuVi5y3wUVdWbAhBv1cXjSl8VQZT
 VT5dcTzL7BgNQQIyPjhAnz4MtoiSxQh5jnqKlT6FzdwR0A4TtNAqEJDTsLasvkXV3GLa
 zfYOUFyyrdU8qm6a2z7eS3iMHbYL1Jj3FX/6AdUEWAWHVv4LcgAkt6OJNaREK4wcMIz9
 l0E2hER3lEzhWjhS0TiFgVRcwDs7yb5YpvwWBkyFMT/n/JeiWSTG5wER1V7rlFzQhCHy
 CB5PdDIzyd0r30Z2vDi5z2TC/+WNlSrAkXAVTmFKB6Qv5ijhS4fQ0bw4JvCax1BEjUtH
 tQ3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZUmZ3/lTPD+6veUnMD7UODTM6LGfhKOSkPjy8oWPj76YszAjHLXL07tFTVnXj9tFOgY1fD4D2CWrc@nongnu.org
X-Gm-Message-State: AOJu0YwpLPvf6rjjUXC8k9OXixLydTHMpNpdIXorq+Wm3HrHX3dc+p9E
 e/55D0OBOOUq9+SOGdPLXcFbpnIjP4WfrpzzaU6KpaDR7X+M5KC5NXtcrpvlX09SMorousqrDbI
 +M+kTd+W4fJI8cTGR1TZz69Pz8kcCn5jQ1S7atUj51V7Eq9wokl23Q3eO
X-Gm-Gg: ASbGnctZdcRGx/C1IOA9p6unqpceVqDkYcyJQdmPJEC+snnN3NF/cvl/p4EuakIEhFc
 O18OgdSH3IauTBW2Q9ZMi6v3o5kNQGDapuVe+vM1btKWicXjgNFxZ2OIBvVaEZQNAgKrc1uHoV8
 JTHCIWA/dWY7IYwA5mYxmhKjZ+ZCun6LCjbyTkqKRN94CMLL34eBqX4NCp+y19/EO+B1a1eotzv
 rfU5rHkS8HAcQsNiDgRIhB+zUcfqwaOqCZ6rdxRHJIg6LbaYx5HPwg1PWLzvEw8QbssZ0LwnBde
 Eeb8OXQNlCmEQUEvWRoNgqIuW4t7051o
X-Received: by 2002:a05:620a:800c:b0:840:fb38:f723 with SMTP id
 af79cd13be357-85ae69afcd4mr594838785a.48.1758830752664; 
 Thu, 25 Sep 2025 13:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1znarV/EziqGz/0+9rXofZY3FahZS/gOyWJLFyz/ScJ+qv5kM82A+EjqfZ9bf9BNCPqA5Lg==
X-Received: by 2002:a05:620a:800c:b0:840:fb38:f723 with SMTP id
 af79cd13be357-85ae69afcd4mr594833785a.48.1758830752098; 
 Thu, 25 Sep 2025 13:05:52 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c306b5f59sm166781085a.45.2025.09.25.13.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:05:51 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:05:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 3/3] memory: Stop piggybacking on memory region owners
Message-ID: <aNWgnBV-9p6UnsYT@x1.local>
References: <20250906-mr-v2-0-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-mr-v2-3-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
 <aMHxhTIw2EGRyD4-@x1.local>
 <fe1969e6-bc13-4438-816d-b352926c33a8@rsg.ci.i.u-tokyo.ac.jp>
 <aMNMjetBDJfBiThl@x1.local>
 <4108b4f2-accf-4080-af29-a3f464d862f9@rsg.ci.i.u-tokyo.ac.jp>
 <aNRfHQoBgwBMjK04@x1.local>
 <CAFEAcA8wTsZiihr8-LKucTmeZwPBdnkdA-o3mUgaW1WzrADhOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8wTsZiihr8-LKucTmeZwPBdnkdA-o3mUgaW1WzrADhOg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 25, 2025 at 10:03:45AM +0100, Peter Maydell wrote:
> On Wed, 24 Sept 2025 at 22:14, Peter Xu <peterx@redhat.com> wrote:
> > Side note: when I was trying to test hotplugs with i386/q35, unfortunately
> > I didn't really see when the address space was destroyed, maybe there's a
> > bug somewhere; I put that info into appendix at the end.
> 
> This is https://gitlab.com/qemu-project/qemu/-/issues/2517
> 
> I got blocked on that because I ran into a weird "I have some
> memory that needs to be freed by the RCU callback, but only
> after the callback has freed some other RCU stuff". I see
> Paolo made a reply on that bug -- I would need to get back
> to it and reproduce whatever it was I was doing.

Thanks for the link, right that looks exactly like what I hit.

I am curious if FIFO is guaranteed for RCU in general, or it is an impl
detail only specific to QEMU.

The other thing is I feel like it should be OK to reorder callbacks, if all
the call_rcu() users can make sure the rcu-freed object is completely
detached from the rest world, e.g. resetting all relevant pointers to NULL.
With that, it seems the order won't matter too, because nobody will be able
to reference the internal object anyway, so the two objects (after reseting
all referers to NULL pointer of the inner object) are completely standalone.

-- 
Peter Xu


