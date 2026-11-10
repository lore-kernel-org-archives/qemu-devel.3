Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF84606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nsu7FgrN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQj92-0007xo-Hg; Tue, 10 Nov 2026 05:32:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQj8j-0007s7-CU
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:31:45 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQj8h-0001Ax-NH
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:31:45 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4919a880834so1127062f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794306702; x=1794911502; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1QDWLufcf1Hre/tzaiNbhLzvQuJ1i53LMyeciIp/H6Y=;
 b=nsu7FgrNVN9jxopday2rrAieTmoIewEuUGNuPx0h0KcxC+rXmA3Lb5oILsxufPJynr
 Ei6UT3g4pn+Xfa89a7SOnVoEojbAFx8sO2VUC/QKcT33f2jQCpQQPhgZQfNls5MCHvZZ
 Ut/qsFxFh0p866Qm+H6msVhFXVZw8VFASQBn20/ADNl2wrSIeYJ7eI5ukrXj4XLQEr/P
 gTunq0IMMaY1t3XouMtmhxH5JVhnBfNnJbhUDSNIyPwQwAPhAyOqEgzDUWYFQ+uh0IId
 +1oJy/K3dlyXhCW+O7tYQuAM+0V9mZ5oGHh3y3G5O8tDxFEQo7EmN0bwxSCHtZ3y/Pfr
 z7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794306702; x=1794911502;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1QDWLufcf1Hre/tzaiNbhLzvQuJ1i53LMyeciIp/H6Y=;
 b=PgUpVlANO7TcC+vsskTJUqpVlJVyEqpy1wji9a7x2QiAgmuuiY986Vo5L/xq42871R
 DzCBPPCk6xO2fqgKQZ3/DibLxcyAqww23LJ129NeYatBZOg9Baiy2czvyuR/Yw+UWN0R
 4dMS7ZY9E5JtT56idR2jAgFb1FOaLpM4+FBqTKeDdJRQnjI4gAVdoyJheK2s49tJgcVk
 kYofx/chLGvudrn4E9p6xH6xDYJyoqbCk53WxMe389a3Ght3Pw1rEo3LBIGgDKx1zsuv
 2BB5XXjNvfiUtHvsBkCCEzJnqDiePyQY7TrWGsBoKvT+aHy9pX6uI+awuu1oo/h3whyV
 k4Bg==
X-Gm-Message-State: APuU4Z9ZYCCMCSUdHzCIHXuo1BaigeJ+rkb9iHBkHXnMTthI1tF1VWXl
 Fwiw795IGasVz4WES/5TbKrdOQIpoMV1Ed+9bQfIdMwFjgqxK/vWhNBfMt07H52ah/wv/HGOBvm
 2WHty
X-Gm-Gg: AYBFou3xHcQGDBA0emN6MVxyyb1WJ+VQcZyDdQ9J+X6OCT8q3L5aRT23Q4blVjabZ+o
 sBsF+fcBp82ArVv61TS71bip4UzVKGQhZOzBc6nVtZ9cEcf3jJMWz/kNblK2+gL/TngZMmy8frb
 SqHQmWI+pSjpTTYPG4OJ9CNdTHGL0rYmb7dYoMxG+NUgB9DEzu1ybPvH+HNudX1veT8txvDJhdb
 hqu5EhtFsb8FqzcwxQGPXfPJP+5omBBzwQcpUrsq2F2HGoxGMA2cPvU7oKkB7Cx8/IVm2AZH47k
 x1JsrKX9gPvBcUFOjzO1ouqY43UL8lNMTp+nN7+WItnU+yPYKN9A2kyomWH/Yi02b1shpRLA0t5
 CBOEw0RuKFLyTNy1PeFcNAeh2jH5s5lcSSoW+8/cepBSHKYyOHEmuXRfKHk7FQJl81C1rmc5+E/
 4azg9frxSi/GlBef3QzT09mK7/mQJ20P1RZC9711FUxLFsY9iU73Q2Qqz5gyOhmXpkRLM7LOG2k
 54hyXtKekZW6GZsYawhMyKO+l1XLunMUCOsNdJuq0aRHaYW396OR6PVhsnwq7IcZuhZrSywJGEt
 bX5w/CsKmdJyYtNsug7+dSpq3kIhTLEC6bDH1AdJJS6XDbXm5I6vA+ka9ClpPu74r/3NejX4+d2
 Epoxu284CZPmhphJbRPujRDDD3oa34eFfr8WuZH2THNKUTLaM8EUzqVg1h7HgQCM1h2xPqz4jzU
 v7pobJvvizxcsUXw6rig7+eAHhTD0i0AcPY1K64UBB94W2ld/RWMxK2oq6Z0cSMFY=
