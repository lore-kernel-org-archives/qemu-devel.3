Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5C9C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 07:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq5Z2-0000VE-6U; Thu, 06 Mar 2025 02:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq5Z0-0000Us-Ld
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:22:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq5Yx-0002Ih-Rp
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741245753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w0vGEmP863N+stWgeieFcuMw37q3NYabbrV1ImiwZig=;
 b=TjhXULN1t9WXcPtpRtNXF33ZgGPua3DkkZ5FHgRhGPgjDKBF1c/as5i8o35MzoXcIhZtMN
 gC7hKP7IUFTIH72Xsb36AmQ+6RuBAiawYZpoAMcmiRmrP7RaPa4fP5sAEObLLLxIDxvdFv
 ub01kCQ1SVOlrMeSHP0jEedY6IBY2FU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-BxaZeKn-PACIQyBN1KbfDw-1; Thu,
 06 Mar 2025 02:22:28 -0500
X-MC-Unique: BxaZeKn-PACIQyBN1KbfDw-1
X-Mimecast-MFC-AGG-ID: BxaZeKn-PACIQyBN1KbfDw_1741245747
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64B501800260; Thu,  6 Mar 2025 07:22:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 184571956095; Thu,  6 Mar 2025 07:22:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9FAA121E675F; Thu, 06 Mar 2025 08:22:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Michael Roth
 <michael.roth@amd.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Harmonie Snow
 <harmonie@gmail.com>
Subject: Re: [PATCH 21/57] docs/qapi-domain: add :deprecated: directive option
In-Reply-To: <CAFn=p-avGWfsjmPFR4DBGD5RrO67Vrh8rzPB1cEOQ7hvpgvBmQ@mail.gmail.com>
 (John Snow's message of "Wed, 5 Mar 2025 10:34:12 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-22-jsnow@redhat.com>
 <87v7snon6o.fsf@pond.sub.org>
 <CAFn=p-avGWfsjmPFR4DBGD5RrO67Vrh8rzPB1cEOQ7hvpgvBmQ@mail.gmail.com>
Date: Thu, 06 Mar 2025 08:22:24 +0100
Message-ID: <87frjqfwsv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

> On Wed, Mar 5, 2025, 4:13=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

[...]

>> pylint warns:
>>
>>     docs/sphinx/qapi_domain.py:279:4: W0237: Parameter 'contentnode' has
>> been renamed to 'content_node' in overriding 'QAPIObject.transform_conte=
nt'
>> method (arguments-renamed)
>>
>> For what it's worth, @content_node is easier on on my eyes than
>> @contentnode.
>>
>
> Almost certifiably a Sphinx version difference that I simply won't be able
> to accommodate. It comes back clean against 8.x, and does not impact the
> runtime functionality at all.

If that's the case, don't worry about it.

[...]


