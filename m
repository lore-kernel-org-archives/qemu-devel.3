Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AC5C2BA18
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 13:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJCd3-0007FD-CZ; Mon, 17 Jun 2024 09:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJCcy-0007Ed-AH
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 09:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJCcw-0004Jj-MX
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 09:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718631749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h0f1TYlgIb71SrpXI6DmM2kIQHh7UwJU1Zr0aQJQuTY=;
 b=eT0RX1K2JeN0ztt30t1dpAW8ks8xXuNvB+7c3Gatp0QGbJZJSpPXs6P7WER+pk+Q3Pr0qf
 c1isFaGJKwX8Cs5pkAjub4mu6RcK9/NaLSEsma0/0lBxeh/TU1P5lOUvVCHKP3EUI49CkN
 m2SvLRqX87bl9Y4aoQtOM/mbEHNFkmU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-gHIvcjRzOQSlA9lydwusJg-1; Mon, 17 Jun 2024 09:42:27 -0400
X-MC-Unique: gHIvcjRzOQSlA9lydwusJg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-421739476b3so38262085e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 06:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718631746; x=1719236546;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h0f1TYlgIb71SrpXI6DmM2kIQHh7UwJU1Zr0aQJQuTY=;
 b=czZMUiCRGlSTPYMhp6FuNi7mbi0B/bMWNBqGplMeF+IL0n77KZGo6L/uMabxavFpH8
 ejg//GSQTYCwsvbpjpvV6SZUxoUiUi51RMCVbgnMiJP0bLBGrf2Jl7W3kbtns5BCG2xU
 fuBj8AemlNKWWcquLL1nBkZe+jEtvT2a9xkPy5pnI2LljLUXc46aki8zeHVybiDqyTH/
 78QedwEbATFQfO0hkwtV/EeqPj0pyDdHETqrsLg+GDwJr/ZiDLzFY77IUWiCmN5cQChw
 Yj2kQSJfHuiyiIqTPUTPxasd/tsfSPfEqnR/RhqQvyJDOOKqxfWoYLS0q3IHBsfYqWW3
 cmyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVKQcxfYlK0yfpcptgbnzurPGRksfqePY2Dk82bAiBSFdP7xFfT7VcCJry7ULlh5sI8xukIuSLwRpDtIYOSPopBcO3smQ=
X-Gm-Message-State: AOJu0YyvvqhinUiBt1ctJo0nCoRbkwwHFhLeT+x7tmBuC7IwSAqEqknb
 Y9D8PkJJ4NaQ0Bw9TFNDlZOpPLaTdyeg4VN6sHFFBUAOg18rstn0Hj18vAALtXZ8Fa9t22lrXyX
 BCkakMzoyljwnPJyNd/CCzWTaY+z9n3rAggXfM0Z+egyIUqKFEcOA
X-Received: by 2002:a05:600c:4f49:b0:422:6755:17de with SMTP id
 5b1f17b1804b1-4230485678cmr88979205e9.41.1718631746037; 
 Mon, 17 Jun 2024 06:42:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPMTkD5pZDRYWqS6why5LfjkEvUHZrpz3QyzcTR1NJxTJZYmmJvaJmOaM4LN361QozWrWdEQ==
X-Received: by 2002:a05:600c:4f49:b0:422:6755:17de with SMTP id
 5b1f17b1804b1-4230485678cmr88978745e9.41.1718631745460; 
 Mon, 17 Jun 2024 06:42:25 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7439:b500:58cc:2220:93ce:7c4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286eef970sm194556365e9.10.2024.06.17.06.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 06:42:24 -0700 (PDT)
Date: Mon, 17 Jun 2024 09:42:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Brad Smith <brad@comstyle.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, gmaglione@redhat.com,
 stefanha@redhat.com, Coiby Xu <Coiby.Xu@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 Igor Mammedov <imammedo@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RESEND v7 00/12] vhost-user: support any POSIX system
 (tested on macOS, FreeBSD, OpenBSD)
Message-ID: <20240617094203-mutt-send-email-mst@kernel.org>
References: <20240612130140.63004-1-sgarzare@redhat.com>
 <rx5hvcffqzmixgmlroko7t6qvjciifr77nvpwrakpl5oovw3ec@mihi4k5nhse6>
 <87iky7eq09.fsf@pond.sub.org>
 <ngknr5yzaqso2aaw3baxq5sa4syo36igyk63lcvymjbtu3eqos@aolclgpjy2cy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ngknr5yzaqso2aaw3baxq5sa4syo36igyk63lcvymjbtu3eqos@aolclgpjy2cy>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jun 17, 2024 at 02:59:14PM +0200, Stefano Garzarella wrote:
> On Mon, Jun 17, 2024 at 02:02:30PM GMT, Markus Armbruster wrote:
> > Stefano Garzarella <sgarzare@redhat.com> writes:
> > 
> > > Hi Michael,
> > > 
> > > On Wed, Jun 12, 2024 at 03:01:28PM GMT, Stefano Garzarella wrote:
> > > > This series should be in a good shape, in which tree should we queue it?
> > > > @Micheal would your tree be okay?
> > > 
> > > Markus suggested a small change to patch 10, so do you want me to resend the whole series, or is it okay to resend just the last 3 patches (which are also the ones that depend on the other patch queued by Markus)?
> > 
> > I guess you mean
> > 
> >    [PATCH v2] qapi: clarify that the default is backend dependent
> >    Message-ID: <20240611130231.83152-1-sgarzare@redhat.com>
> 
> Yep!
> 
> > 
> > > In the last case I would ask you to queue up the first 9 patches of this series if that is okay with you.
> > 
> > Michael, feel free to merge the patch I queued.
> > 
> 
> I can also include it in v8 if it helps.
> 
> Thanks,
> Stefano


If I'm to merge it, pls do.
Much less error prone.

-- 
MST


