Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EC0606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cFoOiYtX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQj8j-0007s2-0O; Tue, 10 Nov 2026 05:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQj8h-0007rD-Kb
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:31:43 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQj8g-0001AW-0d
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:31:43 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so1235736f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794306700; x=1794911500; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bE0MkVWcxILSZWgWMvbEB+6bNpUfNj5i0lViA4Ssjjk=;
 b=cFoOiYtX59RWBJf1Wy13nuz/yz6jrrvI6yQdEtj/pbWRxLeSzEuwligT3hCFWr718d
 t0968k2tixPzSCyZbKMVB1C2o370QoBv4vdz+oHinqSenHsF8kooOUS12TaL800EYXB7
 JFQQ0X4lf1sFT1hIo1D/fEQfIj9G0bYtrxFxEYADW5EhmBYR0NkB+DCa1MBNYFCWvyVU
 hiUpYpQiUfA6Z2NcKTRCErvLTpPTJDLyDSOgXh2/Z7lK+VOM+hmy1+xkr7LheFCj3Ye+
 i+TmHPeIynB3/BWjeSgxorMIs8bTEcwrqjHIQ/Ufi3kuWTOYCbmgFo8jAP378ODcPSZy
 vakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794306700; x=1794911500;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bE0MkVWcxILSZWgWMvbEB+6bNpUfNj5i0lViA4Ssjjk=;
 b=dCx8Pz3XoGmRvQW4M4umRMpRqxAGgDpqWCLBznIBTTs7PDrQr2jEJ2LWiwDm1e03Ou
 ZcJKclSjGGSkonuSug66l8OxQJkqzfGEz8CbntelEVVcV1+uUSzEEzZno117hNCWSDnW
 jgUKEkuabOCDr76l0veWTU+oPEr2DDEQf18g/9Rmlzfg39RaWgmgm9FzXfMtsy/jqGz+
 nKFnJmYHX8Cq7LHBTZo1tm4b1GdKG8+iYbX2zvGt2yqkG16TRdbxyTNxH3zEO9S1+aOs
 fgZY7z6ZvVfpVngDc8jzZ2DZzaK6usKzWpQSc56mMgtgNB4ZNdAf1cIuLsaSOehpbnus
 0dBg==
X-Gm-Message-State: APuU4Z9o3/hpml2/6jDHiaA51kZ/n12VKF8n4ftSGTconqmjNWFyeREt
 kFbr/dppLrnjOTUWQYENwpfIHi0H7NzzNCXe/OexspZ0n03hurUEUt0fxnv1NNmVMMFSEZvD9YC
 F0FHv
X-Gm-Gg: AYBFou0GS/omLh3SX5G7zUf4QzxL9jFDQNSG6HSMSqEbbEG5ZXFt7P4YsohSEFswLSC
 Q/m304LGE2/YrpElrPonq8Xrc1Ucq+4zc5FSghTcCEy8FB+fxLnvmEcwseL7PBZ358oMOjKbOqh
 jPQE9HYLMGPCBEWilbsvQzaI4WShuR0OYIShKwdUnZdigtOGK528zRyv8FbM2ajj6dIHVSzda9C
 fIRYE6nzOEIXh7LAbZyVL+JhuFfqISR+RivSppEHXRkUZ798FXysk07FDhZdJHjfQ4JoipKvoT/
 qCBu03xzT3mbG4mx9tKxCda/13sXNFbtagS3DAmAaxMdw8/Ns/syeC10kVFEWKavR2388kkGiRt
 sd2xlUl15xK2sfqBOKwiYcG31y3hrQn10JgK1n4mik9PLh/1MmaXkh9EfabKS3w0oJxIqYYdqO4
 K4sq9CAP9TZmPQbXMFi1SFdFpV2uE9UOVuWPzkXubKITzhTnNmxPo73xm9+THnF/sryl+I9r+/2
 7drg5vlbNSoMp7MtDb6QTeoR8YuoVBdmET7l0jBLVyNQr0bm2d5r3EgTuV4nMMRshHtLRPiA+EB
 7huB6pSo5hCTYDU2L/Z2p88PZ9nP6hIjElDwhIZjRIG70uTPbV+bMKKKl7n2lG2PtXZPgfYRFY2
 z1VkM4JCbZo6u0IYKsEhjzfJAgVw5bZGg2g91/ddmHYMcz1Ooh4nRJX986SIQj2FiMbIE9ZuenC
 +/ObKZINnP5FRAPrv07aLjHfOLVsDiNNoPxxC1U0qjiEQDKW71KaEpy3EOEmBgRh8=
