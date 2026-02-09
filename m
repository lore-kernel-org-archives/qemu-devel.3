Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF359E81BD3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 15:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpTL1-0008O6-HN; Mon, 09 Feb 2026 10:38:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpTKw-0008N7-GF
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 10:38:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpTKs-0008NJ-1f
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 10:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770651480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4fVkCMeSefvAGS9QMhKynYAx0VQQYLmAa7qJeVRuQ1Q=;
 b=h1wwu+qRi86j/LCw+Z6XlTzVyJaacrbS++JG7dlZKM1cQazDaP+G+aqrFRYim22m2g1eY2
 To8Ct7ig1+Ly3LpWqhaHhInA51DKk8c0oTUUjFXEUorgZhGcKFKVzHZb1Pok3RAkCdz1s9
 HRQybX/HLcdu1JXMrRmVmkIP2qWeW6A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-ssJ7F9w1OZebOZMNqRqHaA-1; Mon, 09 Feb 2026 10:37:59 -0500
X-MC-Unique: ssJ7F9w1OZebOZMNqRqHaA-1
X-Mimecast-MFC-AGG-ID: ssJ7F9w1OZebOZMNqRqHaA_1770651478
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c70ab7f67fso1372924585a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 07:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770651478; x=1771256278; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4fVkCMeSefvAGS9QMhKynYAx0VQQYLmAa7qJeVRuQ1Q=;
 b=MpicW1xLCUCmwFdhce7bC6rZFfh2jnc6c5+fgPkk0DbUr8l7x/HcWhYhCqe4d4Xd5A
 iDe5PLMiXDoGTHeQy5AbjrG3V60AyYpORgRpU4zS6wTV7sEYtRsVFTsKYlr7NJhla4oX
 o+8jk/56gbKyqi6I1oKxXVK6luntFdZSRPCEj5Iie5XJvnYvcnfMhUF5EOO8uBWLY2kU
 BXIiLlsc2XKcFyi2+PezU+Mw98l4V6QTsU16GEkpEIen6kJSrCGCu3X5bIsnKucSBuZt
 Jf4mrPJzwB+BldKe6EHjU+v8A9d1BPd+6s+lZb7uSIhwstHOsjAiv7fsRAMPeCjeRmmj
 kQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770651478; x=1771256278;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4fVkCMeSefvAGS9QMhKynYAx0VQQYLmAa7qJeVRuQ1Q=;
 b=etB0A7Qde66KywdwoRyYWojmiGAPBy2O9uymY0KSvdS/k1dAPNzoc9cQCJQ9biJ+5r
 /tZIJpcgLrrsVhTsR8YATCd9JQAGJDNdI4BgNCOrcTe3lioYW1MdrDJU0QliN1Kd0g5Z
 ytPsM+mijtnWYES5z9qzS3sJgz3ex3LUi6NlmS7FlxzplrulzZCqxqXt4S1gyhMicKPi
 PDJkXV92J0aeG/REnklVwthgZOzaND0FzMM6dQtnVThZG9ncE0HfQImTqYBHgFfNxHSm
 i2XDG8kRqTJQSV8W8Bu616Fs0tL7MN9pqBnLa+2GiYu7Y4IdIOxaOnkDlhs+711zbqbg
 6TKg==
X-Gm-Message-State: AOJu0YwQCShvhIZT81/vLQ9HP7cDf392eAXkVFmzqmRnY8UG2z2wm/cG
 i/Ahs6xMB6bYlduZADdwT6f4BcnJotp8vjkdaBSX5RkxaCIlJ2dDCtcnrGyRj0GhQlcyjke6Gdx
 mzvGB0TTslFb4GG6Xqf/gfZZXZZRNlkSGdGnGAF/nMBeFgff05QL/h9tjk4+6K6gu
X-Gm-Gg: AZuq6aLrckyJgD0bhYu/NheAC6Eg7p4WsMmpEBa6hNsoiUw36OxUE5PWmu48pDSfdKm
 Kr/C44xXbk5IxcwKZ56t4d+goXqoIR8uE6RKGqR7yCDmkM8sbVrTBviSySfflshLM1KEA5ZXbuu
 LYvkZggtNxTPefPHWRL6ZaPihcjQMUWBN+bFcU+B+5N+99ChKCqVJp71AUAiBu8RJrnHb4VkeVp
 4XJEgHaX4IkRfoWqXPFg9onJUaKf/RN469bLoOO/MSROMdRwERfhHBG1qZL773zK3FUiVBtyqpc
 H1WjnKtmxmp50QSnyNSTYlCwQGu4v9FAd1YKaIBYV+64U4iFhuCaCS0Oef0N1qTyZzSEiMM48mJ
 cCng=
X-Received: by 2002:a05:620a:192a:b0:8b2:767c:31ab with SMTP id
 af79cd13be357-8caf15f3b87mr1514545285a.60.1770651478158; 
 Mon, 09 Feb 2026 07:37:58 -0800 (PST)
X-Received: by 2002:a05:620a:192a:b0:8b2:767c:31ab with SMTP id
 af79cd13be357-8caf15f3b87mr1514541785a.60.1770651477608; 
 Mon, 09 Feb 2026 07:37:57 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf9a16240sm836785585a.35.2026.02.09.07.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 07:37:57 -0800 (PST)
