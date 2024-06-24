Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9D5C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcOT-0005YU-Iq; Mon, 24 Jun 2024 01:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcOO-0005KG-Rc
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:37:30 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcON-0005YJ-Dz
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:37:28 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7066c9741b7so784097b3a.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719207446; x=1719812246;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ST6TBhbJ2OySO0RuuJ46yzMtuL2R3cT8Ca8OYbdGHeQ=;
 b=sWzRSm5SchrsGjBO+BMeViZtY4bPnl/yf3oFpjAorJeAMsfPtGpITyuE0HmQNeYBz9
 rw7PTcGiMuPXJyeumJkdtwScuxHT+MiKd+rgdMmNTIIus3otwWmZuot6LWuSvcvYdruh
 pLSiPvwAA4DIZ/wrBDcSuup2y/3AxDPKnnu4CIl7IrCd1l/P9nKuwyGeO5omYU1zqUoW
 gx2Tzn+UWss0eGkZBLLqOhkeJNe3RbcD5RvpEmipKE4nYzV9gf73/v0dOBRC01W4v9dr
 oAaYf5lLV680j0foKDTUHmSkLR2kC9Wh0t+nF+j13MQLzG6bb6yYGmlDJTf34vetJ6so
 NdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207446; x=1719812246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ST6TBhbJ2OySO0RuuJ46yzMtuL2R3cT8Ca8OYbdGHeQ=;
 b=UDjzLdbPha3ZL9sDlSasX3PytjL1MWpqxZJJBcjVHOBODObFLGw3Nq4QPuXe+tGKMf
 xR3A79d5M9cgeh1CE8Iha3/q9CKHHGvE40tYbQy4HV1xUg0SxxejO69B++d+KpokR33e
 55a0t9wXGvmvH1EUutP3uApJcKc1SaMzFbWz0ncZXp5LWz7a3EyjQ3WBZ1onCNmMivj1
 6zHXwPLJF8hyCiU8k/vbQjBBMADe6U8WylB14ZUVRWX7qIv6s5FC6aCTXsgIgNoFbJHw
 +Ep7fhabL7E1a4OQkYchdaS1MVMPvsnzEXgvpy0HNKS8eIfJ6mx/0vR1sChQqF9RUoNK
 ozvA==
X-Gm-Message-State: AOJu0YxgXuxIfQH5F48eBn4x5MvYdHYiXpnaMAnV7EBjzg5/qqsL1JNN
 xtq2uTTujywLBdZGJirnC4aH4UaskLCYTPhm98mspOe2Q6xfVBWUvvVzzSz8eiU=
X-Google-Smtp-Source: AGHT+IGqPlEFzkJd4izrNXXqMvPbuy+nxN4JUfPZ3dgSNvM0fFOy6VDERcuDnc6XQWIUwj9Jkp3NFA==
X-Received: by 2002:a05:6a20:3813:b0:1bd:191:ed95 with SMTP id
 adf61e73a8af0-1bd0191ee94mr1692862637.32.1719207446054; 
 Sun, 23 Jun 2024 22:37:26 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7067d11a437sm1642090b3a.118.2024.06.23.22.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 22:37:25 -0700 (PDT)
Message-ID: <87cc9679-b282-4632-9bee-b0d657e02d6e@daynix.com>
Date: Mon, 24 Jun 2024 14:37:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 08/13] virtio-gpu: Don't require udmabuf when blobs
 and virgl are enabled
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
 <20240623152343.328436-9-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240623152343.328436-9-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
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
> The udmabuf usage is mandatory when virgl is disabled and blobs feature
> enabled in the Qemu machine configuration. If virgl and blobs are enabled,
> then udmabuf requirement is optional. Since udmabuf isn't widely supported
> by a popular Linux distros today, let's relax the udmabuf requirement for
> blobs=on,virgl=on. Now, a full-featured virtio-gpu acceleration is
> available to Qemu users without a need to have udmabuf available in the
> system.
> 
> Reviewed-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

