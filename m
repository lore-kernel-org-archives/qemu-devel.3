Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA88C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 04:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdN2C-0001s4-CC; Thu, 22 Feb 2024 23:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdN2B-0001pd-Az
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:19:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdN29-0006Nw-PY
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708661976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQ1DekT4MltZp1po8fMR3o5/hw70gtfpqtv22kjWB5U=;
 b=cCkfJrtqkUZtCEBjWBhhHwUoy2dZZ2LFyQXlJJv8Bq8sKtVFA/gAmmaVt3ijFy4ZEE8Qlm
 Rzvxm3RuYJ9huXV9zfdfI5ovg2fBmqPDV2PzcxzRKZCIG2mDJT9ebrpc3lGbcN6iAipYEv
 fAKuHzNvMoSuMj/WhmwLjNHFHeNBG0c=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-q39IXGbsM9u9kcRSqX1Vww-1; Thu, 22 Feb 2024 23:19:35 -0500
X-MC-Unique: q39IXGbsM9u9kcRSqX1Vww-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1da0dd1dec4so1407055ad.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 20:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708661669; x=1709266469;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZQ1DekT4MltZp1po8fMR3o5/hw70gtfpqtv22kjWB5U=;
 b=W9nPax4Zg2nrTpyrIgvFcB91pXj6rMuT3iJ4wgGcTnISTowqeDW6jLAI3SSAYp8uCV
 5E1Bk9P7iinG9pmuH13PktnFmCSp5hF+Kdn3+Z9hXxbK/T9rbW6+TVFwf3kTWMEQ00fs
 cQKKRLEwpA/gvaI7fZxon4XZws0xnZc1/vCdJBsR9hlrog177csKxvipXi4mBJGqqbnX
 Ii2UIIvdAcF3rzZmhySP8WqBRvKOnzvBRMxl4aXIw0Uxy55NE+Z6qIs28pKC9CbS/byE
 UMUWCYPi+bg+z43meDhcC2amz3TgKk4t4T8a/Qq1ewOnh/iBNf/MOrqY3Oxc+i/LpqRx
 iMOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGI3cEmLU2RW5OIQUcU/WKMcJqlvzRNbThpKmUzHP7PTTxBYQNDCzUSoikpcSRanrfO5fIRVpMlFVgdzj6yoemxCjysgU=
X-Gm-Message-State: AOJu0YxKhi/OI5GWcPdAI4jYU5ZnKSdAlBFcBaWK8tQV34tduraA3w1n
 4QjXuEbISZf6aegXT5tseNokguhHMB3xvcdH7LmK2sk2EyrY1SBdUod6ot17Ur2Cg67St3/hLQT
 0cxPAmUam4K7zBBxEIOfWLoteiVJBxowptW0q7t2r8+pzALYDd4RA
X-Received: by 2002:a05:6a20:3d27:b0:1a0:dad3:a8ad with SMTP id
 y39-20020a056a203d2700b001a0dad3a8admr943568pzi.2.1708661669698; 
 Thu, 22 Feb 2024 20:14:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsvWbUM7b2d46Sjgdtq1WXO7hcB0j+n6NqA46iVrbu+6WoZWd9z1OZe3sIqPnuS+cm5MTN3A==
X-Received: by 2002:a05:6a20:3d27:b0:1a0:dad3:a8ad with SMTP id
 y39-20020a056a203d2700b001a0dad3a8admr943559pzi.2.1708661669381; 
 Thu, 22 Feb 2024 20:14:29 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 p12-20020a17090a348c00b0029a45b28d43sm368343pjb.14.2024.02.22.20.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 20:14:28 -0800 (PST)
Date: Fri, 23 Feb 2024 12:14:19 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 13/14] migration: Use migrate_has_error() in
 close_return_path_on_source()
Message-ID: <Zdgbm8i9KaSmOudk@x1n>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-14-clg@redhat.com> <87y1bvayu7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1bvayu7.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
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

On Thu, Feb 08, 2024 at 10:07:44AM -0300, Fabiano Rosas wrote:
> > diff --git a/migration/migration.c b/migration/migration.c
> > index d5f705ceef4c925589aa49335969672c0d761fa2..5f55af3d7624750ca416c4177781241b3e291e5d 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -2372,8 +2372,7 @@ static bool close_return_path_on_source(MigrationState *ms)
> >       * cause it to unblock if it's stuck waiting for the destination.
> >       */
> >      WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
> > -        if (ms->to_dst_file && ms->rp_state.from_dst_file &&
> > -            qemu_file_get_error(ms->to_dst_file)) {
> > +        if (migrate_has_error(ms) && ms->rp_state.from_dst_file) {
> >              qemu_file_shutdown(ms->rp_state.from_dst_file);
> >          }
> >      }
> 
> Hm, maybe Peter can help defend this, but this assumes that every
> function that takes an 'f' and sets the file error also sets
> migrate_set_error(). I'm not sure we have determined that, have we?

[apologies on getting back to this thread late.. I saw there's yet another
 proposal in the other email, will look at that soon]

I think that should be set, or otherwise we lose an error?  After all
s->error is the only thing we report, if there is a qemufile error that is
not reported into s->error it can be lost then.

On src QEMU we have both migration thread and return path thread.  For
migration thread the file error should always be collected by
migration_detect_error() by the qemu_file_get_error_obj_any() (it also
looks after postcopy_qemufile_src).  For return path thread it's always
collected when the loop quits.

Would migrate_has_error() be safer than qemu_file_get_error() in some
cases?  I'm considering when there is an error outside of qemufile itself,
that's the case where qemu_file_get_error(ms->to_dst_file) can return
false, however we may still need a kick to the from_dst_file?

-- 
Peter Xu


