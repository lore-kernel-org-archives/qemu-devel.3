Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FDBC3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 13:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXKd5-000858-3L; Fri, 26 Jul 2024 09:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sXKd1-00083e-EZ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sXKcx-0001tE-Iz
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721999094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B3g6QURrGZPYRxDC3Hx/i8519mXf108ro6Hrgt5KPqY=;
 b=EmChLHwfoONrkMs5U16kHjurtwl4i/KjXcyad38QXuPOTykcDvCU+m+lPRXTLzYBl5fTin
 fla/JaEOSXtA5DevxK/I7oP+gPWDqisRoq8LAc/WeRi8lC0Fp9sUZ8X9xiBYZVPdEoom9p
 C2aUaWWPjMmrudVCj4vyf8GFUsA4ABY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-_SjiEMhVPkOi094V3KPfxA-1; Fri, 26 Jul 2024 09:04:48 -0400
X-MC-Unique: _SjiEMhVPkOi094V3KPfxA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36835f6ebdcso1543702f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 06:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721999087; x=1722603887;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3g6QURrGZPYRxDC3Hx/i8519mXf108ro6Hrgt5KPqY=;
 b=ZYI9Yh48uo8V9NH6dDJhYrnawFjh01VpeUy4FwOzH8fSle4kjFCfePSPQtDS7UC2Mz
 6PGX/OvRg04nZpj6ZPcBpwXtwZ2f5A1FmwQAwS/pbWejxsXypixQRaZr33YRfr0k4WZn
 ej9ljsvO/sS+MPV4bzKvLS8IQ+3WIkxC2O2Iak2utqjBm+MotMrYR/YV2P1oQXLK+bCO
 YXlbxGeoV88RVSwMRvTPEItv3jPt5cKiRquyI1tUTpfP/R2XAkza0kvgIxmhfsHPy6YO
 nSuReXWWF9zKLwk21yBqVYUzH6WZI4wUs7R7JYBqo0x+1AsLKtmlWqZlrrELir2X+LwB
 G5Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwyVvpzV6VprLcvspJ2Mo427ll/dH5bendBMvKaOJk0TrAqYuQC0XvWAZCYVyBtG6gKI0gMaahuSPXGV0pzWh2ZfcQP1A=
X-Gm-Message-State: AOJu0YzcP9LYCp9uGlKGxURVBDrwyGchV7wes2Uf4/8Ki0ZShBNfVZRo
 s5jAu5YG9H9aZihxuLOMFsXPMKzUmKBnVWSykZ0mWEYs9sAbqpbu/xHHzyj+LCV0OrA4O4kXaly
 DNEMwNtweRCIGne75n0fMndnbZdHx5sFAcv6pXqB3cOX13uEbLjXO
X-Received: by 2002:adf:f40e:0:b0:368:4ed7:2acc with SMTP id
 ffacd0b85a97d-36b3638148cmr3751289f8f.5.1721999087365; 
 Fri, 26 Jul 2024 06:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2baiiVUKUBh/QT4ya/E9LOG3bE0mPK5t7EPOeVJPpQaN0mCePZ4SEB2ju0LD0SShA7ME5CA==
X-Received: by 2002:adf:f40e:0:b0:368:4ed7:2acc with SMTP id
 ffacd0b85a97d-36b3638148cmr3751249f8f.5.1721999086564; 
 Fri, 26 Jul 2024 06:04:46 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36801828sm5090963f8f.65.2024.07.26.06.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 06:04:46 -0700 (PDT)
Date: Fri, 26 Jul 2024 09:04:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 "Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
 "Luu, Ryan" <rluu@amazon.com>, "Chashper, David" <chashper@amazon.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 "Christopher S . Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] ptp: Add vDSO-style vmclock support
Message-ID: <20240726090326-mutt-send-email-mst@kernel.org>
References: <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
 <20240725174327-mutt-send-email-mst@kernel.org>
 <9261e393083bcd151a017a5af3345a1364b3e0f3.camel@infradead.org>
 <20240726015613-mutt-send-email-mst@kernel.org>
 <2e427b102d8fd899a9a3db2ec17a628beb24bc01.camel@infradead.org>
 <20240726084836-mutt-send-email-mst@kernel.org>
 <c115fa23a5e297284c14c1f7118ffcc3c9831097.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c115fa23a5e297284c14c1f7118ffcc3c9831097.camel@infradead.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Fri, Jul 26, 2024 at 02:00:25PM +0100, David Woodhouse wrote:
> On Fri, 2024-07-26 at 08:52 -0400, Michael S. Tsirkin wrote:
> > On Fri, Jul 26, 2024 at 09:35:51AM +0100, David Woodhouse wrote:
> > > But for this use case, we only need a memory region that the hypervisor
> > > can update. We don't need any of that complexity of gratuitously
> > > interrupting all the vCPUs just to ensure that none of them can be
> > > running userspace while one of them does an update for itself,
> > > potentially translating from one ABI to another. The hypervisor can
> > > just update the user-visible memory in place.
> > 
> > Looks like then your userspace is hypervisor specific, and that's a
> > problem because it's a one way street - there is no way for hypervisor
> > to know what does userspace need, so no way for hypervisor to know which
> > information to provide. No real way to fix bugs.
> 
> It's not hypervisor specific, but you're right that as it stands there
> is no negotiation of what userspace wants. So the hypervisor provides
> what it feels it can provide without significant overhead (which may or
> may not include the precise timekeeping, as discussed, but should
> always include the disruption signal which is the most important
> thing).
> 
> The guest *does* know what the hypervisor provides. And when we get to
> do this in virtio, we get all the goodness of negotiation as well. The
> existence of the simple ACPI model doesn't hurt that at all.

Maybe it doesn't, at that. E.g. virtio does a copy, acpi doesn't?
I'll ponder compatibility over the weekend.

-- 
MST


