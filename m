Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDB1CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 06:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ0ts-00026c-RZ; Mon, 15 Jun 2026 02:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZ0tp-00026F-NL
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 02:34:21 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZ0tk-0004s0-DC
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 02:34:18 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65F6Xr86030009
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 15 Jun 2026 15:33:53 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=7DrQGYFyv6Z4qb3a66rvcUQn4MgoAVIAavnHIlTpqhM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781505233; v=1;
 b=CfA2FlcJmbmU/rxd5aeXXWUwTfmXbR205fxyW01Gg573ISVY86HIQrdKPTdvo2bl
 05CoegEmBV7+lWa7VqS6GFmA4hkEFHZllcpI3H6BLioT3vkpIkqv6Yz5uSDCPMDd
 zx7IKQZZAK8GpaVUhp1yp5nrJj6xdtk9eZr6FC0DczsWysTAISL1Irxe3HW1536Y
 ANjPC40cKmQzEZx0TAHx5JXpFtocRvCm9FrleY7MH6yu3BohvmywRR847z5h2SZS
 KNjJIYH6Zg+bm/3rp5GX/BDkKus8UtHLx19gOu9QXR0IBUsGORghBDb/3OtaMBUb
 VpMeTyC247xZNLueqseOaQ==
Message-ID: <b88250c3-2f39-470b-bf9a-c8fe707bd5c3@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 15 Jun 2026 15:33:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/cocoa: fix artifacts from scaled partial redraws
To: Stefan Reinauer <stefan.reinauer@coreboot.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@mailo.com, marcandre.lureau@redhat.com
References: <20260614000409.63735-1-stefan.reinauer@coreboot.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260614000409.63735-1-stefan.reinauer@coreboot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/06/14 9:04, Stefan Reinauer wrote:
> Under zoom-to-fit, Cocoa redrew each dirty rect by cropping the
> guest CGImage and drawing that crop into the dirty destination
> rect. With non-integer scales, adjacent partial updates could sample
> the source with different phase. Moving cursor updates then showed
> one-line stretch/skew artifacts at the dirty band boundary.

This fix is fine, but I think it's unlikely that "adjacent partial 
updates could sample the source with different phase". You'll observe 
tearing even with integer scales if that is the case. This fix does not 
deal with timing either.

My guess is that some fractions in rectList were rounded in 
CGImageCreateWithImageInRect() or before reaching the function, and that 
caused sampling one line more or less, causing stretch/skew artifacts.

> 
> Keep using AppKit's dirty-region clipping, but draw the full guest
> image into the view bounds. Each partial update then uses the same
> source transform while drawing remains limited to invalidated
> regions.
> 
> Signed-off-by: Stefan Reinauer <stefan.reinauer@coreboot.org>
> ---
>   ui/cocoa.m | 25 +++++++------------------
>   1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index c5e639ab98..f294c20720 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -551,24 +551,13 @@ - (void) drawRect:(NSRect) rect
>               0, //interpolate
>               kCGRenderingIntentDefault //intent
>           );
> -        // selective drawing code (draws only dirty rectangles) (OS X >= 10.4)
> -        const NSRect *rectList;
> -        NSInteger rectCount;
> -        int i;
> -        CGImageRef clipImageRef;
> -        CGRect clipRect;
> -
> -        [self getRectsBeingDrawn:&rectList count:&rectCount];
> -        for (i = 0; i < rectCount; i++) {
> -            clipRect = rectList[i];
> -            clipRect.origin.y = (float)h - (clipRect.origin.y + clipRect.size.height);
> -            clipImageRef = CGImageCreateWithImageInRect(
> -                                                        imageRef,
> -                                                        clipRect
> -                                                        );
> -            CGContextDrawImage (viewContextRef, cgrect(rectList[i]), clipImageRef);
> -            CGImageRelease (clipImageRef);
> -        }
> +        NSRect imageRect = NSMakeRect(0, 0, w, h);
> +
> +        /*
> +         * AppKit already clips drawing to the dirty region. Draw the full
> +         * guest image so scaled partial updates use a stable source transform.
> +         */
> +        CGContextDrawImage(viewContextRef, cgrect(imageRect), imageRef);

Please use CGRectMake().

Regards,
Akihiko Odaki

>           CGImageRelease (imageRef);
>           CGDataProviderRelease(dataProviderRef);
>       }


