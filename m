Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4709606A31D
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jP+/0Lb7;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nP/arg9j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNDHl-0004Mo-2I; Sat, 31 Oct 2026 13:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xNDHd-0004MS-9z
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 13:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xNDHb-0004vK-Js
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 13:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793469260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rgKbjf2tWUbpWi1JP6prylSZpxqrhFltng7lafiBQlk=;
 b=jP+/0Lb7Aydjcqdhv0wSVLM/qZ1zehMoiGxfFiJUh39vQEJOg4HEuoha455mjbkX6kroGo
 ebSZx8Qjzq+yw12T+teg21budJORtyyBvsWhfkLSIzWXylBYhxcOaLCMufeQborofipt/u
 Ey7bpIYVLyvWU1PTHPuT/81SPXPs1l4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-mSiWCNkLO8ezLmbyGUzPBw-1; Sat, 31 Oct 2026 13:54:13 -0400
X-MC-Unique: mSiWCNkLO8ezLmbyGUzPBw-1
X-Mimecast-MFC-AGG-ID: mSiWCNkLO8ezLmbyGUzPBw_1793469253
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a0284121c6so15320315e9.3
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 10:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793469252; x=1794074052; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rgKbjf2tWUbpWi1JP6prylSZpxqrhFltng7lafiBQlk=;
 b=nP/arg9jB3hmtVIBcs0NOPeRb6SIuTQGfXfYllNThFDrtLy3+CZooUtAGI/+erpVKs
 PZM4Y/KFmbOPu5y+NM+qDVbkOutnZA9JsfKqj2BeXKwTcr3XeRVO1qfq+RlpLRT7BFo9
 cNaEAkJCRwN0dEfzzNrp38oFuUgDkidzzjESI12BehHnEw0YDTloEOJVXpnv5W1HZyp9
 oRZTeWP7JmwJiaDeCAvNg2Ps+iwhJSnmkoU3QR9zC6Du30IgYr1GUhjOKia36ovzo0Sd
 gb6rboPJkQfox7QwZ/YSc2NWMaliWuXSwqnovSHbvnk6mJj++59rSOO7H2yl3ALGqI0r
 Dv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793469252; x=1794074052;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rgKbjf2tWUbpWi1JP6prylSZpxqrhFltng7lafiBQlk=;
 b=oNvescNCY9OMMll/p3W0AS0rBENfCDdku8XmMnw2AoYlX2b+cp4jcZLPx1JnUBaOqo
 Ev60V1UcvgydLPD2vNy6IXPrR5uEEgVqY8FbAS/wc5qx4bZGYiwSd7cthkE2TZljGR2Y
 qqwzpV2gBc8PCKdxUdHpfsGQ1zgwfqmi1W2vrxGArLq0z2uDn7WLuqpFMwGglmFy0DNj
 wnQc3Tz0eM8J8JkD5bQ+r7bUwNw50Z39tkxWdCamwlDvibV71FHeeaJuD/PGtuAVgO2v
 aXK2Zk8cciA+dGxbWwweAbUWabiowsMRlSfgXhMW2aChP+yRYltSptcuvk5KhJAmJOXh
 o6QA==
X-Gm-Message-State: AFq9FYIUqHHf4y8m9wscMifd5TxRBPn7qNEyBJM5nxa9NPxD2DbAmdqs
 +mKPB/TEeyWqw8mOCETDtDQ5KKVU84Y8tvkEsCy8xapmMmebbOmOMRJ9yWMIRjtWVo15St9fNfI
 lt3qSQjFGKxhkwgnLSJNwB6vxriShiRcX1+25GC4tKiqak/3Il1eimuHR
X-Gm-Gg: AYBFou2rKJlOKWmG0pNYvmePZGy6BVZvMHoaxgRnO03MiEHR44SIt7s2iRRIj9bJDOq
 vWL9E4pF0x/ilUV+FGAwotCOgPwy7x/EdQZU+y/lvaFZ2XnkLElbMbsNZAcNeXAR5yiETsv0um8
 IehdIzT1XY/389d0R5yu0FvW0gj+tWXtfZMdqAdRA7R4iDNA+lIBgxZTYy8gRPCgtO6A5Ryrv3e
 ZpfBkfKCX9hLzc2tR1uBJSRRPf89GWVCYG51tNNrive/IjR6gcE0RHttOouyV8wVSemJDax/PaP
 HN+hKfXvVjiuNaGyZB/ADO8XMKuivkatuNS/yPYawBHeR/W/hRvWMscNvtT6Kf59VLWzOlHfhMu
 9S1Qp6CaypZUbtxhvL0Omneb6nWt20aXBvLqd3k6Nu+Mg
