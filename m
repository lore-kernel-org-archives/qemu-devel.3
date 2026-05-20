Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74979CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfAS-0008EU-M9; Wed, 20 May 2026 07:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPfAL-00086I-7Z
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:32:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPfAH-0005Py-Ne
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779276759;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DmI1i4ZLPGwJ94757clEo8XVYHE5lBXGLjLjlr2GDaQ=;
 b=Xpqlx1MC3jIOQ14azmjCPpiO1h2YgZh5zeSFMX360Q1fBcOmx2Qieemi3SwnwzWJFKGnEi
 vqyD3QEo6ISImAUrghg1ooJ5Rqo6H77crffA/mjJ/s+dVeX7ew6oZZ9lOeiWKTAqbc27pC
 yiG/ol097xgsmlM88l5/+bx1wZCSo88=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-ZqTlwNnlNJqZRGbrhXzorQ-1; Wed,
 20 May 2026 07:32:36 -0400
X-MC-Unique: ZqTlwNnlNJqZRGbrhXzorQ-1
X-Mimecast-MFC-AGG-ID: ZqTlwNnlNJqZRGbrhXzorQ_1779276755
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D717619560A2; Wed, 20 May 2026 11:32:34 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.211])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79C28180034E; Wed, 20 May 2026 11:32:33 +0000 (UTC)
Date: Wed, 20 May 2026 12:32:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs/code-provenance: Fix formatting of *-by tags
Message-ID: <ag2bzfFmeAE1WozR@redhat.com>
References: <20260520-prov-v1-1-7a58af334b9c@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520-prov-v1-1-7a58af334b9c@9elements.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 20, 2026 at 01:25:49PM +0200, J. Neuschäfer wrote:
> Applying both ``code`` and **bold** formatting doesn't have the intended
> outcome, instead Sphinx emits the backticks into the HTML.
> 
> Use only **bold** formatting to fix the HTML output.
> 
> Signed-off-by: J. Neuschäfer <j.neuschaefer@9elements.com>
> ---
> I'm fine with either solution, keeping the bold or code formatting, and I'll
> switch to the other if requested. They just don't mix well.

Bold is probably the least worst option here, as it helps legibility
of the doc more IMHO.

> ---
>  docs/devel/code-provenance.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> index 4e6a9afe0d672c544c069447a9978baa0b4a6212..65b8f232a08f6bc903c77fd0b1f7a5adad9fbe5d 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -99,13 +99,13 @@ Other commit tags
>  While the ``Signed-off-by`` tag is mandatory, there are a number of other tags
>  that are commonly used during QEMU development:
>  
> - * **``Reviewed-by``**: when a QEMU community member reviews a patch on the
> + * **Reviewed-by**: when a QEMU community member reviews a patch on the
>     mailing list, if they consider the patch acceptable, they should send an
>     email reply containing a ``Reviewed-by`` tag. Subsystem maintainers who
>     review a patch should add this even if they are also adding their
>     ``Signed-off-by`` to the same commit.
>  
> - * **``Acked-by``**: when a QEMU subsystem maintainer approves a patch that
> + * **Acked-by**: when a QEMU subsystem maintainer approves a patch that
>     touches their subsystem, but intends to allow a different maintainer to
>     queue it and send a pull request, they would send a mail containing a
>     ``Acked-by`` tag. Where a patch touches multiple subsystems, ``Acked-by``
> @@ -113,18 +113,18 @@ that are commonly used during QEMU development:
>     maintainer wants to indicate they have done a full review they should use
>     a ``Reviewed-by`` tag.
>  
> - * **``Tested-by``**: when a QEMU community member has functionally tested the
> + * **Tested-by**: when a QEMU community member has functionally tested the
>     behaviour of the patch in some manner, they should send an email reply
>     containing a ``Tested-by`` tag.
>  
> - * **``Reported-by``**: when a QEMU community member reports a problem via the
> + * **Reported-by**: when a QEMU community member reports a problem via the
>     mailing list, or some other informal channel that is not the issue tracker,
>     it is good practice to credit them by including a ``Reported-by`` tag on
>     any patch fixing the issue. When the problem is reported via the GitLab
>     issue tracker, however, it is sufficient to just include a link to the
>     issue.
>  
> - * **``Suggested-by``**: when a reviewer or other 3rd party makes non-trivial
> + * **Suggested-by**: when a reviewer or other 3rd party makes non-trivial
>     suggestions for how to change a patch, it is good practice to credit them
>     by including a ``Suggested-by`` tag.
>  
> 
> ---
> base-commit: 6d17fd91f6cf88df5cb2205e578640d72605cc43
> change-id: 20260520-prov-73c69e4e979c
> 
> Best regards,
> -- 
> J. Neuschäfer <j.neuschaefer@9elements.com>
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


