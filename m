Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EF1FD4F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 19:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w033a-0008SW-Q8; Tue, 10 Mar 2026 15:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w033W-0008Rx-7w
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 15:47:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w033R-0000In-IS
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 15:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773172061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TuffWqpkUB2l8pHh77vDiGwBA+LP1srhPlLJTrOzTSU=;
 b=Z5rwN2FOwahdUOs4S6K/yDsU8xODP1Bur8NOO1X1Jnsanhnx2idJPbnAiyPXjTDLZ4eAz8
 8hCIlHHCIUnWBWXiWKJdRv5kSxkXLivGekVpv0n2YrtHjmWXTp92sKpNK9KgRCDi/VE5qN
 QSpbrlJZtz1pidGkWi07DGRYf1FW4ZY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-MYxG-ZiLPCKdE9zPx6xrKg-1; Tue, 10 Mar 2026 15:47:40 -0400
X-MC-Unique: MYxG-ZiLPCKdE9zPx6xrKg-1
X-Mimecast-MFC-AGG-ID: MYxG-ZiLPCKdE9zPx6xrKg_1773172058
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89a116bf0f8so529411636d6.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 12:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773172058; x=1773776858; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TuffWqpkUB2l8pHh77vDiGwBA+LP1srhPlLJTrOzTSU=;
 b=soRiaDzWMK1wfQBRE8yuJKCNYSGenVziqr6MO2iPHFysII9eLy7fbQV70Rrfsx9fL/
 ZBeFiZj1pGVNNUxHWilQUzR7oL/nyMi55K/42K/ZGm1uu+1d5FB98pMtXio/V2lZC8B4
 3Vbx4pwLGxAVEBKBdDFRBvK0eQfEAhmoWYhqV68T9HrB+3aXvaO44hLpNgAdZVdaxv0m
 W4xuoypP7/4dbbdvfdx57CM9TWaNcFQ+TZ5Ox2q581WBbXqnXPhYe1q6Xt8HOigV+jKn
 5WS63i+Pz4sE0nv6SrFzHVD+GMQby/bIX3HQO2yMWYrCfn9MRc0XwsZ5LChjFmsSU9IQ
 1rKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773172058; x=1773776858;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TuffWqpkUB2l8pHh77vDiGwBA+LP1srhPlLJTrOzTSU=;
 b=nkPHvSg7bPKN1DVtIox1HKW5OHVmOTTXNtkhbEIa2OIbomXCmHydwknNW9IutOp0+f
 AezsBANtNlxjepBQlZxF51/xi4BkVBg5U2LE7mJM8/cwsZ6GiSBZGSDWW7XN5JX80dnX
 oWn14Xpi3IMUtrO+KjHawLkQLVXvfv5O2KmARtE9MJJNya5vD9pyljyiqBONcQHhuei/
 GwMXIGf4GdT5z+7rrGeMCX99P6WDHcx4ujwtxQC3y4TxHGDZcWSEMlnZIxyt+dYX0v0z
 xK39iPLsrEXY3NyYiWK9IV0UEJeP8rYAW72ueQIxN5oqR7HmxsRrbhGnicuOK4Rl6+jS
 PXLw==
X-Gm-Message-State: AOJu0Ywp7t1MsMDXRqFV+eM/on4aJAS77Urj3zwnZ27fPFyFc133dX8F
 rEGRio4qTFjRhDfR2KuAX5ofdy+VrlqyRsHN5+tz4Fpsq3ypMPAOrQl3PQt3d6L9uzgjg6441/n
 n0NBGIpY/bGCqCMObeFOoCR0OsNa6FcHy6RfdoJn1Ig4vVrOfJsaeVqgD
X-Gm-Gg: ATEYQzwWDx2kaGjAgPwv6vZZD9uLF4mQmMi1fDRfQZ7iOs8cr4ney/j1Nf6KX1vqWX7
 sD3egEfRN21NDroLpC5lX21xJycDmAxc8Celo+20gwElgQfWlrDHw7k/ZSM5nAYh+CbseffND+6
 GvGYAbILMkZdq8cx5FgtNomeM4vsyiYtl04WSnQRuEk6CtikxaPX4lGlr5mMdinN6gdK+V9eF0N
 9FkHPa1ZIr2I+W++Wj4OjBUUJ94Roqp83yXCYji8cH0u4QVyTGpVzCtiBJcJMHgII7c0Tqh3X7a
 RAbgvjKIOlz2H3ImftxAZ6y5hvVwIrVvflOm3q3fuXnxdPtTqgH48oB1gY8SJWcXg+1g4o11G9+
 /X0LySpeOArOpuw==
X-Received: by 2002:ad4:5d45:0:b0:89a:125f:37db with SMTP id
 6a1803df08f44-89a30afbf90mr241875186d6.51.1773172058329; 
 Tue, 10 Mar 2026 12:47:38 -0700 (PDT)
X-Received: by 2002:ad4:5d45:0:b0:89a:125f:37db with SMTP id
 6a1803df08f44-89a30afbf90mr241874726d6.51.1773172057868; 
 Tue, 10 Mar 2026 12:47:37 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a65cfc85dsm534896d6.37.2026.03.10.12.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 12:47:37 -0700 (PDT)
Date: Tue, 10 Mar 2026 15:47:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/8] tests/qtest/migration: Fix leak of migration tests
 data
Message-ID: <abB1Vxk8liS9Cbr5@x1.local>
References: <20260310135540.8679-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310135540.8679-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 10, 2026 at 10:55:33AM -0300, Fabiano Rosas wrote:
> When the migration-test is invoked with the '-p' flag (to run a single
> test), the glib code won't call the destroy function for the
> not-executed tests, causing the MigrationTest wrapper data to leak.
> 
> This doesn't affect make check, but affects debugging use-cases where
> having a leak pop up in ASAN output is extra annoying.
> 
> Fix by adding the tests data to a list and freeing them all at the end
> of migration-test execution. Any tests actually dispatched by glib
> will have the destroy function called as usual.
> 
> Note that migration_test_add_suffix() is altered to call
> migration_test_add() so that there's only one place adding the data to
> the list.
> 
> Performance is not an issue at the moment, we have < 100 tests.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


