Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5C9CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0ZS-0004f4-IW; Tue, 09 Jun 2026 13:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wX0ZQ-0004bG-50
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:49:00 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wX0ZO-0006cS-5p
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=ZVX+Fo/Y/js8LTHxqI21HI9gGy9P5wTKg54kt6a2LaI=; b=cCLGNae7cE0M24u4
 FYqNk4ons7RPifwRAyoRiwe+URrFh3nc5GRNhDH8UdHBC2hYx4AJPZkLilyifSgptD4Bv9WNzJ3kF
 q6zvFk4jUzIVep2V0oUbaYeeoIQYlazl9qonUvGzQACKwpQrgGXY1iJmrNI6Bu+ng9NMz/KKvyQZG
 YuA2cLx7x38C/sLsn4IC6j4zC0Bl/f+yknBppESNc5SXEGPpJSP18NOXWTSTq2o5dcJv/FR3VafPH
 akOOxZfzOHC9uyXywblZ3YQRDTaAdeMQSQw//d1ywikvhD0M4z6XiHAs9UbYkza0PNOkptmERU6/d
 XFg5hoooexl4Q/u3AQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wX0ZI-00000006PB7-0ZbV;
 Tue, 09 Jun 2026 17:48:52 +0000
Date: Tue, 9 Jun 2026 17:48:52 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 01/17] hmp-commands.hx: fix button_state doc
Message-ID: <aihSBL791PGJyo6-@gallifrey>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
 <20260609-ui-input-v1-1-42615deb818e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609-ui-input-v1-1-42615deb818e@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.88+deb13-amd64 (x86_64)
X-Uptime: 17:38:11 up 24 days, 20:50,  2 users,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
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

* Marc-André Lureau (marcandre.lureau@redhat.com) wrote:
> Right & middle buttons are inverted (see hmp_mouse_button)

OK, so lets look at that, hmp_mouse_button has:
    static uint32_t bmap[INPUT_BUTTON__MAX] = {
        [INPUT_BUTTON_LEFT]       = MOUSE_EVENT_LBUTTON,
        [INPUT_BUTTON_MIDDLE]     = MOUSE_EVENT_MBUTTON,
        [INPUT_BUTTON_RIGHT]      = MOUSE_EVENT_RBUTTON,
    };

and looking at qemu_input_update_buttons the left side is which
event to send, and the right side is the mask;
include/ui/console.h has:
#define MOUSE_EVENT_LBUTTON 0x01
#define MOUSE_EVENT_RBUTTON 0x02
#define MOUSE_EVENT_MBUTTON 0x04
#define MOUSE_EVENT_WHEELUP 0x08
#define MOUSE_EVENT_WHEELDN 0x10

and it looks like the L/R/M have been like that since at least 2007
(which matches hid and spice but is the opposite to vnc)

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hmp-commands.hx | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 0d780e6da30..7ae2468a3d9 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -752,13 +752,13 @@ ERST
>          .name       = "mouse_button",
>          .args_type  = "button_state:i",
>          .params     = "state",
> -        .help       = "change mouse button state (1=L, 2=M, 4=R)",
> +        .help       = "change mouse button state (1=L, 2=R, 4=M)",
>          .cmd        = hmp_mouse_button,
>      },
>  
>  SRST
>  ``mouse_button`` *val*
> -  Change the active mouse button state *val* (1=L, 2=M, 4=R).
> +  Change the active mouse button state *val* (1=L, 2=R, 4=M).

Looks right to me,

Acked-by: Dr. David Alan Gilbert <dave@treblig.org>

>  ERST
>  
>      {
> 
> -- 
> 2.54.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

