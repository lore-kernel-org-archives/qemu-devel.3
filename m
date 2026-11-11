Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E74606A334
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Uc6Fm3rG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR6wB-0000xk-GO; Wed, 11 Nov 2026 06:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xR6wA-0000x5-4r
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 06:56:22 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xR6w7-0000rX-Jg
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 06:56:21 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4b7252a32c8so33083675e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 03:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794398178; x=1795002978; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KLi6GSKTSdxVcJpgthI2AtqH+4LySCUfnAhG5gKoR/A=;
 b=Uc6Fm3rGbS9lQQ2m+RShNrifdTY4lWthAOKNyNnpNo3DdTLBkDpqYI2tgeJTy+nWIl
 4RqtqglJr53Q6tLbfJmGPaTW1AXyZi9NXl/2rqOi0Q4v/dKBeXIDDtG/HmQptggX5wYJ
 Rfw1Xko3+TND0NbyujpWkvqnYtHW+DQ1eDU0lNLZ8CGHSCy9alqWIfJadCR+nTv+piRW
 iamtyttV75eLftA1QVJrX3hhWGjWnUnP1VYUaomtX9/cGICaxN6ijn5IKnDxydloJMVF
 EWfqd+0I4JtVbEGKjnoCfLPEE3lhY9O66LVioo8XWmtjqots9a5Lfl6PDYv2C/ubQpE6
 nywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794398178; x=1795002978;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KLi6GSKTSdxVcJpgthI2AtqH+4LySCUfnAhG5gKoR/A=;
 b=HKup78ZLCFuVx76h4GN6obo6O3+Yol3HpTNA8he2M+dlg7GjAvB0QT5eAXIPipfz1o
 yObKm0DBAcnA0TaUBGYrO3BR64OIjl5zc5xLpzTZlFAyX9iuunzAfRo64+ITk62dy5rC
 3ztZ19DBXtS31E/0tqRDUSrH/KwRGtF4NfXkQLLQSnUbra/wg/GKili7rcWzvo9eb2rs
 hSoNOqHAJKcZ2Dh9MUcEBbXJI+9dnLOSEpQX+06tdfKQ9JVX7tpOXkYPAmiMe5o0QGuo
 lU9CzwfT6Hy8ggPp2pI/Bj8niztKvD41O+VvaMMn2g615/o900V12ESH2/b/jIsp1CfI
 Ct1A==
X-Gm-Message-State: APuU4Z+uFZOEcvbPnfNVzEKOTVy1NHozhXq8lJk5YCxOuVuWFKqbC3p4
 eSLIjBcVmggGp6ztnSxBQ3r38jYp1vYDwHaST8bstQFwU4t9S+V6i/Umcbypy6fe6U8tiIUZYrO
 628vc
X-Gm-Gg: AYBFou13KXYEpfy1W45f5k4l5tryiCaOcD7s2pbwnhdwdXVLQJn0+SjT3f/OPrk3BQL
 A9o13GIKJ7Vdi2zY1AnCWRdOAlv6Lcd4WLtcoOqbMmh+5Jjy4WUdVOoAqx/+BfrwPb0Eux0uK3C
 mkGl2VIWg97xufX9kjUKwo7Sn6GmHOFS3sxH26KlgKS0sHi+C5SbP/WhiSIGYqikSMLDR9iTAh3
 H1/MfPeMe0NZh203zgRqhO8lncB9MHhupqhijGE9RKuvXYkJpHFXbS5mO4d3SDiCDKzmqp+x8+x
 uVbC2ovlyk3StQzNE7fSd1+QPFQRhTbrzuKAsc1YAGX0UqD1ELaeu74gZP7U5/VUTGLAIPofVsV
 H8CVRCmXS+os+9W/GBmeHWG+DdJyTpQ1zLShKBcGszlK5xDcDG7O85o6NIbVidtPZQuVSeNxB+7
 lnPNDmagTRKpD7Es98EULmQMcQLHKi9uxp3HrocFcCGO3EnPsvQlYOLa9Nxbn0jOCfHl1lQdIPP
 7SIuLYRmgmJXZLrqdPV29yS41055EXfgSD0prSRhkVhGD9oaC1dLecfhyO84Q995Gq3u0fxlupy
 G/obK+oZU6OU8zrUTYt61hnXmBbcYkFecACrWQRGNwbKO014s0/tqlgwleATHFKg4rMIfu3i/7/
 VvDvomDrBc+t+c9gURr0HRVuKgO1Ckr7LmIBrVYEBJp+WK3TpFvLO1fnJMO5IXUWknAjE/swZWz
 bUsI+kMPUX2gs8IVOg3NvkX8CzfHXgXsaOJk5KzIT9S31ET4R/x/bRMBRC8w==
X-Received: by 2002:a05:600c:c166:b0:4b3:ad9d:e21 with SMTP id
 5b1f17b1804b1-4ba0936ed51mr40726525e9.12.1794398177835; 
 Wed, 11 Nov 2026 03:56:17 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02043149sm128158315e9.8.2026.11.11.03.56.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Nov 2026 03:56:17 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PULL 2/6] virtio-snd: add pcm_state_to_str()
Date: Wed, 11 Nov 2026 13:55:54 +0200
Message-ID: <20261111115559.18557-3-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111115559.18557-1-manos.pitsidianakis@linaro.org>
References: <20261111115559.18557-1-manos.pitsidianakis@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 49 ++++++++++++++++++++++++++++++++++---------
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
γαῖα πυρί μιχθήτω


