Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194FAC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmxxm-0002uw-Pc; Wed, 20 Mar 2024 11:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmxxl-0002un-S4
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmxxk-0003o8-GR
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710948883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ReL5L+eVKFIx/m4v1FLnhf7YTGHpcTVfr7E4ESZAUg=;
 b=UR0PCG8a7oWdvez55ZrB4ak7X9VyX4axhEPSajvweYPhqgKmtxCeoyj8QJAt5M0f50ebpu
 f4cCO/HYaT1Fm6KJNy/TMgLT/0z+t6ZwWj5odk3CgITz14dxE5ua4Tv92x2QoCuU4eKsB9
 BZmn/xx19hFiTEtoH7ueoI5HOh7EnHc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-chwe2zlpN0GNRT2gRfDZIg-1; Wed, 20 Mar 2024 11:34:42 -0400
X-MC-Unique: chwe2zlpN0GNRT2gRfDZIg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-789ef1b84a7so61285a.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 08:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710948881; x=1711553681;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ReL5L+eVKFIx/m4v1FLnhf7YTGHpcTVfr7E4ESZAUg=;
 b=wkUwrds5jylHb7IgB7qy3523T1O1cITlm2I6MIIkoPfUaa1Exufo22RjwnwZedwsLm
 aIMQHyVc+cdzvP+nhvWp3PQdE33d/K0Gs+f3ER0cfTRHwdIvU4Cbap4RGz0W8QUxG4tT
 Fss7Mzh4A7i54EpSSBHCfkgJViMRq3OpfCTc60wZmUhE9e6UqHkHAn+HocGTwHArH84K
 iXKRKW5NBoNeMI2+uzVwGaxE8P7IOILiM7pHJLHnDWPp1UgZd+F2ZlKwOKDHIdjFHQQU
 CKmCCDepsSWjwUUO3wSGbnaLoScPBTdhpWnPTyzo6wWLkimf1lbIa1PIN4t72ty5aQ3X
 EyUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP4nQAkaKwnc2jwpOATyZh3Y2zN3WXCbKp0wiylvKdXAYm8cDyEYrND9kKhmjYt0DbzETQexrNY0DhTnkXkNmKRACUBAU=
X-Gm-Message-State: AOJu0Yzeb33i7by/Qof9cafTY1CEmxBfpStD2bIC9MljHq5CJMLAukK+
 97UoKKXwzjfpTQxDIGC6HyPmdUvRQ9PHTzyDTto0hYKF0L4Np+T9HpP+AFNSlrIzTmV6q9VpKWN
 lsRr8hGTfCOpaU2QcSrLqUepGyn+w/Rzu0OwCHMOzbsuEyovDNjkr
X-Received: by 2002:a05:620a:450e:b0:789:db16:b67b with SMTP id
 t14-20020a05620a450e00b00789db16b67bmr20161915qkp.1.1710948881505; 
 Wed, 20 Mar 2024 08:34:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvXt3fEMHd3BWSpBobZlfmndPCjJtTMnxh2tawaHmWm2MVpecqyChMCoCIVJLW/yHRSIM8iQ==
X-Received: by 2002:a05:620a:450e:b0:789:db16:b67b with SMTP id
 t14-20020a05620a450e00b00789db16b67bmr20161874qkp.1.1710948880893; 
 Wed, 20 Mar 2024 08:34:40 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 g9-20020a05620a13c900b00789ed758a1bsm4313500qkl.69.2024.03.20.08.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 08:34:40 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:34:38 -0400
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
Message-ID: <ZfsCDhnYYmjxLTRW@x1n>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-6-yuan1.liu@intel.com>
 <Zfq9lBXZWcy3Alhw@redhat.com>
 <PH7PR11MB59410E02C6C7CECD7E30AA4FA3332@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR11MB59410E02C6C7CECD7E30AA4FA3332@PH7PR11MB5941.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
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

On Wed, Mar 20, 2024 at 03:02:59PM +0000, Liu, Yuan1 wrote:
> > > +static int alloc_zbuf(QplData *qpl, uint8_t chan_id, Error **errp)
> > > +{
> > > +    int flags = MAP_PRIVATE | MAP_POPULATE | MAP_ANONYMOUS;
> > > +    uint32_t size = qpl->job_num * qpl->data_size;
> > > +    uint8_t *buf;
> > > +
> > > +    buf = (uint8_t *) mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -
> > 1, 0);
> > > +    if (buf == MAP_FAILED) {
> > > +        error_setg(errp, "multifd: %u: alloc_zbuf failed, job num %u,
> > size %u",
> > > +                   chan_id, qpl->job_num, qpl->data_size);
> > > +        return -1;
> > > +    }
> > 
> > What's the reason for using mmap here, rather than a normal
> > malloc ?
> 
> I want to populate the memory accessed by the IAA device in the initialization
> phase, and then avoid initiating I/O page faults through the IAA device during
> migration, a large number of I/O page faults are not good for performance. 

mmap() doesn't populate pages, unless with MAP_POPULATE.  And even with
that it shouldn't be guaranteed, as the populate phase should ignore all
errors.

       MAP_POPULATE (since Linux 2.5.46)
              Populate (prefault) page tables for a mapping.  For a file  map‐
              ping, this causes read-ahead on the file.  This will help to re‐
              duce  blocking  on  page  faults later.  The mmap() call doesn't
              fail if the mapping cannot be populated  (for  example,  due  to
              limitations  on  the  number  of  mapped  huge  pages when using
              MAP_HUGETLB).  Support for MAP_POPULATE in conjunction with pri‐
              vate mappings was added in Linux 2.6.23.

OTOH, I think g_malloc0() should guarantee to prefault everything in as
long as the call returned (even though they can be swapped out later, but
that applies to all cases anyway).

> 
> This problem also occurs at the destination, therefore, I recommend that
> customers need to add -mem-prealloc for destination boot parameters.

I'm not sure what issue you hit when testing it, but -mem-prealloc flag
should only control the guest memory backends not the buffers that QEMU
internally use, afaiu.

Thanks,

-- 
Peter Xu


