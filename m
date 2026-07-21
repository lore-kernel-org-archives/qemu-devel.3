Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA55C44532
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9rB-0000FR-JD; Tue, 21 Jul 2026 08:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wm9r5-0000Er-89
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:45:52 -0400
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wm9r2-0000Nq-SH
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:45:50 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3A54B14000DD;
 Tue, 21 Jul 2026 08:45:47 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
 by phl-compute-02.internal (MEProxy); Tue, 21 Jul 2026 08:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1784637947;
 x=1784724347; bh=WaxU6dX9dvZCuA+SnqFqE6K5LFpUvWabT2u9ndjknOE=; b=
 dWpNmc8YSoblfk6zy/tWWOOGO5g1dOs7vPwYu6TXnA+rat2FQ8CSFBnwDxnWQgqA
 trDnn6yP66rnuLrklddYHcmIPApK0ZfoU1C+Z8MQy3LWQ3CW0L2FE297Bkx8nqs/
 XojPNEaYJ7w25dBa47hp2thZggWb2PaUzqO4tKCkGg2Yj/WqPgCugFJcim8wPACC
 C5MMMNKiX40bUgavge3YYimxYUglFKBM+P8FNnPv4OFj2Lf5GPX67RWWTm0gmOdW
 v4gP5WV93Zk47VonOb6Aft4riJePS0C/NcWPuluxWJI0XaKEGyFY526aB3CW6qnC
 CsMU2HZOxRdj5V5NfJAx0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784637947; x=
 1784724347; bh=WaxU6dX9dvZCuA+SnqFqE6K5LFpUvWabT2u9ndjknOE=; b=J
 an7aPtypCPAipVDw+p1TcRdK1/imaDvt3ppddHVnhegQsYOhxjFbZsB2Mv0vAOGb
 ojoR9UCrAwXfOII5k67xSf3ruM6MO92AFv7H3wgTg+YquE0AvW0r38qhaelGcwrU
 VUB7c846YOqs/GSmoM2jn52KnnJly/WL5aF6BU5eQ6Wy2UDtfrLkiC/V8ouf4z9S
 OAzv5edJyvtaQgCXgwBFNwf1js3QBrhU9HqZtLnNCak30PGvoKfTQmZScfr+bzhc
 RZ0fUFWRUIqt3D9Wc27fB9lrdieX9a/bBKMW/PbUL5fySjYd1rhxm93Oor5e+AaU
 s7vD8nDH2fj4MJPHme76w==
X-ME-Sender: <xms:-mlfarqTkoiWnYffWetSWiom8fJY-7teFIEdrwXL7JmlGLO5thUdCg>
 <xme:-mlfagfWKC6WbTkMSsFkpphEAEGCp-ZjpGNyyMeaU_rNnLRr2PtlF3A9SN3EZxNnI
 tiKGdJWV_HZ0d1R1ArLPeVA76PmUE25h-CV3nXMRxDzy9uOorZm>
X-ME-Proxy-Cause: dmFkZTFfigHL4G23AI1EmuIZrBRVm9X2rU4+zuAPAYDh407myJTdEwO+IeSZT6tBys5iD6
 SzB1SjO/KnJ2WMZOZDNirB4m0UkEsz2z/U8jt+rkPFp5HZyQ0Z1LpM+BWT9PLznKfN0zFo
 aqftjdTuzLpnuF+zoVm/L5CVA8xBUOVQY/X5FajGXHVvBR2KBrGg2tfy44QFywLeA2Lubh
 yRXun00C/WnTv9jD5Ujz87dSzhMSQOJ6tNYaIbKksHjfan3lkq25QmTgDxYrxoQSu6qlxD
 SO5hEPvRilmKFkXUgmHFtZifVKxtkv4S25J1zxscioisqOT/UVEQzT1gbxLQZhVf2xRIGy
 j8TJ5JF1aLFrPA0KquvwwJ8xD3h7UgAR/J5qI/1T4gcu3Oh9DGDykBsy1bCU+F8yh+EFa6
 XanpaBJc4z7YZVwKvhmb3G1WNcn3x2n/RSf50aM2qxh9BaoORpu0QOqAt6UPPB9Zcmkfvh
 zEZfqYNJP4tx2+cQmVwMOnEYjS7bpPr8qMgl46zKyFYXSmmYARMQJvROQgLn+0pb1Lh0o4
 +KNbzQ45I/GLKd+55YS+w7PKxaR0w+LSvBkbEfLI8PygdAxABtuvMIKLHyHEyo7ro+VAlF
 2Qzi+J2MWnufYNlYdgI7IDa8tCabc9g6kkHEaCLMjCRk9aWRkFXMpTjWZv3g
X-ME-Proxy: <xmx:-mlfasHB87Qc6lQCJeJYPY8_Ub4gFoRrCaN-KTSEH9bRCIeVUY3btg>
 <xmx:-mlfatFok_Ch5nk0RWdFRAX2q2uheMfQBo4aV-xyF5PiJNjKnYJfZA>
 <xmx:-mlfapPi_CdzQzDafewYc4r8YxfNet9CfNBQdRzm-RmpYI7JopwqvQ>
 <xmx:-mlfasELUp7szjGXrzAYsUw656pLDk2yB_bVBjze1ngIisLnH8peag>
 <xmx:-2lfasn3tIri50kz3hgoDk2PRV_sji-oTK5I5ktIzlzhh_4QG38MzLOs>
Feedback-ID: i03f14258:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id C6C8A15C008C; Tue, 21 Jul 2026 08:45:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AL_Jt5W8A3YZ
Date: Tue, 21 Jul 2026 06:45:26 -0600
From: "Alex Williamson" <alex@shazbot.org>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <6ae7c0fb-1f28-4e11-a953-ac8a27939f33@app.fastmail.com>
In-Reply-To: <20260721062745.3793066-1-clg@redhat.com>
References: <20260721062745.3793066-1-clg@redhat.com>
Subject: Re: [PATCH] vfio/listener: Remove unnecessary linux/kvm.h include
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.156; envelope-from=alex@shazbot.org;
 helo=fhigh-a5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 21, 2026, at 12:27 AM, C=C3=A9dric Le Goater wrote:
> Since commit d0e8bccafc23 ("hw/vfio/listener.c: remove CONFIG_KVM"),
> the linux/kvm.h include is unconditional. This breaks the build on
> targets that lack asm/kvm.h such as sparc and sparc64:
>
>   In file included from ../hw/vfio/listener.c:23:
>   linux-headers/linux/kvm.h:16:10: fatal error: asm/kvm.h: No such fil=
e=20
> or directory
>
> This include is not needed in listener.c which only uses kvm_enabled()
> and kvm_get_max_memslots(), both are declared in "system/kvm.h".
> Remove it.
>
> Fixes: d0e8bccafc23 ("hw/vfio/listener.c: remove CONFIG_KVM")
> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>"
> Suggested-by: Alex Williamson <alex@shazbot.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/listener.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index=20
> c19600e980a8d02217b5d9df4aca8f879ab2c5d5..008f488a3e7d4ca2ec9e1780b496=
371b0f447653=20
> 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -20,7 +20,6 @@
>=20
>  #include "qemu/osdep.h"
>  #include <sys/ioctl.h>
> -#include <linux/kvm.h>
>  #include <linux/vfio.h>
>=20
>  #include "exec/target_page.h"
> --=20
> 2.55.0

Reviewed-by: Alex Williamson <alex@shazbot.org>

