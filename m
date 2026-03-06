Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5C4FCC04F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZDE-0002VV-Iu; Fri, 06 Mar 2026 12:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZDD-0002V9-B3
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:43:43 -0500
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZDB-0005wC-Jc
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:43:43 -0500
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-89a133cdd4aso49259386d6.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 09:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772819020; x=1773423820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DWa2D5lR49IJ11tY8Mm7osQUN8nI2qfyLzOunqnFXWQ=;
 b=xRxK49RgPzNINYimXChq8fuJGB0NqHxH9gPJ2Iilpobz6DLx6CULu8EMNJGFJuXpkT
 3czz9+x8AA2rqM7IxLmvj37/3SiMo1q8LzxzZ0zHAi6ZJ+3pxB6F1szUVLplHHDjZ694
 7kYbqit41mfpxsyvwJ2HLT995car9L4iM2d0ZJvff1fmgno1Xu5auvbA9tRI/A7PI6Rk
 UIX/9Rcuj57wXYOgwPKDAmOWSt0nF3TQJ1taU0mIWzETpHdVxYCobp9X0ycxZ4fMgfwZ
 qDePfbUzRTRnqeZAEMSuml03ebA+JLahYzDvnLokxnnvaLRwyJkchA42YXhodyhMNeQa
 pQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772819020; x=1773423820;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DWa2D5lR49IJ11tY8Mm7osQUN8nI2qfyLzOunqnFXWQ=;
 b=cqFf0PthZPupDFyMkVNlf2yQ2tN4s5WSVD4wXCse+ktI6+2d0ZSic0v5ISs+FAo6UE
 j1Dvq7AHF7/vvi6IzIueLsA6HGuv7DnwQKstpbN0bWCJZW2CCbm5tnDsxD1CNTus7wKl
 QBxmpoBi8ZNvqfmC8l4nBbkBgMozaLIJx1IWYuxfhp/ze71BXMeKtUF7eZDPUkFCWNhM
 zEvLI7GvYUBuICLIoRDGA6TGbzf4Vt3XD3D19cNx16xoS/bWsndT2Yn13i8KNczwQi8o
 Q9skuEtWC9t+G2ufFZgEWeUYEMYhmsJGGpV5DorSG7d7mWe4N4+Df740glP5ATZ+9Qvm
 cSQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYEQuSTm+0WVgibUGrkUly+vycBm64RttOKCPjm9oa38fGnl8I+7r6QH1+JlVZQqKWfIIbVmsYbcfg@nongnu.org
X-Gm-Message-State: AOJu0Yyeid6NP3sfEtiJNwxLU8qCwQKeA9+B6eOWQ/VzCeeZ/JWsGbxS
 ujnS20amQd4l95Pv07zTtZDLIlSc04yEF9TJ3frwutn+jpwO2ufSvUFYd03jhwekdew=
X-Gm-Gg: ATEYQzztDGYqBhkGmq5hJdHvvskcbeYL9VLAbJpYPM7GU9Paa7R6Rq6A2Kd+ZNVh5Iw
 53YU/leqPLLJbSU3JaIB1BEPvoOjjeQHDHbUzLakJ7EyokWn+CVz20wCdkadLdGY1eODeTJEH4x
 4KHe5Tel/E5V/qZZ+E0GcQU6ZwL0rgcQSitDCvS/Ipl+CI+ftYymwJtFlGNpfomx8OcczvJQiWZ
 V1NDevI8N0M5SKAUluYYV1TZF+9qZRmlkfG1jD6U78G/cGJM7AfzIiMayzdlOZMEjJ7CUWPv5qT
 OsoPsGOD2Ljai2AmHhSI9QsxkPWCUQG1zLAxEcjP9m5skN/TrO8m3R9cSpJWldDlPL8IVfrSmUB
 lS77G2Y19G6/7gwDtpNrvUneCn2/Jvroil25N58NzGJjgylO0OX1iKG41jiqX/KQ4Px7rmS8DDN
 7a7LUugIdx64VuspF3cmQOJ4r4Wn/86ahdaQzq5IfALqrVUCFxg+CrWWhxiodcnVsNr24A
X-Received: by 2002:a05:6214:2244:b0:89a:e77:1f7c with SMTP id
 6a1803df08f44-89a30ad2384mr42869576d6.41.1772819019675; 
 Fri, 06 Mar 2026 09:43:39 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a3140da14sm20659966d6.9.2026.03.06.09.43.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 09:43:39 -0800 (PST)
