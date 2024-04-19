Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DD1C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 09:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxkZ7-00071G-Rq; Fri, 19 Apr 2024 05:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rxkYr-0006mD-G7
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:29:41 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rxkYp-00063l-85
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:29:36 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5c6bd3100fcso1140527a12.3
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 02:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1713518973; x=1714123773;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H6fE9CuDo1fBdkRXcytKrDDysxsdzdFMOMAWNIyYGbQ=;
 b=csQJmRjZ4nlhcTucNo2M6An8aaci0SI7P0AIYz9Z6e1XsUDMshLxqvfJAy3+2syFoE
 ViX27zjolsECEXZzdWdbwidvJ7XQuuGPtZpw7AuoJjnTuBFSuXCczC7rthwDFN4ORlIU
 88WGMdaPni7Wa5pwvOM4hpVLbqeXzmASHzsktuTOXB0OAdkx8vXyZIFfsDwA/5yvZrKJ
 13V/AdHnxOnQb8rK+E4F1hAnTe4XSFu98/10HoX5wu/SvrAO6T5Vi/I7Uh4G5OFiHxZP
 IRIigzmgSAtWofE0f04metbjJjY1sbsZgqbh2aKC2Ngp6383rWXibf+q25brndaMIJHE
 frRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713518973; x=1714123773;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H6fE9CuDo1fBdkRXcytKrDDysxsdzdFMOMAWNIyYGbQ=;
 b=AawZRRo2qEUf5r4WdRuzZoyGGl5EdG7Cwl5fEEgIltELibnHHm9PSKZ48A5S23Or6e
 CHuSNM0J2e7hYm5h1TzDT3OqxMzgNFZynXNUraklqR95R50Y4zbQCRUdUFx2SOdIDdqG
 mDe8w1i15F/n3Iu+juX+SO9+cKuEPB7ML/yEiptincVSdnGSIBkImDt2Swl/0ReCnC8h
 /VqlBc1WURjnQUEE9WyNA7QntqGUpvLGgM3Q+LYswlrdwO9a0pEzzJiVAnpnpVPszTtq
 4JFu2GBvHI4gWqKLS9qZecAVfOwwZ2LH9XV1TNACp0lBBYK/v8ks9/g4lyXXq9Z9liSJ
 SsOQ==
X-Gm-Message-State: AOJu0YwfBx7F1msGhC9DwiZDZ31alncnu1W9Ao/AU5HkN9tzzwIbISWF
 /adIr49bxHX2oAuHDyiMr1fO8UxzRvqm9i6DqIC60/9cEUBiFap3l/muIBdQO9c=
X-Google-Smtp-Source: AGHT+IEEBf1vvnH9cxOYtVq/DOvMDShO9NXD6Zy+UTA4Px7fjPoWj5qkT3nK2cUzNOIb/0waDQcNww==
X-Received: by 2002:a05:6a20:12ce:b0:1aa:590a:9668 with SMTP id
 v14-20020a056a2012ce00b001aa590a9668mr1864051pzg.51.1713518972816; 
 Fri, 19 Apr 2024 02:29:32 -0700 (PDT)
Received: from [157.82.207.134] ([157.82.207.134])
 by smtp.gmail.com with ESMTPSA id
 fj33-20020a056a003a2100b006ef97508163sm2832286pfb.37.2024.04.19.02.29.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 02:29:32 -0700 (PDT)
Message-ID: <ad215124-6a02-4bc7-8cee-c6865bfff768@daynix.com>
Date: Fri, 19 Apr 2024 18:29:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/11] virtio-gpu: Resource UUID
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
References: <20240418190040.1110210-1-dmitry.osipenko@collabora.com>
 <20240418190040.1110210-10-dmitry.osipenko@collabora.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240418190040.1110210-10-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
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

On 2024/04/19 4:00, Dmitry Osipenko wrote:
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
> 
> Enable resource UUID feature and implement command resource assign UUID.
> UUID feature availability is mandatory for Vulkan Venus context.
> 
> UUID is intended for sharing dmabufs between virtio devices on host. Qemu
> doesn't have second virtio device for sharing, thus a simple stub UUID
> implementation is enough. More complete implementation using global UUID
> resource table might become interesting for a multi-gpu cases.

Isn't it possible to add two virtio-gpu devices even now?

A new subsection should also be added for migration compatibility; see: 
docs/devel/migration/main.rst

