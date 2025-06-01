Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D6DC5B552
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 08:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLdzJ-0002R6-KX; Sun, 01 Jun 2025 04:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uLdzI-0002Qq-2U
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 04:24:12 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uLdzG-0005CN-Bi
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 04:24:11 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ad55d6aeb07so522121666b.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 01:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748766248; x=1749371048; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MGRiNezikHlSH9dQNMu6ohKB/xcUBur2Fa+qu3GhHp8=;
 b=LqxsH4OxXD9O2F1Y8G/dJVx/IG0zD6rGkofEDaiTN9HLtno82RhmDrbjV4uO4sbgEx
 cdF2tWC4uYVr7AHCzAXWlBvswAjIM9QghSbmtcJBf5IPmp8wVbkI/ZOBiLej4nGb+tbr
 fUM/gfk+KImSOaWmmTw4dlYfdwi31x2Ss3fkhfzxH70q+Nj5nGYdn8cbDb4dc6u2KbJa
 zpOhd4xv7RqdC0CWO5Gam/rcCtDspLbgXczAckH7NTYbd9Bv+AvAgswyGtalTAUA4jM0
 2IGeNhlbjL74U3suQtsmrNiPyp3ZTR0Z0nQav8E6cC+Z5yoqzS36hBLygsSOprepMFJM
 HTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748766248; x=1749371048;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MGRiNezikHlSH9dQNMu6ohKB/xcUBur2Fa+qu3GhHp8=;
 b=I+94nDfzY8FriWmqL7WQP+DnaOXjee+GoOacbKnBCBOmb/LqUdah5K4uAVaE48McPc
 WqeMaMlFKVB+ZlnXi22yWoPbwa7l7TOlCRJwwpgRkbb0E8kgf0nKkKU+Rnump4m6Rfqa
 ef2XO89m1DW3qjnjnRzp954nqUkFUp61xhjI2M+EmDtR8GS0JQN7lnWbIPe9asDdS6A2
 p/PpOfLQieAQlNKq2GPlr/8oIuKFWRjDoCsq1X1sUdIzxesI0cG4MCiZ+gAi4R5Hef0F
 ytyh3fULbRUV4R9LUvDxmyLDV9cJNDXNBHw2qI4rFZL6gmv2TAvU4XMGBu/0LKLLEeu2
 iB7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiw++3GyOOtxGnVO+CkHhuoxmrbUVINbc+7Ig9OJePjQF/mXS8QPuj0MWfR9ajXkf684toG7VErcON@nongnu.org
X-Gm-Message-State: AOJu0YwZ1J3zGDmMh1E+8sPXPqqdzLzgX0lsMgOR+3rXUl4vKd2CAzKv
 RbkKT/0E0TZJridwBZGME6DFsntc48Z1vRobWWVWEd/p72BzJN9LKRNx/Eie+GxSpCOmq6NrdHA
 HFV1R04c+dGtN0PIrdQmlC6Fc/PD+zy4=
X-Gm-Gg: ASbGncuYOpqCN8v9GxZg+0375a2c8H7hE1ljsbCTxShyndEE/sdyljrOOcLNKbBUmKH
 uJntGQjkl4XsWiIpqt6Tta4rlO5fl722b5puafy5aP/AngS6sJ7muciOx71Pv8mEJO9AIFDFCze
 zbTtLjfoiWnyoiHymtZKQtnE+y7kfM2iHHFGCAFXyTMXXr
X-Google-Smtp-Source: AGHT+IE84dwwg3DV1WO3y7Cogu2vZkOMM4NeR7NkXtV7jsy3/72zBKYW4UIjj/HvpIL++b0rdoo5LObrWuNkMIuq90Q=
X-Received: by 2002:a17:906:478d:b0:ace:5461:81dd with SMTP id
 a640c23a62f3a-adb36b05802mr805613266b.3.1748766248301; Sun, 01 Jun 2025
 01:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
 <19542757-ecc0-4eb5-b26c-4a06f7f800c3@tls.msk.ru>
 <0790819eab97fbc5728f583b6ec90e338c2819e0.camel@gmail.com>
 <8a78195f-583e-442f-8d0a-41753c70e584@tls.msk.ru>
In-Reply-To: <8a78195f-583e-442f-8d0a-41753c70e584@tls.msk.ru>
From: Weifeng Liu <weifeng.liu.z@gmail.com>
Date: Sun, 1 Jun 2025 16:23:56 +0800
X-Gm-Features: AX0GCFvitzApRwSykmHZB9VHm7W9KCUsW7Wy6eZVykf-dYHfGqINSJruWgQr2Uw
Message-ID: <CAGZJSh-BX1WGmWYhau7qm9MrL8c3Hp7qTvxLGfbKCABG5dEe2w@mail.gmail.com>
Subject: Re: [PATCH 0/9] ui: Improve scale handling
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dongwon Kim <dongwon.kim@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/30/25 6:56 PM, Michael Tokarev wrote:
> On 30.05.2025 09:39, Weifeng Liu wrote:
>> On Thu, 2025-05-29 at 10:23 +0300, Michael Tokarev wrote:
>
>>>> PATCH 3 - 5 fix bugs in mouse position calculation due to not
>>>> handling
>>>> scale properly, for both gtk and sdl.
>>>>
>>>> PATCH 6 align scale update logic in gtk-egl with other
>>>> implementations.
>>>>
>>>> PATCH 7 fix an issue that gtk window might keep enlarging/shrinking
>>>> because
>>>> ui info propagating to guest not considering scale.
>>>>
>>>> PATCH 8 and 9 align fixed-scale mode behavior in gtk-gl-area and
>>>> gtk-egl with
>>>> other implementations by adding appropriate padding to the window
>>>> to preserve
>>>> the scale.
>>> ...
>>>> Weifeng Liu (9):
>>>>     ui/gtk: Document scale and coordinate handling
>>>>     ui/gtk: Use consistent naming for variables in different
>>>> coordinates
>>>>     gtk/ui: Introduce helper gd_update_scale
>>>>     ui/gtk: Update scales in fixed-scale mode when rendering GL area
>>>>     ui/sdl: Consider scaling in mouse event handling
>>>>     ui/gtk: Don't update scale in fixed scale mode in gtk-egl.c
>>>>     ui/gtk: Consider scaling when propagating ui info
>>>>     ui/gtk-gl-area: Render guest content with padding in fixed-scale
>>>> mode
>>>>     ui/gtk-egl: Render guest content with padding in fixed-scale
>>>> mode
> ...
>> I think the first five patches are good candidates for backporting to
>> the stable branches, as they only address bugs without altering
>> existing behavior. [...]
>
> It somehow feels like *all* patches should be picked up, not just first
> 5 of them :)  BTW, the first one (Document scale handling) does not fix
> any bugs ;)
>

Great! Please apply all these patches to 10.0 branch. Let me know if
there's anything I can help with.

Best regards,
Weifeng

