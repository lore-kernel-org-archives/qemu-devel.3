Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1509BC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 18:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZxwl-0002B7-5O; Tue, 13 Feb 2024 13:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZxwj-0002Au-Og
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:55:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZxwi-0006ZX-3b
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707850555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hrpF7UZ8CmOpjLBsEhUrk4lcsnWjQ9Hs6YXrGC8JCc4=;
 b=HQqw90fo7mitYOB1gMs9R32Vxyhw2hc15gsz9q1QVIJTQmXq5I4sK1GKFosRHb/b6zHLQA
 oP9VYNpLWiX8SYLwAcgXqXQ7ctdGao8RC2ZsS9WtQWEmHwQCcAAkdoH5Ldn8Dcii3XXsGC
 maGXHtsBvC7KKc3I2kSkm85Xmq55Q28=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-fQ5j6mUyPPGFCsMVQDACtw-1; Tue, 13 Feb 2024 13:55:53 -0500
X-MC-Unique: fQ5j6mUyPPGFCsMVQDACtw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-411bff89ec8so4354315e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 10:55:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707850549; x=1708455349;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hrpF7UZ8CmOpjLBsEhUrk4lcsnWjQ9Hs6YXrGC8JCc4=;
 b=sXWLIAlEQeOC5JfRjpb9QnoJbMAceP5Sftq6xgfFXFhBPLTjuCxTGkxXZTXXmFgXK3
 URBLX9/i36h2WsO6IWdSz4om64+kW4nimqMbWp6Fe5Wm4rF2vSxmVmAmtGbsBK0mURvL
 bfSZoDllW/n//nXp4nJFkrfm5gsgZnrxhgvizcrYGZpiWOVut+pQu3xWc4oAc5+OQA5d
 Sds0agLXELVP/4w/8LKt+l+MTnjWfDaYUUO1nHjOT7HFdRtm6zyudwm1Z9ANd2oqqF8N
 CEW6n7i8SI3J0Vv7UX0A+ATF2YbERXYb4WkEMnFTKS460IsE46MiYkGPBu7VYukUt77E
 wWWg==
X-Gm-Message-State: AOJu0Yxs6FNYWyNVppFjSutooEBtLXJpXVNaRMky7uOkjBSGFvUBkHz3
 hUL45x8NHabfJxVkIk6AC1OnBCUybg1wURgesJMnI0q6pTs0IEkp5q348m4KDmYvPP347B8zcFF
 lwvJBTTJeNuuV39ysLzC0k8mYrmLtFFSiV8lTy9Zq1BQX5+z2H05M
X-Received: by 2002:a05:600c:b91:b0:411:c80f:3000 with SMTP id
 fl17-20020a05600c0b9100b00411c80f3000mr419211wmb.8.1707850549025; 
 Tue, 13 Feb 2024 10:55:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeEuxB1DnHzVoxutHRhmFFAxBTsGZtP/zMeiovmtl0hi2whlCZ62JADG/QESSYQIEeAVv4+g==
X-Received: by 2002:a05:600c:b91:b0:411:c80f:3000 with SMTP id
 fl17-20020a05600c0b9100b00411c80f3000mr419203wmb.8.1707850548696; 
 Tue, 13 Feb 2024 10:55:48 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVRDqim4iP2DhjbF3KUd0ciSSCKfJuSBKwAumOR+zauvFb8Gwr7WXB2TDzGRdu5gL6ixYacdn++Q0Y3w6Ei+QZySt+tR9E2/ayQyUhsCxe7BdyQyI/Gbb2XIWOA0ksWq9IOd0ToGxyb4OmPyBWVSjTUi5fmMCRITOkEUop8gLkIyTCOIgZlErzCtBBvfw4Ae3C424nUAr8vdhElm3ZR+w==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 f7-20020a05600c4e8700b00410709fa0d3sm12733800wmq.33.2024.02.13.10.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 10:55:47 -0800 (PST)
Date: Tue, 13 Feb 2024 13:55:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH v1 00/15] libvhost-user: support more memslots and
 cleanup memslot handling code
Message-ID: <20240213133708-mutt-send-email-mst@kernel.org>
References: <20240202215332.118728-1-david@redhat.com>
 <20240213123259-mutt-send-email-mst@kernel.org>
 <35a8c2e1-e20c-4d68-b7b7-0bd488bc3ac9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35a8c2e1-e20c-4d68-b7b7-0bd488bc3ac9@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

On Tue, Feb 13, 2024 at 07:27:44PM +0100, David Hildenbrand wrote:
> On 13.02.24 18:33, Michael S. Tsirkin wrote:
> > On Fri, Feb 02, 2024 at 10:53:17PM +0100, David Hildenbrand wrote:
> > > This series adds support for more memslots (509) to libvhost-user, to
> > > make it fully compatible with virtio-mem that uses up to 256 memslots
> > > accross all memory devices in "dynamic-memslot" mode (more details
> > > in patch #3).
> > 
> > 
> > Breaks build on some systems. E.g.
> > https://gitlab.com/mstredhat/qemu/-/jobs/6163591599
> > 
> > 
> 
> ./subprojects/libvhost-user/libvhost-user.c:369:27: error: comparison of
> integer expressions of different signedness: ‘long int’ and ‘unsigned int’
> [-Werror=sign-compare]
>   369 |     if (!ret && fs.f_type == HUGETLBFS_MAGIC) {
>       |                           ^~
> 
> So easy to fix in v2, thanks!


I think there is another problem around plugins though.


> -- 
> Cheers,
> 
> David / dhildenb


