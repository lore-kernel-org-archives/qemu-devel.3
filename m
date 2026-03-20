Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581091098797
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3bvL-0003XC-4n; Fri, 20 Mar 2026 11:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3bvJ-0003X1-Ca
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:38:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3bvH-0003Pj-DQ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774021081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TXdruH1vk/Lt3UAZA0iyFqjY32qTrI0srWY1UFkHfVs=;
 b=Q7AeX9cK0YcCFmb5nZnvwkqecWnfuJEKXdVuCRKscoATW6RjSUh/lyyIe2WctsymYkXmDb
 AcqMg5r9eSZUh8NX1Ph1O3AMK4jx0PB3A7HVL8FHgYtxR2gIw/Ie2ojjLAlrzKPq7fIBn8
 osY92JpZiCNQVOvxBh8F/Ia9NsuqtTo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-_xS9YfSSMReL7uAfRJh6Xg-1; Fri, 20 Mar 2026 11:38:00 -0400
X-MC-Unique: _xS9YfSSMReL7uAfRJh6Xg-1
X-Mimecast-MFC-AGG-ID: _xS9YfSSMReL7uAfRJh6Xg_1774021080
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89c3d3f5799so160388516d6.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774021080; x=1774625880; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TXdruH1vk/Lt3UAZA0iyFqjY32qTrI0srWY1UFkHfVs=;
 b=Tq3Pb25T8TwEs3v/yZBsqSGHBs/PHO2I0j/aQYX7JeX1t5yUJtqpCfkUSugWLXnyCT
 D4th0cUWsFyQaedQyQYMhBCFkCA1v9IToPoDpBXXEOxxnI8EkcZClaX6A6iS8VcnWT48
 PVesvP/dnFqlPADVbNUX8NG7fxUk1SrKqfiMtmI6nYSvOdmpVHmYlBy6ODF6hDbqeugK
 /azX+p9eBTOp8aKcw4OUqzmcBO1VGCE/kFtWey6prGnCh/0bkcYS9myho1xy9tXa4MES
 p82rs04T1fSd4/L5875rbt73rCA5Um7rB4O6i522qhGP3yehhZJeZjCh5MSf3LvUQlVX
 kZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021080; x=1774625880;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TXdruH1vk/Lt3UAZA0iyFqjY32qTrI0srWY1UFkHfVs=;
 b=X7mWcpUOiIAyVL4THs/q/EY431rOBMOC+DKuxvODVe/B1Fr9OIMfGA735NgQS+ICBu
 R2uIpXE67IN/gxKi4M8AiOvc9bNtOcsAcXwnsJTxal82LG3nmGqmRlevw2DuMq7IAFVd
 K9+G6rb0Ay2SkNMQCMuMO6jqHXH45jrJYH5cQLH12eWyWoG3s8llX1kF96a789uc3/6J
 aMwCYzAnIeIDwVeIAZv97s1E5kTZQQN82cuc4Xn0X4AhtF2snMgMCwR/BcyOS+x55H7r
 1fc7aQBMOe0YlwylCZEv6M0+wQP7vDO1oGO1CLWZQtkiduHwiZLMTapdwPQ1UYz/nPKt
 D1fw==
X-Gm-Message-State: AOJu0Ywiexh9W3BfJMqmzZ+lSEw0S/VEvqQjFDj373QhWUh3W8WQISb3
 cxJXQPSnxAhyoTvho3W7Hc1krBwhrhSv7OKFiSEOzTVNSwghKUNfNK6fhVS0KZmfhNN8gUhmgLg
 mhI/AW0Cbvq9oVgg+75DRJlBcVg/XpIu38N79p9l7lKVAf77W+6IPMOyC
X-Gm-Gg: ATEYQzzgSh1CU0HMhsUM5r7tZ7tX9KqvwZbQUUcOaZo8FgdYcQ2OWPMMEvTfoVL3ruL
 izp7uN25WGP7NNN4e9XZ6Pyi1IEJou0C8Z24dSANVebREHe7uSP+e6wFsOxuBxGoF3jEwW4YgaH
 FZ3lj2FAf1DFy8CGME4aJmcRq+wHBJSrG79z8Wv7mAiXwH+rUSmRVVtPOOXTkeVm+lUAz5iyzHm
 1LSdbTCkCnQUzKLtNCCXgbUV3IP0VE9YRMH0pbqqrRO5JqW9a87+f8zw2ZK3rQX1CklauwdFMP9
 aCU6qoglak1FiyE+r7RqdnxLWbJHUJvBmNhFRfNq8Zfvxf2AfMzqSXHF5E6XNYmjUi8mAWvU4pl
 eQGiamIc18Gfb7A==
X-Received: by 2002:a05:6214:4347:b0:89c:869e:47b3 with SMTP id
 6a1803df08f44-89c869e48d0mr39375826d6.41.1774021079382; 
 Fri, 20 Mar 2026 08:37:59 -0700 (PDT)
X-Received: by 2002:a05:6214:4347:b0:89c:869e:47b3 with SMTP id
 6a1803df08f44-89c869e48d0mr39375286d6.41.1774021078830; 
 Fri, 20 Mar 2026 08:37:58 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c85251e32sm22681436d6.16.2026.03.20.08.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 08:37:58 -0700 (PDT)
Date: Fri, 20 Mar 2026 11:37:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 09/10] vmstate: Implement
 VMS_ARRAY_OF_POINTER_AUTO_ALLOC
Message-ID: <ab1p1QY3hV5dn13C@x1.local>
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-10-peterx@redhat.com>
 <87tsua1s0z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tsua1s0z.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 20, 2026 at 11:42:36AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Introduce a new flag, VMS_ARRAY_OF_POINTER_AUTO_ALLOC, for VMSD field.  It
> > must be used together with VMS_ARRAY_OF_POINTER.
> >
> 
> Sorry if I missed it somewhere, I was a bit tired yesterday when I

I haven't read it, I will read it, at some point.. Fridays normally aren't
as busy.

Since this one is shorter I'll reply fast,

> looked at this series, but why can't we reuse the currently invalid
> VMS_ALLOC|VMS_ARRAY_OF_POINTER combination?

This only handles allocation of the field as a whole.  Say if it's an array
this makes sure the array will be allocated properly on dest.  It doesn't
cover the fields in the array.

Btw, it's exactly the given example described below that this wants to do:

> 
>     /* When loading serialised VM state, allocate memory for the
>      * (entire) field. Only valid in combination with
>      * VMS_POINTER. Note: Not all combinations with other flags are
>      * currently supported, e.g. VMS_ALLOC|VMS_ARRAY_OF_POINTER won't
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>      * cause the individual entries to be allocated. */
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ >     <------------------- here
>     VMS_ALLOC            = 0x2000,

-- 
Peter Xu


