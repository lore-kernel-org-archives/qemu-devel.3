Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29519606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SnfDc7n1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQj8l-0007t2-Ey; Tue, 10 Nov 2026 05:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQj8i-0007rs-G9
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:31:44 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQj8g-0001Ah-NF
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:31:44 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b70d5b07faso2267250a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794306701; x=1794911501; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mMnTqbgA/u8irVTU6krX/Y7diqJSDml6WoXSbHPBoEg=;
 b=SnfDc7n1hL5nsoJMXRZS1pEJMIOqjHNP9X2d8jzA2lzDibpziCJiJDSR1HnyW9nPBz
 ljslY69otSfek6aUMRmesU+yE0ZMAwToeuqRlkyvogOn8atL9n8ehBivl9IoPLcoz2Xm
 O7LTfFzqm+lsY0BVfPWGDHdcqp4OBGdiU+GEhTY8Qo1o5lMsw4ozu5I7c6/6VYAVZbl1
 dI8sbHR4FWjQPV5JXes6995S8e09re7MlJfVt2TG5UxgCr3iAvByhRF3RFD+wMecXOkq
 1LXrUMPdPZUe8Ulbcd+PFW4rMER7qosPa3lHfDyeZptYUkH5UDkHoCe5KnD09EIGaCXm
 dqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794306701; x=1794911501;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mMnTqbgA/u8irVTU6krX/Y7diqJSDml6WoXSbHPBoEg=;
 b=sk5Hv4Z2ny1LhuKSzdiy0XdiKjXRXBLaywCCZVfDsPBF0pnJd4fqFo3MjkvuidkvLr
 HhI2b+RgyaAbigRnIOvBR5MjyABR9+A9ojy69eIGRhYnR7pvDnhxN4MW1FA3ol9VlRsk
 6Q7eY/3+gVJNZVBNE/4lgzV+LcQ2wgX4DDcRUTLXgC4T+T8oGIg8xZAuDsSfA8BhZtWp
 A1eaG0w59FKEnDTXwpamIlMuQExyhHh0g3qu+d04r4y7pVd4qbu24ZgsX7fCI/a9qahu
 exDAvQ/2buk7ebJl/eJeKU63vv1SzbloXBHBNISias2jAd6+3di8M7okuXl8XKBJA7cU
 xaaw==
X-Gm-Message-State: APuU4Z8DD40C1uZvncNNYCynEjPBPEt4P2iM49sTmmvVfOeeAJmQMLmF
 d707Ze7nwFgPrgMpRQlQsubE8FkHMRs19v03jGZ7ogszIF4GelyXj4ATtADSYd/4yW6C5+aOtdI
 zk6pk
X-Gm-Gg: AYBFou30wxOzIjXCX3k53fMEtBZi/A6A52mejFzmFQrOsMNYG7LPW4IuOGQ7opAVPOW
 QP9lAPyu7uZYVz2c3R2jhWGQWrV9wBFFVI+eSc1YwAC9zzhcapQ1zSeuryXsGn7sUbuBcaXW07m
 icXD9EFAKfp1pSbbv/iRmVdwDp1f62utd6luCbHGArGODXRMKHZbAPc2Fq0HGgPXBauZThFc1EY
 6nTaAsl39zOKat2ZW8217cNumeyDqj/UJBqy3k+BMcW128FqS1JracD4eoxA5HAwBjjyzLf8spy
 fIm3sObwoNQmlA9tB1ygu909k6m3WY7eDYyCJsK5Ta7ODwyR00f60pLVQsLeSvt0ILyrHKaWo8P
 39R81H85EJkgDt2+mzOzUbUWG5Wv2n9fmUWXqlIKWwf0HCwWKw4rhiFV2he6MDap+JfsBVkNBOZ
 zf8QwUNm6i8VmRglkFne/8JZ1TwZ4WeWvEFOfR3ga0qAZj1BX5bNb1LGFXTOpydE9ZR/y+0E6dQ
 q3n3rsOXbUR1grMN2kS22EHlNdf41jDfxAAWGuPOZPRP4xxJ2Ikk2Ik5KERBgndx5qJxcKP09Xn
 W6fQOh5ijcUbLtEC28I2ab+NMcOSfwDWPdKU6tQt5hrQaoHwTDm5oWj9YTT/ARSOhrbVUtgaJrm
 9xAz55g+V1a1sAUrTk1pF4Fxn3DImR/CG1hlTF8jeXNbCNU/r19IHJ173gNX/wTsKb41fJ/PTzt
 TgBVh6n22txnjbqLUOiMPx1VsHAkLz8qNRU5hJ8y+5vQROKL+NvmUVhp1EkgQiLeRusQwTJm1SC
 8a0puZvmPgs
