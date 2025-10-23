Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E88CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwHy-0008TA-1k; Thu, 23 Oct 2025 10:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBwHw-0008SW-IW
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBwHr-0001Ad-Ej
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761229649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5ejov+DXYA6q0ZVkJsV1kdKg4rKTnu258ot1aAH0csw=;
 b=WRrCw6SXrjf5CUbFg5VnBrUO1nXSzoYymjc++IIlwg4C0dySob/SEGVKY0kA/k2HjtFc7+
 GBnpSpVWfVLJQah6WCtvuMnVXerXkGZ0GWpm6pZyAEDJ1z3w7GqZ/Qh4Z62VnX5eKqmsfs
 cR7tVBmftb8/lSZMGiEOiarAQarQ4is=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-mPUPPnYIP0WD2VbuHem4zQ-1; Thu, 23 Oct 2025 10:27:27 -0400
X-MC-Unique: mPUPPnYIP0WD2VbuHem4zQ-1
X-Mimecast-MFC-AGG-ID: mPUPPnYIP0WD2VbuHem4zQ_1761229647
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4e8b8db4a35so25469411cf.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761229647; x=1761834447;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ejov+DXYA6q0ZVkJsV1kdKg4rKTnu258ot1aAH0csw=;
 b=YwIcgrlTsCNwO+heoaKFRdQe9n9KP9g3f6+3bk3nCPvkLdMf75bYFtBG2jYsunDYaf
 mrFJ8MRUjYsvooaNzNb9/tKqANx8LI9xS2rTSzSspepaQ4oAWAJ61jZYVaoZ1a7Msa+p
 czkEkqc4rDgZIHHGH2cKv5EdsPBDFlZPCjkyfATD8tKEWpAdvgs7oPp3uduOBXGZUnm2
 8GUSCnRsUUI0wmkdw1Dk8PsORYM2wRhLZzosEwQ0xN2A5aXuJ6Bk4io6G4nn3VVY1KKm
 DSY48UyaJ+yOPMStycdZaRUP59LXKtNlc5n93jzlXXV4DtitIEQl7kP8dwycgZ8QQ33d
 q7Zw==
X-Gm-Message-State: AOJu0Ywr6Cc9ijU21UdedTB8iNzNPau4vDzfjEfihomHqaocaUAjf5Lk
 yb8sgt6i9Nrwpuq7/BCVj1ZsxcixyRReXMZu5JpPcRsrnBg+w4v/vqub5jhl6+PMqJx2FF7vW3Z
 BnMT37nyEPj2bCtz7ibM+t20lj+V2R061Y7/g8qe5OUR27H1/HycGR0ny
X-Gm-Gg: ASbGncsFjPptnWAIWxeXkGkGpRVQxML4Xspvkd79zHaKl9EWIGWhtIFqRDFLMPtRLQX
 iBT7f0Jh1P5dbLu9+fQO824hgMsEJiSjaLgQxjfOvIO35ePRa/H0xb9WuAKFRSZB0yAB6sZTFt1
 yn+AP3u0YKK+7HKcfIVjWvRGQIXJckuQ61MnGQfMNeQWTIbPcfYo2lw50+puXMcmBkB0hcrh12a
 7ejTBFzgiA2r9V7CxXtT7FaNsiRXM9TRCrCOo3SyNfSovpbGknG8df8YYCNYcou1eLS7hDv12FK
 iRrtKmjavYMBOJiwAjg0RiaRoCkwbnx9h6XR5MP7T1lEVyRGzJrjbOq7EERGGY63LH8=
X-Received: by 2002:a05:622a:494:b0:4e5:8180:d4fa with SMTP id
 d75a77b69052e-4eb8153df25mr32716371cf.39.1761229646993; 
 Thu, 23 Oct 2025 07:27:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBENeZS+CWHvrlMAxXqOpAO07BPl8MCVRWYFroZ3Ir/aKPCV23xJux82ztI8lqZ5CKrE2Dnw==
X-Received: by 2002:a05:622a:494:b0:4e5:8180:d4fa with SMTP id
 d75a77b69052e-4eb8153df25mr32715821cf.39.1761229646432; 
 Thu, 23 Oct 2025 07:27:26 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4eb80697747sm15212931cf.16.2025.10.23.07.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:27:25 -0700 (PDT)
Date: Thu, 23 Oct 2025 10:27:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH] migration/qmp: Update "resume" flag doc in "migrate"
 command
Message-ID: <aPo7Sw29g_gdOD0k@x1.local>
References: <20251022190425.2730441-1-peterx@redhat.com>
 <87cy6eb25c.fsf@pond.sub.org> <aPozyk9Do9iu32G4@x1.local>
 <87sef94suf.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sef94suf.fsf@pond.sub.org>
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

On Thu, Oct 23, 2025 at 04:04:40PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Oct 23, 2025 at 07:47:11AM +0200, Markus Armbruster wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > It wasn't obvious how the resume flag should be used when staring at the
> >> > QAPI doc.  Enrich it to be crystal clear.
> >> >
> >> > Reported-by: Markus Armbruster <armbru@redhat.com>
> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >> > ---
> >> >  qapi/migration.json | 5 ++++-
> >> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/qapi/migration.json b/qapi/migration.json
> >> > index be0f3fcc12..48856078db 100644
> >> > --- a/qapi/migration.json
> >> > +++ b/qapi/migration.json
> >> > @@ -1732,7 +1732,10 @@
> >> >  # @detach: this argument exists only for compatibility reasons and is
> >> >  #     ignored by QEMU
> >> >  #
> >> > -# @resume: resume one paused migration, default "off".  (since 3.0)
> >> > +# @resume: when set, resume one paused postcopy migration, using the new
> >> 
> >> Scratch "one" unless there can be more than one.
> >
> > Sure.
> >
> >> 
> >> > +#     URI/channels specified to replace the old/broken channels.  The user
> >> > +#     should make sure the migration is in "postcopy-paused" state before
> >> > +#     the resume request.  Default "off".  (since 3.0)
> >> >  #
> >> >  # Features:
> >> >  #
> >> 
> >> What happens when migration is not in state "postcopy-paused"?
> >
> > The QMP command "migrate" with resume=true set will be rejected,
> > corresponds to:
> >
> > migrate_prepare():
> >         if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
> >             error_setg(errp, "Cannot resume if there is no "
> >                        "paused migration");
> >             return false;
> >         }
> 
> Makes sense, thanks!
> 
> I'd suggest something like 'Resume fails unless migration is in
> "postcopy-paused" state.  (default: false, since 3.0)'

Since it's still a "migrate" QMP command, should I use "the command will
fail"? I also re-arranged the words slightly.. would below look a better
next version as a whole?

# @resume: when set, use the new uri/channels specified to resume paused
#     postcopy migration.  This flag should only be used if the previous
#     postcopy migration was interrupted.  The command will fail unless
#     migration is in "postcopy-paused" state.  (default: false, since 3.0)

Thanks,

-- 
Peter Xu


