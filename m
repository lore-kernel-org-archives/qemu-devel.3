Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B335AC28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 20:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trNXy-0002r9-Rn; Sun, 09 Mar 2025 16:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trNXw-0002qs-St
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 16:46:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trNXv-0005zh-FL
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 16:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741553209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PdJ9dgvdGOLl9PjvOFNIU2esakPZJ3GyE2FGoe0gjEA=;
 b=OxGS3q6IDZESM6EqfJbjqcs4RkfcVQ7uytVpVo6l8ztdzQryZr6214oG3d/pEqmeAPVMzX
 RfKFvZj1LVtVLMrKD0ZOH7zdNQ7og6Kc/TdNxDtTRMEEj5k2GqbKkDCsLWx86gPwzsSE9v
 SP5zvw9GYWHYO81psCXQ15wjR4r28gs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-KbbPM6s6NX-ofvgw8NjdBw-1; Sun,
 09 Mar 2025 16:46:46 -0400
X-MC-Unique: KbbPM6s6NX-ofvgw8NjdBw-1
X-Mimecast-MFC-AGG-ID: KbbPM6s6NX-ofvgw8NjdBw_1741553205
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9A7D1956087; Sun,  9 Mar 2025 20:46:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E1391800370; Sun,  9 Mar 2025 20:46:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1514B21E675F; Sun, 09 Mar 2025 21:46:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 18/62] docs/qapi-domain: add "Return:" field lists
In-Reply-To: <20250309083550.5155-19-jsnow@redhat.com> (John Snow's message of
 "Sun, 9 Mar 2025 04:35:05 -0400")
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-19-jsnow@redhat.com>
Date: Sun, 09 Mar 2025 21:46:42 +0100
Message-ID: <8734fm0w5p.fsf@pond.sub.org>
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

> Add "Return:" field list syntax to QAPI Commands.
>
> Like "Arguments:" and "Errors:", the type name isn't currently processed
> for cross-referencing, but this will be addressed in a forthcoming
> commit.
>
> This patch adds "Return" as a GroupedField, which means that multiple
> return values can be annotated - this is only done because Sphinx does
> not seemingly (Maybe I missed it?) support mandatory type arguments to
> Ungrouped fields. Because we want to cross-reference this type
> information later, we want to make the type argument mandatory. As a
> result, you can technically add multiple :return: fields, though I'm not
> aware of any circumstance in which you'd need or want
> to. Recommendation: "Don't do that, then."
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Mention the new syntax :return like PATCH 15 does for :arg?

> ---
>  docs/sphinx/qapi_domain.py | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
> index d018fcd4f7c..8a364ff75ea 100644
> --- a/docs/sphinx/qapi_domain.py
> +++ b/docs/sphinx/qapi_domain.py
> @@ -296,6 +296,13 @@ class QAPICommand(QAPIObject):
>                  names=("error", "errors"),
>                  has_arg=False,
>              ),
> +            # :returns TypeName: descr

:return I believe.

> +            GroupedField(
> +                "returnvalue",
> +                label=_("Return"),
> +                names=("return",),
> +                can_collapse=True,
> +            ),
>          ]
>      )


