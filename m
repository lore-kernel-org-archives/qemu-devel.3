Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8600C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcNk-0004Pc-MN; Mon, 24 Jun 2024 01:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcNe-0004Ip-Og
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:36:43 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcNd-0005V6-Bm
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:36:42 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3d35f1dfda2so2138647b6e.3
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719207399; x=1719812199;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4UeIrnK+x4MJL0Fd1GojjIUpYNBbEWfFqfmaS+MdeYc=;
 b=rNN4rigGeMDuecT2H0QxzUwkLm7okJmJRBAqU6LEhBw/CYC14ZhnFkaMLwY0/oPupP
 pIIx20t9Y2yBVM4oacqf89DyikxEJPldX4B7TvO2INCgioB5S/xAE1MIgeuZIMS7vYsQ
 FAOU0C4GjqZ9CKfk7KYe7P3p9IQcAj3OkH64BKXgbgsFXE7XlIiPo9QbT0imYKNvazdj
 tf9x3djYkabwUKZoilyaFkMYnGKLFhJrpKSCULuZdJUvgDXMw6PopzgTmZXPfezFvWRP
 dFtgffrer7ENQEz2HXEHyuGDBN++wOfrxqw0o4yz3uca+PnQ4Ig97CNdrYg2xMcD3nGv
 EZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207399; x=1719812199;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4UeIrnK+x4MJL0Fd1GojjIUpYNBbEWfFqfmaS+MdeYc=;
 b=msAXMzB8bx8D4fVzUXG5wTi9+bAubI3CFVKSJhaql0sjey6FaPJffrDmo0kehtv3Mk
 N423+zLPYzdCyLMNOW2ETl4m3LScLgJz/I6OghgBYkQmdTF1QodohiCkqS5GVUZhNDSU
 RocwBZQhqBwgR1IZTfI0UNFQMtf86yB9XOIz7HK3UIIGrB5CuQ1AI1q67nN7yXIGMPnL
 mSwXGetG1xAGdAWXMEmU7CXIHcy25e7At18xktpu0NzafKskz9lqVsLcqvyuJZUSnq0i
 bzYiRHd8u5kgWW8W4J4omiEZM4sb4ocMfswWbdEm5XhAH/l8nhsxhAxRPQXOBD9wqaYa
 T2og==
X-Gm-Message-State: AOJu0YxINME/hzhcdekcZa03/lnxVnc/0BEBKY2e+quVY1BL1nHXl+2S
 AIZ4FuIXvZ4o2kd9ePGae61kaIdPaRwWaQ8m+Tyt8gNDrQeIIazFNtmTSsY5GWs=
X-Google-Smtp-Source: AGHT+IHbp0eiyz0zbaapHbvhjQwCWjEb4yMPDxXBpMVZbRziGJf4DxLGkZTOndrHIUgaGn31osxHbQ==
X-Received: by 2002:a05:6808:bc9:b0:3d1:d3f6:455a with SMTP id
 5614622812f47-3d541c65829mr5299997b6e.20.1719207399325; 
 Sun, 23 Jun 2024 22:36:39 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7067e0e5723sm1582153b3a.75.2024.06.23.22.36.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 22:36:39 -0700 (PDT)
Message-ID: <8af265a0-7e15-4944-b40c-a4d19f5928cf@daynix.com>
Date: Mon, 24 Jun 2024 14:36:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 06/13] virtio-gpu: Use pkgconfig version to decide
 which virgl features are available
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
 <20240623152343.328436-7-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240623152343.328436-7-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::232;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x232.google.com
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
> New virglrerenderer features were stabilized with release of v1.0.0.
> Presence of symbols in virglrenderer.h doesn't guarantee ABI compatibility
> with pre-release development versions of libvirglerender. Use virglrenderer
> version to decide reliably which virgl features are available.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