Date: Mon, 9 Feb 2026 10:37:56 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ppandit@redhat.com
Subject: Re: [PATCH v2 8/9] migration/options: Stop freeing s->parameters
 members individually
Message-ID: <aYn_VBkEGVpAZUEh@x1.local>
References: <20260202224101.20568-1-farosas@suse.de>
 <20260202224101.20568-9-farosas@suse.de>
 <aYUWwSxnsWn1Dfu0@x1.local> <87a4xmqcmn.fsf@suse.de>
 <aYYU5fbU5l4grFav@x1.local> <87343dd53c.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87343dd53c.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Feb 06, 2026 at 04:50:15PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Feb 06, 2026 at 09:29:04AM -0300, Fabiano Rosas wrote:
> >> There's some amount of rigidness caused by qdev requirements
> >> unfortunately.
> >> 
> >> I'm not sure if I ever posted it, but I wrote some code to move the
> >> parameters into a MigrationOptions object so we could make
> >> MigrationState not be a TYPE_DEVICE anymore. But then we'd end up with
> >> something like -global migration-options by default, so it kinda killed
> >> the idea.
> >
> > It's not strictly about TYPE_DEVICE, but reusing of qdev properties, right?
> > At least the issue described by your comment was about offseting and it
> > sounds like so.
> >
> 
> Absolutely, I was just rambling.
> 
> Of course, TYPE_DEVICE brings us weirdness such as:
> 
> (qemu) device_add migration,help                             
> migration options:                                           
>   announce-initial=<size> -  (default: 50)         
>   announce-max=<size>    -  (default: 550)        
>   announce-rounds=<size> -  (default: 5)    
> ...
> 
> So it would be nice to drop this dependency.

Yep.  I'll move my (below) series higher priority to respin, likely I can
drop the QOBJECT_COMPAT idea that didn't attract much attention, but
instead I can stick with exporting the qdev property helpers.  It'll be
enough for us to make migration object to get rid of TYPE_DEVICE.

> 
> > I just want to double check with you that I think the problem you described
> > will also present even after applying my other series:
> >
> > https://lore.kernel.org/r/20251209162857.857593-1-peterx@redhat.com
> >
> > That series only removes the TYPE_DEVICE dependency, but not qdev
> > properties.  I think it's the qdev property trick that is relevant at least
> > to the offset issue you mentioned so MigrationParameters cannot be
> > g_new()ed.
> >
> > The major use case for this qdev reuse is: (1) help scripting, so as to use
> > -global migration.XXX=YYY, (2) support migration in machine compat
> > properties.  IIUC (1) isn't a major thing we ask for (again, maybe I used
> > the most of it.. but maybe only me; I'm not sure..), as long as anything
> > can keep (2) working then we can consider.
> 
> The properties are also useful in providing defaults for the migration
> options and perhaps we could make use of the .get/.set methods in a more
> convenient way in the migration code, such as implementing per-option
> input validation instead of checking all options always. (although I
> haven't thought about the overlap with QAPI)

Yes good point.

Said that, currently if we're still with qdev properties we can't easily
inject those checks due to the hard-coded get()/set() for qdev properties,
e.g. qdev_prop_uint8 will provide its static get()/set() hooks.  We either
need to teach qdev props to take check functions, or impl our own (then
we'll need to provide the default_val and machine compat features).  Maybe
it's easier to do the former, and maybe some other qdev props can leverage
too.  Not an immediate concern.

> 
> About -global, we should do better to separate the compat options from
> the regular options. (and no, a blank line in options.c is not enough
> separation!). I worry someday we'll break something in compat while
> trying to change the regular options.

Normally if we have something in machine compat properties, those shouldn't
be used for normal users.  Those, importantly, also shouldn't be present in
QMP set parameters.  That should IMHO be the line to identify a real compat
option v.s. a real parameter, because we do not expect normaly user to use
-global, only advanced, so one knows what one is doing and taking the
risks.

It actually makes sense to still be able to adjust some internal compat
behaviors if an advanced user really wants; that might be handy for
debugging in some cases to overwrite machine compat properties, even if
extremely rare.

> 
> Another point is that even after all the recent changes to options.c, we
> are still left with a list of migration_properties that is optional to
> use. Which means setting defaults is also optional.
> 
> If we decide to retroactively add a default we'll suddenly have a new
> option showing up in -global! Having to discover mid-way through the
> implementation of a new migration feature that setting a default like
> the other options do will also add property code to your option and now
> you have one more source of SIGSEGV is not super fun either.
> 
> I had the intention to somehow force every option to have an equivalent
> in migration_properties so that every option would have a default
> explicitly set, but seeing the recent work on fixing the StrOrNull
> property, I don't think it's worth it to ask that people go through the
> hassle of implementing a property (when the new option cannot use the
> existing types).

Right. We can discuss this case by case, normally I think we should always
welcome the same parameter to be added into migration_properties[], most of
them will be simple scalars so we shouldn't worry.  We can make it optional
if it needs extensive work on new types.

-- 
Peter Xu


