Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460C7C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVnle-0004QC-Vm; Mon, 22 Jul 2024 03:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVnle-0004PH-2v
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVnlc-0006XR-AZ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721634451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o5iR0cS7R4+gqm4ZjoYrQK5YsFCZZv0fnfPzkifdk4M=;
 b=Gx7Kky+oKBUi0hRZaLoiuRVO3TYTJumE8SQ1Lb5KkV6CyNKwP4R0ktGuBI4IC7nZKrvY8S
 9/BW+8ioUgJGyul1v9dR8I29S22YihA1QwkanpZEOHqdAH2k6PR5Gnb6W79bpZX9uSpOwv
 v/V4wQaooMn8xajyxd8FXEq2+rT+YHk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-go-Z2009Na6Dfx70w0QLng-1; Mon, 22 Jul 2024 03:47:26 -0400
X-MC-Unique: go-Z2009Na6Dfx70w0QLng-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4266fbae4c6so30042925e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 00:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721634445; x=1722239245;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o5iR0cS7R4+gqm4ZjoYrQK5YsFCZZv0fnfPzkifdk4M=;
 b=dZ8hUSOp0BuLIS07IUT90KBS76wEYzmPHanYul4VoV3ix5R0+j40ZVYAlPpkWLRO8t
 UKSyYVdjWHGblZSdUfuWLSlwvirGsGHRLxPgyW9yGqk6+GAVnUMaBfTPdeBPjgauR4Ge
 r2LSybMtZi8dPw4ai2285KXCSJ70TFdhXT7eljSv1ympTovhgjT1q9WVzaGE4Iu+wgPJ
 MrVuVp7nVqvPQT54ABg66ZZ00aLyt/rjuhn1kRTUb11x++QOwKURt9i3K5fYTbPBweYq
 ojg4PJoRFAmnhEljP10uiqfaFKY1s76QXEIkI5wuIVaYY/Hn0UqqPYylT0bqSzyyL/Nj
 eMCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRWgl9gBy5VGfKUUWfEACZlFYIn2SnjMQ1IlBBk96YrlL7muO+0y3py2PrKr+ze2BIAIihKgDxoReWAVBb+KRgmtN9GGw=
X-Gm-Message-State: AOJu0YwppBFWJN59X1t5uoMh7se/kGgJ80Z8szNntyWBa9xezqLgYE6V
 kPtqgbAqJNJD1l+h4xZ5MlEj3NE9XpVfnDRqeB/2swofSHAdjFasUv6axc+ZfZE/XNC1PEKujJl
 cX9UvYvJv98gkrhynuMaP1mYp1az6Ef4qg2OLNkiBOvsDYx4peeX8
X-Received: by 2002:a05:600c:45c8:b0:426:5fe1:ec7a with SMTP id
 5b1f17b1804b1-427dc558a50mr37337045e9.31.1721634445261; 
 Mon, 22 Jul 2024 00:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU+nGRqJ9nedRxjvN0vzUwJ56c0/p6O43XPqR9J+A+u3FAKKJuDhft7INlUdHnPHkpB1eklQ==
X-Received: by 2002:a05:600c:45c8:b0:426:5fe1:ec7a with SMTP id
 5b1f17b1804b1-427dc558a50mr37336815e9.31.1721634444619; 
 Mon, 22 Jul 2024 00:47:24 -0700 (PDT)
Received: from redhat.com (mob-5-90-115-88.net.vodafone.it. [5.90.115.88])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a5c356sm143262975e9.18.2024.07.22.00.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 00:47:24 -0700 (PDT)
Date: Mon, 22 Jul 2024 03:47:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH] tests: increase timeout per instance of bios-tables-test
Message-ID: <20240722034713-mutt-send-email-mst@kernel.org>
References: <20240716125930.620861-1-imammedo@redhat.com>
 <b538c18f-1b95-45b3-9aba-d1d92491c750@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b538c18f-1b95-45b3-9aba-d1d92491c750@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 22, 2024 at 09:35:17AM +0200, Thomas Huth wrote:
> On 16/07/2024 14.59, Igor Mammedov wrote:
> > CI often fails 'cross-i686-tci' job due to runner slowness
> > Log shows that test almost complete, with a few remaining
> > when bios-tables-test timeout hits:
> > 
> >    19/270 qemu:qtest+qtest-aarch64 / qtest-aarch64/bios-tables-test
> >      TIMEOUT        610.02s   killed by signal 15 SIGTERM
> >    ...
> >    stderr:
> >    TAP parsing error: Too few tests run (expected 8, got 7)
> > 
> > At the same time overall job running time is only ~30 out of 1hr allowed.
> > 
> > Increase bios-tables-test instance timeout on 5min as a fix
> > for slow CI runners.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >   tests/qtest/meson.build | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Since we're entering the freeze period this week, I'm going to pick up this
> patch for my next pull request in the hope that it will help to get this job
> green again during the freeze period. But in the long run, it would be
> really good if someone familiar with the bios-tables-test could analyze why
> the run time increased so much in recent times for this test and provide a
> better fix for the problem.
> 
>  Thanks,
>   Thomas
> 

OK.
Acked-by: Michael S. Tsirkin <mst@redhat.com>



