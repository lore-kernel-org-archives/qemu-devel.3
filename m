Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F31C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 02:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmPcd-0008UY-7u; Mon, 18 Mar 2024 22:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1rmPca-0008T3-TG; Mon, 18 Mar 2024 22:54:36 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1rmPcV-0004fv-Pt; Mon, 18 Mar 2024 22:54:36 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c38b875a1aso780032b6e.1; 
 Mon, 18 Mar 2024 19:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710816870; x=1711421670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nm7Kk4CzPWmaV5HfOkntNZglV6jxDGCgaL98QUQsbQA=;
 b=Dvr8xGl8cEsGL2Wghu/taBqSZl+bN4liLhx3I810Fe8xjp3HgOP+tac5OBMjT6FKhC
 ExuJ7wnZhSoAW3J61uHZgPAQu3Eo511MoIJ0BUcRdtYuNH0sUP08HF3nEApnouLGrL1K
 GAV9CEHLhMX9106nJ4MsCKgnZsCrrdSYTEmEeEDHUGTbKV9nQfxIvsmathFDKU2Hs3nC
 7xUZwVDxUzDRBcEWySQg1mQdaVXSGg4lwKMGSPwt8RmC9Rd/yAePMmU4ZWxD9Il4nBiV
 UjTqb9E+Gu1LDaWD9WTDgVEmndMv0FEdM0X+FgPDJ1+NAXwXIj/H8wWRZd3OGc3crWGF
 YyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710816870; x=1711421670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nm7Kk4CzPWmaV5HfOkntNZglV6jxDGCgaL98QUQsbQA=;
 b=jkUQjwjlaS8KhdPgG1JSnSnOt7NxnzsBUGREeyzbXT8Vo03S8VgRk3XZ7LWCC0N19X
 wPERmZZr3KBDIWzuT4dh2busdL4Y2ll+zsb+u0ZIlB0zGPxXIJBtwIKJ4t6SlPN+8ujJ
 rl9agR00blTRZBftDEnCLz9jAsw32fwZl21nNddEwVwiA1hyZRB8lQTKP+s53gL3/wSb
 /mBLUPqoW1Q25ACFNhPEw985HvZXK17r5JjZ1LrDi1OKG1RpKympAsBuAoibCCkia2NH
 BcJPQy236QupzWdfmuc8tlINitY7hNENrM6NLjbNgj/6DBXVsPzza1e/Z1F6d1WgpFir
 8XiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX62EkdGJITzoxaH2DuU4QkNa7dn2G37+G2lo0xu/5btNHQlQms6MFyqQug2TDgx5zEB5MlTyNVeoj+8Ip9XlDn5fCDE3T+uVXTppS/bIm3yxnQrggffxJm/pk=
X-Gm-Message-State: AOJu0YxWVoynrfYMLdd3JhsqKePxsH1QK5284jgaoCqeA85T1xJLz9Ow
 Nj/r18yhh/PS1wiEuucRUXuxGmFqInuw81E1iIfXnJU4a+WA/DKv
X-Google-Smtp-Source: AGHT+IH2K0YLQr9U9B2+/vvyZOP6fxCIy7trQorEdzntP1DZpVnJnwe+N5Ac1j2brj+QxVNq45Gv4A==
X-Received: by 2002:a05:6808:20a9:b0:3c3:7434:78be with SMTP id
 s41-20020a05680820a900b003c3743478bemr14148895oiw.27.1710816870069; 
 Mon, 18 Mar 2024 19:54:30 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a056a001b4800b006e68bff396csm8605735pfv.215.2024.03.18.19.54.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 19:54:29 -0700 (PDT)
Message-ID: <954c07cc-7894-44a6-b6d4-bde1460a4391@gmail.com>
Date: Tue, 19 Mar 2024 11:54:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 1/3] ui/console: Introduce API to change
 console orientation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20240318113140.88151-1-philmd@linaro.org>
 <20240318113140.88151-2-philmd@linaro.org>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20240318113140.88151-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2024/03/18 20:31, Philippe Mathieu-Daudé wrote:
