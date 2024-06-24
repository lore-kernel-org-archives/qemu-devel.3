Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55F6C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcMt-0001PY-K8; Mon, 24 Jun 2024 01:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcMs-00019V-0x
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:35:54 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcMq-0005MT-A7
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:35:53 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70656b43fd4so1764753b3a.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719207351; x=1719812151;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=emPhRUMi3Y+67u9Y2hEPgVEwvlb7TYgX3iKz8DMYQBw=;
 b=Qcy23NZCSdllP7Ruj3mdCwmUPrSWVTt6bgokml6dkgm+6G3LY/DwkfyxlsekArnuvr
 DulgMX0eKYNNQRLez9awPKdl/JlUHGVTzfgtC2tVDu2St0UUGgMpCzu7OEHp0YCllV2n
 nRuLUF0tGbsx9EesHI6GdKwu/iFtE4HHxB8l12Q6XwXvM2LGZdL76FPr3G+CcmIHl9BA
 z7axH69NybgohM/LZ8BqXWN4j2PzTGtY+ISGiv0HjyOEzTJwI2BTmXe5hKiHmMyJniqR
 fMVbHPpmovVSnkaQ4zZJel3hkBuDRbOXfsyDf/qvOdQ7nZNSuFY3YoHw2VurTRPtR1MX
 M53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207351; x=1719812151;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=emPhRUMi3Y+67u9Y2hEPgVEwvlb7TYgX3iKz8DMYQBw=;
 b=a1EZuTDi9WfqOvPk/cKEYDLpnK9gthQCPJemVbQ1+HOru/Cp9ZhR404SYBgsHhe6Lb
 NO6PI8vzYw6xe49p9M2HB8YiusjdydlBrg1J8E/ArVPx6c/Ny9D5tDud+bngVjkhbevC
 KB20ge7+xajbzExlgq93XDKNI8yopVjUyEhiLkUssHC+7Dzyct2Ac+UAbIEnExUijYDd
 5uhbbUL+1ChKEbUlwOmYy64LUjd/ItEtFI0Bw8jW+otO9DsudjGGJ0auZDIHkV0OHaQr
 C8dRYfmRhXHw4WoyIj3N964JmKEswB+xUrhYnKnIdk0szvmqC/BZoVZrNs/LEbCucLsg
 vC7Q==
X-Gm-Message-State: AOJu0Yx1AJ2MmuHELslp6GBs9wZMwN06dS/Kg6JgFX/vvVor0xhyFBVx
 fkuVIhPUKzt4SClaTh98wgjW6rKCDAQVQFKoppu2zK6ZdCGpm9XBHpJZJO3RKpY=
X-Google-Smtp-Source: AGHT+IF9tOIexbHElw2XCTZAJkJYHBwV5J/wi2riZdPJX04o3qYBZXHv3yarm6Ffna2IalLD9k6K3g==
X-Received: by 2002:a05:6a20:1595:b0:1bc:de4d:1c53 with SMTP id
 adf61e73a8af0-1bcf7eb7a17mr2909983637.29.1719207351003; 
 Sun, 23 Jun 2024 22:35:51 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb32170asm54193165ad.86.2024.06.23.22.35.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 22:35:50 -0700 (PDT)
Message-ID: <9b8ac69a-ca24-48b1-8622-6b7800ce5930@daynix.com>
Date: Mon, 24 Jun 2024 14:35:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 04/13] virtio-gpu: Handle virtio_gpu_virgl_init()
 failure
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
 <20240623152343.328436-5-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240623152343.328436-5-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
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
> virtio_gpu_virgl_init() may fail, leading to a further Qemu crash
> because Qemu assumes it never fails. Check virtio_gpu_virgl_init()
> return code and don't execute virtio commands on error. Failed
> virtio_gpu_virgl_init() will result in a timed out virtio commands
> for a guest OS.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

