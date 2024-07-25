Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C712C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 14:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWzBu-0000Te-RU; Thu, 25 Jul 2024 10:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWzBt-0000T8-44
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:11:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWzBr-0005nq-9u
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721916688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m+7qqjfSJJedkSM0ho4FvwKX/Ww1MNIJK3ukt4D885M=;
 b=C3WOKJvocm7CyMDobSC6lkN5cHTfn3eyY9+OHTI476Pw0qWzmjmb0w4vhAygPe1WYfBVIj
 C+4N/DnvVRO0gDQIqKn2+9Gcs7MRRFZMdR2GjGBCleC4OFbHCJBYzzTIDgL1ADG/KVZJgx
 RZgnNoKjRXOZFHNo9ZHnAuoZuAP1/5c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-aKh6PcezOEySUQjyMj7Hhg-1; Thu, 25 Jul 2024 10:11:25 -0400
X-MC-Unique: aKh6PcezOEySUQjyMj7Hhg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-427fc86aaa2so6912165e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 07:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721916684; x=1722521484;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+7qqjfSJJedkSM0ho4FvwKX/Ww1MNIJK3ukt4D885M=;
 b=eTYCRwhtcZBOnSwHMecLUfes2YulB5tI9gp6xo3k1rAzNmBIhpKcZA12YVRs3pfEfq
 sdD+tWMTAWG0fXtbVWywscSBIR0e2y7ieXJSLJkmFCUIQOzfGIy9NbdhWR5i5esd3CcS
 asRadlGNyuWVUq14UjDeJPeel74oGCwmH+1A7mLPz2NQtHzH2mX+gBnHs2sEmf8mPZx2
 wGUTeaJ6a5wKLl5onfc3WeAXFdtEIFOKnPR7zT2nxLHgKXNpcHeX6OD5Gs4VlO8ffLyU
 8itNc7RpWwZ52Bhe3TOWkSfucnLLZUpPEP1FTbFeWascPmPzZH4xZEo22SIZexMFayc1
 iWNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXShfgujYpG5kbXskDahXYW8ZpsH8Ap8ycRwoJ2WytErk9bs96nLUx8RHLBVCwTnsw0Tr08GvVMjp835vA0Z0O/vFBFSX4=
X-Gm-Message-State: AOJu0YwRWTGKUPkvdRMBumz5s1Tvw+VPZnWCPbU0yfKDuQLff+tMBVya
 KpAjxqS8Xo/sBPy3Sd+nCpXf7yLeoLJpqZs1jhkX8LD7PfdBPcbLu/JsJuF0kkP5R/GLJIHHGr+
 h5msSY1pdPrtwqJvXtaeyu94W16CYx1OyMr5xtnLw/3wtCQy3w+y/
X-Received: by 2002:a05:600c:138a:b0:426:6320:226a with SMTP id
 5b1f17b1804b1-4280548fb4cmr18426205e9.15.1721916684227; 
 Thu, 25 Jul 2024 07:11:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNsRboMyhKaoJYp9kK8awnKz/IQ2dhEpvJdwFDL7IFTPJdpWaM7Aqb1Bj5iTJbBTmDrGoXmQ==
X-Received: by 2002:a05:600c:138a:b0:426:6320:226a with SMTP id
 5b1f17b1804b1-4280548fb4cmr18425765e9.15.1721916683628; 
 Thu, 25 Jul 2024 07:11:23 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:81aa:776c:8849:e578:516a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428057a6307sm37266205e9.36.2024.07.25.07.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 07:11:23 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:11:18 -0400
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
Message-ID: <20240725100351-mutt-send-email-mst@kernel.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
 <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
 <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
 <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
 <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
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

On Thu, Jul 25, 2024 at 02:50:50PM +0100, David Woodhouse wrote:
> Even if the virtio-rtc specification were official today, and I was
> able to expose it via PCI, I probably wouldn't do it that way. There's
> just far more in virtio-rtc than we need; the simple shared memory
> region is perfectly sufficient for most needs, and especially ours.

I can't stop amazon from shipping whatever in its hypervisor,
I'd just like to understand this better, if there is a use-case
not addressed here then we can change virtio to address it.

The rtc driver patch posted is 900 lines, yours is 700 lines, does not
look like a big difference.  As for using a memory region, this is
valid, but maybe rtc should be changed to do exactly that?
E.g. we can easily add a capability describing such a region.
or put it in device config space.

I mean yes, we can build a new transport for each specific need but in
the end we'll get a ton of interfaces with unclear compatibility
requirements.  If effort is instead spent improving common interfaces,
we get consistency and everyone benefits. That's why I'm trying to
understand the need here.

-- 
MST


