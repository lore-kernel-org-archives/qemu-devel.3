Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466E5CD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXF3v-00009i-78; Wed, 10 Jun 2026 05:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wXF3t-00009B-Bf
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 05:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wXF3r-0006FV-E9
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 05:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781083042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4xZMSY2cY3V0vU5SGZLBx2sj76ShEiouLQ1+dt8AKPQ=;
 b=P1A06+A89sIgbpooqDWNK00CxxQLxoF5NJEwfSYQJGX8YUo+WtHHccn7lsfDwVgNIkMEhq
 Ad06h9bnXoCcwgiMHRrwsIR40OlRbMRFyQVtSRzaiQMkm5IL9PAAPJu+bGq11NYBJKsEfQ
 jxsJx6/p/+0HxrQUe6vfkd3kHMfsxzI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-XHH6dIVFNB6ImMxGHOrwBA-1; Wed,
 10 Jun 2026 05:17:17 -0400
X-MC-Unique: XHH6dIVFNB6ImMxGHOrwBA-1
X-Mimecast-MFC-AGG-ID: XHH6dIVFNB6ImMxGHOrwBA_1781083035
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C48681801BEF; Wed, 10 Jun 2026 09:17:14 +0000 (UTC)
Received: from [10.44.34.108] (unknown [10.44.34.108])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70351195410A; Wed, 10 Jun 2026 09:17:10 +0000 (UTC)
Message-ID: <0a0a1116-a5f3-45f2-b079-f66e6b17f672@redhat.com>
Date: Wed, 10 Jun 2026 11:17:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] tests/tcg: run tests with meson
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/9/26 23:47, Pierrick Bouvier wrote:
> This series is an experiment to replace TCG tests makefiles with meson, with the
> goal of having something more readable and maintainable in the long term.
> Also it closes the gap that tcg tests had with the rest of tests, by integrating
> them with meson directly.
> 
> It covers all existing tests for aarch64 architecture, including
> user/system/multiarch-user/multiarch-system. I'll carry the effort to port all
> other architectures once we agree on a base. We agreed with Alex to not merge
> anything before all arch are covered.
> 
> Series first declare the global infrastructure, then add aarch64 and multiarch
> tests, and finally plugin tests.
> 
> For review, I would suggest to start with aarch64 patches (end of the series) to
> get an idea of what they will look like, before the implementation itself. You
> can also compare that to existing Makefiles, they follow the same order.
> 
> It implements all requirements listed on original thread [1], except cross
> container support, which can be easily added on top once we agree on the base.
> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/

> We also have for free:
> - correct and complete dependencies for any test, including:
>    scripts, c.inc, headers, reference files and binaries/plugins.
> - catch test declaration issues at configure time vs test time.
> - proper data types for variables instead of string expansion with make.
> - we could now build tests binaries by default with 'all' target.
> - hopefully, better readability to your taste.

Yes there is absolutely a readability improvement!  At most, one could 
say that it's not a very high bar. :)

Having to reinvent cross compilation (cc_has_feat, custom_targets for 
compilation) is not great and the only part I'm not super convinced 
about; I wonder what it would be like to make TCG tests their own 
standalone meson projects.  While the Makefiles are awful I do like 
being able to do "make -C tests/tcg/x86_64-softmmu", and in that respect 
this would be a half step backwards (and a big step forwards in many 
other respects, mind).

I can help with the integration of the individual test suites into 
tests/tcg/Makefile.include.

Paolo

