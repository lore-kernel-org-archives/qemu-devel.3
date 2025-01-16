Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A6CC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYS87-0005As-PV; Thu, 16 Jan 2025 10:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYS86-0005Ab-FH
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:49:58 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYS84-0006L8-KA
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:49:58 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385e3621518so530554f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737042594; x=1737647394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tB9Z7P6pPttY0wcLNCPk+BKhhAFnUlXTBAe7XtpEeg8=;
 b=U1eNAiG0qkyO8gr7YcIICOGemOsvoPT/bS93Yk3xsbEqAsYYXKBH1WRnnED0RNJSZL
 wihsUhQuUs1beLYeUX51zlgWqg+l0pK5z6p/3N9V08m8jE9EaHrum9kHpBMlt0w6Ny8a
 FDBeCyWufiT6Zc6DI7jDt2yQ3BVdoBRu1uPn9tk42nukyaofJgRfIpb3v9PyysgBfslV
 egV3EY8HCvXGWZ0no4ZbpMUHAfuzdVGs9tEd7KcxJFo+BZCwHczIKCAwZnwk43qlyHxt
 EGgRr7j94MgSR5noD3FriMtQ4V/UI1TWCt/kcr8gsgHWxNiQ4i/MyPPVVhnxMuq1yzc6
 FNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737042594; x=1737647394;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tB9Z7P6pPttY0wcLNCPk+BKhhAFnUlXTBAe7XtpEeg8=;
 b=vRq/5W7DZi+TQyctC6B+GrhRJklv4z7A5WOEegrHitI6SeGR/2dv8bzp5pLcI98DIo
 GJhwl3Dauvi/LVTsW1tKJhO80wQooXY/x7VkyGbtBCmL+5UcbAZu9k0f3xcbRtmPjQT9
 SfnnYtgA3AQRV01fNTHpOisc8rbzATWkAQsOTGfkcqk4OUg5BQaBZEYw4ElkH33rRN+l
 e+yee9hCGlQ0XDBmWW0FSKj3dS3nPAE0zDw1xsl1zsCWKnArT7JyZ+b/M5LoET0jqJ1Y
 cygCkBBBs8UWaSqY8W8lwxaexsmxHdRSJJ/vbDuT2kthZQ4Qeai/iFq464Pn2MTRy/wS
 a4eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdusGw20Q187vwj5X9KB2GTaJpu7fpLLvNXSgsnt8lp0KiL1ggYcLB/KuWXa502itHR/Ab8pFKjr+E@nongnu.org
X-Gm-Message-State: AOJu0YyNDFoStNYTdQJdc7rwD3pNFIgHu4QZ4BVvT9QBvl3LgHnrScKj
 zHsBv0sdiOkfJk/fjg+DxWkleOKntfsfxbB5ikIOthsLERyUIMXuzV5gvrr2wfw=
X-Gm-Gg: ASbGnctNDonuzbb7PnxGEjiSKr58ZIMOZbkLvX9r4VzOpmbIVB0Sd/i5ervg+I6erQi
 +RY7VwAC+94MSHRpmOi/iUuL4c0HJWw1al0GYmY1pP+pjy1KNgN4kyYxNhmIX2NtP1qpbzjOTDE
 a4sJx4jEJIiHJasguWvKKOKZ904ev36ue5Uu+IcubCi00KtIQRJVGr4j+Ac0tdYdAPn+GsYytSg
 t3r4+2TRdNsM+2LX5w1BxnQojboQqHSOQHH8vyKWLALHguPdthPgrNNGArE3/MqfdQKd+WIEixc
 0HO4pTd/RiA6wFAC8mNIuFbh
X-Google-Smtp-Source: AGHT+IGVLosAJCstIut47n6zX8ISFXTIqt8rrFltqUvIDgEOH9oS/FZLJcPSsVMoo4JlS+EO8e4NEQ==
X-Received: by 2002:a05:6000:2cd:b0:38b:ecec:8576 with SMTP id
 ffacd0b85a97d-38becec864amr3293746f8f.0.1737042594568; 
 Thu, 16 Jan 2025 07:49:54 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3221b65sm201104f8f.33.2025.01.16.07.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 07:49:54 -0800 (PST)
