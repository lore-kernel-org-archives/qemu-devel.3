Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8361E65298
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmhDC-0003qD-I4; Sun, 01 Feb 2026 18:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmhD9-0003pV-GV
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:50:36 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmhD7-0006RK-Rv
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:50:35 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so37094055e9.3
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769989831; x=1770594631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7kZ/74JHqcCI4/WSZhC/+nPp2AOaIwL1ztkTSGfbg0g=;
 b=r4/AAUPruQegD0VNl+qhkuv+Dq1D3ZFGBd+FgQTIysmCNEGTmB9YaO3x6HS3TNrZ6W
 1oikVX8R1auadAlqt2730556QP1Kdvo6px9MgSB8LYL91x5o56GzAKVOu3Hi1MxFrDBW
 s7+TvV2Z7tHRBYwU0ilKEYGmekRVm/Vf7ffeopYU+WF12BWerhQrlR6aY2FRF3lrpB5y
 vf4kW7ka9DR7fCGO+qehzXKN/8fTnwGP8yINuFXUEoLAtL1I1JJkJTTMeJefmsaHT9is
 F/qsF5XO3YBQnSf7i8sfCDUlVKwf17+FnYc8bQwHA2oD23emVvdwpIQmrsEXlrNTWbEy
 bZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769989831; x=1770594631;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7kZ/74JHqcCI4/WSZhC/+nPp2AOaIwL1ztkTSGfbg0g=;
 b=NP4rVxmhgfgcWtbxbHg/ctqSWCzvsyzehKlOuvT06J3cdlwXecFmpGXUFsHb86IuvI
 idgRxy0Ebk6JM/EVJ/etF3ZMB/u0qgWwcUJYbU3bj00hFi+GTnv8q5IUFxiANUdMX3F4
 rEQavkF1Tn+2TnKAKlaDsdAXhxD97Ynq9nmk9OmJkJbPQWmu9u8dP2KA6/waLtIXy2Tb
 YmLZBnIKVNs5GGyCOuQoiuv4qzBKIbtJDChnkIz0+UvbmpbqsfcEa8SOxsvbualPm46S
 4GLBtyd9Qwa6HZPTxSAdLhOvrJ6pxlzyds3IjYdanOEcW1oAwbdjsdg22mL9ILzmU71m
 Hr0g==
X-Gm-Message-State: AOJu0YwrFMkvpiX9gE0QXo+l8WLfqUbmd3VLWNHr8rU+rz0bsNGUh4IJ
 pRW75eABdQsvJzo8qdUh/hUybwIZmBqnGxcuIHSQM0Y56HKmjEK4ca7eVt/xFk34YcpTxCnukgp
 /nuoC7tA=
X-Gm-Gg: AZuq6aKOpSIeVS5O77pdPy7iaW0fqp0+3m1+sZ8ooMa6HE/m4ADisMoMsB/f0blPxEH
 7MqFp5SgjnUeY77JeH8S4Ajy4HvEFuaavFAPGFcZobKf/0JFmlMiRqd552G2FlQtCMNa9YnNC5k
 WqcdSx13xR5nVSCH7eSBBHq+8ijiGwdpGt4ZBaNKDKSkCUGW4sd2ZrVusHm/MAUZjBKCl483KL9
 9cw3uxDS1j/Z+Q1F2HW5RpT6B2UrRQehE8eO8kWlj5A2ybraSUzzzfY1m7bTb+dDQFXuDCG/9AU
 LeYNoVCYlOq4BtttVC53Z3er6Zx+OeDfGwBhBT+o7LWJTdZ43A9GgWKs5a03csxY2hxN+QTWrkv
 UH1xF8+RXlFmHUcC2MbbkXo5Mm5ruBGcR/UeAZ/ut/o2593OGmtU11FOzOtOTG7tQCMUInvmifS
 UBVqperSm01xfct5Yzmn3zrh41tcQX3k6RSNKjom41fLetf9r+7wCqrg==
X-Received: by 2002:a05:600c:530f:b0:47d:3690:7490 with SMTP id
 5b1f17b1804b1-482db45ba1cmr125660515e9.9.1769989830718; 
 Sun, 01 Feb 2026 15:50:30 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e13235f5sm38513068f8f.29.2026.02.01.15.50.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 15:50:30 -0800 (PST)
Message-ID: <93bb5be9-32d9-4ebf-97dd-63c148a80c97@linaro.org>
Date: Mon, 2 Feb 2026 00:50:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] hw/virtio: Introduce
 VirtIODevice::access_is_big_endian boolean field
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20260201232924.93399-1-philmd@linaro.org>
 <20260201232924.93399-4-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260201232924.93399-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 2/2/26 00:29, Philippe Mathieu-Daudé wrote:
> VirtIODevice::access_is_big_endian boolean field, initialized on
> device reset, represents whether load/store accesses are ordered
> using big endianness.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/virtio/virtio.h | 5 +++++
>   hw/virtio/virtio.c         | 1 +
>   2 files changed, 6 insertions(+)
> 
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 17b105c146d..7a4f7de7475 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -154,6 +154,11 @@ struct VirtIODevice
>       VMChangeStateEntry *vmstate;
>       char *bus_name;
>       uint8_t device_endian;
> +    /**
> +     * @access_is_big_endian: whether load/store memory accesses are ordered
> +     * using big endianness. Might change during device resets.
> +     */
> +    bool access_is_big_endian;
>       /**
>        * @user_guest_notifier_mask: gate usage of ->guest_notifier_mask() callback.
>        * This is used to suppress the masking of guest updates for
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 86fc0e262f7..242c207a591 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3247,6 +3247,7 @@ void virtio_reset(VirtIODevice *vdev)
>           /* System reset */
>           vdev->device_endian = virtio_default_endian();

IIUC vdev->device_endian is only used in vhost_needs_vring_endian().

>       }
> +    vdev->access_is_big_endian = virtio_access_is_big_endian(vdev);
>   
>       if (k->get_vhost) {
>           struct vhost_dev *hdev = k->get_vhost(vdev);


