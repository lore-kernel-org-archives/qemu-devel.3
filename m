Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D5F606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=C+pBAX6t
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQl9n-00050t-Ip; Tue, 10 Nov 2026 07:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQl8l-0004X7-Tr
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:40:01 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQl8i-0006c5-Cr
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:39:54 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso19064015e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 04:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794314389; x=1794919189; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aiFNorPS2vT4MbCOHhd4fYXGnRl/hE+LcKapaLUxH/k=;
 b=C+pBAX6tviOZwGxyvvKWfk+9I5C1qHGUNJcZIVY0jQlNWCtqpwz4N5vldrN2hhDLQN
 t0anNgdUY/Bgzx2dIdMgNv9ta/4WnS4+aGk89FRbDi1epTE6F2ErWkqRVCvHMV4APZ1/
 +lVDlKJs+OTNPh993u2zYyu57ZvF+MaE82UuBYVUy6vC/drDNuDMK7qBZ5/ASPfgZIRc
 swDskT5Xm3dX2dYlq0ZKgu3+NOyD+2XrFR0yRcIZ2+/1Iy5NTRpQYebIAnTs4sDJ2Hwj
 sWBLSzTf5dajcnrQS3ZLQvJ1slQ0ygk0ZV80gOReEpEVJBd7DmBh0KXWqDP7Xl5o4yyA
 xDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794314389; x=1794919189;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aiFNorPS2vT4MbCOHhd4fYXGnRl/hE+LcKapaLUxH/k=;
 b=NmFiJOq57ZFq4xlarQy6ZoV1KVoTnA2ejXWcNyx/p34CmrYsJSSbUPwuqCu6e4b2tu
 8aMxDVlAaWlbtZ+MxaOiRGjdimWFzMYfS+zCj76SvGGkRRqWfEONwPYZ/Fs4soiNYIa3
 ZAdg5TJ/fj5W9qaS8XQUke5knQekvcGwRq/Nm0oI/cRwb6+QOWheb5bPTLZ4yOuwABy4
 sa3iCc5u8gT/wOUE3Qdh+OIJYGYsTZNIOXqJ63tp6pcA2er3EcNoH0shZ2ab499H5AmD
 cIgJZUem1NL8bJFZBZMbA/3YpDU2P9PoZ5GPIzrENLghcD/LuR3n92W31eVFw1M9KmBp
 rbCA==
X-Gm-Message-State: APuU4Z8i8CLQVTHuE/UcJ3VpvyaUE+sNKTYIoOLStCM92gB+K6qnhXBt
 UDgNtaCdkChbzrIY80CAs0NS/C58vMBgk6IDSZ0IKvJdraFNCse8jNs/tiDuOZPDBIM=
X-Gm-Gg: AYBFou1P+T/UK5XA+6GORa5hQ/DdFx95Bc3+G12c74yoVauUHe7HVx81B4nVBkK5Akx
 pMLfDrcqQ1i4H7jXY4FMVBM67TrXXrVw9RGCZY17gfmCYhKx1DXn5xp9e8qot6R5IXK8ayjFSww
 aBTQBwf06TLlIavC1OvX3DGySutKhK8Vq2Jp2bBj0JTnaGqAtRedbvUbbNNLNzChFGrJy8uXRAn
 Mj6QajNZMTUjpbhQitw0A04xqiAvWFfUl/rqQFf2EZENBBDX8lkHHdpCrKFuGlkOmNR4RcDHtkD
 jLU97Wpun2B+4bFNMANIzEbanRpALMuG3Phj7mcccMKxoq3o+coT2YdzHmB7353laPyp9RCF1+d
 qIi8qz51SYQUOIh0zd813UbhDggqzh2xgx8PchZCFidhfThooBSauwx7LmYsDN+EuyZsvcOLm+C
 Tg1sKqhONdB60G9S7K2j3ND06ypWqraGd1pFm24cNJudfpqsbJAp3oy5I5c51qmmnKEKQ58H36j
 pPWWCy2RhnSC6pLKU8osojjSvfL7jyjPhm/E0BIG/w0WM8rdtTpPn6q8jpPEJQPQBFSCHhNz8pC
 woBFy8Kv+XiMGJADHbJPWHaIbALhhbWmifvU4cSbvvTqAEQyqPU1/T0ZPD4ujf7yMJq7FYVIaNb
 pLI+bru/IZMkL4kzQqZ+TP3EO5h3B5dg/Q2wNr9Ymfz/nZ+5BZ8V1mh/Hbqo+GGXkhF8uktUWF+
 Ck18jKFH4sAfTmOg9ybjOFQIMwZRoOkF4hjVmaCHj/pmK+iema0MdaVErJIZ4Byck=
