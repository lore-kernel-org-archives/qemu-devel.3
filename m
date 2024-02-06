Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF2CC48286
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 07:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXFjh-0000db-Hc; Tue, 06 Feb 2024 02:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rXFjc-0000b1-5Q
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:19:12 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rXFjZ-00060Y-6l
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:19:11 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a3832a61a79so16512666b.1
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 23:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707203945; x=1707808745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wwvO77buz/C6Ye6CqMYu9OPrrxj5zzuo2P2AYFXew54=;
 b=TURkCBsfy2o+naCg5lOJ6nKUGnbga4G5Q4gCImTEtOv43GkAOU/Wsu/V/aeMj8uIAO
 FjXR6y14OJbEkYmuKWmGvFOVxzwouqcOs/2TkxxjSdiIUfeJvIIwMN2aZ64mQy65ENmN
 PNf0aNuFX+JekWnv5O2cUTGgA+iPAz1v1rW6RNN7qwWhWSDdzndvmP8HNJxiIJmkD2Bs
 28oFg1pW/XDNnRW76mZ0vhtGRLvwKPg/cTO+cPxhBEU/3xyUO1v8yE/EZ9U+AopWs8gw
 VxSySwsonvlZ89nCK49l4izM4+ytXMlbfG9csMBB2t9UftLdK1lJkAr/opS+65NunT8c
 da6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707203945; x=1707808745;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wwvO77buz/C6Ye6CqMYu9OPrrxj5zzuo2P2AYFXew54=;
 b=R8lnd9WHPm2elW0WRTuehMl1yAcTQb72wlB/ghELOM5zlzHpYXOW2wIv41zOxq1yo5
 xMe+rO0g05aJJmeDMggVL3i5ImxYOBi2FMM4MHwGPcn1xmf9xjqRj12Qgw69UIjkkVnu
 680ye7wOVJCsN0Lg3aVCk25ULeTqB3HX9AJ02mNPwN1ZWEEHBW6cazDPKujkSPYtYhbY
 DnFPvtwnEE3/+YHleyDj5xjYeLf3zrLjQ26JF0x5Crt7PiphIJmBTv8LSMdhREa0oWTh
 +1ti26xAF3qoPz+p364F11XGxMHyTe0BIioKtWmaPvLthM2thzOZhxf/5ouQoCW7PiBP
 i04g==
X-Gm-Message-State: AOJu0YyublP7/hn9ACEY7ZKZZWFTGIOMyg7bjGTUCfD+9w3JRXBj1pU7
 YTfk+hL36Fp8SyjVfokmrXdgJAkry8Dqtivyhl79xutSd5WpftGOIPBZ+dqwViE=
X-Google-Smtp-Source: AGHT+IGHmOeM0hMovAHY9oZRNIz8VxSNsjkFIoRYuBFZZju9aOyf2No0XTrCjat0DTMeyWQiCwFAoQ==
X-Received: by 2002:a17:906:b30b:b0:a37:28e9:bfdc with SMTP id
 n11-20020a170906b30b00b00a3728e9bfdcmr1220199ejz.27.1707203945441; 
 Mon, 05 Feb 2024 23:19:05 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWitvALn/CxAg1Y0ZJETohecJsObSaYtrlu+GfuSrDpDCaUzugFiYiR/0ub6WWc4plNP3chLk3cGyBLe9Fv94hBLUEXCEkFzD9NOQlGW8BCo8WCB/wPQASQpRgnv4xX5bzr3jhbCPGgIuOhMhDfZ118QX1HJotJNhVK51FzFISk43Br6KRDivqU2I9FaAl3r8iq+rQDT5RcCMnKnL1gNdvSopZ5bFOG
Received: from meli.delivery (adsl-245.37.6.163.tellas.gr. [37.6.163.245])
 by smtp.gmail.com with ESMTPSA id
 k4-20020a1709063fc400b00a34c07816e3sm789842ejj.73.2024.02.05.23.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 23:19:05 -0800 (PST)
Date: Tue, 06 Feb 2024 09:16:02 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 4/5] virtio-blk: declare VirtIOBlock::rq with a type
User-Agent: meli 0.8.5-rc.3
References: <20240205172659.476970-1-stefanha@redhat.com>
 <20240205172659.476970-5-stefanha@redhat.com>
In-Reply-To: <20240205172659.476970-5-stefanha@redhat.com>
Message-ID: <8fazq.207jmrshdmjy@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x636.google.com
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

On Mon, 05 Feb 2024 19:26, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>The VirtIOBlock::rq field has had the type void * since its introduction
>in commit 869a5c6df19a ("Stop VM on error in virtio-blk. (Gleb
>Natapov)").
>
>Perhaps this was done to avoid the forward declaration of
>VirtIOBlockReq.
>
>Hanna Czenczek <hreitz@redhat.com> pointed out the missing type. Specify
>the actual type because there is no need to use void * here.
>
>Suggested-by: Hanna Czenczek <hreitz@redhat.com>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> include/hw/virtio/virtio-blk.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
>index 833a9a344f..5c14110c4b 100644
>--- a/include/hw/virtio/virtio-blk.h
>+++ b/include/hw/virtio/virtio-blk.h
>@@ -55,7 +55,7 @@ struct VirtIOBlock {
>     VirtIODevice parent_obj;
>     BlockBackend *blk;
>     QemuMutex rq_lock;
>-    void *rq; /* protected by rq_lock */
>+    struct VirtIOBlockReq *rq; /* protected by rq_lock */
>     VirtIOBlkConf conf;
>     unsigned short sector_mask;
>     bool original_wce;
>-- 
>2.43.0
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

