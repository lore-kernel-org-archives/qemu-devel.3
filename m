Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78D0606A8B3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=j6YEpPys
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR6wC-0000yF-9M; Wed, 11 Nov 2026 06:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xR6w8-0000wi-Re
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 06:56:20 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xR6w7-0000rP-2C
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 06:56:20 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so17971635e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 03:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794398177; x=1795002977; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=waKnf2Nv/NzYI2FVFtNWH+mZNsjkicaAnIDyZnq21ew=;
 b=j6YEpPysyMHs2LegVBQATbZhJBM6QIP6FRYYxn3WRjBr0QxLzl7RhV+7dx1Zh0sxdT
 dSN7IGlBuzsgRhDqZFANF9bTEGjhBg40OrA+AI4GYro8NwM34O95flbYkzv3wmymRmIB
 pI+zenMAR6nNvx5xglEArNFgDr8QFfRVJ7y7+/9E/LFIu0EmcZXJp+vkpa8+EutSZzQY
 HMrFD2oqXWUVeRkZvAdcZ9EdznOk3wEs459aYapE12p2nKykx+NxeuMDysBb3mWEISLp
 hDeRIvxKvVSjDtslwhxixSwsNWIaTHEe0mQ7+cV0ToaiWnF2Ey7nk1QFVIsdsfgZ1ZKL
 4zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794398177; x=1795002977;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=waKnf2Nv/NzYI2FVFtNWH+mZNsjkicaAnIDyZnq21ew=;
 b=nGW1zuaf8RH+ogg14+wrHhHQ6/KO86r77BI8OvxabDLZW8yYDjc0+ledWObUgetHVh
 F9Kz9jcazkI8FaY7zyjrL/I5LUnKYTErq1PkvJ+peNrnr6i4E4Hznxpr03LxOQYWcr/d
 WERaz3ZNWtjvvrHx4ja3pIIwqFsWPteOALnLB8L/2wiaHoOPz0z6UksHrwN2J/8WBb23
 NTHVFFZWJVAFOQmtEphgpRxJH5XcBQRM+OgCvi2w8eSm06vMSDT9wMNmH7KT7C3dekvU
 cLLD7J/34FP23xVooB08QtIVQwxzdI/2m98iGxPWEuj8zxQ1UVI7fEg6+n+6FaEB2ET6
 YeIA==
X-Gm-Message-State: APuU4Z8UY9Suedh5FG1D23DIzmJuC1Gd8KiGM5Jq2Weej69B6i/r97v8
 7mKD8WJv5KVPg+SAMGGlT5oG5Gz9DxzkiRrfxVx4f1ms9xLmrDQ2Cj8ynM6bwTqyzerEW3AsvVj
 ZH9bX
X-Gm-Gg: AYBFou2H3aZOkvFWzIwPeNix5tpwCwLpa60PyXv9lj/54mvUleHpvdY5uU+4ZWvPuaE
 zKW3hIrDIqF0V+VJLLAI5uNhXzdvcc8BPhXiDjmP4dozLlXyGqzJJmfxeoRFrOu1Zz71+VBqYDX
 sxamcb6ulcJhum8vdGH40Fyi58RdJ1Mwo5ac/DeBk59sT872vFfxW3aEJGXCtq7awJvuUdGvESo
 iy7R3vPHOqGW8MX9OclFCO9IFXdFZEW36rIgRiios0vwmv6xqf+tocufrMFs4E3onFAtahQMkLr
 He/BwnD23odomaGSQ0p2GsSOQP1/rMgsZfTKGiwN1EZSwXB1c7w8zexg5m6cP10V8Mt6dZ04yff
 PR92T4jVGpCsPIdRjlVPNDWX+cwEA/3LdIOisByOQq/B13XEOxZaZmLW6QFv9eTeMPP7baOpHaM
 ShxC5YNi93dtTRw7k+sJGvoUlW7e1Yk96zIkLHJuiCXHGjqkpc5ufq455dAphhN6fN+ghP9X3nZ
 F5vJQvWIcgPr7uyNCvMCMcN3cBEAbg9EtoSLPkYHhsYPKRE+ag0dAR3HqqAzYCr0F2M7aVVgHjI
 VxqympTMjR2aAZmvd/N4mSD0f+0ti9TmD10RFUlk170y8hILsZJ6jpmZdlo8K801lG2438Vzy3r
 DgDAZFB+LmGlOT/FeR2yKB0Ej2DZhL9DWThGbqPA1UZehuaRU/mjlTd124VyhWcRszAE/myAopt
 3bsXJC/nVZF14rhHI1KuW9dS7pIdulNHCGJdfJTJz5es2qTRuGTjjt3EMQWV5hHXsfyp5/GtEfo
 jMO/es=
