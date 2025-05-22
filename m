Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328DEC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 13:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI5nv-0003Dc-Pz; Thu, 22 May 2025 09:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uI5nu-0003DT-H5
 for qemu-devel@nongnu.org; Thu, 22 May 2025 09:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uI5nq-000732-Ma
 for qemu-devel@nongnu.org; Thu, 22 May 2025 09:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747919857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HjmsqcAImOVDVgiMZ1NtBflrL9XyO0KmZJb6uSql8fw=;
 b=bmJpU+KmZgr0rPGAUMui+/QwEPiFkLG/RT/PBKKzHpz7dDqadV2Q7fgQZNSyKMf6zymErc
 mZT3vw4FeQPrB56y98EAhsoy4TGdp8szkd7YoPM/OEKvR3db8ThY3gxmx2KwNg9xlEnfNS
 6GPp++F+diqzKCHjAC85te+AUFg0Di0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-d6r9RITVO0OL972B2sY9RQ-1; Thu, 22 May 2025 09:16:06 -0400
X-MC-Unique: d6r9RITVO0OL972B2sY9RQ-1
X-Mimecast-MFC-AGG-ID: d6r9RITVO0OL972B2sY9RQ_1747919766
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c9305d29abso1445787885a.1
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 06:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747919766; x=1748524566;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjmsqcAImOVDVgiMZ1NtBflrL9XyO0KmZJb6uSql8fw=;
 b=ex5EUrPfyXw08FA3Hu1wLJ0Ze+NkQxBQR6X7Q/rcwvk/XKI18UQRI0Top16Hiw1bBt
 8K/g2knC/RY2NjHTDgeXnoIoWwsDAgOjXRXim52eBBfMLju23nDjdKJhuzMaQhbT4OfH
 3Jlb/f1mU0Zfkjz5XNPou6j6xL9CGl1Jogd4Oi9GTi19ycHSb5X0i7+8B1y9f5vt9beT
 /vGTxC22ebLRka5QO3a879CNgKKvhgfs64/JAu56+o+bzN+cGvWiUxjPbX1LJZKAQboe
 eLGg1iLVfnDLGlzo5XaLF/zPVG2zkoCc0rEl490JvJKGuSdcjkYBSx36tWBek+vYO/0x
 tORw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC/hFac3jVHvUtjoZFBkYNtVPPqXDmS/jCVjQOAAXDV+jlnxSroPhmPI4UYpnGKGpPX3WvrelK/Vt+@nongnu.org
X-Gm-Message-State: AOJu0YyqU9FGXQ2AYxWvJyttbicih+z9bJm3DN2Qe+tb6/HpugrxTefR
 QznqbnBq4/GyDZu25GZFYb34XGxlt/Ul+BJ/2M5IJyYAVWKh9jsKIjy2sW5X19i4LvO8p6RFMIN
 Y+7n3oPHJz5/qU2yBxlMmyuV6ndERFlt4o+dYFn6vbdGH8Q+2jslDEjpx
X-Gm-Gg: ASbGncspgiaZq8/grSPKqbUTaukCQC5SeObBKiMl2bqo9yW/kEjSWZqXiLIAZ00sYdL
 NW82vadE8HYsHJ3jQPlXAbMpNCWODhnMcX20qIY1uysIu7vhg2jvdnYLntFtLchNoCCh6iSwwEi
 X7bzT4lt6uIORURw7ocvd0gZ4sh4W66oKMKaNsuk7nuUVqIXBmyCsSfboowcTnZW8qhtzebHf5E
 TPJlO76Wp2K6SC9yKENx4YlCKPqk38K5KEjrSZz+vnOYl6KRT2uowgGwZHdMvNwMCEGpRkM6sXT
 JkA=
X-Received: by 2002:a05:620a:1a04:b0:7ca:dac1:a2b9 with SMTP id
 af79cd13be357-7cd467aa440mr3644504185a.50.1747919765979; 
 Thu, 22 May 2025 06:16:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOg2Ls7aaX2HD9Uq5W7/iL+W8FY/7BqBgdhHC23EIZ2zQTiPuTmAubTV+X8+voECdFfJAYeg==
