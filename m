Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0151C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 21:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk8DO-0007bc-JX; Thu, 07 Aug 2025 17:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uk8DK-0007Xd-Df
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 17:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uk8DI-0005Gi-FC
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 17:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754602310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JqZ1WJSpkptdpqldQTyNXLMfXBWLe+yiMA3um8GvK1A=;
 b=eqi+eFMEuxqyaQgkyoon02+sFGRdnRidRAL9KTYOYozI7ieM4ESECvtmqMgq6WY6EC6dsA
 vFjq29Zng7o6CoMNd8cVE1pW8PxiWhoQEiidVpqOko2Wa2tLlJuRrl4d9D5LRLs2zYUiqw
 ldAoxZh8n8gaQ6iCJEzjPRDdhGWVg1I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-qUFwybaiMjyJl2o9303sog-1; Thu, 07 Aug 2025 17:31:49 -0400
X-MC-Unique: qUFwybaiMjyJl2o9303sog-1
X-Mimecast-MFC-AGG-ID: qUFwybaiMjyJl2o9303sog_1754602307
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-31f030b1cb9so2589468a91.2
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 14:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754602307; x=1755207107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JqZ1WJSpkptdpqldQTyNXLMfXBWLe+yiMA3um8GvK1A=;
 b=KxcynPV/QIHclOBLPriAHXEw11TnI/sygnwD6KsLy+/svfYRNdyZ4d1oUnNcPMbZ1T
 nTjro0wavytKQ30+iVjv1/t13TNYLtysBIKjJGQQS9Kaw9Xp8z+YpUO7wOpk4zZ73eJk
 cCWm5EkWdlpJP2UMyNFyUvRq5BiBvAMP5W2jcEVFbAbqcCoBwVoOAgVAdXa7rFrZE9Ro
 4oKPs86zB/Oke32Cw4LqAlcyB/9RGHuk3QRMB60GyD0U32ueKV3Sr8ZbTt+2rZhZUvRG
 KYVIBxrDFyXGgZGRZ2edpc1WSphNZkX2KBolg18v7aBbVdQqIsECvcPnb4a9e8mwz3dn
 Mwjg==
X-Gm-Message-State: AOJu0YxYFJw00g4+Gmb4YGR2zYOSUD4n/SzoFdcTpJH0s991BCqlVCw9
 pcr4lw/GzGxIerIhVQ63oG5cEbcC2/6goQ60CTEJbH4reMHX7nl28vHw+74nfBcnPHSa5Uc7R1f
 E+f1+1sHrVfcJDpRf/LxGk4eO1VejAPRIqsz4JGrOx+nb9xcy0sVOFSfA1xn8Aj67OK3JwzLtZB
 7b1xaLe9wE6TMQ046ODGmrhhCBPv3Syj0=
X-Gm-Gg: ASbGncuVS8OkoHPFeoV3B9g5fruEsHD3bfUMNcou1st+Ouz+lb5Xvx/hgBY0RDv9V7x
 51UYmOQ/s6e3vWVRvY9tVQ54ZgEk/JVMMAFuyHFQ4lgqwS2hfuAv/8glEgZJ8FoZzZi1ewWqUo/
 7j+whpa9ilpSjpvj0e6eQM4yRUDaSRi5UZ8YloKlzG29/rHek1s0kj
X-Received: by 2002:a17:902:cec8:b0:242:9bbc:6018 with SMTP id
 d9443c01a7336-242c2277f70mr6889995ad.56.1754602307139; 
 Thu, 07 Aug 2025 14:31:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsZiNLnT2hqVWZ67rawXnm8lOYdMDnh+FyseOTetr3fcE3ncUHWJbxuZ3Pq273wkB94D2kB0M+tjfJUG7H6Ag=
X-Received: by 2002:a17:902:cec8:b0:242:9bbc:6018 with SMTP id
 d9443c01a7336-242c2277f70mr6889795ad.56.1754602306765; Thu, 07 Aug 2025
 14:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250731054044.4011789-1-armbru@redhat.com>
 <20250731054044.4011789-4-armbru@redhat.com>
In-Reply-To: <20250731054044.4011789-4-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 7 Aug 2025 17:31:34 -0400
X-Gm-Features: Ac12FXx73uF4OiCGqKNtEzMqZ5vU5UqAhEC3_SUVHvS6HCQFGlG2CJv6FwPnoRM
Message-ID: <CAFn=p-bYKEjGX-DYPNbxFn=52-dJH29-SwmPvWYZ7tgo9ZBS+w@mail.gmail.com>
Subject: Re: [PATCH 3/3] docs/devel/qapi-code-gen: Update cross-reference
 syntax
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, peter.maydell@linaro.org, 
 eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jul 31, 2025 at 1:40=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> The new QAPI code generator creates a cross-reference target for each
> definition documentation.  Enabled for the QEMU QMP Reference manual
> in commit a377f39f38f, and for the QEMU Storage Daemon QMP Reference
> Manual and the QEMU Guest Agent Protocol Reference in commit
> a6af5443440.  We've put these targets to use since, but neglected to
> update doc comment markup documentation.  Do that now.
>
> Co-developed-by: John Snow <jsnow@redhat.com>

No need for this in my opinion, the SOB suffices to say the same thing
in my book. I don't insist you remove it, just seems ... oddly
pretentious to say I "co-developed" a single paragraph of text ;)

> Signed-off-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  docs/devel/qapi-code-gen.rst | 11 ++++++++---
>  docs/devel/qapi-domain.rst   |  1 +
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index 2cd51729c3..d97602f464 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -943,9 +943,14 @@ The usual ****strong****, *\*emphasized\** and ````l=
iteral```` markup
>  should be used.  If you need a single literal ``*``, you will need to
>  backslash-escape it.
>
> -Use ``@foo`` to reference a name in the schema.  This is an rST
> -extension.  It is rendered the same way as ````foo````, but carries
> -additional meaning.
> +Use ```foo``` to reference a definition in the schema.  This generates
> +a link to the definition.  In the event that such a cross-reference is
> +ambiguous, you can use `QAPI cross-reference roles
> +<QAPI-domain-cross-references>` to disambiguate.
> +
> +Use @foo to reference a member description within the current
> +definition.  This is an rST extension.  It is currently rendered the
> +same way as ````foo````, but carries additional meaning.
>
>  Example::
>
> diff --git a/docs/devel/qapi-domain.rst b/docs/devel/qapi-domain.rst
> index fe540d1e40..1924f12d42 100644
> --- a/docs/devel/qapi-domain.rst
> +++ b/docs/devel/qapi-domain.rst
> @@ -375,6 +375,7 @@ Will allow you to add arbitrary field lists in QAPI d=
irectives::
>
>        :see also: Lorem ipsum, dolor sit amet ...
>
> +.. _QAPI-domain-cross-references:
>
>  Cross-references
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --
> 2.49.0
>


