Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48EED17138
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 21:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2znD-0005eA-EP; Mon, 21 Oct 2024 17:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2znB-0005ds-D0
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 17:18:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2zn9-0002eD-Gk
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 17:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729545498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N6KOQk46edGaDkUkqBKsjSvUWMbHio0dwFaaVPJeLqA=;
 b=LNEEwP6nbpN93x167kyLAcyTGfxYkmAaizRM8iMcBO7/ThMPWhihmG5P46kabvYQDBHmDy
 eFeBrlYg2aWquxh4T2JedNLHNIo7e9zxB/KBtWsTO3/27JO6eQJvWDE+tv2c/zk1q/zZk9
 ihhUVseMI4Z29b+qs1RxG5UgCfSHc4I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-IwJPqEanNwCHnqkj5HvE6w-1; Mon, 21 Oct 2024 17:18:17 -0400
X-MC-Unique: IwJPqEanNwCHnqkj5HvE6w-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-460dd31b4c1so35763231cf.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 14:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729545496; x=1730150296;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6KOQk46edGaDkUkqBKsjSvUWMbHio0dwFaaVPJeLqA=;
 b=jYgf1/iVpwSa4bBwythAQ9UHqEc0w712fj/b+UyeA8EgoIjiK2Vi1V+chmmum3GZuQ
 8Zls3PfbK2VGP6BDNWWctkwv0yPrN0Qxi9Owm+CxiD6MizWAEXjDc72lUTdGxrvz12xJ
 +Uy029uK3wMtt3ti7Le8TAGzEhtgBGl2T/hPdo1SM+ZjOMkpsz87Xuy+qg/f3QUP0HWS
 8CJaq34KxICDF1OmECOv48KWAXdNBjjfdBQ9HITg0GJGxdxKTQRWcz0fg8RqN0q/aTg8
 YUixjIJBI9XvjCuwFewdCU/6ujVoQSc2QLJ3Bp67IOJG55hm0CrdWCp3UBG7k6hHGTfz
 3rgA==
X-Gm-Message-State: AOJu0YwGGMxytYOi3iASsLB2xTklnf+EGsxhCtfla6GOsHSu8TFpjL8s
 4EdX3/lFGQq05ki7lXD7i3XFVeZj2MY6jy6k6JzdlHQ5pszWMsAXuHWKzjdTneCnV0f2fNU7eqj
 HrmvdNYgsLRL2KTuF3a69R+TcxtWRwgzXr5MGdP0tz1q1n9IA0qus
X-Received: by 2002:a05:622a:2a05:b0:460:a9ec:b50e with SMTP id
 d75a77b69052e-460aedf60bemr183703991cf.38.1729545496609; 
 Mon, 21 Oct 2024 14:18:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+iFcgtJVt5TL2LldSc1JnsvIcY+Ruu2FyCGG/8Lh8zldmK8jM2Noxn9hgRRovGRuuWkV9zQ==
X-Received: by 2002:a05:622a:2a05:b0:460:a9ec:b50e with SMTP id
 d75a77b69052e-460aedf60bemr183703751cf.38.1729545496283; 
 Mon, 21 Oct 2024 14:18:16 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3c3aff7sm22359231cf.12.2024.10.21.14.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 14:18:15 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:18:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>, Zhiyi Guo <zhguo@redhat.com>
Subject: Re: [PATCH v4 1/4] KVM: Dynamic sized kvm memslots array
Message-ID: <ZxbFFenerfWK2MFM@x1n>
References: <20240917163835.194664-1-peterx@redhat.com>
 <20240917163835.194664-2-peterx@redhat.com>
 <52cc6540-b1ff-495e-9b98-98f13ecbf380@tls.msk.ru>
 <ZxZnLXD4w2HV07gJ@x1n>
 <cd4d904e-82c2-42d0-8aa3-5906f7182024@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd4d904e-82c2-42d0-8aa3-5906f7182024@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

On Mon, Oct 21, 2024 at 10:05:23PM +0300, Michael Tokarev wrote:
> 21.10.2024 17:37, Peter Xu wrote:
> > Michael,
> > 
> > On Fri, Oct 18, 2024 at 06:38:53PM +0300, Michael Tokarev wrote:
> > > Looking at this from qemu-stable PoV, I'm not 100% sure this change is good
> > > for stable-7.2 series, because 7.2 lacks v8.1.0-1571-g5b23186a95
> > > "kvm: Return number of free memslots" commit, which was a preparation for
> > > for memory devices that consume multiple memslots.
> > > 
> > > I did a backport of this change (currently it is at the tip of staging-7.2
> > > branch of https://gitlab.com/mjt0k/qemu.git) - I had to tweak context and
> > > also to remove now-unused local variable in kvm-all.c.  It builds and the
> > > tests run fine, but I'm not really sure it does what it is intended to do.
> > > 
> > > Should anything else be picked up for 7.2 for all this to work, or should
> > > this change not be back-ported to 7.2 ?
> > > 
> > > (for more recent releases, everything looks ok).
> > 
> > I don't remember anything this series logically depends on (besides any
> > context-wise change).
> 
> Well, 7.2 is a bit old by now, and the commit I already mentioned above is
> also quite old, - at the time you started working on this series, this
> commit (v8.1.0-1571-g5b23186a95) has been in the tree for a long time
> already.  This change might be relevant here or might be not.

That specific commit (5b23186a95) shouldn't be relevant.

> 
> > If there's uncertainty / challenge from backporting to some stable branches
> > from your POV, we can still keep things simple and skip the series, as it's
> > only a perf regression and only happens during live migrations (which can
> > enlarge the downtime, for example) but not daily VM use.
> 
> For this change alone, I did the backport, I just am not sure it makes sense.
> 
> It would be great if you take a look, including the change I mentioned above
> (it isn't in 7.2), there: https://gitlab.com/mjt0k/qemu/-/commits/staging-7.2
> Or we can just drop it for 7.2 per the above.

I checked the backport, it looks all good.

Thanks,

-- 
Peter Xu


