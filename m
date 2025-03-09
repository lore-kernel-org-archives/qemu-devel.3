Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2326C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 21:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trNxs-0003Oh-MQ; Sun, 09 Mar 2025 17:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trNxp-0003OC-W3
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 17:13:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trNxo-0005HS-9O
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 17:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741554815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5IYSFVXQSFrAcc6A6v21G4axArBXwxfFkyVgFsbEkpk=;
 b=D+pzw/XCUEyA5ehaQX7fKjrzhu2HK9m1Tn42kOPYtkINuvEAj2Q4pSyd7bAQNRcgq/BmZ0
 1g+iUFwNDUSf33Uxr9TLMD/LmI+ZaaSOHNOl/p0XsauE1X8qnOc+dayixdynM51CHYEN++
 DQgPaCIJ530NbDWVHiJWvsnxhrloFFM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-sotq_xJFPTuKadk7E_qGRg-1; Sun,
 09 Mar 2025 17:13:31 -0400
X-MC-Unique: sotq_xJFPTuKadk7E_qGRg-1
X-Mimecast-MFC-AGG-ID: sotq_xJFPTuKadk7E_qGRg_1741554810
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B5BC180049D; Sun,  9 Mar 2025 21:13:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C77D51800370; Sun,  9 Mar 2025 21:13:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4343F21E675F; Sun, 09 Mar 2025 22:13:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 61/62] docs: enable qapidoc transmogrifier for QEMU
 QMP Reference
In-Reply-To: <20250309083550.5155-62-jsnow@redhat.com> (John Snow's message of
 "Sun, 9 Mar 2025 04:35:48 -0400")
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-62-jsnow@redhat.com>
Date: Sun, 09 Mar 2025 22:13:27 +0100
Message-ID: <878qpdykjs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

> We are not enabling the transmogrifier for QSD or QGA yet because we
> don't (yet) have a way to create separate indices, and all of the
> definitions will bleed together, which isn't so nice.
>
> For now, QMP is better than nothing at all!
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/interop/qemu-qmp-ref.rst | 1 +
>  qapi/qapi-schema.json         | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/docs/interop/qemu-qmp-ref.rst b/docs/interop/qemu-qmp-ref.rst
> index f94614a0b2f..e95eeac45e2 100644
> --- a/docs/interop/qemu-qmp-ref.rst
> +++ b/docs/interop/qemu-qmp-ref.rst
> @@ -7,3 +7,4 @@ QEMU QMP Reference Manual
>     :depth: 3
>  
>  .. qapi-doc:: qapi/qapi-schema.json
> +   :transmogrify:
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 2877aff73d0..4475e81cc3e 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -5,6 +5,8 @@
>  #
>  # This document describes all commands currently supported by QMP.
>  #
> +# For locating a particular item, please see the `qapi-index`.
> +#

```qapi-index``` becomes a link in HTML.  The link takes me to an index
page.  Two observations:

* The index page appears not to be linked from the navigation thingie on
  the left.  Searching for "QAPI Index" there doesn't find it, either.

* The index is structured into sections titled Alternates, Commands |
  Enums, Events, Modules, Objects, A, ... Z.  As I scrolled down
  quickly, the transition from Objects to A confused me briefly: I
  didn't immediately understand that A, ... Z contains the union of
  everything above sorted into letter buckets.

>  # Most of the time their usage is exactly the same as in the user
>  # Monitor, this means that any other document which also describe
>  # commands (the manpage, QEMU's manual, etc) can and should be


