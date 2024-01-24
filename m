Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C970DC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 09:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSZMN-0002f1-Vq; Wed, 24 Jan 2024 04:15:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSZMK-0002ea-SP
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 04:15:49 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSZME-0001P3-ME
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 04:15:46 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5100893015fso1835469e87.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 01:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706087735; x=1706692535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dDUGwrU3qbNypFqKDx6zM1TwiZwabEv5EaERUyRrsAY=;
 b=P7nN1dtwC0hucN7JoP95d2mVqWT3ZomgQqQfaqF0Abwz0nIn3cZINgZZ2rwhPg8rzc
 z8+NjeIXEk163ce3rVAUEXGsptrrn8Z+oiKNJS+Qk7MwGzzrM/FX0TskF82+ecbZ3poA
 Fw7jN5ZoR+U8s2dZcP/tdEt/h4j02udEYmdtC7ULnYVtwztXf79Ujs7A3UnV14QlZvdJ
 rmIJeeo7KTst/YWSvJXnZ+OPBGMTXnrEYHCaBd1LvCtz35x0OJyZAfQvYoI4Ms2xyfIA
 EMXPA1eu6GMjn3T2TvmxbR0DnfZEIgmsOTjhP7vSutrTcjSyR0IftvfgvcKNTZYAJdHz
 slqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706087735; x=1706692535;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dDUGwrU3qbNypFqKDx6zM1TwiZwabEv5EaERUyRrsAY=;
 b=P6vmYUYCyYAyEGKh3htmnKYVrdhRVXePTiKh/owXMUNeT65yqffG6D/Lb0Zy8AZUw1
 kr62OhPC8souC6hwC1puLQn0W63F2BXjP3Rv//m+CL6m9P+Ci8aZ0i+djNGsD4btpIo4
 aziwtCdjhzsxaszPuKMr3tnxta7maMrqsG0WVt++CgV9Me8jMWlEyO79+PtxNiRZ15pv
 9QzF0ukkfoFFoCRnL9Id5KhSydyjQgfcygUZsjHUC+k/HacjgDquK1nOFZMFd484ACt5
 m6MMKFGSsAHDfBE6bMhnU0qNUVuIlJ7fkx4RTowvdbu38pkBnX+YgMkrSM1QtOF+rtL7
 DsTQ==
X-Gm-Message-State: AOJu0YwjPhwLMKq1JinFR9gfAvHkG7+oq4zOYGBvdTWjiy1x26iz+14T
 GpVXIF5j3RAKXTeRgmiN6U5HBGyVZ2NRLHNrRxbKV6LDW0cVT6t30584PPneFYU/zK667oxGstX
 xMmk=
X-Google-Smtp-Source: AGHT+IFjQRY8dz1l9++hGKsOBtwOsaOEG4j7L6rs4ZAX967/fGh97w7aRn+dlEvpnFCj8eNFeXGFIw==
X-Received: by 2002:a05:6512:1317:b0:50e:6c1d:5dec with SMTP id
 x23-20020a056512131700b0050e6c1d5decmr2523426lfu.23.1706087734916; 
 Wed, 24 Jan 2024 01:15:34 -0800 (PST)
Received: from meli.delivery (adsl-114.109.242.225.tellas.gr.
 [109.242.225.114]) by smtp.gmail.com with ESMTPSA id
 g4-20020a17090669c400b00a2bf375ceebsm15122949ejs.208.2024.01.24.01.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 01:15:34 -0800 (PST)
Date: Wed, 24 Jan 2024 11:13:52 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>, Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 C=?UTF-8?B?w6k=?= dric Le Goater <clg@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH 3/6] hw/display/virtio-gpu-udmabuf: Use RCU_READ macro
User-Agent: meli 0.8.5-rc.3
References: <20240124074201.8239-1-philmd@linaro.org>
 <20240124074201.8239-4-philmd@linaro.org>
In-Reply-To: <20240124074201.8239-4-philmd@linaro.org>
Message-ID: <7rdpv.zrb3rigymykz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 24 Jan 2024 09:41, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Replace the manual rcu_read_(un)lock calls by the
>WITH_RCU_READ_LOCK_GUARD macro (See commit ef46ae67ba
>"docs/style: call out the use of GUARD macros").
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> hw/display/virtio-gpu-udmabuf.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
>index d51184d658..0ee6685803 100644
>--- a/hw/display/virtio-gpu-udmabuf.c
>+++ b/hw/display/virtio-gpu-udmabuf.c
>@@ -42,9 +42,9 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>                      sizeof(struct udmabuf_create_item) * res->iov_cnt);
> 
>     for (i = 0; i < res->iov_cnt; i++) {
>-        rcu_read_lock();
>-        rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
>-        rcu_read_unlock();
>+        WITH_RCU_READ_LOCK_GUARD() {
>+            rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
>+        }
> 
>         if (!rb || rb->fd < 0) {
>             g_free(list);
>-- 
>2.41.0

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

