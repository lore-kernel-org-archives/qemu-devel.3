Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B6DD0D141
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 17:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdWxW-0003Gv-OP; Wed, 07 Jan 2026 12:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdWx5-00036F-Lm
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:04:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdWx3-00022V-Ow
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767805442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yi8fk6uLzMfWcy7sQTZ+gleUSPTFLfeFBLKKnPjcPUI=;
 b=QESXqna0Xi+7iFfkctGT8zCFH8PY8ND4cbXf72HQCQcmOjCOFCPCpAGyxhmF2ukFBm9s5a
 BdabXmoMS4q+8JGMQOhcyityufKR8tyuFzlNNDSN36WyFqznrNj+aLLnRzEBOWJD+JsFQc
 UnbBWA3irW/8wCcXkUFixR+sjP/Btk8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-lKnUUICLP7igfkbXle6Lbw-1; Wed, 07 Jan 2026 12:04:00 -0500
X-MC-Unique: lKnUUICLP7igfkbXle6Lbw-1
X-Mimecast-MFC-AGG-ID: lKnUUICLP7igfkbXle6Lbw_1767805440
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88a43d4cd2bso30492346d6.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 09:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767805440; x=1768410240; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yi8fk6uLzMfWcy7sQTZ+gleUSPTFLfeFBLKKnPjcPUI=;
 b=alUnANLb3M6bK2rOO2K3qsA/vBm+IGG2K0sw/yTAriNYlNzfMidiIKH/Z7wlHbYY7e
 TzmjsIbOoTMEycT3HmYmEADqMQ5LlqJmGo4jyPD1f2+wYAtuGYbVh47QBvBdWUCaPZf7
 0veIWG8zc4vRnwqFh5bcci9L++IwttKdjhaqwfyck+BGpYy554AGppWqJ1BewPokfgLZ
 1u4xzHsD+7BfdW4D89WogfLm+aGf8ZTzPBXd0MFDjuFQTypZmvt5c/jVhGHGO1vxqPV6
 YWTTjFJA8dYeRHsouQXkdi+MwzhRdsDbUOXSCXmybWuI0JDAE3TQSW+14yEclFbpE0wj
 SaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767805440; x=1768410240;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yi8fk6uLzMfWcy7sQTZ+gleUSPTFLfeFBLKKnPjcPUI=;
 b=psAFq57MdUZtihWMIwBDIAzNtbdY7EZb+XHEKQ43ZdGXOhlPAr0cYI1N2C6qZOZz4O
 HAUgAPbwLMx2qnzy6NChL2DBZ0sZDhDmaHjfKYbtILy83/NIVVp7TtEV0zkftY6JY8Lb
 Xj0rKE3qD65s1rxcgX9abQ9YdZk8+k9B7BEJzDhjynNhQ89QL4H5aTTPsqFyg7+TUA47
 phe4wP500RqUfT3S2iCvVvfgwjBsA4il70GR5VCcE+Va6Pi6IVG9wIOtj/Ql6/KErGCP
 SR25VoDET+KRUREnh7ZSPishIvIgvE7K/JB941bRSANpIfdyoH2//ztsa/VW6LY2cbjl
 ncmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtX6ijHH4X6dM6xDjyMOVuskRxweAtJuCx9ipFGs5LJmvB7dJ7sCPg1S44y6DtdMNgyEzoF/SpYWnT@nongnu.org
X-Gm-Message-State: AOJu0YxRA8VyFcJjwOuOsTHhovzK1yd4judmlGpQsuDxX0is3hwcDoHp
 G6MqZKNyYcHbSSh9XBrnURnZdIiT6U7Y3agu39lzIH7aggOrWAHacosIJy34Czo5h1StQ4SpzyA
 BksbgpAqaesTPkLu2w0Szy+GP5dOv+ONz6RlUcrwEcPndILca2hTHQaBS
X-Gm-Gg: AY/fxX4GscxlN1gY/12xR+P2HL+PratTBgcpFir9x/6CANM15YVm4aq63NgvxLcGc31
 2NnfvZUMwooKH0Q0UTDag7lbuenTZBQqKrUQrJ3EEEhDEOKou3juka6/tw28l1la7evxJ8xA+1R
 CiFx0YuycbLYPPoNCCvCUJ3vCCWO11TeLs8mxNloyH5QjMNPQoECbZ72qjV3AYaGphH5iJ5A/aj
 GJ8aqCZKTKI4NzcNQhjet12/Umz7YHi9UP1l17p5VGUcfTO2o0s7wIvyFmQtN9At9rcSyq5iq9Q
 RIDjjbwtlbKLEVvFwiKMu0ysQE3q4+JUflLQPj/wE5p9bhG2FZUghM2PiXRBY2b9ATqlFwSEmG2
 PxuY=
X-Received: by 2002:a05:6214:5a13:b0:88a:3113:3abf with SMTP id
 6a1803df08f44-890842a38edmr39912956d6.52.1767805440153; 
 Wed, 07 Jan 2026 09:04:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyWOODm8xCdif3ZiNiNpPkGdlUlrUEZVmloj3K5gzjYYi5fVrrwu6coaYr0ifm35VuUCeXeg==
X-Received: by 2002:a05:6214:5a13:b0:88a:3113:3abf with SMTP id
 6a1803df08f44-890842a38edmr39912296d6.52.1767805439558; 
 Wed, 07 Jan 2026 09:03:59 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-890770ce99dsm36653166d6.3.2026.01.07.09.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 09:03:59 -0800 (PST)
Date: Wed, 7 Jan 2026 12:03:58 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Prasad Pandit <pjp@fedoraproject.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
Message-ID: <aV6R_hADWPz1yr2E@x1.local>
References: <20251222114822.327623-1-ppandit@redhat.com>
 <87h5tilhcq.fsf@suse.de> <aUq1oA73W9rAdCgG@x1.local>
 <CAE8KmOzcOdYhnxpDr8BMV8zjixpEh9r+COe=xyLfXCVWKD0CRw@mail.gmail.com>
 <aV0lj8ShJufwRY8z@x1.local>
 <CAE8KmOw+0dXcON1_VTBY2i6aE0So-MGDtxLmhvtLZWGM6TPxQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOw+0dXcON1_VTBY2i6aE0So-MGDtxLmhvtLZWGM6TPxQA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 07, 2026 at 04:41:09PM +0530, Prasad Pandit wrote:
> On Tue, 6 Jan 2026 at 20:39, Peter Xu <peterx@redhat.com> wrote:
> > Copying Dan and Jiri in case ...
> 
> * Thank you for copying.
> 
> >>           } else if (s->current_state == ACTIVE && s->trigger == 'error-occurred') {
> >>               s->current_state = STOP
> >>               s->reason = "Error occurred, migration failed"
> >
> > We can't change status that were already used, like FAILED.  Libvirt and
> > all mgmt may rely on it.
> 
> * True; If we decide to go in that direction, we'll have to tell
> libvirtd(8) and others about new states.
> 
> > Personally I don't see much benefit on adding a new "trigger" internal API.
> > If we want to forbid some state machine transitions, we can use a
> > transition map.  Said that, IMHO it's separate from what we're discussing
> > here.
> 
> * If we can reduce/rationalise the current 17-18 states and related
> complexity, it'll help to simplify things.

Personally I still don't see the benefit of doing so.

I agree MIGRATION_STATUS_CANCELLING isn't a must to have, but since we have
it already and libvirt should treat it almost the same as ACTIVE we don't
have problem with it either.  It doesn't sound like a big issue.

I don't see how we can shrink the rest of status otherwise, or what would
you propose for removal?

Thanks,

-- 
Peter Xu


