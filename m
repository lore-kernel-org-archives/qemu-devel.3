Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABC7C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprUK-0002cy-3D; Thu, 28 Mar 2024 11:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rprUD-0002c6-Hr
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:16:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rprUB-0003L5-Ex
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711638970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dB6iKuO62vFonkQYCgk6muVpTHqtyzGQgWnmHKAu0LA=;
 b=W4E8EVOGRtpriPlLHL2xc7Z9vL0Eb4JYeDohWCppxGQcRnOIrEsq46HGy8TIgFCeVc5X+r
 pLvp6zIt7uI/wIYRTDTdrLdS/zR16Hat32FEC+17nYCDjjSiuTrs/AP67GJstHsYdb6ss/
 cNWLExx9oz711bcjHMEPZ9noQxHXues=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-3z5niuZpMS6pWR8yQMvz6g-1; Thu, 28 Mar 2024 11:16:08 -0400
X-MC-Unique: 3z5niuZpMS6pWR8yQMvz6g-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-690ab2b0de1so1856336d6.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711638968; x=1712243768;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dB6iKuO62vFonkQYCgk6muVpTHqtyzGQgWnmHKAu0LA=;
 b=Ksyz9GeU18jSkAdmxr6lfpgr/klV0zqKwDWGvPsvYIszEQBifFRmNt/bWh7OHPmKQT
 NnYY6geTPHUpfh4x++fssXQ+385WQgU+suG+o0J2IBu0i9Xomjf8oqP54G69IPQhUnDk
 WidO9RYRmWSHwWpdTrsz1m/DJt4gZHwWKEHFUcxOEdW/S9lIdwZbuMbWYfP5TUr6CgEI
 sSl9Qo4MdYH2zhJSQQyhQBmZMMoOVvqcpu8wC24CUs/i4vxeJCy4+mBAsthzxsPcchPl
 BWjCfO6QN7Xsl3ulVXJLQHnU9l7oGMS6CAluqitAzqpM6FR43mnjusBUyRobbyOn2TvQ
 qkJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZP+TTBjqLwseIw39Eq6W72VqxkF2lXFyahR6R3s1uQ7/+BfEHjsEe17nsJgT5CEXCo6asTCF452qvKJW1BpC0KGIJ7ZE=
X-Gm-Message-State: AOJu0YxYPf3FT1/XBi/aRmhzG/h9tsO2Z1AnUjwo6vhAkt1J0V7pUQ/9
 lXnFrl0cXOFiLpBH9qG66gdrMoCXjgKqtB1+AVy0N5yIRaDh3AiSUtMFqUJCw1Gow3wevMAnVrv
 M1a36EYa8rIQpiacPXoNqDW7rqqpO4HE8f0gBb5HCG7HQnE5E61XW
X-Received: by 2002:a05:6214:5ed1:b0:696:8a5e:33c6 with SMTP id
 mn17-20020a0562145ed100b006968a5e33c6mr2826625qvb.5.1711638968153; 
 Thu, 28 Mar 2024 08:16:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRGCFMvQ+RTOCSEic1tqvYICW9CjM66x8jfwXIa88jbNBfYgZBNCvw9oKqVyjBB/zTQ0+9lQ==
X-Received: by 2002:a05:6214:5ed1:b0:696:8a5e:33c6 with SMTP id
 mn17-20020a0562145ed100b006968a5e33c6mr2826574qvb.5.1711638967419; 
 Thu, 28 Mar 2024 08:16:07 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ks28-20020a056214311c00b0068f35e9e9a2sm730232qvb.8.2024.03.28.08.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:16:06 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:16:04 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>,
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: Re: [PATCH v5 5/7] migration/multifd: implement initialization of
 qpl compression
