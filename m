Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81440C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 12:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY2vk-00010d-85; Wed, 15 Jan 2025 07:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tY2va-0000sF-1F
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:55:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tY2vY-0007gq-9h
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736945717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hpIJ5X5NNxdmUsUFZLhjndj1jKyLSLco7XkVHjzdcWc=;
 b=cbPHBVCxksI9OyHYOkFGpxBRZvH5C98GudMUqyC7ZptZm1mhaLchiWnnnDXrfxyiGh900L
 hBMDesrYD0ldcOwKa1r96gVOY9i4CQqoO2p3/Z/qtGa9wHBIE8k1kzc5jwq66yi2j7lLAh
 tdAGBPDYY8FJoqgpZleKJK9G3IRVeS0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-Tsgl0EmZO3q7HMbzqvD0_w-1; Wed, 15 Jan 2025 07:55:16 -0500
X-MC-Unique: Tsgl0EmZO3q7HMbzqvD0_w-1
X-Mimecast-MFC-AGG-ID: Tsgl0EmZO3q7HMbzqvD0_w
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4678f97242fso176594091cf.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 04:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736945715; x=1737550515;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hpIJ5X5NNxdmUsUFZLhjndj1jKyLSLco7XkVHjzdcWc=;
 b=F/VTl0iP+feB8owNOTlc5Q3y2EAK0xZyiZBUJtbHbAQQjRK1k983bYnZYTgktlzKSN
 eSlz9Rew2anHdacY5yx65oGWS2FGsJtiIJ3kvpfzuMcV/2KaKpLQeS8dOHx2RwEGmydF
 QXmKW15Axa+cF5A4ENrUd9BI0KMhle4eB3beK5mzP+xBhEyp0bhjLxMOD6NaaNNQXps5
 b76WNn531bQxl6PeE02ht/kV9W1rsqKjQGonIBhWdADU7hulJEnsfu2m+LEEdBz7zkPg
 zVLg0FT9ee1GdBxKrcNYezLG5QOkRSqBq6mhhADk8eVoEGOOuXHjzxrnjbsKkSwcpujF
 IkZQ==
X-Gm-Message-State: AOJu0YwgrRjr3fe779ZXF1lpnLMGBkvY3qnpWbupCQ9l8m1bQFN8ARp0
 z4+WbIL2WvSjX7thy9rlWyHkEqfXR3O0luqt2RGGHf857Xz1uFrMfP/sRq3kecUPaF7OQR0uvj7
 Qm0LLtQJ2PqROP2owM8LEgmyz8D9jbs+ThXboCobpHr+UqTQhSRKn
X-Gm-Gg: ASbGncsOb+i8gpito8NoGJ0OPFCO7dmZGzUZyzlF1zVv38h+d0zQXzjsbUZ6++sWAUU
 DGz1wB+0drWWFV+Q776vcd6wneelyZLEaAT7tgMb+6UVMzVOBtjdZmpKgTha7+xBxi4bAP8Sjuj
 TqMWvzM3klNJOVvJFA5k1K3RQUpJAaXT++xVg4aEDWnL3a0T8lh73ztbx9PB1y8g6ooFh54uBHZ
 hBlqIhtPYD/xrHAwoH3+MbFve2GgHqpNdoxnJCYlrDtP0eb752VVELffzeqyC1dA2ntrrA4HxpY
 SltG1NzSl1Jni/qL3w==
X-Received: by 2002:a05:622a:254:b0:462:bb8d:3673 with SMTP id
 d75a77b69052e-46c7107e0e1mr492271981cf.35.1736945715581; 
 Wed, 15 Jan 2025 04:55:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQzXx295uQdkAG1vIE5kLoqBgf8/UliXJPC+Vp/GRYJS6k5tU4rej8cX5M4n9tY6FhIvOL/w==
X-Received: by 2002:a05:622a:254:b0:462:bb8d:3673 with SMTP id
 d75a77b69052e-46c7107e0e1mr492271641cf.35.1736945715307; 
 Wed, 15 Jan 2025 04:55:15 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873216dbsm64307791cf.7.2025.01.15.04.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 04:55:14 -0800 (PST)
Date: Wed, 15 Jan 2025 07:55:13 -0500
From: Peter Xu <peterx@redhat.com>
To: Jiri Denemark <jdenemar@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 00/16] migration: Switchover phase refactoring
Message-ID: <Z4ewMbck5qDrRjlw@x1n>
References: <20250114230746.3268797-1-peterx@redhat.com>
 <Z4d8DWKgWveN17M9@orkuz.int.mamuti.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z4d8DWKgWveN17M9@orkuz.int.mamuti.net>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
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

On Wed, Jan 15, 2025 at 10:12:45AM +0100, Jiri Denemark wrote:
> On Tue, Jan 14, 2025 at 18:07:30 -0500, Peter Xu wrote:
> > CI: https://gitlab.com/peterx/qemu/-/pipelines/1625266692
> >     (note: warning is present on rust stuff, but shouldn't be relevant)
> > 
> > This series refactors the migration switchover path quite a bit.  I started
> > this work initially to measure the JSON writer overhead, but then I decided
> > to cleanup the switchover path in general when I am at it altogether, as I
> > wanted to do this for a long time.
> > 
> > A few major things I tried to do:
> > 
> ...
> >   - DEVICE migration state
> > 
> >     QEMU has a very special DEVICE migration state, that only happens with
> >     precopy, and only when pause-before-switchover capability is enabled.
> >     Due to that specialty we can't merge precopy and postcopy code on
> >     switchover starts, because the state machine will be different.
> > 
> >     However after I checked the history and also with libvirt developers,
> >     this seems unnecessary.  So I had one patch making DEVICE state to be
> >     the "switchover" phase for precopy/postcopy unconditionally.  That will
> >     make the state machine much easier for both modes, meanwhile nothing is
> >     expected to break with it (but please still shoot if anyone knows /
> >     suspect something will, or could, break..).
> 
> No problem from libvirt side...
> 
> Tested-by: Jiri Denemark <jdenemar@redhat.com>

This is definitely reassuring.. thanks a lot, Jiri!

-- 
Peter Xu


