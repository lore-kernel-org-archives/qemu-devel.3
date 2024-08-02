Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB67C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 11:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZqDD-0007V9-Vh; Fri, 02 Aug 2024 07:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sZqDB-0007Qc-VP
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 07:12:41 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sZqDA-0006jb-Df
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 07:12:41 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5a1337cfbb5so12865945a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 04:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722597158; x=1723201958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lavbJMgYEf9moKbNFJH2GN3J9/8/DEWhuvohPFrHTlw=;
 b=fbTW92kK7JzB4uEIKsY+j2fS0Osr15ccEisTFUmzVg6NVFxuqOrmTttqwxYHvx5Qz2
 xQp7ex8e1HqLwwi5tjwibl/ItynuDxi3DJ97NGF1ZYrh5xF1LvewF4LUUXFbkvKFVVWI
 P2Bw1EXZDLgHIsLKEyqYlzBXEIgXXZOsMj6Y6c0SSSTFHPLb70Rnk8Upx10z6gxYC64u
 19/hzkS1LC0TMUvNbi1Z/mHno1v1DBQVZ4ekiB8boJVdtp/63ZFcz4GLDYgkCgkgtZ+h
 i7j5yzHx+VFk6UDxjwyprrLjnTPtq1T8d2Fspyu9p/Cp//+mACQq5aQbJKdYoL2Lb1KT
 4FeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722597158; x=1723201958;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lavbJMgYEf9moKbNFJH2GN3J9/8/DEWhuvohPFrHTlw=;
 b=pLFF2qddA2CiL6r8wftpbChOCnfnk5yAYjnQDqjfBiLmb+4pWLK1g0yrckgD0C0YuY
 kpuLj3Yo+grm/06KKgWqizWvPug19KUQlKBkUsDuDDZpusDPt9H2HSTyXltKzUa/up3M
 yNKOoffW8zXzS3n/YYpMnDc/97wQZA5Wd6OAKSxXkPOTzy+Ar7wxbzm6bIemFLQ36EIL
 ZCEzx7/edlHlHn/C6+qmPDmommATBtaQRGKoZUG8W6ZrjKU2Us3L3c7IQ0dETjsm0jB9
 mSG8NFTVQvKgXLJhfOr3a57hX7yxsj9Ow165nYMAy3QEgtsMfumMJQRtwSvylOdUQqst
 THxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzPu/W/uznVPVlPktz6HOR4LkT2ToYHBYFOKjZM10NS7iJTsEf2uLmMRn3R4kY33DoNWeOu354lkVunRaF52AckFRMbCI=
X-Gm-Message-State: AOJu0YzKzGuTeHj4n6y29Y+lUuV9NvjCwEdX1MDsXiUplFWsULogLpZ0
 +GEHgLe8LfdQR+8Bwo9rSe0DI0UiPJ5XHnHfsLFfyvjHke091W9qIqnNEZg8tcA=
X-Google-Smtp-Source: AGHT+IFmi190W8igl6I6jkfSY+KqxYZx/GkSPxJDLTEU6FD/GC5G4gQwIzsaWzTeb+a/WvIie2A8CA==
X-Received: by 2002:a17:907:9486:b0:a6f:59dc:4ece with SMTP id
 a640c23a62f3a-a7dc4dc3c72mr253654066b.2.1722597158360; 
 Fri, 02 Aug 2024 04:12:38 -0700 (PDT)
Received: from meli-email.org (adsl-146.37.6.160.tellas.gr. [37.6.160.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ecb546sm85952766b.224.2024.08.02.04.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 04:12:38 -0700 (PDT)
Date: Fri, 02 Aug 2024 14:11:20 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Volker R=?UTF-8?B?w7w=?= melin <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/audio/virtio-snd: fix invalid param check
User-Agent: meli 0.8.7
References: <20240802071805.7123-1-vr_qemu@t-online.de>
In-Reply-To: <20240802071805.7123-1-vr_qemu@t-online.de>
Message-ID: <hl8gz.cfuid0km5pqb@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 02 Aug 2024 10:18, Volker Rümelin <vr_qemu@t-online.de> wrote:
>Commit 9b6083465f ("virtio-snd: check for invalid param shift
>operands") tries to prevent invalid parameters specified by the
>guest. However, the code is not correct.
>
>Change the code so that the parameters format and rate, which are
>a bit numbers, are compared with the bit size of the data type.
>
>Fixes: 9b6083465f ("virtio-snd: check for invalid param shift operands")
>Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>---
> hw/audio/virtio-snd.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>index e5196aa4bb..d1cf5eb445 100644
>--- a/hw/audio/virtio-snd.c
>+++ b/hw/audio/virtio-snd.c
>@@ -282,12 +282,12 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>         error_report("Number of channels is not supported.");
>         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
>     }
>-    if (BIT(params->format) > sizeof(supported_formats) ||
>+    if (params->format >= sizeof(supported_formats) * BITS_PER_BYTE ||
>         !(supported_formats & BIT(params->format))) {
>         error_report("Stream format is not supported.");
>         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
>     }
>-    if (BIT(params->rate) > sizeof(supported_rates) ||
>+    if (params->rate >= sizeof(supported_rates) * BITS_PER_BYTE ||
>         !(supported_rates & BIT(params->rate))) {
>         error_report("Stream rate is not supported.");
>         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
>-- 
>2.35.3
>

Thanks for the fix Volker :)

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

