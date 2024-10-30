Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F559D5CCA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 13:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t68KH-00058I-PM; Wed, 30 Oct 2024 09:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t68K2-00056y-Ft
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 09:01:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t68Jy-0007l2-Um
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 09:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730293269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=coqfGM19ZWbbZSOuCAcMFyOv551LKHGjkbE5giPSlsE=;
 b=WbrQH6dW7/2wRIa0AUTciVsmOiiQ1y4+pZ/1fyTXi5nXs4co0J4n9BJXc87QmYVYI+vGK/
 r7U/Mv+KXtjb+Qj2JH6qG14jI1sdtwZOfu7kpSBYHTzCzJr3bbyTYClhNLIi3hYSSsQLoR
 jCK8hQ7Jwe+hbYBDO8FLLfGT0+XIeVU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-NdQ4CoHMNii0k57Tv_R2eA-1; Wed, 30 Oct 2024 09:01:08 -0400
X-MC-Unique: NdQ4CoHMNii0k57Tv_R2eA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cbd2cb2f78so23785686d6.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 06:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730293267; x=1730898067;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=coqfGM19ZWbbZSOuCAcMFyOv551LKHGjkbE5giPSlsE=;
 b=mAq4L4HwT2mqJNW8dnGjdiVplZ4HTjQ0SqS1oF6VobekqGx6TKHgsR+HloZS4wUA6E
 9XB5sEkqcwPIvW9w2qQVpxtaSmjhnFTJqGMWGYugNgXz3TVAdH7q2e83WupkSlnljidY
 cb8M2PcaVIWrbNJAzwjrcNjoqdRorAa5vZm/W/itk09XxgCk4dFnxUL44k1h/A3vDV38
 rnT3DltkoQpzL2/RI8qLMRM+1tCwrtOAyduxUPVDCNb19Pz9ZvXyfpwrVlVmrL2ud9W6
 al8yVshfFFdxi900m+Cr57eu3mcIFid35PpPSYBY6g/RStygHi7Ccnaf/ZS2dqnrChnj
 7Mpg==
X-Gm-Message-State: AOJu0YxtfaM0n5RCSH+JstD/f1E2i3uedwUQIzr1FcNDjv/uZykB8TH1
 C+6+83WqO1QKfxWvr7vr/S+GOcPw/4OpQSo+MuKw0G7prOSxPimZu33XPTQL2hkSC0wCuout8sm
 GH9cXaxCLEJ4SmuZjAFzbmWxIWWMArHBPf6PV9PiIZa+C2BTvfAVd
X-Received: by 2002:a05:6214:5783:b0:6cd:efb4:2efe with SMTP id
 6a1803df08f44-6d2f63df3e1mr116039196d6.24.1730293267099; 
 Wed, 30 Oct 2024 06:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ2br3ngK95STzUhoMJ4PvsoNZY2KhljRbvWOsvMzXdVzWBVELk1eUQaQwSzYAwf2xH1uSjA==
X-Received: by 2002:a05:6214:5783:b0:6cd:efb4:2efe with SMTP id
 6a1803df08f44-6d2f63df3e1mr116036516d6.24.1730293265222; 
 Wed, 30 Oct 2024 06:01:05 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d179a2c999sm51051516d6.106.2024.10.30.06.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 06:01:04 -0700 (PDT)
Date: Wed, 30 Oct 2024 09:01:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC v2 5/7] x86/iommu: Make x86-iommu a singleton object
Message-ID: <ZyIuD-SQA0Q2Sr7L@x1n>
References: <20241029211607.2114845-1-peterx@redhat.com>
 <20241029211607.2114845-6-peterx@redhat.com>
 <ZyILcz3XnwK0nRI8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyILcz3XnwK0nRI8@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 30, 2024 at 10:33:23AM +0000, Daniel P. Berrangé wrote:
> On Tue, Oct 29, 2024 at 05:16:05PM -0400, Peter Xu wrote:
> > X86 IOMMUs cannot be created more than one on a system yet.  Make it a
> > singleton so it guards the system from accidentally create yet another
> > IOMMU object when one already presents.
> > 
> > Now if someone tries to create more than one, e.g., via:
> > 
> >   ./qemu -M q35 -device intel-iommu -device intel-iommu
> > 
> > The error will change from:
> > 
> >   qemu-system-x86_64: -device intel-iommu: QEMU does not support multiple vIOMMUs for x86 yet.
> > 
> > To:
> > 
> >   qemu-system-x86_64: -device intel-iommu: Class 'intel-iommu' only supports one instance
> > 
> > Unfortunately, yet we can't remove the singleton check in the machine
> > hook (pc_machine_device_pre_plug_cb), because there can also be
> > virtio-iommu involved, which doesn't share a common parent class yet.
> > 
> > But with this, it should be closer to reach that goal to check singleton by
> > QOM one day.
> 
> Looking at the other iommu impls, I noticed that they all have something
> in common, in that they call pci_setup_iommu from their realize()
> function to register their set of callback functions.
> 
> This pci_setup_iommu can happily be called multiple times and just
> over-writes previously registered callbacks. I wonder if this is a better
> place to diagnose incorrect usage of multiple impls. If pci_setup_iommu
> raised an error, it wouldn't matter that virtio-iommu doesn't share
> a common parent with intel-iommu. This would also perhaps be better for
> a future heterogeneous machine types, where it might be valid to have
> multiple iommus concurrently. Checking at the resource setup/registration
> point reflects where the physical constraint comes from.

There can still be side effects that vIOMMU code, at least so far, consider
it the only object even during init/realize.  E.g. vtd_decide_config() has
kvm_enable_x2apic() calls which we definitely don't want to be triggered
during machine running.  The pci_setup_iommu() idea could work indeed but
it might still need cleanups here and there all over the places.

In general, I was trying to have this as a show case, so in this case it's
indeed not required.  But I wonder whether other devices / objects can also
benefit from it, knowing some of them can only have one instance.  I used
to believe it could be pretty common in QEMU, but maybe I'm wrong.  If
there's none of such elsewhere, then I agree the singleton idea may not be
that helpful.

Thanks,

-- 
Peter Xu