X-Received: by 2002:a05:6000:29cb:b0:490:71a7:6f51 with SMTP id
 ffacd0b85a97d-49830b97c12mr2713381f8f.45.1794306702011; 
 Tue, 10 Nov 2026 02:31:42 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c43f4sm5279060f8f.47.2026.11.10.02.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 02:31:41 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 10 Nov 2026 12:31:34 +0200
Subject: [PATCH 5/6] virtio-snd: cap maximum buffer_bytes to half a GiB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-virtio-snd-fixes-v1-5-544d6f9eca38@linaro.org>
References: <20261110-virtio-snd-fixes-v1-0-544d6f9eca38@linaro.org>
In-Reply-To: <20261110-virtio-snd-fixes-v1-0-544d6f9eca38@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1860;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=JdPly4XUOVOuWfMB6buCmU9psYgf8xH348nhmx7tpcQ=;
 b=owEBiQJ2/ZANAwAKAXcpx3B/fgnQAcsmYgBq8vKIUQxIyvlWZkHeWTB2xbTYPDZeLGn2xkoaS
 YNSHCbHOUOJAk8EAAEKADkWIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCavLyiBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQdynHcH9+CdDbwQ//Un7X1gEGzxQHKbvbGKguiHamrauo5Ht
 9+rHDqV6pbI9t+tl+3+JTSugHif7FCu3dZKSSPgfm/imDxndjzBoBFGZK1TkN9gQIeYnysqdx/j
 TByaH4N4c0YUwtzvVaccdqBEoZ4dS+2HANbbhQnszZnDAgnjcJP8oZYR5jXUhPcak4T1rRxZ2SF
 JfUSOwNQCZRayX+i9yCzzDe1juD92iZVTTrOeXLPHLLnF7M5jTebOVI1o+rapJ62MdKM5ek/vg/
 aqLzcNdem1xxp+ntxuQQu3gWaOSiKokU/gDtKxnWSePBqO9mzDIkl+ku8lkqOPe4JaOKYvHil2R
 05gdck73S/9Vq28r1i9KbcNenPG5v+m3kGVgDJ9ZYTQoEUy+iNGdWyMAfiJ2vzOAsggisZfGiCg
 zKEOwnEUx7hvxT3wDU63YIgbX6uAUu0/cfNNvfM6yyly3zIGZrT3W69cuzzxV3aG0I1HfYobAYV
 BT/Sd3xzKtVRBM91VWIkq+dj+iLI/u2pDWNXTsff8ZO4ZHwu9wGAbHnDfVm2SUXP7wav+cbTwWX
 tH7kmGU1jNbrS9q90dd5a/QCFePye/8vNf2nCVBpdAttaEdLtietkgZSoN8ynvli3pjSb5XiuCv
 uNGrMKv5AZdbNcVTp18tT10q7rbyvoqeekBc+a/dHAx8fFZmQmxY=
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
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

A faulty/malicious guest can try to exhaust host memory. Cap the buffer
size to 500 MiB.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3587
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index a7d749f24f..a6036d5b75 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/iov.h"
+#include "qemu/units.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "system/runstate.h"
@@ -24,6 +25,8 @@
 #include "qapi/error.h"
 #include "hw/audio/virtio-snd.h"
 
+#define MAX_BUFFER_MIB 500
+
 #define VIRTIO_SOUND_JACK_DEFAULT 0
 #define VIRTIO_SOUND_STREAM_DEFAULT 2
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
@@ -368,6 +371,14 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
                      & ~(stream->info.features));
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
+    if (le32_to_cpu(params->buffer_bytes) > MAX_BUFFER_MIB * MiB) {
+        error_report("%s: given buffer_bytes value %"PRIu32" "
+                     "is too big: over %d MiB",
+                     VIRTIO_DEVICE(s)->name,
+                     le32_to_cpu(params->buffer_bytes),
+                     MAX_BUFFER_MIB);
+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
 
     st_params = virtio_snd_pcm_get_params(s, stream_id);
 
@@ -1037,6 +1048,8 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         }
 
         stream = &vsnd->streams[stream_id];
+        size = MIN(stream->params.buffer_bytes, size);
+
         if (stream->info.direction != VIRTIO_SND_D_OUTPUT) {
             goto tx_err;
         }

-- 
2.56.0


