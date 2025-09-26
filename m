Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C22CAC5BC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 11:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v26oz-0006Yv-HL; Fri, 26 Sep 2025 07:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v26ox-0006YJ-1S
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 07:41:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v26ok-0007xy-Og
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 07:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758886844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V1SBsEqZYJFBI6Zs78jlBTVZgteGr5Co7Y+zHzXnHWY=;
 b=N9xByEWjNty5fCxmbTR5JRYLc+Y7fM+NJvnxqbn4uUZe0enxA9SQoezXFBdo6EO2O4tHFj
 YXfawy+0GbuBPt9WHnV6zyuHjWbnFHGYZP44z6+WvTE3jpLN9+PoHT67GzvGUXZsxsMBOj
 EKVHWfxR6huJS/5Hb66eFFqErSVQ2+U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-MtFlNt-HMFOj5c3K9MWjLQ-1; Fri,
 26 Sep 2025 07:40:41 -0400
X-MC-Unique: MtFlNt-HMFOj5c3K9MWjLQ-1
X-Mimecast-MFC-AGG-ID: MtFlNt-HMFOj5c3K9MWjLQ_1758886840
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73D2F1956089; Fri, 26 Sep 2025 11:40:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D55991956095; Fri, 26 Sep 2025 11:40:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 29D9421E6A27; Fri, 26 Sep 2025 13:40:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: imammedo@redhat.com,  philmd@linaro.org,  berrange@redhat.com,
 jdenemar@redhat.com,  armbru@redhat.com,  pbonzini@redhat.com,
 richard.henderson@linaro.org,  eduardo@habkost.net,  mst@redhat.com,
 marcel.apfelbaum@gmail.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/2] docs/about/deprecated.rst: document new
 restrictions for isapc CPU models
In-Reply-To: <20250925160453.2025885-3-mark.caveayland@nutanix.com> (Mark
 Cave-Ayland's message of "Thu, 25 Sep 2025 17:03:20 +0100")
References: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
 <20250925160453.2025885-3-mark.caveayland@nutanix.com>
Date: Fri, 26 Sep 2025 13:40:37 +0200
Message-ID: <87seg9o30q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:

> Add a new paragraph in the "Backwards compatibility" section documenting that
> the isapc machine is now restricted to 32-bit x86 CPUs, and -cpu host and
> -cpu max are no longer supported.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  docs/about/deprecated.rst | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index aa300bbd50..4c7000650d 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -514,6 +514,19 @@ available firmwares that are using the current (wrong) name.  The
>  property is kept as is in 9.1, together with "riscv,delegation", to
>  give more time for firmware developers to change their code.
>  
> +x86 "isapc" board restricted to 32-bit x86 CPUs (since 10.2)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The "isapc" board represents a historical x86 ISA PC and is intended for
> +older 32-bit x86 CPU models, defaulting to a 486 CPU model.  Previously it
> +was possible (but non-sensical) to specify a more modern x86 CPU, including
> +``-cpu host`` or ``-cpu max`` even if the features were incompatible with many
> +of the intended guest OSs.
> +
> +Now the "isapc" board contains an explicit list of supported 32-bit x86 CPU
> +models. If the user requests an unsupported CPU model then an error message is
> +returned indicating the available CPU models.
> +
>  Migration
>  ---------

I couldn't see how this corresponds to PATCH 1 until I realized it
documents recent commit e1e2909f8e7 modified by PATCH 1.

A hint in the commit message could've saved me a few minutes :)

Reviewed-by: Markus Armbruster <armbru@redhat.com>


