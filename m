Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D80CD5BB8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smI3E-0006s0-6Y; Thu, 05 Sep 2024 15:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smI38-0006hM-1r
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smI33-0001Dq-5Y
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725564098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/O2uML1QjwMSFtNLqiQUnM8V+1+zkZaBo/ak/HYr/M4=;
 b=U7IvjJuBrM9Y0UZeFQuVuan93zzLr+uGNGSZAiDXm4bynNpamK6uZKu3WKPyh02TMIBq7i
 S32dnkj0h1djZ3RXrXLKdtNWPvihpigqUPkhwY3TtgiTe3rdMev7km4nVKQD0RCtZGR3IY
 nrWrMAE6qWWcGOnro0Gx8z8X3Wie+Nc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-1vsGQwu9PI2VMzw-_XVMiQ-1; Thu, 05 Sep 2024 15:21:37 -0400
X-MC-Unique: 1vsGQwu9PI2VMzw-_XVMiQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6d73d0944acso54761497b3.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 12:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725564096; x=1726168896;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/O2uML1QjwMSFtNLqiQUnM8V+1+zkZaBo/ak/HYr/M4=;
 b=BuhQesaOrPXYmQiPpv6tVMU/awzhlWoMA0nU8uEmkp9r6OXwvdg3RByk5wXJ1Ut37q
 iq+pCu9GhP80ZoHVVtsBB0CvAXphxfrQo444xccBrBRvpCxhsHvA5c1Bg+rI9gaVDfpH
 w3nJQ58pfKABXghsmgHBQ4QAVOzRJWgeuNL8dwcfZAD9s8MXVZholfH9HhjWZ5LZJRQL
 lHhwcXyrzWKNKclUWxWdwexOR9M7y7W+FBCkLD0vvRiiz9QtB1fnMDFs608/OkeSwe1X
 PcLqTA/5WYJbrZuCFAl1qVTqJOTw39LbRUKqc8o8qQn9wdm29lNiiCNXqcsCGoKmONdP
 hhrQ==
X-Gm-Message-State: AOJu0YwWcKiphf7O2ryKSPOnMZ6OliAIPFzcKudFfqXz6JBEJit/fL3F
 N/i+Y0YvTmM3JL20ZAiWRtw62Y8Wp8GWy0xNx96Ijgx6NjoqoaBXrsCFzOzdlSJREX6tW8rUQzj
 /zdZi+Znsah1vowvggFlgPdc6ipKwaJ6uCNAvwzbckn6WexyGQO6P
X-Received: by 2002:a05:6902:1109:b0:e0e:7b3d:53fe with SMTP id
 3f1490d57ef6-e1d348ba79amr406750276.18.1725564096640; 
 Thu, 05 Sep 2024 12:21:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS4LGtjoKyeIAFajTmwcG4RxppJ5G7TGFM3aGDe2GTEmDkaXHcgiUq2YBlQZJiDFoUXBe4mQ==
X-Received: by 2002:a05:6902:1109:b0:e0e:7b3d:53fe with SMTP id
 3f1490d57ef6-e1d348ba79amr406724276.18.1725564096318; 
 Thu, 05 Sep 2024 12:21:36 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98efed96fsm100490485a.90.2024.09.05.12.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 12:21:35 -0700 (PDT)
Date: Thu, 5 Sep 2024 15:21:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH] ci: migration: Don't run python tests in the compat job
Message-ID: <ZtoEvvdDO_3PsfDz@x1n>
References: <20240905185445.8179-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240905185445.8179-1-farosas@suse.de>
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

On Thu, Sep 05, 2024 at 03:54:45PM -0300, Fabiano Rosas wrote:
> The vmstate-checker-script test has a bug that makes it flaky. It was
> also committed by mistake and will be removed.
> 
> Since the migration-compat job takes the tests from the build-previous
> job instead of the current HEAD, neither a fix or a removal of the
> test will take effect for this release.
> 
> Disable the faulty/undesirable test by taking advantage that it only
> runs if the PYTHON environment variable is set. This also disables the
> analyze-migration-script test, but this is fine because that test
> doesn't have migration compatibility implications.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

We should still merge your previous pull, right?  Looks like that's the
easiest indeed.

But still, just to double check with both you and Peter on the merge plan.
If that's the case, I can send the 1st 9.2 pull earlier so we can have this
in.

Thanks,

-- 
Peter Xu


