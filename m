Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1A6606A5A6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H3fueyEg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtnl-0003nG-Mx; Mon, 02 Nov 2026 10:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNtnd-0003m4-Q5
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:18:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNtnb-0003ui-Nv
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793632693;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFVdc4ejh/Zo1eCqeoqaZH+YGBwF8YTu7rFblpIzOOg=;
 b=H3fueyEgMnU2YvxrgwMIFzau/D64P2g6NWVAGlC4hoLDcGOwQvLI3N2V4dfSp3ucMr9imm
 8cAHxmYk8RBd7rm7vaf451VDZ50N1wmgv1O3RI7wY0/oQRgYnIvhkBxYc8E3/ItdR95A99
 2zDC5RRti2D5LTmnvcTHFlEMnpVpKwQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-kLTJCBS5OB2l4bAaEOSxPw-1; Mon,
 02 Nov 2026 10:18:12 -0500
X-MC-Unique: kLTJCBS5OB2l4bAaEOSxPw-1
X-Mimecast-MFC-AGG-ID: kLTJCBS5OB2l4bAaEOSxPw_1793632691
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF09B1956068; Mon,  2 Nov 2026 15:18:10 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DFA1433; Mon,  2 Nov 2026 15:18:09 +0000 (UTC)
Date: Mon, 2 Nov 2026 15:18:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH] iotests: add --quiet arg to hide env variable dump
Message-ID: <auiprglCLIof6Lgm@redhat.com>
References: <20260623160611.2347282-1-berrange@redhat.com>
 <auimJx3lKKVupFPs@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auimJx3lKKVupFPs@redhat.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 04:03:03PM +0100, Kevin Wolf wrote:
> Am 23.06.2026 um 18:06 hat Daniel P. Berrangé geschrieben:
> > Every test run dumps a long list of environment variable settings.
> > While this is often useful, if you are trying to reproduce a bug
> > while repeatedly running a single test it can be quiet noisy. Add
> > a --quiet flag to 'check' which allows the env variable dump to
> > be hidden.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> The result doesn't feel terribly quiet to me, with all of the test cases
> still getting a line of their own. I would have expected that a quiet
> mode only prints errors and maybe the summary line at the end that tells
> you about passed and skipped test cases.

I felt the list of test cases was the core program output, while env
variables, etc were "supplementary info", so preserved the former.

My use case was primary single test at a time, where the output
now looks like:

  $ ./build/run ./build/tests/qemu-iotests/check --quiet -qcow2 080
  080   pass       [15:14:39] [15:14:42]   3.2s   (last: 3.2s)  
  Passed all 1 iotests

instead of

  $ ./build/run ./build/tests/qemu-iotests/check -qcow2 080
  QEMU          -- "/home/berrange/src/virt/qemu/build/qemu-system-x86_64" -nodefaults -display none -accel qtest
  QEMU_IMG      -- "/home/berrange/src/virt/qemu/build/qemu-img" 
  QEMU_IO       -- "/home/berrange/src/virt/qemu/build/qemu-io" --cache writeback --aio threads -f qcow2
  QEMU_NBD      -- "/home/berrange/src/virt/qemu/build/qemu-nbd" 
  IMGFMT        -- qcow2
  IMGPROTO      -- file
  PLATFORM      -- Linux/x86_64 berrange.csb 7.2.9-200.fc44.x86_64
  TEST_DIR      -- /home/berrange/src/virt/qemu/scratch
  SOCK_DIR      -- /tmp/qemu-iotests-rrynctwo
  GDB_OPTIONS   -- 
  VALGRIND_QEMU -- 
  PRINT_QEMU_OUTPUT -- 

  080   pass       [15:17:19] [15:17:22]   3.2s   (last: 3.2s)  
  Passed all 1 iotests

> Though I guess we could always have something like -qq for quieter
> output, so this is not a fundamental objection.
> 
> >  tests/qemu-iotests/check         | 4 +++-
> >  tests/qemu-iotests/testrunner.py | 7 ++++---
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> > index 3941eac8e2..c8ba536970 100755
> > --- a/tests/qemu-iotests/check
> > +++ b/tests/qemu-iotests/check
> > @@ -46,6 +46,8 @@ def make_argparser() -> argparse.ArgumentParser:
> >          description="Test run options",
> >          formatter_class=argparse.ArgumentDefaultsHelpFormatter)
> >  
> > +    p.add_argument('-q', '--quiet', action='store_true',
> > +                   help='reduce output verbosity to only test results')
> >      p.add_argument('-n', '--dry-run', action='store_true',
> >                     help='show me, do not run tests')
> >      p.add_argument('-j', dest='jobs', type=int, default=1,
> > @@ -230,6 +232,6 @@ if __name__ == '__main__':
> >          with TestRunner(env, tap=args.tap,
> >                          color=args.color) as tr:
> >              paths = [os.path.join(env.source_iotests, t) for t in tests]
> > -            ok = tr.run_tests(paths, args.jobs)
> > +            ok = tr.run_tests(paths, args.jobs, args.quiet)
> >              if not ok:
> >                  sys.exit(1)
> > diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
> > index dbe2dddc32..0eb7f144df 100644
> > --- a/tests/qemu-iotests/testrunner.py
> > +++ b/tests/qemu-iotests/testrunner.py
> > @@ -376,7 +376,7 @@ def run_test(self, test: str,
> >          sys.stdout.flush()
> >          return res
> >  
> > -    def run_tests(self, tests: List[str], jobs: int = 1) -> bool:
> > +    def run_tests(self, tests: List[str], jobs: int = 1, quiet: bool = False) -> bool:
> >          n_run = 0
> >          failed = []
> >          notrun = []
> 
> This line is too long now:
> 
> 297                             fail       [15:57:51] [15:58:02]   10.8s  (last: 10.6s) output mismatch (see /home/kwolf/source/qemu/build-clang/scratch/bochs-file-297/297.out.bad)
> --- /home/kwolf/source/qemu/tests/qemu-iotests/297.out
> +++ /home/kwolf/source/qemu/build-clang/scratch/bochs-file-297/297.out.bad
> @@ -1,2 +1,4 @@
>  === pylint ===
> +************* Module testrunner
> +testrunner.py:379:0: C0301: Line too long (86/79) (line-too-long)
>  === mypy ===

Ah, ok, will repost for that

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