X-Received: by 2002:a05:600c:46c8:b0:4a2:397:73f6 with SMTP id
 5b1f17b1804b1-4ac174713fbmr141669415e9.8.1793469252380; 
 Sat, 31 Oct 2026 10:54:12 -0700 (PDT)
X-Received: by 2002:a05:600c:46c8:b0:4a2:397:73f6 with SMTP id
 5b1f17b1804b1-4ac174713fbmr141668995e9.8.1793469251854; 
 Sat, 31 Oct 2026 10:54:11 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abea533a1esm100238895e9.1.2026.10.31.10.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 10:54:11 -0700 (PDT)
Date: Sat, 31 Oct 2026 13:54:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Weqaar Janjua <weqaar.janjua@packetfive.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, peter.maydell@linaro.org,
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com,
 marcel.apfelbaum@gmail.com, peterx@redhat.com,
 lizhijian@fujitsu.com, odaki@rsg.ci.i.u-tokyo.ac.jp
Subject: Re: [PATCH v3 0/6] hw: Add Cnuas virtual devices
Message-ID: <20261031135234-mutt-send-email-mst@kernel.org>
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
 <20261016153247.1815153-1-weqaar.janjua@packetfive.com>
 <20261027080746.2468700-1-weqaar.janjua@packetfive.com>
 <20261027063724-mutt-send-email-mst@kernel.org>
 <20261029115735.2716219-1-weqaar.janjua@packetfive.com>
 <20261029134859-mutt-send-email-mst@kernel.org>
 <20261029194227.2735464-1-weqaar.janjua@packetfive.com>
 <20261030191556-mutt-send-email-mst@kernel.org>
 <20261031120516.2846639-1-weqaar.janjua@packetfive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031120516.2846639-1-weqaar.janjua@packetfive.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 31, 2026 at 12:05:14PM +0000, Weqaar Janjua wrote:
> On Fri, Oct 30, 2026 at 07:19:05PM -0400, Michael S. Tsirkin wrote:
> > I see. Then a simple way for you to get some eyes on this, and a path
> > towards upstreaming, could be to try and add this rdma functionality
> > in the virtio spec.
> > Interface changes might be required during the standardization
> > process.
> 
> Thanks Michael, that is a helpful pointer.
> 
> The intended use of the Cnuas emulated PCIe devices is the reason they
> were not designed as virtio devices.
> 
> Cnuas is intended for teaching and research of Open Compute ORV3
> (and future versions as it evolves) rack-scale data center systems, where the
> PCIe devices and their drivers are what is being studied. CnuasNIC and
> CnuasGPU are small, fully documented PCIe devices in the spirit of
> edu, but with production-like features such as configurable link speed and
> width, a 64-bit prefetchable BAR (CnuasGPU), and a switch transport
> that joins several guests into one fabric. Their guest drivers are
> full netdev and RDMA core drivers that run rping, perftest and QEMU
> RDMA migration unmodified. Just to clarify these aren't edu extensions 
> because they are different PCI classes (network and co-processor), and 
> edu's fixed register map is used by existing course material. My concern with
> virtio device is that it would hide the layer we want people to work with.


People being the students?

> Also, that in the ORV3 rack model, each sled carries its own NIC and accelerator
> as separate PCIe functions with their own driver, next to the virtio
> devices the guest uses for its disk and management network.
> 
> I understand that a virtio-rdma device could definitely be useful in its own right, 
> I am happy to look at it separately since the CnuasSwitch backend could serve 
> both. If you are ok with it, for this series I would like to keep the devices as 
> they are, in the same spirit as the other QEMU-only devices in the 1b36 range, and 
> keep looking for a reviewer for patches 2 and 3 (Jason, Peter, Zhijian, Akihiko, 
> any of you?).
> 
> Thanks,
> 
> Weqaar


-- 
MST


