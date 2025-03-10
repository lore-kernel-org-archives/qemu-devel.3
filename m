Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D67C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 09:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trZk2-0002sZ-W9; Mon, 10 Mar 2025 05:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trZjN-0002G5-Jd
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:47:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trZjH-0002Kt-3o
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741600040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vwid8cmJwzJPJMHnx0+S9nLlm+3HLEBBM0G8MMculGg=;
 b=dybe8Ixuv/UtKtu4JjVpB0RfYVJll6RD3MNx4OyefCtBbYUFaSUEGZut07qL3fyYH6+fGX
 v4gbJntejEcSzwHon4F6VctW+Ih2oqKxiOSh6ne615HxZSKPHFmK2qZElQfbi+lmMRYUR2
 BfuD2QWCkPhdV09EiZ6KJFznbTTQgQM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-MxOP1P-xP7WfZ-MCgby84w-1; Mon,
 10 Mar 2025 05:47:16 -0400
X-MC-Unique: MxOP1P-xP7WfZ-MCgby84w-1
X-Mimecast-MFC-AGG-ID: MxOP1P-xP7WfZ-MCgby84w_1741600035
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EF8919560BC; Mon, 10 Mar 2025 09:47:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB9133000197; Mon, 10 Mar 2025 09:47:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8C6CA21E66C4; Mon, 10 Mar 2025 10:47:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell
 <peter.maydell@linaro.org>,  Harmonie Snow <harmonie@gmail.com>
Subject: Re: [PATCH v2 28/62] docs/qapi-domain: add CSS styling
In-Reply-To: <20250309083550.5155-29-jsnow@redhat.com> (John Snow's message of
 "Sun, 9 Mar 2025 04:35:15 -0400")
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-29-jsnow@redhat.com>
Date: Mon, 10 Mar 2025 10:47:11 +0100
Message-ID: <871pv5gqu8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

> Improve the general look and feel of generated QAPI docs.
>
> Attempt to limit line lengths to offer a more comfortable measure on
> maximized windows, and improve some margin and spacing for field lists.
>
> Signed-off-by: Harmonie Snow <harmonie@gmail.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx-static/theme_overrides.css | 56 +++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
> index 3fd326613d9..92f395054a8 100644
> --- a/docs/sphinx-static/theme_overrides.css
> +++ b/docs/sphinx-static/theme_overrides.css
> @@ -18,8 +18,8 @@ h1, h2, .rst-content .toctree-wrapper p.caption, h3, h4, h5, h6, legend {
>  
>  .rst-content dl:not(.docutils) dt {
>      border-top: none;
> -    border-left: solid 3px #ccc;
> -    background-color: #f0f0f0;
> +    border-left: solid 5px #bcc6d2;
> +    background-color: #eaedf1;
>      color: black;
>  }
>  
> @@ -211,6 +211,18 @@ div[class^="highlight"] pre {
>  
>  /* QAPI domain theming */
>  
> +/* most content in a qapi object definition should not eclipse about

QAPI unless there's a reason for lower case.

> +   80ch, but nested field lists are explicitly exempt due to their
> +   two-column nature */
> +.qapi dd *:not(dl) {
> +    max-width: 80ch;
> +}
> +
> +/* but the content column itself should still be less than ~80ch. */
> +.qapi .field-list dd {
> +    max-width: 80ch;
> +}
> +
>  .qapi-infopips {
>      margin-bottom: 1em;
>  }

[...]


