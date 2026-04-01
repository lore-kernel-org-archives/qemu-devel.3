Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BAA10FCADC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w82JB-0003bD-4u; Wed, 01 Apr 2026 16:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82J8-0003au-RJ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82J6-0004Gh-0I
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775075814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xy13xOYzlk+QgqkWiMOoRU2qRITckbs194SuRber0NM=;
 b=ftXGmOQUxBoxayUkXJpm0q8Z8xBl6NctRZKnYt/wJCfKYpEe8uMvi3dU87KOw5Y9krqYjh
 3ugkag1cjBMsfO2r+2yeohxfFyp3XFGAMs8URmr/r7spCHP8eZQIITSikDBTIhd9ZGqYmw
 YYl83z0Xxov/QlkW9P1bYiXqZIOXcpg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-xzS5glzFNM-D7cH1KQqeXg-1; Wed, 01 Apr 2026 16:36:53 -0400
X-MC-Unique: xzS5glzFNM-D7cH1KQqeXg-1
X-Mimecast-MFC-AGG-ID: xzS5glzFNM-D7cH1KQqeXg_1775075813
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cfc5df1dccso60270885a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 13:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775075813; x=1775680613; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xy13xOYzlk+QgqkWiMOoRU2qRITckbs194SuRber0NM=;
 b=TJwnaweAwGLFJXGVmV7/24d6XC+yCaypZQJdVOOYJjAaMvC9POkIOdfpqtwp03jsB/
 6rBlODMjJCnKS47+n1zQL86xWRaUQPL7AVdbRU46MlJy/RUslIbaRwS5mY5mpnX9Xr6X
 dU42hiXuAybaMSeI4tyknuMQdGv37vI52aYCo3LSgXS6yrfFc29BN1Okgk3o2SCHgTf6
 ivuC1Fc3i7vZb7HodmdUgSgtsflskp6+vGkdor1T7q8daZshh+We+MOgwZ2eCDmJpAQR
 EKPIec0pWL9edgYA9BF1A3U5wASgBySrdwynjTNqP9TdufftvULDIY4TGcrFAHcchXL4
 vTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775075813; x=1775680613;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xy13xOYzlk+QgqkWiMOoRU2qRITckbs194SuRber0NM=;
 b=hZbtKEkYBfcQ6oOaxXw3l7ZgfSGwKkqgvod4QwbGj1yt/DgQrN7LJwyYNWd2edVAdP
 oNCizZcrU5TfMP5ZU0jOxjdESt5m5auWNy+vDYRrxXA5RnjotuklYVQ1fYhbB2SQOSpN
 6pN100qdPJYcG7NPziQ4QcTKdpTmabMNQ4ZJEDobzIXnzy/lLMlAnYSbBE9aXC3PHLH+
 PwWPUU+Tmh6zd6kkHI7ICE19sn5a7p8nIp1JvdVd0lin9Drv++B+MC/2goX2tYnAZfEv
 L3rp3oIABRNrJ0frFsYW7DPY5df3DGM+F+U5JE016b63Q7nYc80Nf1rSi9eprCuqcdRi
 vXeA==
X-Gm-Message-State: AOJu0YxMjP7Lb87Q5Sg1N/b6B+2tYfk0tCGhV6TjlLQEbvhzQGoI8mFr
 pLBCi6JuF37RR6Z80ZNEyTf7ANVeGy6s54imKNZtrcFZ87HXf8CkJoL5WCqPlX4qXTHPptw397i
 bUjEu8cMBvqwnrR1OQ+uTYYFPGZnG9B11jcSrd1Kkm1atdhVvmGIW1hDC