> Extract the following methods:
> 
>    - qemu_console_set_rotate()
>    - qemu_console_is_rotated()
>    - qemu_console_get_rotate_arcdegree()
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> ---
>   include/ui/console.h |  3 +++
>   ui/console.c         | 16 ++++++++++++++++
>   ui/input.c           |  9 ++++-----
>   3 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index a4a49ffc64..86ba36e391 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -422,15 +422,18 @@ bool qemu_console_is_visible(QemuConsole *con);
>   bool qemu_console_is_graphic(QemuConsole *con);
>   bool qemu_console_is_fixedsize(QemuConsole *con);
>   bool qemu_console_is_gl_blocked(QemuConsole *con);
> +bool qemu_console_is_rotated(QemuConsole *con);
>   char *qemu_console_get_label(QemuConsole *con);
>   int qemu_console_get_index(QemuConsole *con);
>   uint32_t qemu_console_get_head(QemuConsole *con);
>   int qemu_console_get_width(QemuConsole *con, int fallback);
>   int qemu_console_get_height(QemuConsole *con, int fallback);
> +unsigned qemu_console_get_rotate_arcdegree(QemuConsole *con);
>   /* Return the low-level window id for the console */
>   int qemu_console_get_window_id(QemuConsole *con);
>   /* Set the low-level window id for the console */
>   void qemu_console_set_window_id(QemuConsole *con, int window_id);
> +void qemu_console_set_rotate(QemuConsole *con, unsigned arcdegree);
>   
>   void console_select(unsigned int index);
>   void qemu_console_resize(QemuConsole *con, int width, int height);
> diff --git a/ui/console.c b/ui/console.c
> index 832055675c..84aee76846 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -37,6 +37,7 @@
>   #include "trace.h"
>   #include "exec/memory.h"
>   #include "qom/object.h"
> +#include "sysemu/sysemu.h"
>   
>   #include "console-priv.h"
>   
> @@ -207,6 +208,21 @@ void qemu_console_set_window_id(QemuConsole *con, int window_id)
>       con->window_id = window_id;
>   }
>   
> +void qemu_console_set_rotate(QemuConsole *con, unsigned arcdegree)
> +{
> +    graphic_rotate = arcdegree;
> +}
> +
> +bool qemu_console_is_rotated(QemuConsole *con)
> +{
> +    return graphic_rotate != 0;
> +}
> +
> +unsigned qemu_console_get_rotate_arcdegree(QemuConsole *con)
> +{
> +    return graphic_rotate;
> +}
> +
>   void graphic_hw_invalidate(QemuConsole *con)
>   {
>       if (!con) {
> diff --git a/ui/input.c b/ui/input.c
> index dc745860f4..951806bf05 100644
> --- a/ui/input.c
> +++ b/ui/input.c
> @@ -1,5 +1,4 @@
>   #include "qemu/osdep.h"
> -#include "sysemu/sysemu.h"
>   #include "qapi/error.h"
>   #include "qapi/qapi-commands-ui.h"
>   #include "trace.h"
> @@ -179,10 +178,10 @@ static int qemu_input_transform_invert_abs_value(int value)
>     return (int64_t)INPUT_EVENT_ABS_MAX - value + INPUT_EVENT_ABS_MIN;
>   }
>   
> -static void qemu_input_transform_abs_rotate(InputEvent *evt)
> +static void qemu_input_transform_abs_rotate(QemuConsole *src, InputEvent *evt)
>   {
>       InputMoveEvent *move = evt->u.abs.data;
> -    switch (graphic_rotate) {
> +    switch (qemu_console_get_rotate_arcdegree(src)) {
>       case 90:
>           if (move->axis == INPUT_AXIS_X) {
>               move->axis = INPUT_AXIS_Y;
> @@ -341,8 +340,8 @@ void qemu_input_event_send_impl(QemuConsole *src, InputEvent *evt)
>       qemu_input_event_trace(src, evt);
>   
>       /* pre processing */
> -    if (graphic_rotate && (evt->type == INPUT_EVENT_KIND_ABS)) {
> -            qemu_input_transform_abs_rotate(evt);
> +    if (qemu_console_is_rotated(src) && (evt->type == INPUT_EVENT_KIND_ABS)) {
> +        qemu_input_transform_abs_rotate(src, evt);
>       }
>   
>       /* send event */

