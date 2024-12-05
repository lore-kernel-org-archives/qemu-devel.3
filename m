Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFEEE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 22:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJKXL-0004tg-Oj; Thu, 05 Dec 2024 17:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJKXK-0004tX-Dl
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:41:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJKXI-00050D-4o
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733438485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/L6WxSrTathuGuWPPUO7E2o2zPORCQLI+kx/Mxx6K0o=;
 b=f7oL2RqAFf6CwypQBmgXvYnjX6wAHafk0uQeGphNweO2mBW/54uc/KOpZQujjfvhPuzBhe
 4xb1Q5pDxHJN77yHBiUqka3nxIgJ5AiNK0aw8fZg00O7M0LPGVv1gH9BBr9J7L3moOX620
 ksHKlhwyQcSOBt0zSASEoAklqS9+tV0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-32uAyOKYM1iFiVM2leeZ6g-1; Thu, 05 Dec 2024 17:41:24 -0500
X-MC-Unique: 32uAyOKYM1iFiVM2leeZ6g-1
X-Mimecast-MFC-AGG-ID: 32uAyOKYM1iFiVM2leeZ6g
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-46697645ceeso27941181cf.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 14:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733438483; x=1734043283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/L6WxSrTathuGuWPPUO7E2o2zPORCQLI+kx/Mxx6K0o=;
 b=TYqEBro0qDQPOQzmaIQsLoAIAFYe90Q1lLxM7noE6Gmc3Q8P0t/dOX9Eb8F+0lBf1L
 iuhL27Mv6rPbtoYimC9Ki0PZQu+VWol9izUYBRxN8F2TNFcdWSiTJVbfMSFpZaBQ2aab
 Ouvbu6VMyEeoQcv+4ZA8PzGoziHDTg/uzXNXiV2VI+4QwbEupHZ9Imc9HlKGRd06BFYK
 aDHzv2U20Xh4LZD0/yYikpKZ6mn/cIvo+kPZFTJ6Saz3Da4EC8wgJnfj0fwlm+OrHyLG
 aPvyGKpFv9PLyZAtHSuzjxTvEJuuXAtWyMD3O1ggOhjSenrhXTS0tqyDax1UZu4lrH9o
 LlqA==
X-Gm-Message-State: AOJu0YyVW98vmL81Is4cIc+VrXJgvDIBCD0zR6xYQ+GKOuw5pBTPQHAy
 64xu4bPmtp14WmcMX2yhg7+COPiD4S0qaFIgZvT2tcOHdt5dQ+mNN+kB0WkGEl+SDwPLX8TkgIf
 QVWyMCtoTWESsFK+EY0iurh4PXbPqA2OtxVto2PW65GfKGVGyrUFn
X-Gm-Gg: ASbGncvIXVEKvtP2vakzCTRu5unMf8xVf0eB4EiVYD2f5gTYW2P51ivYG0a87FCOPFE
 hzZRJ6C23LsXeqjpETNw2/TUXo9t78b+2bxWPBmzonmJ0NXkiVdA7BXHkswg+kwLbyvYvhi3ADq
 XyHatKa54+lh8S9xlAJi9oMf7C0rvqXgqpWbj2ek7dLR1xLwHHFSwcRbfLKymoSpTK5EuzHnmfY
 g0gg0hrmnGZtqszQ/xXQ/cD49UUxuas6HatM56ggYKJYyEv7as+I2zwx+LLgtEodT1bJyQt5ScP
 7n1l5qNa+T0=
X-Received: by 2002:a05:622a:90a:b0:466:a607:7858 with SMTP id
 d75a77b69052e-46734deb418mr21535171cf.35.1733438483595; 
 Thu, 05 Dec 2024 14:41:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnEskpsrNAeZdtFN/t1qSq5kid0jhIyxN391kxVU1VBDM60LOGlKzdyMYJy7qGBUO+teqmxw==
X-Received: by 2002:a05:622a:90a:b0:466:a607:7858 with SMTP id
 d75a77b69052e-46734deb418mr21534831cf.35.1733438483285; 
 Thu, 05 Dec 2024 14:41:23 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296a5f08sm12885201cf.5.2024.12.05.14.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 14:41:22 -0800 (PST)
Date: Thu, 5 Dec 2024 17:41:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v2 0/3] Allow to enable multifd and postcopy migration
 together
