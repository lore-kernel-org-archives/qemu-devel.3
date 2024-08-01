Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DBAC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 09:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZSQq-0005Lz-7z; Thu, 01 Aug 2024 05:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZSQo-0005GB-M0
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 05:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZSQn-0003k8-6j
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 05:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722505747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Una+J1YOyhvw6DC8uipGmAmwlKmpG88KmXyoeBw5YGc=;
 b=hwBKgvlJujTaFcrDnT1E0r30162r60qyPvQ6KI3JKHSTIQSYehXHbwnEdKvyn9TANAgNck
 9EK9EPAuP+A8Jwo2T+XIidE3JRFBzBbTeBVEb7FqYWYKJSJFGQ+u8WCKEs7I/yJH3Xs8RA
 OYxHorWkC2VfljggmWEXv+15FeH0oIo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-I1KWGxU2M02s_VkUELA4TQ-1; Thu, 01 Aug 2024 05:49:06 -0400
X-MC-Unique: I1KWGxU2M02s_VkUELA4TQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5a7661b251aso6901739a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 02:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722505745; x=1723110545;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Una+J1YOyhvw6DC8uipGmAmwlKmpG88KmXyoeBw5YGc=;
 b=WZSMcfRtQR/wPyTapya8NL0BQ/aVKi+m/ASFh5swk+ToSKYPZ4W/msEHVLeAhY9zKu
 mHacmz+WhrZpPXEHd3Xl7514yd8LKailZ7so0W7dxWGcAyJgecB4pGAJm1xsVHX5XZE4
 0n6e4vh9wwy0yNBUO6jq8ym9490idQ7tWhJADlvM7uD83Impl/Hg46NoWwS0E6Kd/QA8
 2kdWLhKx7h4rSQJYKTEgoBS9LfngsBkUA7M/+6peAq/hhEP0/EaEo/H4jPhh17FPxfQt
 R4FkzMIcGPbh6cZUOtMDjmqJGidGeOgZtu7DTawq7d234wdVct8u8SKzTDyOBLef0+KV
 lslA==
X-Gm-Message-State: AOJu0Yz1jlQUmNqBdtj/HRVXbh8eH793crtkIRqeY/3Jf1q+Rgwdufg/
 vJfHMjIMRKZys14XuyoIeFrSrTd1cRyQwgarwCH0o8ndMP7HV9nigZj8/WyYC41+oQL9sKpIp+S
 wZ+ml1xgSaq84NlorHPyzoXVtI9/ivhjp2KZ/oWwvabWs+cMl2406
X-Received: by 2002:a17:907:9490:b0:a77:a630:cf89 with SMTP id
 a640c23a62f3a-a7daf135a59mr132780766b.0.1722505744729; 
 Thu, 01 Aug 2024 02:49:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGord70hP1xhrH85XY0PLMdSDq2n7HXSk6cbX+2nHe9ug94c4ahdySiB8tL5ojAdkUzdt8iJA==
X-Received: by 2002:a17:907:9490:b0:a77:a630:cf89 with SMTP id
 a640c23a62f3a-a7daf135a59mr132777466b.0.1722505744055; 
 Thu, 01 Aug 2024 02:49:04 -0700 (PDT)
Received: from redhat.com ([2.55.14.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad903f1sm876832866b.152.2024.08.01.02.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 02:49:03 -0700 (PDT)
Date: Thu, 1 Aug 2024 05:48:58 -0400
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
Message-ID: <20240801054718-mutt-send-email-mst@kernel.org>
References: <bc85aba60523e0d63e760d5143c5cb57688779d1.camel@infradead.org>
 <20240730135143-mutt-send-email-mst@kernel.org>
 <546A904C-FEEB-4365-B7AA-CA4E3D03300C@infradead.org>
 <20240730164434-mutt-send-email-mst@kernel.org>
 <9811E311-F599-4B2E-A3C2-5233D6F2D485@infradead.org>
 <20240731171843-mutt-send-email-mst@kernel.org>
 <a432792506935843c0d5c4323ea70ef8df1dbefd.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a432792506935843c0d5c4323ea70ef8df1dbefd.camel@infradead.org>
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

On Thu, Aug 01, 2024 at 09:49:06AM +0100, David Woodhouse wrote:
> On Wed, 2024-07-31 at 17:19 -0400, Michael S. Tsirkin wrote:
> > 
> > > Perfect. So as and when the header is in its final form in Linux,
> > > it can be part of the automated import and we'll use that version.
> > > At that point we can drop the one that's sitting alongside the
> > > device itself in hw/acpi/.
> > 
> > Yes. Maybe add a comment in the temporary header.
> 
> I pondered that, but kind of preferred to have it byte-identical.
> 
> Admittedly I'm not *planning* to have to change it any more but it's
> been useful so far that I can just *copy* the file between the Linux
> and Linux-backport and QEMU repositories.

ok. note machinery we have is clever, it handles __le and such stuff
automatically.

-- 
MST


