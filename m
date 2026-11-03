Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB886606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zqNyfpq+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOMC2-0004yt-56; Tue, 03 Nov 2026 16:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOMBz-0004yi-9x
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 16:37:19 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOMBx-0005WA-K9
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 16:37:19 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8b0a921ee46so528437b3.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 13:37:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793741835; cv=none;
 d=google.com; s=arc-20260327;
 b=FNeG7XDrkh7no/cJm63fwFi0VbsE7UPSbi95O7rWrQB9xHfXcbF+08Th06NolEVXcn
 ykZDOaza2e6bxF5PRCSrYke9AdbAJwo/9Wyb4DgzyRsR8Gu+VKMSBeUX+N7CVO1eEGOB
 +Oe8lP/wcUTe1FXC89lQZSCgLTlQjY3y4Ar/JGR7INH/Msl5ZdOq8PdsfDfuUfUTB5JV
 x6OpplqMIUQ80bJ9gCCD6QDWanQZLmZgNXQn9SV7P4Z7ODCfnXOWw9cPexgl6KRMLMAt
 n05m8b8U57uxtXw9VAWF50BJSSZ8yslZpVgTAU7sW8zlc8+xpyQOOEpRBvn/yln2k+ST
 U7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TSUWwVydHQrYjn5zir+0+LXobOs3Q65VERna5l3bEbQ=;
 fh=usDNqvCtitj82pGicDpK6B1e4SZ+WdKRTKWbIL3slCY=;
 b=RWt3rSquaL8g5uJ39qXI5uc2exyEOmbfyjajcYKJMTqy1Dvq25YstnXFI9DLwHt87C
 YvG2fiuO0mKU3n4FKuBUnpoRwZO2ADkXrxKhxLNyRhRxrfkCkab6rf0jacZetT9aqTUN
 iVhLfa+Nelt4c/xkPB9ji0kMl5VzjBeYzY+I5ac1MqM0XW4OrE1hOgxmP3Nf9E5G4FK8
 phnqY3tmAeQRUhN4JixXckqhaMJtXYnVV7nxFWEuXo6xdrCsIMf9fzqzYIINgCoPViyf
 1F9M1SfJ3Y6QpCilPYkLHdAaTt49j2Leve8LmAigGz7EvQd1RdrKBMSQuxmXQqNUccS8
 LwEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793741835; x=1794346635; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TSUWwVydHQrYjn5zir+0+LXobOs3Q65VERna5l3bEbQ=;
 b=zqNyfpq+Wqp3JvS2R6hpTgSTcd8ext4KCBQUaArX3zb4i/P/37Sjq3eM+Q49KHYT0S
 Vd9AGHCkuO/4ebNJH9rpF0J6pQePPbTKHfm5Y+oGspZUL1nlfI7ixFv0hMzD6ltlGDxs
 /oZWAN4TY5A5nXGVx7UHmP0wNIcmS83nEJVx4V+pP5Ak3pzUyiqpDByiv4kBO7pIghgT
 1QdQwj9i7pxwbWyDXzTaX6DrLoSa/3VkGabJWQTwXZJlepfSsj61Mg6Jib40B/Da1ogV
 Jdq0QS+breAZ8oBdMw1RaEpsZVs3ktlaNMSpL0b4wCPp6EZWmJfMi80xlJUPIrzh8Fyl
 hPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793741835; x=1794346635;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TSUWwVydHQrYjn5zir+0+LXobOs3Q65VERna5l3bEbQ=;
 b=B1SMavfAPH6UCusxywXGTmPp4n57rdk6H0zY+caHNrgDHZIwJjjIWIZ3johntWLw9Q
 xHedWHZk4MvGFb7j/XVMHgpFrV8h6h0trlcLgv79jncXIz/wYtanOKryKDpRvGpI5yKM
 1MTR051IqRHqaCwOIRzW/S5FVV/2TAEypfBhesASJ8eQHlIirsvBOCUB9e8CLQIfVGJe
 dNIXgTnMcslXkTrRNjF5LbMlikWctWYUx3egS8im6QDxT2wI0bTlGduJTN9vbdXwXOMc
 lj3QY+pnHN05APIIzfmOUcECRmsfFyumWihEus9oJpofHo3iKinJ7UE5H0QhgYdhKamU
 rfrQ==
