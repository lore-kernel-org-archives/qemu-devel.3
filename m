Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2283C606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OLj151RU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQj8i-0007s1-UH; Tue, 10 Nov 2026 05:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQj8h-0007rA-3S
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:31:43 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQj8f-0001AS-Ad
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:31:42 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48fd2e38825so1139901f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794306700; x=1794911500; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UUQFFxhaOph1yFa86qG98GxU0KrZ+l3NI8Hk+AvzdG0=;
 b=OLj151RUhJd8WK0njb875cf1G42pwtgB+DSJ28X/gK1LtR0SW4PVO7vfiB0jjzI8r0
 cy6WSuYY40C7I9hh5dhNmUT7eWAu6tLq0QNv/NVxGkpCu+BDOaPooT4pJDNxDKQeJ/Nv
 wTwH28H9D2DfjWR+XZfMYZhB/R6X7IRcevaGG4bn7nD/4F/uB0vhMvhRImKLnhUMadDR
 d42QS6LmI8PJ27oBpOvhx1GgMmblquwrC5Q6D15N5GPZxOVQaF8vwSANFn8j48rGb+sJ
 J/khLCAzoZMPHMFL1CQKxn/bwVzTu99Cp9RRAHytpjHATwe+J/f/BFfwVNmVgUdM2VWn
 D88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794306700; x=1794911500;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UUQFFxhaOph1yFa86qG98GxU0KrZ+l3NI8Hk+AvzdG0=;
 b=Pg0nAN345vNL/CBhWXLySI0iIxudy1BV8QZ0ThQakqL+nmmR90viFDYnYqYiN7wdlm
 YOR7PJ+V5t3ZhOkV9QONc/eyzYbsc/C8yca2Tprip0+77nSVOvqkqvjQ39gB09MpQ9MZ
 6tsLO9/F3J7Jgz2H7fKDF6CKgrn+VrEy7JzwKlxY4hjDNs39SNQHg39wUl06Pc95Ozrs
 d+e6AzjS2c5KKuHIPvR0C0YJopskj+mPTzTAYc8xI5oWpveMQjXSy+AR+vsIRoUoG+aN
 Hok6x8IN7/AJ/Xw95ZYkypPGpdOHrEcD0nCQwyHax7phVQKbv1/L2kYgAb56PuoQXGsW
 eMdw==
X-Gm-Message-State: APuU4Z85XsIjrCZKrUYwhfAncC0EecsX1xCSVQl1I6y8mW0jtEuiXwGJ
 InskijS0prSXt27law/LA8FyIqyajn75gzXJjUKeW/foP7GNl77Z/aoU9VZS0IxBD0vVAIFmUGF
 J7Yam
X-Gm-Gg: AYBFou1QpdXCNuohsUBw+Wfx2pmsicIPZY/o8yc5Dn1qBl3f1aE6S0OkRyfA66Ro2Qg
 H7SN410AuXIvGfyiFrRPRla7ObZtChivQzcnlMgB5GS1dxWA8qBibrCMNsC1w0d4BkJa1C1FaHF
 iVEhhhFx6q8qjzFsi4vaHZc9mfEbEds0Wulej3Vqr6enIT35n1PZFLT/eOTVffRqq2+O8ZwvXxG
 /SHuOrkkW/UcpIzvO+2JLb7loph//LIZpW6HxnMQZI28lJzPZE5rrbFh+nKhzlE3quIvcV44Cld
 YmRCrjvhCKV27UylCIjibel9dS7POtJZomecnmNS2+vAJrVHEdlAwDfzV+0bsmOWZjFlWDJIaJd
 IRGAe33KS/nu0RCv95rrf24+QF8t1G2VWVLtBwBrYqgTogQrD6VWnBz+mfRNaaGjSz8sTm57Kao
 dXNLPoD7USfLTMjoe2oB1D5lB4JjO0+XZ3E+0WK5a4KkYS+nnkpTkeUOQnwANsnh69NBrCGiMe9
 0DtLgCdTSodEL/LubIbDehgUJKorznSpKuIO3fx8T4KNFUrpGeJWMKCgcN+H8Sk5bdu6PBzoqPK
 DV/C7GIurKAZHgqX4Nc/XY4J254AuSXeL8RVUF28lH1/PS+W4X4dkU0sR+OO8MZ76JYjBtFVYUc
 sX8oSgOFXDt/nROp6a2++2KnA6uVO3jcXdBCJpNRMZX2Z7UPROvqHi53Z7jVywIGwhCnx0I53IZ
 b5ZRSox9LxRlJpr9dzKdonsfjKS8zd0av1PZm/ogkBSKd93WV5S0rajBu2tOaMhLk=
X-Received: by 2002:adf:e184:0:b0:493:d5f0:4e68 with SMTP id
 ffacd0b85a97d-498302fba0emr3795530f8f.36.1794306699495; 
 Tue, 10 Nov 2026 02:31:39 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c43f4sm5279060f8f.47.2026.11.10.02.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 02:31:39 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 10 Nov 2026 12:31:31 +0200
Subject: [PATCH 2/6] virtio-snd: add pcm_state_to_str()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-virtio-snd-fixes-v1-2-544d6f9eca38@linaro.org>
References: <20261110-virtio-snd-fixes-v1-0-544d6f9eca38@linaro.org>
In-Reply-To: <20261110-virtio-snd-fixes-v1-0-544d6f9eca38@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4478;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=ARMQOMlmQT4ia7yLM7QIYNGucWkZ9CLiTOkI+qlBeK8=;
 b=owEBiQJ2/ZANAwAKAXcpx3B/fgnQAcsmYgBq8vKHkldrah3jDaPBmq3tIFxI7dGskkYQOfADC
 wiFyN2freSJAk8EAAEKADkWIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCavLyhxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQdynHcH9+CdCmGA/9HmuGihJG+RPqgMhF1PcXeQWSCLyJVNv
 kuC96Qa+g3BVX5LzSzW4rVm/2jYyEAmor5Kugfv6tBwe549uoZrmDmTyjbz/aOO48y/agRTSq3/
 zxuxfslkF1E8FgEQJVQHr0zzBMjCc18j+/doUB+DzX9H2fQ610dtrrOmFsKmcQmm3EB3R85k/Hs
 Cqyn1QamGmeJB5o18sRPfBydqVKWnc3BUs1xgmKJoW8LWlO/MFoYQW/jVnHtMrhIYhHoubMZwTO
 BaeKlKgyqCYrsjIcQrd/7F6d5DaG8eNwJNLl2Y8JtyyMCsStydEsUnvrA9UgdqkvsDOI3X4tP98
 71bxJ2/b9ROnGTYAadCWjHVtTktSbEtgOeRqdTYyXNrPFw4m1tTrCtFwtJS3ZND8TkfYxljnhKj
 04q5TiXDMjseekSqxVihouEnZkN5pEFOIwbYylTJNKFiWV9/USW9ppLbHOOmYcuNi4pvMXthQg4
 VDxLps49oe3jDlPL2AkoTmSVpsET4GfctzV9C0TATXeyZ5eWckYhIDLI2/k9ckooVmw3/LN7pys
 gSp0NsE2MehznJzNz+huxUecLqttMwB/p5FPnp3iOQSq/5UnUHuLxUjwov2D/Rn4zY2u2vUGNkL
 tevuxdMG+KM/TqpPAcMOEYapF6AehSsZfYTDBGrq7LAeDu5MiAFQ=
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42c.google.com
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


