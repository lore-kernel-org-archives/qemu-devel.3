Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60920606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hHt2xRHf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKLIR-00057R-1C; Fri, 23 Oct 2026 15:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xKLIP-00056O-5R
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:51:21 -0400
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xKLIN-0005Hp-G2
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:51:20 -0400
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-35b2c599f43so2859252eec.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 12:51:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792785076; cv=none;
 d=google.com; s=arc-20260327;
 b=KGFYJSS6nS9nAO0MXgH11nQhHPAwBVG2zXcb7I32nrypzSJPSn+3wrNMm8JatHpOU7
 yE0jgRU20QB4sCqjCXA1TMw+jPF1Ck71ZOaJvjTzbvhWRMg7Wy7doCpPEwHsOcC2ssYS
 s4O+3kcUsvIsBf0takxrWCHVZ4x2AZhimbk43xbaAF6jv+ZvVZydJlj1L+qTqgpCbPh/
 BWI8VtBccPUmwk87XcgxzppKgU6PDvU0eigNVvLd0t801+AptFkYss5c64e4PXCjIo5K
 s/3NBWNNLjF0C6AWDpBuy7MEZj6zk0T/2yh0heBgbdQQiHqlPgh5ymOTGSaDiESf5mZ4
 UCXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6luzpgGM/422WzIvYdBO3Tdtfm/bkyHsLVYD2AfTqgI=;
 fh=cOsNULT/G3KmuphHDOpmhJ0EqPaEyNDPfyDGSK/csWI=;
 b=QYS4hzeLP3Uj36BMgek5ozMFD2A0H+vivt7q3lZaeghqW/F/Yx6iJkJomwrbcryxym
 o9zH9R+e9iybDCfxE5r9XJf7bjjfx0+6fXE2wm4hK43SRQLXodEZh4kCEP/b3DAMs2OF
 l9RUZMpdqDTQ4G7gmBryeYal87Tik0UdIZfhdrlOfdxscg+79RXsMjeqkeBwmhLmGCj4
 tjoNpN2BmrbMMXiycq+V5B0ZhAjbBRtNcgjcdxVKldyYrlhfAQ0TMJ71MtbBI+CzL7jR
 C+y2CUN6W0RywP8W77MoeYliX1R3peYgijjLMmWjZmG6rZlAluiEUyHrw8AFlxUweqbw
 OSAQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792785076; x=1793389876; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6luzpgGM/422WzIvYdBO3Tdtfm/bkyHsLVYD2AfTqgI=;
 b=hHt2xRHfaRZfh9W3Pe5ZBtcYs55sfbvq2Rna9KA9c2Y9BKyK1SqcnJ+q/sOE3t4n4y
 7C/tm3F7dTh8X6ekjVaDoLCJ9McYo8kbauY5NdJMhY138LDosjuSIqcAoSw7v40gNd97
 gAo55HTriSAcVo4wRJt+0rWfGNGbb8sPZpbXQ+SlU3rytMVtzPEXmlLBv8f6FNuJeV7L
 ogFerZxIBmtRqfb0ioAvHaeCko9dgqH0MC0Cpyy9WllXCGwpleZqTmHUhK3edj9u6dVY
 wcyRgmINbO/IuGYB04vM72np5ZDa0IRl8Pvw3xZPkfgxeRJrNONGobpfbs1HyJ07Sih8
 RKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792785076; x=1793389876;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6luzpgGM/422WzIvYdBO3Tdtfm/bkyHsLVYD2AfTqgI=;
 b=ahvH5QyWHc/SWMWDd8itKXnLuDRuxLaT/YOX/vz8Ac5Us9phUtq89y7dbcg2hxbphr
 MQlCmMYpAcb/u8n2zEzcdBFOJLcEb57yiys3wro5tEx9ppY2vuvE61DkvEDdKOytspms
 fInqdOcmqURRFHLqFcKgOz3llWassbvHzoA30lsMiPw0dFBT+j4NpYi9lgROAjXw7SEG
 qejMONp34PjVwwFljlFrVzEAp8/5rl3JNi2K0oZeeb4i/Za29zYvUEYZ0xMr6VuqZ89d
 tVpMar4J2DH5zoGakodxBOlKhuLz5E8hSe4NvFewD+GRCd/8SGcCDKfimQeHUjVofcVL
 oE4A==
