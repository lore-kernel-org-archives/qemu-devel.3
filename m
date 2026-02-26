Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768EBFD8FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdFI-0006Jc-Cq; Thu, 26 Feb 2026 10:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vvdFD-0006J9-Kw
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:25:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vvdF5-0005Kk-LK
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772119530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P6T4+eVfHVZJh/RAPggWQOSXbIgtrPWNcXlWAC5T1zQ=;
 b=Sja5aka0jSTTkOZgpv5x7GWCjTVTND5Tw3ZD/QozvxzspO+IdZlpc34cn6udkJUyFt/3tc
 3ZPztEs0bbZlYnFxwq+Yh/wIutWwW/P3FAR7EkPLJxC+L8fzpg6IG8brz/bm8mhQZLsCv5
 QBFRbx6gu+2JYNrWiVxp8GA4tRUYwXk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-zXa8h25QNPmczaX_70KiDA-1; Thu, 26 Feb 2026 10:25:28 -0500
X-MC-Unique: zXa8h25QNPmczaX_70KiDA-1
X-Mimecast-MFC-AGG-ID: zXa8h25QNPmczaX_70KiDA_1772119528
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cb6291d95aso924909285a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772119528; x=1772724328; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P6T4+eVfHVZJh/RAPggWQOSXbIgtrPWNcXlWAC5T1zQ=;
 b=Hx9TQw0ZnwZAyG30N6n+t9RqpeelDkrPjj5KMY7Kb9AT1Iff0UIvEw3PCgB7l3iYdW
 K3F45BuOISt367q0K6+rGIdrYrr8DLmtKSeDYZD9cI16IlBdi9bqM/JKcCBkwQnXTtDz
 MGGHv7wMvqVj1cK6JNv4gS10nazEoI4ujBVFA9Y63fR1Dtj6hQIY5RbhviIcBWuLiEwI
 +ZxA66jAWEVgXIMHM1AYEGjo1bb9c0N9726JxWSDcMoZqjdmiTP87Y0xJci83+QuVWOw
 7AA+HJjXzhducZdshshldKNJyt5q1RBfF/SlvGn9+JGdKfr3dUxEeuSipwpz47fWZxBc
 nTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772119528; x=1772724328;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P6T4+eVfHVZJh/RAPggWQOSXbIgtrPWNcXlWAC5T1zQ=;
 b=qfaNgtsxnNSM1MTk8Np2MXQEeDcsYgkNMqGG40lHgekva3N3bqEWG28fhIlG9yl/bj
 75gGVTrB4YdCpeWtbO0GtTEVsq1okih/CxFdPAYSVMZ9f4tnCnYT9lVr+KQps/j0WyeB
 0kEfq9+uFSIJ8ZcUFL1cEa1i5jgCko+Zo1pGybqYGxk5SHUnAX0hEHvSQ+8RigU66PIu
 2ZSca2W67b2zAWw6CRS+6EynYXWcX+2dUv16jnikmLXVY+hZ4ocaslwAylglmcnOYhmD
 vSj9/WHf3DwO3QN7qZt31vqZrEjN/c9xmx7l8kAGpLnqqMxQLTGjKoRfyWfZsHjBnhkL
 6JyA==
X-Gm-Message-State: AOJu0YzAb8yA65u8mAdVCGAj0Qx/cNO5whykNanWvOSowW2I9wsZAO9w
 pvZdGqYou+juqcCfNR4lmc6tVrltn5cIgahofp2sz5goKBWmcfaEuQ2dRXd7cxRx3IjgXLKsRCV
 y9lj5CvDEkrr3DXFz+fSJv3uEl9QAs4h+4PinJaOiOb/5oUW4JjZ20Wdu
X-Gm-Gg: ATEYQzzyF1cmkq/Wp1CCPiCIB09mkXtw3EsGG/J2zKdbDFGOrYAKxxW+XT9NhvXJvDc
 A2iPRbX6POsZqOuE8Vg1ieo+REeFKgTEfYYa5i5e1SRoIkfNhZwDjmWHd49/JTzrnfgFidp/rG3
 99BPyy2rHuHf+Ciu9CcOkEt/BoE6R5P/UkLxBVqSubFG/fhBXc1tnO8CRQ4PwOg3daFFZiftLKV
 WyEGBFQtPmaJhJUXdZz9/ieJFuaGf20N5xktzPx7BQNk4KWj6Mt1UyZFC/RVNvga0QDmmmu4ikl
 yM3FP9zUmkgjbC9XVYnYrvcl5Vet0TNMNPF6PEuH/GRCiob4ZgVHHHAH8YScaC3HyXkkcI5qun2
 IYNynGs+pXReSjA/8kZHwAvpLTbW8EReLJYgRRFz7f3QTrxseJSb7+VSvCvSu0aK9bAhIh2YCrd
 88wdDuhQ==
X-Received: by 2002:a05:620a:46a6:b0:8c6:e579:a81f with SMTP id
 af79cd13be357-8cbbcf77cb0mr598302185a.23.1772119527415; 
 Thu, 26 Feb 2026 07:25:27 -0800 (PST)
X-Received: by 2002:a05:620a:46a6:b0:8c6:e579:a81f with SMTP id
 af79cd13be357-8cbbcf77cb0mr598297485a.23.1772119526876; 
 Thu, 26 Feb 2026 07:25:26 -0800 (PST)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899c7159c15sm20937726d6.2.2026.02.26.07.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:25:26 -0800 (PST)
Date: Thu, 26 Feb 2026 10:25:24 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v10 18/19] multifd: Fix hang if send thread errors during
 sync
Message-ID: <aaBl5IRgBosD8AQU@x1.local>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
 <20260220-colo_unit_test_multifd-v10-18-bfe67d422ef1@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220-colo_unit_test_multifd-v10-18-bfe67d422ef1@web.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
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

On Fri, Feb 20, 2026 at 08:51:40PM +0100, Lukas Straub wrote:
> When a send thread encounters an error (as is the case with yank),
> it sets multifd_send_state->exiting and the other threads exit too.
> This races with multifd_send_sync_main() which now hangs at
> qemu_sem_wait(&p->sem_sync) in multifd_send_sync_main() line 647
> as it waits for threads that have exited.
> 
> Fix this by kicking the semaphores when exiting the send threads.
> 
> I encountered this hang when stress testing the colo unit test,
> though I was unable to write a migration test to reliably hit this.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


