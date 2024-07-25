Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B998C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 12:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWxez-0005nV-Rv; Thu, 25 Jul 2024 08:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWxew-0005mn-M8
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 08:33:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWxet-0000uC-I1
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 08:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721910802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MtA7yhRfm5XfOtod2ZhYC2Xuv723Fg+huPBrtR9uGkE=;
 b=M5mdT9StJs4UtZzRstWJiAu3ffcrGx5y4oJ4t6Ig64d7jCRSbG1qqOPJQYOxW570nCjd1y
 n8yO9YkZ13R+dnlZzI/uCU7CaA6SLVnGl1M/YmBLoerBEnD/hmZmm/3fR3YnlvvIzqY9dt
 B1Z92nCp9zy5EHmIl6Cd6vetkiLCsoM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-JbdsWDMgMsS24NQ1nS2HWw-1; Thu, 25 Jul 2024 08:33:20 -0400
X-MC-Unique: JbdsWDMgMsS24NQ1nS2HWw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36875698d0dso567463f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 05:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721910799; x=1722515599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MtA7yhRfm5XfOtod2ZhYC2Xuv723Fg+huPBrtR9uGkE=;
 b=aocMlXu9QIJ+/fU6p5SlkR1ks8TiPNwJNMKUY+zu3sk5Byol6DVGCNLV2pGSBhVafo
 uYhauk4TdTw4HwxG3SY+cbs4nopIdyIGzu7rMBLwTMOOLEb0jn8TTIn2bEburivYuOEJ
 4fKdV2T3grVwrSHH81z3YJzFCzqqBDk8OgC+hRbR22i2e1XYJ5HvNXA0JgmbB8+G/SOD
 1p0UQOEMaZ2/TJITvHWAggCbzIH44u3CjiknDhlaO/XB1QjPOw6XdonAlCUpC4U4TF26
 VMq+nNI9mFdG8SwAUkHo4OHGQGexhvHOG2lGlA9i1etQIZysMiLq4R2gKeuyZHIKl8dP
 M1nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYaGQqi9zhROHh+Oa54rX4T548sc1LOm0Dy263hueBS1NSSPYhdJwqkgzvTg5AXUkd7oUYAJKgEBUY7ydMORdni+JYZp8=
X-Gm-Message-State: AOJu0YwVZLxAiOFE+cA+F4C/uyNWuE3ub314qp6nM+h3jT9OoLLSbBVO
 IT+aNaWNdW21S4iQMiKlpwuIpJluf3jciTlTx7dw/W+47bu065OkLWVkl5yjINVCX3mUvCjJkZC
 2mjq/up0SVB/mqnxPgRrL4OMA3YsCcXp8d+gKP9qhO+B4yDCTGkMS
X-Received: by 2002:a05:6000:10c4:b0:363:d980:9a9e with SMTP id
 ffacd0b85a97d-36b31a5187amr2126799f8f.55.1721910799449; 
 Thu, 25 Jul 2024 05:33:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNFg/vuWe2oFay9N039fn3TrlpoXUmzQUlnFxLTZeAWFsuS7LiKQSxku9klsp/j5rRo846+Q==
X-Received: by 2002:a05:6000:10c4:b0:363:d980:9a9e with SMTP id
 ffacd0b85a97d-36b31a5187amr2126769f8f.55.1721910798847; 
 Thu, 25 Jul 2024 05:33:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:81aa:776c:8849:e578:516a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367f0e26sm2054573f8f.47.2024.07.25.05.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 05:33:18 -0700 (PDT)
Date: Thu, 25 Jul 2024 08:33:12 -0400
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
Message-ID: <20240725083215-mutt-send-email-mst@kernel.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
 <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
 <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
 <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
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

On Thu, Jul 25, 2024 at 01:31:19PM +0100, David Woodhouse wrote:
> On Thu, 2024-07-25 at 08:29 -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 25, 2024 at 01:27:49PM +0100, David Woodhouse wrote:
> > > On Thu, 2024-07-25 at 08:17 -0400, Michael S. Tsirkin wrote:
> > > > On Thu, Jul 25, 2024 at 10:56:05AM +0100, David Woodhouse wrote:
> > > > > > Do you want to just help complete virtio-rtc then? Would be easier than
> > > > > > trying to keep two specs in sync.
> > > > > 
> > > > > The ACPI version is much more lightweight and doesn't take up a
> > > > > valuable PCI slot#. (I know, you can do virtio without PCI but that's
> > > > > complex in other ways).
> > > > > 
> > > > 
> > > > Hmm, should we support virtio over ACPI? Just asking.
> > > 
> > > Given that we support virtio DT bindings, and the ACPI "PRP0001" device
> > > exists with a DSM method which literally returns DT properties,
> > > including such properties as "compatible=virtio,mmio" ... do we
> > > already?
> > > 
> > > 
> > 
> > In a sense, but you are saying that is too complex?
> > Can you elaborate?
> 
> No, I think it's fine. I encourage the use of the PRP0001 device to
> expose DT devices through ACPI. I was just reminding you of its
> existence.
> 
> 

Confused. You said "I know, you can do virtio without PCI but that's
complex in other ways" as the explanation why you are doing a custom
protocol.

-- 
MST


