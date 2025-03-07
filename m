Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6E0C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 07:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqSbP-0004jJ-K4; Fri, 07 Mar 2025 02:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqSbN-0004j7-RF
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:58:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqSbL-00074i-U2
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741334313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Kzjc4JV5HmITje/DVLPkgAEWcFJCS55DVAwo+SM9Yo=;
 b=XCGCHsk+m94jFj0+dhLXsbIKdsoB5HrGTRN3R8lVbTACUkJCAxhGzclmgujrpbccRIRtA5
 X110f3Nl0YlTH6FHO0KJFylIdTV8CKXl4cJfCtWCRp35htVQoiQHXdl2vTwK6ttVCb2qGo
 HaA4U5cUMg0a6sFyrTU6CiuaX8/1SwU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-5dk0JhPNPu6TP0vXCAbNJw-1; Fri,
 07 Mar 2025 02:58:24 -0500
X-MC-Unique: 5dk0JhPNPu6TP0vXCAbNJw-1
X-Mimecast-MFC-AGG-ID: 5dk0JhPNPu6TP0vXCAbNJw_1741334303
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FEA51800361; Fri,  7 Mar 2025 07:58:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3245C1944F2E; Fri,  7 Mar 2025 07:58:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BA92521E66C2; Fri, 07 Mar 2025 08:58:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 16/57] docs/qapi-domain: add "Returns:" field lists
In-Reply-To: <20250305034610.960147-17-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:25 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-17-jsnow@redhat.com>
Date: Fri, 07 Mar 2025 08:58:19 +0100
Message-ID: <87tt85p90k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

> Add "Returns:" field list syntax to QAPI Commands.
>
> Like "Arguments:" and "Errors:", the type name isn't currently processed
> for cross-referencing, but this will be addressed in a forthcoming
> commit.
>
> This patch adds "errors" as a GroupedField, which means that multiple

"errors"?

> return values can be annotated - this is only done because Sphinx does
> not seemingly (Maybe I missed it?) support mandatory type arguments to
> Ungrouped fields. Because we want to cross-reference this type
> information later, we want to make the type argument mandatory. As a
> result, you can technically add multiple :return: fields, though I'm not
> aware of any circumstance in which you'd need or want
> to. Recommendation: "Don't do that, then."

scripts/qapi/parser.py rejects duplicate 'Returns:' tags.  So, to do the
thing you shouldn't do, you'd have to use the QAPI domain directly.
I doubt such shenanigans would survive review :)

> Since this field describes an action/event instead of describing a list
> of nouns (arguments, features, errors), I added both the imperative and
> indicative forms (:return: and :returns:) to allow doc writers to use
> whichever mood "feels right" in the source document. The rendered output
> will always use the "Returns:" label, however.
>
> I'm sure you'll let me know how you feel about that. O:-)

My personal taste is imperative mood, always.

Sadly, the QAPI schema language uses 'Returns:'.

The Sphinx Python Domain appears to use :return:.

I recommend to go for consistency with the Python Domain, and ditch
:returns:.

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapi_domain.py | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
> index d60cccb8e95..7531bdfbba7 100644
> --- a/docs/sphinx/qapi_domain.py
> +++ b/docs/sphinx/qapi_domain.py
> @@ -292,6 +292,13 @@ class QAPICommand(QAPIObject):
>                  names=("error", "errors"),
>                  has_arg=False,
>              ),
> +            # :returns TypeName: descr
> +            GroupedField(
> +                "returnvalue",
> +                label=_("Returns"),
> +                names=("return", "returns"),
> +                can_collapse=True,
> +            ),
>          ]
>      )