> Main ideas for the current design are:
> - make arch files as simple and explicit as possible. If it conflicts,
>    always pick explicit, as long as we don't expose meson details.
>    remove any kind of "skip, override, filter" logic.
> - never expose custom_target and meson details in arch files.
> - catch any spelling mistake on test or any dependency.
> - keep complexity contained in tests/tcg/meson.build.
> 
> Usage:
> 
> ```
> make check-tcg
> make check-tcg-aarch64-linux-user
> make check-tcg-aarch64-softmmu
> 
> from build folder:
> ./pyvenv/bin/meson test --list --suite tcg
> ninja clean
> ./pyvenv/bin/meson test aarch64-softmmu-asid2 --verbose
> ```
> 
> Pierrick Bouvier (27):
>    tests/tcg/multiarch/system/memory.c: remove unused variable
>    tests/tcg/multiarch/plugin/check-plugin-output.sh: take test output as
>      input
>    tests/tcg/multiarch/plugin: rename check-plugin-output to
>      regex-compare
>    tests/tcg: introduce meson.build
>    tests/tcg/meson.build: introduce exe_name
>    tests/tcg/meson.build: introduce test_name
>    tests/tcg/meson.build: introduce cflags
>    tests/tcg/meson.build: introduce qemu_args
>    tests/tcg/meson.build: introduce env_var
>    tests/tcg/plugins: build list of test_plugins
>    tests/tcg/meson.build: introduce plugin_test
>    tests/tcg/meson.build: test gdb support and introduce gdb_arch
>    tests/tcg/meson.build: introduce gdb_test
>    tests/tcg/meson.build: add default flag for testing compiler support
>    tests/tcg/meson.build: introduce wrapper
>    tests/tcg/meson.build: introduce expected_output
>    tests/tcg/meson.build: add wrapper run_and_check_forbidden_output
>    tests/tcg/meson.build: add wrapper run_with_input
>    tests/tcg/meson.build: add wrapper record_replay
>    tests/tcg/meson.build: add wrapper check_plugin_output
>    tests/tcg/aarch64: add user tests
>    tests/tcg/aarch64: add system tests
>    tests/tcg/multiarch: declare user tests
>    tests/tcg/aarch64: add multiarch user tests
>    tests/tcg/multiarch: declare system tests
>    tests/tcg/aarch64: add multiarch system tests
>    tests/tcg/meson.build: add generic plugin tests
> 
>   tests/meson.build                             |   2 +-
>   tests/tcg/aarch64/meson.build                 | 248 ++++++++++++++++
>   tests/tcg/aarch64/system/meson.build          | 100 +++++++
>   tests/tcg/meson.build                         | 276 ++++++++++++++++++
>   tests/tcg/multiarch/Makefile.target           |   3 +-
>   tests/tcg/multiarch/meson.build               | 149 ++++++++++
>   .../multiarch/plugin/check-plugin-output.sh   |  36 ---
>   tests/tcg/multiarch/plugin/regex-compare.sh   |  28 ++
>   tests/tcg/multiarch/sha1.ref                  |   1 +
>   tests/tcg/multiarch/system/memory.c           |   3 +-
>   tests/tcg/multiarch/system/meson.build        |  53 ++++
>   tests/tcg/plugins/meson.build                 |  11 +-
>   tests/tcg/scripts/check_plugin_output.sh      |  19 ++
>   tests/tcg/scripts/record_replay.sh            |  16 +
>   .../scripts/run_and_check_forbidden_output.sh |  19 ++
>   tests/tcg/scripts/run_and_diff.sh             |  12 +
>   tests/tcg/scripts/run_with_input.sh           |  12 +
>   17 files changed, 943 insertions(+), 45 deletions(-)
>   create mode 100644 tests/tcg/aarch64/meson.build
>   create mode 100644 tests/tcg/aarch64/system/meson.build
>   create mode 100644 tests/tcg/meson.build
>   create mode 100644 tests/tcg/multiarch/meson.build
>   delete mode 100755 tests/tcg/multiarch/plugin/check-plugin-output.sh
>   create mode 100755 tests/tcg/multiarch/plugin/regex-compare.sh
>   create mode 100644 tests/tcg/multiarch/sha1.ref
>   create mode 100644 tests/tcg/multiarch/system/meson.build
>   create mode 100755 tests/tcg/scripts/check_plugin_output.sh
>   create mode 100755 tests/tcg/scripts/record_replay.sh
>   create mode 100755 tests/tcg/scripts/run_and_check_forbidden_output.sh
>   create mode 100755 tests/tcg/scripts/run_and_diff.sh
>   create mode 100755 tests/tcg/scripts/run_with_input.sh
> 


