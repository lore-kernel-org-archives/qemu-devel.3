Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD3DC07E8E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 12:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzc7Y-0001wu-Au; Wed, 24 Apr 2024 08:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rzc7W-0001wV-8W
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:53:06 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rzc7U-0007Pb-Ge
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1713963182;
 bh=onMY1lu3JFtKonKYbbWWlXYmK0OoNOSu9q7gZOeYlZY=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=aTGzYhawmLx/K+WJ4LcREXkMUpO5hIBaU7B2IOckKeAumBVim4eeFhQ9QV1REh1nO
 s027iNQwZ18brVfNH+KsH7aTPRBg+vKq7qMpafmFgkBVSNYwI7fmb4mw8oAj5MU5Gl
 7CHP1w1Z3/39xinnucCjXnhAYRg0JbFL89Gs37SOFxDSertzUtwuOSiCz3zYXexWwx
 XJmv9wVyR9p7rDshj6VHzs+33VuRE32CizmhbtLrxrHI892nKccGE+R1G9m+EQzSOe
 mDbtVwREwlG8ycZz2EmleYb7nm4DIojkv+uOGvT5FPtEUVtMI+Uw9oPtQwyjJhLCxw
 mcK78MpOi9Kwg==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 422E037813E3;
 Wed, 24 Apr 2024 12:53:00 +0000 (UTC)
Message-ID: <902711ed-2c59-4804-bd55-62545bde67e4@collabora.com>
Date: Wed, 24 Apr 2024 15:52:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/11] virtio-gpu: Resource UUID
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240418190040.1110210-1-dmitry.osipenko@collabora.com>
 <20240418190040.1110210-10-dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20240418190040.1110210-10-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.235.227.194;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 4/18/24 22:00, Dmitry Osipenko wrote:
> @@ -1405,6 +1408,8 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
>              res->iov[i].iov_len = qemu_get_be32(f);
>          }
>  
> +        qemu_get_buffer(f, res->uuid.data, sizeof(res->uuid.data));

Save/loading uuid without changing vm version was a bad idea. Will drop
it in v9, we don't need to save/load uuid for virgl anyways.

-- 
Best regards,
Dmitry


