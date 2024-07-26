Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A0AC3DA63
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 05:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXDvu-0004lq-2c; Fri, 26 Jul 2024 01:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sXDvs-0004kN-7u
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sXDvq-0005rX-8I
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721973356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YQThcy6xed9kn8EJsXisAuikWbZtGIN23SlH2PNZkcA=;
 b=bkjymalnOdXScRwNcjhDSuo1dqkAVX4GvsaNggUYsA+jms15GCP9J7z/xQ1sVUevJJzvfG
 IPBjOcfwxwqCWeaNhUFSWefQ9jv/H37Wci3DEzRRojLXmnC/jl8Ysb3EIsSDo/7ynFBrK9
 tyWJ98LQeCUNb/hyL57bPquZ0MGrTeA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-BhRb-0kGOoqAW-HOKuxBXg-1; Fri, 26 Jul 2024 01:55:53 -0400
X-MC-Unique: BhRb-0kGOoqAW-HOKuxBXg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4280c6b3614so2716565e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 22:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721973352; x=1722578152;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQThcy6xed9kn8EJsXisAuikWbZtGIN23SlH2PNZkcA=;
 b=e0S//220sfzB8fa07Q767Y88pLun7rhkBpDWGJzlRRWv+sTzwnfsi8hk+GPYThPcuK
 OAOQsXLsqLSxq8yeeEXHQZUEMDN4Rw3EBFgaLi4iFZZLbdIsapZjpWIrS+UfWdMtgLLK
 Rgngtpv1d4W2NeJkZOSoeBBDLX4W3Z0PR0mdxfZ01mC6b31EIBZToT0lv2NOgJHc1/q/
 QUS/Yv14ehQiedQSC1dXkO9GX8b7wavEk//n+Rrb8PZjFchAc95UE8Tf5IdEfHT/Fw8g
 kbeFjTfV/qzoK1m86V+cM62GptAgYwGVRQ/zWljAc64lrebzkdwCVGKqRgHCJxCjDa8j
 8ZGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhDuRu5ekU8FpDhJiGcGnuv1wZ8QjKzMZG9jq9DRPQ1XUnQFNwvdHKsqlZoOT25d7zrWJokShW3yK3m3xezXfSWkzL4ZY=
X-Gm-Message-State: AOJu0YxehzxT6TTFxmUDkFNfUQXCX8GkPb4wM1ha/b2dcoVjG07szeDd
 HznOFenqPTDqJSzeBJMuoioKAwSXioxqAg3wplaSf5dfPSi4FVJd21kNPhnXH8MNEPNVgQnU2VG
 uoNnA2HmpoH6wuk8f4kWH80bMahCbMdF4oyqf1axegMLdIBoqnvqz
X-Received: by 2002:adf:c08b:0:b0:367:8875:dd4c with SMTP id
 ffacd0b85a97d-36b31ae2541mr2973082f8f.23.1721973351674; 
 Thu, 25 Jul 2024 22:55:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwUk9Ft0dVUiNjmu7f1QTIXu6q3o+g6VMlVMK1lSks1buGboeYtzHjiLlkzq1mSCBI88a7sA==
X-Received: by 2002:adf:c08b:0:b0:367:8875:dd4c with SMTP id
 ffacd0b85a97d-36b31ae2541mr2973059f8f.23.1721973351027; 
 Thu, 25 Jul 2024 22:55:51 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573edbfsm63673365e9.15.2024.07.25.22.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 22:55:50 -0700 (PDT)
Date: Fri, 26 Jul 2024 01:55:45 -0400
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
Message-ID: <20240726012933-mutt-send-email-mst@kernel.org>
References: <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240725100351-mutt-send-email-mst@kernel.org>
 <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
 <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
 <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
 <20240726010511-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726010511-mutt-send-email-mst@kernel.org>
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

On Fri, Jul 26, 2024 at 01:09:24AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jul 25, 2024 at 10:29:18PM +0100, David Woodhouse wrote:
> > > > > Then can't we fix it by interrupting all CPUs right after LM?
> > > > > 
> > > > > To me that seems like a cleaner approach - we then compartmentalize
> > > > > the ABI issue - kernel has its own ABI against userspace,
> > > > > devices have their own ABI against kernel.
> > > > > It'd mean we need a way to detect that interrupt was sent,
> > > > > maybe yet another counter inside that structure.
> > > > > 
> > > > > WDYT?
> > > > > 
> > > > > By the way the same idea would work for snapshots -
> > > > > some people wanted to expose that info to userspace, too.
> > 
> > Those people included me. I wanted to interrupt all the vCPUs, even the
> > ones which were in userspace at the moment of migration, and have the
> > kernel deal with passing it on to userspace via a different ABI.
> > 
> > It ends up being complex and intricate, and requiring a lot of new
> > kernel and userspace support. I gave up on it in the end for snapshots,
> > and didn't go there again for this.
> 
> Maybe become you insist on using ACPI?
> I see a fairly simple way to do it. For example, with virtio:
> 
> one vq per CPU, with a single outstanding buffer,
> callback copies from the buffer into the userspace
> visible memory.
> 
> Want me to show you the code?

Couldn't resist, so I wrote a bit of this code.
Fundamentally, we keep a copy of the hypervisor abi
in the device:

struct virtclk_info *vci {
	struct vmclock_abi abi;
};

each vq will has its own copy:

struct virtqueue_info {
	struct scatterlist sg[];
	struct vmclock_abi abi;
}

we add it during probe:
        sg_init_one(vqi->sg, &vqi->abi, sizeof(vqi->abi));
	virtqueue_add_inbuf(vq,
                        vqi->sg, 1,
                        &vq->vabi,
                        GFP_ATOMIC);



We set the affinity for each vq:

       for (i = 0; i < num_online_cpus(); i++)
               virtqueue_set_affinity(vi->vq[i], i);

(virtio net does it, and it handles cpu hotplug as well)

each vq callback would do:

static void vmclock_cb(struct virtqueue *vq)
{
        struct virtclk_info *vci = vq->vdev->priv;
        struct virtqueue_info *vqi = vq->priv;
	void *buf;
        unsigned int len;

	buf = virtqueue_get_buf(vq, &len);
	if (!buf)
		return;

	BUG_ON(buf != &vq->abi);

	spin_lock(vci->lock);
	if (memcmp(&vci->abi, &vqi->abi, sizeof(vqi->abi))) {
		memcpy(&vci->abi, &vqi->abi, sizeof(vqi->abi));
	}

	/* Update the userspace visible structure now */
	.....

	/* Re-add the buffer */
	virtqueue_add_inbuf(vq,
                        vqi->sg, 1,
                        &vqi->abi,
                        GFP_ATOMIC);

	spin_unlock(vi->lock);
}

That's it!
Where's the problem here?

-- 
MST


