Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831E2C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 20:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uICnv-0005fw-JR; Thu, 22 May 2025 16:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uICnk-0005fH-W7
 for qemu-devel@nongnu.org; Thu, 22 May 2025 16:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uICnj-0006Fl-4A
 for qemu-devel@nongnu.org; Thu, 22 May 2025 16:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747946761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xfbQ+O8kvx6fHJSh6M8IJ9Ossd+z4mTp6GQWrK2VD6M=;
 b=R/4r8yqCnIBQCbGxJyN0VA7Ub8QSw2MKiPgnNdxxaSkWNXe2dTLQIaAMm6ItQZpeVt8Y9J
 XIqSJwV70cOhOCKKVj+sRBYhIklIelW+x2TxtVqUqVdIyTYzyP110iOmBiA6HcxMTDjAFR
 Ojl6s7QBJZSTPy8i92nd8fy5cTL1K00=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-pXxmjWTNMdmpYh2jkfa-Qg-1; Thu, 22 May 2025 16:45:58 -0400
X-MC-Unique: pXxmjWTNMdmpYh2jkfa-Qg-1
X-Mimecast-MFC-AGG-ID: pXxmjWTNMdmpYh2jkfa-Qg_1747946758
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4766c80d57eso127606421cf.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 13:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747946758; x=1748551558;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfbQ+O8kvx6fHJSh6M8IJ9Ossd+z4mTp6GQWrK2VD6M=;
 b=vS7V8M3UdpxOFGKtcAdBlZPsnYQepNhXBSxMEUuLNHOuyhpuVs1q1dWo59/PmOac9d
 gcJwvvNV80/v23zO5cb78I9H6EPFfbQ663cK3lMk4Sgamqpknzfgl8A3iVup8b4tcY9Q
 Khz07AbrgUuDCZSlxLDZT+xiXJ7knofGdYWMc7a5zk04bu0zVebuvQ1pipX0qzgDUYfM
 5nUPYgnx2xhUFmTXEPUTVrEiiOT+PcMhJHvfsvwzdR5dNeT6JfZuIv/triGPkt6X4mSh
 UW/vbC4ONxQ9uaQC4ySxjXLobonc3zpz+6RrK5IQfm0YCnVUi3db7902+RlHPTLvCCQu
 f/CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/GRqDWEANlBqBYPPiXZDufeHiuH2dIZW9P6/8zB33lBDyHmpBFqEJqOo/zad3eyV4aWJGdxwMguBX@nongnu.org
X-Gm-Message-State: AOJu0YwMdPLbGuXIv9uz41z3U+feTSzbXPEakKmwfXI603+BNN+anz3A
 TWCPvwbmSEGtgdhx19uCMqS+xWcXoSSwtadhnyZqg8RRV41e303AgeSwN/F+7BVKdnqNRDe3j/N
 MmF1n7bBqYx2rFMIsy1nzdUsyLjZdmuOPUlNAgJ1CZHr6pcB38kD0Mp3n
X-Gm-Gg: ASbGncuCA4+dm03I8NHkI7sMSgqGb8E0fP4EQRSBuZFuPCk5VdjkBidVVUsrFwb6iTD
 orpp5ztTlCSzXUUZpmHc6U2JRBJSLy/ZZmYASlgV1xdTRilwd0SLTMP6QcCNWYdAEYwZmAL1hKy
 dBsMe1lEUl3f4ueHShrkrPxQVDDECx1bSLB2GCok6v4Rgryu053xUObT1MucVbEM+8nUoaa4zpG
 k0F4PKd9SUe91FRUXc6TacBNp2on4YELpeqeTIOeKR1FJLKREMteb1awUBr+U/BjjxQuvMJDPVY
 Vw4=
X-Received: by 2002:a05:622a:4297:b0:48d:d1fb:3eee with SMTP id
 d75a77b69052e-494ae38e68emr410773821cf.23.1747946757716; 
 Thu, 22 May 2025 13:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqzOPP0ftEuqWPDY+qbZQzRkXOcig931bHCkkNmRpbXWEDwKorUPb3DrUNR4K5nLJziZBTlQ==
X-Received: by 2002:a05:622a:4297:b0:48d:d1fb:3eee with SMTP id
 d75a77b69052e-494ae38e68emr410773621cf.23.1747946757381; 
 Thu, 22 May 2025 13:45:57 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-494ae3ccfd5sm102409691cf.2.2025.05.22.13.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 13:45:56 -0700 (PDT)
Date: Thu, 22 May 2025 16:45:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-devel@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH] migration/multifd: Don't send device state packets with
 zerocopy flag
Message-ID: <aC-NAZEznD1gvJ3r@x1.local>
References: <3bd5f48578e29f3a78f41b1e4fbea3d4b2d9b136.1747403393.git.maciej.szmigiero@oracle.com>
 <4a5a68dd-74b2-4ffc-baa7-42eba9276b81@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a5a68dd-74b2-4ffc-baa7-42eba9276b81@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, May 22, 2025 at 11:12:22PM +0300, Michael Tokarev wrote:
> On 16.05.2025 16:53, Maciej S. Szmigiero wrote:
> > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > 
> > If zerocopy is enabled for multifd then QIO_CHANNEL_WRITE_FLAG_ZERO_COPY
> > flag is forced into all multifd channel write calls via p->write_flags
> > that was setup in multifd_nocomp_send_setup().
> > 
> > However, device state packets aren't compatible with zerocopy - the data
> > buffer isn't getting kept pinned until multifd channel flush.
> > 
> > Make sure to mask that QIO_CHANNEL_WRITE_FLAG_ZERO_COPY flag in a multifd
> > send thread if the data being sent is device state.
> > 
> > Fixes: 0525b91a0b99 ("migration/multifd: Device state transfer support - send side")
> > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> 
> Is this qemu-stable material (for 10.0)?
> 
> I'm picking it up for 10.0 branch, please let me know if I shouldn't.

Yes please, for two migration patches in the lastest pull.  I forgot to add
Cc: for stable.  I'll try to remember again, thanks.

-- 
Peter Xu


