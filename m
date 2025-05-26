Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A76EC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 15:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJZwD-00019a-5O; Mon, 26 May 2025 11:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uJZwA-00018o-LH
 for qemu-devel@nongnu.org; Mon, 26 May 2025 11:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uJZw8-0000Vw-RI
 for qemu-devel@nongnu.org; Mon, 26 May 2025 11:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748274022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D/wvTctol1P0mccm5ZAnlhxiLvJHfLYo8ZTV+OEL/fQ=;
 b=hQjMsWsJIofyvCEG3wuhrSjNxkwpQKgOvhVSIk1mBf+ONhyA53n31hfLbk3uhUdokzfsSt
 G61ANcgCQKgpx0wsgc/VCJs6MxasteABi6bgZutBa67FHrdR2NZVV0ASOs2Q84qhHvLRVL
 C220AQ/bsYOGmTX1zXzm+iLhBFG7uTY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-LssafCHPNu-9JHBPkuyC1Q-1; Mon, 26 May 2025 11:40:20 -0400
X-MC-Unique: LssafCHPNu-9JHBPkuyC1Q-1
X-Mimecast-MFC-AGG-ID: LssafCHPNu-9JHBPkuyC1Q_1748274020
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7caee988153so433391285a.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 08:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748274020; x=1748878820;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/wvTctol1P0mccm5ZAnlhxiLvJHfLYo8ZTV+OEL/fQ=;
 b=AG6227yhGdlvAjOQQcT4rcF1X7O1eH3R+SLZ/2pXg4h9nAXri1XLOatNNOpIzcxjAU
 XHO4pYaHZdRU84ku2u4OPK7gUM7ckC12y9tN4JA1w+30PlKwzrJxYwU791D3LAbY0KUG
 L/KGKyyLsFoUbwja+ZY0aA7G1RnddJarxFLUqWHSAozaBhyNLxqOpLpHPWZVMEYkEopk
 6I3oR+eoF1F53O8Lp5SUeaGTKqPMFfXuj46MGT9bCE8o3PsxGWzSmx/cqM3KOEFSBeln
 Ryin1aSeNCw1Z1cEhQ9P8+b/CKD5AXpxXKVYpfRfmxK6I7TdVMjIm/iODduz0htgqg2A
 fLLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7Sxc/HTuGR0YMgwAYsmcqDrtJ+BYLaxQVY0g985wcXVsqOTB2eWJS/+EHo9vwsyVoyhc+F/a8OamV@nongnu.org
X-Gm-Message-State: AOJu0Yyl2vQVCsEdJzmf0BVJ3+LeCNVN5AAJO0PI/F/kWxNJMilAm750
 EY4wVc+cf4RE/jkorNXzy9p7Ik68Tg6Tao6ihfwN4zxVW+8K7S3c5y/x4tcw8vSwdQGhp+GvA/O
 7vY388pKxcxL4Zzbdvk//78h0HkPTOHIokJIzoDpVi7E5mxOgzPDNXA51
X-Gm-Gg: ASbGncu2EX1W77XmeSsr7ibcRjLVAgYEm1LpS5O89EGZgV+7kCllT5Eeea10vKNrjGk
 Cu2sue+qWr45UfHYpPNX58FHcNjCKSA4jwtk5F7xVjiI1Mf/dFmD8xETTIYn6QswiUb14WW9FlD
 DBRKPLImS30HvQl2zyKglkyydFw9byfVh5cTJZiligD6JP4RBbDYs2JCN5nvbUmztNQei4r/n+2
 fFSijxCYhXLGUdwb+dSCMRnHKdLU3l56PYvRjju644NMGSMEvT5mosvIfRVXo7Ylk/2vgc6vUUs
 JUU=
X-Received: by 2002:a05:622a:124e:b0:494:abde:2aa3 with SMTP id
 d75a77b69052e-49f46a3b249mr191853891cf.18.1748274020274; 
 Mon, 26 May 2025 08:40:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkToBLRvFVmOI2AsL1NNaRBEigEZUItSTpZj86LK7bAvn7qc529Fo5gmd7NRcl53P/7fKs+g==
X-Received: by 2002:a05:622a:124e:b0:494:abde:2aa3 with SMTP id
 d75a77b69052e-49f46a3b249mr191853571cf.18.1748274019997; 
 Mon, 26 May 2025 08:40:19 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-494ae501e0fsm151233981cf.63.2025.05.26.08.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 08:40:19 -0700 (PDT)
Date: Mon, 26 May 2025 11:40:14 -0400
From: Peter Xu <peterx@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 2/2] migration/hmp: Add "info migrate -a", reorg the
 dump
Message-ID: <aDSLXqCAEor3YJE2@x1.local>
References: <20250514200137.581935-1-peterx@redhat.com>
 <20250514200137.581935-3-peterx@redhat.com>
 <26d8a22f-adfb-4990-8015-c24fd1304c8c@fujitsu.com>
 <aC3dJvwXK9eW1YO6@x1.local> <aC4_-nMc7FwsMf9p@gallifrey>
 <80ff85f3-1e75-43f9-aeff-99e5033e6090@fujitsu.com>
 <aC8jkx-PnaJsuUB5@x1.local>
 <7e3b7343-fbfc-43a4-a0c6-eb9c037da4d3@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e3b7343-fbfc-43a4-a0c6-eb9c037da4d3@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 23, 2025 at 02:06:42AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 22/05/2025 21:16, Peter Xu wrote:
> > I followed up with Dave's idea, but then added all entries into it, below.
> > 
> >    Status: postcopy-active
> >    Time (ms): total=40504, setup=14, down=145
> >    RAM info:
> >      Throughput (Mbps): 6102.65
> >      Sizes (KiB):        pagesize=4, total=16777992
> >      Transfers (KiB):    transferred=37673019, remain=2136404
> >        Channels (KiB):   precopy=3, multifd=26108780, postcopy=11563855
> >        Page Types:       normal=9394288, zero=600672
> >      Page Rates (pps):   transfer_rate=185875, dirty_rate=278378
> 
> 
> Regarding the "transfer_rate" and "dirty_rate" fields:
> Would it be clearer to drop the "_rate" suffix since the category header
> "Page Rates (pps)" already implies they are rate metrics?

I made it verbose to be clear while still suitable in a line.  I don't feel
strongly - I can drop them when proposing the patch, thanks.

-- 
Peter Xu


