Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45520C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 20:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trNPa-0007HB-FO; Sun, 09 Mar 2025 16:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trNPY-0007Gt-WD
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 16:38:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trNPX-0003na-6W
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 16:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741552687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WwMSiWFFjYEN6smR/7EdmfzCMUMcIM7ih3FNl9P/2Y=;
 b=grCIjUh0aQXgDoifHhkaNVKghWgEBC0M6nXIgDORdDS1zZYcyX9GNyLzP+avAGUEcaKNRh
 OTlBv8j+GaRPHqtoYDuaR4o5wBjqDOYXoUQT1hKsuTxU/ba4euWlYMUqEGqwCen8j5+vPC
 Hs7DsG6JKVr49AMK2drfRNPFwPJfim0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-AIPz0F0zPwif_yg3h_L3Rg-1; Sun,
 09 Mar 2025 16:38:02 -0400
X-MC-Unique: AIPz0F0zPwif_yg3h_L3Rg-1
X-Mimecast-MFC-AGG-ID: AIPz0F0zPwif_yg3h_L3Rg_1741552681
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37C6E19560BC; Sun,  9 Mar 2025 20:38:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABBEF1800946; Sun,  9 Mar 2025 20:37:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 277DE21E675F; Sun, 09 Mar 2025 21:37:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 15/62] docs/qapi-domain: add "Arguments:" field lists
In-Reply-To: <20250309083550.5155-16-jsnow@redhat.com> (John Snow's message of
 "Sun, 9 Mar 2025 04:35:02 -0400")
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-16-jsnow@redhat.com>
Date: Sun, 09 Mar 2025 21:37:57 +0100
Message-ID: <87ikoi0wka.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

> This adds special rendering for Sphinx's typed field lists.
>
> This patch does not add any QAPI-aware markup, rendering, or
> cross-referencing for the type names, yet. That feature requires a
> subclass to TypedField which will happen in its own commit quite a bit
> later in this series; after all the basic fields and objects have been
> established first.
>
> The syntax for this field is:
>
> :arg type name: description
>    description cont'd
>
> You can omit the type or the description, but you cannot omit the name
> -- if you do so, it degenerates into a "normal field list" entry, and
> probably isn't what you want.

Suggest "You can omit the type or the description.  You should not omit
the name ..."

>
> Signed-off-by: John Snow <jsnow@redhat.com>


