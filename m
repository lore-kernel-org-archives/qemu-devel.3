Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046BBC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 11:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMnci-00070X-IG; Thu, 27 Jun 2024 07:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMnce-000705-MJ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:49:06 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMncc-0003R5-HD
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:49:04 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fa07e4f44eso46401615ad.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 04:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719488941; x=1720093741;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5cJLWURiQFo5D95r5D1PrYms1E5NQD/eO7a7HLsxZXY=;
 b=rLxyuzI1V+s/O0afqyMZP9gdxSJxnxkTI1KhkrLtdVZkvzIqk8ZCi5rodXhMlEVuyu
 NpbHcPd+OnPIbZxJJwJwp9DDVLVvTFSfjt9VTFwNxjGoQRWeVdRBP24fOkleTzc0vAgK
 Rp72ndHYqY1oqhlUzTIzLjCykABVJYdVUL5iYrwq1ZI9qWA66UxRx/9IlA0DlfMALVde
 pzPZaiTAq++RbaVApcR/yrk3y5R1UWhJV/4m6COcA69ZugHD8WKtPJFPeUKMjoA9uj/L
 OncSaP35E+FazX7KpK6+ctnWSP+L0ieg80o5pXWq89sBCaSFNH7GTtou+OVYNZJgioCK
 unZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719488941; x=1720093741;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5cJLWURiQFo5D95r5D1PrYms1E5NQD/eO7a7HLsxZXY=;
 b=Zf/Eg+2BiF3yoNRyDjnQOKfGuNtYNLC/++NkpAqolXGSbuxNa+YVkg5pauDrZgQ9aL
 U4O48buD6tw8kahxFPFJsIfAMWXOykYl8IozCWsKMomtGp/wu9zrgJGmrNXaiBanTAcg
 GK3jkEiiN7EMTWZNhdNrWCpobpgSse8AoLKBYww/aVmmJQtu3KFUz4qxk3gETw/+klSd
 1SUZu73ZDrR0g8kK34PB8oZMEAE9fsJGsSZxy8i+cUet0ltBiJn/6iCRuIatdTQmuv9+
 /Gr6TabAM1lWgH7pyq8hy6+dq9rqXIjZ1f5QtXXGCpSKuDvtU0nXsNRlEm0bznSoXepr
 PEiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdxsGq7V69/l4bS7VxacMAOcKPSlDfwSox4VGv2QiU7F45269nUxc9y6wIMVtqXPr/dsv0rEHxpmHjOhKMSMEWoMQxafU=
X-Gm-Message-State: AOJu0YwIJd81Hyjq8C2+GWXtRiKBC4wAeJJimpa41BuzAVh5Zqsgyj5L
 Ygl4/rToRGLMisnfoJKZ/7ASjJ0eXhdeqsgqxmJjdQkv412o9vkNWQfRpPeafMw=
X-Google-Smtp-Source: AGHT+IF31sitNWbS82Tlh8I/YgWC5lM6bval8FrWycPLksXPxHCXI45odLjEqczDgAWEy7BstuVOfQ==
X-Received: by 2002:a17:902:d509:b0:1f7:c56:58a3 with SMTP id
 d9443c01a7336-1fa23dce430mr147384585ad.26.1719488940872; 
 Thu, 27 Jun 2024 04:49:00 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac8df8c6sm11515235ad.54.2024.06.27.04.48.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 04:48:59 -0700 (PDT)
Message-ID: <bbcfe4f8-0c65-45f2-a0ba-050aa3cbd51b@daynix.com>
Date: Thu, 27 Jun 2024 20:48:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v2 2/2] ui/cocoa: Adds NSCursor absolute pointer support
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, marcandre.lureau@redhat.com, 
 lists@philjordan.eu
References: <20240625134931.92279-1-phil@philjordan.eu>
 <20240625134931.92279-3-phil@philjordan.eu>
Content-Language: en-US
In-Reply-To: <20240625134931.92279-3-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi,

Thanks for fixing my patch and adding this follow-up.

I incorporated your fix with some change with v2 so please review it and 
rebase this patch to it.

