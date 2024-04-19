Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AB6C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 08:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxjzm-0006fk-5o; Fri, 19 Apr 2024 04:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rxjzf-0006f5-Uk
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 04:53:16 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rxjze-0008LO-3R
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 04:53:15 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e50a04c317so10632485ad.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 01:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1713516791; x=1714121591;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bBl7TMKqHwjRRTwHqVtRxo3gsbUvZoXSrMUCkVnLEAo=;
 b=CPd4mKoiaSjm6djPdSeHg5FBjYSOd0/Z1mEZagzSC0B1knZbI14+nq+Jf9901uEoS8
 5Q6be59f6FZ8tYJtHIwb5ufUS3FN4EhkyVjKfzONdSq8fqa8JNtvXlmHibxx33LHjzY3
 vw3lu24ECHD7lIEfHrSs+jqYYFi6sUW2C/4Zn+10lOdRLpAyYsfn6GR932Oor/8iIDlY
 SJJuMyRSIF2cKA7QyfQY9Kssvcuf6O1ZB1ld7IcDtKzkM2d4mWYpIuSJFdv3NVfOQnsK
 uDTE4qzxydS25ErAxwvUqBQI+eS/WqOufQds6tr8HUJTmB7HGRtxQK1fAxiMqQs5838u
 Xvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713516791; x=1714121591;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bBl7TMKqHwjRRTwHqVtRxo3gsbUvZoXSrMUCkVnLEAo=;
 b=iQK8F8yik2OPH8GrHYviHko5a3QPnv5HRIoobdjIeSfGjR96cnxr/nBLq7fhWa2omQ
 9T37PNiLI9gl/J6K2TxlLkRMR1vH5/enV2Wc4yP+UswZvYCRPIr9ByDubkfSjP1lYcyZ
 mbyklKh/C3bznUj/y941pf3Yquv/x7FoH0sqK5eYJJgT7AUUCb+kr3BV3CeLxLvfB8KY
 mF455liGp7FyowiujEXz7UrI1sEAfNJHDFGxWMyGQoxKXycj8DYHeId8sDREk9Gv3Dnn
 npr+Vbu2XLbB6XPln9XFTc3Pnn/ClWbjsSpj1yl7Ki1SO/BrejS3G5vTipWUmVbef5X5
 QgUQ==
X-Gm-Message-State: AOJu0YzbGYuDKZ7zHVQph5ju0lM0B44lM+cnNNtgtp/PoRYVwsBcSdq6
 vKbhQha0jcRGZPikN8yAo7Vle3CFdpY6862bxarozfAABRb8BT+vyI3ods1TanU=
X-Google-Smtp-Source: AGHT+IF09m1DfiftzGvosNRxr6B3dvyV8W1wnyxVgWzOp4rE2WLZGFThmqdJ4s8ol6MO5x2osiEJIg==
X-Received: by 2002:a17:902:ec85:b0:1e3:dd66:58e1 with SMTP id
 x5-20020a170902ec8500b001e3dd6658e1mr1753889plg.44.1713516791041; 
 Fri, 19 Apr 2024 01:53:11 -0700 (PDT)
Received: from [157.82.207.134] ([157.82.207.134])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a170902779800b001e5119c0f9asm2843759pll.66.2024.04.19.01.53.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 01:53:10 -0700 (PDT)
Message-ID: <8a153bf1-f86c-46c8-a29a-08e9a0197dc3@daynix.com>
Date: Fri, 19 Apr 2024 17:53:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/11] virtio-gpu: Support suspension of commands
 processing
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
 <20240418190040.1110210-8-dmitry.osipenko@collabora.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240418190040.1110210-8-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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
> Add new "suspended" flag to virtio_gpu_ctrl_command telling cmd
> processor that it should stop processing commands and retry again
> next time until flag is unset.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

This flag shouldn't be added to virtio_gpu_ctrl_command. suspended is 
just !finished in virtio-gpu.c. Only virtio_gpu_virgl_process_cmd() 
needs the distinction of suspended and !finished so it is not 
appropriate to add this flag the common structure.

Regards,
Akihiko Odaki

