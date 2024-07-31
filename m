Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A160CC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 21:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZGk4-00077G-W5; Wed, 31 Jul 2024 17:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZGk3-00076j-Aq
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZGjz-00009Y-5M
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722460804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aBR6zYDfiikOpHVZZ6bSKqdhTViuR/dky130Rj60/Qc=;
 b=YW/x1PkaaH+F4SmZtp4so/fmksQ3GCKKfQY3is1mTNjcOQoy+ICvswQtaSvhng2eN215sh
 gqmyEsQyR2yw2/bxEbHKGhdGpatyblmGmWSddmHA3QSHUU20+sSKcLiYX80YsalUQWs3QU
 NXLcE/Le9WyACwWtVcFZdp+nnUzNoTM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-7oe4haIBN0yhQxzuMHxOrw-1; Wed, 31 Jul 2024 17:20:02 -0400
X-MC-Unique: 7oe4haIBN0yhQxzuMHxOrw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3687f4f9fecso4022878f8f.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 14:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722460802; x=1723065602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBR6zYDfiikOpHVZZ6bSKqdhTViuR/dky130Rj60/Qc=;
 b=R8WEYzKnjAUa/786047wIiHDwItQH/GdJo5qOC5dCwfJLt+XbKMIb223wFUi3NEGOB
 D2wzumVfAYf/RldLOh8MqVBbGwIrwtaSSas4YcHSkP86xInoaNJVPYYxPhCgSrzmkPha
 dgrh5l878otngKgwd/AitxcsvW5oLlc85ptKwX9scfWhXDCkCXhS1ymDTxpkqyKLQ6mA
 ai90JpeaeHrlzAReh/wb4vkLHLERJMAbEkj+SgzwaeRfwo2L7I/5mmjjDjBvT4QV4CML
 QFpS48N/rUM8rOBXnFu6SqZ2ISbob+pGMwb0JO1Nadsjboz6UyiEh6QfDOgdHv/29Bhf
 FU8A==
X-Gm-Message-State: AOJu0YxFipRPmIGV+qtNXqYOGSAdh0qyXrYHHRab0pOWVtcOQXbvzWsR
 NJCrb4o3mO3tGSiYsiv7D0curPTFan3CpZB1oaCDQLSDBblJW8rTv6VeHB6s9yxZJ7uKDoEgt1b
 +1TnKdb0LN1uwcEdIhh0QsRkxFGm2Cc7gAraqk3k7YvqGFo0rHU2T
X-Received: by 2002:a5d:548a:0:b0:368:4e35:76f9 with SMTP id
 ffacd0b85a97d-36baaefe4abmr442702f8f.37.1722460801696; 
 Wed, 31 Jul 2024 14:20:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv1+KzI5IeCjMn+hGSlQV/ZR7vKgifl+BFLKezY757mbRXTdlfBNWvzadlBWXqaGFNn79aWw==
X-Received: by 2002:a5d:548a:0:b0:368:4e35:76f9 with SMTP id
 ffacd0b85a97d-36baaefe4abmr442678f8f.37.1722460801021; 
 Wed, 31 Jul 2024 14:20:01 -0700 (PDT)
Received: from redhat.com ([2.55.14.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab2314csm827557566b.14.2024.07.31.14.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 14:20:00 -0700 (PDT)
Date: Wed, 31 Jul 2024 17:19:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
Subject: Re: [PATCH v2] hw/acpi: Add vmclock device
Message-ID: <20240731171843-mutt-send-email-mst@kernel.org>
References: <bc85aba60523e0d63e760d5143c5cb57688779d1.camel@infradead.org>
 <20240730135143-mutt-send-email-mst@kernel.org>
 <546A904C-FEEB-4365-B7AA-CA4E3D03300C@infradead.org>
 <20240730164434-mutt-send-email-mst@kernel.org>
 <9811E311-F599-4B2E-A3C2-5233D6F2D485@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9811E311-F599-4B2E-A3C2-5233D6F2D485@infradead.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 31, 2024 at 01:23:49AM +0100, David Woodhouse wrote:
> On 30 July 2024 21:45:53 BST, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >On Tue, Jul 30, 2024 at 08:04:17PM +0100, David Woodhouse wrote:
> >> On 30 July 2024 18:53:18 BST, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >We don't want to manually sync headers with Linux.
> >> 
> >> Indeed. I was briefly tempted to fake it, but figured it might get lost if we subsequently do run the script to automatically merge from Linux, before the guest driver is merged there.
> >> 
> >> >I think Linux abi should live under uapi. When it is there, we can use
> >> >./scripts/update-linux-headers.sh machinery to import it.
> >> 
> >> This isn't just Linux ABI. It's intended as hypervisor to guest ABI too. In the fullness of time I'm hoping it'll actually be a virtio header. In the meantime, best not to overthink it. It's fine in hw/acpi alongside the device itself for now, I think.
> >
> >This is exactly the same as e.g. virtio. We use Linux as a source of truth, it's
> >easier to share with other hypervisors this way. And UAPI and hypervisor
> >ABI requirements wrt stability are mostly the same. It works.
> 
> Perfect. So as and when the header is in its final form in Linux, it can be part of the automated import and we'll use that version. At that point we can drop the one that's sitting alongside the device itself in hw/acpi/.

Yes. Maybe add a comment in the temporary header.

-- 
MST


