Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A8CC982D6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7DF7-0005Tt-2J; Thu, 17 Sep 2026 10:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7DEm-0005T2-NX
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7DEk-0000ot-H4
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789655837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wzPfsIGovdQT2Rs/VimLkRhihk0xNZIASw9vF0ggNi8=;
 b=WqdqOKZoFT6B2CIm3kqOeZcpWy25ELsS9Tds3UJ07XbrzjJPV5JeKqQPOISfAtp9efLe4M
 f8+cVCejXwnanXU2SF3dqfRXBDMy55AVc2ViGcW00SSiVohlkn/XlixjeN3rueqiRGIhh8
 n477FPNMOxHWc+OJq5PW5L7P21yO78I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-ucLxvLOtMCKcSeoBVXFJCA-1; Thu, 17 Sep 2026 10:37:15 -0400
X-MC-Unique: ucLxvLOtMCKcSeoBVXFJCA-1
X-Mimecast-MFC-AGG-ID: ucLxvLOtMCKcSeoBVXFJCA_1789655835
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-530f5e827c6so19939881cf.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 07:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789655835; x=1790260635; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wzPfsIGovdQT2Rs/VimLkRhihk0xNZIASw9vF0ggNi8=;
 b=cNcL/gom6S3/2fF4nDnxljNjYem7C4CgU80DS6wHkkljkvYztOJ1QIYnjemmE+cMB+
 +CLiYawBKVJbWlpolaOjj5QbiX9taCMmRSwVsALWLTV8OUjpYMi6Dk2n+KbPFf3sXnUx
 ndjNxVvYraPD98g68SxgukQP6UTRO7q/Qoshp5K7FPKMlbVl9kSu/45FHtqxJiE1xkZQ
 P6OtL6+UDx+WI7CMgFzf5qDCn5r+2rSoFfrSDlLlrcV8tDomeYLY/Ijok2JqYh2ejEmG
 2HYjIRh/odhUb2maXcOlFrRd0WkOuzHa+HYqzQXaoxUfzc9nA7VsdDlpAYufomHemIgS
 Y+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789655835; x=1790260635;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wzPfsIGovdQT2Rs/VimLkRhihk0xNZIASw9vF0ggNi8=;
 b=sMtx+bZ16grRI+qpYhma3Z7x0M/irp9BcO8kmM6S3z35Q/u7dAULDvi6Y2wc+g6hTn
 kp1c7yyAtgwe7XpWlgQbwnbFGuax6XBsfkmOsckLtjJGF9aoD/Jzo7V1UUrp21lJxtUF
 oMYP2X2m2HXliF1v68KHD3ZcIxjZUpUMHfwwg67k2R3GVdrHsOVLW/GK/ygsj8F0c+9U
 uEqS1GXInabuRIPk5zg6uQd3dfxZjh8a5fdTGdX21MFddzQXwP2f2LKMxHXpSsMASLHR
 jMXE8r5q/BXJaFTgmnUNzNUtNSgjL2r9oIsD7/CX+NAcStH8oexr2C06ZWAMgoOYLB0j
 mxtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByfFaGQJKFJkF5xeZnhTM9q2Joj3oAh2oYuVdt3kgFF8KZOSzbZ1S5qodlWR+j5Pq5zLmlQuAke3Qgj@nongnu.org
X-Gm-Message-State: AFuF++l7mCVs6JpdWw9mlsmVu8JIsMupVE6osHfrekcVMPIHekRjdi0V
 t0rm0XbRbO/vlm4QOdTzJrbtXXqfAkgxa8gJnYl0J30O7/FUBhN/jXNiIM+j+s1tq+o4fpblO+4
 /LMt9N5xnnAwFcTMN96HvTItYgyST6T7HIWWwbXjAXzDKAM1BI6EWxsjo
X-Gm-Gg: AYBFou1W6f64s1l5P1GT1HICeP/dbzRzcdD3LvN7aIuX6NtnJExSzQgsCR8ihsBcyo4
 vVDAwDBDb0jWLBGZjDTT4enqNCoe/HXjgOw8OEtbqyMJv1Tahl22mnch36ZHgb6vBn7YIJikQya
 sNst4owcpXmYLhXgJ1nZDm9/PV1K2iVQ8qBFUdGUmeDMxMEH+vWCZpYb143ASOM4HxoISAV3IPs
 ChT+sih3zp2nC/wgxfD0kEdPNwceAKXtWBaQWfx98MGYETLaKwH9nbQvwv9tirLIaCAWeyrd06F
 AcEwBmDIBpD/4MnWI4dECNujD7NEgSOltD1SKZCsDHa8py3kMj377VnOEBrfao5Pbe3ixCw=
