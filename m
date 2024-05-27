Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EA3C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhjH-000603-8c; Mon, 27 May 2024 17:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBhjE-0005zY-SN
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:18:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBhjD-0003Y6-79
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716844678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U/1F0fDGLRPkJdriVJvFO5RLxx/qKwKhlT5HAU466bI=;
 b=BkMpA80bQhnsZ5y8hjvUwOpUU5KKS0vhO7YMqSaYT0kkS9WUUNP8ylsXNkkPpTaiowXem1
 9gdJ3D68wTCqOzHrY89HSiue+OIVMtYB1mzbEz1+DxhBGMCSnv7emYO7VTvpiVx5HF4QrU
 9Bz1wwkd9/hOvCioaNADB97KLKtl3NA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-9s3cVOdHPViOMuICL0H7Sg-1; Mon, 27 May 2024 17:17:57 -0400
X-MC-Unique: 9s3cVOdHPViOMuICL0H7Sg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6ad5ebfaa68so466266d6.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844676; x=1717449476;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/1F0fDGLRPkJdriVJvFO5RLxx/qKwKhlT5HAU466bI=;
 b=uIgh49Oxv6Q1Wr1BKN6SQHuDmUeKtjHE8EZQOCNDmtzAyDqBcnCukZfHAfAghgdDt/
 vzgeJ78dq9WFTBEsn69u7nesqPlOcIgsw7FZy7f42R9ow1xKUXDeDsWi8Ij0AH1or32o
 ieQ3jeRuRyLlGDscKNq018ppTX2TnBexpgmG+J68daDZRw84G5s3zMMzGvZqJP7oiKb1
 ak506KUkZTxvTonmfCtOyaL/eU6y9GscTZ+5DaOMj9tBT4v5hukq48xUBXljwpaC7Xzt
 EGL1kKlOJXVeEsOPe92yhQg/hDAMcwHTT3ut3W0iqWU3UFaM6/JOV3Ys8PVnenM+x+YV
 E69A==
X-Gm-Message-State: AOJu0Yyi/6B+OAGL3uQriKq/MyyrKZoK2lC0iFQ00y2XdQOoFSKuRhrG
 1zWBr4YvL5tPRJPWMr5HfiogghL9TSfZ1GyNg0IW7v/SovbF7VkgnSuYNEJUKz/SWjGipuk1xB2
 5gET5FsQ75OxoBo0My1asolzsSfAipxU3TImzF4bDQW1pHXuWqKUB
X-Received: by 2002:a05:6214:d67:b0:6ab:8463:4355 with SMTP id
 6a1803df08f44-6abcd0d569dmr111143376d6.3.1716844674934; 
 Mon, 27 May 2024 14:17:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/GQ4/exDS9iuizhnSi+SZwHRmroW8onGwHl5dfoc8QYKPw7VLK/wxXEw5UakE/VlDzE2vRg==
X-Received: by 2002:a05:6214:d67:b0:6ab:8463:4355 with SMTP id
 6a1803df08f44-6abcd0d569dmr111143086d6.3.1716844674223; 
 Mon, 27 May 2024 14:17:54 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ac162ef865sm37891396d6.96.2024.05.27.14.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:17:53 -0700 (PDT)
Date: Mon, 27 May 2024 17:17:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Het Gala <het.gala@nutanix.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [RFC PATCH 4/4] ci: Add the new migration device tests
Message-ID: <ZlT4f368xO8fXsUY@x1n>
References: <20240523201922.28007-1-farosas@suse.de>
 <20240523201922.28007-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523201922.28007-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

