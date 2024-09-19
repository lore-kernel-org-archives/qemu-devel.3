Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06178CF3958
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 14:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srINE-0004qj-HY; Thu, 19 Sep 2024 10:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1srIMy-0004U4-Bm
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 10:42:56 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1srIMm-0004Hx-Cj
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 10:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=josV6NXwzoUJASKVBaFDCVv1eUqMkzXz1NTL5UaS96Y=; b=H6YVxhxOR9nMTORn
 IctCKZp+KnZvGgQl5Cxv1eMsvQqQckD/IxrAKHhAJ1XzJyO/hy0J/tifFy49FTVfNazzJ69s8n6vf
 tzVrVg1amVuJwQhJE+EHG/NzZHQv/CoOa1lHURtAYVPBtgo+jG9/TSHNq6sIvT+5YbovtZfysPXIu
 hIQvC38XlQg1I7eCAZ5EcR3DUd7dFMKEkFQb9suV0W5HBFnW/bfm8PHW1pQh6MfMt8mXOy6HKsNOR
 2LLHk0dpZ9vGdeC9tsQ5uodqBqQ0tZWYA8D8kUaz+fuRA/iCaTcMkeWuvXi5+6xW7Jkzd11AYbDsT
 PAM2SrGgfzPpM6Wsdw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1srIMl-006RFU-1G;
 Thu, 19 Sep 2024 14:42:43 +0000
Date: Thu, 19 Sep 2024 14:42:43 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] qemu-timer: Remove unused
 qemu_clock_get_main_loop_timerlist
Message-ID: <Zuw4Y1VLDhjB7_hL@gallifrey>
References: <20240918163427.175237-1-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240918163427.175237-1-dave@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:42:22 up 134 days,  1:56,  1 user,  load average: 0.03, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* dave@treblig.org (dave@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> qemu_clock_get_main_loop_timerlist has been unused since it was
> originally added in
>   ff83c66ecc ("aio / timers: Split QEMUClock into QEMUClock and QEMUTimerList")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>

V2 sent, see:

[PATCH v2] qemu-timer: Remove unused timer functions
<20240919144124.309646-1-dave@treblig.org>

I found another one.

Dave

> ---
>  include/qemu/timer.h | 10 ----------
>  util/qemu-timer.c    |  5 -----
>  2 files changed, 15 deletions(-)
> 
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index fa56ec9481..ccd8578ae3 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -190,16 +190,6 @@ bool qemu_clock_use_for_deadline(QEMUClockType type);
>   */
>  int64_t qemu_clock_deadline_ns_all(QEMUClockType type, int attr_mask);
>  
> -/**
> - * qemu_clock_get_main_loop_timerlist:
> - * @type: the clock type
> - *
> - * Return the default timer list associated with a clock.
> - *
> - * Returns: the default timer list
> - */
> -QEMUTimerList *qemu_clock_get_main_loop_timerlist(QEMUClockType type);
> -
>  /**
>   * qemu_clock_nofify:
>   * @type: the clock type
> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
> index 213114be68..e5b5452e4e 100644
> --- a/util/qemu-timer.c
> +++ b/util/qemu-timer.c
> @@ -291,11 +291,6 @@ QEMUClockType timerlist_get_clock(QEMUTimerList *timer_list)
>      return timer_list->clock->type;
>  }
>  
> -QEMUTimerList *qemu_clock_get_main_loop_timerlist(QEMUClockType type)
> -{
> -    return main_loop_tlg.tl[type];
> -}
> -
>  void timerlist_notify(QEMUTimerList *timer_list)
>  {
>      if (timer_list->notify_cb) {
> -- 
> 2.46.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