X-Gm-Gg: ATEYQzyf8dO8nvAaXgz2+x6y+lPVFa+zpvx2+IxhlH86pYbtbzFuNH+yQhHiD1kCjQU
 NxYdLdXYk3L2k4oalGTX9lfYmzCiKga3j7SxR8YM22jBGwamO52j9NzoCOGdja7l8ea2Z5z5B17
 c54ZmXpUH22YwohYCxyCJjbyyhW4QifI1MVQdKZirsntw6H2qu4jI0Od1dGnUIaB89jSbxlf9QK
 L39O9C5Cdg1/IHu7SbOsm5WuBn5matOeKulFcGjJeTAq6ftezAximcxPPJfAd+8vdS5CAEeOmOC
 wnjD20qbqmzZB6S2FWfaltNu9CdM/lcBd9weRxuxTL9eOx7VEk8NsrSvHZ8p7LRjt4NToWz681g
 RV/j6LFV6pHY4IKOoDbsoowscJLSxl9iZphUOnrGPtgbP+Q==
X-Received: by 2002:a05:620a:28c5:b0:8ce:5a30:9523 with SMTP id
 af79cd13be357-8d1b5a98f30mr742302685a.4.1775075807745; 
 Wed, 01 Apr 2026 13:36:47 -0700 (PDT)
X-Received: by 2002:a05:620a:28c5:b0:8ce:5a30:9523 with SMTP id
 af79cd13be357-8d1b5a98f30mr742297885a.4.1775075807192; 
 Wed, 01 Apr 2026 13:36:47 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a8740491sm60058685a.38.2026.04.01.13.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 13:36:46 -0700 (PDT)
Date: Wed, 1 Apr 2026 16:36:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH RFC 03/12] vfio/migration: Throttle vfio_save_block() on
 data size to read
Message-ID: <ac2B3VF8CSu3ytEE@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-4-peterx@redhat.com>
 <d075580a-ad4f-4047-b012-e5d9e4d6bc80@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d075580a-ad4f-4047-b012-e5d9e4d6bc80@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 25, 2026 at 04:10:14PM +0200, Avihai Horon wrote:
> Hi Peter,

Avihai,

> 
> Thanks for sending this series.

Thanks for taking a look.

> 
> On 3/20/2026 1:12 AM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > During precopy phase, VFIO maintains two counters for init/dirty data
> > tracking for query estimations.
> > 
> > VFIO fetches data during precopy by reading from the VFIO fd, after
> > fetching it'll deduct the read size.
> > 
> > Here since the fd's size can dynamically change, I think it means VFIO may
> > read more than what it "thought" were there for fetching.
> > 
> > I highly suspect it's also relevant to a weird case in the function of
> > vfio_update_estimated_pending_data(), where when VFIO reads 0 from the FD
> > it will _reset_ the two counters, instead of asserting both of them being
> > zeros, which looks pretty hackish.
> > 
> > Just guarantee it from userspace level that VFIO won't read more than what
> > it expects for now.
> 
> The VFIO_MIG_GET_PRECOPY_INFO ioctl returns an estimation of the data size
> currently available for reading. So, even if the ioctl returns X bytes, it
> may be that there are more than X bytes to read or less than X bytes.
> The code was written in a flexible way to handle such discrepancies.
> 
> Because we are dealing with an estimation, I don't think we can assert that
> the counters are zero, and I don't think reading only up to the cached size
> gives us any benefit:
> If the estimation is lower than actual available data, we are just deferring
> sending of the remaining data to a later stage.

Since we'll introduce cached size, having the read() only happen with the
size reported still makes sense to me.

We're not deferring to later that much, when dirty data reaches zero, we'll
re-sync with everything including VFIO's VFIO_MIG_GET_PRECOPY_INFO.  So
it's just splitting one last-phase read() into two smaller read()s.  To me,
it sounds still OK if with that we can make sure the counter won't overflow.

> If the estimation is higher than actual available data, we may still read()
> zero when the cached values are not zero.
> 
> I think we should keep the code as is.
> 
> Does that make sense?

I can understand what got reported in VFIO_MIG_GET_PRECOPY_INFO may not be
the total size of dirty data, but what the userapp can read.  That part is
fine.

Now, do you mean the size reported could shrink as well?  Could you explain
why, and when, dirtied data size can shrink?

Thanks,

-- 
Peter Xu


