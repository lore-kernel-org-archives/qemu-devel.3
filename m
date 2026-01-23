Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07992D7789E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 17:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjLMq-0005Iq-C2; Fri, 23 Jan 2026 12:54:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joe@perches.com>) id 1vjLMo-0005FB-QO
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 12:54:42 -0500
Received: from smtprelay0015.hostedemail.com ([216.40.44.15]
 helo=relay.hostedemail.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joe@perches.com>) id 1vjLMn-0003rK-96
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 12:54:42 -0500
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
 by unirelay04.hostedemail.com (Postfix) with ESMTP id 82CBB1A04FF;
 Fri, 23 Jan 2026 17:54:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf18.hostedemail.com (Postfix) with ESMTPA id E119037; 
 Fri, 23 Jan 2026 17:54:35 +0000 (UTC)
Message-ID: <18c9df0128a437af4043a5d4978ee09843da7d75.camel@perches.com>
Subject: Re: [RFC PATCH v2 00/16] MAINTAINER updates plus conversion of
 get_maintainers.pl to python
From: Joe Perches <joe@perches.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@linaro.org>, Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>, John Snow <jsnow@redhat.com>, Florian
 Mickler <florian@mickler.org>
Date: Fri, 23 Jan 2026 09:54:34 -0800
In-Reply-To: <20260123145750.1200879-1-alex.bennee@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-Stat-Signature: recapgbzyw9ef5zkabatsrimn986k9ji
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E119037
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+6gKviBaomqFLDCp19QLPtNrArxqXme7M=
X-HE-Tag: 1769190875-411237
X-HE-Meta: U2FsdGVkX1+mX/eXUw1hDLs8+HyIa9WvduI8zQltnxSbiA1DuW7r4sTR4kG1K7tOUu+aVgTSGKMo2KhjSeDEhOEXdZspKf4bUinK/6OkC44zFLhuFqTNSSxK2QND1xdzdYSzQdMtiv+1Gjak6EaxXfB45a9mAyTAQS6gYUTpa9QaJldEvtNNg6OaVzmZDhVALfdaXJkKa0PY6usLLqQd79hCd3olsbi6tmEKfPbaEhokS7CFb4HlCmInpxzgVM4wQp1+DNLa37cjXAS2lVC/Fp7mtYjhIfzihZ0RfuIZWIPqPCd07CyWtS9pDSQfhBV8
Received-SPF: pass client-ip=216.40.44.15; envelope-from=joe@perches.com;
 helo=relay.hostedemail.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

On Fri, 2026-01-23 at 14:57 +0000, Alex Benn=E9e wrote:
> I wanted to look at adding gitlab tags to MAINTAINERS and baulked
> slightly at figuring out what I would need to change in the perl
> script to cleanly handle it.
>=20
> While we imported the perl script from the kernel I'm fairly sure we
> don't use half the features it has and as us grey beards age out less
> people will be willing to tweak it. Consider this a proof-of-concept
> for discussion about if it is worth perusing this path.
>=20
> For v2:
>=20
>   - added the missing K: keyword support
>   - added basic --git fallback support
>   - picked up a few more MAINTAINER updates from list
>   - updated entries for Arm and *-user
>=20
> I've CC'd the kernel maintainers for the script to see if they are
> interested in this work.

I think rewrites aren't particularly useful but, your time, your choices.

Perhaps the --interactive bit of the script isn't necessary to convert.
I don't know that anyone uses it.

Adding Florian Mickler who wrote the --interactive code to cc's
(15+ years ago now)

