Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C5FC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 15:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg576-0007Rs-M9; Fri, 01 Mar 2024 10:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rg574-0007R2-JC; Fri, 01 Mar 2024 10:47:54 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rg572-0005g8-73; Fri, 01 Mar 2024 10:47:54 -0500
Received: from [192.168.0.253] (unknown [178.178.100.83])
 by mail.ispras.ru (Postfix) with ESMTPSA id 878EA40F1DFB;
 Fri,  1 Mar 2024 15:47:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 878EA40F1DFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1709308047;
 bh=Bm38lFwtIU/Ws2Fofl5LNYp0G1R3YthP/JdI8roNLkA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kXzU7oVgKC9bezxIsBZByx/6igDlUbLSOQlikxHQF+5mbsOAgCNsAPOmmwt2ovo4y
 8jpUHi0yZriTyVsXSuuCEO3aCnAwlGSqSQirfEhIMWHWaRLTpDkmEM22Ppvtu8Hrsj
 x8HYYVik0LU3L8RG/SgBEAmnC7W79XwjHq8k4v5c=
Message-ID: <a066c1db-33a4-41c9-9a15-4ede82dfc895@ispras.ru>
Date: Fri, 1 Mar 2024 18:47:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Spam][PATCH] replay: Improve error messages about configuration
 conflicts
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-trivial@nongnu.org
References: <20240301120641.864047-1-armbru@redhat.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20240301120641.864047-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

On 01.03.2024 15:06, Markus Armbruster wrote:
> Improve
> 
>     Record/replay feature is not supported for '-rtc base=localtime'
>     Record/replay feature is not supported for 'smp'
>     Record/replay feature is not supported for '-snapshot'
> 
> to
> 
>     Record/replay is not supported with -rtc base=localtime
>     Record/replay is not supported with multiple CPUs
>     Record/replay is not supported with -snapshot
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   replay/replay.c | 2 +-
>   system/vl.c     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/replay/replay.c b/replay/replay.c
> index 3fd241a4fc..a2c576c16e 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -511,7 +511,7 @@ void replay_add_blocker(const char *feature)
>   {
>       Error *reason = NULL;
>   
> -    error_setg(&reason, "Record/replay feature is not supported for '%s'",
> +    error_setg(&reason, "Record/replay is not supported with %s",
>                  feature);
>       replay_blockers = g_slist_prepend(replay_blockers, reason);
>   }
> diff --git a/system/vl.c b/system/vl.c
> index e480afd7a0..cc03a17c09 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1932,7 +1932,7 @@ static void qemu_apply_machine_options(QDict *qdict)
>       }
>   
>       if (current_machine->smp.cpus > 1) {
> -        replay_add_blocker("smp");
> +        replay_add_blocker("multiple CPUs");
>       }
>   }
>   