X-Received: by 2002:aa7:cd92:0:b0:6af:a64f:bd44 with SMTP id
 4fb4d7f45d1cf-6b756b0d218mr1272654a12.45.1794306701034; 
 Tue, 10 Nov 2026 02:31:41 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c43f4sm5279060f8f.47.2026.11.10.02.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 02:31:40 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 10 Nov 2026 12:31:33 +0200
Subject: [PATCH 4/6] virtio-snd: don't allocate pcm_info zero-count buf
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-virtio-snd-fixes-v1-4-544d6f9eca38@linaro.org>
References: <20261110-virtio-snd-fixes-v1-0-544d6f9eca38@linaro.org>
In-Reply-To: <20261110-virtio-snd-fixes-v1-0-544d6f9eca38@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2213;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=YIhvXQ4cL5OVYY1ekkl9ViTCk+LS32wEx/KM3gar5qs=;
 b=owEBiQJ2/ZANAwAKAXcpx3B/fgnQAcsmYgBq8vKIW1frBMnvdxV6qeBWPBb2OLQl3O4psDvNW
 PW2bkazXJuJAk8EAAEKADkWIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCavLyiBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQdynHcH9+CdCjLxAAm7Shql/itnAQ7Sk3svMJpELyzv5zZpp
 8WmGBr2HvzdTz6EdTjPuKe7pdcZ/Y22SC1tYAILPqir6LTYQZNANY64bNwrG0QIlL3Ghgadv4hy
 dfedp4vhnHjCDN/g1XDynzMKcl7fCgZfd5Oi2tg5SyB89sxMJe1a+3dkmln1lKfhZgmYKcOnKWx
 EZl8N+ouLxtAWEkZGtUlgAc9V6QBIxprGfOHRrFH+l4Uv85cS/AX7OC26ueh1I6hLrS75eKf98D
 KLE8HhbAyDZJyv/bFnA24lE4KtsL9LaM9ZrNYN1MAB2I81yacVpWrp53ImD5aB0StsSbgOjFBUE
 S/k7XkXPZw1zm6Ebn6e0FzmdsGC6L/ORpsOT9XlJRwg1yA0G80h/R0eND6YUSkLywGU4I3SBXYS
 nlk923vv6fSp81uWUR3ATIXkXZmiF5SV99gcfbd1zTo3+oXn80D77TpwKKVtU9pRM4qXMLNDfvU
 r2BUs1VR5KIj1sLI2+Tb/OannxBVUqfQInihxo7pcW11jZsLDxWcWjh/teRv9j7iAIH4wOuCUIx
 OWTjyBmB02tJJm917NPDVpZ/gW+UmLiJ5DhmKe3klve5/SDwxgFB+SiAOoJWgPSd+DmwtZOLSQ8
 I4mOnx1TZrsi1zS306zm02uMVvZoGullGLfrCZTkX8COUzPJqVdI=
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x530.google.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

g_new0() might return NULL, which is UB if passed to a memcpy
implementation that does not expect it (not in the usual case).

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3778
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 8695a4651b..a7d749f24f 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -267,6 +267,11 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
         return;
     }
 
+    if (count == 0) {
+        cmd->payload_size = 0;
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
+        return;
+    }
     pcm_info = g_new0(virtio_snd_pcm_info, count);
     for (uint32_t i = 0; i < count; i++) {
         stream_id = i + start_id;
@@ -352,15 +357,16 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
     if ((le32_to_cpu(params->features) & ~(stream->info.features)) > 0) {
-         error_report("%s: invalid stream features. "
-                 "Stream %d offers 0x%"PRIx32", "
-                 "guest requested 0x%"PRIx32
-                 " (invalid: 0x%"PRIx32")",
-                 VIRTIO_DEVICE(s)->name, stream_id,
-                 stream->info.features,
-                 le32_to_cpu(params->features),
-                 le32_to_cpu(params->features) & ~(stream->info.features));
-         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
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
     }
 
     st_params = virtio_snd_pcm_get_params(s, stream_id);

-- 
2.56.0