On 2024/06/25 22:49, Phil Dennis-Jordan wrote:
> When pointer input is absolute, use the native macOS host’s Cocoa
> NSCursor to render the guest’s cursor. The rendered cursor is no longer
> cropped to the guest viewport, and the correct cursor image is passed to
> anything tapping into the host system’s native cursor. (such as remote
> access)
> 
> The CALayer is retained for rendering the cursor in relative pointer
> input mode. Cropping the cursor here gives a visual indication of the
> captured pointer (the mouse must be explicitly ungrabbed before allowing
> the cursor to leave the Qemu window), and teleporting the host cursor
> when its position is changed by the guest causes a feedback loop in
> input events. >
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   ui/cocoa.m | 82 +++++++++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 65 insertions(+), 17 deletions(-)
> 
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index cca987eac7..131c442e16 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -314,6 +314,7 @@ @interface QemuCocoaView : NSView
>       CFMachPortRef eventsTap;
>       CALayer *cursorLayer;
>       QEMUCursor *cursor;
> +    NSCursor *cocoaCursor;
>       int mouseX;
>       int mouseY;
>       int mouseOn;
> @@ -402,6 +403,9 @@ - (void) dealloc
>   
>       [cursorLayer release];
>       cursorLayer = nil;
> +    [cocoaCursor release];
> +    cocoaCursor = nil;
> +
>       [super dealloc];
>   }
>   
> @@ -460,27 +464,14 @@ - (void)setMouseX:(int)x y:(int)y on:(int)on
>       [CATransaction begin];
>       [CATransaction setDisableActions:YES];
>       [cursorLayer setPosition:position];
> -    [cursorLayer setHidden:!mouseOn];
> +    [cursorLayer setHidden:!mouseOn || isAbsoluteEnabled];
>       [CATransaction commit];
>   }
>   
> -- (void)setCursor:(QEMUCursor *)given_cursor
> +static CGImageRef cursor_cgimage_create(QEMUCursor *cursor)

Don't add C functions in middle of Objective-C definition.

>   {
>       CGDataProviderRef provider;
>       CGImageRef image;
> -    CGRect bounds = CGRectZero;
> -
> -    cursor_unref(cursor);
> -    cursor = given_cursor;
> -
> -    if (!cursor) {
> -        return;
> -    }
> -
> -    cursor_ref(cursor);
> -
> -    bounds.size.width = cursor->width;
> -    bounds.size.height = cursor->height;
>       CGColorSpaceRef color_space = CGColorSpaceCreateWithName(kCGColorSpaceSRGB);
>   
>       provider = CGDataProviderCreateWithData(
> @@ -506,6 +497,43 @@ - (void)setCursor:(QEMUCursor *)given_cursor
>   
>       CGDataProviderRelease(provider);
>       CGColorSpaceRelease(color_space);
> +    return image;
> +}
> +
> +static NSCursor *cocoa_cursor_create(QEMUCursor *cursor, CGImageRef image)
> +{
> +    NSPoint hotspot = { cursor->hot_x, cursor->hot_y };

Use NSMakePoint() for the consistency with the next line (among other 
similar constructs).

> +    NSSize size = NSMakeSize(cursor->width, cursor->height);
> +    NSImage *cursor_image = [[NSImage alloc] initWithCGImage:image size:size];
> +    NSCursor *cocoa_cursor =
> +        [[NSCursor alloc] initWithImage:cursor_image hotSpot:hotspot];
> +    [cursor_image release];
> +    return cocoa_cursor;
> +}
> +
> +- (void)setCursor:(QEMUCursor *)given_cursor
> +{
> +    CGImageRef image;
> +    NSImage *cursor_nsimage = nil;
> +    CGRect bounds = CGRectZero;
> +
> +    cursor_unref(cursor);
> +    cursor = given_cursor;
> +
> +    if (!cursor) {
> +        return;
> +    }
> +
> +    cursor_ref(cursor);
> +
> +    bounds.size.width = cursor->width;
> +    bounds.size.height = cursor->height;
> +
> +    image = cursor_cgimage_create(cursor);
> +    [cocoaCursor release];
> +    cocoaCursor = cocoa_cursor_create(cursor, image);
> +    [self.window invalidateCursorRectsForView:self];
> +
>       [CATransaction begin];
>       [CATransaction setDisableActions:YES];
>       [cursorLayer setBounds:bounds];
> @@ -514,6 +542,16 @@ - (void)setCursor:(QEMUCursor *)given_cursor
>       CGImageRelease(image);
>   }
>   
> +- (void) resetCursorRects
> +{
> +    if (self->cocoaCursor == nil) {

For consistency, just do: if (!cocoaCursor)

> +        [super resetCursorRects];
> +    } else {
> +        NSRect guest_area = {{ 0.0, 0.0 }, { screen.width, screen.height }};
> +        [self addCursorRect:guest_area cursor:cocoaCursor];
> +    }
> +}
> +
>   - (void) drawRect:(NSRect) rect
>   {
>       COCOA_DEBUG("QemuCocoaView: drawRect\n");
> @@ -1181,7 +1219,12 @@ - (void) grabMouse
>           [[self window] setTitle:[NSString stringWithFormat:@"QEMU %s - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)", qemu_name]];
>       else
>           [[self window] setTitle:@"QEMU - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)"];
> -    [self hideCursor];
> +
> +    [cursorLayer setHidden:!mouseOn || isAbsoluteEnabled];
> +    if (!isAbsoluteEnabled) {
> +        [self hideCursor];
> +    }

[self hideCursor] should also be called for an absolute pointer device 
if the guest does not set the cursor. See ui/gtk.c and ui/sdl2.c to know 
how the show-cursor option should behave.

Regards,
Akihiko Odaki

