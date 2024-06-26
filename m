Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEEAC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 17:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMW65-0006qA-R3; Wed, 26 Jun 2024 13:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMW64-0006pw-J3
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 13:06:16 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMW63-00079o-0U
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 13:06:16 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-366de090da9so3197340f8f.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 10:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719421573; x=1720026373; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=inE83XdkTpfJZ2qFl+V3HYw0FLo/roOl5wWMzFlDjEI=;
 b=a9hdTHvMb7u1nGzOI/cfLfqkhYYiIFXv8bZs9f69SBQRdl5sT4sNYLOtAqY3UM0yvD
 y5HQqIfNrUlfzdBYGyIEUavxFp7rPDKU67OMD/bHxW4uPmu/Zgm5oBlrhnWVtWUKgVT2
 sLdI98IKgFKPhwgROCNTDDLMHvaMnzMVXIIOVA0NYDxZHXvwBS+n5EGhFbtHOFluFpuN
 ywM7bbeaNv+Bpn9xPPIP0VGXm83aOq+laY6MiGJs7DtJoWIP+XxmLrPRk6gUt6nR5arp
 JqKW7Xuyerauk0Vrx6c6cyQItyBec8NpSrIPFzMAJ3PYSfJ7JB03tq1eqMA39lQMlEAl
 c8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719421573; x=1720026373;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=inE83XdkTpfJZ2qFl+V3HYw0FLo/roOl5wWMzFlDjEI=;
 b=Ltji32ljMLf7BOCpWCl+NeHg0hVEm/9HTLmuJnPOwt1gKW0/EWGq1uW+gx3Th2u0rr
 Z2ZngKxnIJjP+jk91LwgM+4WzIOZGL5NsZdN2fRbDweTUv194Ry2spNWxSdH1d+NONSb
 gqISShE9X0PqufekL9j/QG5rzWUlrKT9ya2Qf5N5dx+BcQULUSQr0xJRvwEwQ1NayVlB
 AXvaGJBjKOqPOzFX8X1GxNNYbaXiV6j60b2wUBtGdFmVMnFfx+ljj6iPdWoi3Zkt+6yu
 9CFMKPRoIeMt40kPlAq9RJnM1y4XT1084Enu30Wc46A43Wb1uht8aDixPExccB5DXIsp
 CI+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6J0YB09Jr/2VTPKo7YfsPi/O4KmF96wd2Hezz1azCqz7yDvlO3xPa9M5svuEHvr3D76BXUCEUTZXM+YsXxSA2cgjYNho=
X-Gm-Message-State: AOJu0YypxGhqTWy3LoTATNbhjnvXIMzZZb04AN/wSlkNEhJE7yOMfjUC
 0xmV1WDF0X/ePwtfL3Igk6GxqydZ6JQhAw8OZ7hkB57tpN/alsxCMI+Wkfs386lxftxv2sVA8kI
 O
X-Google-Smtp-Source: AGHT+IGJFn802s0OWlIomec24jvR+as30k2gnZuYERilV7TldOV/QAtO9g1ia1hYXKNCWm+L0WSDqQ==
X-Received: by 2002:adf:f083:0:b0:363:74a4:2ac4 with SMTP id
 ffacd0b85a97d-366e94d5ac7mr6157105f8f.40.1719421572922; 
 Wed, 26 Jun 2024 10:06:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.234])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36730236a59sm1522499f8f.45.2024.06.26.10.06.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 10:06:12 -0700 (PDT)
Message-ID: <0399c37b-e4cc-441d-874b-ba3feb537dc4@linaro.org>
Date: Wed, 26 Jun 2024 19:06:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/gtk: Negative Page number is not valid
To: dongwon.kim@intel.com, qemu-devel@nongnu.org
References: <20240626000835.248538-1-dongwon.kim@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240626000835.248538-1-dongwon.kim@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Hi Dongwon,

On 26/6/24 02:08, dongwon.kim@intel.com wrote:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> Negative page number means the page with that number does not
> belong to the notebook so it shouldn't be used as a valid page
> number in gd_vc_find_by_page. This function should just return
> null in such case.
> 
> This change, however, will cause a segfault during detaching
> /untabifying process in gtk_release_modifiers because the
> current VC's page number suddenly becomes '-1' as soon as
> the VC is detached, which makes gd_vc_find_by_page return
> null. So gtk_release_modifiers should do the null check on
> VC returned from gd_vc_find_by_page.
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>   ui/gtk.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 93b13b7a30..1f8523fd81 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -164,7 +164,7 @@ static VirtualConsole *gd_vc_find_by_page(GtkDisplayState *s, gint page)

The caller should check gtk_notebook_get_current_page() != -1.

We might assert(page >= 0) here.

>       for (i = 0; i < s->nb_vcs; i++) {
>           vc = &s->vc[i];
>           p = gtk_notebook_page_num(GTK_NOTEBOOK(s->notebook), vc->tab_item);
> -        if (p == page) {
> +        if (p > -1 && p == page) {

Then this is not necessary.

>               return vc;
>           }
>       }
         return NULL;

I wonder about returning NULL, maybe just

        g_assert_not_reached();

> @@ -357,7 +357,7 @@ static void gtk_release_modifiers(GtkDisplayState *s)
>   {
>       VirtualConsole *vc = gd_vc_find_current(s);
>   
> -    if (vc->type != GD_VC_GFX ||
> +    if (!vc || vc->type != GD_VC_GFX ||

Then this is not necessary.

>           !qemu_console_is_graphic(vc->gfx.dcl.con)) {
>           return;
>       }


