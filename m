Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D318ACCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 08:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8aN8-00058X-Dm; Tue, 14 Oct 2025 04:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v8aN6-00057v-UN
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v8aN2-0004L9-OV
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760430419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SQ6bqhqmgQvV3BqM1we6Mx7PD1rUGj8m3YMzOR47ZWs=;
 b=QXrb6BYiWVeDGsfrjKSAxmQe+3aZnfa6ZlQAxqlMsvT+OVCsEwaKmPg5F3fmxLy4swKHL2
 9L7f1OX9oftLellK1zLj0dobJTgQV/dUGugzwrIrn1w129sosCg/hXhpC/OKwycefpDWCw
 2eHW+da8EO7HoyGZRLNIi3zBGiRZXJ0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-PLuYjgBAOMufQyEdfzShpw-1; Tue,
 14 Oct 2025 04:26:55 -0400
X-MC-Unique: PLuYjgBAOMufQyEdfzShpw-1
X-Mimecast-MFC-AGG-ID: PLuYjgBAOMufQyEdfzShpw_1760430414
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A2CC19560BB; Tue, 14 Oct 2025 08:26:54 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.78])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF5301800447; Tue, 14 Oct 2025 08:26:51 +0000 (UTC)
Date: Tue, 14 Oct 2025 10:26:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 2/4] tests: rearrange suites for I/O tests
Message-ID: <aO4JSRfDAn6Jq7Hn@redhat.com>
References: <20251008113552.747002-1-berrange@redhat.com>
 <20251008113552.747002-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251008113552.747002-3-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 08.10.2025 um 13:35 hat Daniel P. Berrangé geschrieben:
> Currently there are 5 block formats, each classified as either quick,
> slow or thorough. This classification then determines what tests we
> add to meson suites. The suites are as follows
> 
>   * block
> 
>     => tests listed by 'check -g auto -n' for 'quick' formats
> 
>   * slow, block-slow
> 
>     => tests listed by 'check -n' for 'slow' formats or 'check -g auto -n'
>        for 'quick' formats
> 
>   * thorough, block-thorough
> 
>     => tests listed by 'check -n' for 'thorough' formats
> 
> The pairs of suites 'slow' / 'block-slow' and 'thorough' / 'block-thorough'
> match in terms of what tests are enabled. The only difference is whether
> non-block related tests are also in the suite.
> 
> There are two problems with this
> 
>  * If a format is classified as 'quick', we don't expose any
>    meson suite for running *all* tests, only the 'auto' tests.
> 
>    eg there is no suite to run all qcow2 tests, only 'quick'
>    tests can be run via meson, even if using 'SPEED=slow' we
>    still filter to only 'auto' tests.
> 
>  * There is no suite that allows running all tests for a given
>    format.
> 
>    eg there is no suite to run only 'raw' tests - you can only
>    use 'block-slow' which runs both raw and "auto" qcow2 tests.
> 
>    eg there is no suite to run only 'vpc' tests - you can only
>    use 'block-thorough' which runs qed, vmdk & vpc tests.
> 
> This patch suggests that 'block-slow' and 'block-thorough' are
> not actually compelling use cases, and should be dropped. ie it
> is not expected that people need to run all VPC, VMDK and QED
> tests at the same time. Instead a more useful feature is the
> ability to run all tests for a given format. Further the 'auto'
> filtering should only apply in the default 'block' target/suite.
> 
> IOW, with this patch we get the follows meson suites:
> 
>  * 'block' - 'auto' tests for any format listed as 'quick'
>              Currently just qcow2 'auto' tests
>  * 'block-$FORMAT' - ALL tests for the given $FORMAT, for each
>                      of qcow2, raw, qed, vmdk & vpc
>  * 'slow' - ALL tests for formats tagged with 'quick' or 'slow'
>  * 'thorough' - ALL tests formats tagged with 'thorough'
> 
> This corresponds to the following make targets.
> 
>  * 'make check-block'
> 
>     => runs only 'auto' qcow2 tests  (unchanged)
> 
>  * 'make check-block SPEED=thorough'
> 
>     => runs all 'qed', 'vmdk', 'vpc' tests (unchanged)

Also all qcow2 and raw tests, right?

Quotes are a bit inconsistent here in the commit message. Sometimes
you use quotes for format names like here, but in other places you use
quotes for 'auto' and leave format names without quotes.

>  * 'make check-block SPEED=slow'
> 
>     => runs all 'raw' tests (unchanged)
>     => runs all 'qcow2' tests (previously was only 'auto' tests)
> 
>  * 'make check-block-qcow2'
> 
>      => runs all qcow2 tests (new feature)
> 
>  * 'make check-block-raw'
> 
>      => runs all raw tests (new feature)
> 
>  * 'make check-block-vpc'
> 
>      => runs all vpc tests (new feature)
> 
>  * 'make check-block-qed'
> 
>      => runs all qed tests (new feature)
> 
>  * 'make check-block-vmdk'
> 
>      => runs all vmdk tests (new feature)
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  tests/qemu-iotests/meson.build | 48 ++++++++++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
> index fad340ad59..939a14ffae 100644
> --- a/tests/qemu-iotests/meson.build
> +++ b/tests/qemu-iotests/meson.build
> @@ -35,23 +35,21 @@ endforeach
>  qemu_iotests_check_cmd = files('check')
>  
>  foreach format, speed: qemu_iotests_formats
> -  if speed == 'quick'
> -    suites = 'block'
> -  else
> -    suites = ['block-' + speed, speed]
> -  endif
> -
> -  args = ['-tap', '-' + format]
> -  if speed == 'quick'
> -      args += ['-g', 'auto']
> -  endif
> +  listargs = ['-tap', '-' + format]
>  
>    rc = run_command(
> -      [python, qemu_iotests_check_cmd] + args + ['-n'],
> +      [python, qemu_iotests_check_cmd] + listargs + ['-n'],
>        check: true,
>    )
>  
>    foreach item: rc.stdout().strip().split()
> +      suites = ['block-' + format]
> +      if speed == 'quick'
> +          suites += ['slow']
> +      else
> +          suites += [speed]
> +      endif
> +
>        args = [qemu_iotests_check_cmd,
>                '-tap', '-' + format, item,
>                '--source-dir', meson.current_source_dir(),
> @@ -68,4 +66,32 @@ foreach format, speed: qemu_iotests_formats
>             timeout: 180,
>             suite: suites)
>    endforeach
> +
> +  if speed == 'quick'
> +      listargs += ['-g', 'auto']
> +      suites = ['block']
> +
> +      rc = run_command(
> +          [python, qemu_iotests_check_cmd] + listargs + ['-n'],
> +          check: true,
> +      )
> +
> +      foreach item: rc.stdout().strip().split()
> +          args = [qemu_iotests_check_cmd,
> +                  '-tap', '-' + format, item,
> +                  '--source-dir', meson.current_source_dir(),
> +                  '--build-dir', meson.current_build_dir()]
> +          # Some individual tests take as long as 45 seconds
> +          # Bump the timeout to 3 minutes for some headroom
> +          # on slow machines to minimize spurious failures
> +          test('io-' + format + '-' + item,
> +               python,
> +               args: args,
> +               depends: qemu_iotests_binaries,
> +               env: qemu_iotests_env,
> +               protocol: 'tap',
> +               timeout: 180,
> +               suite: suites)
> +      endforeach
> +  endif
>  endforeach

The code itself looks good to me.

Kevin


