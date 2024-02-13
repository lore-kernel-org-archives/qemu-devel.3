Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6143AC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpTO-0008R3-1K; Tue, 13 Feb 2024 04:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZpTM-0008Qh-P3
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:53:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZpTI-0002N7-Nl
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707817979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Znw6E+iclqrcFxZJmfW5ppaSiQa1CvikpT8w3ZyLw4s=;
 b=FKilCbN9fnoI0WjEjVBP9qO2ShvpS+7GCdosg4/OCfq75oJET+I64urvb3oTDSm1vklpNl
 vczZoGR+2Arej0bDMbYYvD7T8sTHcKl50W9YXL/hopNNpbiycroUBP4rt81cj4tMTDdQ/S
 0PvauEsgM27/zUBAj+yJLiRUklHLpiU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-Ea95ITVdOUiIkXOsJ0BvIg-1; Tue, 13 Feb 2024 04:52:58 -0500
X-MC-Unique: Ea95ITVdOUiIkXOsJ0BvIg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a2b6c2a5fddso283096866b.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:52:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817977; x=1708422777;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Znw6E+iclqrcFxZJmfW5ppaSiQa1CvikpT8w3ZyLw4s=;
 b=Um2GyYt3FcFs8rQsAsufJwtOMXoBAA9ixXpZrUL7s0plrcAqD7CXGnw11zNFrFQYPj
 xXiheYpLLON/lPFigQpI/QExMzkCUEFRagJAf9yQRuRDEENfHiXEF2I880rTHZO0xhsT
 6Ekju7iy3HqfG+xpMUMIQu/P4MAm/cb6B2U3hsf6XSG3h2UWPlguh8bII4d2XIPUsBLX
 K3w9ylibQ/9ugI6H0upnPaMkPkJrsCX6r/i6TlU77RRc/5eP3U4Vo0376atry7xRlWww
 qAgfS4YpPeLENAtRV8XptFRZhtJ/s2eVuX3O5XWaokWRDm53Pq6clahDz+WuTFIk4MfJ
 zV5w==
X-Gm-Message-State: AOJu0Ywq+PiWPCJ9qN/UdwbJPECegn0mzTL+4XZ8Q5qONgnDkVzjYNWj
 kGKysO8EtGOXbYUapoFz3FnUn4hc5ASEyoZ8WFvwlO1KmacjvShQl3kUWh/l6a3E8j+LyHD5sCg
 CM7LeqJG1bbk74nGfcgtEe9yA619BdU/LumP6972SS4cFVI6V4EnE
X-Received: by 2002:a17:906:dfe7:b0:a3c:8bed:86d5 with SMTP id
 lc7-20020a170906dfe700b00a3c8bed86d5mr4448765ejc.12.1707817976923; 
 Tue, 13 Feb 2024 01:52:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0XGr9JJ9LCxGm6Oj3tulfMgTWfPoXOME/IKfrkSj72PkrKH5Nw6DyzdK/BZXsrJkQjaqRUA==
X-Received: by 2002:a17:906:dfe7:b0:a3c:8bed:86d5 with SMTP id
 lc7-20020a170906dfe700b00a3c8bed86d5mr4448745ejc.12.1707817976582; 
 Tue, 13 Feb 2024 01:52:56 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVljxaOyIB3iXCYqxgYCuJksRdadmqamqkXRHaeVhLVjocI2+c1+uWE7HqxArBfbsfWiEagqKXo+CziV0EV0sP8sfz/bj49CTZ9cQdyKJPZu/L6Ory60VX/ksLVoRrRZnfhf4Lx3fW20tUVbvhq47de/hPysCntKNHxnhR+6eQ/bm9RxZKoKL+QtUSn2POd34Gxl29/yxOTUJ4LHpYD+dHXx/DUXSiRGypI0l8P3qoWqMimbGSK4hbxE2IrCHnAGoAGczwlhEpXSSOwTMZ6rPyZtNqW8ndNbDAfxnPVzVnrdDbnKyabTPyohbOrgJHhHSAUqg==
Received: from redhat.com ([2.52.146.238]) by smtp.gmail.com with ESMTPSA id
 i8-20020a170906114800b00a3c24e4ec65sm1138538eja.144.2024.02.13.01.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:52:55 -0800 (PST)
Date: Tue, 13 Feb 2024 04:52:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Rick Zhong <zhaoyong.zhong@nephogine.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jason Wang <jasowang@redhat.com>, Peter Xu <peterx@redhat.com>,
 Guo Zhi <qtxuning1999@sjtu.edu.cn>, Xinying Yu <xinying.yu@nephogine.com>,
 Wentao Jia <wentao.jia@nephogine.com>,
 Shujing Dong <shujing.dong@nephogine.com>,
 Kyle Xu <zhenbing.xu@nephogine.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBGVzogW1BBVENIXSB2?=
 =?utf-8?Q?host-user=3A_ad?= =?utf-8?Q?d?= VIRTIO_F_IN_ORDER and
 VIRTIO_F_NOTIFICATION_DATA feature
Message-ID: <20240213044703-mutt-send-email-mst@kernel.org>
References: <CACGkMEtHQHmhBAF6WguUSHr+iFMmOjvTshqpGzkvE=QtkgVVPA@mail.gmail.com>
 <SN4PR13MB5727AF7CB6E6CF563B618F1386732@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB5727D5A7AD34F7169E2A236F86702@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CAJaqyWc2P6iHrG9dR2X9YC=P7dw4=Y2RwRkr5H81hkj6ej_5hA@mail.gmail.com>
 <DM6PR13MB3988D0E01FE275F72E53397295702@DM6PR13MB3988.namprd13.prod.outlook.com>
 <SN4PR13MB5727A733210FBF7A3B72DDE886792@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CAJaqyWdx+33QrtCkMDAMG=1au7jKCgw4bcmgC+zgEcXaeW=Fbg@mail.gmail.com>
 <SN4PR13MB5727E433825757E3E326EB9F86432@SN4PR13MB5727.namprd13.prod.outlook.com>
 <20240201075513-mutt-send-email-mst@kernel.org>
 <DM6PR13MB39889A667DB46A0EC65FA08495422@DM6PR13MB3988.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR13MB39889A667DB46A0EC65FA08495422@DM6PR13MB3988.namprd13.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 02, 2024 at 10:27:33AM +0000, Rick Zhong wrote:
> Hi Eugenio and Michael,
> 
> Let me make it more clear about the target for this patch. Currently Corigine is developing the vDPA features on NIC which are based on the QEMU vhost-vdpa/vhost-user backend. These two virtio features are helpful in data plane performance.
> 
> In my understanding, these two virtio features are defined as part of the basic facilities of a common virtio device, which means they can be utilized by virtio-net, virtio-blk, virtio-fs... whatever backend. To implement, it is beyond the team's knowledge to handle these for all kinds of backends. So I'd prefer to set them off by default and raise an warning for other type of backends, except vhost-vdpa/vhost-user.
> 
> Best Regards,
> Rick Zhong

Yes, you should set it off by default.  No, just skipping implementation
won't cut it.  It is understandable that you just want your own use-case
addressed and it is annoying to get roped in to do some work on qemu.
However, such is the cost of doing this business.  If instead we add
hacks like the warning you mention then the codebase quickly becomes a
mess of special cases.  If you need this feature, you have to make it
nicely orthogonal and palatable to everyone. It is really not a lot
of coding work, mostly testing.

-- 
MST


