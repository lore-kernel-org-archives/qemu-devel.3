Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3271C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 07:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0c3e-0003bF-34; Sat, 27 Apr 2024 03:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0c3c-0003Zs-CG
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 03:01:12 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0c3a-0007tT-IY
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 03:01:12 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6ee12766586so2224822b3a.0
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 00:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714201269; x=1714806069;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yiGMdEE1TWgXuEiZrblVmIxL0BuQwHqNxoRlN9Gbzzo=;
 b=bo7qcXttVfmFaYs3cBn/OVuJSXexiYmaAxnu+p9kHrEBsUC90T602aUa/P2CFfRS73
 uJmBIrXOZk52HjzKXQVWvM3M1q1jCJszu/mdtiVP/OYSVcJlWydzgcLqrQ7zkVB+lp/2
 zJ+xvozuPXK3G+KbFm/zMf1zunIDfjw4Q3JggfZz7IAfHn45jxtOrWxgf8hjc4TLt23W
 ImKvMV+k+E9LFT5HTsxXQkixWvPb13tDN9ZkkDdgzramnalf94mle3yXcYkkN8kjAu+z
 dl5b6bTH+WOOx7LIJwgky9Cp1pgy9tnzgCiE+i1Hvb4mj+EWjxGqxwK8b/XlxHoQ+IH/
 4TPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714201269; x=1714806069;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yiGMdEE1TWgXuEiZrblVmIxL0BuQwHqNxoRlN9Gbzzo=;
 b=FCo/UvZYyfYNfUmNRMD8LsilY9dcRUk539eYWgo0CZLPCcc0rIQrdpcD07NOBzH0KL
 YQ2rZWOeYo6p3P+b7ShRhgnPcmHDorsYbp0JEdy7kRT55KTeJMpmUh9umC/zlpKWXiLZ
 5tXdBe0vBv/KepNL2x75tfvWQzGh48+P8CcQYtZczDUTH7CA9wP9W/md03Uw5FA7cDdb
 a0fMUqTB7/yMwqipu5fei5jMhRehXOGrj2jPJ23tz2aRnLmlHnqoGDrL7NqNBF1KSD9F
 9Dfo5nxXnHw9zRyroN/qcW4kT+DIzPH+ZuUsmmfYp5fJnmoD1rK6Hd1jLvdUsKFrmSXA
 B6RQ==
X-Gm-Message-State: AOJu0YyMwNw21Pw/LYhzKbUIkwHl7Qlonl4Mtr6kvx5+yXAPsFqRKqJO
 Pe90cfxhqJ+VUsGxT6XV1X6DuUgL62OKRCvVX93/fiE4nZe+NqBx+Y0e7o56PEs=
X-Google-Smtp-Source: AGHT+IFdMF3F4ccwpK+WJQ9RjYt9aZ1HvGsIUIFzfAGugj1uBZMgYnoh/7LZPx5j/5Ew/Nw3LJsKDQ==
X-Received: by 2002:a05:6a00:181a:b0:6ea:f43b:b961 with SMTP id
 y26-20020a056a00181a00b006eaf43bb961mr2712952pfa.6.1714201269022; 
 Sat, 27 Apr 2024 00:01:09 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 ff20-20020a056a002f5400b006eacefd8fabsm15833389pfb.64.2024.04.27.00.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Apr 2024 00:01:08 -0700 (PDT)
Message-ID: <0d037703-5832-48fa-a092-a4d334358b7e@daynix.com>
Date: Sat, 27 Apr 2024 16:01:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/11] virtio-gpu: Resource UUID
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
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
References: <20240425154539.2680550-1-dmitry.osipenko@collabora.com>
 <20240425154539.2680550-9-dmitry.osipenko@collabora.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240425154539.2680550-9-dmitry.osipenko@collabora.com>
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

On 2024/04/26 0:45, Dmitry Osipenko wrote:
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
> 
> Enable resource UUID feature and implement command resource assign UUID.
> UUID feature availability is mandatory for Vulkan Venus context.
> 
> UUID is intended for sharing dmabufs between virtio devices on host. Qemu
> doesn't have second virtio device for sharing, thus a simple stub UUID
> implementation is enough. More complete implementation using global UUID
> resource table might become interesting for a multi-gpu cases.

This message needs to be updated to clarify that a VM can have a second 
virtio-gpu device but this implementation does not support sharing 
between two virtio-gpu devices.

