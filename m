Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43767C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 12:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXKM9-0000yH-6P; Fri, 26 Jul 2024 08:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sXKM6-0000my-5H
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 08:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sXKM3-0000iv-Q4
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 08:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721998044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+RI/VaWGAXgOj4f2LRD8sZvA9wQ8Bbq5V+URVVIVY/U=;
 b=dmRouIDe3PSr1DV09ABVkprsy60tOdf+oPQsOMiANUgxAwSZo0tnoHJFS++XGR8v60h8+z
 kdZVCmxfFzKflddkncosq+Us6rl3e4q8NwipWpl6d2BLBnVMqHaULEfeO9xO6lG8vpdgw4
 DRa8wqKyPgGqG3mDu3Jvh6wmkqd4ue0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-TDs2j9dZNAuRbv9_H1YwVA-1; Fri, 26 Jul 2024 08:47:20 -0400
X-MC-Unique: TDs2j9dZNAuRbv9_H1YwVA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-368448dfe12so1390880f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 05:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998039; x=1722602839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+RI/VaWGAXgOj4f2LRD8sZvA9wQ8Bbq5V+URVVIVY/U=;
 b=fUtjvJaD4tGjop1bw/6fy7X429ZmUujMTAQ7ZBTl6kwCFXyDYAtmqk2qbezymNeXiM
 MYeQ3tHdcS/qZevdFGOb1wzoBBXHXSHGIdB9HiIFfiNdZ/C3pfGYbhtjhlBr3+SiiQJi
 Cze3YzTV5cFHeOiboesUXPe1IkT+k8YJFUnz/eHdLJh2qlsA1lwjZ7TAVf8RszNlYlzP
 a9sjuvAFIMrdl821+HH4Q3CI0jcMZ6jLqYxneYRplt/rTqjuXqXcT2Ed//aahKQy1joj
 D+y3Kvg9W1Gj5kx9SHzae79OLCZchBqXX1UBbaGSKg8z0wtakg4GQCwx5j7JmzJsRnL7
 MMUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuPn64EdT6tTU71W4l3eimbd0zPrDKV9sn0RBFhKpnJyI01sL/+tpHMOpTHlWi4li69QnD3vdVlCSoIFWtN1KsyW+X5D4=
X-Gm-Message-State: AOJu0Ywt8dWT4iX1Th1oQORr68AiPSqLJmgjAACYl3hJsrD0UUxXqljs
 yJsxEEOONhqs7G0bj663vTtkJWXdJIKjGK/+SRsVly0KerdZVTTu2ZW5I5tfiHPCZnbKt08nd3Z
 PGpyPhLddnZiXMnWJ/O/8Z+8BZ2IlhnKpZFC9o+DAGOTKWTsZ6cet
X-Received: by 2002:adf:f802:0:b0:367:40b6:b90b with SMTP id
 ffacd0b85a97d-369f66a36dcmr6227104f8f.10.1721998039091; 
 Fri, 26 Jul 2024 05:47:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDA1wA77VLVH0wQPd6DrvSmW8M/g+xgdd7FFO6J646GDTZZ94nA7gUMdnSx1MXbGPQ+LmlFw==
X-Received: by 2002:adf:f802:0:b0:367:40b6:b90b with SMTP id
 ffacd0b85a97d-369f66a36dcmr6227065f8f.10.1721998038420; 
 Fri, 26 Jul 2024 05:47:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367d98ccsm5031156f8f.33.2024.07.26.05.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 05:47:17 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:47:13 -0400
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
Message-ID: <20240726084424-mutt-send-email-mst@kernel.org>
References: <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
 <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
 <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
 <20240726010511-mutt-send-email-mst@kernel.org>
 <20240726012933-mutt-send-email-mst@kernel.org>
 <f2e85f8f568f8a21b2178e59d8387d7a52a843bd.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2e85f8f568f8a21b2178e59d8387d7a52a843bd.camel@infradead.org>
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

On Fri, Jul 26, 2024 at 09:06:29AM +0100, David Woodhouse wrote:
> That's great. You don't even need it to be per-vCPU if you let the
> hypervisor write directly to the single physical location that's mapped
> to userspace. It can do that before it even starts *running* the vCPUs
> after migration. It's a whole lot simpler. 

It *seems* simpler, until you realize that there is no way
to change anything in the interface, there is no negotiation
between hypervisor and userspace. If I learned anything at all
in tens of years working on software, it's that it is
never done. So let's have userspace talk to the kernel
and have kernel talk to the devices, please. There's
no compelling reason to have this bypass here.

-- 
MST


