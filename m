Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CC0FD8FE0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 17:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vveqY-0005X5-S4; Thu, 26 Feb 2026 12:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vveqW-0005Wl-O5
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:08:17 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vveqU-0000JX-7b
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:08:15 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4837907f535so10462245e9.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 09:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772125692; x=1772730492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cJ6QuEyaXLd8/OOc/Z0fAYJuC3JNh5cCwzxGRUoPfxo=;
 b=ZKeGZnCY+XdmEcD/GjET83CKx1Gg4m1REnM9gLT2xPyeBgpxNuRDuBjSDVMlAKvoNB
 hbvwbJri7jDhJPaK2H3vU6JPM7kULQySvZ3EGp0vhZpkiTZBkg8rbPjLlVDC9sYQtrQk
 tK4aQw0FsIhBQPxqtGPywIooxT7Rx5egKPpqsl6jMo/DQfuehfNYWloEFzSPH7WhA47G
 luJNCfQ0c15gNbDj41eoS1NOvMBGmRuDsKgWz+XiQO34/AeBZxCqI0Z1eL59Xh9rN9fR
 x462pC6pmNAUcTQd/l9rIzkZbjTYzTGI5brH9S6quOGLRMGg+tdDRKdhz5dA4YWQj+Oq
 cR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772125692; x=1772730492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cJ6QuEyaXLd8/OOc/Z0fAYJuC3JNh5cCwzxGRUoPfxo=;
 b=eHgvSM/Vm8KbkS25v2GekobynDvF0LJdlHCFzHjmcLlPc/F/KLQExR2nVOlQAnYz3f
 iCZ+fbIVWou/bnrpFghJs/6okmEQYb98qZzj/YreyThMga3K70rKnN15mR2Wu3O1uapZ
 dRs94I4tSEVeoMdEVktWpFfghXipwxwP9DZtVNpeXKZW+JWoipA4DodpP9J/3cT3iJBC
 cF1LB075Ixh0W80VIux+UTU5d+7/0e5q0iw0ZLOmNqh4OLqIkLQnRmwNy3eojOEhAPdb
 qeZ/HY7iqKFWcU48d8x/5zGwUILN/To9Y8IxA1+B+J3vvhrPUPKaeuyHDG54kom1SK6T
 FMRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY9zt61+9JnQkWK1TzMd53SIO9e2culyG/4pbdzmgewfrgnmvtqWz0hYNvJN4+daww0w08RDv20rOP@nongnu.org
X-Gm-Message-State: AOJu0YyVhWnz/vQCrvD7Fm6QO26f6FrQrHofTxgWZg5VWrQAHwSkvVRR
 C74+cePPHmU5ZeiMNQm9JiOMI39ySDiiJ5vMaIs64IIGzLyob2TJiphkNp96x1DEjAM=
X-Gm-Gg: ATEYQzzQbYkkLv8CYSIvEYPSToJOIXbGY9winnrM0MBjmc7gEh6uyyyvAafTvBx0Su2
 Fcv5vsz//Q0D2gmY/8E5D5Awo/vVjKUaNO5b3hiY3Crj+r4qzNOrONOfp+ij9rkUvfvZClb+oWR
 zci2rgxKxpzNo9J99+l0qfksaig3Z2JJZlNAbtXzp1jff941mt2+KYF9bijgMLuUvxmlDTCal1q
 dDpq4ZKGzkvYtbBNHQqyHS3ji0M0OFoIJcB6KEiz79MJWZASukX/DKWyEXqgbtJ0LVSS3w+NI+y
 KucZTMnm7f2YcLIEzFn4RJvV4Q/rMX5zFQ7J7KBOMnbMDYOymaylZdPFBF7qJo3PMAler6pl91m
 t6mvjmP7xqdxE7hXGvuE+4sLcouVWrs3cRTosdlltRNbSkvaoSRGEehR5zD3wfPdWkpfeHP9IJm
 CCDXvU6ncsKZlXNMm5N8S8hVdKtEovcsvht4ujyMciXXDCh98/cl7odb54Hitr/uTF3w==
X-Received: by 2002:a05:600c:8a09:20b0:480:69ae:f0e9 with SMTP id
 5b1f17b1804b1-483c89b4949mr13070545e9.16.1772125691955; 
 Thu, 26 Feb 2026 09:08:11 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfba9a5esm97270375e9.4.2026.02.26.09.08.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 09:08:10 -0800 (PST)
Message-ID: <de38bb8a-91d5-4088-83bf-0730d3aa3d56@linaro.org>
Date: Thu, 26 Feb 2026 18:08:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] machine: add "acpi-watchdog" property
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, zhao1.liu@intel.com,
 rad@semihalf.com, leif.lindholm@oss.qualcomm.com
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-3-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260206131438.1857182-3-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Igor,

On 6/2/26 14:14, Igor Mammedov wrote:
> It will be used by following code to enable ACPI watchdog.
> Initial support will bring it to Q35 and arm/virt machines using
> respective iTCO and GWDT watchdogs as hardware backend.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   include/hw/core/boards.h |  1 +
>   hw/core/machine.c        | 20 ++++++++++++++++++++
>   2 files changed, 21 insertions(+)


> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 6411e68856..4ca808fb73 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -499,6 +499,20 @@ static void machine_set_usb(Object *obj, bool value, Error **errp)
>       ms->usb_disabled = !value;
>   }
>   
> +static bool machine_get_acpi_watchdog(Object *obj, Error **errp)
> +{
> +    MachineState *ms = MACHINE(obj);
> +
> +    return ms->acpi_watchdog;
> +}
> +
> +static void machine_set_acpi_watchdog(Object *obj, bool value, Error **errp)
> +{
> +    MachineState *ms = MACHINE(obj);
> +
> +    ms->acpi_watchdog = value;
> +}
> +
>   static bool machine_get_graphics(Object *obj, Error **errp)
>   {
>       MachineState *ms = MACHINE(obj);
> @@ -1257,6 +1271,12 @@ static void machine_class_init(ObjectClass *oc, const void *data)
>           NULL, NULL);
>       object_class_property_set_description(oc, "memory",
>           "Memory size configuration");
> +
> +    object_class_property_add_bool(oc, "acpi-watchdog",
> +        machine_get_acpi_watchdog, machine_set_acpi_watchdog);
> +     object_class_property_set_description(oc, "acpi-watchdog",
> +        "Set on/off to enable/disable ACPI watchdog."
> +        " Default: off (ACPI watchdog is disabled).");

Should we check for CONFIG_ACPI somewhere?

>   }