X-Received: by 2002:a05:622a:98a:b0:532:9ade:b6f7 with SMTP id
 d75a77b69052e-5329adec5f0mr10178871cf.77.1789655834820; 
 Thu, 17 Sep 2026 07:37:14 -0700 (PDT)
X-Received: by 2002:a05:622a:98a:b0:532:9ade:b6f7 with SMTP id
 d75a77b69052e-5329adec5f0mr10178341cf.77.1789655834302; 
 Thu, 17 Sep 2026 07:37:14 -0700 (PDT)
Received: from localhost ([2605:8d80:6cc5:ca21:5af0:e7f:3a22:9538])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532620c2ffbsm51495881cf.27.2026.09.17.07.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:37:13 -0700 (PDT)
Date: Thu, 17 Sep 2026 10:37:11 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>
Subject: Re: [PATCH 1/1] migration/cpr: lock the cpr state
Message-ID: <aqv7Fxeog6EiZ1xm@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260916132428.1628553-1-den@openvz.org>
 <aqrhPxFO7zHvZgs5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87v785rpml.fsf@suse.de>
 <aqrwAftZOnT4LsI6@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <88028fa0-6b8d-44a6-8a59-41480b9d7b69@maciej.szmigiero.name>
 <aqve6zlIKMMcIfKV@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <aqvgvw44pMtCZRGB@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <fdabb32a-cb79-40cf-ba68-2de565aae639@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fdabb32a-cb79-40cf-ba68-2de565aae639@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 17, 2026 at 04:17:54PM +0200, Maciej S. Szmigiero wrote:
> On 17.09.2026 14:44, Peter Xu wrote:
> > On Thu, Sep 17, 2026 at 08:36:59AM -0400, Peter Xu wrote:
> > > On Thu, Sep 17, 2026 at 02:24:42PM +0200, Maciej S. Szmigiero wrote:
> > > > Isn't moving to more fine grained locking than BQL desirable in the long term,
> > > > much like BKL was split and removed from Linux kernel years ago?
> > > 
> > > My question was more seeking the issue behind.  CPR is pretty special, I
> > > didn't expect any new fd addition didn't already take BQL, at least before
> > > reading the last message.
> > > 
> > > I don't think we should randomly add lock for any structure that is
> > > currently protected by BQL, it'll unnecessarily slow things down.  We
> > > should only do smaller granule locking when we can consider getting rid of
> > > BQL in the first place.
> > 
> > Now having some understanding of the issue, I noticed I'm not very certain
> > whether this small lock can avoid all the issues.
> > 
> > Consider a race between cpr-exec migration at the very end, cpr_exec_cb()
> > does cpr_exec_preserve_fds() walking all the fds, then another connection
> > established in monitor iothread trying to add a new fd.
> > 
> > In this case, when without this smaller lock, it may crash accessing the
> > hash.
> > 
> > When with the lock, two operations are serialized, but is it enough?  It
> > means cpr_exec_preserve_fds() may take the lock first, mark all fds
> > reserved but without the new connection.
> > 
> > Would that be a problem?  Theoretically, cpr should persist all fds in this
> > case, including the newly attached?
> > 
> > Maybe it will never happen in practise because libvirt should never add
> > another connection there, but I feel like it's more than "protecting
> > concurrent access to a hash" problem.
> 
> I though monitor connection FDs aren't CPR-preserved in the first place, no?
> 
> And if you meant a monitor adding some non-monitor FD, I think this will
> be handled in the main loop anyway (and so, serialized) via qmp_dispatcher?

My commnet above may not apply to master, but Denis's branch which
originally exposed this problem.  And I confess so far it's kind of my
interpretation of the issue from reading Denis's email, it may or may not
be accurate.

My understanding is the connection happens with the iothread not main
thread from a client, it may not really need bql.

Denis may have more info when he collects enough info, and correct what I
might be wrong.

Thanks,

-- 
Peter Xu


