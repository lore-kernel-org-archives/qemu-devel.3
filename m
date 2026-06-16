Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF40CD98CE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 05:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZMB7-0004qI-MK; Tue, 16 Jun 2026 01:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZMB6-0004pz-1K
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 01:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZMB4-0000C3-7m
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 01:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781587052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OCy4Ex5d91LHwkpXBa0T18tL4nURwIRokQbtf4Ze3/c=;
 b=hPZ6pGAbDddUusnlshGgjQG/ymjWCcoGMQrnlEMZ7MUHxDkXAS8lL+X+KR8GEWIbOtMMAS
 IKcz7tpzX4gtwwOKXtMFvfT+JcqbhNbZ7Tt/QqNGRN3CO/IefOBNBHEhtl+xkJhjGISbTk
 Hmyb1GUW0Rilzq9/gifwjRS8eTk9KU8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-OE4bz2MiMEaPYtWwsIM7Sw-1; Tue, 16 Jun 2026 01:17:31 -0400
X-MC-Unique: OE4bz2MiMEaPYtWwsIM7Sw-1
X-Mimecast-MFC-AGG-ID: OE4bz2MiMEaPYtWwsIM7Sw_1781587050
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45ef93c359fso3944348f8f.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 22:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781587050; x=1782191850; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OCy4Ex5d91LHwkpXBa0T18tL4nURwIRokQbtf4Ze3/c=;
 b=Lu/6p8P7UkiJDKq/g2mI3toyHcXPsLmM7Vyq26aBbcBbxZjq4gI1op8CYfIGbFfhfK
 /3oyy88XVQAYQiD0bTngv183hoeoK2OOV2xlghRwHt5Pt5cotsuedlHdMq/SVDdB92mu
 DgWPmEeF/w/O1vrvsTOFSPs3vvKwaqf0+YYqPTDSYrUsAzaDbbXxMLpHPAk8+a2N6D9Z
 sBsb54SR3UKwMhJwIVbaU+k7nGsDCsPBFz7XqsRWnQBRaqu7xxLnB+9pn2L8WXtmqmvR
 FXNNCGjzbEAYT68Yg+C5odHa5IaQT8p5vI+d2/hQ+d389oyuR3+uyfqsukhDK+GSOqXN
 nMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781587050; x=1782191850;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OCy4Ex5d91LHwkpXBa0T18tL4nURwIRokQbtf4Ze3/c=;
 b=jvh6NNOpYKaEvcIdo0HUWIiA4GiQePMrKygUJNJ1nCmaLtR6mpqLqIwYvh7ixkmMhi
 vCBHaCHcSTm0SYDzpeZQ1i1JMgFmzPgUDLhfe+dUWphofckQSaw/ol0l0081dnaExf1L
 XnOojV15TBZPCKqH4h9tEDKYiKKTqKK0aflfsUBFgZeq4WuJ7/5okC+Mg+fS3g/K1CNn
 I2ZrKb+Y1AXCYyJUDP1JJmZtI8zbNkZo0fDGYqtuLaCe5wD6DloKZEyX2SWli+JI9lnr
 sBD1s9EONH43gfqtGluLMv0PpG5fjqfsDLuh0253/xzWqJN6ZgWmZurjkZVfPyNaCbH+
 xYtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GIhw3yGpSiEeOQ1uTvVf76qmduFNmY4ak2f063FD+H2Y1bwlrZi7o0NPZ9VO82Z19803j8Bu4EwSD@nongnu.org
X-Gm-Message-State: AOJu0YyORsKz6eN/TjjPP2DHUtdjye6USs5DF+L17qkhWTP8cd0gpAVM
 +brVazo2/7uwe0Dg1jixKKWfzzqZSOy7l+2uR0Fmh60jdC8kk+olovKINdr50JDLJL+ozS4STif
 UZ8QGT9lP+KMjPrkhShg1iiNS5OmhuBiGHIgMevdzHjcPCDYxQwD60JnB
