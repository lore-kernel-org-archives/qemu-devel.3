Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7EAC4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 23:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVgpT-000604-Hg; Thu, 01 Feb 2024 18:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVgpS-0005qT-Kh
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 18:50:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVgpP-0004jn-DK
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 18:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706831442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OsOmfDMb/3n1aE0Fy4zhJy8iHHHUKzjdYqB2YN9s97g=;
 b=LlIpamGp+Y9jy0x9xgzrnMLX+iVKWytYq0jUXlQ7+okzR1pGX5Kp8N8D8qyZuy5gdUQts4
 nG6PrCKNUzh7pUGfJAXgTCorZ1bqKuccHeM8OhjPsYACwTOcg4syoH6WtF47UlWU7GRL2G
 tOZQYXqE1ZmLHNGWJ9/YygUtPQz8cIs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-JefF_bs-O0O_pKqnFIPcoQ-1; Thu, 01 Feb 2024 18:50:41 -0500
X-MC-Unique: JefF_bs-O0O_pKqnFIPcoQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2961fca4282so196612a91.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 15:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706831440; x=1707436240;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OsOmfDMb/3n1aE0Fy4zhJy8iHHHUKzjdYqB2YN9s97g=;
 b=D2759zBr1JlmHLLgCW9J0iSkwi5BL4QSufAicS1xYqeXXpV4pdPnKWRSZR3tpHGOxg
 N8EvdRU82HpR5GYx4GKjxVYkXFKeLpZMKlkQUFKLTAuWP54f4c5bJfV4McH2AKCWLGhS
 LNPMDt6fiOTByR45xIbjyEQFfVumRbjA5UQD9GxcUaWipxwON1RdqEvG44yoA0XXng7H
 6S4KxH8WpqwEFsWjok/glIT1I0j9J0tVEC4aFJxwrvaTd/MawCY+6BzP2WPQRHLJ6ZUf
 3wnPzeACqtSjc88AslBcTjaDZNnuMlITvXwFf40KqkJUc7yag5opS7NEukvo2Z02DD1Q
 jhIQ==
X-Gm-Message-State: AOJu0YzR18HxAX9daMr/aIuKhZ2R7y1SU55rV4G9hZPjLNGO2ycPP91J
 BXZxQZVoFhKKveW+uJCrGsKNJKF19Q+KfyRwm2BADT9LQvtZwMSF4W/2pJruusjBnR9+9m0FBI2
 6JZLAc2tjBYDHxJgf5c2sbXEsyFgWWxRmXSQPNGro3ytXl06PHzZM
X-Received: by 2002:a17:90a:ab8d:b0:290:f5f7:caff with SMTP id
 n13-20020a17090aab8d00b00290f5f7caffmr6426250pjq.3.1706831440182; 
 Thu, 01 Feb 2024 15:50:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7T7ZVQjW/NZ0bC+AlenJTjQlH4F4A2MVi4cubPfQsibYbH5wGub/WGip6w89DaZe5A1vGrw==
X-Received: by 2002:a17:90a:ab8d:b0:290:f5f7:caff with SMTP id
 n13-20020a17090aab8d00b00290f5f7caffmr6426229pjq.3.1706831439780; 
 Thu, 01 Feb 2024 15:50:39 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWK6GX7OesuaaHMjbXygkXi3+xcf6BS9POAbDRXO6iZtE8PDNDaKPAB9/nVcyEe4iY9LKhkYuwf63u2neSNac1DuiwZm0fBXtiJ9a6b5pp1sZXD8mfZWndqW3KiSsS3Jw==
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 nt7-20020a17090b248700b00295c8c120dbsm4277136pjb.20.2024.02.01.15.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 15:50:39 -0800 (PST)
Date: Fri, 2 Feb 2024 07:50:32 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Subject: Re: [PULL 06/15] tests/qtest/migration: Don't use -cpu max for aarch64
Message-ID: <ZbwuSM7LjWCsa_VB@x1n>
References: <ZbcSqyGNLGu7ugBb@x1n> <87sf2ge3qu.fsf@suse.de>
 <87y1c7ogze.fsf@suse.de>
 <CAFEAcA_BPf4LSh-JF1NVVVdaLoKgUcsnGeP7sHt-f73r4zyh7g@mail.gmail.com>
 <ZbjT5OYpzNJjkMw9@x1n> <87wmrqbjnl.fsf@suse.de>
 <ZbnG3qkMBPdsQxan@x1n> <878r45lkeb.fsf@suse.de>
 <ZbsIYKJ5fYG6zsVi@x1n> <87y1c4ib03.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1c4ib03.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fabiano, I think you forgot to reply-to-all.. adding back the list and
people in the loop.

On Thu, Feb 01, 2024 at 10:12:44AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Jan 31, 2024 at 10:09:16AM -0300, Fabiano Rosas wrote:
> >> If we ask for KVM and it falls back to TCG, we need a cpu that supports
> >> both. We don't have that. I've put some command-line combinations at the
> >> end of the email[1], take a look.
> >
> > Thanks a lot, Fabiano.  I think I have a better picture now.
> >
> > Now the question is whether it'll be worthwhile we (migration) explicitly
> > provide code to workaround such issue in qtest, or we wait for ARM side
> > until we have a processor that can be both stable and support KVM+TCG.
> >
> > I actually personally prefer to wait - it's not too bad after all, because
> > it only affects the new "n-1" migration test.  Most of the migration
> > functionality will still be covered there in CI for ARM.
> 
> That's fine with me. We just need to do something about the arm CI job
> which is currently disabled waiting for a fix. We could remove it or add
> some words somewhere explaining the situation. I can do that once we
> reach an agreement here.

Yes.  IMHO we can keep the test (with SKIPPED=1) but amend the message,
which will start to state inaccurately:

        # This job is disabled until we release 9.0. The existing
        # migration-test in 8.2 is broken on aarch64. The fix was already
        # commited, but it will only take effect once 9.0 is out.

IMHO then it won't mean 9.0 will have it fixed, but we'll simply wait for a
cpu model that is ready for both kvm+tcg, then we replace "max".

For gic_version, I knew 3 was there for quite some time so maybe we can
start from that?  Or we need suggestions from ARM people.

-- 
Peter Xu


