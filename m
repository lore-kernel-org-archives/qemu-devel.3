Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD40D6ACC0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 11:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGGRs-0006RG-11; Wed, 27 Nov 2024 06:43:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tGGRp-0006Qs-PQ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 06:43:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tGGRo-0002qm-8I
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 06:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732707784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0/vlqXVux/RQHuw6gh5sec0qZ+V5N9H8mf+xafWeiOs=;
 b=UcYlvgBdYtNHBphoFoWregsxYOv2ld4S4hn1hDAMkVXAmJGl98ctJCCBJmvKlna+gKGcZ9
 ELebnPLs4acXxSoM8xa4pnAHN54AmKOCWD/pWiu7+HRPF8+skkAMbhVTuhFjACF+ie56Qz
 4G0SLBwFre76zdyPMBbAmmXLWmuVp+M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-zwPg2XufNOCcLw1v8p8YCw-1; Wed, 27 Nov 2024 06:43:02 -0500
X-MC-Unique: zwPg2XufNOCcLw1v8p8YCw-1
X-Mimecast-MFC-AGG-ID: zwPg2XufNOCcLw1v8p8YCw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3825a721afaso3944097f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 03:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732707781; x=1733312581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0/vlqXVux/RQHuw6gh5sec0qZ+V5N9H8mf+xafWeiOs=;
 b=NxqpGUHUhPf0ZoxIl8huUFaiF4G8HZdG5C+Rk7uOMqNYFWj9DVDQHRa6ewbRmbiwEM
 ALbP3Wgyq6yQYEcZTH9e6OMA3i32QQUa/Yy1Gkp/6nhIkovmO9kea8wyastGmmelxXH1
 4HYq7xwhjlbQJgQkyHPJ4ZlSH3szEOTnDMCoM+R3SvRoBZ86W++7Rg+1MdVUpAhOkMlI
 OQTwZ4WbQMkRi0JwLTvEsZcP4CbexO6D7/ekxDEIuz1Z3GAQZm5U94bW0sN08B0Kt8+k
 8nfXmByHRxhnXcYB6rRa0wkvBxEChwroYp7tsTaD8FA8SfYCakPLiueWU0NJSV8xiuRX
 kqAA==
X-Gm-Message-State: AOJu0Ywlfqo457ccw8/z/umuw5nY9OCnmT4r0h3EzjJQ4/CJQDnwAWq/
 hC+gXUwZPSc7R2SRdt7I4nMPI3NmoPJVThgr2huUChFcHlO/AbA+owyQdL81j/KWmv4OunIHc/b
 JUz6V00BgaY8O0jaT1W3kVgT7DdRmO3+IKV0hi79RFTeheogCHGr35863P4NVpFmSgRHXxumcBv
 r77k5r6YuRAe7JFhDV9EyQzyPmkEozSSdUUc8=
X-Gm-Gg: ASbGncuLSIVattUAVXU3J87SJdRszO7oXxMCgCEgCNxE9pz6CEAOll3CM+YU3tSuINe
 S+KXZxn5vxtLGK/pSMdY5Rhc9m4fVdcplOw==
X-Received: by 2002:a5d:47ae:0:b0:382:4eef:28a with SMTP id
 ffacd0b85a97d-385c6ed75c6mr2110420f8f.43.1732707780781; 
 Wed, 27 Nov 2024 03:43:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEajC+6PRPlTZYsgHIq53iPDra8pPPl6SBd6c1SjlWDrosf1sUpXwCDmo1OngG3nPzEhA2IsoV+/Q02ZnW4NMQ=
X-Received: by 2002:a5d:47ae:0:b0:382:4eef:28a with SMTP id
 ffacd0b85a97d-385c6ed75c6mr2110399f8f.43.1732707780501; Wed, 27 Nov 2024
 03:43:00 -0800 (PST)
MIME-Version: 1.0
References: <20241126115748.118683-1-ppandit@redhat.com>
 <20241126115748.118683-4-ppandit@redhat.com>
 <87ed2xn16y.fsf@suse.de>
In-Reply-To: <87ed2xn16y.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 27 Nov 2024 17:12:43 +0530
Message-ID: <CAE8KmOwfzFyBWfq_Vhr-hjT4jGQQqi6_gZwkNGtd8SVLxhi0QQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] migration: refactor ram_save_target_page functions
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

On Wed, 27 Nov 2024 at 02:49, Fabiano Rosas <farosas@suse.de> wrote:
> This patch should be just the actual refactoring on top of master, with
> no mention to postcopy at all.

* Okay. We'll have to ensure that it is merged before multifd+postcopy change.

> > +            if (migrate_multifd() && !migration_in_postcopy()
> > +                && (!migrate_multifd_flush_after_each_section()
> > +                    || migrate_mapped_ram())) {
>
> This is getting out of hand. We can't keep growing this condition every
> time something new comes up. Any ideas?

* In 'v0' this series, !migration_in_postcopy() was added to
migrate_multifd(), which worked, but was not okay.

* Another could be to define a new helper/macro to include above 3-4
checks. Because migrate_multifd(),
migrate_multifd_flush_after_each_section() and migrate_mapped_ram()
appear together at multiple points. But strangely the equation is not
the same. Sometimes migrate_mapped_ram() is 'true' and sometimes it is
'false', so a combined helper may not work.  It is all to accommodate
different workings of multifd IIUC, if it and precopy used the same
protocol/stream, maybe such conditionals would go away automatically.

> Yes, although I wonder if we should keep documenting this when we only
> call this function for a single page and it always returns at most 1.
> >          if (page_dirty) {
> >              /* Be strict to return code; it must be 1, or what else? */
>
> ... this^ comment, for instance.
>

* Okay, can remove them.

So to confirm: this refactoring patch should be a separate one by
itself? And then in the following multifd+postcopy series we just add
!migration_in_postcopy() check to it?

Thank you.
---
  - Prasad


