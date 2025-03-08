Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B9BC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 09:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqqNJ-00079o-He; Sat, 08 Mar 2025 04:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqqNH-00077D-KD
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 04:21:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqqNG-0005JI-Ao
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 04:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741425697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0YRLgS4GnqclI93WGRKInrC2bBSy+VQSEzmw3yxDfc=;
 b=gs74+oL5eTk1IqWm+g+rkSgqkH0rtGGfGMygvHtMCzMQv5gZ8WOXyF2OQ+n/pQURaBmFfm
 kMLTvcSnGixvOvfvtMA+JPP1VTB6KwBbgt77y2GpQhUEHhuVtHcebUQQ8Ld758h2remelO
 RPQWqiImc/79Oz1MpeWHqpiX0j+KX6Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-et8r_UT_OX6GdohVYizwJA-1; Sat,
 08 Mar 2025 04:21:33 -0500
X-MC-Unique: et8r_UT_OX6GdohVYizwJA-1
X-Mimecast-MFC-AGG-ID: et8r_UT_OX6GdohVYizwJA_1741425692
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34B9619560B3; Sat,  8 Mar 2025 09:21:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2AE71801748; Sat,  8 Mar 2025 09:21:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F80D21E66C1; Sat, 08 Mar 2025 10:21:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 56/57] docs/qapidoc: add intermediate output debugger
In-Reply-To: <CAFn=p-Z6a3Qq4-uHu1QUwdTrnxRuwKXo9iXwO8PV=hZm-ueTtA@mail.gmail.com>
 (John Snow's message of "Sat, 8 Mar 2025 03:13:34 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-57-jsnow@redhat.com>
 <87o6ydhvet.fsf@pond.sub.org>
 <CAFn=p-Z6a3Qq4-uHu1QUwdTrnxRuwKXo9iXwO8PV=hZm-ueTtA@mail.gmail.com>
Date: Sat, 08 Mar 2025 10:21:27 +0100
Message-ID: <87ecz7ane0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

> On Fri, Mar 7, 2025 at 7:34=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Add debugging output for the qapidoc transmogrifier - setting DEBUG=3D1
>> > will produce .ir files (one for each qapidoc directive) that write the
>> > generated rst file to disk to allow for easy debugging and verification
>> > of the generated document.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> I understand we generally need to examine these .ir files only when
>> things go wrong, or maybe to help understanding the transmogrifier.  I
>> guess few people will care, and only rarely.  But when we care, we
>> likely care a *lot*.  Sure we want to dig the information on how to get
>> .ir files out of a commit message then?
>>
>
> Intend to advertise it in the transmogrifier doc and/or extend the
> doc-writing section of the qapi code gen doc.

Okay!


