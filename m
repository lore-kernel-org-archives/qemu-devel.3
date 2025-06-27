Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2C2C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 12:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7nU-0006H1-3S; Fri, 27 Jun 2025 08:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uV7nS-0006Gn-Ok
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uV7nQ-0001hH-Ck
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751025785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1kmEvI0xPnrkqyHVaUh/t64fzTmGa5YyJwBxN5iXSg=;
 b=fnKb6NtG8WLQczpM3kfDXVq8KtFcAo5aciPWfYoYqmJeHCLaBJQoG6bpmqzI1AcbeTiwUL
 c9rmE8UyumMnOvu8AI/CjBPsEDajlB53jxNoNE5xxJa2MgaCwg/d/FODoMesvQvogktxdT
 Nf9sqEjY9isX2seUb1FWuXXbpB0xDAw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-L1esu3h_OB6JTLFUxgbLyg-1; Fri, 27 Jun 2025 08:03:03 -0400
X-MC-Unique: L1esu3h_OB6JTLFUxgbLyg-1
X-Mimecast-MFC-AGG-ID: L1esu3h_OB6JTLFUxgbLyg_1751025782
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4e713e05bso1140688f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 05:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751025782; x=1751630582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W1kmEvI0xPnrkqyHVaUh/t64fzTmGa5YyJwBxN5iXSg=;
 b=l+//j5KQvvgwanakRwq56FJnj6GsXqDH78QPFqOSg7EWA44Dq7PLUvs3eyehgmH+99
 k1EsXpJ5cqZhUv0Ef1CuwkMV8N896/9X3r5NRlByA1Vv9KhAbkgwYmJD01SZjMCcrL/g
 wCj4i4Sl5NMeGxKs1eC+penKHvZNdNHAgEd9EGs8Hhl92ip3HCOflFvnrdhAvEgozToa
 5rCkZcfH73GDsf+SMvpKe30tGzHyRqBDIlSbQEbx2t7IDAKFOa4DzpvhdJAIo54xyM18
 bhh6Sk76To3mdjsZPu7a1OmEdIjbLjv3lxljQclk+gldn08z9pIpgywFORgJN9tfoED+
 UKHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSVoZFcp7YLLNOpo6Ilofwp7U5ZgnU9r7xm3xyz564YCAD9VFBOwTOQkmVT6WZDL/aeMVmyagjAvgA@nongnu.org
X-Gm-Message-State: AOJu0Yx1l7aSOgYu9mPYuMxzCQQJ8Oo43W6dtii0pAqP2OYBDGk92WC5
 C6WOtniUJDfyAB3LPakagQX4SHEeQvIMXXwxtovmm4ugwveOArD3tddZogy7YCqaSzGY5D51bl9
 H9Crsml0qxk+D2NLncTS6v7lbWhesqEPDMKVz6S9KoJ85eufhGsYEg35W
X-Gm-Gg: ASbGncvm6gPg96VBNH5dxy2QL2GOTHUQiuOQUFeHBDK305uxWUlFxBA64gtPl/4J1zB
 OCbigau1gQ+Fla7TO6r0koBAQAl6hojXjK3He7sbG4GHimWb2KS5aSFGEi90sVrsf9dCjO7walj
 RexUK1wrLU0W9c0CFuxxgVZjboXqpkpC7M6MKieG/xg35iDRvjAKJ9LkMfHBaRirFoO3fz9a4RI
 pMnk1mVSpB4hjwxfgbyRMinQY/Rlte2vHssMAStT/1htDB/D2IqBzsGc0BTZUXk15Wl8SLXXjQj
 MyvWnpub7/c3
X-Received: by 2002:a05:6000:2c0b:b0:3a3:7387:3078 with SMTP id
 ffacd0b85a97d-3a8f577fdd1mr2883209f8f.4.1751025782025; 
 Fri, 27 Jun 2025 05:03:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0JccGnhxlBCGWtLrtSumsI6/tM5Vdu3DiE9m4ju0Ybsoxkw3MpwpqvDeoNRtAeJfo6RiSpA==
X-Received: by 2002:a05:6000:2c0b:b0:3a3:7387:3078 with SMTP id
 ffacd0b85a97d-3a8f577fdd1mr2883123f8f.4.1751025781119; 
 Fri, 27 Jun 2025 05:03:01 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f943sm2500731f8f.101.2025.06.27.05.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 05:03:00 -0700 (PDT)
Date: Fri, 27 Jun 2025 14:02:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com,
 anisinha@redhat.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 pbonzini@redhat.com, david@redhat.com, philmd@linaro.org
Subject: Re: [PATCH 1/3] memory: reintroduce BQL-free fine-grained PIO/MMIO
Message-ID: <20250627140259.3f88db17@fedora>
In-Reply-To: <20250624124527.656d567c@fedora>
References: <20250620151418.1166195-1-imammedo@redhat.com>
 <20250620151418.1166195-2-imammedo@redhat.com>
 <aFWR8rM7-4y1R0GG@x1.local> <20250623145146.4462bf59@fedora>
 <aFlYRWc7rRwBGM8S@x1.local>
 <uyuhe6pvmqtkb3ruywgsvwc3hh4hu27c454an4avme6xxfrls4@fwoathup2su4>
 <20250624124527.656d567c@fedora>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 24 Jun 2025 12:45:27 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 24 Jun 2025 09:07:11 +0200
> Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> >   Hi,
> >   
> > > Gerd mentioned this in the relevant bz:
> > > 
> > >         Note: root cause for the initrd issue noted in comment 5 is seabios
> > >         running into problems with ehci -> io errors -> corrupted initrd.
> > >         Sometimes it doesn't boot at all, probably in case the io errors
> > >         happen to hit the kernel not the initrd.
> > > 
> > > This seems to be the last piece of information we have had that is closest
> > > to the root cause.    
> > 
> > seabios used to prefer pmtimer back then for timekeeping then because it
> > has a fixed frequency.  Doing tsc calibration can easily be /way/ off in
> > a virtual machine on a loaded host.
> > 
> > Meanwhile seabios got support for reading the tsc frequency via cpuid
> > (if invtsc is available) or via kvmclock.  If that works seabios will
> > prefer the tsc for timekeeping.
> > 
> > So, when trying to reproduce the failure for analysis you have to either
> > use an old seabios version, or turn off kvmclock + invtsc support,
> > otherwise seabios will not use the pmtimer in the first place.  
> 
> thanks for the hint (I've been trying to reproduce with current seabios),
> I'll try to reproduce with the old seabios.

not exactly the same config but close 

qemu at offending commit 1beb99f787ba11 + exactly the same SeaBIOS
with guest GA RHEL7.3 (3.10.0-514.el7.x86_64) and making sure
seabios used pmtimer.

Running RHBZ 1322713 reproducer over several days in loop,
haven't been able to reproduce the issue.

Differences are: RHEL9 host and for guest a bit newer kernel.
the reproducer used a bit older (intermediate) one that is nowhere
to be found anymore.

As you've said in comment
https://bugzilla.redhat.com/show_bug.cgi?id=1322713#c6
it's strange that patch causes issues at all, especially with
'-smp 1' as in reproducer.

Also repeated with -smp x>1, it still worked fine.

Perhaps issue was elsewhere after all.

> 
> > 
> > You should have this line in the firmware log:
> > 
> >     Using pmtimer, ioport 0x608
> > 
> > HTH & take care,
> >   Gerd
> >   
> 


