Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC432C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 14:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3zJ6-0001va-Ma; Mon, 06 May 2024 10:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3zJ4-0001tb-CX
 for qemu-devel@nongnu.org; Mon, 06 May 2024 10:27:06 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3zJ2-000755-2Q
 for qemu-devel@nongnu.org; Mon, 06 May 2024 10:27:06 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41bab13ca4eso13026215e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 07:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715005622; x=1715610422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=raJv2AHp/sUn4z0gfIWOtnawg3sVbkLoHyT1lDjf5oI=;
 b=agDiga6vGRXdUFMwbTrRLFegAj/70m4i++xp7BPOKsRwLBakjSsLLCKgxveFuE5hGX
 6BDPnNOwIigCfvqdlqspWYujfR5D6TfqQSf/VMZGCASJKhH5ZhB0FIKNOBrxvISKQwNK
 pAD1lplj5I8ZBiqY+WOlWHrL1hO4h9ncIPggXepoQZANlJusCoRhstLR9FL973BwDNnz
 G1r/lFXUdyZ/TdJJ9Ctr+11mMRjHMD3/EYnpL6jouOwtMxkkElc1kN1TN+9SD+kSkG47
 1MVTvApp7q+z6YbMpFFNlnH6lc4r4HUOGBGEqmBQkKwHCVki+tXaWQ7SbyVVfh8RBnMb
 QSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715005622; x=1715610422;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=raJv2AHp/sUn4z0gfIWOtnawg3sVbkLoHyT1lDjf5oI=;
 b=feTKM1VvTer183/DPbo7Z7OirZFz5x7XSJsNNyYa9ZkMsVRoXUhNmp9gdfmJPzAi9Z
 mxHG1d4ieS59VnX9e32mDp2m2nHXG+VwWMB9WEQIu2ywOjKFmdWs/PrOb+OhGUtkdeyr
 XljpSBa2SoE0cR2hE+o8t+TrKD7Ww5G7IZ1xca1l2aMutdE0TJ9zigiqoypoxsBWUv24
 kEynk429MYOSWk6ZC0EeeEfWBdO2d/+xDxY1Elr3UHgrBV6f02tRDkWbNF67wsZCOqGY
 YNt28hbIbiBHh7hqaWk4Azl7dwNmBdTv959fjsUGLM6EW8TtD9aU9Il1DOuOTRpvuN8/
 33Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYUxHSc2H8wXGEIWN33Bm7F1C20jaO/ck6oDXGkKuE+QhXrjznkM1AZuxEFJfhEXRdmnDIxLmt+TrT931Wuy0eGv6zNpM=
X-Gm-Message-State: AOJu0YwqfaoLkIu8e6Euro5uq45GB4jzBCR8FYForq771LcONq9i2kFs
 IV2ziXMWbyJ80aEUKZ/g0M6Dn12QmsGOaPy2bz7NMfeWKGbfBLyliiJ/Cylvk1g=
X-Google-Smtp-Source: AGHT+IHgS86UpD9xppMA55Txe66wDBm9r+PC1VH3O5ttQA/5b3cxZNIRXGgk7Wbcd0+CoinTIJjlMw==
X-Received: by 2002:adf:e38d:0:b0:34a:e2c4:db1f with SMTP id
 e13-20020adfe38d000000b0034ae2c4db1fmr7354790wrm.7.1715005621975; 
 Mon, 06 May 2024 07:27:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a5d59a3000000b0034def22f93csm10898700wrr.69.2024.05.06.07.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 07:27:01 -0700 (PDT)
Message-ID: <e526e8b9-67fe-4db8-97c3-df2395cd04c2@linaro.org>
Date: Mon, 6 May 2024 16:26:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/i386/pc: Allow to compile without CONFIG_FDC_ISA
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Miroslav Rezanina <mrezanin@redhat.com>, Bernhard Beschow
 <shentey@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20240425184315.553329-1-thuth@redhat.com>
 <20240425184315.553329-2-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240425184315.553329-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi Thomas,

