Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2BCCD5BB8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smI7i-00013a-Su; Thu, 05 Sep 2024 15:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smI7f-0000tN-Rz
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:26:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smI7e-0001su-AC
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725564385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oOv5a3CjfT2NRr9oRC5KpvIQrdbvAUaKzVRkoG1Zosc=;
 b=MNcVWI48YPDStrprQHQJaqzEdhORsgS081w3r5+7fxUFEtlWOKmhbZgHZJIyMGo3jnVleM
 31D3K81XBnCWThnGKBQBRZUt1AFviEShrxkRjMfMsR7x6i9a0bsF/9RdmprMXdl0petfqo
 WNkVyUte8rG6ENQUjvhw3L4PJly02M0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-XnLq5r7sOX6-tHkijzk-ow-1; Thu, 05 Sep 2024 15:26:22 -0400
X-MC-Unique: XnLq5r7sOX6-tHkijzk-ow-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-45689398751so19259901cf.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 12:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725564382; x=1726169182;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oOv5a3CjfT2NRr9oRC5KpvIQrdbvAUaKzVRkoG1Zosc=;
 b=u58663GSGv//IJUMONpepUaOJ72zb9C6DO/483G+4f8zQIVhHBVzyCX+k+NjJ0vFLl
 sJxlUtegQ4hTsS+KBnyEIh0Jwba/VlgSmoz7RSaUGR3s45+YtTVHIua1qqRbfNRf3J4y
 HLc4b8vQBK/p/aiK581Td6tQuVs3AqbVQ/JB/FZ7KPefysWXP8+wNAbTk1HnFN9WQ/D9
 wOAmwG0hkosTrxLCPFKfAi/dv/hNUEXEFEjHkKl8XBrsU/mFkwd/aeuIhAvfteIVqLsx
 guzLVBpn4lVYQ1D37uQoas4CBYY4T3I8I1bbQUdg6JtkXsxIuFtHnH5HRym4rGJG89fw
 biTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV06X0mClGNAgYERhhbAgxpOeClW4RQanui6pnLchGgI8H6nO61jt5NSlp1MFPTD820R9f8A4Y0H8P@nongnu.org
X-Gm-Message-State: AOJu0Yxlnt5R1dU6IvYHojXeHtuAStFH46jckakwbCkOiywI/9CuotY9
 Znn9+87cMawbURc5k3zlDkyXPC6kp7CUckAsRKHO34VPmQvIxJS6wGDVxbWCyFDglIOa2JdyXTL
 ExhdxJAButFqgn02ZlDk8JeRSv/lcdUNy/ylQs+dGPNE8y5nZS7wi
X-Received: by 2002:ac8:5e51:0:b0:457:cb51:2cd4 with SMTP id
 d75a77b69052e-4580c78deafmr3276531cf.45.1725564381753; 
 Thu, 05 Sep 2024 12:26:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3xjx+mX7Fk7SufGs7O0XNw9PwkBaCPXj1rtvowV3CIYQztmNqpLJyzd0JztFr6gL39QMNNA==
X-Received: by 2002:ac8:5e51:0:b0:457:cb51:2cd4 with SMTP id
 d75a77b69052e-4580c78deafmr3276171cf.45.1725564381252; 
 Thu, 05 Sep 2024 12:26:21 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45801dc1754sm9793401cf.81.2024.09.05.12.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 12:26:20 -0700 (PDT)
Date: Thu, 5 Sep 2024 15:26:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH] ci: migration: Don't run python tests in the compat job
Message-ID: <ZtoF2i1xnCr-FpiR@x1n>
References: <20240905185445.8179-1-farosas@suse.de>
 <6c281205-e68e-452f-8320-5001bb3c5ebd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c281205-e68e-452f-8320-5001bb3c5ebd@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Thu, Sep 05, 2024 at 09:05:51PM +0200, Thomas Huth wrote:
> On 05/09/2024 20.54, Fabiano Rosas wrote:
> > The vmstate-checker-script test has a bug that makes it flaky. It was
> > also committed by mistake and will be removed.
> > 
> > Since the migration-compat job takes the tests from the build-previous
> > job instead of the current HEAD, neither a fix or a removal of the
> > test will take effect for this release.
> > 
> > Disable the faulty/undesirable test by taking advantage that it only
> > runs if the PYTHON environment variable is set. This also disables the
> > analyze-migration-script test, but this is fine because that test
> > doesn't have migration compatibility implications.
> > 
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >   .gitlab-ci.d/buildtest.yml | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> > index aa32782405..e52456c371 100644
> > --- a/.gitlab-ci.d/buildtest.yml
> > +++ b/.gitlab-ci.d/buildtest.yml
> > @@ -212,6 +212,12 @@ build-previous-qemu:
> >       # testing an old QEMU against new features/tests that it is not
> >       # compatible with.
> >       - cd build-previous
> > +    # Don't allow python-based tests to run. The
> > +    # vmstate-checker-script test has a race that causes it to fail
> > +    # sometimes. It cannot be fixed it because this job runs the test
> > +    # from the old QEMU version. The test will be removed on master,
> > +    # but this job will only see the change in the next release.
> 
> Maybe explicitly say that this can be removed once 9.2 has been released?

True.  I can touch that up if I'm queuing this.

> 
> > +    - unset PYTHON
> >       # old to new
> >       - QTEST_QEMU_BINARY_SRC=./qemu-system-${TARGET}
> >             QTEST_QEMU_BINARY=../build/qemu-system-${TARGET} ./tests/qtest/migration-test
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

-- 
Peter Xu


