Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919B7C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 15:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNYln-0007fD-0I; Fri, 06 Jun 2025 11:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNYld-0007Wa-2L
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNYlZ-0006xH-0N
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749222833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nOOjwhJnu3zDalxzOTbcYSggHDgZCrhITHbE3CiErQk=;
 b=W+GxzbmyPx6H+UN613klp/PnTrFwdGp/ngZVSZq8LKI10bQOO6cCmgy8ajdR1U22TN340L
 Cc0EjA06m0OJwMyeYX9OGdDWJKERT3MhFSIIqUQ3Ugqgl8EyhJ/s136aGiQtGzP/Y1xwoo
 eAZGcly7Noc1QwsNDYb/5WTQx54a5vo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-9rZ6HMefNce5wfMwLhjLRg-1; Fri, 06 Jun 2025 11:13:50 -0400
X-MC-Unique: 9rZ6HMefNce5wfMwLhjLRg-1
X-Mimecast-MFC-AGG-ID: 9rZ6HMefNce5wfMwLhjLRg_1749222830
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6fafb2f0a33so34246656d6.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 08:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749222830; x=1749827630;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOOjwhJnu3zDalxzOTbcYSggHDgZCrhITHbE3CiErQk=;
 b=mYigUSWunWYlX7HuIyEXettv7koM5u/CpQd9W7/3O0VXhyKaB6rRQVvBDFfXVfEKn5
 EGmKGnpi2epEP5Pf6ov6GWD+LKYSwo9JLsRc34WkFwuJmvJb5P6EfQh9tlgcYJI1colf
 vVdt1VkWoOdxijM/RdiUZmYJZ4/ISG1IaW2/72nWmOYRl+d43FUndikJ5rvoVylthR8Z
 KZJgvPeeDAnhj1k6yqfpTdMjyZWLQW0ukYxvm6ppAtY6PHh6vt6D6VfJ66fhdnuUpauy
 wJ8uS+OcFPypWa1rjQjIhhOnBDr4Iu16WdC4UO+rdgA68pL9KsleffSFXSQxhekecebp
 mUsg==
X-Gm-Message-State: AOJu0YyF5p7Yqg6CFdr5FHCAHnIlFt8dM2EcW79J/6m8E3tEFV6WIUDa
 mTwdCOvu2AS2GU1HYd+MuWZGBTdSA9ne58jy4GuvNiF6iBBnMzz0WMRsqo96RyVc3trIh6FK1xQ
 iYACEJvPfgv8QM+f+QHfAW7jjIIOHi9uHA8cNO72RXca7W5+RX4QoakWH
X-Gm-Gg: ASbGncuO70fXRTTM/jv33niR/KQPHoaIDxJXAenzi98C2IL9riA8SFPxccjthmn5Esi
 40F1eu4jHETKMGv1kApA7SwLsOp6GNqGzIq+ddVwxCptOEeY2dkw2cTbRnkkhtu/zX9XtiGl6tw
 L1BzPaagbwh2jq9uMYMLq+xpuEersLRTl/8HLj7qno4GtAhcZItO/tzkgukGQgxR+aVgoTFkOqK
 4gvawNa1yWLBDOPATtWdThEQJiKdqcApoxAqWtwHhm/3MPI97vdMptS/qzMzuF5sA+350EDQSey
 9BiW3qtAuGZkog==
X-Received: by 2002:ad4:5de6:0:b0:6f8:f1a5:e6a4 with SMTP id
 6a1803df08f44-6fb08f6e965mr59865346d6.22.1749222830204; 
 Fri, 06 Jun 2025 08:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtwh1odNDBqqnk4sDu6kAE3etFYYk6tI0yV9fKi/QOXSoQm32wjc36gVpl+dHuarw+6l+PpA==
X-Received: by 2002:ad4:5de6:0:b0:6f8:f1a5:e6a4 with SMTP id
 6a1803df08f44-6fb08f6e965mr59865026d6.22.1749222829847; 
 Fri, 06 Jun 2025 08:13:49 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b365dfsm12249586d6.112.2025.06.06.08.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 08:13:49 -0700 (PDT)
Date: Fri, 6 Jun 2025 11:13:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 06/21] migration: Remove checks for s->parameters has_*
 fields
Message-ID: <aEMFqt2j51V2U90E@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603013810.4772-7-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 02, 2025 at 10:37:55PM -0300, Fabiano Rosas wrote:
> The migration parameters validation produces a temporary structure
> which is the merge of the current parameter values (s->parameters,
> MigrationParameters) with the new parameters set by the user
> (MigrateSetParameters).
> 
> When copying the values from s->parameters into the temporary
> structure, the has_* fields are copied along, but when merging the
> user-input values (MigrateSetParameters) they are not.
> 
> During migrate_params_check(), only the parameters that have the
> corresponding has_* field will be checked, so only the parameters that
> were initialized in migrate_params_init() will be validated.
> 
> This causes (almost) all of the migration parameters to be validated
> every time a parameter is set, regardless of which fields the user
> touched, but it also skips validation of any values that are not set
> in migrate_params_init().
> 
> It's not clear what was the intention of the original code, whether to
> validate all fields always, or only validate what the user input
> changed. Since the current situation is closer to the former option,
> make the choice of validating all parameters by removing the checks
> for the has_* fields when validating.
> 
> Note that bringing the user input into the temporary structure for
> validation still needs to look at the has_* fields, otherwise any
> parameters not set by the user (i.e. 0) would override the
> corresponding value in s->parameters.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