X-Received: by 2002:a05:620a:1a04:b0:7ca:dac1:a2b9 with SMTP id
 af79cd13be357-7cd467aa440mr3644500285a.50.1747919765572; 
 Thu, 22 May 2025 06:16:05 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-494ae427eaesm100547251cf.41.2025.05.22.06.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 06:16:05 -0700 (PDT)
Date: Thu, 22 May 2025 09:16:03 -0400
From: Peter Xu <peterx@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 2/2] migration/hmp: Add "info migrate -a", reorg the
 dump
Message-ID: <aC8jkx-PnaJsuUB5@x1.local>
References: <20250514200137.581935-1-peterx@redhat.com>
 <20250514200137.581935-3-peterx@redhat.com>
 <26d8a22f-adfb-4990-8015-c24fd1304c8c@fujitsu.com>
 <aC3dJvwXK9eW1YO6@x1.local> <aC4_-nMc7FwsMf9p@gallifrey>
 <80ff85f3-1e75-43f9-aeff-99e5033e6090@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80ff85f3-1e75-43f9-aeff-99e5033e6090@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, May 22, 2025 at 12:55:05AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 22/05/2025 05:04, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> >> On Wed, May 21, 2025 at 08:43:37AM +0000, Zhijian Li (Fujitsu) wrote:
> >> [...]
> >>>> After this change, sample output (default, no "-a" specified):
> >>>>
> >>>>     Status: postcopy-active
> >>>>     Time (ms): total=40504, setup=14, down=145
> >>>>     RAM info:
> >>>>       Bandwidth (mbps): 6102.65
> >>>>       Sizes (KB): psize=4, total=16777992
> >>>>         transferred=37673019, remain=2136404,
> >>>>         precopy=3, multifd=26108780, postcopy=11563855
> >>>>       Pages: normal=9394288, zero=600672, rate_per_sec=185875
> >>>>       Others: dirty_syncs=3, dirty_pages_rate=278378, postcopy_req=4078
> >>>
> >>> (Feel free to ignore my comment if you have reached a consensus.)
> >>>
> >>> Putting multiple fields in one line is a true need for human reading?
> >>
> >> It definitely helps me but I agree that can be subjective.  So I'm happy to
> >> collect opinions.
> >>
> >> So my above layout was trying to leverage more on screens where width is
> >> bigger than the height (which is pretty much the default).
> > 
> > I think perhaps the problem with the on-one-line layout is that the grouping
> > is wrong;  grouping by unit probably doesn't make sense.
> > 
> > So it makes sense to me to have:
> >     Sizes: psize=4/KB
> >     Transfer: total=16777992 kB transferred=37673019 kB remain=11563855 kB
> >     Pages: normal=9394288 zero=600672
> >     Page rates: transferred=185875/s dirtied=278378/s
> >     Other: dirty_sync=3 postcopy_req=4078
> 
> 
> Oh, I vote this !!, more clear to me.

I followed up with Dave's idea, but then added all entries into it, below.

  Status: postcopy-active
  Time (ms): total=40504, setup=14, down=145
  RAM info:
    Throughput (Mbps): 6102.65
    Sizes (KiB):        pagesize=4, total=16777992
    Transfers (KiB):    transferred=37673019, remain=2136404
      Channels (KiB):   precopy=3, multifd=26108780, postcopy=11563855
      Page Types:       normal=9394288, zero=600672
    Page Rates (pps):   transfer_rate=185875, dirty_rate=278378
    Others:             dirty_syncs=3, postcopy_req=4078

Logically I should have moved "Throughput" out, because that should also
include all other things (non-ram iterators, device states).  But currently
it's an entry under info->ram.. so I kept it there.

It also has the "total" in "Sizes" to make the next line shorter
(meanwhile, "total" is also a constant size like "psize"), the hope is it's
still close enough to read when reading "Transfers" on the next line.

I also provided further indents to "Channels" and "Page Types" because they
should be taken as sub-class of "Transfer".

How is this?  Since we're at it, I can send a follow up patch after we
reach a consensus (I may also include that in another series where I'll
further add things into HMP; I'm looking at making blocktime to report page
latencies too).

-- 
Peter Xu


