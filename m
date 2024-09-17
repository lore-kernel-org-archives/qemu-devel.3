Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448DDCAC587
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 15:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqaVl-00071E-5M; Tue, 17 Sep 2024 11:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqaVg-0006xZ-Un
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 11:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqaVf-0002Ic-CD
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 11:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726588377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iA1EUXwBAYzvoMokKyNYWpGJo7W4f1UyHkXRdM7En/A=;
 b=i0VzSxaBbm4s2djvXzcssN9piejM4+LwcfeLQw3ySql88uIIS2ljuYRV9FyOddibgGdVDY
 N6c3ZoqWqaO5Qe24W2XfSwfQnAOqz90Xcz9BZlSjeisdXhykcqhopA9B6VjeqJZdXKgsM8
 M/z6pDQAqmTqPDNmTyUdGbbczo8TgZY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-7sOqV8kwNl-U9YpzUGSyLQ-1; Tue, 17 Sep 2024 11:52:56 -0400
X-MC-Unique: 7sOqV8kwNl-U9YpzUGSyLQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6c517e32a97so4570876d6.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 08:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726588375; x=1727193175;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iA1EUXwBAYzvoMokKyNYWpGJo7W4f1UyHkXRdM7En/A=;
 b=NWRHWXAbLIHOxEzSwpctPSzWMul/FOt67DBfoN4SuR8oInoegSILkeJFlVh/BhWWYx
 EzWhqMDhkHwhk5+ujAoTTGFS/t7cvMlOyxXP2BKDRuHxTCT51VA3nYD0+FTer7Mjgq4J
 nCO9GcmQP7JgaEqr6ccMl0DDRvZgO/ClP71VVVEbPstI1JOu5TvdiahpnB+m5XzpqhBd
 gLkqj4SZ8tK1Sj5BRWInpQcIvUuhbF0M66t56BnRFpzXVLInaAsF+ub1MEK/w8noBiCi
 mpXN8fQwDU8uu7zyX7dwMF8m/6+XUHSB8EdKtLNGeWTFdj5pZ/xwhEAHBqyLYQHniGNg
 NfjQ==
X-Gm-Message-State: AOJu0YwYmQNUevl0ZGPPdPzbdM5QpQKmkhQEXP5PcxlGOMwJUJzTqR1I
 O6/lxEOTxCZqvu6iIym57y+3a78b7sSr1Ms86M7CxlgeV7UoFjx34afZMWONyXaubUkE3fLdyPc
 9CvGtJsxepq3zO//wVsci6KoNaEgnI1WHu5zZQsLkaP6xT+zyUEC2
X-Received: by 2002:a05:6214:2f93:b0:6c5:9bc6:8962 with SMTP id
 6a1803df08f44-6c59bc68c4bmr158994236d6.30.1726588375576; 
 Tue, 17 Sep 2024 08:52:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjOyLQ30aCfJEoJyE/zQVMaaXBWg2v+gnAAH1B/FjdbYEDXHAaS2osRvYYy8L4zk2CLPPOww==
X-Received: by 2002:a05:6214:2f93:b0:6c5:9bc6:8962 with SMTP id
 6a1803df08f44-6c59bc68c4bmr158993886d6.30.1726588375140; 
 Tue, 17 Sep 2024 08:52:55 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c58c691ad9sm35544896d6.77.2024.09.17.08.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 08:52:54 -0700 (PDT)
Date: Tue, 17 Sep 2024 11:52:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>, Zhiyi Guo <zhguo@redhat.com>
Subject: Re: [PATCH v3 1/4] KVM: Dynamic sized kvm memslots array
Message-ID: <Zuml03p5y5ip6e7e@x1n>
References: <20240909145413.3748429-1-peterx@redhat.com>
 <20240909145413.3748429-2-peterx@redhat.com>
 <871q1j1of1.fsf@suse.de> <87y13rzdtn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y13rzdtn.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 16, 2024 at 02:52:04PM -0300, Fabiano Rosas wrote:
> >>  
> >> +    /*
> >> +     * A VM will at least require a few memslots to work, or it can even
> >> +     * fail to boot.  Make sure the supported value is always at least
> >> +     * larger than what we will initially allocate.
> >
> > The commit message says 16 was chosen to cover basic usage, which is
> > fine. But here we're disallowing anything smaller. Shouldn't QEMU always
> > respect what KVM decided? Of course, setting aside bugs or other
> > scenarios that could result in the ioctl returning 0. Could some kernel
> > implementation at some point want to reduce the max number of memslots
> > and then get effectively denied because QEMU thinks otherwise?

I'd say it's unlikely to happen, but indeed failing it here might be based
too much over the artificial KVM_MEMSLOTS_NR_ALLOC_DEFAULT I came up with.

If this check is removed, I suppose we're still fine.  So it means later
when qemu initializes kvm memslots here:

    kvm_slots_grow(kml, KVM_MEMSLOTS_NR_ALLOC_DEFAULT);

It'll be throttled by whatever kvm specified lower than 16. Then if
memslots are not enough, we'll fail at memslot allocation whenever
requested more than what kvm offers:

    fprintf(stderr, "%s: no free slot available\n", __func__);
    abort();

Yeah, maybe it is better to fail here.. Even though I think we'll never use
it, but still good to remove some lines if they're not needed.  Let me
remove this check in my next post.

Thanks,

-- 
Peter Xu


