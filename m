Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305F5C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 12:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugjWo-00064K-BK; Tue, 29 Jul 2025 08:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugjW9-0005fw-Hb
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 08:33:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugjW5-0002Zv-Tw
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 08:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753792387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5sdpfEg6OJqURgQSP3gjg12Tt+0VbTd/rZEp2KzJbTM=;
 b=Y3e0F6NLanT2vfzpnR0M7NsDLPT2ZFnCftzfYYLtRQyim6deVNQ03wwTG0Z7/VMdK/LBdZ
 f7VFdT5r1KvqMou6JqL9W9jeFVfPRlThqcd+2f3DBUkRgifFCLV9iO0dpK35cabuE2loUQ
 vKoIBoCIRuy45imtwhKgBOr8haAm2z0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-XL1PnVSkOsePrZN5P_z6yw-1; Tue,
 29 Jul 2025 08:33:02 -0400
X-MC-Unique: XL1PnVSkOsePrZN5P_z6yw-1
X-Mimecast-MFC-AGG-ID: XL1PnVSkOsePrZN5P_z6yw_1753792381
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 409241956095; Tue, 29 Jul 2025 12:33:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E498518001DD; Tue, 29 Jul 2025 12:33:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3D8AF21E6A27; Tue, 29 Jul 2025 14:32:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  jsnow@redhat.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH 2/2] MAINTAINERS: Cover docs/devel/qapi-domain.rst properly
In-Reply-To: <CAAjaMXYyJHaCwd_3Dxd=wDVj+kPcK-FJZQ=8e7RGD7m22NV7ig@mail.gmail.com>
 (Manos Pitsidianakis's message of "Tue, 29 Jul 2025 15:09:23 +0300")
References: <20250729091642.3513895-1-armbru@redhat.com>
 <20250729091642.3513895-3-armbru@redhat.com>
 <CAAjaMXYyJHaCwd_3Dxd=wDVj+kPcK-FJZQ=8e7RGD7m22NV7ig@mail.gmail.com>
Date: Tue, 29 Jul 2025 14:32:58 +0200
Message-ID: <87a54ndvnp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> On Tue, Jul 29, 2025 at 12:18=E2=80=AFPM Markus Armbruster <armbru@redhat=
.com> wrote:
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f1bd69c3db..9c22e921e8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4432,6 +4432,7 @@ F: docs/requirements.txt
>>  F: docs/sphinx/
>>  F: docs/_templates/
>>  F: docs/devel/docs.rst
>> +F: docs/devel/qapi-domain.rst
>
> Question: Does it matter if this is already covered by QAPI section
> which has: "F: docs/devel/qapi*"?

I'm adding it to the "Sphinx documentation configuration and build
machinery" section as well.

Before the patch:

    $ scripts/get_maintainer.pl -f docs/devel/qapi-domain.rst=20
    Markus Armbruster <armbru@redhat.com> (supporter:QAPI)
    Michael Roth <michael.roth@amd.com> (supporter:QAPI)
    qemu-devel@nongnu.org (open list:All patches CC here)

Afterwards:

    $ scripts/get_maintainer.pl -f docs/devel/qapi-domain.rst=20
--> John Snow <jsnow@redhat.com> (maintainer:Sphinx documentat...)
--> Peter Maydell <peter.maydell@linaro.org> (maintainer:Sphinx documentat.=
..)
    Markus Armbruster <armbru@redhat.com> (supporter:QAPI)
    Michael Roth <michael.roth@amd.com> (supporter:QAPI)
    qemu-devel@nongnu.org (open list:All patches CC here)

Good, because it's John's baby, and he's maintaining it.

> If not,
>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thank you!

[...]


