Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5553BC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcQN-0001k7-Lo; Mon, 24 Jun 2024 01:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcQG-0001Wz-Ga
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:39:27 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcQF-0005gM-0D
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:39:24 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f9c2847618so32543885ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719207560; x=1719812360;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5XzLvTb8oNO4+M49OiqpWHVfNUt+ze8juE42LsRC82Y=;
 b=xEHJxMOzvU+0wi3IjPkaRZ9oOQXxbSEP7mhdkwnd4HNFWhlC59jlnyht7NvuvdfidZ
 IDOLSiaQdwZtf1sFVcTljl5saEf1nAJ6+YdRpJDQSfGakUbmu6YyrJqPmCrG+KE+mDQD
 QSUnNFS0FhJYchxM3nQCb0hAo/SYI33N6QmIxlwEO+kHQtVZywJ1D9QQWllTlkhX4biP
 91TKcxMYVTIgyOrTgoN6tYRnldC1hib6OnWoRL/XxXkRyBbpPfflDRW8UirMz8EdceNQ
 pQnXwk7R/eNWsTPIPAI+3+J+v21K3ViD/gNMHhvsHP4hVOHqI5SBIfe93scTqnoM34y8
 OIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207560; x=1719812360;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5XzLvTb8oNO4+M49OiqpWHVfNUt+ze8juE42LsRC82Y=;
 b=WFcj8se8z8SntBXPlwoF5OxRNK2KEj1vH7ydSpZDBLccjexbbN3K94sGM0LonNtHoh
 Z8DJYJacYZZfz0awqlQaf7s6hETjG2vspJVy5qjBjo/5VOBLO5NSqHglhDVA1daB+/e4
 f4LXQCjQ8KGaNtkNDbvc3S9kj+FrnLDUIupH+OQoD9YfX8TXN9O4vE5k4x3LuAr0pjEE
 bXUxGlA7EHv/vst6dUK5OC2eP13W6zorO49DAVQSwK3iNa6IiaJuVO+8d+B58lntsqJf
 sWC5+ZN0ztzgH68zLZA/qDdogQ259e+U1vethPwGbHY4NNQH6Ma+5NMb6Ah/0sMtSYMP
 0wcA==
X-Gm-Message-State: AOJu0YxCOLn9nqIHkAWD0IhV+KqQ0TpOJ2oFFqK+6LPQeQ3RncaUVd5H
 OBRM1PQMsWv2RnmVtqedfq/+7y+Krxsd6Y/z5o7QZE7LZShs//3PoTTQtxk210k=
X-Google-Smtp-Source: AGHT+IHWR20RTG3hYV+Ac4JTMWZ2d+rr9i541IwRS3MiNKrStyB5Pu+7WC0Y9N5ujRjBCUdQvDHJ9w==
X-Received: by 2002:a17:903:187:b0:1f3:b55:e247 with SMTP id
 d9443c01a7336-1fa15937b3bmr41582855ad.55.1719207560327; 
 Sun, 23 Jun 2024 22:39:20 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbc2a7fsm53370625ad.283.2024.06.23.22.39.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 22:39:20 -0700 (PDT)
Message-ID: <74ad61a5-888c-4a8c-bb3a-6335ee0626ad@daynix.com>
Date: Mon, 24 Jun 2024 14:39:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 13/13] virtio-gpu: Support Venus context
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
 <20240623152343.328436-14-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240623152343.328436-14-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
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
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
> 
> Request Venus when initializing VirGL and if venus=true flag is set for
> virtio-gpu-gl device.
> 
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

