Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64D6C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhnyL-0000o6-3s; Wed, 06 Mar 2024 04:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rhnyI-0000nx-DP
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:53:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rhnyG-0000MR-IO
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709718835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NFE7Ni6nffGgZw6lA+O+jCs2zVtuQqUDAEAA0xuupno=;
 b=J7NWILSObxWhVAIKeE8mTVZ7OudGdzxs7zjEBl+CsY3fmD4vX5jZtL3642aFJmrFavQuoa
 FTW/97Yk4neTbb1CscfbZf0oDzfqcOl0wxcBcu0Xd8i5NIviiKA/5ri5d9SfnZSZ1UKOwa
 0DYtfKZEuCRgWcUXF2huUP8Vb0sMmr8=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-luFGJZGrNNWLk9Mv611f5g-1; Wed, 06 Mar 2024 04:53:53 -0500
X-MC-Unique: luFGJZGrNNWLk9Mv611f5g-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5a137cbbd18so775450eaf.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 01:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709718833; x=1710323633;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NFE7Ni6nffGgZw6lA+O+jCs2zVtuQqUDAEAA0xuupno=;
 b=BdamfKfTIWNTc8uPfl7YVOe1SdeAAMk2Gec0XhquEiaUoHNAw0nFx3NW5yT7yKxSvS
 23OCWevMYkBw5ap6wALinC1Rj0/0rSLQLfUDFhBT2Qn6AaX/+896LzCep6ekEdFUdnbs
 YMxTugUmFIVRt/L02o84hnii9WsYr1pnyiHdwVpkh7RmWM+mLL5xT3dT9vTPT4ZNb7HY
 o6LFwSOXiQEkcerFneJF8MRKb20I0nkUNrilyNCwsFs59FbfpgiP/siwj/DBF5zGAHKO
 w1grh1yxXR442CpYO6CXCjOQRUw5LaiNK4JUHHon4ENY8XHhvKnCwO4P2vcdz24SAcmJ
 GKNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqt5Ucgs14sP7NqcmytlfWTrQDr0igNaDCPlIGvk4NDovUmlecNGFL4K3k5r8zQM3HaBdnKhgdZ9Rl+upLfzwXeObp00I=
X-Gm-Message-State: AOJu0YwsEy92TE1yZSht6Wk/NTm9QdhgOe5tv2JR9+2dEabpHqERs4dR
 SgB6Ji+tdWaZtGhm8necX+813begJDM4T/NCajdhNfdqzt3kXU4eJYH54atYD22zqzu5c+n1xIv
 updLN/tndUlnCIA1eFbANmQak2wKuW0PJEHL8FE2iU8oLiOkwrqew
X-Received: by 2002:a4a:b80e:0:b0:5a0:2cbe:43dd with SMTP id
 g14-20020a4ab80e000000b005a02cbe43ddmr3038495oop.1.1709718832837; 
 Wed, 06 Mar 2024 01:53:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8TOxsiuqsobab3VU4TOlRFe0EjgqbsX72kvi692DufAIQo8ylINdX5eeqIr0kh/j1xBrzPQ==
X-Received: by 2002:a4a:b80e:0:b0:5a0:2cbe:43dd with SMTP id
 g14-20020a4ab80e000000b005a02cbe43ddmr3038486oop.1.1709718832492; 
 Wed, 06 Mar 2024 01:53:52 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 u23-20020aa78497000000b006e5092fb3efsm10413270pfn.159.2024.03.06.01.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 01:53:52 -0800 (PST)
Date: Wed, 6 Mar 2024 17:53:43 +0800
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH] migration/multifd: Don't fsync when closing QIOChannelFile
Message-ID: <Zeg9Jx1lkZziFj_a@x1n>
References: <20240305174332.2553-1-farosas@suse.de>
 <ZedbLT2pFNyRoX90@redhat.com> <Zee-WYQg9c19Up-T@x1n>
 <Zeg2hN-mo53okbjL@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zeg2hN-mo53okbjL@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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

On Wed, Mar 06, 2024 at 09:25:24AM +0000, Daniel P. Berrangé wrote:
> On Wed, Mar 06, 2024 at 08:52:41AM +0800, Peter Xu wrote:
> > On Tue, Mar 05, 2024 at 05:49:33PM +0000, Daniel P. Berrangé wrote:
> > > I don't think you should be removing this. Calling qio_channel_close()
> > > remains recommended best practice, even with fdatasync() removed, as
> > > it provides a strong guarantee that the FD is released which you don't
> > > get if you rely on the ref count being correctly decremented in all
> > > code paths.
> > 
> > Hmm, I have the confusion on why ioc->fd is more special than the ioc
> > itself when leaked.  It'll be a bug anyway if we leak any of them?  Leaking
> > fds may also help us to find such issue easier (e.g. by seeing stale fds
> > under /proc).  From that POV I tend to agree on the original proposal.
> 
> Closing the FD would cause any registered I/O handlers callbacks to
> get POLLNVAL and may well trigger cleanup that will prevent the leak.

It's not possible anymore that we will have such handler callbacks when
reaching here, am I right?  AFAIU that's my understanding after commit
9221e3c6a2 ("migration/multifd: Cleanup TLS iochannel referencing").

Would it be possible if we can assert that fact (either on "there's no
handler callback", or "we're the last reference" then it implies no
handlers) rather than doing an explicit close() (and if we do the latter,
we'd better explain the POLLNVAL bits)?

Thanks,

-- 
Peter Xu