X-Received: by 2002:a05:600c:620c:b0:4a7:9044:a87 with SMTP id
 5b1f17b1804b1-4ba093ab877mr36007815e9.27.1794398177133; 
 Wed, 11 Nov 2026 03:56:17 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02043149sm128158315e9.8.2026.11.11.03.56.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Nov 2026 03:56:16 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PULL 1/6] virtio-snd: convert virtio_error to error_report
Date: Wed, 11 Nov 2026 13:55:53 +0200
Message-ID: <20261111115559.18557-2-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111115559.18557-1-manos.pitsidianakis@linaro.org>
References: <20261111115559.18557-1-manos.pitsidianakis@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
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

virtio_error() also signals a RESET, which is not what we want: we want
the guest driver to read the VIRTIO_SND_S_BAD_MSG response.

If a guest sends an invalid command and we do virtio_error() and reply
with a BAD_MSG response, the guest needs to detect the device reset
otherwise it hangs forever waiting for the response.

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index fb22d79949..bed36203f2 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -298,8 +298,8 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
 
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (!stream) {
-        virtio_error(VIRTIO_DEVICE(s), "invalid stream id: %"PRIu32,
-                     stream_id);
+        error_report("%s invalid stream id: %"PRIu32,
+                     VIRTIO_DEVICE(s)->name, stream_id);
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
@@ -310,8 +310,8 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
     case VIRTIO_SND_PCM_STATE_RELEASED:
         break;
     default:
-        virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
-                     stream->state);
+        error_report("%s unexpected stream state in %s: %"PRIu32,
+                     VIRTIO_DEVICE(s)->name, __func__, stream->state);
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
@@ -535,8 +535,8 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     case VIRTIO_SND_PCM_STATE_RELEASED:
         break;
     default:
-        virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
-                     stream->state);
+        error_report("%s unexpected stream state in %s: %"PRIu32,
+                     VIRTIO_DEVICE(s)->name, __func__, stream->state);
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
@@ -624,8 +624,8 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
         case VIRTIO_SND_PCM_STATE_STOPPED:
             break;
         default:
-            virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
-                         stream->state);
+            error_report("%s unexpected stream state in %s start: %"PRIu32,
+                         VIRTIO_DEVICE(s)->name, __func__, stream->state);
             return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         }
 
@@ -635,7 +635,8 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
         case VIRTIO_SND_PCM_STATE_STARTED:
             break;
         default:
-            virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
+            error_report("%s unexpected stream state in %s stop: %"PRIu32,
+                         VIRTIO_DEVICE(s)->name, __func__,
                          stream->state);
             return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         }
@@ -724,10 +725,8 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
     trace_virtio_snd_handle_pcm_release(stream_id);
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (stream == NULL) {
-        error_report("already released stream %"PRIu32, stream_id);
-        virtio_error(VIRTIO_DEVICE(s),
-                     "already released stream %"PRIu32,
-                     stream_id);
+        error_report("%s already released stream %"PRIu32,
+                     VIRTIO_DEVICE(s)->name, stream_id);
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         return;
     }
@@ -737,8 +736,8 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
     case VIRTIO_SND_PCM_STATE_STOPPED:
         break;
     default:
-        virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
-                     stream->state);
+        error_report("%s unexpected stream state in %s: %"PRIu32,
+                     VIRTIO_DEVICE(s)->name, __func__, stream->state);
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         return;
     }
-- 
γαῖα πυρί μιχθήτω


