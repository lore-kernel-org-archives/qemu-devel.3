Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626C0606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ULRUHtgn;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=M/D0rEDD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMvsX-0007So-Ao; Fri, 30 Oct 2026 19:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xMvsT-0007Qe-Ay
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 19:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xMvsR-0001hD-Cu
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 19:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793402353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0LlTDbJR93oFZ/GnDJkvFSZxstXBkn4pCWqxKjRNBz8=;
 b=ULRUHtgnoCf9WOvASiO3jHDXgdBMghZP0i5r3/iMhPUSbo2u2ceKiYQtWKqgaNXHwYxLi7
 bqn16gSdCvT6g13nb5r5YmtPLT3fAnOYTr8o+QNSiE2rO/r0Qz+PPomT+UAM4j2/0aFJmt
 cLtsMEX9wiMlUBNpAb5ezfcipX9J8xM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-q6MUNRR3O3iKK3pOyI4JqA-1; Fri, 30 Oct 2026 19:19:11 -0400
X-MC-Unique: q6MUNRR3O3iKK3pOyI4JqA-1
X-Mimecast-MFC-AGG-ID: q6MUNRR3O3iKK3pOyI4JqA_1793402350
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a9d51dc486so13663805e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 16:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793402350; x=1794007150; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0LlTDbJR93oFZ/GnDJkvFSZxstXBkn4pCWqxKjRNBz8=;
 b=M/D0rEDDxroe4FOCWshOUxvhxp0h9qLvXgTZlEpi+ojLGTaQ1mptxfyC/Whu867d1H
 WvYUdVCvv39n+ndWhY7Sjykn4oVyG4K8DB9IwP7wuu6IcDXIjkEkynuePjfcpzOYQoVx
 TR0jriHodbpiWFoiJv2Hc/9S5FaE9gzAZhiWOYJuTlB8rChbiMefinXcUpBfTD4Nj4ay
 MpUBOhEPE/OF3UuhVjVTjU8TMzRIRzdunIfjcSFi28iEX/zC+hGvGdSAoWe1+e8y3CPk
 ytyramO3B+hcKe95zzwyu6KkMqospWPP9gwA5lePLHwQfbAhU18B9qEEqq73Vwpf53ay
 MJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793402350; x=1794007150;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0LlTDbJR93oFZ/GnDJkvFSZxstXBkn4pCWqxKjRNBz8=;
 b=uq+jQktKR5JbAHCBjCaM4nzlQf6bnEnbU5N+wbMlwXKS+2Z97veHYD37OcTU20PvbF
 Zh4IIPTFXvHqy5AsSLcpaAVnsmuyxwagypZ3HgnoX7OHjRqf3lLOFJmrCwV0R2YSDMly
 T4SM1UHGRVY46Lsxr66YGRxHwl2WxZbcuw/R4iK/y9Q9jbQWXaw0aMOWLSeHQ2Jfl/I4
 kmeNBdHAATUUU6OTHX2sLH5BnVwuIShTMbGqRJEQT6DfYd7BdcZDaw3piNyGAkw3EvOa
 mEbRFTVJEvEFKtaErudeygiWFLhvb6Tk0VxsgihER0Pd4Lv1PHlGrvhpW1LgcVON26Y1
 WpLA==
X-Gm-Message-State: AFq9FYLTkYpRvTzMgpeVBlxsMJ2dM36NRSE6S33j8u2lFDFGIvpylDW+
 q7g5gvS+xX0qRxIDCB+iHbMeQR1euhv1vjnzjmJEN374gxval6ob1NSb6/X3CqRiWXdvBQ7VYXd
 yY0AYNz3LpK0uYXakXE0a57PVDE0dx4z6SBIW90iA0jcIVhLtaMJYEsz1
