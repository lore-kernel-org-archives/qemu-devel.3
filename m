Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D6EC5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyY0j-0001hh-2Z; Mon, 24 Aug 2026 12:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wyY0g-0001h6-WA
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:58:59 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wyY0d-0003mY-OC
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:58:58 -0400
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67OGwmt9005848
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 25 Aug 2026 01:58:48 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=LIi+CKn2t/ndjlBYBShhFk3/gzHUpow7EImpkksNfkI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787590728; v=1;
 b=WCmafKnpJw2y9cTgriehqRnMIFurBkev8BezTlEuMt1qftWvpjO56Xr+UlnJhwcg
 PORx18aNG5jG0iVkZZ9RDrQ7R5wfAolao8xG8j7IeuqnKYWbaJM3vh7CFlza9g0j
 usw8+It3831taUOMzN5QpZrT1iCNjSsCu9Fe/Abl46plwg8DtfOlRtkk2FXlrDiO
 8c59/PVH4mIgdUFe5A4//ZXYPROOIqSoc/Q55MFeH5QBCEz7RkXMFzKRX68qX/OT
 sT1qMou2JxGJWDkMdrwh4bGFMLp0CsWlV462zC+MjVWL8JkgTRK+xRnxRoawo4XG
 YtAko2FnkjmIstlc0Tvj0Q==
Message-ID: <d8529087-6950-45c1-b7a6-74ab80a10e25@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 25 Aug 2026 01:58:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH] hw/input/ps2: answer unknown mouse commands with a resend
To: Christian Quante <christian@quante.one>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260823071529.16389-1-christian@quante.one>
Content-Language: en-US
In-Reply-To: <20260823071529.16389-1-christian@quante.one>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/08/23 16:15, Christian Quante wrote:
> ps2_write_mouse() ends its command switch with a bare "default: break;",
> so an unknown command draws no reply at all. A real PS/2 device answers
> every byte it is given -- ACK (0xFA) when it understood one, resend
> (0xFE) when it did not -- and a guest that gets nothing back is left
> waiting out its reply timeout. The keyboard path in the same file has
> always answered unknown commands with KBD_REPLY_RESEND.
> 
> Two guests were measured on this.
> 
> OS/2 probes the mouse with the vendor command 0xBB, which QEMU does not
> implement, and then polls the status port until its own timeout runs
> out. On a Warp 3 guest that wait costs about 25 ms of every boot under
> TCG, and 2.1 s under KVM, where each of those polls leaves the guest.
> With this patch the wait ends on the first read: the guest takes the
> same error path an unexpected reply would, and does not retry.
> 
> Linux probes for a TrackPoint with 0xE1 and fails the same way. Timing
> the psmouse detection from a mark written to /dev/kmsg to the kernel's
> "input:" line, three boots each of a 6.18.35 kernel under TCG:
> 426.7/428.8/441.6 ms without this patch, 21.4/21.6/21.2 ms with it. The
> mouse is detected identically either way; libps2 caps its retries at
> two attempts and ends in the same -EPROTO the timeout produced.

With no response, __ps2_command() in libps2 returns -EIO. With this 
patch, two 0xfe responses instead make it return -EPROTO. The two cases 
therefore do not return the same error.

> 
> The specification's second stage -- 0xFC (Error) when the byte after a
> rejected one is invalid as well -- is deliberately left out. It would
> need state that has to survive migration, no guest is known to test for
> it, and the keyboard path has answered unknown commands with a bare
> resend for twenty years.

Commit 06b3611fc2a3 ("ps2: reject unknown commands, instead of
blindly accepting them") changed unknown keyboard commands from ACK
to Resend in 2016, so this behavior is ten years old, not twenty.

> 
> Signed-off-by: Christian Quante <christian@quante.one>
> ---
>   hw/input/ps2.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index 5516eb262d..1e8c6d983a 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -73,6 +73,7 @@
>   #define AUX_SET_DEFAULT     0xF6
>   #define AUX_RESET           0xFF    /* Reset aux device */
>   #define AUX_ACK             0xFA    /* Command byte ACK. */
> +#define AUX_RESEND          0xFE    /* Command NACK, send the cmd again */
>   
>   #define MOUSE_STATUS_REMOTE     0x40
>   #define MOUSE_STATUS_ENABLED    0x20
> @@ -955,6 +956,13 @@ void ps2_write_mouse(PS2MouseState *s, int val)
>                   s->mouse_type);
>               break;
>           default:
> +            /*
> +             * A PS/2 device answers every command it is given; an unknown
> +             * one draws a resend. Staying silent leaves the guest waiting
> +             * out its reply timeout. The keyboard path above answers
> +             * unknown commands with KBD_REPLY_RESEND.
> +             */

Mentioning the mismatch with the keyboard path in the patch message 
makes sense, but keeping it in the inline comment is somewhat extraneous 
since consistent behavior across both paths is an obvious expectation. I 
suggest dropping the final sentence.

Additionally, it would be better to ensure the inline rationale is 
documented consistently across both the mouse and keyboard paths.

Otherwise, the patch looks solid to me.

Regards,
Akihiko Odaki
> +            ps2_queue(ps2, AUX_RESEND);
>               break;
>           }
>           break;


