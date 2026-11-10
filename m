Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59B160A382B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=P1KbE758
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQl92-0004qO-Sw; Tue, 10 Nov 2026 07:40:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQl8g-0004QU-6N
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:39:50 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQl8e-0006bm-8Q
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:39:49 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so15158865e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 04:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794314386; x=1794919186; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UUQFFxhaOph1yFa86qG98GxU0KrZ+l3NI8Hk+AvzdG0=;
 b=P1KbE758548aZ7Tdc5x3yob658iCLjWkUCwMsNo17yLVw8/f3egcvLmcA0S4i1fcsm
 ZvshBXBXPYLW8j05/OhG5NFgTcXny+mUtOGhvRZ2EjnQC3A+g4ywY0QVMa8eyRTCHQxF
 dTJomNltG/SjlxhUjvyEEwTz1lPXcFYeuMP0lij8HjWKqxj/YgUItYNerk8ZlQGXr139
 hRyoAQyX6ploMOFAx3o+dHksaetf8xS7x1T7E2YZ7woq09rd0WKYPU5cbpbP1tnnG6Pc
 j6Kbi3LWLWp7DtYGVsSOL+zWA8kO7qP4JKkIRSKtXxUFQwbUqc0pn4jAKsrWWtk8NSpz
 QEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794314386; x=1794919186;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UUQFFxhaOph1yFa86qG98GxU0KrZ+l3NI8Hk+AvzdG0=;
 b=EKNSjjogeiAGqGaU3opGphUaN+Zg+7M+Oh8Lt5cmqqx4EJOOP75R911Dhv2zwgUefR
 DOYnl3bkvGAnKlyR1PAguJtO8TTaCBGt8UIBowjaPONLzzN0JXlHmuUdTN5Qm1Ophu7a
 iOqXxbkt2JvLeLizDmalmwZGZ+3TpcJdpBL8j0s9I2U52EKUZAtcUqFVVWCs/3Qrb0KS
 ZRJVCvyXR3s+lMOzA86BKcS/Kse3QiX9Rq2WTejZXPbdMZF3mOLGZy1/z1B3tuJbjXS+
 loZUr+E81h7EKIGE2ktwbhNus/YIIKCr62D46AadxEztYKBNfUEXZ5mNB9Usim1qfp3L
 UsBw==
X-Gm-Message-State: APuU4Z+bNOcb/iKz6MkPQOuLFeXF0dQzLbU2HcyhKnG7Y7OEeJO9UcQO
 lPudm4ooIxIZWPPtTngrKiHzS9bZQny8kQ4oK/IR9ou9QCHOc1iiO2d8hPGYBnNiQCA=
X-Gm-Gg: AYBFou1/fbK6Wx7nRqXTwMiLG8FWPhI94KDAHyh5lxIvuiia3ILNCnpVZ8ErmrFleGq
 8m3sHUtblmvNN6fBKq0WZB4p8yOjz3NpdX0mFJ8jjIuD9BRgDAkDE+vrgwDmgBl59Y2IaiLE6LP
 +WWecNMVYPg5HFk1cdtOVmCKdOq+MQimk+MnLuDHSiaOj6TGK6+Hu+ScMFlfdWkKnVptMtNzmi1
 fTzLazf9WUg9g1ZHAT/sJD9E79tyHb7Yn4PxlrQG9vP1B7OZhkuhexZDl9HPKgWeHK5DRkwlhYF
 pNkglfnOaBWpRimnr5BG+aSeBqzZgeXWMFmVDpPLaRt4YfV5S8cr8eAjzcLJ88wBjibjSCdAMr/
 llpYOytmkEv1/FSr+X++60XuR/WEJQdfId2oUtsikWT3ohx9+Od6+pcpWO0Eud2hP+XO8oq4+7B
 bIaWkYhblJbhtcvSGZYSlU0HL9VFjnaY4Oyni/1iJb8+bSJNXagMS5kuZk94I8nvDtx9rttQNw7
 /cfSm2e1n21pLDa/Bj0GVIFbDgtWXzE/AfYFmBV7Ijzwi9uGtLPKwkDFfsp6aYOGSLA2ygzcdIU
 T7HmBo0iDYoDS0WnSZi8nHdzA8s01f+LXNW2xI3hPOhyI5su09xMLqfOs/N60WFqT9VYzOH3/of
 opdgfRB49P1gZVRZYEnI1Kbsqi786FI5bf5B68XKwYhD2TYdDDZcOSznf0nNYTMx5AXVZXJZ5pA
 hIqXphw7tV0afld28QpM2O+WgoaDrxpm16CQG4LMN53YiMTPtAdIpl2KutC3G4HJU=
X-Received: by 2002:a05:600c:6384:b0:4ab:e27d:e241 with SMTP id
 5b1f17b1804b1-4ba0233cb65mr40901485e9.15.1794314385761; 
 Tue, 10 Nov 2026 04:39:45 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0233e5d7sm47638475e9.1.2026.11.10.04.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:39:45 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 10 Nov 2026 14:39:31 +0200