Message-ID: <d9ffeb97-df9d-4888-857e-76ddc345c651@linaro.org>
Date: Fri, 6 Mar 2026 09:43:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] hw/virtio/virtio-access.h: remove target specific
 code
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Greg Kurz <groug@kaod.org>
References: <20260225041948.52929-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260225041948.52929-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf2d.google.com
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

On 2/24/26 8:19 PM, Philippe Mathieu-Daudé wrote:
> v2:
> - Rebased
> - Removed virtio_vdev_is_modern (Zoltan, myself)
> - Include Stefan's Acked-by tag
> - Include "make compilation unit common" patches from [3]
> 
> This series eliminates some target specifics in hw/virtio and replace them with
> runtime functions where needed, to be able to link virtio code in single-binary.
> After a first try on a series [0] doing this change and making all virtio files
> common, Richard asked to refactor this part, thus this independent series.
> 
> By diving into virtio initialization, I noticed that device_endian is always
> storing endianness of cpu associated on device reset. The root issue, is when
> dealing with target who dynamically change their endianness during execution.
> ppc64 is the main use case, as cpu always boot in BE and most of OS use LE. arm
> use case is more limited, as big endian systems are mostly dead nowadays.
> 
> Because of this, initialization is tricky, and goes through different hoops to
> have the expected value. My first approach has been to try to change this, by
> simply setting endianness on the first access. However, it fell flat, because
> current_cpu is not always available at this time.
> A second approach was to set endianness to LE by default, and change it only
> when setting device features, and potentially discovering it's a legacy virtio
> device. It brought other issues, that showed that current initialization code,
> even though it's complex, does the right thing.
> Thus, I focused on refactoring virtio_access_is_big_endian, and noticed that it
> was not even needed at this point.
> 
> Patches 1 and 2 are refactoring names to clear some confusion.
> Patch 3 eliminates virtio_access_is_big_endian, with a lenghty commit message
> explaining the change. By doing this, we remove target specifics from
> hw/virtio/virtio-access.h.
> 
> Of course, performance has been tested, and it is on par with upstream/master.
> 
> Results are on 20 runs and expressed in kIOPS:
> reference: mean=239.2 std_dev=3.48
> with_series: mean=238.1 std_dev=3.56
> 
> ---
> 
> Performance has been measured with this automated fio benchmark [1], with
> original instructions from Stefan [2].
> 
> Download artifacts and run benchmark with:
> $ wget https://github.com/pbo-linaro/qemu-linux-stack/releases/download/build/x86_64_io_benchmark-a55f2d6.tar.xz
> $ tar xvf x86_64_io_benchmark-a55f2d6.tar.xz
> $ ./run.sh /path/to/qemu-system-x86_64
> 
> [0] https://lore.kernel.org/qemu-devel/20260206221908.1451528-1-pierrick.bouvier@linaro.org/
> [1] https://github.com/pbo-linaro/qemu-linux-stack/tree/x86_64_io_benchmark
> [2] https://lore.kernel.org/qemu-devel/20260202185233.GC405548@fedora/
> [3] https://lore.kernel.org/qemu-devel/20260206221908.1451528-1-pierrick.bouvier@linaro.org/
> 
> Pierrick Bouvier (6):
>    hw/virtio: Add virtio_vdev_is_legacy()
>    hw/virtio: Simplify virtio_access_is_big_endian()
>    hw/virtio: Inline virtio_access_is_big_endian()
>    hw/virtio/vhost-user: make compilation unit common
>    hw/virtio/virtio-qmp: make compilation unit common
>    hw/virtio/: make all compilation units common
> 
>   include/hw/virtio/virtio-access.h | 43 ++++++-------------
>   include/hw/virtio/virtio.h        |  7 +++-
>   hw/virtio/vhost-user.c            | 11 ++---
>   hw/virtio/vhost.c                 | 12 +++---
>   hw/virtio/virtio-pci.c            |  6 +--
>   hw/virtio/virtio-qmp.c            | 70 -------------------------------
>   hw/virtio/virtio.c                | 12 +++---
>   hw/9pfs/meson.build               |  2 +-
>   hw/block/meson.build              |  4 +-
>   hw/char/meson.build               |  2 +-
>   hw/net/meson.build                |  2 +-
>   hw/scsi/meson.build               |  6 +--
>   hw/virtio/meson.build             | 17 ++++----
>   13 files changed, 50 insertions(+), 144 deletions(-)
> 


This was merged into master (2940018747e31842cf34334394c7d32517e73fbd).

Regards,
Pierrick

