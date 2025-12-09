Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCA3D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 08:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vStON-0005PD-Pq; Tue, 09 Dec 2025 03:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vStOM-0005P0-Ni
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 03:48:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vStOL-0001tI-3d
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 03:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765270096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J3dL4k8vukFIKC3WSkmAfd0VNAoCvum86wDoLZICg8A=;
 b=W9cqzVsCLaRM9U9/kOgjM0asMv5NhKgHX99K482wvlCN16l36iJ5i5utU4iC/kyMAct99a
 E6P0GNC7bGicnkoHSPYoBnBxCBFqYl7wM2yQB/hpBmJv5z+i9/sDApoHurqtsRnILNqMHs
 MM8Y2F8D9akL0Jm9PpVK47KSA8mowvY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-cnbXKI6_NwmIwSQk9jXaDg-1; Tue,
 09 Dec 2025 03:48:09 -0500
X-MC-Unique: cnbXKI6_NwmIwSQk9jXaDg-1
X-Mimecast-MFC-AGG-ID: cnbXKI6_NwmIwSQk9jXaDg_1765270088
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50EAD195608E; Tue,  9 Dec 2025 08:48:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E88DC19560AD; Tue,  9 Dec 2025 08:48:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7941221E6A27; Tue, 09 Dec 2025 09:48:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  armbru@redhat.com,  marcandre.lureau@redhat.com,
 qemu-rust@nongnu.org
Subject: Re: [PATCH 16/19] scripts/qapi: strip trailing whitespaces
In-Reply-To: <20251010151006.791038-17-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 10 Oct 2025 17:10:01 +0200")
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-17-pbonzini@redhat.com>
Date: Tue, 09 Dec 2025 09:48:05 +0100
Message-ID: <87jyyw59dm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> This help workaround a rustfmt issue.

Which one?  Pointer suffices.

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20210907121943.3498701-16-marcandre.lurea=
u@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/qapi/gen.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index 0c9b8db3b02..c9721545ea7 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -58,7 +58,11 @@ def add(self, text: str) -> None:
>          self._body +=3D text
>=20=20
>      def get_content(self) -> str:
> -        return self._top() + self._preamble + self._body + self._bottom()
> +        content =3D self._top() + self._preamble + self._body + self._bo=
ttom()
> +        # delete trailing white-spaces (working around
> +        # https://github.com/rust-lang/rustfmt/issues/4248)
> +        content =3D re.sub(r'\s+$', '\n', content, 0, re.M)
> +        return content
>=20=20
>      def _top(self) -> str:
>          # pylint: disable=3Dno-self-use

This doesn't just delete trailing whitespace, it also collapses multiple
blank lines into one: \s matches newlines.

We lose the ability to generate multiple blank lines for all generators
based on QAPIGen: C (.c and .h), trace events, Rust.  Hmm.

Is collapsing blank lines necessary for working around the rustfmt
issue?

The generators other than the Rust generator do not emit trailing
whitespace.  Would that be practical for the Rust generator, too?


