Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD52C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVpgb-0003qN-1T; Mon, 22 Jul 2024 05:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sVpgY-0003pg-IU
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:50:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sVpgW-0004oe-KX
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721641822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgNjRqZSYv5lFGbtD/CpW462meKbdPmkP+f9p+Yf6XE=;
 b=DlgKAgZC+WHRFQ5mYUx8aA7QnSbMbf1Jl7iZpdNvBTb13wEuhc9Wt37LlyEfsntQsMjj6+
 LNaekgGVtGKSC6Wnh3GIxXRI6MqSesvXHzE3kzSchbbhGFw1HIgccKnrR+HqskSN+9zQvS
 pJelvFqNpm8ZyaPLI2JlisCZsHQ0vAY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-0JwPV9sLNxiCCHX8r5Jhvg-1; Mon, 22 Jul 2024 05:50:20 -0400
X-MC-Unique: 0JwPV9sLNxiCCHX8r5Jhvg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36863648335so2512191f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 02:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721641819; x=1722246619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hgNjRqZSYv5lFGbtD/CpW462meKbdPmkP+f9p+Yf6XE=;
 b=tsNOwRBx9tPkg0B12Ff303tDGmx1CVulhMQi9mYriFeOe9cLOSwY8xvM38utL3zeg6
 cxQ6S5JE/jWevWKBloOIjr8Fqf8femQAyre1OLKr27/v6Bb2g8hogk0/g/SWB5rENJoH
 QXH9O6GWbBRFrvbyeZ9XtJwaNhgdi6k/1O0rS3ilOv6wmoa/gMCMTNt3Fww7MUjlBEy1
 VAq/EJtt7LOi2rabQKF9W21e5H+8wS0S/XLvniHETMvJdBH1uBeMRRs2Tof5j9yVVLrA
 za1m6M0PMMrpzDf+7xQA7/gvHS7RVoy2zXVo8ippoqooDXV3iKcgF/5r1EJHijuUAbbL
 vqfQ==
X-Gm-Message-State: AOJu0Yx20tp41pL1sIwAooLKjLjcISUe6bhB/pYxzMhtzk+EI7n9GJ4B
 WBNWo2vHc1LjBjGVdVM3NcJjHvmv1QYCvyd14Cc0LmCHrh9LnkHCE6/gFCelvjcObfd24EY9XGq
 QoG21/eRziKdNP0WbGhBKZkBC44D1Sa1kZ8i8U3fPZqkHSvG+v6Xi
X-Received: by 2002:adf:ed4a:0:b0:364:348:9170 with SMTP id
 ffacd0b85a97d-369bae707d4mr4033642f8f.54.1721641819627; 
 Mon, 22 Jul 2024 02:50:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5zi3d+VvSpakf56gX6yX0iTavh6BMiaj2a2tmJZsV9lGzo7R7HnQg3ydAeJyQws6KjJp/Ng==
X-Received: by 2002:adf:ed4a:0:b0:364:348:9170 with SMTP id
 ffacd0b85a97d-369bae707d4mr4033620f8f.54.1721641819160; 
 Mon, 22 Jul 2024 02:50:19 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787caefdsm8057045f8f.66.2024.07.22.02.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 02:50:18 -0700 (PDT)
Date: Mon, 22 Jul 2024 11:50:17 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, pbonzini@redhat.com,
 mst@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] tests: increase timeout per instance of bios-tables-test
Message-ID: <20240722115017.4ca5bbde@imammedo.users.ipa.redhat.com>
In-Reply-To: <b538c18f-1b95-45b3-9aba-d1d92491c750@redhat.com>
References: <20240716125930.620861-1-imammedo@redhat.com>
 <b538c18f-1b95-45b3-9aba-d1d92491c750@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, 22 Jul 2024 09:35:17 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 16/07/2024 14.59, Igor Mammedov wrote:
> > CI often fails 'cross-i686-tci' job due to runner slowness
> > Log shows that test almost complete, with a few remaining
> > when bios-tables-test timeout hits:
> > 
> >    19/270 qemu:qtest+qtest-aarch64 / qtest-aarch64/bios-tables-test
> >      TIMEOUT        610.02s   killed by signal 15 SIGTERM
> >    ...
> >    stderr:
> >    TAP parsing error: Too few tests run (expected 8, got 7)
> > 
> > At the same time overall job running time is only ~30 out of 1hr allowed.
> > 
> > Increase bios-tables-test instance timeout on 5min as a fix
> > for slow CI runners.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >   tests/qtest/meson.build | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)  
> 
> Since we're entering the freeze period this week, I'm going to pick up this 
> patch for my next pull request in the hope that it will help to get this job 
> green again during the freeze period. But in the long run, it would be 
> really good if someone familiar with the bios-tables-test could analyze why 
> the run time increased so much in recent times for this test and provide a 
> better fix for the problem.

running UEFI guest under TCG was always slow (more so for aarch64),
but we keep adding more sub-cases to bios-tables-test (each running
firmware), and that takes extra time.
Overall time to run bios-tables-test naturally increases,
so we have to increase timeout eventually regardless of everything else.
(however there has not been new tests added since 9.0)

In cases I've looked at, meson timed out at the end of bios-tables-test,
where almost all cases were executed modulo the last.
Given flakiness of failure and changes to sub-cases, a few things
could lead to it:
  * performance regression when executing aarch64 tests, not much but enough
    to push the last sub-test behind 10min boundary more often than not
    (either qemu or firmware) (maybe running a few 9.0 jobs and comparing
     them to the current master would show if guest became slower)
  * CI job runners became slower (we can't control that if I'm not wrong).
    As was suggested in another thread running less test in parallel
    might help. But I won't bet on it, since it the end (by the time close
    to timeout) only a few test are still running so it might be not much
    contention on CPU resources.

> 
>   Thanks,
>    Thomas
> 
> 


