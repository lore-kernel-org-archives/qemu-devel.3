Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE7FC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVZX-00063F-Ix; Mon, 26 Feb 2024 02:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reVZV-00062k-Ox
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:38:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reVZI-0004cy-6Q
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708933109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OLyXHS4Efyt43mufq7hZ9gpqvE9WunWgeMIKSh3dkoQ=;
 b=daXKS0crc+amLUrfzPBOs74LAtxAp3RWXMr+aUQQ529U+4/ZpEDz5DaxczfBvNCZKnOeLD
 86VfHi0dS/LrG6tka/jQD3+jJmvFwm0nCiyxTB5t8iLSd0A0ItU2cgrOgblyIirEDNS0Mt
 iDW7rZrTlaMpONaj3N9VAtYUPCxcXEQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-IRvA5Z_JO-epr1K5m5r2dg-1; Mon,
 26 Feb 2024 02:38:25 -0500
X-MC-Unique: IRvA5Z_JO-epr1K5m5r2dg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BA213812000;
 Mon, 26 Feb 2024 07:38:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 05752400D295;
 Mon, 26 Feb 2024 07:38:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 069C721E6767; Mon, 26 Feb 2024 08:38:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Artyom Tarasenko <atar4qemu@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH] hw/rtc/sun4v-rtc: Relicense to GPLv2-or-later
In-Reply-To: <20240223161300.938542-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 23 Feb 2024 16:13:00 +0000")
References: <20240223161300.938542-1-peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 08:38:23 +0100
Message-ID: <87le77llow.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The sun4v RTC device model added under commit a0e893039cf2ce0 in 2016
> was unfortunately added with a license of GPL-v3-or-later, which is
> not compatible with other QEMU code which has a GPL-v2-only license.
>
> Relicense the code in the .c and the .h file to GPL-v2-or-later,
> to make it compatible with the rest of QEMU.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Before we can commit this to either head-of-git or any stable branch,
> we need a Signed-off-by: from everybody who's touched this file (or,
> for corporate contributions, from somebody from the relevant company
> who can confirm that the company is OK with the licensing, which is
> RedHat and Linaro in this case).
>
> The full list of people who've made changes to the file is:
>  Artyom Tarasenko <atar4qemu@gmail.com>
>  Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>  Markus Armbruster <armbru@redhat.com>
>  Eduardo Habkost <ehabkost@redhat.com>

I'm cc'ing eduardo@habkost.net.

> (Artyom is the original author; everybody else's changes are largely
> mechanical, refactoring, etc.  We've done some behind-the-scenes
> coordination so I don't anticipate any problems getting the
> signoffs.)

I doubt my contributions to these files are creative enough to qualify
for copyright, but better safe than sorry:

Signed-off-by: Markus Armbruster <armbru@redhat.com>


