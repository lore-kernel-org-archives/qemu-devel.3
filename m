Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AE6606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NZvSM/l9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQl9N-0004qd-0p; Tue, 10 Nov 2026 07:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQl8i-0004SM-TI
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:39:53 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQl8f-0006c0-Dr
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:39:51 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so14115115e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 04:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794314388; x=1794919188; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1QDWLufcf1Hre/tzaiNbhLzvQuJ1i53LMyeciIp/H6Y=;
 b=NZvSM/l9p3Tx+hRFGr7Modgeh43djoiiACDaEFXvof33RMHVodBB20a4/HyBCul5pT
 /vuUTssIQB7F6joLuvTOm7LRc6F7CX721j1rgKeynPwWEx6Egk5zWcjD6A6FfonPuM4D
 UrBMA22ucsATyfymkSOtts0mg8DjBP6XSxiJWGDtQ5F4G3AFr+SK7S81rhNoBL1Iwset
 r2z8dOmZCbeqAYGSVsVO4fPaNT9cQ1lAsOiHftS03uN/pEgt8ydYUIytzHZb9D6VN4yP
 TT5z6xSQ4WgZ1sxO4jOcJeAfbBLUTcuOdG9iOs7ok8VoeFhbXrn/HIT+cVwZHikf9UQr
 ya0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794314388; x=1794919188;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1QDWLufcf1Hre/tzaiNbhLzvQuJ1i53LMyeciIp/H6Y=;
 b=jGTBSAJ6viAYvaCKRREgXd4OxOV8D3K27ei+lxN2JwfKLorCWRyfuXUWQvSbmYuSV/
 KW12Xf+AJ4McDTcqFaUY/lJFnyC80vLj9+UL5YzvAnzu34fEXMCVsDesOaouPqKesrAC
 9xQPDKF/yXRySVvP+k7ybVq39R1jvb13eIXj/nJFpMVKQk+0g7qPdFvRA4Q9abG3CuEx
 OjL2F3MHy/yGGzNUn6RFeMLrQo8snxbIfTxXNq9QlfmmtDU2sgcrPxCkWlRGCvwa2le+
 6/6a21yalrCvblN+HHXk6GZho+pG9YtrAlmDgxDLYr6m+liQEg5GVF9q5Yx4J++Ve2g0
 PJAA==
X-Gm-Message-State: APuU4Z8+RpkhW2wHy9gpGDCV5a32O59ugwfnZuiBTtrZXDhtKAkoWr5E
 pojXXl1q1OaXQ55KqhYxvPwozxN0RNoaYfRsDmO/vEtmyWCmBvwUJew9cV/1c71usziJIaSQGsh
 8f6A6
X-Gm-Gg: AYBFou3VypMK7djSdYipZOvZnYKRLla1uyxWf9r2xXx3gQK03D1wKTnUbiNVoaeASb5
 ZyFmK7neeyseAEYUUu/O2n1qg/bHwstPqJ8vg6330x53KjnCR7NmVm1XUT6Lva2Sj8Nr+5MTvBd
 uVr8IBclV4UD2J210jcY06k3IcP0f/rEb/2ybhc9YCVdHa6pjczwKMkvYUY9OQ+FFUILW/8JBZH
 BgzIpcQAWBvUrhmZHdkF95h7KXmAQ8IUNWceYLJH6KmYRqXyvxdQTqotYpGiscmvcdMAdUUnfnI
 0Nc5+vA4tBD8eyouHNALszdTCwptf/cPdo/zNDQ7vzG3PbcTnQq//lBDzziO8HxbEg68fa92glC
 uEyeBINUDR26TXOM2YwKYRCMYf0DyhWqKJahkBpqIBZAHNAqMnOJwbLFqedUzGcE3eHqhc4B3t2
 SwIr1KeyT+neS09c2R0wpmCJicUp2TKuDFW44fAWI0wF4ojZcD9mgw35HSAtn+u5m+aE9MMb2/o
 IWeDxDVwJAPFuKQ3ffQJ6MQPcTtreA/mpiuALU4M/OkH2GREND7pN1KCw2MqAoFV1M+bFFNaCns
 bKi+3fICfGGb2u2P78K2uLnZsUScOH2/kJFTrjuqs/2/n7P/4/EVpygfjvl67SUGXPvHWK8lRAk
 kCwjJ2iqohbGmTJYGrtCylMI4ZHCec4mZihFgjGUM2KVsdOqhdj2/tLHd9tGhk3e0ZhGaTx+eMe
 8+cxFlIEj1jfM4ss19sOJQ/LW+ViKLmsEEgtFOzQm4vk04Q7DyzDol4mzam4d7ppY=
X-Received: by 2002:a05:600c:8b2a:b0:4a1:e57b:667c with SMTP id
 5b1f17b1804b1-4ba02350872mr38524625e9.26.1794314387998; 
 Tue, 10 Nov 2026 04:39:47 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0233e5d7sm47638475e9.1.2026.11.10.04.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:39:47 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 10 Nov 2026 14:39:34 +0200
Subject: [PATCH v2 5/6] virtio-snd: cap maximum buffer_bytes to half a GiB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-virtio-snd-fixes-v2-5-d5b654217676@linaro.org>
References: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
In-Reply-To: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1860;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=JdPly4XUOVOuWfMB6buCmU9psYgf8xH348nhmx7tpcQ=;
 b=owEBiQJ2/ZANAwAKAXcpx3B/fgnQAcsmYgBq8xCPrCQyAyp0YAPmIAa4i577xKAc2MCwqhWWy
 3VEnC9eaR6JAk8EAAEKADkWIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCavMQjxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQdynHcH9+CdAUdw/+L8QfazyTsD6RZ0wNtPVHV+l3o59rzPs
 wrYvzWLIn90hAw0nvyblxvfkAIMqvaQ0yD1W8zH5u0AcnDGeRJqxuczwnvNEyH7IdLRBb3QlOPg
 QEoaOZjQWZhjeVUa38ite6mx5JkpU6NdHUXLqC8J+jfJv2C/XzrfkXoFyfsyNXvsG5vT7jt4xkZ
 NXwyogNjhoyywDyCkXvHxgpISfIed/rtgs7HfjVGhW/vRR9rzmWQ4YHw5QO8TNPbxVZ2g+slyJS
 gysWz/1z7kwTuvofwQMuyLkLwdkVWE2kn+NxXsRCqjtT1j6hHRmrm8grnNgDmJVs31Fbey02/Io
 wfCAEST7qK1+NaqoqkDIsFe7hfPfp8bg//sgQ6DiPUWLW07Aigtvrd5Kni8t7M9yDVwRuFRisUA
 ivvE4TzqUYBMFDwEWk5qhGiTdnUTHY4/rFo/fAberk8ucoveWgNI3KaXo3ymXX4uel9GweUHdda
 Y70RaTMKwJ4q1CcGnNcHw7uKptpmRQllSlqGfXf7PyMKku5/XfMXaRurqbQPmVlKjbQAM1npsAg
 rYN50QF/1hmncYb0sqC5srdGMnO3P/JDRlR8xtl1murKApuLaDZttkzZioZohNjPAEj3F10EymP
 /n2KNbt/qimAMTuGYMUptBd+6bLH1iW/XbEMrsWnJPgE+4sAgOvY=
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