X-Gm-Message-State: APuU4Z8/LvaS22HWLkOaowUlyYFJVuDFBpYc/qf61wZlE7vFtjFSFH7n
 au+mFCRjcJGkTid5evaYeElKCelxewzkMTjvtlw1BkC41W2hOdORjoS+poZslxXTXlN0RGRK6xg
 faW25S5qunbexqM1whFeLAAQKrixNmgr+TT5vExXL8Q==
X-Gm-Gg: AYBFou0hFJdgAaKYz6CqCaYWr684T32tOmE8LXu1r3T7yUXB3mJ1An5x1gAKnZOdHLa
 AS+LUWxkmJr757rO2FOlv3+DI29lu24BAqFn73atV6D0pDwI7iTJ2rEEzj/jflJWTIsaBAEJlzZ
 n9TnQ42S2W/2KBfaVHF/8GRcIylsiILAjzbllRCDdbFP6wNpILyqwz2I7JObfmBffo2nudOPTsN
 L6bWho6Y9v6lpEZHcIdQziARi76WQNnhK54HDdqNmSy1C4J+n8z+owev2JAfrjKEg5yuBoXEvr1
 GS5v7vDW4Aorn1pQudH8eYo3sF9paVxWnib2egICHjfxzplAh77T9Bb6vk+a4qzLkF5wD9QXpx2
 toyIYiakYxBuoNdquSt56dyfZlaDCsar98vMggw2Ltl2xQgTTnkqM3CixZbvWKO6W061+SOFiIn
 bokeNxdczOh0GUQ/T9+JQuFLvRJS0QUICVdSzb3RiWlA==
X-Received: by 2002:a05:690c:e3c9:b0:8ac:8a2a:c387 with SMTP id
 00721157ae682-8b2b6751751mr75331607b3.66.1793741835313; Tue, 03 Nov 2026
 13:37:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103192559.297757-1-mondalankush9851@gmail.com>
In-Reply-To: <20261103192559.297757-1-mondalankush9851@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Nov 2026 21:37:04 +0000
X-Gm-Features: AclHuK_kThDuynStmeujoQrLP3knEEwK-X8Wkp8ASy3WrRR6R1vG2lel7JQZ6k8
Message-ID: <CAFEAcA_iWn1iGckLX1uou=nNzB9NfL9JpS8EuPazHS44eo9EvA@mail.gmail.com>
Subject: Re: [PATCH] disas/sparc: Use unsigned long for shift operation
To: Ankush <mondalankush9851@gmail.com>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, 
 thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 20:51, Ankush <mondalankush9851@gmail.com> wrote:
>
> The shift expression uses an integer constant of type int.
> When i is 31, the result sets the sign bit, and its
> conversion to int does not portably preserve the intended
> mask value.
>
> Use an unsigned long constant (1ul) for the left operand
> to ensure that the shift is performed using unsigned long.

We could mention that because QEMU uses -fwrapv this is
not undefined behaviour and won't cause us to produce a
wrong result.

> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2618
>
> Signed-off-by: Ankush <mondalankush9851@gmail.com>
> ---
>  disas/sparc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/disas/sparc.c b/disas/sparc.c
> index 5689533ce1..40c1164554 100644
> --- a/disas/sparc.c
> +++ b/disas/sparc.c
> @@ -2515,7 +2515,7 @@ compare_opcodes (const void * a, const void * b)
>       another, it is important to order the opcodes in the right order.  */
>    for (i = 0; i < 32; ++i)
>      {
> -      unsigned long int x = 1 << i;
> +      unsigned long int x = 1ul << i;
>        int x0 = (match0 & x) != 0;
>        int x1 = (match1 & x) != 0;
>
> @@ -2525,7 +2525,7 @@ compare_opcodes (const void * a, const void * b)
>
>    for (i = 0; i < 32; ++i)
>      {
> -      unsigned long int x = 1 << i;
> +      unsigned long int x = 1ul << i;
>        int x0 = (lose0 & x) != 0;
>        int x1 = (lose1 & x) != 0;

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

