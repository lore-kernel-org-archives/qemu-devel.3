Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36E2E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM94c-0004C3-0O; Fri, 13 Dec 2024 12:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1tM94U-0003y0-9c
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:03:23 -0500
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1tM94P-0002eG-1X
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:03:21 -0500
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d92e457230so19726096d6.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1734109393; x=1734714193; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yvehb7JQ1ylQUiL+dTxjA1ix/u6K7M9c7p63b0T+Dgg=;
 b=eDEL8JlwLWJEJ8ddfCxIezLck7r3VTnqZJY6Bj9bc0vDNaAzs3W52FeWAdM6FlGi9B
 Qql7CoaWH9SLqahnWsg1SfiGQbr/rkg8pXw8CsOSQVqxbjgObF6HJaIqG3CiTIhG5dLc
 sEiqXAPpiijQ2LYG63/8DqcXDeUEDTEcO3+z4LrAgdBmJ2YFNT7QB5ObIO+pWfuuNaR0
 exZ0w/BrqxYppkKo0o127191O5xHfdVgDzSNyIZjya19fKGfHb29txV+UyYUO4kkBTxY
 pgtX/aGfwq+pNom1u2LNfQD9k40HpdjoAF5b1/2/lJSgN1xrtFG2WiECJpV1JpzwRHTM
 LCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734109393; x=1734714193;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yvehb7JQ1ylQUiL+dTxjA1ix/u6K7M9c7p63b0T+Dgg=;
 b=Jamy4GnZrEtZy9tnF1Q2wkNAt+Uyh5FOB5LyOInlMvZ61KGrVKzweMrgfmfJME7HqV
 ButOhPAgfLZ4yooNRQYeFV04j9tshxidUSqLISUlP4kd3OmkvdUyb5Ygxq+AY5iCkZ+z
 iaN/I04r+4SRvGB0hDOMUjkUQKI9IdHrrypvPs81jh0lEvJVIJuOjEqLsAkNuFZqUds6
 B+m8LgW5cAcRXaHZeL60vZt9s4lZOrzDMTIku8ycEAdeWy2dw06JEXs/2f/sqyDYCZ18
 jMywtFqKn5K1BhgR4FP6q/mgMmmaVaMZm0Fe7HuIuDfpimK1zGfJiTie4UXkeJBdboqO
 PgDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1b0/JDglOtY0dC7gRvzsYm17+dof/+uGXUFC04bJIeZiOrqKyyIGabr5kXnrhBCQdWgdtRCBCkWWG@nongnu.org
X-Gm-Message-State: AOJu0Ywobbp7BL0lgWgBYit4L5Q18EdLWAjgddpJTHDY0SepOWJz26a0
 6fCV1YqnM/aQjBL70U2M29sIBZYLwQ9nSZF2YvuAxnSqhCY91MIT0k5rLncNTAk=
X-Gm-Gg: ASbGncuEOnQAV0fsNQjpBRlNZjSm12/3WUrMBhR9wXKcDnUz70feMVVP1Y4igl77Rni
 Qsq15vi4Ah64Q6lFz1anRVmh4xjXh1y06YKhhyidUPCcA774HZYUwqWaO37PPgpPOERd8TDDsma
 OjyJz53yAArxWYX2waWm0aaqlNMUVDU7ZtLMmdeXJf1HzpRdzX93vQQLMRaEbfEeb17bhnc9gVu
 evratvL4v0P17bS2Wp4RCi0jH+dr4/dCwZ7pg8hxlGwroYknb1HDvqEWdnJwYsEWyHQqb8tl1F9
 Zga9BYu0/KwKPXo1wiFxldeVSrAaqqfIHF5CdZ8ugg==
X-Google-Smtp-Source: AGHT+IElG1B0JsUnGJaX3PpOMBAAYk2Z+SJ3uUSInxF8Upb7SrmcY2cGXNlYVjG21ITjK/DdYIdtjw==
X-Received: by 2002:a05:6214:5293:b0:6d8:883c:384e with SMTP id
 6a1803df08f44-6dc8ca53fe5mr60559326d6.16.1734109393082; 
 Fri, 13 Dec 2024 09:03:13 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com
 (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8e65389dcsm85398766d6.36.2024.12.13.09.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:03:12 -0800 (PST)
Date: Fri, 13 Dec 2024 12:03:02 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 svetly.todorov@memverge.com, nifan.cxl@gmail.com
Subject: Re: [PATCH RFC v3 3/3] mhsld: implement MHSLD device
Message-ID: <Z1xoxtKOOmewrgIg@PC2K9PVX.TheFacebook.com>
References: <20241018161252.8896-1-gourry@gourry.net>
 <20241018161252.8896-4-gourry@gourry.net>
 <20241212174016.0000002a@huawei.com>
 <Z1s-4oPjHPFpnnnK@PC2K9PVX.TheFacebook.com>
 <20241213161836.000073d6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213161836.000073d6@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=gourry@gourry.net; helo=mail-qv1-xf33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Dec 13, 2024 at 04:18:36PM +0000, Jonathan Cameron wrote:
> On Thu, 12 Dec 2024 14:52:02 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> I don't think anyone is going to do 2MiB granularity on a real device
> (or at least not for bulk capacity) so the necessary data may not be that large.
> Obviously the cost of updating it will be higher, but meh, that's not that
> common an operation.
> 
> > 
> > >  and we can have
> > > richer info.  Having to chat to each qmp interface independently works fine is
> > > also a bit more complex than I think we would eventually want.
> > >   
> > 
> > This is a small component in someone's fabric manager that translates their
> > requests into QMP commands.  Whatever we ultimately decide on, the complexity
> > here is about the same.
> 
> It's the qmp commands to a bunch of different qemu instances pretending to be one
> Multi Head device.
> Sure we can insert a proxy to act as that one, but then we more or less
> have an external process mediating that.
> 

I'm not against changing this, I just think it's going to increase complexity
for little value.  

I personally like the idea of keeping it the way it is and slapping a small
proxy on top that emulates the "out of band" interface to the device - but
all it does behind the scenes is send out a QMP command (that already exists)
to a guest that registered itself with the proxy.

This separates the complexity of implementing FMAPI functionality and the
complexity of how an individual instance of QEMU go about handling
add/access/remove semantics for DCD events.

The annoying thought experiment here is when someone wants their in-band
host interface to have access to the FMAPI

great now i've made myself grumpy
 
> > 
> > > Having a solution in place though will make it much easier to move towards
> > > an eventual upstreamable solution. This is a great place to start from!
> > > 
> > > Jonathan
> > >   
> > > > +/*
> > > > + * We limit the number of heads to prevent the shared state
> > > > + * region from becoming a major memory hog.  We need 512MB of
> > > > + * memory space to track 8-host ownership of 4GB of memory in
> > > > + * blocks of 2MB.  This can change if the block size is increased.  
> > > 
> > > I'm lost what makes up that size?
> > >   
> > 
> > I think the math is wrong here, we may have calculated based on
> > a larger capacity.  I need to go back and look at how we came to 512MB.
> 4TB maybe?
> 
> Jonathan

Yeah that's probably what it was.  I think that's what I was basing it off of
at the time.

~Gregory

