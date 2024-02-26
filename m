Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48144C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWGb-0005x2-OE; Mon, 26 Feb 2024 03:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reWGY-0005vt-Ub
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:23:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reWGX-0004bs-15
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708935792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zjPaPGj5s3aVhMFul/v781tyjt/wzgZVW9WmyogkM4I=;
 b=axuJHYhnD8FCvY2rT2tCtcY8iSf+yFnifQUmhLK4v8vPbrz+4vrw+UiQEx5HHNlo9s0/Fd
 DGawhirfnkxDV5oNHZwC9XxG4AuvfzHC4Ly39nzGR9Crn7sX6arW5wSGlEx+gDMR/SmHGU
 zsBANyEeMEzkbskN/jHETHjqYExShR8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-2H9wsBxEOCSjOvyk5X0mIw-1; Mon, 26 Feb 2024 03:23:05 -0500
X-MC-Unique: 2H9wsBxEOCSjOvyk5X0mIw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1BFA1021F66;
 Mon, 26 Feb 2024 08:23:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CCFF8CEC;
 Mon, 26 Feb 2024 08:23:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 39FCA21E6767; Mon, 26 Feb 2024 09:23:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  John Snow <jsnow@redhat.com>,  Leif
 Lindholm <quic_llindhol@quicinc.com>,  qemu-block@nongnu.org,  Radoslaw
 Biernacki <rad@semihalf.com>,  BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-ppc@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 3/3] hw/ide: Include 'ide_internal.h' from current path
In-Reply-To: <20240226080632.9596-4-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 26 Feb 2024 09:06:31
 +0100")
References: <20240226080632.9596-1-philmd@linaro.org>
 <20240226080632.9596-4-philmd@linaro.org>
Date: Mon, 26 Feb 2024 09:23:03 +0100
Message-ID: <8734tfk520.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Rename "internal.h" as "ide_internal.h", and include

ide-internal.h

> it via its relative local path, instead of absolute
> to the project root path.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

The series is a lovely little cleanup; thanks, guys!


