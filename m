Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B2EC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZEx-0003LV-SG; Tue, 15 Jul 2025 02:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubZBG-000087-EF
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubZBB-0003G9-Af
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752561015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6xqVTsnoVa90FxN99Ti9fZJDaGrf9sbsLNEOK36OCOY=;
 b=OCbz+kF+SQx6OH0FcO2FFyEECsmzCgag7U/LmzWRYCuDuDO36f3abbt5h0VDywvyQQte0y
 rib0Xier3p6JvtDq2oRkjLfL4fwqCjQ9iTiwx4j2r6fVJQucJU+cHF1I2C4wwIhq2qeYJZ
 pZiq36jS+Lkd79/+a3sHyBynAJ9aeLg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-2Q6Ll_MoOhGgS6jacR0TxQ-1; Tue,
 15 Jul 2025 02:30:13 -0400
X-MC-Unique: 2Q6Ll_MoOhGgS6jacR0TxQ-1
X-Mimecast-MFC-AGG-ID: 2Q6Ll_MoOhGgS6jacR0TxQ_1752561012
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60F0D19560B8; Tue, 15 Jul 2025 06:30:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9EF61977000; Tue, 15 Jul 2025 06:30:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 00FE221E6A27; Tue, 15 Jul 2025 08:30:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 00/32] QAPI patches patches for 2025-07-14
In-Reply-To: <CAJSP0QV7OS5z65M-5pYdRrj4e-5xmBH=nqHtrrMJAnDcm=Yf8A@mail.gmail.com>
 (Stefan Hajnoczi's message of "Tue, 15 Jul 2025 00:26:53 -0400")
References: <20250714134458.2991097-1-armbru@redhat.com>
 <CAJSP0QV7OS5z65M-5pYdRrj4e-5xmBH=nqHtrrMJAnDcm=Yf8A@mail.gmail.com>
Date: Tue, 15 Jul 2025 08:30:08 +0200
Message-ID: <87jz4age4v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Mon, Jul 14, 2025 at 11:14=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>>
>> The following changes since commit 9a4e273ddec3927920c5958d2226c6b38b543=
336:
>>
>>   Merge tag 'pull-tcg-20250711' of https://gitlab.com/rth7680/qemu into =
staging (2025-07-13 01:46:04 -0400)
>>
>> are available in the Git repository at:
>>
>>   https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2025-07-14
>>
>> for you to fetch changes up to 07273ca0ce3af397071f7a6c11abdab649ff25e1:
>>
>>   tests/qtest/qom-test: unit test for qom-list-get (2025-07-14 15:25:12 =
+0200)
>>
>> ----------------------------------------------------------------
>> QAPI patches patches for 2025-07-14
>>
>> ----------------------------------------------------------------
>> John Snow (27):
>>       docs/sphinx: adjust qapidoc to cope with same-line error sections
>>       docs/sphinx: parse @references in freeform text
>>       docs/sphinx: remove legacy QAPI manual generator
>>       docs/sphinx: remove special parsing for freeform sections
>>       qapi: lift restriction on using '=3D' in doc blocks
>>       docs/qapi-domain: add return-nodesc
>>       qapi: Fix undocumented return values by generating something
>>       qapi: remove trivial "Returns:" sections
>>       qapi: rephrase return docs to avoid type name
>>       qapi: add cross-references to acpi.json
>>       qapi: add cross-references to authz.json
>>       qapi: add cross-references to block layer
>>       qapi: add cross-references to crypto.json
>>       qapi: add cross-references to dump.json
>>       qapi: add cross-references to job.json
>>       qapi: add cross-references to Machine core
>>       qapi: add cross-references to migration.json
>>       qapi: add cross-references to net.json
>>       qapi: add cross-references to pci.json
>>       qapi: add cross-references to QOM
>>       qapi: add cross-references to replay.json
>>       qapi: add cross-references to run-state.json
>>       qapi: add cross-references to sockets.json
>>       qapi: add cross-references to ui.json
>>       qapi: add cross-references to virtio.json
>>       qapi: add cross-references to yank.json
>>       qapi: add cross-references to misc modules
>>
>> Markus Armbruster (2):
>>       qapi: Clean up "This command will do ..." command descriptions
>>       qapi: Clean up a few Errors: sections
>>
>> Steve Sistare (3):
>>       qom: qom-list-get
>>       python: use qom-list-get
>>       tests/qtest/qom-test: unit test for qom-list-get
>
> The check-python-minreqs CI job is failing:
>
> qemu/utils/qom.py:35:1: F401 'qemu.qmp.ExecuteError' imported but unused
> qemu/utils/qom.py:241:34: E201 whitespace after '['
> qemu/utils/qom.py:241:56: E202 whitespace before ']'
> qemu/utils/qom.py:244:30: E711 comparison to None should be 'if cond is N=
one:'
> qemu/utils/qom.py:245:33: F541 f-string is missing placeholders
> qemu/utils/qom.py:254:5: E303 too many blank lines (2)
> Log file "stderr" content for test "01-tests/flake8.sh" (FAIL):
> Log file "stdout" content for test "05-tests/mypy.sh" (FAIL):
> qemu/utils/qom_common.py:96: error: Function is missing a type
> annotation [no-untyped-def]
> qemu/utils/qom_common.py:192: error: Function is missing a type
> annotation for one or more arguments [no-untyped-def]
> qemu/utils/qom.py:227: error: Bracketed expression "[...]" is not
> valid as a type [valid-type]
> qemu/utils/qom.py:227: note: Did you mean "List[...]"?
> Found 3 errors in 2 files (checked 22 source files)
> Log file "stderr" content for test "05-tests/mypy.sh" (FAIL):
> Log file "stdout" content for test "33-tests/pylint.sh" (FAIL):
> ************* Module /builds/qemu-project/qemu/python/setup.cfg
> setup.cfg:1:0: W0012: Unknown option value for '--disable', expected a
> valid pylint message and got 'too-many-positional-arguments'
> (unknown-option-value)
> ************* Module utils.qom
> qemu/utils/qom.py:244:23: C0121: Comparison 'value =3D=3D None' should be
> 'value is None' (singleton-comparison)
> qemu/utils/qom.py:245:32: W1309: Using an f-string that does not have
> any interpolated variables (f-string-without-interpolation)
> qemu/utils/qom.py:35:0: W0611: Unused ExecuteError imported from
> qemu.qmp (unused-import)
> ************* Module utils.qom_common
> qemu/utils/qom_common.py:92:0: R0903: Too few public methods (1/2)
> (too-few-public-methods)
>
> https://gitlab.com/qemu-project/qemu/-/jobs/10682353448
>
> Please take a look and resend this pull request if fixes are necessary. T=
hanks!

Sorry about that.  I'm going to split this pull request: 29 unmodified
patches now, the three remaining as soon as they're ready.


