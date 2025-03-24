Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B030C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 00:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twVgT-00067w-75; Sun, 23 Mar 2025 20:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1twVgQ-00067h-Ok
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 20:28:50 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1twVgO-0002yU-Aw
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 20:28:50 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 45C894E6014;
 Mon, 24 Mar 2025 01:28:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id YBQfWeyhm2Jy; Mon, 24 Mar 2025 01:28:44 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4B2CD4E6004; Mon, 24 Mar 2025 01:28:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 48AA074577C;
 Mon, 24 Mar 2025 01:28:44 +0100 (CET)
Date: Mon, 24 Mar 2025 01:28:44 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] system/vl: Tidy up break in QEMU_OPTION_machine case
In-Reply-To: <20250323230006.36057-1-philmd@linaro.org>
Message-ID: <c0e89357-8b9c-fb51-5164-cc9c499a5c6f@eik.bme.hu>
References: <20250323230006.36057-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1986341314-1742776124=:41042"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1986341314-1742776124=:41042
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 24 Mar 2025, Philippe Mathieu-Daudé wrote:
> The break in the QEMU_OPTION_machine case is mis-placed.
>
> Not a big deal, since producing the same outcome, but
> suspicious, so put it in the correct place.

Why is it misplaced? It's at the end of the block. This swich has other 
cases that put break outside or inside the block randomly so there's no 
agreement on that. Changing this one place does not make it consistent. 
IMO inside the block looks better but I'd align the {} with the case and 
not indent them but this probably does not worth the effort to clean it.

Regards,
BALATON Zoltan

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> system/vl.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/system/vl.c b/system/vl.c
> index ec93988a03a..dbca9ebba4d 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -3409,8 +3409,8 @@ void qemu_init(int argc, char **argv)
>                         machine_help_func(machine_opts_dict);
>                         exit(EXIT_SUCCESS);
>                     }
> -                    break;
>                 }
> +                break;
>             case QEMU_OPTION_accel:
>                 accel_opts = qemu_opts_parse_noisily(qemu_find_opts("accel"),
>                                                      optarg, true);
>
--3866299591-1986341314-1742776124=:41042--

