Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F435606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e96QKpkC;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=O1OQiNLF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNQ8-0007cB-34; Mon, 26 Oct 2026 12:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xLNQ1-0007aZ-1z
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:19:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xLNPz-0000Cq-GL
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793031565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/GyJAljMh1MPZTtL0Z3L7ybGVWs0rh499dym0TvbMpc=;
 b=e96QKpkCHbrABi6g3qxWRSfwKSemd3uOgcMsuyz3jvms0UEmKHVGZRKNPcr62KAfd6saz2
 6KRK1R5exgJISy7UfHk3tIdA0Al/6OqQkUaaoqVEOXfBFBimiv/grNAsA2Q2d8eYDHdcFK
 GvEHH3UNDTS8HAek/pacGQKdEbdeXnI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-2R6dq_pCOMKfmpXVhSuGFg-1; Mon, 26 Oct 2026 12:19:12 -0400
X-MC-Unique: 2R6dq_pCOMKfmpXVhSuGFg-1
X-Mimecast-MFC-AGG-ID: 2R6dq_pCOMKfmpXVhSuGFg_1793031551
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e0af48c18so2845816f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793031551; x=1793636351; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/GyJAljMh1MPZTtL0Z3L7ybGVWs0rh499dym0TvbMpc=;
 b=O1OQiNLFBsnQt35yaV1G5kXT/Tpam6G0mKFx6CFHtlPv6gjo7uNgr2KvsYCZXZOLmF
 qJb0B/4Jl7TdxBPdw7RbfPahCue5B5SQTz/dHneK7KqA9+VWr/O6nw49ALGdIrdRVRtn
 vMwS9VCr5JGRDZy5CdS7GCJ3jApMS8Rqh6YNXfYwgiLZ8idQN9qCW77+AP1mZUYYMceZ
 Wh1LK1SrJacTmCPa0dHxybj4DJCe2NcWbjBihbE2LI+j4kaCsMP13+V6RoRlgsbV/0yq
 ko7hzyNjyXmUElrGdg5409X1p1qRBfeBmqae4YH+qJDgDc5Y6lcU4v/X8QHJ9J+0PNoT
 e1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031551; x=1793636351;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/GyJAljMh1MPZTtL0Z3L7ybGVWs0rh499dym0TvbMpc=;
 b=LPTa1grTB3OPdaB5AgZsrgMQru0LS0RfGTQDnHIGfbDNExI7f2NM/osM8vqKbZMeUO
 KbEA+ylvPNW2JvUgte3FchQxwQUt/16Isv+FSMlBmZj0dIpMzPLpNO8WQx7yN6MheC7L
 U9PqC9Wy7VhYpJIfyv6bVk18QXolWYDodhQA0qDF4GSX2oLjRINRXIw7RSeBmcbay3nV
 kDzjFnsOktd7ygveadIg0pMSyTl3UbEzgntChMMdfwVdroO7AANXz0aBnhdSR3PoUH0o
 AOfecnthz9zQ9VZiGwTWx9gZVB3Eb0bwjsUUfEJbei3O/M/PZOxCuWI8ThuGD2P7jf+0
 242w==
X-Gm-Message-State: AFq9FYLU0UhlBo4HCSBAeP54TLFymwGAKsyzl/jtDl7op4UJyryvullh
 Ctb9z5lkd6NtuCHZl0BeNcgsWjHnE3QbJYy4bY4xTSjYl+dy5QRDgx/HNRTe6W3fFJSdkX40G4P
 DnjnH15S9Enck9nSPrEPc4I+7H4wz8ugRAoNIuxMtAE2t2gsHdX9f7h10
X-Gm-Gg: AYBFou1RqlNr3zbpe1P/WZhnseEY7qM8oCDDvukbitceNscU48j/BEAdq9MTxsSDRmH
 8wlNG91G8Cxi/P5XcJSkvXADPFjh7/e3UCr+ImNZqvaX71C7Mu14upwGZFKpCZxML+YDqRiut6u
 gW14yKZwvrjtM59w/ErS3javIU9sD1/nkgF6xOTZLiarHeeuJP2609w1Qzg1yK62wbcq787fLo+
 fP3eEPjoazgDTLLXfVYCXwa9pw/ikhG1rGZQyM3LODCcudFqj1cDmodMCV7ufu9ejedw0/WiJvR
 y8hO4ifG8kkSKlpCwDMAHkH2i9UFRttBtRYRwCh2ckMhf6A+95uYuLlsDbwikyt7NWA=
X-Received: by 2002:a05:600c:6217:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4a35aae5c3amr125781645e9.0.1793031550665; 
 Mon, 26 Oct 2026 09:19:10 -0700 (PDT)
X-Received: by 2002:a05:600c:6217:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4a35aae5c3amr125781125e9.0.1793031550157; 
 Mon, 26 Oct 2026 09:19:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a55e9aasm208340125e9.5.2026.10.26.09.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 09:19:09 -0700 (PDT)
Date: Mon, 26 Oct 2026 12:19:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: migration, PCIE ports, and parent_obj.parent_obj.parent_obj
Message-ID: <20261026121828-mutt-send-email-mst@kernel.org>
References: <CAFEAcA_1ESA4Uan=gJyiRrjj4-EVvtfgn2dUT8qDa8zUU_gf=g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_1ESA4Uan=gJyiRrjj4-EVvtfgn2dUT8qDa8zUU_gf=g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 04:11:57PM +0000, Peter Maydell wrote:
> In reviewing a new pcie host bridge, I noticed (because this new device
> copied existing code) that the vmstate structs for pcie root ports do
> this in their vmstate structs:
> 
>     .fields = (const VMStateField[]) {
>         VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
>         VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
>                        PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
>         VMSTATE_MSIX(parent_obj.parent_obj.parent_obj.parent_obj,
>                      GenPCIERootPort),
>         VMSTATE_END_OF_LIST()
>     }
> 
> (this specific example is hw/pci-bridge/gen_pcie_root_port.c).
> 
> Devices shouldn't have to have ugly long chains of "parent_obj"
> like this and shouldn't have to care what in their parents needs
> migration; compare e.g. SCSI devices, which start with a
> "VMSTATE_SCSI_DEVICE" that captures all the parent class's needs,
> followed by only the state that the child added.
> 
> How can we get to something more like that for PCIE port classes?
> 
> thanks
> -- PMM

Yea makes total sense. Anyone has the bandwidth to take a stab?
I'm buried under a pile of ai generated security reports.

-- 
MST


