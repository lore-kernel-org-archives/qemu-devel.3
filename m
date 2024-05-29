Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A57C27C44
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLYC-0003M8-FS; Wed, 29 May 2024 11:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCLY4-0003Kk-UU
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCLY1-0007lM-WF
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716997744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qIq4sT9qoD04V3my5vqGCekTfJw8GrcOvSo7H00yX/E=;
 b=EoFoyXGfHvNIXVItFrS5upg6m4Y0uzvRo0Zx3dwqptnUhVl2dMlsbO1WNI/MuxMw0QKxtF
 e0+3Kq8wh6K7yHYkiPNc5q/lPXd3uPChvm78pH9n/arVKevhI1K3benDR8fHHBUuPr4LOe
 54A4BhT/zIrWx3LyHHvmMsq/jRki39k=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266--OrCsc5zMZ6q-pA5waIRlg-1; Wed, 29 May 2024 11:49:02 -0400
X-MC-Unique: -OrCsc5zMZ6q-pA5waIRlg-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5b3332ae946so641904eaf.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716997742; x=1717602542;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qIq4sT9qoD04V3my5vqGCekTfJw8GrcOvSo7H00yX/E=;
 b=MBjQEePjvFAMCR5eJVqo6lzdk4cgaIbU5m7+bliZf97mfKnI8niQ7Lp3VWVM4eu5hw
 E18U9zDME0F/5gVns07XCczC4oLfvSTCz1OLYuMnc65BV+UvreFikeR12OzGfRCuuM2F
 YDueqNOuO+rBMzZpI4zA0OseqMOLL2ynZua4IHQP51QUO6Shw2gw3NiUpvQYhtrRoeaT
 o7lDPdm9KaE5JTpz+HCugiU2bn9QNm5GOALah/CkKjlec6pMtnRsNGViFZimI+xrhZf7
 vHN2nn7jmWO/z3isqpz7Cz0MGhct57sXDxZD+IUSBHffNc4P2bjbHh3F4mVmTkpXwG4a
 4vrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4IN9va6oT1ZBwXe3IF4pBT2S9ec2bFkjXJjYfVYhdYUTLgII7XSGYey+Mr0/p9S7N+RntZF60eQsJoGbhNVtjA+epLT8=
X-Gm-Message-State: AOJu0YxF3rz/Tgs90pYCRN7H3Qk0bjk5ZnCCYPohd6P9yoZRj8mFuOiw
 eSXYlIBRcktDyP2PNp9NZFi4YHTMM2RSwwmGLKpsH1MHzyFyXFl5tc+qUqsYCQj/vU8aULVJ7xu
 AeN/rLq0jrs13iW9YIB/f0SERnlxe6FQPATzlappwXJGCI9kLaPb4
X-Received: by 2002:a4a:ba86:0:b0:5b2:8017:fb68 with SMTP id
 006d021491bc7-5b95cde3ec5mr17116967eaf.0.1716997741803; 
 Wed, 29 May 2024 08:49:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2c2zCmehW+44rAlMjMRbTVxIEmKuelLZ5JcfjXZCMhjQjjn6G1zKvKHxWjO19QcLImYRBHA==
X-Received: by 2002:a4a:ba86:0:b0:5b2:8017:fb68 with SMTP id
 006d021491bc7-5b95cde3ec5mr17116935eaf.0.1716997741100; 
 Wed, 29 May 2024 08:49:01 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb18327f6sm55170661cf.58.2024.05.29.08.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 08:49:00 -0700 (PDT)
Date: Wed, 29 May 2024 11:48:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/qtest/migrate-test: Add a postcopy memfile test
Message-ID: <ZldOal1YdAWLB5pj@x1n>
References: <20240529041322.701525-1-npiggin@gmail.com>
 <875xuwg4mx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xuwg4mx.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
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

On Wed, May 29, 2024 at 09:54:30AM -0300, Fabiano Rosas wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > Postcopy requires userfaultfd support, which requires tmpfs if a memory
> > file is used.
> >
> > This adds back support for /dev/shm memory files, but adds preallocation
> > to skip environments where that mount is limited in size.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >
> > How about this? This goes on top of the reset of the patches
> > (I'll re-send them all as a series if we can get to some agreement).
> >
> > This adds back the /dev/shm option with preallocation and adds a test
> > case that requires tmpfs.
> 
> Peter has stronger opinions on this than I do. I'll leave it to him to
> decide.

Sorry if I gave that feeling; it's more of a stronger willingness to at
some point enable shmem for QEMU migration, rather than wanting to push
back what Nicholas was trying to do.  Enabling more arch for migration
tests is definitely worthwhile on its own.

Shmem is just some blank spot that IMHO we should start to think about
better coverarge. E.g. it is the only sane way to boot the VM that is able
to do fast qemu upgrades using ignore-shared, that was true even before
Steve's cpr-exec work, which would be much easier than anonymous. And it's
also possible shmem can be (in the next 3-5 years) the 1G page provider to
replace hugetlb for postcopy's sake - this one is far beyond our current
discussion so I won't extend..

IMHO shmem should just be a major backend just like anonymous, and the only
possible file backend we can test in CI - as hugetlb is harder to manage
there.

> 
> Just note that now we're making the CI less deterministic in relation to
> the migration tests. When a test that uses shmem fails, we'll not be
> able to consistently reproduce because the test might not even run
> depending on what has consumed the shmem first.
> 
> Let's also take care that the other consumers of shmem (I think just
> ivshmem-test) are able to cope with the migration-test taking all the
> space, otherwise the CI will still break.

Looks like ivshmem-test only uses 1MB shmem constantly so probably that
will succeed if the migration test will, but true they face the same
challenge and they interfere with each other..  that test sidently pass
(instead of skip) if mktempshm() fails.  I guess we don't have a way to
solidly test shmem as shmem simply may not be around.

For this patch alone personally I'd avoid using "use_uffd_memfile" as the
name, as that's definitely confusing, since shmem can be tested in other
setups too without uffd.  Nicolas, please feel free to move ahead with your
arch enablement series with /tmp if you want to separate the shmem issue.

Thanks,

-- 
Peter Xu


