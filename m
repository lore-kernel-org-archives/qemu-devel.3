Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A587DCA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 15:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqYq4-0006mX-QN; Mon, 25 Aug 2025 11:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uqYq3-0006ll-CN
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 11:10:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uqYpv-0006Dp-Aa
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 11:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756134615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cVFzsCD9aFGIAAw0D23rm6WiwHdzhe1lK5XFYrK6f5Y=;
 b=gy/Ang7o+iZxq063B0kl3pXGp4/hUiSR3vCnuqEYrEvEnR7iU/x33md1Xe78R3FlOTxfqm
 xUIVHIlAm/TcbsTA9NXaGyOF5RXWBAvJtOaIFbpokm9Mw4+FZg+Df9Vzx0LL8p2j9ldw4k
 yxpcREPdo+s4x8IAaLevWgvHsTB3jQI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-Sbx3e10nOp6NqcoE9TBH-g-1; Mon, 25 Aug 2025 11:10:14 -0400
X-MC-Unique: Sbx3e10nOp6NqcoE9TBH-g-1
X-Mimecast-MFC-AGG-ID: Sbx3e10nOp6NqcoE9TBH-g_1756134614
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b109bd3fa0so45002821cf.2
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 08:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756134614; x=1756739414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cVFzsCD9aFGIAAw0D23rm6WiwHdzhe1lK5XFYrK6f5Y=;
 b=jmtrpGMpRfSnI9vNvBtljgRsdEfHvJzMK91bStX8ky7R230q5LRdYPA/IpgrZk7aqw
 3OoH9EB66fXy6ZnjpcUe6WuvKHnxDhGuNwqWCpmp45VkVv/xBsxdKriCQmaco3y3Hq76
 wFV1/HSDimuFb5PWv6RR9zwUC7gVts525oZQuDoqMgzty87SS7C8ZvOSY6ugot36IBM6
 /STKQfX4lPq/LWCKGJwHjdzvmsUejJona34/IV+lBRpqNrvfSuTomlR8DRBIxWwilPR5
 4/WKXWvyaOZD0xyXem301X43jGgDjAubsT15cKsYFoyxsIHoH/W57frUwCMDnnxgpLSM
 6+ag==
X-Gm-Message-State: AOJu0Yw6YsotNyU+H7k7Wtopk8fW+G5bNrs6S5PaQ6lVPZ02oLwZbjcx
 CUrnp01ay7fscFdz9QN3QPB3vprI7o3auswQstH3okRLRU4gGjIaKowXpz5zsieeYoT8QalSPbR
 wDfZT+Y5JAE0PwiW7+9VFzs4XOhtgEFLRldnaDpzz1sYQNoPA9VZEiDwz
X-Gm-Gg: ASbGncvZa+hk35rlSqq9ubp0mS1adOFjXKsFB/tEfTWgbYIjNVx7vUy8IXMcND1ICTQ
 sGIN8niVrm3Q61wRI/SOudTXTnezSK+7GJUsPyuQ0OooRJVwfGCfksLVJP5NXFwU2r+YYToVGKA
 Dx0+CrR+4XhpqCGYGrdW4TsMvXnr5M9I2D33HIDTFDOrXdeLL7erv2qeGsvm7HxnmFYHeHpYd0a
 CmTACEPSyJV0SWE5hE2MqudiAYOk2++Eto/Xja8MQmvB8sO3aMFN3Dv5HU/UmgThtcPI9TIN3Ce
 5HiiMkJ8xZNaAQCGED+yxps7LnZhpQ==
X-Received: by 2002:a05:622a:5e18:b0:4b2:d287:2340 with SMTP id
 d75a77b69052e-4b2d2872dddmr34377891cf.70.1756134613602; 
 Mon, 25 Aug 2025 08:10:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVaNcv/WreMb64j06R10CJFferNzlDgS7r0IjlrCZ9QoV4a8cZiSYNiPtqrmIG3nYi1aHXaQ==
X-Received: by 2002:a05:622a:5e18:b0:4b2:d287:2340 with SMTP id
 d75a77b69052e-4b2d2872dddmr34377161cf.70.1756134612814; 
 Mon, 25 Aug 2025 08:10:12 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b2b8de5fdesm51711301cf.31.2025.08.25.08.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 08:10:12 -0700 (PDT)
Date: Mon, 25 Aug 2025 17:10:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
 <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 mtosatti@redhat.com
Subject: Re: [PATCH v4 5/8] hpet: make main counter read lock-less
Message-ID: <20250825171009.0651153f@fedora>
In-Reply-To: <aKx5b7VH1p0NHxjL@intel.com>
References: <20250814160600.2327672-1-imammedo@redhat.com>
 <20250814160600.2327672-6-imammedo@redhat.com>
 <aKx5b7VH1p0NHxjL@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 25 Aug 2025 22:55:43 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> On Thu, Aug 14, 2025 at 06:05:57PM +0200, Igor Mammedov wrote:
> > Date: Thu, 14 Aug 2025 18:05:57 +0200
> > From: Igor Mammedov <imammedo@redhat.com>
> > Subject: [PATCH v4 5/8] hpet: make main counter read lock-less
> > 
> > Make access to main HPET counter lock-less.
> > 
> > In unlikely event of an update in progress, readers will busy wait
> > untill update is finished.
> > 
> > As result micro benchmark of concurrent reading of HPET counter
> > with large number of vCPU shows over 80% better (less) latency.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > ---
> > v3:
> >   * make reader busy wait during update and reuse existing seqlock API
> >        Peter Xu <peterx@redhat.com>
> > ---
> >  hw/timer/hpet.c | 26 ++++++++++++++++++++------
> >  1 file changed, 20 insertions(+), 6 deletions(-)  
>  
> ...
> 
> > -    QEMU_LOCK_GUARD(&s->lock);
> >      if (addr == HPET_COUNTER) {
> > -        if (hpet_enabled(s)) {
> > -            cur_tick = hpet_get_ticks(s);
> > -        } else {
> > -            cur_tick = s->hpet_counter;
> > -        }
> > +        unsigned version;
> > +
> > +        /*
> > +         * Write update is rare, so busywait here is unlikely to happen
> > +         */
> > +        do {
> > +            version = seqlock_read_begin(&s->state_version);
> > +            if (unlikely(!hpet_enabled(s))) {  
> 
> is there any particular consideration for rearranging the order of the
> conditional branches here (and not directly using likely(hpet_enable()))?

not really, I suppose it should be the same either way.

> 
> > +                cur_tick = s->hpet_counter;
> > +            } else {
> > +                cur_tick = hpet_get_ticks(s);
> > +            }
> > +        } while (seqlock_read_retry(&s->state_version, version));
> >          trace_hpet_ram_read_reading_counter(addr & 4, cur_tick);
> >          return cur_tick >> shift;
> >      }  
> 
> Nice imprvoment!
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 

thanks!


