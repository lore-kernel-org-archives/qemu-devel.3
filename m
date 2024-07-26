Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDA0C3DA63
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 05:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXDCy-0003zg-Rl; Fri, 26 Jul 2024 01:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sXDCw-0003zA-Q9
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sXDCu-00064H-Hl
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721970569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DbuOgyAkRILEBrf9MJ+4blSFephMiZi+pxSKWGG3nSg=;
 b=THp7EWZiUx6RPlTgiC7TC+02+nQJkQ674YKs/wMVEcb0CNs9Sq4V3x4mQNrpKEm/bbjF0K
 BbZ7PRViOf7okRUEjMA2Lm749wpFrczBoLFJQhQIe9jleDATCQXOlZNbmHVDOujbcvlpNF
 PqoSHnKJRASHiWDJR7C6Lws/m6Oa7oA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-CK_t25wEMguX0lGDWNy64Q-1; Fri, 26 Jul 2024 01:09:25 -0400
X-MC-Unique: CK_t25wEMguX0lGDWNy64Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4280645e3e0so10769735e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 22:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721970564; x=1722575364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DbuOgyAkRILEBrf9MJ+4blSFephMiZi+pxSKWGG3nSg=;
 b=QJ3J3suiYcIcMn6ZWB3hW2FVbU8ImFm+miynTgkNuCwKrN5V8XCVSHlq/lj4jm67Gi
 8w2Yj0Ad0jkwAotnaiZg3Jx2AloAdvFsaTp0VmBvbOz4Pa3NNC03b5b6lsIpJZhJ3DUI
 cS+NoKuDYX3EcczJoiUBMmhKCGg5L36zVfkyZWkTATHlliAmCa/+bB6UxIJ+2jj3dYLz
 0nds0fak5AOxM5voWokzJpSthk6kX4hOrrLH2u3N8LL47EYPrEX20ragcstzwhaiNG0q
 felVx5MMu8/DHfzKGqkXCeRUFH6HKDQ3tEX+/Y6fumyEU9w5t31K68lncmxW18tIPiTG
 NckQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmEVMh3iIh3Q7LS1egXNo8jydB/rfxSxUq8n2gezwnDw1r11wexlVyAVjHfY1LbAnnKWqlNsqylhkvZiTg081bpzdClH0=
X-Gm-Message-State: AOJu0Yy3pm+QY58xpghyeEXp1Xg6VHBriwhsv22W8pzXJ5agkxjnOLth
 J5bgaXjd4wgSFZOuOjdiRqPFPvKYlCTDedHGTXf8zk50qyt604F65NfvgLjqZJGULSeg59cw0cX
 AvtlOmrrsQPoD/WexOuCs4lF4WGyqGtaG9HSs8jnjW6aQgGQhYUe7
X-Received: by 2002:a05:600c:1c1f:b0:426:6153:5318 with SMTP id
 5b1f17b1804b1-4280570fe50mr29400795e9.19.1721970564593; 
 Thu, 25 Jul 2024 22:09:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLGThAmioKqXVYW1bGCeFOTJCJYjUraPBu1ns0STXkcb4YEMtbOBAAif1jc1w6fYVZOAbSOQ==
X-Received: by 2002:a05:600c:1c1f:b0:426:6153:5318 with SMTP id
 5b1f17b1804b1-4280570fe50mr29400405e9.19.1721970563829; 
 Thu, 25 Jul 2024 22:09:23 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f93e6871sm105269105e9.30.2024.07.25.22.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 22:09:23 -0700 (PDT)
Date: Fri, 26 Jul 2024 01:09:13 -0400
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
Message-ID: <20240726010511-mutt-send-email-mst@kernel.org>
References: <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240725100351-mutt-send-email-mst@kernel.org>
 <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
 <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
 <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Thu, Jul 25, 2024 at 10:29:18PM +0100, David Woodhouse wrote:
> > > > Then can't we fix it by interrupting all CPUs right after LM?
> > > > 
> > > > To me that seems like a cleaner approach - we then compartmentalize
> > > > the ABI issue - kernel has its own ABI against userspace,
> > > > devices have their own ABI against kernel.
> > > > It'd mean we need a way to detect that interrupt was sent,
> > > > maybe yet another counter inside that structure.
> > > > 
> > > > WDYT?
> > > > 
> > > > By the way the same idea would work for snapshots -
> > > > some people wanted to expose that info to userspace, too.
> 
> Those people included me. I wanted to interrupt all the vCPUs, even the
> ones which were in userspace at the moment of migration, and have the
> kernel deal with passing it on to userspace via a different ABI.
> 
> It ends up being complex and intricate, and requiring a lot of new
> kernel and userspace support. I gave up on it in the end for snapshots,
> and didn't go there again for this.

Maybe become you insist on using ACPI?
I see a fairly simple way to do it. For example, with virtio:

one vq per CPU, with a single outstanding buffer,
callback copies from the buffer into the userspace
visible memory.

Want me to show you the code?

-- 
MST


