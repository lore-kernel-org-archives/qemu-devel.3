Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590B4C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3BbY-0001cT-3b; Fri, 11 Apr 2025 06:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3BbW-0001bE-42
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:27:22 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3BbU-0006Gx-9g
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:27:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso13182675e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 03:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744367238; x=1744972038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gJNgIjzYFRqq6Q+RMe/zLhdYNWW11VICjpZpl6ROY54=;
 b=Gpk7+zUNUAdzT1t1jXnh4b6dOS+itb28j8+jOgOeiXMutKJwbkYQ8X78iEDoL5DhMr
 iXvWeItxJz1Pynag059p72JG4c6HbFgS1bElxutywFmlTFMFL1FvO2ya4e8Y/WHavUbM
 xxj3S0sObLZqb+w6atC6i49VEldVDOQPzLl9TEpLEJn70dkiVXzZFK9FtMA8xb8aSETj
 PikNj8pC1ZHFNQnI1OADkyY9XY9NVUQH1RV8D1KqbV+lQXdQD2Fe4CEPMFcyj1eS9M4E
 dP1RT+74vZ1mIsuRCASFJSglI+LOFMCxgJ6fkxqW9JNoJBpcB2leRRvK2dABG9Yqb8yq
 KTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744367238; x=1744972038;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gJNgIjzYFRqq6Q+RMe/zLhdYNWW11VICjpZpl6ROY54=;
 b=BAdWeflp8+/l9f9C8mgppEujtI6YS/O/lQsxDEd5aslCkbmNAS5rq2pCL22ZEVN3+G
 QifwfNRKjmVGBvQHxqlmk2cJ4gySsGGW5ScQCFAvsRU6BztbA5iiQEZHgwu/8gunrjEI
 /7hQR8ApH8bhgq924hdKVz/KsHG6dSOm4rTAiM5xhhRCIpYNmngoql0qfFTTt2lMetuI
 C1NKPL8jBLbRYxI7JIq94Ck4jLsYxnvqIM2F0HH17mrvxdbNVlg2CSIOqTM8uEMsnQJR
 s4vTZu51JHKi8XcZ2kBQjUWBaxvkVlzGz+F5aE0YyKF6H64Jjpw7db1M5StreRgyIR4t
 KU+w==
X-Gm-Message-State: AOJu0Yza5+5xxOLGxFt/I5ePTXQlwlT/2ObTwW/YhhSVBM7uYXeMOKWu
 iHDBCBeIFBL/P/puxJKwcnUfAh+gojtQv3WC7YqXQnqrNdp5dvb9SSE2sRLg1CU=
X-Gm-Gg: ASbGnctF2WIbbpAuujt6RwbPvprwt9NtdFfUxDhSf3DesPzE6O8VnMbCJxcHSUZXG2r
 SXYwA3IfDCbsKPdDk6x+y4Ex3n5rx2Ri86d6b2B10e2EJ54VPcQ4F1+cHPTMSPCcrzFf+jj5ZYn
 Pvdgiu4RfMTtmaoybyrpeKZeYweWPMcFA9PxZwwBkZLo6JO22e2LTmt9jvnXgvjB4lEBVBb404f
 DZC6ra2jSpfctwUqc6B5Op2wr6RCbnF1ZePvam5QE/ksKh7UdpHW7QMAraFvfP1UB5Zo6BJpwjG
 n33BI1W1aZgjt1e14NG/19am9h/w5zfBl6JVbfwqNZ4ylnSN2tPT+sW1cnkgurC3VsFk33nNLEw
 XFk8tlZay
X-Google-Smtp-Source: AGHT+IFI9lIeLobmjvHbgGQhZgeHXT0eJG5tN0I/86EXb1Yc+lQu3hAWU6nKzdnLLEvMGp6IPmIPaw==
X-Received: by 2002:a05:600c:a04:b0:43d:ed:acd5 with SMTP id
 5b1f17b1804b1-43f3a93d4a8mr18630495e9.10.1744367238334; 
 Fri, 11 Apr 2025 03:27:18 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43cceesm1576867f8f.73.2025.04.11.03.27.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 03:27:17 -0700 (PDT)
Message-ID: <3796b8e8-b896-4b7e-a90f-ae15a4132100@linaro.org>
Date: Fri, 11 Apr 2025 12:27:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] usb/msd: Add some additional assertions
To: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250411080431.207579-1-npiggin@gmail.com>
 <20250411080431.207579-8-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250411080431.207579-8-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 11/4/25 10:04, Nicholas Piggin wrote:
> Add more assertions to help verify internal logic.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/usb/dev-storage.c | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
> index a9d8d4e8618..3b806872587 100644
> --- a/hw/usb/dev-storage.c
> +++ b/hw/usb/dev-storage.c
> @@ -264,13 +264,24 @@ void usb_msd_transfer_data(SCSIRequest *req, uint32_t len)
>       MSDState *s = DO_UPCAST(MSDState, dev.qdev, req->bus->qbus.parent);
>       USBPacket *p = s->data_packet;
>   
> -    if ((s->mode == USB_MSDM_DATAOUT) != (req->cmd.mode == SCSI_XFER_TO_DEV)) {
> -        usb_msd_fatal_error(s);
> -        return;
> +    if (s->mode == USB_MSDM_DATAIN) {

Or switch().

> +        if (req->cmd.mode == SCSI_XFER_TO_DEV) {
> +            usb_msd_fatal_error(s);
> +            return;
> +        }
> +    } else if (s->mode == USB_MSDM_DATAOUT) {
> +        if (req->cmd.mode != SCSI_XFER_TO_DEV) {
> +            usb_msd_fatal_error(s);
> +            return;
> +        }
> +    } else {
> +        g_assert_not_reached();
>       }
>   
> +    assert(s->scsi_len == 0);
>       s->scsi_len = len;
>       s->scsi_off = 0;
> +
>       if (p) {
>           usb_msd_copy_data(s, p);
>           p = s->data_packet;
> @@ -288,6 +299,10 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
>   
>       trace_usb_msd_cmd_complete(req->status, req->tag);
>   
> +    g_assert(s->req);
> +    /* The CBW is what starts the SCSI request */
> +    g_assert(s->mode != USB_MSDM_CBW);
> +
>       s->csw.sig = cpu_to_le32(0x53425355);
>       s->csw.tag = cpu_to_le32(req->tag);
>       s->csw.residue = cpu_to_le32(s->data_len);
> @@ -486,7 +501,7 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
>           trace_usb_msd_cmd_submit(cbw.lun, tag, cbw.flags,
>                                    cbw.cmd_len, s->data_len);
>           assert(le32_to_cpu(s->csw.residue) == 0);
> -        s->scsi_len = 0;
> +        assert(s->scsi_len == 0);

Preferably having scsi_len changes in a distinct patch,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           s->req = scsi_req_new(scsi_dev, tag, cbw.lun,
>                                 cbw.cmd, cbw.cmd_len, NULL);
>           if (s->commandlog) {


