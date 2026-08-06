Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80754C55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 05:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrqet-0003fo-Na; Thu, 06 Aug 2026 01:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wrqer-0003fN-MZ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 01:28:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wrqem-0002AS-JF
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 01:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785994117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xMvBAjjn2WrTC2tQZP28i2iF2BPm1ukyo7cIk9uoNiU=;
 b=SpKlWhafuY/4N7t9HGxr5LdpC/VT+P1YqJRxtuIYcmnejq5LokykZ0bKtxg7eHp+Q9xFqz
 3Qch79kBsi3uUo8odJ/9d4Io5B6tNp/uI2VqLGy7mFEE0B7/1FqgYVInRoZGqFIdsgFOkQ
 lpsFc17NNerLwPrDl14X7AvBC+YOzU8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-51otf-QbN--Rj55FUiOUXg-1; Thu,
 06 Aug 2026 01:28:33 -0400
X-MC-Unique: 51otf-QbN--Rj55FUiOUXg-1
X-Mimecast-MFC-AGG-ID: 51otf-QbN--Rj55FUiOUXg_1785994112
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5597818007FB; Thu,  6 Aug 2026 05:28:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD32B427; Thu,  6 Aug 2026 05:28:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6BA4621E6920; Thu, 06 Aug 2026 07:28:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>,  qemu-devel@nongnu.org,  Chao Liu
 <chao.liu@processmission.com>,  "Daniel P. Berrange"
 <berrange@redhat.com>,  Philippe Mathieu-Daude <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] checkpatch: warn about hunks which only add blank lines
In-Reply-To: <e8921043-2405-4b20-95f8-7cfc2d9bd8f9@redhat.com> (Thomas Huth's
 message of "Thu, 6 Aug 2026 06:37:34 +0200")
References: <20260731134046.1015479-1-den@openvz.org>
 <e8921043-2405-4b20-95f8-7cfc2d9bd8f9@redhat.com>
Date: Thu, 06 Aug 2026 07:28:29 +0200
Message-ID: <877bm3yg02.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> On 31/07/2026 15.40, Denis V. Lunev wrote:
>> Patches sometimes carry a hunk whose entire content is one or two
>> added blank lines. It changes nothing, it makes the diff longer and
>> it survives review because nobody looks twice at a blank line. The
>> blank line itself is perfectly fine, the gratuitous hunk is not.
>
> Well, I wouldn't say that the blank line itself is fine. It depends.
> In source code, there normally should not be more than one empty line between code blocks, that's why I complained to the patch in your pull request.

For what it's worth, Python style *demands* two blank lines in places.
Here's what happens when I delete one of them:

    $ pycodestyle scripts/qapi/parser.py 
    scripts/qapi/parser.py:656:1: E302 expected 2 blank lines, found 1

Why?  PEP 8 "Style Guide for Python Code" section "Blank Lines":

--> Surround top-level function and class definitions with two blank
--> lines.

    Method definitions inside a class are surrounded by a single blank
    line.

    Extra blank lines may be used (sparingly) to separate groups of
    related functions. Blank lines may be omitted between a bunch of
    related one-liners (e.g. a set of dummy implementations).

    Use blank lines in functions, sparingly, to indicate logical
    sections.

    Python accepts the control-L (i.e. ^L) form feed character as
    whitespace; many tools treat these characters as page separators, so
    you may use them to separate pages of related sections of your
    file. Note, some editors and web-based code viewers may not
    recognize control-L as a form feed and will show another glyph in
    its place.

We run pycodestyle via flake8 from python/tests/linters.py.  Still not
part of "make check".

[...]


