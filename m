Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11796606A33D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DVgF/2Z9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQl9l-0004zS-S2; Tue, 10 Nov 2026 07:40:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQl8i-0004SN-TF
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:39:53 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQl8e-0006bq-8e
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:39:50 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so15158965e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 04:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794314386; x=1794919186; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fCoqsLvBRnTDkTuukF9z6LZpYGL6TiFTwfrriTck7NE=;
 b=DVgF/2Z913bI+BmAh7596l2im5xA2nP2uOv1pgErXdS/Nck8QrEnY2I2PjhKXEhEMc
 45CUO8MVY2ngihXv+llHtjcyCMH2URTGszhlNyxxSzlK04kHRbtV+gElbA4N43UAHnUN
 5T39qcUqKTKfpilNYZvqFIr98HiZGc2j2DNNWlYLvFGufQxmAmRcQ284VFCPMT7mHYix
 GxWVlvGrzk7pmzvTHifxICTeJgyGGj7gmV54q0819Ep5ftxfI8WFgNdHeclRs2huZ9Eb
 lzqyUrfb6KDiqVr9bjP6m8bMZAc+S7mt2Okw3tp0NTQSp4TMPeckEf0gooXHFbOHpg1t
 Bx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794314386; x=1794919186;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fCoqsLvBRnTDkTuukF9z6LZpYGL6TiFTwfrriTck7NE=;
 b=gSr3WRuvA+E2HxqixPgPrD3yc1OfFgyJm1cABO9Pr/OhiAiD4VD7/o93DK/ev4LIpj
 nQJLkDTsGeBDSJXDpsvt0btcWwBHv7ubZlRSsgQvhzLAV/IrDj2CR4BQF6W7WIKLV99R
 CnBMGuDY9pl0OvkvkcwnJEgeUy+ivVqygBpo49qivhwOhk594FVQJlZQvIZZYXxj3f8m
 yMBLYMvnHMtLmiIwFpIShd+F0dux1R+x4WBseBJRGyUo1spiRRRMvf59MICgUR8CdZ1Y
 PIpxZ3c7cu1OUn90dMQMIPHz1Nq2tT2hVoWjA7fexI2fIcxYpTvJLfzX9T2mg5fMxAWY
 1NDQ==
X-Gm-Message-State: APuU4Z+M+LT3ZFwip3XUVWpbKatV+ph6eYFnXxD9mBdE5LqCDi/s0+hE
 51DJmzPC9eXRJ9mFZC3WnEGqZzhswjFBAak+O3vHXLxRLeWFLYvKydAO5D52y7ckwQk=
X-Gm-Gg: AYBFou1r2Jarsr7QSGLf01BHh2ULdypwl5JlIFyOQGOgRLkfXRVKBr1IT4ZrGFXnK05
 fNTb/HaB0zjIr9nqpIx9e7eI1WI4U0O5703R4br9u3ik8hniq2MNCSJH5idySQ3Zg5hknaG1p6V
 4y2h8CakOWfN3zjfu+qfrgzio9gM3NqKdtVsBhMv6aT5s7D+zqM6Zz4NSwGmz50/axkOZ3SpBnj
 Gf8eHw9OnDG8G2zz7/46PMpV/iEMbN2DaKOa6WrejnEZd/L0PXC13RHtt9HFbmJ7TsJc+akB/6T
 2lni+imX/3652bGzdc+HzOk/sPiOpDLE3k3X4190vI3yZNW9x+vM65sBVZjiWyWrVi3amPeh0BH
 CPK1YnsL9UY4ML/GzMVJWcVu8BSToJhKywlBXw5LAz99W3JrLYPXeUMIlzfOLzRkX1VOP6E4Y4L
 qMBxpKxMFsDLmfJd98qh5O/i1l/s9q+Y5AjC41R9qUwettetXiSahGP11meJbsS6xuoh5HyTpor
 L2HUWsCr5N8mjtEh6MD1M6F+UGZt5GBsEopXaTJQ1wq2pvRWud2c98uHksCYesPTyCFBl0i0nUN
 X6GRpTN+JraOLtQbv6WGLiQoPeSvgJonsKc8qD0Ubrj30DCTwrzY+fCPWSdmscY+SpCquydRbd4
 ve3TwrjXYun/hFwzKuYeWlc5CA1d1g/iSftpAE2mZdxV26sZcpUsYfKtL8k6R/vyBaFYgepC/Ja
 hJT7F6dBmeQXrw3fMYnG3IL2JO4n9OTozNGb9aTx/Fg2sTr1Uj+11ly39FUCjEIV0Q
