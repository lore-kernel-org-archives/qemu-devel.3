Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A38DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 16:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shAOH-0007Xw-UD; Thu, 22 Aug 2024 12:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shAOE-0007W2-3N
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:10:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shAOB-0005e8-9T
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724343016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SnXVDeN5AYNLaVNESJz1K2/WwwRY5WOKT0UW+GE4cnI=;
 b=Y77I9JxKZv+MPH1zcALJvGhHawFTJfx3VsSMEgW0aRAJsZUApu6LkdsNIY0/W7MOKR6Urf
 ZBkV57iZrafMT74jDNxVgtnrTPVLK7xEmIm0b6ndsD/2Tu67I7DmOoDtaIK1ZAPjixFk1k
 GUIlOqLAEBTIsTWQLKv5i/fWazdREo0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-jZ9pKToqOX-VafhU_4axAw-1; Thu, 22 Aug 2024 12:10:15 -0400
X-MC-Unique: jZ9pKToqOX-VafhU_4axAw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-451ce285418so11784751cf.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 09:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724343014; x=1724947814;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SnXVDeN5AYNLaVNESJz1K2/WwwRY5WOKT0UW+GE4cnI=;
 b=kQOhQHOCl4HMA/SROtd4vIGxFmEGhSwknxS/7KaaJSLudsZZSGAR1Oe46cwoJSUhYi
 yg4ZqU5tmWA4s87lUDsxzJd9h5YdapoZWNi8YX8CzuG7q4uXiVRLjvOmGqp67IeC+JZo
 w0L3P2o3GcVlBkkn1cjSS6g2uHk+B07kSDRtzjMOwyt8KLvPOH2Dl/9FINUUvA+e2D3J
 5MVGtwp5zM3iC/wTkxCwZTjLhWWLJCTbOfUt1xvf3daN3qNt4gICInmy3HNpvTzvdA/1
 3jusMR0RUZok5iV10jEbtvEG4EgWl9S0G1jwVAnoDzltEZBY/9+c/T/gJ50iC3eU2xlR
 VLxQ==
X-Gm-Message-State: AOJu0Ywo4CW77A3N455U6DGRAUKyiCKDzigcWv0102L6BA1Vs+n8bsRF
 Kd3SAoCU49KT97akFvXLPc/itL7Gd/SjLDgBpvzYRlFtu6PfS9pi50JrTvrrNNjcjxUucrjiW/0
 dt4Z9THxDbFaKsnKUVpmdfz8I4xum/S/XoNh93OUE718b3XxWr7mOFcR9VTTS
X-Received: by 2002:a05:622a:1dc4:b0:451:d6b3:3930 with SMTP id
 d75a77b69052e-454ff830415mr21394171cf.47.1724343014307; 
 Thu, 22 Aug 2024 09:10:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfkHSPdXWqE9nLXmdqe67HXY+7gpeuvm6sxqKb+WkgEBY3Z0Fw+T70k+19yoQMcZJdr2rwSg==
X-Received: by 2002:a05:622a:1dc4:b0:451:d6b3:3930 with SMTP id
 d75a77b69052e-454ff830415mr21393971cf.47.1724343013996; 
 Thu, 22 Aug 2024 09:10:13 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe0f309dsm8129841cf.54.2024.08.22.09.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 09:10:12 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:10:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 12/14] migration/multifd: Allow multifd sync without
 flush
Message-ID: <Zsdi432b2dobNhMj@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-13-farosas@suse.de> <ZsdhY2ijx9nhSdLz@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZsdhY2ijx9nhSdLz@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Aug 22, 2024 at 12:03:47PM -0400, Peter Xu wrote:
> On Thu, Aug 01, 2024 at 09:35:14AM -0300, Fabiano Rosas wrote:
> > Separate the multifd sync from flushing the client data to the
> > channels. These two operations are closely related but not strictly
> > necessary to be executed together.
> > 
> > The multifd sync is intrinsic to how multifd works. The multiple
> > channels operate independently and may finish IO out of order in
> > relation to each other. This applies also between the source and
> > destination QEMU.
> > 
> > Flushing the data that is left in the client-owned data structures
> > (e.g. MultiFDPages_t) prior to sync is usually the right thing to do,
> > but that is particular to how the ram migration is implemented with
> > several passes over dirty data.
> > 
> > Make these two routines separate, allowing future code to call the
> > sync by itself if needed. This also allows the usage of
> > multifd_ram_send to be isolated to ram code.
> 
> What's the usage of sync but not flush here?

Oh I think I see your point.. I think flush+sync is always needed, it's
just that RAM may not always be the one to flush, but something else.
Makes sense then.

If you want, you may touch up the commit message to clarify that.  E.g. I
still don't see any use case that we want to sync without a flush, that
part might be a bit ambiguous.

If my understanding is correct, take this:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


