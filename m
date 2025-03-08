Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488E4C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 06:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqo9C-0007cN-4y; Sat, 08 Mar 2025 01:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqo92-0007Z1-WD
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 01:58:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqo91-0004M3-Ft
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 01:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741417125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CBBWpDZBpJt4GnJGzgIbHETib6unOf8AbHn16EGHn1I=;
 b=gncShi9dg5oVVOlZRBNwQS2cHlQ8L8HigKMfvSTp4MDrS57z/mYoP57YUvh9UW8zNTywdv
 Y7RbnaIf9RL8KBLMA+JLm/jviOrohtm1FrjOLJd7IUpkViPB7HcgxqxAGFeotUOgrNvgWA
 WWkJhOewK3Fpsw/KlAAKw0IzmDxx4oQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-S3aVdHyQMdub6zQks6OfeQ-1; Sat,
 08 Mar 2025 01:58:37 -0500
X-MC-Unique: S3aVdHyQMdub6zQks6OfeQ-1
X-Mimecast-MFC-AGG-ID: S3aVdHyQMdub6zQks6OfeQ_1741417116
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D8541956083; Sat,  8 Mar 2025 06:58:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFA441955DCE; Sat,  8 Mar 2025 06:58:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C20221E675F; Sat, 08 Mar 2025 07:58:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 18/57] docs/qapi-domain: add qapi:alternate directive
In-Reply-To: <CAFn=p-Y1YkZaG1=E_QGT93EMpiqjkXbq1_jV3GL9ONLt6J05Sg@mail.gmail.com>
 (John Snow's message of "Fri, 7 Mar 2025 18:02:57 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-19-jsnow@redhat.com>
 <87a59xnny6.fsf@pond.sub.org>
 <CAFn=p-Y1YkZaG1=E_QGT93EMpiqjkXbq1_jV3GL9ONLt6J05Sg@mail.gmail.com>
Date: Sat, 08 Mar 2025 07:58:33 +0100
Message-ID: <87y0xgc8km.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

> On Fri, Mar 7, 2025 at 5:18=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Add the .. qapi:alternate:: directive, object, and qapi:alt:`name`
>> > cross-reference role.
>> >
>> > Add the "Choices:" field list for describing alternate choices. Like
>> > other field lists that reference QAPI types, a forthcoming commit will
>> > add cross-referencing support to this field.
>>
>> Nothing wrong with the term "choices" per se, but
>> docs/devel/qapi-code-gen.rst and the Python code call these things
>> "alternatives".  I'd prefer consistency.  Could be done as a follow-up
>> if that's more convenient for you.
>>
>
> Done. (Wish you'd said so sooner, though.)

Fair!

[...]


