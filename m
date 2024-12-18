Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC2BE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNy8G-0003T2-3X; Wed, 18 Dec 2024 12:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNy8F-0003Sp-4G
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:46:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNy8D-0007tu-7S
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734544003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=18oUAH1ggMCfdBu+K60OKUMwyBR7qMMqjhSlruMleFI=;
 b=Xbj56eUfFwhR6bCjB6e4lGop2RhLE3etxvJuw5E3y2KPQarxgRzO+5gxLV1/+NO6RO/PqG
 F+h3dai0mcgcyph8yGOpEEQN8yHjp7teKOyXW/dQ+cJJD5S1s6MMWvwj81khHD2mgWcrLb
 RZgD7r/l1d5Z+8Qa7+3xwlKMk25KKr0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-_pCefM96MFW7clqZq04ARg-1; Wed, 18 Dec 2024 12:46:38 -0500
X-MC-Unique: _pCefM96MFW7clqZq04ARg-1
X-Mimecast-MFC-AGG-ID: _pCefM96MFW7clqZq04ARg
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b6eabd51cfso956680385a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 09:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734543998; x=1735148798;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=18oUAH1ggMCfdBu+K60OKUMwyBR7qMMqjhSlruMleFI=;
 b=bckpSyXfyE1swes1rLy15yd1Pzt6e/gFf7wOQCD8IxHTWb0WZypOmYTlf+Oo0GL9qc
 IBQmksAMIg0ldNR1bYEycODtjbg5nGkD1LSN+FL7C2/t5P6Csz6sECowrb/TqjSML3VI
 QL+pQeihXtO+Zs4hacwbOVBtqKmQdgdWvmFDJBtSzlBwSV7pxW1JxKjfmksrD3KdGq7H
 OXFvqm7yzPru+jtd+Rr5UAUECuCJm4zNEWJJI6VDUMy588vPnJwR1sK3ZYo3Wkd2Fgwn
 I3bYSx4+0RleLXAMPHBWhUkMAFP+4QCe0YHfquc6SR3iLK2H/jbjTIvn+055SpkB+mFr
 CzKg==
X-Gm-Message-State: AOJu0YwMmI2jBxc6Ia4V2yIoGv1MnZaMRbqzttYNxfLTByYqY8SnDg9n
 Lt/H+sFqBXUxd2Q4F6EuLdju60y0g/5waG6gaJKTAdm1YQddY80jNUIIQhMjLDHHYlTN45f8XU3
 /gqdPlOg9mgDkfx5sOq0hiNnjv1DLyb//LL4aD3hCLrpw9Irh5hzD
X-Gm-Gg: ASbGncv6qYcwSOEXl/2nLZKpw28uINqeczqqXf4dcHXaKEO2h3HjRK2iO3j8BefJj0z
 jcJKDXLMWCL9N3kn6QKotYYw9PyprPNmVwVk9eAh7FbGnMrX8AmquorJG0Jn47s3VCat2ldj+zu
 0LYzIcHAGEdpfTP1ORMnM1rUjzog13o2lf/YOABLfquovj5OfVXFMqRfn52Fa5U0PLq0ekOMBEJ
 d74kRLEJss6AoIzl8wbnSiGNz95Ojx+gQYdWULYAsVtmo8vzUa+tvaz8OJA+ZHcqOqVmAp1QvJB
 6nrfc67ZnRBHx/dERg==
X-Received: by 2002:a05:620a:4406:b0:7b6:c543:7e54 with SMTP id
 af79cd13be357-7b86372077emr505484385a.22.1734543997787; 
 Wed, 18 Dec 2024 09:46:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrZUmTiIZXS34zLCoGcdW7GCtta8IXbeQ4GZFo+1yMP0F7yCzj/xGjQ8mY1/Xm6juJuzKlOA==
X-Received: by 2002:a05:620a:4406:b0:7b6:c543:7e54 with SMTP id
 af79cd13be357-7b86372077emr505481285a.22.1734543997351; 
 Wed, 18 Dec 2024 09:46:37 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7047d1cf5sm450203785a.34.2024.12.18.09.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 09:46:36 -0800 (PST)
Date: Wed, 18 Dec 2024 12:46:34 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 19/22] tests/qtest/migration: Add migration-test-smoke
Message-ID: <Z2MKesakYn3fn2ue@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-20-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113194630.3385-20-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Nov 13, 2024 at 04:46:27PM -0300, Fabiano Rosas wrote:
> diff --git a/tests/qtest/migration-test-smoke.c b/tests/qtest/migration-test-smoke.c
> new file mode 100644
> index 0000000000..ff2d72881f
> --- /dev/null
> +++ b/tests/qtest/migration-test-smoke.c
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "migration/test-framework.h"
> +#include "qemu/module.h"
> +
> +int main(int argc, char **argv)
> +{
> +    MigrationTestEnv *env;
> +    int ret;
> +
> +    g_test_init(&argc, &argv, NULL);
> +    env = migration_get_env();
> +    module_call_init(MODULE_INIT_QOM);
> +
> +    if (env->has_kvm) {
> +        g_test_message(
> +            "Smoke tests already run as part of the full suite on KVM hosts");
> +        goto out;
> +    }

So the "smoke" here is almost "tcg".. and if i want to run a smoke test on
a kvm-enabled host, it's noop.. which isn't easy to understand why.

If to rethink our goal, we have two requirements:

  (1) We want to categorize migration tests, so some are quick, some are
      slow, some might be flacky.  Maybe more, but it's about putting one
      test into only one bucket, and there're >1 buckets.

  (2) We want to run only a small portion of tests on tcg, more tests on
      kvm.

Ideally, we don't need two separate main test files, do we?

I mean, we can do (1) with the existing migration-test.c, with the help of
either gtest's "-m" or something we invent.  The only unfortunate part is
qtest only have quick/slow, afaiu the "thorough" mode is the same as
"slow".. while we don't yet have real "perf" tests.  It means we only have
two buckets if we want to reuse gtest's "-m".

Maybe it's enough?  If not, we can implement >2 categories in whatever
form, either custom argv/argc cmdline, or env variable.

Then, if we always categorize one test (let me try to not reuse glib's
terms to be clear) into any of: FAST|NORMAL|SLOW|..., then we have a single
migration-test that have different level of tests.  We can invoke
"migration-test --mode FAST" if kvm is not supported, and invoke the same
"migration-test --mode SLOW" if kvm is supported.

Would this be nicer?  At least we can still run a pretty fast smoke / FAST
test even on kvm. Basically, untangle accel v.s. "test category".

-- 
Peter Xu


