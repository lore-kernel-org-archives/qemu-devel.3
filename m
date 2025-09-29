Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B81CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3EoD-0005BE-O6; Mon, 29 Sep 2025 10:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3EoA-00059h-Al
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3Enz-0004MG-EU
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759155869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OZ2F4N4ILzr4kOWx2vv/9FHTkPHFyLw47+8PMSyrxIM=;
 b=ZVq1i1aGLBr8mz2tuHbEIGBII5j8gCYOe/DswSSOT+GSgil0ZZdAbuyl515OhHEoyQIGRL
 v8h1A7ThCYR/s66M+8Iyeq8pDeeWlurXYWUr8KuoJv3iNeTxfZZREs3iyLZY3I2M8NlbC+
 n1AEk3t0Vk0J/pjuTBtOQywp4qHRfaU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-RF6fbuqdMtijpJS7iacGxA-1; Mon, 29 Sep 2025 10:24:26 -0400
X-MC-Unique: RF6fbuqdMtijpJS7iacGxA-1
X-Mimecast-MFC-AGG-ID: RF6fbuqdMtijpJS7iacGxA_1759155866
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4dfe8dafd18so63531141cf.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 07:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759155866; x=1759760666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZ2F4N4ILzr4kOWx2vv/9FHTkPHFyLw47+8PMSyrxIM=;
 b=c34ZmFOXb0TpVQ+afK+Yea/A6eZrNvHH40GnKmNH7k9c32zPveEOkhTjNTy4dw7Vlo
 gi1vzuTVcJQbhPSk64x5RgQ51JeBZe+yYrtUrwGR2mvjsfGgUyS3dNpBKZ2mjG66af3Q
 iPuUj5bkbA5/uuMX7ggJAAL0PYjmFEJ5XMiEW8tmqdt55HlgY0Bo0A85kDiLidc5Xt5e
 pUC4bxJ2J3zghYCZAv1p5l3FfdPbHIF1Y8p8bbuvaBQIOlH0kLu26hZxKiane2+mK5jo
 /qlSDBVHAIBuanHDTlWamVB9R00uTpztS8EERjDH1VVAQyK0BFgxidNtQ71s5kzBNbxw
 WAeA==
X-Gm-Message-State: AOJu0Yy5OSrPxozx/6QZZmZJ75QLJ4BQFeNbZkh+KPkqvPtRQnqP7Njc
 vY4PUuBHtDXN3szDWlXBW9H2tlVDYVmMi59a/mkISDKWwaX/dP1o0/oz6G+h3zV4AWVZvydN3fd
 5S8OlGvC9SpcBDCWcuXi+fALBp+/o9uJmDNhXKylzoXENmRQkRAgKyh4r
X-Gm-Gg: ASbGncvhafmIKGj31ZB1RwoowbMuqXuE7vz7g0UqzDHN7QLzI4DeAO57kXKsiStVAy6
 BxcDA/Imbe1O5vIIVEmCEB4JEdxE1RQQFT9XaLKIYnhufDRDTFZl+235UkIknhp4KXIbqJaaTxe
 yM8AJBCOECWr0Hxdk75nlmnS++h9J1G8rz7cmZLk02KRCUH9/uY2SNMc5+BcfIh5GTkdk1MuyZY
 TU+VvuoVzvvSw8iQ9kh8pQBM3xuFCgQIzz81U2HeoiTegRHtQqTnwAOv+Ut4dy2NdmtwNWzFqwJ
 yc7GjhYkELeoyfB0vUYvcOWlys8b18nj
X-Received: by 2002:ac8:7602:0:b0:4dc:d94f:d13f with SMTP id
 d75a77b69052e-4dcd94fd62cmr122579491cf.72.1759155865595; 
 Mon, 29 Sep 2025 07:24:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnaylEJZYHwInWh0i5jzLMAMihClV5W+3N1JvmTTu7oPpizAoz3C8FxUyEKO6fF6FgApZcxg==
X-Received: by 2002:ac8:7602:0:b0:4dc:d94f:d13f with SMTP id
 d75a77b69052e-4dcd94fd62cmr122579061cf.72.1759155864947; 
 Mon, 29 Sep 2025 07:24:24 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4db10875a51sm79069701cf.27.2025.09.29.07.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 07:24:24 -0700 (PDT)
Date: Mon, 29 Sep 2025 10:24:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH] migration: Use QAPI_CLONE() instead of duplicating it
 inline
Message-ID: <aNqWl8IOAvrXge6z@x1.local>
References: <20250929080115.98072-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250929080115.98072-1-guobin@linux.alibaba.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 29, 2025 at 04:01:15PM +0800, Bin Guo wrote:
> It's better to use QAPI_CLONE() in qmp_query_migrate_parameters so that
> the code is cleaner.
> 
> No functional changes intended.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>

Fabiano has this in an older patch:

https://lore.kernel.org/all/20250630195913.28033-12-farosas@suse.de/

Even though I don't remember why the subject said "QAPI_CLONE_MEMBERS"..

IIRC it has some dependency to convert tls entries first, likely patch 3 of
that series.  So the easiest is to wait him repost v3, then this will be
converted as part of the whole series.

Thanks for the patch.

-- 
Peter Xu


