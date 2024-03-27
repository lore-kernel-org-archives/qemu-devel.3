Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E1FC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 19:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpYub-00020E-VG; Wed, 27 Mar 2024 15:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpYuZ-0001zx-K7
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 15:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpYuV-00038y-JX
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 15:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711567565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ESGEeTau4tSlq/X+EvtiyXmaxofkZOShYxbsdyprEM=;
 b=emKYYaKtoI31/ar95rq34LQgr2JDT/BoZ8Dbr7ji5g1mETHgheACjmJgMXCT9LlJpa+ES/
 fIkF0DW5cV8Yk9lFVppOEqyAX2qe7ZTchn0CFxd/El7StYjXChOHP/zLu+BuRDG0qxrFq+
 Kcs1EF7fdFp+tA6/atNXgnzwfdSXBuc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-EBQOd2xvNsGeWEWgYnNQrA-1; Wed, 27 Mar 2024 15:26:04 -0400
X-MC-Unique: EBQOd2xvNsGeWEWgYnNQrA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-430c76df729so329081cf.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 12:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711567564; x=1712172364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ESGEeTau4tSlq/X+EvtiyXmaxofkZOShYxbsdyprEM=;
 b=P/LHnApfpkTklCCAdReChhaqorW2Vd7M6WcDes17DJEckERXyXNqmLPeDD552pphdv
 4G/4l3K/mLDme6oHBxqCAI8amYN//Tsz2gyu003CGfl64Brn7qjp3/uFwu1psOB5pAzv
 ktl8q6kTEkncumqgL8LEaWZS+Nb4cJoixEOvkSEWmozfs77BaoeE0l68eL2DI0KDP7q1
 Wo9Uc3FV9qn+PX1bfI7AEwuYTeoatIbpJi3paKqJ4B3EPP36Bxmo88M1Sw6+PBCF96pe
 zKNof9pKgaxfRNlygik/LvK+04jEpseZGgWGzDhXQ04rjjhNhxoa/c8fikGD4TOuetOR
 wQuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvqE8mrbEBboTNenwE/o/y7yZJfZ/GLdm80wj1DaL6dGXWXCrvMrf57PpH25KhwxucH3w7bMe5G6zASy1WG/3sWuyEyWc=
X-Gm-Message-State: AOJu0Yyf6zmnZKSt2OwROUmBVpr9AqZwP2QYp5NL/TU2YG7x7MdlTyuI
 pdxsiZOvPnHans1qYaupRoOg/YEb0/qsLt2AeyDg4E1E3CMCNz/9YYpo+F1K/VIuWTM0/JXjRLG
 O3oKJrWiQRsHg6wZXO98XOQW7zyPdqf/orvsNpkH0rGjs/2ZPDGrN
X-Received: by 2002:a05:622a:174a:b0:430:d201:c0ca with SMTP id
 l10-20020a05622a174a00b00430d201c0camr635632qtk.5.1711567563553; 
 Wed, 27 Mar 2024 12:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7q7PJno9a3sTR6Ux9tMTrBcOPR8HTM0+AM1/pMeuNdZhTQP2HmwlNx2mbyP1wP8feVEkSwA==
X-Received: by 2002:a05:622a:174a:b0:430:d201:c0ca with SMTP id
 l10-20020a05622a174a00b00430d201c0camr635607qtk.5.1711567562932; 
 Wed, 27 Mar 2024 12:26:02 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 w13-20020ac8718d000000b00430bcec5432sm5052873qto.85.2024.03.27.12.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 12:26:02 -0700 (PDT)
Date: Wed, 27 Mar 2024 15:25:59 -0400
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
Message-ID: <ZgRyxy3MhFp7PiH9@x1n>
References: <Zfq9lBXZWcy3Alhw@redhat.com>
 <PH7PR11MB59410E02C6C7CECD7E30AA4FA3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZfsCDhnYYmjxLTRW@x1n>
 <PH7PR11MB5941F8AE52DBD0F197798103A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZftHtgpxOPNA8AYE@x1n>
 <PH7PR11MB5941186DCF12ED13130CBF5FA3322@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZfxSAgJECCOqtGRh@x1n>
 <PH7PR11MB594128C3B1C9ED66482DFEDEA3312@PH7PR11MB5941.namprd11.prod.outlook.com>
 <PH7PR11MB5941B5EB0C21FBFB6C8FFA16A3312@PH7PR11MB5941.namprd11.prod.outlook.com>
 <Zf20gJbSavpp93_b@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zf20gJbSavpp93_b@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Mar 22, 2024 at 12:40:32PM -0400, Peter Xu wrote:
> > > void multifd_recv_zero_page_process(MultiFDRecvParams *p)
> > > {
> > >     for (int i = 0; i < p->zero_num; i++) {
> > >         void *page = p->host + p->zero[i];
> > >         if (!buffer_is_zero(page, p->page_size)) {
> > >             memset(page, 0, p->page_size);
> > >         }
> > >     }
> > > }
> 
> It may not matter much (where I also see your below comments), but just to
> mention another solution to avoid this read is that we can maintain
> RAMBlock->receivedmap for precopy (especially, multifd, afaiu multifd
> doesn't yet update this bitmap.. even if normal precopy does), then here
> instead of scanning every time, maybe we can do:
> 
>   /*
>    * If it's the 1st time receiving it, no need to clear it as it must be
>    * all zeros now.
>    */
>   if (bitmap_test(rb->receivedmap, page_offset)) {
>       memset(page, 0, ...);
>   } else {
>       bitmap_set(rb->receivedmap, page_offset);
>   }
> 
> And we also always set the bit when !zero too.
>     
> My rational is that it's unlikely a zero page if it's sent once or more,
> while OTOH for the 1st time we receive it, it must be a zero page, so no
> need to scan for the 1st round.

Thinking about this, I'm wondering whether we should have this regardless.
IIUC now multifd will always require two page faults on destination for
anonymous guest memories (I suppose shmem/hugetlb is fine as no zero page
in those worlds).  Even though it should be faster than DMA faults, it
still is unwanted.

I'll take a note myself as todo to do some measurements in the future
first.  However if anyone thinks that makes sense and want to have a look,
please say so.  It'll be more than welcomed.

Thanks,

-- 
Peter Xu


