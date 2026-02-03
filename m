Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA12E6E803
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnE6x-0005OE-Hl; Tue, 03 Feb 2026 05:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vnE6v-0005Nr-HI
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:58:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vnE6u-0004M5-0C
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770116298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WlQ3Va8gtv/vpAonmfA6LshMtNGtaeiTGtkOOqxrVRs=;
 b=S+/k3CYa/xf9KiN6jRFWvr8g+bMWieMwCE0AMrdjSK1D1FJmB4Fj3bc1KwhVRHu8g0mqDE
 jGjZflRBKrMZKyKLmJartQMm5VSlq1ef4hT1bwigUMV0kzOy7SiQGrY/KHM6EumTjqqd+R
 oM9wfbTZVldO703o6DbiVyNYZqLMpyA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-2q9Td4KqPiymbigKihavGA-1; Tue,
 03 Feb 2026 05:58:14 -0500
X-MC-Unique: 2q9Td4KqPiymbigKihavGA-1
X-Mimecast-MFC-AGG-ID: 2q9Td4KqPiymbigKihavGA_1770116293
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6922D1956088; Tue,  3 Feb 2026 10:58:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1E6E1956053; Tue,  3 Feb 2026 10:58:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 58B6621E692D; Tue, 03 Feb 2026 11:58:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>,  Joe Perches
 <joe@perches.com>,  John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH v2 08/16] MAINTAINERS: be realistic about *-user
In-Reply-To: <aYHDKafOxzPL8DhL@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 3 Feb 2026 09:43:05 +0000")
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
 <20260123145750.1200879-9-alex.bennee@linaro.org>
 <CANCZdfo3yz=aC-EOxd2LYBX=tf=RQTY6ibCpj-fCfGHZtH6WTw@mail.gmail.com>
 <aXOok4KRTvgwx7GJ@redhat.com>
 <CANCZdfoXfeBh5For_Cag+191GkjDtsqBNZ4LU1g2DYepkYoaBw@mail.gmail.com>
 <CANCZdfqBKMt5qxfrEhudTbrkMzKRzVATuTWXnRnPttVj6UZ5HA@mail.gmail.com>
 <aYHDKafOxzPL8DhL@redhat.com>
Date: Tue, 03 Feb 2026 11:58:10 +0100
Message-ID: <871pj23xh9.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Feb 02, 2026 at 02:57:57PM -0700, Warner Losh wrote:

[...]

>> One question I have, should include these lines
>>     =F0=9F=A4=96 Generated with [Claude Code](https://claude.com/claude-=
code)
>>     Co-Authored-By: Claude <noreply@anthropic.com>
>
> Commit message tags like this are considered to be referring to the
> code in the commit body, so that would be potentially misleading.
>
> Personally, I also don't like the concept of providing free advertizing
> for commercial tools in commit messages.
>
> If you've exclusively used it for commit metadata, then IMHO it would
> be sufficient to just mention this in the cover letter description,
> and explicitly say it had no part in writing the code, etc.

+1


