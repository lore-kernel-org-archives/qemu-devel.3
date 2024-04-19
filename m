Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1AAC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 15:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqDC-0001XN-Pm; Fri, 19 Apr 2024 11:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rxqD9-0001X8-22
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rxqD7-0004Si-1U
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713540691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QvQCmJr4VihjMsFRWNDnuzneUalAY6ReyeNB66XBwno=;
 b=PaPmGqMKT/uS/mqjhZLAGfVxOMP26fpFpC3vkkTxy2GhCjI9EiNWNRPAIiQdFB8D/QhF24
 zRY6MVsBXQcrWpVpsEN+ShQrb0qDTM1zVjJRDB1RJFM0FBQ08ls40V37QtlZneZx851+yD
 ZiN7yqPTeeiDXNw7j5VvkLaZbFkGYuM=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-3ediVc-zMgiT7jx6cMbb9A-1; Fri, 19 Apr 2024 11:31:29 -0400
X-MC-Unique: 3ediVc-zMgiT7jx6cMbb9A-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5acdbf9d0c5so779503eaf.2
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713540689; x=1714145489;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QvQCmJr4VihjMsFRWNDnuzneUalAY6ReyeNB66XBwno=;
 b=F7ceA2IkzxtxcFGgMoRN6iQJIx08g8nXvAbsxY1pPMGV9tRqudW/sqeSS0mAoSvF04
 +Xvn+RAdwB1moyPbjd95DXze6zjqxHMuRvcJvU0mEGq+FYzReVJ1ouAwzH7zsxP2Wv+U
 Udq+picW1eJK9SJf4VBAfk3+TLgfILWOTgHb8PvFoEV1mRKzoASZe58WCWR7eOa4GwXW
 2j7Ar8y+iikjrDZUY6hqlho7+Cs3Y9d7NF75eRAgYEr+RzdUzoBlUHwFiNA8JAzOz4RV
 aAz8FruQ8vTgPUnexY0XGtCJg7OzolRfqY0jnV9RYYuWH+jtgXE6P49sgGEhJccPCNl+
 IcFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ8q1+m+WyFOW7mSkq6DuLgl61sKB7npmOULR21GufYMm1EEAVKp7LXPjKyOK2K5iUUgoHeC36L56D3SKwNUvRnWkuOpI=
X-Gm-Message-State: AOJu0Yy2s0GXhkD2pvATY/lzUgTDdmLcXAex62a8VW7QggI2qPYPAjr9
 esN2jTiXNc9J6HKS3bd1IA75HF37rJyYsp+cHQ4n722ToHXiIU1aFnxbU0Nf6QHQNaNw5fvz5F6
 ginKwk1UV/um9/Yhd95Oxc3fO/BLuDp18u+/sjofJfe7Dg++LXWMS
X-Received: by 2002:a05:6870:8988:b0:229:ee6d:77da with SMTP id
 f8-20020a056870898800b00229ee6d77damr2865788oaq.2.1713540688777; 
 Fri, 19 Apr 2024 08:31:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHoM32po19uD/TrrdRtyjRunKRKw8ENuwP4JTbG0nNF4w+x87AcrI9onM1Ew7TQrn8RWYXGQ==
X-Received: by 2002:a05:6870:8988:b0:229:ee6d:77da with SMTP id
 f8-20020a056870898800b00229ee6d77damr2865740oaq.2.1713540688271; 
 Fri, 19 Apr 2024 08:31:28 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 y22-20020a05620a0e1600b0078ec71866f7sm1667171qkm.58.2024.04.19.08.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:31:28 -0700 (PDT)
Date: Fri, 19 Apr 2024 11:31:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 00/26] =?utf-8?Q?Multifd_?= =?utf-8?B?8J+UgA==?=
 device state transfer support with VFIO consumer
Message-ID: <ZiKOTkgEIKo-wj5N@x1n>
References: <cover.1713269378.git.maciej.szmigiero@oracle.com>
 <Zh-KF72Fe9oV6tfT@redhat.com>
 <c0b1dbb1-d353-4832-af90-96895b2129fc@maciej.szmigiero.name>
 <Zh_6W8u3H4FmGS49@redhat.com>
 <71ede5c8-857c-418b-9e37-b8d343ddfa06@maciej.szmigiero.name>
 <ZiD4aLSre6qubuHr@redhat.com>
 <aebcd78e-b8b6-44db-b2be-0bbd5acccf3f@maciej.szmigiero.name>
 <ZiF8aWVfW7kPuOtn@x1n> <ZiJCSZvsekaO8dzO@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiJCSZvsekaO8dzO@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 19, 2024 at 11:07:21AM +0100, Daniel P. Berrangé wrote:
> On Thu, Apr 18, 2024 at 04:02:49PM -0400, Peter Xu wrote:
> > On Thu, Apr 18, 2024 at 08:14:15PM +0200, Maciej S. Szmigiero wrote:
> > > I think one of the reasons for these results is that mixed (RAM + device
> > > state) multifd channels participate in the RAM sync process
> > > (MULTIFD_FLAG_SYNC) whereas device state dedicated channels don't.
> > 
> > Firstly, I'm wondering whether we can have better names for these new
> > hooks.  Currently (only comment on the async* stuff):
> > 
> >   - complete_precopy_async
> >   - complete_precopy
> >   - complete_precopy_async_wait
> > 
> > But perhaps better:
> > 
> >   - complete_precopy_begin
> >   - complete_precopy
> >   - complete_precopy_end
> > 
> > ?
> > 
> > As I don't see why the device must do something with async in such hook.
> > To me it's more like you're splitting one process into multiple, then
> > begin/end sounds more generic.
> > 
> > Then, if with that in mind, IIUC we can already split ram_save_complete()
> > into >1 phases too. For example, I would be curious whether the performance
> > will go back to normal if we offloading multifd_send_sync_main() into the
> > complete_precopy_end(), because we really only need one shot of that, and I
> > am quite surprised it already greatly affects VFIO dumping its own things.
> > 
> > I would even ask one step further as what Dan was asking: have you thought
> > about dumping VFIO states via multifd even during iterations?  Would that
> > help even more than this series (which IIUC only helps during the blackout
> > phase)?
> 
> To dump during RAM iteration, the VFIO device will need to have
> dirty tracking and iterate on its state, because the guest CPUs
> will still be running potentially changing VFIO state. That seems
> impractical in the general case.

We already do such interations in vfio_save_iterate()?

My understanding is the recent VFIO work is based on the fact that the VFIO
device can track device state changes more or less (besides being able to
save/load full states).  E.g. I still remember in our QE tests some old
devices report much more dirty pages than expected during the iterations
when we were looking into such issue that a huge amount of dirty pages
reported.  But newer models seem to have fixed that and report much less.

That issue was about GPU not NICs, though, and IIUC a major portion of such
tracking used to be for GPU vRAMs.  So maybe I was mixing up these, and
maybe they work differently.

Thanks,

-- 
Peter Xu


