Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC9609B5AA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NoM3lLam
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtZM-0008Iq-Od; Mon, 02 Nov 2026 10:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNtZ5-0008Hv-PD
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:03:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNtZ4-0002U2-6y
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793631793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mcwnC6yaNg4KvJG+c7v2SXl5XV0525VZvN03Wus5PmE=;
 b=NoM3lLamgk5P+zHbRRnmMw5Grl9Bzc8LJnoEEKGDN0rXQeLF9RDEqavhSU/VjQaKCedNiO
 mtexnsDPMiefKZZdu5phF0HDD+o9NWxSKsGjH2wUqb+Nop1ghht3+mOcPe4s+KL6NzD4gw
 tDyu6OELRgL34uQhSAv88yELdsS2f5E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-CmVLw7q7PnSYrT8W1LZxPg-1; Mon,
 02 Nov 2026 10:03:10 -0500
X-MC-Unique: CmVLw7q7PnSYrT8W1LZxPg-1
X-Mimecast-MFC-AGG-ID: CmVLw7q7PnSYrT8W1LZxPg_1793631789
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3E751955DBF; Mon,  2 Nov 2026 15:03:07 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.164])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F79B1955F43; Mon,  2 Nov 2026 15:03:06 +0000 (UTC)
Date: Mon, 2 Nov 2026 16:03:03 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH] iotests: add --quiet arg to hide env variable dump
Message-ID: <auimJx3lKKVupFPs@redhat.com>
References: <20260623160611.2347282-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623160611.2347282-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 23.06.2026 um 18:06 hat Daniel P. Berrangé geschrieben:
> Every test run dumps a long list of environment variable settings.
> While this is often useful, if you are trying to reproduce a bug
> while repeatedly running a single test it can be quiet noisy. Add
> a --quiet flag to 'check' which allows the env variable dump to
> be hidden.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

The result doesn't feel terribly quiet to me, with all of the test cases
still getting a line of their own. I would have expected that a quiet
mode only prints errors and maybe the summary line at the end that tells
you about passed and skipped test cases.

Though I guess we could always have something like -qq for quieter
output, so this is not a fundamental objection.

>  tests/qemu-iotests/check         | 4 +++-
>  tests/qemu-iotests/testrunner.py | 7 ++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 3941eac8e2..c8ba536970 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -46,6 +46,8 @@ def make_argparser() -> argparse.ArgumentParser:
>          description="Test run options",
>          formatter_class=argparse.ArgumentDefaultsHelpFormatter)
>  
> +    p.add_argument('-q', '--quiet', action='store_true',
> +                   help='reduce output verbosity to only test results')
>      p.add_argument('-n', '--dry-run', action='store_true',
>                     help='show me, do not run tests')
>      p.add_argument('-j', dest='jobs', type=int, default=1,
> @@ -230,6 +232,6 @@ if __name__ == '__main__':
>          with TestRunner(env, tap=args.tap,
>                          color=args.color) as tr:
>              paths = [os.path.join(env.source_iotests, t) for t in tests]
> -            ok = tr.run_tests(paths, args.jobs)
> +            ok = tr.run_tests(paths, args.jobs, args.quiet)
>              if not ok:
>                  sys.exit(1)
> diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
> index dbe2dddc32..0eb7f144df 100644
> --- a/tests/qemu-iotests/testrunner.py
> +++ b/tests/qemu-iotests/testrunner.py
> @@ -376,7 +376,7 @@ def run_test(self, test: str,
>          sys.stdout.flush()
>          return res
>  
> -    def run_tests(self, tests: List[str], jobs: int = 1) -> bool:
> +    def run_tests(self, tests: List[str], jobs: int = 1, quiet: bool = False) -> bool:
>          n_run = 0
>          failed = []
>          notrun = []

This line is too long now:

297                             fail       [15:57:51] [15:58:02]   10.8s  (last: 10.6s) output mismatch (see /home/kwolf/source/qemu/build-clang/scratch/bochs-file-297/297.out.bad)
--- /home/kwolf/source/qemu/tests/qemu-iotests/297.out
+++ /home/kwolf/source/qemu/build-clang/scratch/bochs-file-297/297.out.bad
@@ -1,2 +1,4 @@
 === pylint ===
+************* Module testrunner
+testrunner.py:379:0: C0301: Line too long (86/79) (line-too-long)
 === mypy ===

Kevin