Message-ID: <Z1IsDhszjRu_mJQJ@x1n>
References: <20241129122256.96778-1-ppandit@redhat.com> <Z0nvv23M6bCnJrZc@x1n>
 <CAE8KmOyBUVF3DrLmwneM_paXH7uZeZPxzuS8Ae5LSnuJTow22g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOyBUVF3DrLmwneM_paXH7uZeZPxzuS8Ae5LSnuJTow22g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Dec 02, 2024 at 12:37:19PM +0530, Prasad Pandit wrote:
> Hello Peter,
> 
> On Fri, 29 Nov 2024 at 22:16, Peter Xu <peterx@redhat.com> wrote:
> > I saw that there's still discussion in the previous version, while this
> > cover letter doesn't mention why it was ignored.  Especially, at least to
> > me, what Fabiano commented on simplifying the flush condition check makes
> > senes to me to be addressed.
> 
> * It is not ignored. Simplifying flush conditionals makes sense to me
> too, that is why in the 'v0' version of this series I had added the
> !migration_in_postcopy() check to the migrate_multifd() function,
> right?

As explained, that addition was wrong, because migrate_multifd() should
always return the user option only.  Again, you can add another helper.

> I tried to discuss in the 'v1' thread if there's another way to
> simplify conditionals. Not sure if you've followed all comments in the
> thread.

I'll post a version to clean it up, either we go with Fabiano's, or mine,
or a 3rd option.  We shouldn't pile up more condition check there.  It's
growing into something not maintainable.

> 
> * Secondly, as you mention above, I also thought Fabiano is pointing
> at the complexity of the 'if' conditionals and thus I replied that his
> proposed patch does not seem to solve for that complexity. But in his
> subsequent reply Fabiano mentions that it is not just about
> conditionals, but larger complexity of how and when multifd threads do
> flush and sync amongst them.

Yes they're relevant, but I think we can cleanup the whole thing and it's
not that complicated, IMHO.  We'll see.

> 
> * IMHO, simplifying that larger complexity of how multifd threads do
> flush and sync can be done independently, outside the scope of this
> patch series, which is about enabling multifd and postcopy together.

I assume you're working on the test cases, I hope this won't block you from
continuing your work on this series.

As mentioned above, I think we need to clean this up before moving on,
unfortunately.  And I hope things settle already before you have the test
cases ready.  I appreciate you add the test cases for multifd+postcopy.
That's very important.  Before that you can keep your patch as-is, and
leave that part for us to figure out.  Feel free to chime in anytime as
well.

> 
> > Meanwhile, before I read into any details, I found that all the tests I
> > requested are still missing.  Would you please consider adding them?
> >
> > My previous comment regarding to test is here:
> > https://lore.kernel.org/qemu-devel/ZykJBq7ME5jgSzCA@x1n/
> >
> > I listed exactly the minimum set of tests that I think we should have.
> ...
> > In general, any migration new feature must have both doc updates and test
> > coverage as long as applicable.
> >
> > Multifd still has its doc missing, which is unfortunate.  We could have one
> > doc prior to this work, but it can also be done later.
> >
> > OTOH on testing: this is not a new feature alone, but it's more dangerous
> > than a new feature due to what I mentioned before, that postcopy needs
> > atomicity on page movements, and multifd is completely against that from
> > design POV due to NIC drivers being able to modify guest pages directly.
> >
> > It means multifd+postcopy bugs will be extremely hard to debug if we don't
> > put it right first.  So please be serious on the test coverage on this
> > work.
> 
> * I'm yet to get to the test cases. The revised series(v1 and v2) are
> posted to share patch updates which were suggested in the previous
> reviews. Test cases are a separate/different effort from source
> patches. If we want to hold on this patch series till we get the test
> cases and documentation in place, that is okay, I'll work on that
> next.

So we talked about this in our meeting, but still just to keep it a record
so whoever work on migration can reference: we do require test cases and
it's not separate effort.  We request both test cases and docs to present
before mering a feature, unless there's good reason to not to.

E.g. multifd doesn't yet have doc, so doc is not required for this work
yet, however test cases are.

Another outlier is VFIO+multifd cannot easily add test case because CI
normally doesn't have available hardware environment.  However does should
apply there to be required at least from migration POV.

Thanks,

-- 
Peter Xu


