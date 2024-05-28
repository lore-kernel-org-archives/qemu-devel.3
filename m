Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4C9C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByr7-0006HL-QT; Tue, 28 May 2024 11:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sByr6-0006Gy-Dd
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sByr4-0003sF-MX
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716910513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1WdTmjw8EhuVR8eQNarlG3ROBvZ5T382348YDC217RY=;
 b=SnTSBmoxLHsCrTnbyEsLIl3gpV9INJaWgjtMw3Et64UxNSzmVxH85Ytxy3mz1rH+hZdcqY
 eZjygPQ1NtvH/J5cKDNll4gIVHY93bJumv9pyAGD0jAYJuRVDWOuPdKD5K3hrMx86Zvj3n
 jQals7UVPaJhqFMW8n+zuS5NtLoM2L8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-MmP-gvXOO8u-9shdGqRJvA-1; Tue, 28 May 2024 11:35:11 -0400
X-MC-Unique: MmP-gvXOO8u-9shdGqRJvA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-43fc8bb9f09so169031cf.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716910511; x=1717515311;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WdTmjw8EhuVR8eQNarlG3ROBvZ5T382348YDC217RY=;
 b=EwHADB+xZlS0rg9aZsGVo6WTgTrnNfi7fWNLii7kpXK545DovT0UjZLeIZhTD3/Bf9
 lXR1GH4YkLJrmoEZf4zHRpfzRxdBUaRKd2KIfpBW8xtU+zZNl+d9jtgh7XfvEZVZzyY1
 JRPArljCnROXcjuky2uyPzY37sc1Tz/TxVAol/KtRLCSqANYQtlnM6AtqWcxb2pLmJiL
 NrDJ7UzR2iiR8jdQN835h5KDmkiJMre4j6PfrLaf3OJqY4VKXr8FbyVE69Ohph99TXiN
 d2rKeZb6i4hPb3dWTg6JI8biG0CC7E7YQ7LgykQMbOU+kDbKnuin/PtdUxFgxXauZUzY
 7cQA==
X-Gm-Message-State: AOJu0Yx1EJZU8kpghoz4Z8utLccdTrC0Dmzzbi561r/fZjWSZ/pZOq8S
 UTYmJpYRBVgUWCBnQ3EqrSI11tROlRZ217TyH4cfpPRXFHR14jAjosw58XKPKo9v0ojF/lGXXGE
 YcpZhuqxQMidKvjYhy70J8rmV/uu2Qo/B9+k6kNTw1kW+Af2zPAzS
X-Received: by 2002:ac8:58d4:0:b0:437:cc82:9c00 with SMTP id
 d75a77b69052e-43fb0d69b99mr138894231cf.0.1716910510687; 
 Tue, 28 May 2024 08:35:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjC1pa7WMNKRno+MCbUCfIOCwB+9sjtaA1afZw2EYtGD6jEu93OkNPJKZhDZSd0QiriNKoFA==
X-Received: by 2002:ac8:58d4:0:b0:437:cc82:9c00 with SMTP id
 d75a77b69052e-43fb0d69b99mr138893791cf.0.1716910509875; 
 Tue, 28 May 2024 08:35:09 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb16b97b5sm43547591cf.18.2024.05.28.08.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 08:35:09 -0700 (PDT)
Date: Tue, 28 May 2024 11:35:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Het Gala <het.gala@nutanix.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 3/4] tests/qtest/migration: Add support for simple
 device tests
Message-ID: <ZlX5q9e-p93i0Am9@x1n>
References: <20240523201922.28007-1-farosas@suse.de>
 <20240523201922.28007-4-farosas@suse.de> <ZlT3ORBU6-FbRXda@x1n>
 <87wmneg8t5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmneg8t5.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, May 27, 2024 at 07:59:50PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, May 23, 2024 at 05:19:21PM -0300, Fabiano Rosas wrote:
> >> The current migration-tests are almost entirely focused on catching
> >> bugs on the migration code itself, not on the device migration
> >> infrastructure (vmstate). That means we miss catching some low hanging
> >> fruits that would show up immediately if only we had the device in
> >> question present in the VM.
> >> 
> >> Add a list of devices to include by default in the migration-tests,
> >> starting with one that recently had issues, virtio-gpu. Also add an
> >> environment variable QTEST_DEVICE_OPTS to allow test users to
> >> experiment with different devices or device options.
> >> 
> >> Do not run every migration test with the devices because that would
> >> increase the complexity of the command lines and, as mentioned, the
> >> migration-tests are mostly used to test the core migration code, not
> >> the device migration. Add a special value QTEST_DEVICE_OPTS=all that
> >> enables testing with devices.
> >> 
> >> Notes on usage:
> >> 
> >> For this new testing mode, it's not useful to run all the migration
> >> tests, a single test would probably suffice to catch any issues, so
> >> provide the -p option to migration-test and the test of your choice.
> >> 
> >> Like with the cross-version compatibility tests in CI and the recently
> >> introduced vmstate-static-checker test, to be of any use, a test with
> >> devices needs to be run against a different QEMU version, like so:
> >> 
> >> $ cd build
> >> $ QTEST_DEVICE_OPTS=all \
> >>  QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> >>  QTEST_QEMU_BINARY_DST=../build-previous/qemu-system-x86_64 \
> >>  ./tests/qtest/migration-test -p /x86_64/migration/precopy/tcp/plain
> >> 
> >> $ cd build
> >> $ QTEST_DEVICE_OPTS='-device virtio-net' \
> >>  QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> >>  QTEST_QEMU_BINARY_DST=../build-previous/qemu-system-x86_64 \
> >>  ./tests/qtest/migration-test -p /x86_64/migration/precopy/tcp/plain
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  tests/qtest/migration-test.c | 19 +++++++++++++++++--
> >>  1 file changed, 17 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> >> index 2253e0fc5b..35bb224d18 100644
> >> --- a/tests/qtest/migration-test.c
> >> +++ b/tests/qtest/migration-test.c
> >> @@ -71,6 +71,13 @@ static QTestMigrationState dst_state;
> >>  #define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
> >>  #define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
> >>  
> >> +/*
> >> + * The tests using DEFAULT_DEVICES need a special invocation and
> >> + * cannot be reached from make check, so don't bother with the
> >> + * --without-default-devices build.
> >
> > What's this "--without-default-devices"?
> 
> A configure option. It removes from the build any devices that are
> marked as default. It's an endless source of bugs because it is supposed
> to be paired with a config file that adds back some of the removed
> devices, but there's nothing enforcing that so we always run it as is
> and generate a broken QEMU binary.
> 
> So anything in the tests that refer to devices should first check if
> that QEMU binary even has the device present. I'm saying here that we're
> not going to do that because this test cannot be accidentally reached
> via make check. Realistically, most people will consume this test
> through the CI job only.

Ah I didn't expect that is an existing configure option.. then it is all
fine.

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


