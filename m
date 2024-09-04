Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169F2CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 21:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slxeK-0005X8-Pg; Wed, 04 Sep 2024 17:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slxeI-0005Vv-M8
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 17:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slxeH-0000TB-7W
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 17:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725485683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEx0WNMMAe2k5mPeGmTDqoe25Jt7Ei+CY5w5V6nwzBE=;
 b=TAuRPaHycmIkR0nEC1xZasrCNP2Q8LL4fPyBbDWHOaPDNDRPVGe0v6zNv60VXGuECsfr9y
 dwWcqPeQ2KYeobaBlYWN+pWJA8aee+RoO31FBu/fpJZNbTNt91AnZ8w9kwyzDPWeChH4wC
 heCHaPE5iuWTDhQJUSsQbfS5DLu6bzc=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-PBdeuqcTPIK2QPL7OFKaKw-1; Wed, 04 Sep 2024 17:34:42 -0400
X-MC-Unique: PBdeuqcTPIK2QPL7OFKaKw-1
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-4feade4b21aso38403e0c.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 14:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725485682; x=1726090482;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEx0WNMMAe2k5mPeGmTDqoe25Jt7Ei+CY5w5V6nwzBE=;
 b=dDY/C0EubLIlDQmMQ/L2UT0BWD8UrYu1DF75+FnenGJ/2fIwFVfG9QoWx36fJOf1VH
 cfb3YT03dFPK7dBb1/4TKMrLvRh9KbUpkMC8TGj5C3b1gYAw9hydR+Zp7aCbplcG8Ju9
 dhKU0DNNfKd4skoJHUGu/0Zf5LWRJwxveEq9K7uAJSQn2oL+rqFiSplrzMWLH+OJ0kXL
 /jzy1g1H+q5lxxx3q4GPb7jHS7ksbLK+ymBNrbVXN7dUCXsJbmN741K3JTXulLIyiwWZ
 V/TZGPGVnRfk5vo7nfJoFvN3THXU7jdFxRuI8c1gHzL3ywu6PFWInQEb3IqQs1+wpiP8
 2hJw==
X-Gm-Message-State: AOJu0Yyum4NESetLJjJXKGxkSneOPQOpdiYPdFAgTgwaLAB5c/rrI3Be
 A/QhrgeXwbmkxOf+6JdTj/c6O5zq9D6o/jwe63RoWETB0f2/efG4RDkHxOkP6OBFZEIR/XvVouJ
 ceU+HjUma9WlN5ev8RN+XiaI3uDGMs/CvLEeubHGPHBHaX7QQnyBB
X-Received: by 2002:a05:6122:a10:b0:4f5:1363:845b with SMTP id
 71dfb90a1353d-5009ad1a1e0mr18940567e0c.9.1725485681839; 
 Wed, 04 Sep 2024 14:34:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4mTbb272G3xEy7HhszAkq0XamDttA4aBkk7hqljQEaGA4GWzkqig+DOEBQZD0ruwW4zOJog==
X-Received: by 2002:a05:6122:a10:b0:4f5:1363:845b with SMTP id
 71dfb90a1353d-5009ad1a1e0mr18940532e0c.9.1725485681418; 
 Wed, 04 Sep 2024 14:34:41 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5204189acsm2095306d6.110.2024.09.04.14.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 14:34:40 -0700 (PDT)
Date: Wed, 4 Sep 2024 17:34:38 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Zhiyi Guo <zhguo@redhat.com>
Subject: Re: [PATCH 3/4] KVM: Dynamic sized kvm memslots array
Message-ID: <ZtjSbnb-yFOEsq0R@x1n>
References: <20240904191635.3045606-1-peterx@redhat.com>
 <20240904191635.3045606-4-peterx@redhat.com>
 <b2cf2a87-848f-4c07-9d05-39b53c638950@redhat.com>
 <ZtjPA9eCN1Ro9HFp@x1n>
 <ff6430ac-f7f4-49f3-a63b-76eae5b2f791@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff6430ac-f7f4-49f3-a63b-76eae5b2f791@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Wed, Sep 04, 2024 at 11:23:33PM +0200, David Hildenbrand wrote:
> 
> > > 
> > > Then, you can remove the parameter from kvm_slots_grow() completely and just call it
> > > kvm_slots_double() and simplify a bit:
> > > 
> > > static bool kvm_slots_double(KVMMemoryListener *kml)
> > > {
> > >      unsigned int i, nr_slots_new, cur = kml->nr_slots_allocated;
> > >      KVMSlot *slots;
> > > 
> > >      nr_slots_new = MIN(cur * 2, kvm_state->nr_slots_max);
> > >      if (nr_slots_new == kvm_state->nr_slots_max) {
> > >          /* We reached the maximum */
> > > 	return false;
> > >      }
> > > 
> > >      assert(kml->slots);
> > >      slots = g_renew(KVMSlot, kml->slots, nr_slots_new);
> > >      /*
> > >       * g_renew() doesn't initialize extended buffers, however kvm
> > >       * memslots require fields to be zero-initialized. E.g. pointers,
> > >       * memory_size field, etc.
> > >       */
> > >      memset(&slots[cur], 0x0, sizeof(slots[0]) * (nr_slots_new - cur));
> > > 
> > >      for (i = cur; i < nr_slots_new; i++) {
> > >          slots[i].slot = i;
> > >      }
> > > 
> > >      kml->slots = slots;
> > >      kml->nr_slots_allocated = nr_slots_new;
> > >      trace_kvm_slots_grow(cur, nr_slots_new);
> > > 
> > >      return true;
> > > }
> > 
> > Personally I still think it cleaner to allow setting whatever size.
> 
> Why would one need that? If any, at some point we would want to shrink or
> rather "compact".
> 
> > 
> > We only have one place growing so far, which is pretty trivial to double
> > there, IMO.  I'll wait for a second opinion, or let me know if you have
> > strong feelings..
> 
> I think the simplicity of kvm_slots_double() speaks for itself, but I won't
> fight for it.

Using kvm_slots_double() won't be able to share the same code when
initialize (to e.g. avoid hard-coded initialize of "slots[i].slot").

Thanks,

-- 
Peter Xu