X-Received: by 2002:a05:600c:8506:b0:4a1:d087:f6ab with SMTP id
 5b1f17b1804b1-4ba02346b62mr42979425e9.18.1794314388740; 
 Tue, 10 Nov 2026 04:39:48 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0233e5d7sm47638475e9.1.2026.11.10.04.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:39:48 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 10 Nov 2026 14:39:35 +0200
Subject: [PATCH v2 6/6] virtio-snd: period_bytes divides buffer_bytes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-virtio-snd-fixes-v2-6-d5b654217676@linaro.org>
References: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
In-Reply-To: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=tAltvfvEShhXkSh940g0g6nIH/2uwK8GfvFwmNWUDJM=;
 b=owEBiQJ2/ZANAwAKAXcpx3B/fgnQAcsmYgBq8xCPxLurSmsddQrro/xVcU+LJRjlungSGm6pW
 NjkSnyPUmyJAk8EAAEKADkWIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCavMQjxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQdynHcH9+CdDH3w/9EB372/NyArpTc/oWXeWyB4URK5UU1iV
 Ja9vDN9FbPIumXTg2n4benTNdavYG2f4zfYXaULkUov1TWnPhlbsydN6MCtooxjqEGm6gkawOXa
 EtckzMkHss1kmxKae9TpGj6AAMONRfMYpjFx68R9Pg/OWNmbqF/zzvct0ds0ujWvv93KA+dFFyc
 9LuL2y5i31xklRjEr6+n93M84dnUB8RY+cAwg4yPHhicZ0+UhujoALLUvxj42dIp7V/dJnmv3U+
 QDoZEm4IKEzyvTRuBPSc07bW0nVp2dRcogqORlObbZorDidzG6q+3eRfxaICfue9fl9mSKw5g/N
 U5/zr0GFStjxhcAmyc21p8yyoeyShTdc2TRiA3PW/jYQoKhCq1gK1jV/Grx45x1v4LZ40F4/uyK
 /NQk0Gk4muM8BNW1HcxwsvCjJoSe6c/95lNXTxhuI3SXtKe6gR1dMNMRbH5cP3Rpx6FBmqd7wZt
 LJfWvV2ZVjw0c2vh54ZhB5zTHHwn5zX0/3DVHJ28ET5692rYB8Iu7GJA0ctCG1dqUEDPFdln6Df
 5RFU7ywkUAvTUWWrZ7hYP+GoCnSFmq3bIiiV64LHClJYwgtcsE/20UGNxk7lF67bbtaaDbNwScR
 LsYLo24KeBV+m+qgGLxBcGGsUBgbpfUyvlYNAjR/tUqcuu9B/Fsg=
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a check for the VIRTIO spec statement:

  5.14.6.6.3.2 Driver Requirements: Stream Parameters

      period_bytes MUST be a divider buffer_bytes, i.e. buffer_bytes % period_bytes == 0.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index a6036d5b75..1cbc4da752 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -380,6 +380,17 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
+    if (le32_to_cpu(params->buffer_bytes)
+        % le32_to_cpu(params->period_bytes) != 0) {
+        error_report("%s: 5.14.6.6.3.2 period_bytes MUST be a divider of "
+                     "buffer_bytes, i.e. buffer_bytes %% period_bytes == 0. "
+                     "Got buffer_bytes = %"PRIu32", period_bytes = %"PRIu32,
+                     VIRTIO_DEVICE(s)->name,
+                     le32_to_cpu(params->buffer_bytes),
+                     le32_to_cpu(params->period_bytes));
+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
+
     st_params = virtio_snd_pcm_get_params(s, stream_id);
 
     st_params->buffer_bytes = le32_to_cpu(params->buffer_bytes);

-- 
2.56.0