Subject: [PATCH v2 2/6] virtio-snd: add pcm_state_to_str()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-virtio-snd-fixes-v2-2-d5b654217676@linaro.org>
References: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
In-Reply-To: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4478;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=ARMQOMlmQT4ia7yLM7QIYNGucWkZ9CLiTOkI+qlBeK8=;
 b=owEBiQJ2/ZANAwAKAXcpx3B/fgnQAcsmYgBq8xCOWemWwzImwNHLPeZsua6FTXJlsoQlxc0K+
 wnBmuEMEr2JAk8EAAEKADkWIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCavMQjhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQdynHcH9+CdAk/g/7BtmR5W+6sfyR4xIop2ohUvY/nR9f52V
 soDskjQZMPwTTJaNQu0zxSF0RFMYqsizlv78C7ydFwjqAr5K8WO4ojB3mtj5zvXqsB5YoQk4GPB
 fVQrCzvkiA1kyneUuSxZ3lzULGTQvXXmICg3hqOY0D8cTJ66iHsQaBEGCmPHJRIU+qsNEpC9w2z
 xuv0k5Oh+Pnp9HJqj4PJ6ey2wkSDoNJUpvUmCVbIydzSFINIaA/sGhh1k3HFkNb0Ga7SaW/S+1Y
 yLNtN3BixtJHYabqTfNxnTxPxelb2QyUjIldV6Vj39HfejIqhhHEF3WrcZIB8NvAQC77Y9FN5b5
 lqcsTFTphQvK/k1bMklZ0Ju9Gh/J6cdpc22aEaaycg6AcUCsvGiG5DmC+fviqB7lqjm11bbjTQT
 ViCml3bS9TKUI4lOhLXTNlfY8twR4ukppp7KWJzAVHfHixkQCtxZWBJQ0TvjztUgdRhw4TBc4kb
 h0kRzSOWphtjgkqhG5YbeXr6GZhStRKJzHPjLXQA59udywbc2rV9dkIEXHePHL3o/PjzNLZqnDT
 CmJa1BWlT/kc9GeQmXTBQCqW5iUiGWQdzP1IIIqtdpZgx4rN3fBZdcLCzv9XYjh51PJ/G5bufpm
 5hd9ANZ6FV0fWhy/x7hMvTAxzCOTlx20NOg+Z7elaNHc5cf6LJAU=
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
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

Add macro to print the stream state in a human-understandable state,
since this is an internal enum and one would have to inspect the source
code to understand what a e.g. "2" state means in an error message.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 49 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index bed36203f2..f1dc03d1b8 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -38,6 +38,26 @@ typedef enum virtio_snd_pcm_state {
     VIRTIO_SND_PCM_STATE_RELEASED,
 } virtio_snd_pcm_state;
 
+static inline const char *pcm_state_to_str(virtio_snd_pcm_state s)
+{
+    switch (s) {
+    case VIRTIO_SND_PCM_STATE_UNINIT:
+        return "UNINIT";
+    case VIRTIO_SND_PCM_STATE_PARAMS_SET:
+        return "PARAMS_SET";
+    case VIRTIO_SND_PCM_STATE_PREPARED:
+        return "PREPARED";
+    case VIRTIO_SND_PCM_STATE_STARTED:
+        return "STARTED";
+    case VIRTIO_SND_PCM_STATE_STOPPED:
+        return "STOPPED";
+    case VIRTIO_SND_PCM_STATE_RELEASED:
+        return "RELEASED";
+    default:
+        return "invalid";
+    }
+}
+
 static inline bool virtio_snd_pcm_state_prepared(virtio_snd_pcm_state s)
 {
     return s > VIRTIO_SND_PCM_STATE_PARAMS_SET &&
@@ -310,8 +330,10 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
     case VIRTIO_SND_PCM_STATE_RELEASED:
         break;
     default:
-        error_report("%s unexpected stream state in %s: %"PRIu32,
-                     VIRTIO_DEVICE(s)->name, __func__, stream->state);
+        error_report("%s unexpected stream state in %s: "
+                     "%s (%"PRIu32")", VIRTIO_DEVICE(s)->name,
+                     __func__, pcm_state_to_str(stream->state),
+                     stream->state);
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
@@ -535,8 +557,10 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     case VIRTIO_SND_PCM_STATE_RELEASED:
         break;
     default:
-        error_report("%s unexpected stream state in %s: %"PRIu32,
-                     VIRTIO_DEVICE(s)->name, __func__, stream->state);
+        error_report("%s unexpected stream state in %s: "
+                     "%s (%"PRIu32")", VIRTIO_DEVICE(s)->name,
+                     __func__, pcm_state_to_str(stream->state),
+                     stream->state);
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
@@ -624,8 +648,10 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
         case VIRTIO_SND_PCM_STATE_STOPPED:
             break;
         default:
-            error_report("%s unexpected stream state in %s start: %"PRIu32,
-                         VIRTIO_DEVICE(s)->name, __func__, stream->state);
+            error_report("%s unexpected stream state in %s start: "
+                         "%s (%"PRIu32")", VIRTIO_DEVICE(s)->name,
+                         __func__, pcm_state_to_str(stream->state),
+                         stream->state);
             return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         }
 
@@ -635,8 +661,9 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
         case VIRTIO_SND_PCM_STATE_STARTED:
             break;
         default:
-            error_report("%s unexpected stream state in %s stop: %"PRIu32,
-                         VIRTIO_DEVICE(s)->name, __func__,
+            error_report("%s unexpected stream state in %s stop: "
+                         "%s (%"PRIu32")", VIRTIO_DEVICE(s)->name,
+                         __func__, pcm_state_to_str(stream->state),
                          stream->state);
             return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         }
@@ -736,8 +763,10 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
     case VIRTIO_SND_PCM_STATE_STOPPED:
         break;
     default:
-        error_report("%s unexpected stream state in %s: %"PRIu32,
-                     VIRTIO_DEVICE(s)->name, __func__, stream->state);
+        error_report("%s unexpected stream state in %s: "
+                     "%s (%"PRIu32")", VIRTIO_DEVICE(s)->name,
+                     __func__, pcm_state_to_str(stream->state),
+                     stream->state);
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         return;
     }

-- 
2.56.0


