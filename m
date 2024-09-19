Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1213CE8D49
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 05:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr9GY-0007nj-Kx; Thu, 19 Sep 2024 00:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1sr9GP-0007GY-FI
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:59:37 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1sr9GN-0000yM-Dh
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:59:33 -0400
Received: from [192.168.3.57] (unknown [78.37.10.254])
 by mail.ispras.ru (Postfix) with ESMTPSA id 5787B40755F3;
 Thu, 19 Sep 2024 04:59:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5787B40755F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1726721966;
 bh=sgMPNZPs/phctBLOuiqfsU4PjUMnbzSqyL6pHFhwjrQ=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=CuwZ5uHqRLffuXb99GkPZLY4hWmisvCRawOzXCQN6j04g3Dqlh2BvA/eaP1MRQlY5
 VuMTPbAejGcxfs0OGAOLf537IgB0uMmO6ru8slX0S78WXrjJjNAbsjnTtY5guwJMO8
 IYv71xtOc8UMpywdl9aOCamryOAWShEreWQaFtMg=
Message-ID: <2bb2f9ba-a431-49c4-8be2-e50b47cb4089@ispras.ru>
Date: Thu, 19 Sep 2024 07:59:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] replay: Remove unused replay_disable_events
To: dave@treblig.org, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20240918234005.466999-1-dave@treblig.org>
Content-Language: en-US
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20240918234005.466999-1-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>

On 19.09.2024 02:40, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> replay_disable_events has been unused since 2019's
>    c8aa7895eb ("replay: don't drain/flush bdrv queue while RR is working")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   include/sysemu/replay.h | 2 --
>   replay/replay-events.c  | 9 ---------
>   2 files changed, 11 deletions(-)
> 
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index 8102fa54f0..cba74fa9bc 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -117,8 +117,6 @@ void replay_async_events(void);
>   
>   /* Asynchronous events queue */
>   
> -/*! Disables storing events in the queue */
> -void replay_disable_events(void);
>   /*! Enables storing events in the queue */
>   void replay_enable_events(void);
>   /*! Returns true when saving events is enabled */
> diff --git a/replay/replay-events.c b/replay/replay-events.c
> index af0721cc1a..2e46eda6bf 100644
> --- a/replay/replay-events.c
> +++ b/replay/replay-events.c
> @@ -92,15 +92,6 @@ void replay_flush_events(void)
>       }
>   }
>   
> -void replay_disable_events(void)
> -{
> -    if (replay_mode != REPLAY_MODE_NONE) {
> -        events_enabled = false;
> -        /* Flush events queue before waiting of completion */
> -        replay_flush_events();
> -    }
> -}
> -
>   /*! Adds specified async event to the queue */
>   void replay_add_event(ReplayAsyncEventKind event_kind,
>                         void *opaque,


