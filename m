Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9082BC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcPh-0000Vd-Tg; Mon, 24 Jun 2024 01:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcPe-0000UH-K3
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:38:46 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcPd-0005dr-1v
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:38:46 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7067108f2cdso920888b3a.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719207524; x=1719812324;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eXtvNAEnYUDuPvQX5jvfRmz/iEwMwGxxNmQhjRmDIYU=;
 b=NXiTuLmkQ7Y/27whXsLpPqepQ8dB1hTPYjA3RRUiLgvhJkMn9onqMgxSQ3vR+0hEax
 LYmO42kUYiGz12cXN3kmULmsGhxlToVuBqn5feiZFc7nSDDQFxpfRrMD1nW1q7YMJ6li
 MBBJcPn/4gu7cpYA+uSvH1sKPhA4TwTAwwYbs3SaP/XWi2RIBC517QY5Caa70oXm7kiB
 d9CYOUMF87SOwyCDr4B0PBQ5paih64uODVTKJls5s6s99PbH/V+CbficpmF1AL1D2bNV
 tSTGeVpn5FiG6vEIH6BF4zVR8CB/D5lOOJ/HdJ9DZABgs8a8WD69S+oALv7pfg8e4XYR
 WM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207524; x=1719812324;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eXtvNAEnYUDuPvQX5jvfRmz/iEwMwGxxNmQhjRmDIYU=;
 b=W+6uPNBw5yWzmzUpsF8uojyFxcyYYAHtwgYIzTPhuNegwYYcIK6SvQYx9AUnHTCRLG
 5ybRcGEnXW3I9jEb8jsLPGeDsXMjOXSot5FYp4eG2qMugasgJL5Y4YcB8wPqpIIeWorq
 TuHE2HLmG+staNahzDvClCRJoo8r9noba+HeqGoq7zFnUpcBTol+zYVPzIbz+QI2Eupj
 gUFblXyHRIi9jY/JfHDw8hUlGa/k3YcdgFEv3Zart0o/ztHhcchosWYk++Nzv9LTn+vn
 oTXhwsimWUCLovJXx6T6HF8fQzcEJ4YSONxLgDQ+cLDRQFq0K3CAXGfeNwZbZDgdXNyz
 DyVw==
X-Gm-Message-State: AOJu0YzX+CxPB/eSPy67zDJgx0Uzp/nAmbo/8cv75QTj7SNZAqyKP4Bn
 0l/Gyv055xNJ91NLGhJ3HnoWBEyyqd2xAod4rzW2LiLo6wA+QbgVi6XJY8shP2M=
X-Google-Smtp-Source: AGHT+IETqFTIyL15r9SCeXSjdc+132e9I2xafB6AYMaU158w25zBX13n959gAXwypF5DiHbd6QKo4g==
X-Received: by 2002:a05:6a20:a820:b0:1b5:6b5e:c104 with SMTP id
 adf61e73a8af0-1bcf464da0dmr4178204637.51.1719207523677; 
 Sun, 23 Jun 2024 22:38:43 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb321720sm54589145ad.84.2024.06.23.22.38.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 22:38:43 -0700 (PDT)
Message-ID: <2f70527a-b1e0-43f4-aa6a-85ab5a45901b@daynix.com>
Date: Mon, 24 Jun 2024 14:38:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 11/13] virtio-gpu: Handle resource blob commands
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
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
References: <20240623152343.328436-1-dmitry.osipenko@collabora.com>
 <20240623152343.328436-12-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240623152343.328436-12-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/06/24 0:23, Dmitry Osipenko wrote:
> From: Robert Beckett <bob.beckett@collabora.com>
> 
> Support BLOB resources creation, mapping, unmapping and set-scanout by
> calling the new stable virglrenderer 0.10 interface. Only enabled when
> available and via the blob config. E.g. -device virtio-vga-gl,blob=true
> 
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com> # added set_scanout_blob
> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

