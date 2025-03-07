Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033FAC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 10:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqVOF-0005x8-Vd; Fri, 07 Mar 2025 05:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqVOE-0005wv-4m
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:57:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqVOC-0003BA-9Q
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741345030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pqivcjU1Um+DLgjx4G+j5q3nsFFSrUu9IFvKpbpM2tk=;
 b=VgpTAvadJuYNGmRWEafNvIPvEApiXBKwhn3f/+FtPkZCj0lGU1XHsHjFI8nAEBbWUPJlnH
 sCJwb6N9n4NS+5ih20OTafFOxAy7Ka9io2LQpgnYQ1kuClJKSxzFbbs4ENo1J1N+AwyjCN
 7F+zpH67qXgaod/UPrykq9YoqjpddRM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-KLb5NLywOF2kmvvzMaY0Yw-1; Fri,
 07 Mar 2025 05:57:04 -0500
X-MC-Unique: KLb5NLywOF2kmvvzMaY0Yw-1
X-Mimecast-MFC-AGG-ID: KLb5NLywOF2kmvvzMaY0Yw_1741345023
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08FAD180AF4D; Fri,  7 Mar 2025 10:57:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B232D180AF7A; Fri,  7 Mar 2025 10:57:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C55E21E675F; Fri, 07 Mar 2025 11:57:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Harmonie Snow <harmonie@gmail.com>
Subject: Re: [PATCH 23/57] docs/qapi-domain: add :ifcond: directive option
In-Reply-To: <20250305034610.960147-24-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:32 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-24-jsnow@redhat.com>
Date: Fri, 07 Mar 2025 11:57:00 +0100
Message-ID: <87cyetm7lv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

John Snow <jsnow@redhat.com> writes:

> Add a special :ifcond: option that allows us to annotate the
> definition-level conditionals.
>
> RFC: This patch renders IFCOND information in two places, because I'm
> undecided about how to style this information. One option is in the
> signature bar, and another option is in an eye-catch, like :deprecated:
> or :unstable:.
>
> A benefit to having this be a directive option is that we can put it in
> the signature bar, the QAPI index, etc. However, if we merely want it in
> the content section, a directive would work just as well,
> e.g. ".. qapi:ifcond:: CONFIG_LINUX".

You haven't implemented conditionals that aren't at definition-level.
As I said elsewhere, that's okay for now.  All I want to say here is
that implementing it might influence your preference on how to do the
definition-level conditionals.  That's fine, we can revisit this.

> (Though, having it be in the same containing box as the unstable/ifcond
> boxes might require some extra fiddling/post-processing to
> achieve. Generally, the less docutils tree muddling I have to do, the
> happier I am.)
>
> The syntax of the argument is currently undefined, but it is possible to
> parse it back down into constituent parts to avoid applying literal
> formatting to "AND" or "&&" or whichever syntax we formalize. (Or, in
> the future, applying cross-reference links to the config values for
> additional reading on some of those build options. Not for this series.)
>
> "Vote now on your phones!"

Find my vote here:

    Message-ID: <87zfhya0is.fsf@pond.sub.org>
    https://lore.kernel.org/qemu-devel/87zfhya0is.fsf@pond.sub.org/

> Signed-off-by: Harmonie Snow <harmonie@gmail.com>
> Signed-off-by: John Snow <jsnow@redhat.com>


