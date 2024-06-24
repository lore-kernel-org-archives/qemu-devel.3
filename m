Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3446AC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcMn-0000JB-Vz; Mon, 24 Jun 2024 01:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcMV-0007tm-0p
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:35:33 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcMS-0005B7-9R
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:35:29 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f9e2affc8cso20904425ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719207326; x=1719812126;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TK9jsPupGbqTFb0SSVGrHarCX3uZpmBjTVW1qQtF12Q=;
 b=AfI4JD4+ZeWFgdSO5I+eMoZekaUcsMbeUntcEiJ33UKqugKe/P/F08yc1bXJUTNV4a
 2AP8PEAAXgEXzorXrTF8/5/mPD2ldQoog48TtNMYD9HW8BktkaNCSE6eNcHrtpYFm9+j
 6+93t6HgqJHfv+eY2hl+6oIKw48KX4Dp2NdJ0PaZtHiALRtY3ut2bqNajCrBnAtWzwsc
 B9QEHUclvfxssLqqy0wqUGbV/7/+LT0LjgottP2BvFPYShq5GegN+BgyB+GvxfasAovW
 yoGwICNQ0L+0NJL9VqSO6U3way5lfyXQ8RfPhMb3Lxj4sI2fUQrF/nSryMMSXhzV9nOR
 mnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207326; x=1719812126;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TK9jsPupGbqTFb0SSVGrHarCX3uZpmBjTVW1qQtF12Q=;
 b=fwzO6g8DnfJKk1FAmc4MgyAM1G/lhTerIg1Jyfr9/uBnFbmzYa25emmr7d+wuNeXAj
 UoE/MAZKlDbuAPTk1VnlrL2Or2PkTsQmIRdFS4IIzkTXXVGkeQlnSNAmF3bdqDB0fvuk
 08aS0PNBCgM7LOtN142YIOZSdHOF69u8vdaihCWzhTEtcDK0/wF569lfp3anA0o7vGq9
 NoLk2izU1hQst185GXCSk+ifgV8DFb5/fAhQybCVJ4doW2+23/NgJeZ416j3VAZbtVGi
 t/Vmsdx8Y1LhHb/kRHzY13dCO7P/iUdB0Suy3BPClS1CTLZKm+aBal2PR+0NBqrNRuZP
 EZFw==
X-Gm-Message-State: AOJu0YyJqYDyW/122ogfoV8NZXy/73Xjzm2L7Sw3oHnXGQTdwpmEbNMW
 UEC8blBiMoACr2+oVAd+/4Ji6WOSwr38L0d3j95tXXXaUnaPMEvprARcOl0jEl4=
X-Google-Smtp-Source: AGHT+IGOZhd1U2SFdnnoDjB4R2y4hDFBlFnU++u622aW3EOwwsdKbMzEjvybndaAHBxY+3m9ahqE3Q==
X-Received: by 2002:a17:90b:4c89:b0:2c5:249d:67be with SMTP id
 98e67ed59e1d1-2c86126b700mr2305581a91.22.1719207326496; 
 Sun, 23 Jun 2024 22:35:26 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c7e64a1d9esm7838919a91.56.2024.06.23.22.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 22:35:26 -0700 (PDT)
Message-ID: <90bea313-6bec-4937-a338-422b4b7bfb9d@daynix.com>
Date: Mon, 24 Jun 2024 14:35:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 03/13] virtio-gpu: Move print_stats timer to
 VirtIOGPUGL
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
 <20240623152343.328436-4-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240623152343.328436-4-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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
> Move print_stats timer to VirtIOGPUGL for consistency with
> cmdq_resume_bh and fence_poll that are used only by GL device.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

