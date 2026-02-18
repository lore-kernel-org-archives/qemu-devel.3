Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24898E9A04C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsog6-0003k4-Ry; Wed, 18 Feb 2026 16:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsog5-0003j1-HO
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:01:45 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsog4-0001x6-1N
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:01:45 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43770c94dfaso279103f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 13:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771448502; x=1772053302; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IU8UThMO77PUIXRS4bbE5wip7Bln6liM1GyhB0aLkDI=;
 b=ez2LGl8JMsKVBLEsjwrV1s4W/7LBwqbU61987QyZ/NZj9pLPWqZojM/ICwD1sGGET9
 vHLYoPhRNVAPQuRPEYdFg4D2u64ADjlfaTx8nnWQ1dcgD8ON5q7UInww3LUega+RRe5P
 bAXbOfk3yau/i0EsY1fFG3i39+nQVD/XWTBoDL9srEjk2Syhfszg6DgpGtd6eyMWPyDx
 VBbivXRZQ4SXNLyNI3DuLGp0kcca6PcLYpYgPQD0mx17eTV0rH9OvAi2bcj9NDR+TXFH
 2e65k0pNoWbRcBSGfpZ2kf6nyUscOCx32Ug2W/D7lJk9JyvoqLnbO1YkfQgErWoy5ckJ
 vFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771448502; x=1772053302;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IU8UThMO77PUIXRS4bbE5wip7Bln6liM1GyhB0aLkDI=;
 b=CNNowieVSltGnQ7pV9ti0DqUapHqlxkonTbE00tK99Hy8+GfZHAAhaU/Kp+yTNmplJ
 84V947lih7fyZ4nj2Vg5UXyn4GZNAjf7eIfrQodjUVO/XQXtJKnOMAq4ZsTU6rKXdJ/a
 5HyBjYV0XSimP/UvyWG4JBff7tltQpL3DrljVlCejqF99yvnyqpOd7dppwBt44p7ip3z
 0HHwrudr0n4nm7SOl7HQGFuM3TK2wRrHbIrMcU09+30TbWMl8xwAPi4DyJyilrP+d2Lo
 Bp8g90QjNCCLtOcFobDKedTCbp3U5o91Ix/W3w5wA13xPOUNwno6YVREWDdf+JFb5w7s
 Jc7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcJTFmLFZjz4nGzEVs329azl9bNzZ7myU2QP+a39zqZ0yRvh6VSFIfF38cJHu0dsrMHb5w+U18bGnZ@nongnu.org
X-Gm-Message-State: AOJu0YwBcmXEs0sLRza/yl0wmPZ1au1iciq5s9rmn4scSTsYWawau78c
 WUg4X3pdA8dkbd8Q/kRvJsr+GYhwaOEzYEZUMRDmS7kZxFsA+lO2GBMLc3baiMmP9fA=
X-Gm-Gg: AZuq6aIommuJv1BzLo9PFZTOBDzADW2O0hQ2U5zGVP7C6OaQvZ8S5Nm4/cwZHwFpAos
 icH7BIsi8+8/Phxro4kVQOKoe6M2TqsiA6+WqrHDgyu3PinX06wgP/2rGw+yqgDsiTLrDTkmaeP
 FeOGBeb7PIYseVA3TozRv/tWrW2ZWP6DN7BtgTvWg0ihqr9BEb3G4m6v8wg0/AaEfZjYt4ecOat
 YMzqV/ZeZsRiSC5lXCXSPB5UK9T5z7Ui3GCXwLFq/C3yLmsX9RJDC7BMpcV2Sv9bPt8RQ3YtG9g
 R29C0ypQWnKGaeKAxHDz2WjbGpiftHKbCIaYFhBGbduWDzEzABDIfIno162xC3yuukoO2wVf5ft
 d3LV0cbdiOy4m6S9DVhXsCwEkOToq1Da7G7ec10GtHZl0DXrWmQTfcGKmzA9/++GPIVZ7VQX6uj
 sL1hV0fb1qFFr12F137gAVA892AaReq8xth31V6kJDjKg+Ro7JiAdbLgKGje4Cp3YXBdaj94cTh
 kYr
X-Received: by 2002:a5d:5f88:0:b0:432:c0e8:4a33 with SMTP id
 ffacd0b85a97d-43958e07213mr5606027f8f.22.1771448502492; 
 Wed, 18 Feb 2026 13:01:42 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5acaasm40350746f8f.6.2026.02.18.13.01.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 13:01:41 -0800 (PST)
Message-ID: <b9e3398a-370c-4fa5-b62e-88d2b45cc7c4@linaro.org>
Date: Wed, 18 Feb 2026 22:01:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/virtio: rename virtio_is_big_endian to
 virtio_vdev_is_big_endian
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, stefanha@redhat.com,
 richard.henderson@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>
References: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
 <20260212234602.338131-3-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260212234602.338131-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 13/2/26 00:46, Pierrick Bouvier wrote:
> Renaming this function removes the confusion with
> existing virtio_is_big_endian cpu ops.
> 
> Indeed, virtio_vdev_is_big_endian is *not* calling cpu
> virtio_is_big_endian everytime.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/virtio/virtio-access.h | 2 +-
>   include/hw/virtio/virtio.h        | 2 +-
>   hw/net/virtio-net.c               | 4 ++--
>   hw/virtio/vhost.c                 | 4 ++--
>   hw/virtio/virtio-pci.c            | 8 ++++----
>   5 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

