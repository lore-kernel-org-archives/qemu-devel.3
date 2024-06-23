Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B5DC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 20:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLU5S-0005OH-G8; Sun, 23 Jun 2024 16:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sLU5P-0005MP-AH
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 16:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sLU5N-0001wQ-JX
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 16:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719175516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N7TDj64ZdDI/CxtCOfhRCPadRiEAob+XyYevWJ6nq70=;
 b=WtUuxKPp+3TsSEi/pSRVNAVeZAKdO6fBLu2Tgs9ib4sWK8v4I87E4r/jTm36/zbW7+TUMv
 1o1FEh5b4aeOBzl+5Ly06R7FJPN3urJ0Ltw1ldo3Ie8wnUO419+Ebbf1ckEiU2p29y4FLU
 q2N1War2XVLc2AFHBP/ZvVXuhacapwU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-a8UAQt19OE2cZsAvOIe4Cw-1; Sun, 23 Jun 2024 16:45:14 -0400
X-MC-Unique: a8UAQt19OE2cZsAvOIe4Cw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-43fd537e6a6so7472391cf.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 13:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719175513; x=1719780313;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N7TDj64ZdDI/CxtCOfhRCPadRiEAob+XyYevWJ6nq70=;
 b=jf9s2caU2qrEXn3MnCeY6V1PcrJc9YTXw5nZfZDau8Fn083+5hIQ2uHliC8pu9umWM
 J2B6HTeIzSE70JiwRtaVCFL0ONUbXkbcS6hbmMS0cKbR0msYUWHiLpConXemXWLOCjsO
 uD/I9R46hKbG6JYv63LrVY5KoQkY9DCe7zn8L5SLvcjJ+eMNDWM1r6kAGg86UIpd5rND
 qmwINLPZALUK3Q99DIfVsAdV2U0CSOGJvHZGbIpjDe2saK20cEcridQYca+MvMOtnDJE
 H3RPsuqz0lYQCM/lszd8r4Rkz2l4uI0ZeomhG0ai6SCoGBZj9FtlrKS/ZgDmoW7rsxP5
 jz5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNVzhg98btvbLfXPdbp/wPSZVbIsqNdSt965QbmK6L+OR+XCNvC+3pe6gLTuPGGrbVUicUpLdV05hgOYnNrB1mi/C6UQs=
X-Gm-Message-State: AOJu0YxNwuhhF2/IuNb37SG6mzSaZ03mmWydnCvrWX+hYYoQmTWTcLOa
 h9vfu/yM5GzWBgO914mg6/veAQ0VVrEDdNg4AqLuIgcYmQvh1TR0RxhADarDwX/oy2GppSurQtj
 CpC1fDfCwO8sNo5oR8xmOiXHmZva0UmK7Jow++k2U+4Jrb8MjEkuTnNuFbIjP
X-Received: by 2002:a05:620a:4712:b0:79b:be0b:77e0 with SMTP id
 af79cd13be357-79bdd78b97dmr525581285a.2.1719175513290; 
 Sun, 23 Jun 2024 13:45:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIQZcY6tnjGfPixrpd3nMrA7jJZLVBXimvFh1QNNvXOGnopW4TNGZWvY77kuUWhh6g9Q06vQ==
X-Received: by 2002:a05:620a:4712:b0:79b:be0b:77e0 with SMTP id
 af79cd13be357-79bdd78b97dmr525579585a.2.1719175512672; 
 Sun, 23 Jun 2024 13:45:12 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79bce91f891sm258565885a.92.2024.06.23.13.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:45:12 -0700 (PDT)
Date: Sun, 23 Jun 2024 16:45:09 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 0/7] migration/multifd: Introduce storage slots
Message-ID: <ZniJVe9DmzIoX3dV@x1n>
References: <20240620212111.29319-1-farosas@suse.de>
 <f6f84518-530e-4332-8881-41a6219b8d4d@maciej.szmigiero.name>
 <87v822ibh8.fsf@suse.de>
 <dfe0384e-a765-4bfb-81c8-529329d76052@maciej.szmigiero.name>
 <ZnWinGjeZGRGVOF-@x1n>
 <2d245ec8-0b0d-4596-a3a7-8bbbfd9c3d41@maciej.szmigiero.name>
 <ZnXoeOIbga7mu4BY@x1n>
 <a6f09608-eae7-48c1-a28f-e33798e94ec4@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6f09608-eae7-48c1-a28f-e33798e94ec4@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Jun 23, 2024 at 10:25:05PM +0200, Maciej S. Szmigiero wrote:
> > I appreciated a lot you worked out VFIO on top of multifd, because IMHO
> > that's really the right direction.  However even with that, I don't think
> > the whole design is yet fully settled, not to mention the details. And that
> > implies it may miss 9.1.
> 
> I appreciate your work and review Peter - it would be nice if we could
> at least make some progress on this subject for 9.1.

Let's try and see, I didn't mean it won't hit 9.1 at all, it just feels
still challenging, but who knows!  I just don't want to give you that
feeling then right before softfreeze I start to say "it's not ready".

I think one reason it'll be more challenge is also since Fabiano will be
missing for weeks, and since you look like to agree on his RFC as a start,
it means it might be good idea we wait for his back and see how that goes
from there even if we can reach some consensus; it'll just be challenging
already.

I also left my (slightly lengthy) comment on the high level design of that
series here (I know you'll see that, but just to keep a record of this
discussion and link them together):

https://lore.kernel.org/r/ZniFH14DT6ycjbrL@x1n

Let's discuss there, let me know if something I just made it wrong, and
also if you're targeting landing part of the series you can try to
prioritize / provision what can already be landed and easier.

I actually have a wild idea where I don't know whether "switchover phase"
hooks are even needed.  I mean, currently save_live_iterate() allows
"returning 1 means all data ready".  Logically in switchover phase the
migration core could simply call save_live_iterate() until it returns 1.
Then switchover hooks do not need to exist at all.  I didn't check the
details, but if that works that'll simplify all register_savevm_live()
users, and also for VFIO it may mean iteration phase is more important too,
as when it's resolved it naturally works with switchover phase.  You can
ignore this idea because it can be too wild and definitely not helpful on
landing things fast, just in case it may bring some thoughts.

Thanks,

-- 
Peter Xu