X-Gm-Gg: Acq92OE4CUvLsaJ4otFrRC41rQF1G2MceXsZQj4VMwKKLrWB7/MmzKBqBL2115h7LmB
 nWBn6J71GG198Lurlni9uvPBFC3NKDxcK5KHIcnAUi778fhQBSiFCemfNXDSXRFvuKQcFyndtHK
 nEl75rpJw0g5WBN9HgK5N3V9oN6xUIfrJ6Uc0WaJuLvtLAHzXsriAaTMVFXwRMI9PPs54VzfxpK
 DmnHD7VPdhQey6wNzlMzKSbrn0x/RIeNA7KB7AcIDm8zYABLIx+54lPldLOb8TzRabidipXONc2
 385XKKfyhhPZY6Xky3O/JW6aolBHsdMj/2e2aGemmgiSQgSIbUFBmdQGBUF190L8Z60WW3XEN9W
 PGDJCwL4PVwiTMHCtirRRhHK8owKxP7jrFjZww0HgRAo=
X-Received: by 2002:a05:6000:25c6:b0:43f:e721:76b8 with SMTP id
 ffacd0b85a97d-4619f3c09f7mr3304266f8f.37.1781587050162; 
 Mon, 15 Jun 2026 22:17:30 -0700 (PDT)
X-Received: by 2002:a05:6000:25c6:b0:43f:e721:76b8 with SMTP id
 ffacd0b85a97d-4619f3c09f7mr3304215f8f.37.1781587049719; 
 Mon, 15 Jun 2026 22:17:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f4f6sm44690970f8f.16.2026.06.15.22.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 22:17:28 -0700 (PDT)
Date: Tue, 16 Jun 2026 01:17:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, alex@shazbot.org,
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <20260616010544-mutt-send-email-mst@kernel.org>
References: <CAFEAcA9CT6E8dhEV7Ek6ruT_o2dKUf==2V+U-1WFDOLtYbgeeQ@mail.gmail.com>
 <20260615105556-mutt-send-email-mst@kernel.org>
 <CAFEAcA9Gi43qNZoZcGtq8ioffGwOc_XuhoFAjGx7-bt4U8qfxw@mail.gmail.com>
 <e399ceb9-bc4a-4ba6-8efd-ed2742d0853b@redhat.com>
 <20260615154054-mutt-send-email-mst@kernel.org>
 <22d55870-b521-4002-add7-791bce8ea96a@redhat.com>
 <20260615224658-mutt-send-email-mst@kernel.org>
 <0038f601-7647-4547-a67a-c6a17fae26ca@linaro.org>
 <20260616004924-mutt-send-email-mst@kernel.org>
 <3880910f-4465-46c5-a5e5-daa2f70821d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3880910f-4465-46c5-a5e5-daa2f70821d1@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 16, 2026 at 02:55:52PM +1000, Gavin Shan wrote:
> On 6/16/26 2:49 PM, Michael S. Tsirkin wrote:
> > On Mon, Jun 15, 2026 at 09:48:00PM -0700, Richard Henderson wrote:
> > > On 6/15/26 21:23, Michael S. Tsirkin wrote:
> > > > B. Also on x86, I do not see why we should not use memcpy for large
> > > > accesses if we can. Better perf.
> > > 
> > > We have an example where memcpy writes to the same location 3 times.
> > > This is not appropriate for any host.
> > > 
> > > 
> > > r~
> > 
> > as in, same byte?  could you share the details pls?
> > 
> 
> This issue happened on aarch64 only.
> 
> https://lore.kernel.org/qemu-devel/CAFEAcA8dwHV8F48kb-013rxkG9kKcZhym9_qarKmoeUfeh0YWw@mail.gmail.com/
> 
> Thanks,
> Gavin

oh wow. thanks for sharing!

Still I think for sizes outside of 2,4,8 it's fine?
That is where the perf is.


-- 
MST