X-Received: by 2002:a05:600d:82e4:b0:4a7:9044:a87 with SMTP id
 5b1f17b1804b1-4ba0234efc4mr47905435e9.27.1794314386481; 
 Tue, 10 Nov 2026 04:39:46 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0233e5d7sm47638475e9.1.2026.11.10.04.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:39:46 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 10 Nov 2026 14:39:32 +0200
Subject: [PATCH v2 3/6] virtio-snd: reject invalid feats in set_pcm_params
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-virtio-snd-fixes-v2-3-d5b654217676@linaro.org>
References: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
In-Reply-To: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=8eeK35x0KbmYuUFtE8569t2ljmdxp2Af4iESWE4QcXY=;
 b=owEBiQJ2/ZANAwAKAXcpx3B/fgnQAcsmYgBq8xCO1jV+r7H56mZ9ymYK8dJECeILjSiinF5x1
 Vj5/J1grYKJAk8EAAEKADkWIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCavMQjhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQdynHcH9+CdDF0w/+K7I0nDhC+V4mxA65i2Y0f695lU6v68N
 vCh1Qd6vmtDxklLIU4YxGIdJ7Mc10gTY/aw3aHROIU12QYuIqz5hfNSo0sKlQ0pqL42aJWTpufz
 /iy/zfuzZsgH5eeLV/Yi3mI9QnnRQu1nZ80YZkt2p9HMoOnrVVXHaQLGCznffeb62S6nAb3UXFv
 AZnOcUUe6Ec3xbPr0aYJlaWg1deE2HkCMi+T0wv2mMNe6GKemAyIbE9AOYfcVA6A06+Lcxd/ivR
 6Gw0GWnB9Xlt9zfwynxl6UwjuIYPmTnVpGRaT1BuD5HBI4rkFIxL6lIcineNMbUBs1e87ZaZMf6
 731aH6N8K+aaF9j7807VA9eD+EHmLGDVjVWHExwOuV/wfczpMkUjLeMQslGxn6uDeTLGV2tAuBi
 x/N8ZCbGdarAhsiSNnIKHnsfcIHvT9sK1lW1ZvrUL1wQ3oSjLgk9p1gOJ3WGKRUo8an6zifJCoi
 Ub+p5oRKOhoLzaY7dEqAuH2HLAMJfv+Cbjvf97LMhV3fB5RcxmOLY9ixCJDetRWH9Z8tydC9fop
 lvx4j5hW0fxZUZ/k1W5bHFSDj63KafjQ4vVfPYDPjGZ494Zn8uwWTFUQEIa/AZtBgYZtryyha2z
 0JiYAc3FJ9vFxfoYyWAUtd4Bf8zxn/X7iuTl+n5h0ZVfkMMP1lZQ=
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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

Do not blindly accept features for a stream, check them against what we
had reported to the guest with pcm_info.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index f1dc03d1b8..89406f0a3a 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -351,6 +351,18 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
         error_report("Stream rate is not supported.");
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
+    if ((le32_to_cpu(params->features) & ~(stream->info.features)) > 0) {
+        error_report("%s: invalid stream features. "
+                     "Stream %d offers 0x%"PRIx32", "
+                     "guest requested 0x%"PRIx32
+                     " (invalid: 0x%"PRIx32")",
+                     VIRTIO_DEVICE(s)->name, stream_id,
+                     stream->info.features,
+                     le32_to_cpu(params->features),
+                     le32_to_cpu(params->features)
+                     & ~(stream->info.features));
+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
 
     st_params = virtio_snd_pcm_get_params(s, stream_id);
 

-- 
2.56.0


