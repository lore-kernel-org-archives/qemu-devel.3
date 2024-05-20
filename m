Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41178C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 03:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8u48-0000h3-5f; Sun, 19 May 2024 23:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s8u46-0000gr-KA
 for qemu-devel@nongnu.org; Sun, 19 May 2024 23:51:58 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s8u44-0001CT-SS
 for qemu-devel@nongnu.org; Sun, 19 May 2024 23:51:58 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f4ed9dc7beso2134503b3a.1
 for <qemu-devel@nongnu.org>; Sun, 19 May 2024 20:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716177115; x=1716781915;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y3j9SfsiXD1KtUqLz+b+t1xBZpmIPiLeXLkBD2DgOe8=;
 b=VL/UgRtr/rXyLbei9ePJc8ElqdwHt7Jg6Nw2dMUd59PHXQwE6RYF3QQ2l+vCu1SKHg
 N8VuzGWyg/z8npGfY6rcIZdwX/HcCZ7Ge2BKBjc2JpFw48zohGF0gFm/BcKXyKXibe0k
 sEU6LCBe+ZrK12Z9XFzUXfzeb7nftQ46+pIKKlQPBw5mqF3rIsMXZehRl3mQUtoamc/r
 YD/AVTHckIzl+/MWCL9gAAIkbUbnOBtPADURL5gB9SPpd7ZxHviFYZZDSVzYfk/53WK+
 jAHnSZLNc2ogyISW2NiGyyaAT16kSNEQlhj2EymH3POXa4+N7L0G7SQHK1F6yRC3QEFX
 2Leg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716177115; x=1716781915;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y3j9SfsiXD1KtUqLz+b+t1xBZpmIPiLeXLkBD2DgOe8=;
 b=mGKV4LfmWbFR6L0vc7yHXWjt/aNP+51vUEZ6r6JafvB3V77KV+Z7dl4Qh6u/E8CtFQ
 dt5EoCNzsZE7NFCgmhVm1T5ojgEaC6j1DPs34J5qyrtAMAvzjeLLcpaHPSiXjoK9BKMP
 cnodbbtINST/5+YFip/7kf0zaouHmch8ty6Ib5Htnrg66kGB+PI4RW42qx8fLEIM/QIF
 uJvqqdztBdpRBo+ljekmNfMpnC5JZKAintaDNuArYqr0K4/Dh9Cf5+qIy8ziheUC5Ei5
 PB1ph/c4dpLh5yI8KWpiWVZf6wqlT1NyurMoF7dvUnE6E8SByIktUBiPMNpnjDpiU7Sp
 pYOQ==
X-Gm-Message-State: AOJu0YzkjYiB8kNEERUTmbr1vOqY2SAbci9NQWol0YB5fx5TT0z8dwja
 OQpdsndmfCXQb2bBX0lK4vAAWGTO3nrKAfJThSHCrtKe43RhicW9sUaRnmAvXS8=
X-Google-Smtp-Source: AGHT+IHP3EeW+jjk4PylZlV7hI1NjduSzlGxcihL+bYLi4pidUr2IW4q6JyXFP3ZzKbtNxuF/NyGzg==
X-Received: by 2002:a05:6a00:6282:b0:6f3:8468:8bb with SMTP id
 d2e1a72fcca58-6f69fc55443mr5245340b3a.17.1716177114796; 
 Sun, 19 May 2024 20:51:54 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2ae0fc9sm18207666b3a.132.2024.05.19.20.51.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 May 2024 20:51:54 -0700 (PDT)
Message-ID: <4390f6bc-84d4-44be-8487-0591cb4ea348@daynix.com>
Date: Mon, 20 May 2024 12:51:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 10/13] virtio-gpu: Move fence_poll timer to VirtIOGPUGL
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
References: <20240519212712.2605419-1-dmitry.osipenko@collabora.com>
 <20240519212712.2605419-11-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240519212712.2605419-11-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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

On 2024/05/20 6:27, Dmitry Osipenko wrote:
> Move fence_poll timer to VirtIOGPUGL for consistency with cmdq_resume_bh
> that are used only by GL device.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Thanks for refacotoring.

Please move this before "[PATCH v12 01/13] virtio-gpu: Unrealize GL 
device" so that you don't have to rewrite code introduced by that patch.

