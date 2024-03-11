Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060C3C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 07:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjZjm-0007t0-S5; Mon, 11 Mar 2024 03:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rjZjX-0007s1-HR
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 03:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rjZjV-0006cM-RV
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 03:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710140759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7IA2bnntCqzgsW4BCsJ9TcXjp/1HBaRmv15AQl7n9Mk=;
 b=JIXa2ODsYdPRIVAarokxjWd2L6B4Mss/6laNR+K1iJBNCelp/WllooAo7BePudVTOkvw2F
 jH/1DywN4yC3aYzyF9OwVYkURkwAoEP/Doe4WR9fuoxPKdFfEMgc3W6RGqKjuQ1gu/kB2e
 9s6PFXMwNugnej3p8kWFKprYiQWi+ew=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-EdbZ1sboODOntp5DMye6aA-1; Mon,
 11 Mar 2024 03:05:55 -0400
X-MC-Unique: EdbZ1sboODOntp5DMye6aA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C847D1C0170E;
 Mon, 11 Mar 2024 07:05:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8587C8177;
 Mon, 11 Mar 2024 07:05:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 05FB721E6A24; Mon, 11 Mar 2024 08:05:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  John Snow <jsnow@redhat.com>,  Thomas Huth
 <thuth@redhat.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/ide/ahci: Rename ahci_internal.h to ahci-internal.h
In-Reply-To: <a1a9cdfd-8c54-dc8c-6512-9c59b63cdcdf@eik.bme.hu> (BALATON
 Zoltan's message of "Sun, 10 Mar 2024 15:27:23 +0100 (CET)")
References: <20240227131310.C24EB4E6005@zero.eik.bme.hu>
 <00a87926-49bf-4945-94fd-99f5c3a73bb0@linaro.org>
 <a1a9cdfd-8c54-dc8c-6512-9c59b63cdcdf@eik.bme.hu>
Date: Mon, 11 Mar 2024 08:05:51 +0100
Message-ID: <87zfv5uu28.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Tue, 27 Feb 2024, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 27/2/24 14:13, BALATON Zoltan wrote:
>>> Other headers now use dash instead of underscore. Rename
>>> ahci_internal.h accordingly for consistency.
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   hw/ide/{ahci_internal.h =3D> ahci-internal.h} | 0
>>>   hw/ide/ahci.c                               | 2 +-
>>>   hw/ide/ich.c                                | 2 +-
>>>   3 files changed, 2 insertions(+), 2 deletions(-)
>>>   rename hw/ide/{ahci_internal.h =3D> ahci-internal.h} (100%)
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Was this also queued somewhere? I haven't seen it merged neither with the=
 trivial nor the misc-hw pull requests.

I figure John (our IDE odd fixer) wouldn't mind this going via
qemu-trivial.  Cc'ed!