On Thu, May 23, 2024 at 05:19:22PM -0300, Fabiano Rosas wrote:
> We have two new migration tests that check cross version
> compatibility. One uses the vmstate-static-checker.py script to
> compare the vmstate structures from two different QEMU versions. The
> other runs a simple migration with a few devices present in the VM, to
> catch obvious breakages.
> 
> Add both tests to the migration-compat-common job.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  .gitlab-ci.d/buildtest.yml | 43 +++++++++++++++++++++++++++++++-------
>  1 file changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 91c57efded..bc7ac35983 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -202,18 +202,47 @@ build-previous-qemu:
>    needs:
>      - job: build-previous-qemu
>      - job: build-system-opensuse
> -  # The old QEMU could have bugs unrelated to migration that are
> -  # already fixed in the current development branch, so this test
> -  # might fail.
> +  # This test is allowed to fail because:
> +  #
> +  # - The old QEMU could have bugs unrelated to migration that are
> +  #   already fixed in the current development branch.

Did you ever hit a real failure with this?  I'm wondering whether we can
remove this allow_failure thing.

> +  #
> +  # - The vmstate-static-checker script trips on renames and other
> +  #   backward-compatible changes to the vmstate structs.

I think I keep my preference per last time we talked on this. :)

I still think it's too early to involve a test that can report false
negative.  I'd still keep running this before soft-freeze like I used to
do, throw issues to others and urge them to fix before release.  Per my
previous experience that doesn't consume me a lot of time, and it's not
common to see issues either.

So I want people to really pay attention when someone sees a migration CI
test failed, rather than we help people form the habit in "oh migration CI
failed again?  I think that's fine, it allows failing anyway".

So far I still don't see as much benefit to adding this if we need to pay
for the other false negative issue.  I'll fully support it if e.g. we can
fix the tool to avoid reporting false negatives, but that may take effort
that I didn't check.

>    allow_failure: true
>    variables:
>      IMAGE: opensuse-leap
>      MAKE_CHECK_ARGS: check-build
>    script:
> -    # Use the migration-tests from the older QEMU tree. This avoids
> -    # testing an old QEMU against new features/tests that it is not
> -    # compatible with.
> -    - cd build-previous
> +    - cd build
> +    # device state static test: Tests the vmstate structures for
> +    # compatibility across QEMU versions. Uses the latest version of
> +    # the tests.
> +    # old to new
> +    - PYTHON=pyvenv/bin/python3
> +          QTEST_QEMU_BINARY_SRC=../build-previous/qemu-system-${TARGET}
> +          QTEST_QEMU_BINARY=./qemu-system-${TARGET}
> +          ./tests/qtest/migration-test -p /${TARGET}/migration/vmstate-checker-script
> +    # new to old skipped because vmstate version bumps are always
> +    # backward incompatible.
> +
> +    # device state runtime test: Performs a cross-version migration
> +    # with a select list of devices (see DEFAULT_DEVICES in
> +    # migration-test.c). Using the multifd tcp test here, but any will
> +    # do.
> +    # old to new
> +    - QTEST_DEVICE_OPTS=all QTEST_QEMU_BINARY_SRC=../build-previous/qemu-system-${TARGET}
> +          QTEST_QEMU_BINARY=./qemu-system-${TARGET} ./tests/qtest/migration-test
> +          -p /${TARGET}/migration/multifd/tcp/channels/plain/none
> +    # new to old
> +    - QTEST_DEVICE_OPTS=all QTEST_QEMU_BINARY_DST=../build-previous/qemu-system-${TARGET}
> +          QTEST_QEMU_BINARY=./qemu-system-${TARGET} ./tests/qtest/migration-test
> +          -p /${TARGET}/migration/multifd/tcp/channels/plain/none
> +
> +    # migration core tests: Use the migration-tests from the older
> +    # QEMU tree. This avoids testing an old QEMU against new
> +    # features/tests that it is not compatible with.
> +    - cd ../build-previous
>      # old to new
>      - QTEST_QEMU_BINARY_SRC=./qemu-system-${TARGET}
>            QTEST_QEMU_BINARY=../build/qemu-system-${TARGET} ./tests/qtest/migration-test
> -- 
> 2.35.3
> 

-- 
Peter Xu


