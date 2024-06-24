Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5513C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcPG-0007pp-H9; Mon, 24 Jun 2024 01:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcPE-0007oG-Jo
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:38:20 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcPC-0005bX-UL
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:38:20 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70679845d69so517322b3a.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719207497; x=1719812297;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cgI9hSP4ZTd/FnLyKh4zIejgp6yP0213M5kyxmjgu5A=;
 b=qk+7Bn8hYnCJZ6HzjsSyv/h4O6eshDoxIoWYCaL8tbuYSkcY0ScTnxfPOd4rPCHk1S
 dtVaF4NlesKD24N4HIQ3nXt9feZjaOOYLn+V7T5qFME50JL2krp9UTi6xRUs/+q8KvDa
 T2PZNKR4LxLfgJQqOGbeeLkbHnT+u4t+9dN4SodegdNcsHdrNjlHDHwF/uRxj9QijOHo
 838XsOJFwuNFkWVxVdfG2TsBmc1IAxgS0uugTj8qei1rpMIh3y5WBaApf2cdc36RkzFX
 VJGBDHw4jSF6E66h6aZTwB7hWYBowmq2P14I7FpT4YAFEs9gkVKBLGktKong7Zd0ZC0j
 l7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207497; x=1719812297;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cgI9hSP4ZTd/FnLyKh4zIejgp6yP0213M5kyxmjgu5A=;
 b=QFxRpp2KLuwvlQkebG/1n4Y0gYG4wA9ZxLNFiOoML85/YVJU6zdH9q2N7eRDqTn53I
 BT/wU1JVyUpjWxjxeZpJ0O0HUY/IqciRvieA5u+Id489g7UpqChErer1dkDtdJJVtGYP
 3VdMh7S+DNiPx0yeD3/Au+MIM/xt/KhMm5He+crGbtKpMtxjO6VUuwvKDU2oZrolKSwV
 xAw3P9JpvOkyo8jZrfwcA0uxh4AxUg49/3I1eSvw6fcxr2aiEvv8YCmBA6Jbm7950JV0
 60URdP9qIMXSVacBY3NVE+/rne3oPxH4tfKgxN04nLdr8+LlowTy64itemekZauHA4m9
 O6CA==
X-Gm-Message-State: AOJu0YwjcdQhXuQ1lnPThsm+BB43UHR7PyJVrXmA/0lAHBQnavkfmah1
 1FJ6fb8Xsh6i8qTCp21x03TIrzSczVoiqWPghdM3ogw5zY9xsC2990sqLTMxDL3DISdVD28NObj
 O8Ik=
X-Google-Smtp-Source: AGHT+IER3xyrXI/lobZrjuCK35ILPXDD/xOpj3c8QGstjzEBk6dZ930dJCQwrPJNfCLECDQsoPGvrw==
X-Received: by 2002:aa7:8ecb:0:b0:706:57ce:f042 with SMTP id
 d2e1a72fcca58-7067455bfd2mr2912448b3a.7.1719207497532; 
 Sun, 23 Jun 2024 22:38:17 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706511944d2sm5328390b3a.70.2024.06.23.22.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 22:38:17 -0700 (PDT)
Message-ID: <0425f585-9cbc-4c23-b3f3-7140dedcaa46@daynix.com>
Date: Mon, 24 Jun 2024 14:38:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 10/13] virtio-gpu: Support suspension of commands
 processing
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
 <20240623152343.328436-11-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240623152343.328436-11-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
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
> Check whether command processing has been finished; otherwise, stop
> processing commands and retry the command again next time. This allows
> us to support asynchronous execution of non-fenced commands needed for
> unmapping host blobs safely.
> 
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

