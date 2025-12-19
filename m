Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAE1D74960
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 07:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWVAR-0000Oa-85; Fri, 19 Dec 2025 02:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWVAD-0000Nr-5Q
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 02:44:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWVA8-00051W-UC
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 02:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766130263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0FC5KR3VqnCwZpWLWjhIE3yKxwEzM3sGMOhtI0Ufefk=;
 b=R3coURTklIxyCKoahPJiZ9n5oBwGII8FRbRvpPFmeSRhfutSxql1z05T4ZZwAMbeB3fm2V
 YsTh+G997TKkPYxE5hEAHHGixoFzOhObkKHe7nTQxOWor6dLGTR5GidG10ULeyskvjJCE2
 Zab6yePPaq70UiQhjFqDpAaaeNbdFqA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-3xiqMGr4Oa6AznHuASJh8w-1; Fri,
 19 Dec 2025 02:44:20 -0500
X-MC-Unique: 3xiqMGr4Oa6AznHuASJh8w-1
X-Mimecast-MFC-AGG-ID: 3xiqMGr4Oa6AznHuASJh8w_1766130259
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D4481956050; Fri, 19 Dec 2025 07:44:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5D451800576; Fri, 19 Dec 2025 07:44:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 712EE21E6A27; Fri, 19 Dec 2025 08:44:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Weil <stefan.weil@weilnetz.de>
Cc: qemu-devel@nongnu.org
Subject: Re: Report on MAINTAINERS coverage
In-Reply-To: <97a6f77e-7a86-4bbc-a20a-b1e1c7bdb537@weilnetz.de> (Stefan Weil
 via's message of "Thu, 18 Dec 2025 16:57:13 +0100")
References: <87h5toc61n.fsf@pond.sub.org>
 <97a6f77e-7a86-4bbc-a20a-b1e1c7bdb537@weilnetz.de>
Date: Fri, 19 Dec 2025 08:44:16 +0100
Message-ID: <87v7i27w6n.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Stefan Weil via <qemu-devel@nongnu.org> writes:

> Am 18.12.25 um 13:45 schrieb Markus Armbruster:
>> Back in 2014 (time flies), I posted
>>=20
>>      Subject: MAINTAINERS leaves too many files uncovered
>>      Message-ID: <87mw8rumhb.fsf@blackfin.pond.sub.org>
>>      https://lore.kernel.org/qemu-devel/87mw8rumhb.fsf@blackfin.pond.sub=
.org/
>>=20
>> I updated my findings in 2015, 2016 (at commit e00da552a0d), 2018 (at
>> v3.1.0-rc2), and 2023 (at commit 36e9aab3c56, close to v8.2.0).  This is
>> another update, at v10.2.0-rc4.
>
>
> These two files were contributed by me and most of my initial code is=20
> still unmodified, so I could be added as their maintainer:
>
> hw/nvram/eeprom93xx.c
> include/hw/nvram/eeprom93xx.h

Thanks!

> I had two contributions to the eeprom93xx.c (one made by Thiemo in my=20
> name). Other authors had also two or more contributions:
>
>        2 Author: Alex Williamson <alex@shazbot.org>
>        2 Author: Anthony Liguori <anthony@codemonkey.ws>
>        2 Author: Aurelien Jarno <aurelien@aurel32.net>
>        2 Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>        3 Author: Blue Swirl <blauwirbel@gmail.com>
>        3 Author: Juan Quintela <quintela@trasno.org>
>        3 Author: Paolo Bonzini <pbonzini@redhat.com>
>        5 Author: Markus Armbruster <armbru@redhat.com>
>
> I am not sure about the desired order in MAINTAINERS. Therefore I don't=20
> intend to send a patch but would be happy if someone else updates this fi=
le.

I can take care of it.

MAINTAINERS has the nvram device models either under a machine,
supposedly the one machine that uses it (e.g. ds1225y.c is under
"Jazz"), or in section of its own ("CHRP NVRAM" and "Firmware
configuration (fw_cfg)").

As far as I can tell at a glance, eeprom93xx is used by the eepro100
NICs (i82500, i82551, ...), the tulip NIC, and dc390 SCSI HBA.  These
are all PCI devices available with -device, so not tied to any
particular machine type.  I guess a section of its own makes sense.  Do
you agree?

If yes, the section goes under the Devices heading.  Section order
appears to be unsystematic.  Next to "CHRP NVRAM"?

> For the other files which are von covered by MAINTAINERS, the copyright=20
> notice might help to find possible maintainers:
>
> grep --no-filename -r -o "Copyright.*" $(cat FILELIST)|sort -i|uniq -ci

Yes, but I don't have the time to tackle the long tail myself.