On 25/4/24 20:43, Thomas Huth wrote:
> The q35 machine can work without FDC. But to be able to also link
> a QEMU binary that does not include the FDC code, we have to make
> it possible to disable the spots that call into the FDC code.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/i386/pc.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 08c7de416f..93c48f6747 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -439,16 +439,19 @@ static void pc_boot_set(void *opaque, const char *boot_device, Error **errp)
>   
>   static void pc_cmos_init_floppy(MC146818RtcState *rtc_state, ISADevice *floppy)
>   {
> -    int val, nb, i;
> +    int val, nb;
>       FloppyDriveType fd_type[2] = { FLOPPY_DRIVE_TYPE_NONE,
>                                      FLOPPY_DRIVE_TYPE_NONE };
>   
> +#ifdef CONFIG_FDC_ISA
>       /* floppy type */
>       if (floppy) {
> -        for (i = 0; i < 2; i++) {
> +        for (int i = 0; i < 2; i++) {
>               fd_type[i] = isa_fdc_get_drive_type(floppy, i);
>           }
>       }
> +#endif
> +
>       val = (cmos_get_fd_drive_type(fd_type[0]) << 4) |
>           cmos_get_fd_drive_type(fd_type[1]);
>       mc146818rtc_set_cmos_data(rtc_state, 0x10, val);
> @@ -1132,7 +1135,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
>       int i;
>       DriveInfo *fd[MAX_FD];
>       qemu_irq *a20_line;
> -    ISADevice *fdc, *i8042, *port92, *vmmouse;
> +    ISADevice *i8042, *port92, *vmmouse;
>   
>       serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
>       parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
> @@ -1142,11 +1145,13 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
>           create_fdctrl |= !!fd[i];
>       }
>       if (create_fdctrl) {
> -        fdc = isa_new(TYPE_ISA_FDC);
> +#ifdef CONFIG_FDC_ISA
> +        ISADevice *fdc = isa_new(TYPE_ISA_FDC);
>           if (fdc) {
>               isa_realize_and_unref(fdc, isa_bus, &error_fatal);
>               isa_fdc_init_drives(fdc, fd);
>           }
> +#endif
>       }

So the problems are these 2 functions:

FloppyDriveType isa_fdc_get_drive_type(ISADevice *fdc, int i)
{
     FDCtrlISABus *isa = ISA_FDC(fdc);

     return isa->state.drives[i].drive;
}

used by cmos_get_fd_drive_type() and

void isa_fdc_init_drives(ISADevice *fdc, DriveInfo **fds)
{
     fdctrl_init_drives(&ISA_FDC(fdc)->state.bus, fds);
}

which expands to:

void fdctrl_init_drives(FloppyBus *bus, DriveInfo **fds)
{
     DeviceState *dev;
     int i;

     for (i = 0; i < MAX_FD; i++) {
         if (fds[i]) {
             dev = qdev_new("floppy");
             qdev_prop_set_uint32(dev, "unit", i);
             qdev_prop_set_enum(dev, "drive-type", FLOPPY_DRIVE_TYPE_AUTO);
             qdev_prop_set_drive_err(dev, "drive", 
blk_by_legacy_dinfo(fds[i]),
                                     &error_fatal);
             qdev_realize_and_unref(dev, &bus->bus, &error_fatal);
         }
     }
}

Pre-QOM code I suppose, since it is odd to create the floppy
drives out of the FDC realize() method. Somehow DriveInfo[]
should be passed to the FDC object before it is realized.

For cmos_get_fd_drive_type, we could expose the FloppyDriveType
as a QOM property. Then we only need the QOM API to access the
FDC, and it can be built as a generic modularized QDev object,
usable in a generic qemu-system binary.

This is why I was holding this series review, I needed to give
it some thoughts w.r.t. single binary. I'm gonna ack the series,
postponing the FDC rework.

Regards,

Phil.