X-Gm-Gg: AYBFou0Cg3z3TwsNcFn/4z9RKvNOHXh66KMYUO/DN/weQDphA/iijpFxKZRQ+TJOsIp
 pwt3RRtqb7QFvjsf4Uglgkihg6dRbX1oKbcrzzjb5A7h+h/+f3umZwL/rhpY1lXkorUY2i0AFdQ
 3yW3LScsF0Pzo/sfaCkXbz2et9vZaHGXTP37kaZlQpmMWH9sqiCI6IWldK0xJXdkQAcAadUMx5S
 HIYSgbzoif0g3rdCNlPV8DqvrfgcShyjmfyuAd33KnCMhgH3/wiisUv5zWFiOP6N1JZGFZnLudc
 TPku7GuU32C5OL0LKFwOYBfkmf3NW/3Tu6lEfoQbScuWB5pT4IAMOjdpoJCwkio47G1urz7cE0H
 cmIAAOY0y+fNyoNDxdMTkzJZj/PjXVZqLQrsui/4gccZV
X-Received: by 2002:a05:600c:4ece:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4ac169d7e39mr84529545e9.5.1793402350177; 
 Fri, 30 Oct 2026 16:19:10 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4ac169d7e39mr84529145e9.5.1793402349702; 
 Fri, 30 Oct 2026 16:19:09 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6e63e0esm119095955e9.12.2026.10.30.16.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 16:19:08 -0700 (PDT)
Date: Fri, 30 Oct 2026 19:19:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Weqaar Janjua <weqaar.janjua@packetfive.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, peter.maydell@linaro.org,
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com,
 marcel.apfelbaum@gmail.com, peterx@redhat.com,
 lizhijian@fujitsu.com, odaki@rsg.ci.i.u-tokyo.ac.jp
Subject: Re: [PATCH v3 0/6] hw: Add Cnuas virtual devices
Message-ID: <20261030191556-mutt-send-email-mst@kernel.org>
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
 <20261016153247.1815153-1-weqaar.janjua@packetfive.com>
 <20261027080746.2468700-1-weqaar.janjua@packetfive.com>
 <20261027063724-mutt-send-email-mst@kernel.org>
 <20261029115735.2716219-1-weqaar.janjua@packetfive.com>
 <20261029134859-mutt-send-email-mst@kernel.org>
 <20261029194227.2735464-1-weqaar.janjua@packetfive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029194227.2735464-1-weqaar.janjua@packetfive.com>
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

On Thu, Oct 29, 2026 at 07:42:24PM +0000, Weqaar Janjua wrote:
> On Thu, Oct 29, 2026 at 01:50:11PM -0400, Michael S. Tsirkin wrote:
> > Hmm wait a second.  I don't understand. Isn't it a physical device you
> > are emulating?  Why is it using the Red Hat IDs?
> 
> No, it is not a physical device. There is no CnuasNIC or CnuasGPU
> hardware; both exist only as virtual devices, the QEMU device models
> in this series. Think of CnuasNIC as veth or rxe for RDMA, but
> presented to the guest as a PCI device so the full driver, verbs and
> RDMA CM path runs unmodified. The Cnuas project (cnuas.io) emulates
> the rest of the RDMA subsystem around it, including a RoCEv2 and
> InfiniBand switch. CnuasGPU is the same idea for an accelerator.
> 
> The register interfaces are defined by the models themselves and
> documented in docs/specs/cnuas-vnic.rst (patch 2) and
> docs/specs/cnuasgpu.rst (patch 5), with more detail in the
> datasheets at:
> 
>   https://cnuas.io/cnuas/docs/datasheets/CnuasNIC_Datasheet/
>   https://cnuas.io/cnuas/docs/datasheets/CnuasGPU_Datasheet/
> 
> So this is the same situation as other QEMU-specific devices in the
> 1b36 range, for example pvpanic-pci (1b36:0011) and the emulated UFS
> host controller (1b36:0013), which also have upstream Linux drivers.
> That is why I asked Gerd for IDs from the QEMU range. If we were to
> build hardware, it would use our own PCI vendor ID, not 1b36.
> 
> The "RDMA network adapter" wording may have suggested otherwise. It is
> an RoCEv2 adapter in the sense that a Linux guest sees a normal RDMA
> device, but the wire side is a socket to a user-space switch process,
> not a real NIC. I can make "virtual" more explicit in the commit
> messages and docs if that helps.
> 
> Thanks,
> 
> Weqaar

I see. Then a simple way for you to get some eyes on this, and a path
towards upstreaming, could be to try and add this rdma functionality
in the virtio spec.

Interface changes might be required during the standardization
process.

-- 
MST


