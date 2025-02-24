Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C763AC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tme0e-0008W2-HW; Mon, 24 Feb 2025 14:20:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tme0d-0008V4-7G
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:20:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tme0b-0007xn-Kd
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740424850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ennigzcwHGNgl2gptP1Nq+WKpdP/Aajkg3ddzIJXBZ8=;
 b=L8gs7aL0sT9eahZb7iwx0U6y6t1xvdFWCq92H16bH9JheKbtSCdoMfXLsnReMfh807W/MJ
 chaeqNvbFSc9vHehT6/gju+cpvJIsG0M59+OZCEe9ehemFtatlE87hf6HOjgNhBKW+XyaL
 v+m7eYrZH8oc/iXKqCxIdds5Ta/QqgI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-gqvC6vz0ONmrID6dBkI22A-1; Mon, 24 Feb 2025 14:20:48 -0500
X-MC-Unique: gqvC6vz0ONmrID6dBkI22A-1
X-Mimecast-MFC-AGG-ID: gqvC6vz0ONmrID6dBkI22A_1740424848
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3d2a40e470fso37765365ab.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 11:20:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740424847; x=1741029647;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ennigzcwHGNgl2gptP1Nq+WKpdP/Aajkg3ddzIJXBZ8=;
 b=voG0B+5zxcquDEDUjlchyAupes2MagGXLrFCZvo30vWhn9C2OQL7NU7nr5wypvl9s3
 aOUmq0bqCA+8L5EFDFJ7TxD7zi2lI3tr1Zjxmcib4xTnr6kVLluMehJOE+YCtT9HX28B
 dYLqXrLpKkCGIiJFACYrexfNgZiTpRYXkUzCUac4+CGvN/g6zCCaKvoCD6e5dzRTOxNN
 +SkaIQidosqSal4FgYqxLVihk39Kr07PvcSzNrT4uVFWH+RIOzeSlLqhWJm5yr/LzhLu
 zDc02g6LYv1O1Ni25wSMYrMZmwG3+KyOjTTdoiVnwbveSLjuWOZ5ZN041hYjgO3Y75KT
 8Xgw==
X-Gm-Message-State: AOJu0YzF8DJsE1uMSwI9/yEjNYfbVDeWEqr4nYWpC+/7jFEke97StgEG
 ORuUyVGGT1wdBOEQnzZClgNvibqbltAEZPLa8I+VHUHrmLLfL46CLK2rZvSJlax5Yph/fDY00zZ
 Bvw+SdqKW1PlX+ODDku71udgHG3z7mW9oUh/IFEZeKC/Jl3e6VwhRTpmD1Osw
X-Gm-Gg: ASbGnct+P08QCtr8Fd3ndXNJAhusa8pEULMefkgdd5jP81U7C4ntE+qzNeZuuIQy+CU
 NUJip/QhnWqQZ8mHuTAs9i4jRiJcynC5nDbe+yIijog7CEz+SKeL3UGXSlHo4rtM7G0Rzg4+szc
 +B/ffcUmm5LFYgZ1MPtZ+l7pIVYCXdbGyFcIkPWMxV/pG/ce8rvQ4LOApR7WIQv0DiwLOk84iNA
 AAn8Z8wpC/w/DMaR7LVsV792e0GhLMxdbHojPcA+fziAeHMdYU0W9j+76Ro9sz4eiqHkw==
X-Received: by 2002:a05:6e02:3e06:b0:3d0:4a82:3f40 with SMTP id
 e9e14a558f8ab-3d2cae69466mr137556635ab.7.1740424847673; 
 Mon, 24 Feb 2025 11:20:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGHV6Fz2kNEpIJPz3MRU+88jGzdo/fOdS1BSJJkEXylrm48H4NQQWBPxvkXJRKP9aaF3i9dw==
X-Received: by 2002:a05:6e02:3e06:b0:3d0:4a82:3f40 with SMTP id
 e9e14a558f8ab-3d2cae69466mr137556375ab.7.1740424847366; 
 Mon, 24 Feb 2025 11:20:47 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04744e8e9sm34177173.12.2025.02.24.11.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:20:46 -0800 (PST)
Date: Mon, 24 Feb 2025 14:20:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V2 28/45] vfio: return mr from vfio_get_xlat_addr
Message-ID: <Z7zGim2fayueJQRd@x1.local>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-29-git-send-email-steven.sistare@oracle.com>
 <Z69z6oTtaGOC287O@x1.local>
 <b6e19df6-cb38-4576-bdd0-6278997e402e@oracle.com>
 <Z6_G1rF7x2Nbzpl4@x1.local>
 <4f6ac09b-7a58-418f-9212-da12b8412b6e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f6ac09b-7a58-418f-9212-da12b8412b6e@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Feb 24, 2025 at 11:50:50AM -0500, Steven Sistare wrote:
> > > I can do that, but it would add cycles.  Is this considered a high performance
> > > path that may be called frequently?
> > 
> > AFAICT, any vIOMMU mapping isn't high perf path.  In this specific path,
> > the refcount op should be buried in any dma map operations..
> 
> memory_region_ref contains a comment that implies we should avoid taking a
> ref if possible:
>      * Memory regions without an owner are supposed to never go away;
>      * we do not ref/unref them because it slows down DMA sensibly.

That's for internal / permanent MRs that don't have an owner to speed
things up, and that should be orthogonal to this, as that'll automatically
take effect even if we use memory_region_[un]ref() here.

AFAIU we should always suggest using memory_region_[un]ref() in callers
when there's MR references.

I'm also ok without the boosted refcount, but then please document the RCU
implications on referencing the MR, and the MR reference must not be used
after rcu_read_unlock(), in that case.

Thanks,

-- 
Peter Xu