Message-ID: <ZgWJtFtbpXDvelvh@x1n>
References: <ZfsCDhnYYmjxLTRW@x1n>
 <PH7PR11MB5941F8AE52DBD0F197798103A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZftHtgpxOPNA8AYE@x1n>
 <PH7PR11MB5941186DCF12ED13130CBF5FA3322@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZfxSAgJECCOqtGRh@x1n>
 <PH7PR11MB594128C3B1C9ED66482DFEDEA3312@PH7PR11MB5941.namprd11.prod.outlook.com>
 <PH7PR11MB5941B5EB0C21FBFB6C8FFA16A3312@PH7PR11MB5941.namprd11.prod.outlook.com>
 <Zf20gJbSavpp93_b@x1n> <ZgRyxy3MhFp7PiH9@x1n>
 <PH7PR11MB59417CED1514B574523D6B1CA33B2@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR11MB59417CED1514B574523D6B1CA33B2@PH7PR11MB5941.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
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

On Thu, Mar 28, 2024 at 02:32:37AM +0000, Liu, Yuan1 wrote:
> > -----Original Message-----
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Thursday, March 28, 2024 3:26 AM
> > To: Liu, Yuan1 <yuan1.liu@intel.com>
> > Cc: Daniel P. Berrangé <berrange@redhat.com>; farosas@suse.de; qemu-
> > devel@nongnu.org; hao.xiang@bytedance.com; bryan.zhang@bytedance.com; Zou,
> > Nanhai <nanhai.zou@intel.com>
> > Subject: Re: [PATCH v5 5/7] migration/multifd: implement initialization of
> > qpl compression
> > 
> > On Fri, Mar 22, 2024 at 12:40:32PM -0400, Peter Xu wrote:
> > > > > void multifd_recv_zero_page_process(MultiFDRecvParams *p)
> > > > > {
> > > > >     for (int i = 0; i < p->zero_num; i++) {
> > > > >         void *page = p->host + p->zero[i];
> > > > >         if (!buffer_is_zero(page, p->page_size)) {
> > > > >             memset(page, 0, p->page_size);
> > > > >         }
> > > > >     }
> > > > > }
> > >
> > > It may not matter much (where I also see your below comments), but just
> > to
> > > mention another solution to avoid this read is that we can maintain
> > > RAMBlock->receivedmap for precopy (especially, multifd, afaiu multifd
> > > doesn't yet update this bitmap.. even if normal precopy does), then here
> > > instead of scanning every time, maybe we can do:
> > >
> > >   /*
> > >    * If it's the 1st time receiving it, no need to clear it as it must
> > be
> > >    * all zeros now.
> > >    */
> > >   if (bitmap_test(rb->receivedmap, page_offset)) {
> > >       memset(page, 0, ...);
> > >   } else {
> > >       bitmap_set(rb->receivedmap, page_offset);
> > >   }
> > >
> > > And we also always set the bit when !zero too.
> > >
> > > My rational is that it's unlikely a zero page if it's sent once or more,
> > > while OTOH for the 1st time we receive it, it must be a zero page, so no
> > > need to scan for the 1st round.
> > 
> > Thinking about this, I'm wondering whether we should have this regardless.
> > IIUC now multifd will always require two page faults on destination for
> > anonymous guest memories (I suppose shmem/hugetlb is fine as no zero page
> > in those worlds).  Even though it should be faster than DMA faults, it
> > still is unwanted.
> > 
> > I'll take a note myself as todo to do some measurements in the future
> > first.  However if anyone thinks that makes sense and want to have a look,
> > please say so.  It'll be more than welcomed.
> 
> Yes, I think this is a better improvement to avoid two page faults. I can test
> the performance impact of this change on SVM-capable devices and give some data
> later. As we saw before, the IOTLB flush occurs via COW, with the change, the 
> impact of the COW should be gone.
> 
> If you need more testing and analysis on this, please let me know

Nothing more than that.  Just a heads up that Xiang used to mention a test
case where Richard used to suggest dropping the zero check:

https://lore.kernel.org/r/CAAYibXib+TWnJpV22E=adncdBmwXJRqgRjJXK7X71J=bDfaxDg@mail.gmail.com

AFAIU this should be resolved if we have the bitmap maintained, but we can
double check.  IIUC that's exactly the case for an idle guest, in that case
it should be even faster to skip the memcmp when bit clear.

If you're going to post the patches, feel free to post that as a standalone
small series first, then that can be considered merge even earlier.

Thanks a lot for doing this.

-- 
Peter Xu