X-Received: by 2002:a5d:5d0e:0:b0:492:905a:8b22 with SMTP id
 ffacd0b85a97d-4982c799164mr4058212f8f.2.1794306700330; 
 Tue, 10 Nov 2026 02:31:40 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c43f4sm5279060f8f.47.2026.11.10.02.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 02:31:40 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 10 Nov 2026 12:31:32 +0200
Subject: [PATCH 3/6] virtio-snd: reject invalid feats in set_pcm_params
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-virtio-snd-fixes-v1-3-544d6f9eca38@linaro.org>
References: <20261110-virtio-snd-fixes-v1-0-544d6f9eca38@linaro.org>
In-Reply-To: <20261110-virtio-snd-fixes-v1-0-544d6f9eca38@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=9BL/iXuPLKN+S9cY21gLG5VaqzrQgJnX5veQ6LJBBmk=;
 b=owEBiQJ2/ZANAwAKAXcpx3B/fgnQAcsmYgBq8vKIQtq4i+vSLY3ZpMwZsxtM+aOXvjd+iFhmb
 eah1mZuz8mJAk8EAAEKADkWIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCavLyiBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQdynHcH9+CdAR6g//bTYzIHuiHqQs8oWE00jNAueL8TW9gRg
 PNykBNQhyWEW6HqMISUF/xZDcqoZ9mPx9mbdKfwSmkehayFEi5pu1tg3zShdOVH/4RtnMJamXUh
 0f7xiVRYMkl0DLFVGn7lng3/AIADttTkUcIux9/aNGFDVa5k3Fo9MzS9NCM1UDu0N2LKjpoEfIi
 fFuR7Masi190XDV3do9/BXJfC/iMYujUnfwhlp7jVaUal1Ku/6FhOt5q+4lwm+3pgKF5SrbdBoQ
 xMYRe4PGA5Tfp2MQnBYerQPtvx2a4gA4a3LO/3G44YNWh1fuWi3qyv/3nnlXRjP4Eev9ct4RJwI
 ZuhfYc/tf82fsZN8lIXx9C6sHUWHKGK9EDA7kkr4Dh4ISGGpTXdZEAiBCXHjjPN62wnRx3/z46e
 VO341K+7+x86AEF0dep97+x/xTrgL3HoAUZNq3C1AKsB5Phac2IdlB7NsHMKa4Z4WoWOAs2EW3w
 dqE3B4aD63tO0arKGjhPhRUamTI3Phty9XdcE3aPZR7pM1CsL6pC/dM1YOrNYSXmOQnjSNEu/Uk
 XfqDb8Fj6JCkNeF0U2ONmMgDM6v8HbKdAZt/mO64H1PGhxkdrWaYSpdTsypG30JSisK+lPnqC+j
 thOBjjHj6NJAAEULPAMeMOEjefp9qCRlDw1mwOnOHWUYIZ77OAUs=
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x431.google.com
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
 hw/audio/virtio-snd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index f1dc03d1b8..8695a4651b 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -351,6 +351,17 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
         error_report("Stream rate is not supported.");
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
+    if ((le32_to_cpu(params->features) & ~(stream->info.features)) > 0) {
+         error_report("%s: invalid stream features. "
+                 "Stream %d offers 0x%"PRIx32", "
+                 "guest requested 0x%"PRIx32
+                 " (invalid: 0x%"PRIx32")",
+                 VIRTIO_DEVICE(s)->name, stream_id,
+                 stream->info.features,
+                 le32_to_cpu(params->features),
+                 le32_to_cpu(params->features) & ~(stream->info.features));
+         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
 
     st_params = virtio_snd_pcm_get_params(s, stream_id);
 

-- 
2.56.0


