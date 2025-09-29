Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17640CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 07:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v38jG-0002bW-0H; Mon, 29 Sep 2025 03:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v38jB-0002bD-KQ
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 03:55:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v38ix-0000bX-QZ
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 03:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759132497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NGEDkSWCVsZRgU5HjSTd1kzJlNXgZiZXVeNLhXwEtC8=;
 b=Fmn2CauMo8CDUEYVOgpdNbXhQDK6zI2JmQuc+T6QBc3+VbaZrfI+qxwzrAFnwlmHePMEGA
 NnMw4lPRH92bgnDbPID42MkXxDnZPoCRU5sLZFJCkxaGv06YLm5+dz41ke/GPJcbQEwfhE
 s7z3wAADh/HN3WmGbPKPBtVDqMB5RXQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-mxSvSRywOGy61lLJClJPyA-1; Mon,
 29 Sep 2025 03:54:53 -0400
X-MC-Unique: mxSvSRywOGy61lLJClJPyA-1
X-Mimecast-MFC-AGG-ID: mxSvSRywOGy61lLJClJPyA_1759132492
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AE16180035C; Mon, 29 Sep 2025 07:54:52 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.153])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF6FC30001A4; Mon, 29 Sep 2025 07:54:48 +0000 (UTC)
Date: Mon, 29 Sep 2025 09:54:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 3/3] docs/code-provenance: AI exceptions are in addition
 to DCO
Message-ID: <aNo7RaEOKJ5GFjNQ@redhat.com>
References: <20250922154843.60233-1-pbonzini@redhat.com>
 <20250922154843.60233-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922154843.60233-4-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.539,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Am 22.09.2025 um 17:48 hat Paolo Bonzini geschrieben:
> Using phrasing from https://openinfra.org/legal/ai-policy (with just
> "commit" replaced by "submission", because we do not submit changes
> as commits but rather emails), clarify that the contributor remains
> responsible for its copyright or license status.

I feel here the commit message is clearer than...

> [This is not my preferred phrasing.  I would prefer something lighter
> like "the "Signed-off-by" label in the contribution gives the author
> responsibility".  But for the sake of not reinventing the wheel I am
> keeping the exact words from the OpenInfra policy.]
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/code-provenance.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> index 103e0a97d76..41062f29639 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -341,3 +341,9 @@ or more general revisions. This can be done by contacting the qemu-devel
>  mailing list with details of a proposed tool, model, usage scenario, etc.
>  that is beneficial to QEMU, while still mitigating the legal risks to the
>  project.  After discussion, any exception will be listed below.
> +
> +Exceptions do not remove the need for authors to comply with all other
> +requirements for contribution.  In particular, the "Signed-off-by"
> +label in a patch submissions is a statement that the author takes
> +responsibility for the entire contents of the patch, including any
> parts +that were generated or assisted by AI tools or other tools.

...the actually committed text. We should probably mention "copyright or
license status" explicitly here in some way instead of just a more
generic "responsibility for the entire contents" without referring to
copyright.

Maybe something like "...responsibility for the entire contents of the
patch and in particular its copyright or license status, ..."

Kevin


