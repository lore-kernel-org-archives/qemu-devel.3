Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94166C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 06:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqo0a-0001l4-1Q; Sat, 08 Mar 2025 01:50:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqo0V-0001kJ-7Y
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 01:50:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqo0T-00028F-Qd
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 01:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741416595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDkjc68dCUjbWlcKeSQlZnYoteC4U2qbbu7XxtoHTCA=;
 b=Q15szLQE3JbOZqAoPSdUlw2a2zAwXko9I1M7H5RBX087AeziymGPaxgaAeLuokimgfxVzA
 xBpUXkjrXGqqbPpZb7DyGXVPPsYhHZtXerpaikUKUoDl8a5e5WcBHolVHp/X9rZE/m69jz
 Nb6C/xlAa4CPUt8FgZ0dfCJJrWhhrzo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-w5-w6O9nOqOk6JQT4q4Y6A-1; Sat,
 08 Mar 2025 01:49:50 -0500
X-MC-Unique: w5-w6O9nOqOk6JQT4q4Y6A-1
X-Mimecast-MFC-AGG-ID: w5-w6O9nOqOk6JQT4q4Y6A_1741416589
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECB6918004A9; Sat,  8 Mar 2025 06:49:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD23C1956095; Sat,  8 Mar 2025 06:49:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 23E4121E675F; Sat, 08 Mar 2025 07:49:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 15/57] docs/qapi-domain: add "Errors:" field lists
In-Reply-To: <CAFn=p-b-R9AORQ2OWj5-MTEzC2m5iyQoWYisJ_Tp1Xk4DZcMjw@mail.gmail.com>
 (John Snow's message of "Fri, 7 Mar 2025 17:50:57 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-16-jsnow@redhat.com>
 <871pv9qo0u.fsf@pond.sub.org>
 <CAFn=p-b-R9AORQ2OWj5-MTEzC2m5iyQoWYisJ_Tp1Xk4DZcMjw@mail.gmail.com>
Date: Sat, 08 Mar 2025 07:49:45 +0100
Message-ID: <87bjucdnjq.fsf@pond.sub.org>
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

> On Fri, Mar 7, 2025 at 2:48=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > ``:error: descr`` can now be used to document error conditions. The
>> > format of the description is not defined here; so the ability to name
>> > specific types is left to the document writer.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> By convention, the description is a bullet list, but we don't enforce
>> that in software.  Observation, not a suggestion to start enforcing it
>> now.
>>
>
> Right. This commit message is accurate, though: this field list type will
> accept any old thing. I have an idea to fix this to make the aesthetics
> better (fixes the misalignment) and to enforce the bulleted list in one
> shot. Not for this series, sorry. Please accept a raincheck.

You're quite right to resist mission creep.

The commit message could mention the convention, say "The format of the
description is not defined here (we make it a bulleted list, but that's
just convention); ..."  Up to you.


