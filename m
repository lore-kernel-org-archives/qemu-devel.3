Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22832C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 17:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFG4r-00081N-U9; Wed, 14 May 2025 13:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFG3W-0006FW-94
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFG3T-0003ZP-GE
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747244284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A7dgFPquZzfHYR2FZ0ZwBIpCNC1/E45uftUDmnHsywg=;
 b=PBQPoWYgwXCK0h6nzm7Zii4Srk5Ksj4HIhhSwyFmpqosXVUMIr3BolK77PFuGjLy3rg/RU
 KM8DznXoclDafZInj573lZx2mD4SiX8T4DxOJb8RRn32jQVlh8Uxp7YHlFICpZ7GhD74u3
 0HqBjNiZ/AG0HbALpE7eTEDleoGkPDM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-iMZpREAEPyKRjRBddVHkKQ-1; Wed, 14 May 2025 13:38:02 -0400
X-MC-Unique: iMZpREAEPyKRjRBddVHkKQ-1
X-Mimecast-MFC-AGG-ID: iMZpREAEPyKRjRBddVHkKQ_1747244282
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7caee988153so794785a.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 10:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747244282; x=1747849082;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A7dgFPquZzfHYR2FZ0ZwBIpCNC1/E45uftUDmnHsywg=;
 b=vA0Lhv7vzYIj6ZihuUXhXl9QL3j8Wbh78TqkIg7w1t3rPnf2ZOOnlXWsHmuAoX5bGW
 X2Yohv5UjsU/ktAhN94uu70Uol2anhsjsOysQ6vGv8l0nSPI9/Cwn7he5QrBCUXQyxIo
 uwfBFKqZ89/K+4fVLKfvlhU3JXHepor5tBubmIpR3/FHn2Yh7rfdoaY+FljhgNitE1AX
 QqwM08JcZxzLyqVzziWp2psBHvTkCbSp1i/8bJe+JwqvZ10WelSbjkO9eZ4AFNmWV7Fu
 G0QxWGbOHDyaTgFdAXhU6IYP5kOIYpYsXMMM8K6PrbeFa5B0zPmnaLhDmQJjKuWQqIAE
 0sbw==
X-Gm-Message-State: AOJu0YxuMfXhwePodjO2hUXGGJhPZkTVSRn0y+DKRThkJXFRty7zsmGx
 +0RUDy6I8BpTgGTRV63IdCGZ94ncRIoRvqxQ9Zsp8qMCehsYf3zrgPzmys8G+Xwn/RhSvzSDU6i
 I0VCjVBOOUfH8jTlfi9Z91GjsJsWVI7E2rEdXTccsH/OUskWJ3Ok0
X-Gm-Gg: ASbGncvUQ8O7R6hPvunSL7T6uCnL0D7lWKz6BH1OdyV/JYohwWPk6cFA15rn6j36YK2
 dM32/zKkJIfXi6UaJ7rKLDrBFMOVOiV7teKlID1qYcZXTHbqaBsyzv/Ld0Xg1p1XsLVb7oAM6b8
 EvRVnNiq+qnkU1oFybBvBhYxuatTJctLZZj2iZonejNMkPhzAyC0MldgpSP9fKfWdtPy3v2GPru
 EUXzHitVYK6qnULeYfo4yGqns7CXOtpTcq+sNfjWt0d3+6peBw1UKm7u7J72lyS0R+qw+gyVaw3
 BJ8=
X-Received: by 2002:a05:620a:26a1:b0:7c5:ccc0:2382 with SMTP id
 af79cd13be357-7cd2885d28bmr627464885a.52.1747244281881; 
 Wed, 14 May 2025 10:38:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQXCiAg97NAo4vteZMIwgtFE3HWgXYpZ9YBM27LVxompj3HgMAbDF8ZQMtUlrhu4OfOSQiHw==
X-Received: by 2002:a05:620a:26a1:b0:7c5:ccc0:2382 with SMTP id
 af79cd13be357-7cd2885d28bmr627462085a.52.1747244281569; 
 Wed, 14 May 2025 10:38:01 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd00f4d54fsm874866285a.14.2025.05.14.10.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 10:38:00 -0700 (PDT)
Date: Wed, 14 May 2025 13:37:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <ppandit@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 3/3] migration/hmp: Add "info migrate -a", reorg the dump
Message-ID: <aCTU9aFgbt4-ZbYz@x1.local>
References: <20250513220923.518025-1-peterx@redhat.com>
 <20250513220923.518025-4-peterx@redhat.com>
 <lu4vgrxl2b5kgg5jdfnucqfvu2wh3rudhya5jarw2auyh62mge@onoeum25ttzm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <lu4vgrxl2b5kgg5jdfnucqfvu2wh3rudhya5jarw2auyh62mge@onoeum25ttzm>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On Wed, May 14, 2025 at 04:33:16PM +0200, Juraj Marcin wrote:
> >      if (info->ram) {
> > -        monitor_printf(mon, "transferred ram: %" PRIu64 " kbytes\n",
> > -                       info->ram->transferred >> 10);
> > -        monitor_printf(mon, "throughput: %0.2f mbps\n",
> > +        monitor_printf(mon, "RAM info:\n");
> > +        monitor_printf(mon, "  Bandwidth (mbps): %0.2f\n",
> >                         info->ram->mbps);
> 
> I think the previous name (throughput) was better suited for this
> metric. IIUC '->mbps' is the actual amount of data that has been sent
> over a period of time, which is exactly the definition of throughput.
> Bandwidth, on the other hand, is more of a (theoretical) maximum that
> could be sent.

Heh, it's interesting you found this change, I should have mentioned it.

I think I saw more use of the word "bandwidth" from people to describe
miration throughput, but I don't think I was able to distinguish the two
before, after checking I think you're right.

I believe you demostrated solid understanding in networking issues. :-D

I'll use "Throughput" when repost. Thanks!

-- 
Peter Xu


