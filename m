Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94478CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPI9Z-0007zi-E1; Tue, 19 May 2026 06:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wPI9T-0007y1-MD
 for qemu-devel@nongnu.org; Tue, 19 May 2026 06:58:20 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wPI9R-00016m-RF
 for qemu-devel@nongnu.org; Tue, 19 May 2026 06:58:19 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so2017166f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 03:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779188295; x=1779793095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=th+7m4e1V2ZxPwz3Px/qnbJ7ANB0j47Cvdm2V2sKVJ8=;
 b=DOkIzr5QX7JbZFD7ImfIBdowVwEcYpRVzpfxDYp3WRwWTLo5ZdeZlVMTHY2WxmHy/i
 ZfXXxC8jcQ4hE7woiwJrRbJdiNdKIBsHocX+gfIZ0M1LensK4A2S7I461DFdAc5ht3TG
 1g5MIiXBdYbG5ily1b7+CegHKKn0Yba3uMBjQN+uacVhw1UTVM3iOwLPeN0JOXVostLm
 WGuE64ypImggCyV3MK6D9i1jaWlcFaixDl8DA7NirJvsb/BVknsrdpTVD1GswEi1EiOg
 g8nhQp9rv/6h+auzsiBm+OdfFHMIeQbR9Dmwp/7IK1h9sREwvzL/h7rRsmF38i6Fuxh9
 L25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779188295; x=1779793095;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=th+7m4e1V2ZxPwz3Px/qnbJ7ANB0j47Cvdm2V2sKVJ8=;
 b=X/Y91bQlw+T0h46bF3cHCpYnON7tAe4wGWldcHVwv/eTrJI6wvJLAcCAKk3d5zIqjF
 jBX+Wjuap5/U04F3QTx2fXy7E7YIm51HDDkwRQnJEw4Vl0stFvtviS+vvzeYF//6QFTA
 u9dH5fS3hpF1pHecavVkfKUjkfEaBMMsLWeKXBtslCTnaORJWNM9hUZzaHOHu/Zh7Psp
 W5pua4aaAIKNi3t3IQBGR+BtY0gzCO3AOCg471LS7a4uJfi7/VtRv2jS2P2o4Sz547wJ
 mqobXmxDN5ImPvljnduz71rMx6Dc5iE5FNCSamaHGi3GoE4w+9O3pa4FYgoRcGSs7QAl
 uy4A==
X-Gm-Message-State: AOJu0Yy17XY+1pd/9xnzU7w+pshydkf0O/FoSC35HA9Gah2KXa81bU4r
 xlJxgEjLpD5ES556i31E7nCCINm/38MAwVA0NhLmUB8LHqT4hzFcnRrrt22vCMtYZMY=
X-Gm-Gg: Acq92OEubCEuqOMUDGWkg09j+SLnuaO+Rn1ncX+C9EJs9Hxe7W1clBSQOdGOwxLC4sL
 vGNgxeHVyqtShy2A6SCfR+kdC81wxmsxjIURd/r3FbTZ601Ccztneq3hoHa5XR2raMMlSp2JZ+W
 uZAsDoHe/cEPy0QP5Gun0JrQQewaVeGt0lSCny28pc2WHa4D4QFyr79uIA1zj1oyqQTiGZ1iyY3
 K+kZqrPV8ezt0Op2AccLe9UdknKU5MOkhiF/B1nm3I063BrecqpYF8sp7w5uMjOAFTMj8F/5afg
 NxmJ1EzqbpHZTW9qRxsfU2hRlcde7y0/gSJn1+Rt+qj0vFV2jmtVZ7nD1MIJS2OdY3RfpZRmYzN
 lZmZv4H6k8Rh9jRIJrve8mJENOUknNC/6tg2kMh6kxhl2I2fvpS1GBflewHurQJT2aVpQV3KJq2
 uHjeM9K1hOrRMrZGi3MXBETQk=
X-Received: by 2002:a05:600c:4fd4:b0:48a:581c:ead with SMTP id
 5b1f17b1804b1-48fe60ed7b7mr265377945e9.10.1779188295032; 
 Tue, 19 May 2026 03:58:15 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe537c516sm344405225e9.13.2026.05.19.03.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:58:14 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A646C5F81D;
 Tue, 19 May 2026 11:58:13 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 dmitry.osipenko@collabora.com,  marcandre.lureau@redhat.com,
 visitorckw@gmail.com
Subject: Re: [PATCH v5 4/4] virtio-gpu: advertise VIRTIO_GPU_F_BLOB_ALIGNMENT
In-Reply-To: <20260317182049.33848-5-lucaaamaral@gmail.com> (Lucas Amaral's
 message of "Tue, 17 Mar 2026 15:20:49 -0300")
References: <20260317182049.33848-1-lucaaamaral@gmail.com>
 <20260317182049.33848-5-lucaaamaral@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 19 May 2026 11:58:13 +0100
Message-ID: <87se7nbr96.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Lucas Amaral <lucaaamaral@gmail.com> writes:

> Set blob_alignment to the host page size so the guest kernel can
> align blob BAR offsets accordingly, avoiding alignment mismatches
> with the VMM's memory mapping API (e.g., hv_vm_map on macOS).
>
> Guest-side kernel support (drm_mm alignment) is pending upstream
> Linux merge.
>
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
> ---
>  hw/display/virtio-gpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index de7a86a7..44ae5034 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1532,6 +1532,14 @@ void virtio_gpu_device_realize(DeviceState *qdev, =
Error **errp)
>  #endif
>      }
>=20=20
> +    /*
> +     * TODO: guest-side F_BLOB_ALIGNMENT support pending upstream Linux =
merge
> +     * (Sergio Lopez's patches, Nov 2025). Until merged, the guest won't
> +     * negotiate this feature. The host advertises it per OASIS virtio s=
pec.
> +     */
> +    g->parent_obj.virtio_config.blob_alignment =3D
> +        cpu_to_le32(qemu_real_host_page_size());
> +

Is it merged yet?

>      if (!virtio_gpu_base_device_realize(qdev,
>                                          virtio_gpu_handle_ctrl_cb,
>                                          virtio_gpu_handle_cursor_cb,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