X-Gm-Message-State: AFq9FYIn6+SuwdhWHQ2gVHUrfa3G/RSmj/9gGWKX45vZT6tpiLZor1YN
 N7d4N9SDBzJZlqBiTi+G2NcyPi3VA8cMfaWmtdPrRo1n/b1zIqBAhi+ADSdpmVFeUfOXUh2iU+V
 tOqOMki6IL3ZibhI0AVJBMlbxPOPgV4Y=
X-Gm-Gg: AYBFou0FQMxrZvBfJmXCcJv+CsYesyHPf5IVcBIBXck81sKqAmt7Au9a+yupt17nT4G
 /kPyX3nfcyIT9ggMaj9F8VGFqbjcL1/bugc8eho4ZdgLgZwXy/IiZtTirXwm4T6Yt5N7cG7CUH6
 oN2JwZALROP+gItRxIE1iXHvrpxKLWcJ2AMyVtB/8GoaBO7OD4H7azsxlfLmMpCUZqCAeT0fl5T
 WPtoD1gFe+yVsF4iqTsrETpyF1C04YJYQmohaaZk0YLil9daE5pv6ei+MBoySs7+WfGKlsEI0oq
 Fh5Zv9FeiGMb9xoMCzzCJ4Sgf7USmAdUVn53kzyZbMLCSaK5SXTBJFRcid11QZ2mWo+n3s3UMqN
 ZS4QVFvjIAUYihC3hzro6vzM4xct6PlxT6uj44Lp09RKqRQl99wS9EfngyHlyhF9LoR5B6bWEou
 7swX9MObZlqPZIjQ==
X-Received: by 2002:a05:693c:6209:b0:366:83dd:46f3 with SMTP id
 5a478bee46e88-369e84596b9mr477967eec.14.1792785074689; Fri, 23 Oct 2026
 12:51:14 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022193944.19266-1-dongwon.kim@intel.com>
In-Reply-To: <20261022193944.19266-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 23 Oct 2026 23:51:00 +0400
X-Gm-Features: AclHuK-_L0g-axSB07HbrEApF1QCeF-Rs1BK4AI5FfZ-PydLO6MJtmEcTtYLxZc
Message-ID: <CAJ+F1CJx5eo1wygivoTmMpHTU-F+9F9XzYC0tA85R4YRi-RuVg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] ui/gtk: Hotkey and fullscreen handling fixes
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1335;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1335.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi


On Thu, Oct 22, 2026 at 11:41=E2=80=AFPM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> This series resolves several issues regarding keyboard shortcuts and
> fullscreen behavior in the QEMU GTK UI.
>
>  1. Detached (untabified) windows properly support fullscreen and zoom
>     accelerators.
>  2. The "Grab Input" accelerator remains functional in fullscreen mode wh=
en
>     the menubar is hidden.
>  3. Initial fullscreen setup is deferred until the window is properly
>     realized to avoid display configuration race conditions.
>
> v2:
>  - Return TRUE in accelerator callbacks (gd_accel_grab_input, gd_win_*) t=
o
>    comply with the GtkAccelGroupActivate prototype.
>  - Restore scale to preferred_scale and trigger gd_update_cursor() on
>    fullscreen exit.
>  - Deduplicate zoom handling by sharing gd_win_zoom_* across menu actions=
.
>  - Guard zoom helpers against NULL / non-GFX consoles.
>  - Remove leftover debug fprintf in gd_win_grab.
>
> v3:
>  - Add gd_is_full_screen() to query GdkWindowState directly and replace
>    s->full_screen checks across attached and detached consoles
>  - Keep zoom_fit_item deactivation in gd_menu_zoom_* while keeping
>    gd_win_zoom_* focused on per-VC scaling
>  - Restrict global free_scale handling to attached consoles so detached
>    window geometry is not overridden
>  - Use gd_is_full_screen for full_screen check in gd_window_map_event
>
> Dongwon Kim (3):
>   ui/gtk: Enable fullscreen and zoom hotkeys for detached windows
>   ui/gtk: Register "Grab Input" shortcut to accel_group
>   ui/gtk: Defer initial fullscreen activation until window is mapped


Something went wrong with your v3 series, some patches are v3 or v2,
or no version. Can you send it with b4 with a consistent version?
thanks