Message-ID: <41c6c5b6-4e08-4332-a6a3-24b6b51361de@linaro.org>
Date: Thu, 16 Jan 2025 16:49:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] pc-bios/s390-ccw: Fix boot problem with virtio-net
 devices
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>
References: <20250116115826.192047-1-thuth@redhat.com>
 <20250116115826.192047-3-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250116115826.192047-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 16/1/25 12:58, Thomas Huth wrote:
> When we are trying to boot from virtio-net devices, the
> s390-ccw bios currently leaves the virtio-net device enabled
> after using it. That means that the receiving virt queues will
> continue to happily write incoming network packets into memory.
> This can corrupt data of the following boot process. For example,
> if you set up a second guest on a virtual network and create a
> lot of broadcast traffic there, e.g. with:
> 
>   ping -i 0.02 -s 1400  -b 192.168.1.255
> 
> and then you try to boot a guest with two boot devices, a network
> device first (which should not be bootable) and e.g. a bootable SCSI
> CD second, then this guest will fail to load the kernel from the CD
> image:
> 
>   $ qemu-system-s390x -m 2G -nographic -device virtio-scsi-ccw \
>      -netdev tap,id=net0 -device virtio-net-ccw,netdev=net0,bootindex=1 \
>      -drive if=none,file=test.iso,format=raw,id=cd1 \
>      -device scsi-cd,drive=cd1,bootindex=2
>   LOADPARM=[        ]
> 
>   Network boot device detected
>   Network boot starting...
>     Using MAC address: 52:54:00:12:34:56
>     Requesting information via DHCP: done
>     Using IPv4 address: 192.168.1.76
>     Using TFTP server: 192.168.1.1
>   Trying pxelinux.cfg files...
>     TFTP error: ICMP ERROR "port unreachable"
>     Receiving data:  0 KBytes
>   Repeating TFTP read request...
>     TFTP error: ICMP ERROR "port unreachable"
>   Failed to load OS from network.
>   Failed to IPL from this network!
>   LOADPARM=[        ]
> 
>   Using virtio-scsi.
> 
>   ! virtio-scsi:setup:inquiry: response VS RESP=ff !
>   ERROR: No suitable device for IPL. Halting...
> 
> We really have to shut up the virtio-net devices after we're not
> using it anymore. The easiest way to do this is to simply reset
> the device, so let's do that now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/virtio.h     |  1 +
>   pc-bios/s390-ccw/netmain.c    | 33 +++++++++++++++++++++++----------
>   pc-bios/s390-ccw/virtio-net.c |  5 +++++
>   3 files changed, 29 insertions(+), 10 deletions(-)


> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index e46e470db4..335ea9b63e 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -153,19 +153,10 @@ static int tftp_load(filename_ip_t *fnip, void *buffer, int len)
>       return rc;
>   }
>   
> -static int net_init(filename_ip_t *fn_ip)
> +static int net_init_ip(filename_ip_t *fn_ip)
>   {
>       int rc;
>   
> -    memset(fn_ip, 0, sizeof(filename_ip_t));
> -
> -    rc = virtio_net_init(mac);
> -    if (rc < 0) {
> -        puts("Could not initialize network device");
> -        return -101;
> -    }
> -    fn_ip->fd = rc;
> -
>       printf("  Using MAC address: %02x:%02x:%02x:%02x:%02x:%02x\n",
>              mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
>   
> @@ -221,11 +212,33 @@ static int net_init(filename_ip_t *fn_ip)
>       return rc;
>   }
>   
> +static int net_init(filename_ip_t *fn_ip)
> +{
> +    int rc;
> +
> +    memset(fn_ip, 0, sizeof(filename_ip_t));
> +
> +    rc = virtio_net_init(mac);
> +    if (rc < 0) {
> +        puts("Could not initialize network device");
> +        return -101;
> +    }
> +    fn_ip->fd = rc;
> +
> +    rc = net_init_ip(fn_ip);
> +    if (rc < 0) {
> +        virtio_net_deinit();
> +    }
> +
> +    return rc;
> +}

Optionally extract net_init_ip() in a preliminary patch
for clarity to see where virtio_net_deinit() is added.

