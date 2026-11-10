Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A24D606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=K1/TfFSv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQj92-0007xz-JU; Tue, 10 Nov 2026 05:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQj8j-0007s9-P1
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:31:46 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQj8i-0001B6-9v
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:31:45 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so970175f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794306703; x=1794911503; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aiFNorPS2vT4MbCOHhd4fYXGnRl/hE+LcKapaLUxH/k=;
 b=K1/TfFSvSHoDf+8Vtx/InUvsKsqN/48h2VKivO7m69txeWk2BpTgGReiqpcVADtWpP
 wNk/v4E1oTGxRMz1AwRwNHTNd2UcOQTW8cPse3nBpZPJyVKhss/8f5VTGccn4qj365Nb
 zsU8mgdoly7kdgxAIIHnXNLWR4unr3Lf3Jq/CdXnWYVWlyCjfzv5iN1OVStLDERs4USs
 tFiGILCR1X6ytI5FF3llDUdrLZibwd4k9Ov7/vfbZ+NLcV2BkpALmL5/bM27wZBNezJJ
 pJxwweK6lmNQJJBFubHlCpHsUN/miAVLBU4ya/htJRTMZjAT9uSiJE4J5idetJCQUHBi
 nw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794306703; x=1794911503;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aiFNorPS2vT4MbCOHhd4fYXGnRl/hE+LcKapaLUxH/k=;
 b=qmCiu0dn2sCjC/kPyJAB6wvijN5I9uxDikSEjJuIA1LS7lzvTW8y9+tkb1H30JAw8q
 2QuC1QDMTZbJrlMIIlOF1qwDfYpwYCZD4OyKY8Ds52BPTLZhD8qZaEZ5LdimezAoGgoJ
 qWItI9vYsRqUngaIK9h1qv+V0iSikJZfVSqo10lH6ePsyvDGkhqdCCneODmtq41KS8rD
 Dabe8pn6fV7Ha0WsVY+gJNQaKb3S/JclkKR9UAd3bLcxHx0KzcHShdLAjmSoQUzJ1Djh
 ViRfheEnDRnm8ooA52MpyV3z2U9sioGNRN+rXdoalJSfiXN4fLlH9hODzIJJN1XeX/DS
 0maw==
X-Gm-Message-State: APuU4Z/x92Vwh+05LCELwuvDVncqg9nAaw3N/MJ2znt6YK2ukNtEJ4dJ
 jjOLSI+pv8SrKfQsQJpc2xIfXekgtx+PcsV9gmJFXcRJju4kMY8jduABGM4IAs6pZIAFsXH8DvA
 bxjoz
X-Gm-Gg: AYBFou04+IO7LxFzFKtZDTuXVAKznAw16YOXe7N8SajaKcb8O3g8eFDRKJmJuhQM+Dv
 FKZZo2izbDOIYSwLJPqLmNgVNoi/4M1MDD9MD66EfP9kM38IFJERJV/zTF1btKjeHEMCRgdIPWK
 bD2XwLYaPSdWTy3fRNBhrUKOxsBm8MGEb6xukMF6BJsfsjk7iq3A1zlDgRYkIb+p+oQFNJNKf+I
 7xFKCn6vJDW1z87gQQtNNlqB3zNj9HMPNq3OnipcxPL/uc8VC3j6g4qOhE2Fp2/KfWfatQVtCHM
 wCRkn+ctNBaXtBDznc86sXBwzwEC5Sye9GX/U9dJEsoQjot6Tri4ukWsnq1SJ1lo352pIo0lFuS
 5nG27bI8KQxCcVqqtcKCpQbwa8yOFGgyK/6vHjTWPy7Q0iOuPTLBPrd4rIzDhjyg+HzSSs9c7NJ
 v5Y7Ze/yZiTpr6sVWcu4VWvx2fXAowHsKPoMa/u9GC7gvncGTO6iLjo32XlRB0Q3GwqqAuAIJGf
 9FYinvXKmPONdHHVxydqlc3f6wnuC+/UE/HsE1GVvPW/fpoAB69V7wkkHTPmuUkVUQeZWsccPrU
 RU+DqkEMH4SWh+Bm3DFqoHWEh2nfxDnOLtKNoG+QqNY9/leymz0oJGzTVMDj8WXgrE4e5YOIzm9
 SbauxfFaJ9/FRYLYN6w70EkE/NJnAsTlOX/TKjSYJNNyaq8MzA4DlgzDsJ0txWNT3HUb+JYEvg0
 UoU9RJwtAPdZt835DYTzTQ+lldolqjKCaB+Ixf7NcPl0drSMTEgHntWKK/8EBbj/ug
X-Received: by 2002:a05:6000:4102:b0:491:36b3:23d with SMTP id
 ffacd0b85a97d-4982f2b4b99mr3019751f8f.13.1794306702785; 
 Tue, 10 Nov 2026 02:31:42 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c43f4sm5279060f8f.47.2026.11.10.02.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 02:31:42 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 10 Nov 2026 12:31:35 +0200
Subject: [PATCH 6/6] virtio-snd: period_bytes divides buffer_bytes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-virtio-snd-fixes-v1-6-544d6f9eca38@linaro.org>
References: <20261110-virtio-snd-fixes-v1-0-544d6f9eca38@linaro.org>
In-Reply-To: <20261110-virtio-snd-fixes-v1-0-544d6f9eca38@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=tAltvfvEShhXkSh940g0g6nIH/2uwK8GfvFwmNWUDJM=;
 b=owEBiQJ2/ZANAwAKAXcpx3B/fgnQAcsmYgBq8vKI9ROEG9yh3uDtmg+maYwu49f97TCNd7Zxo
 Y92n5bZrUmJAk8EAAEKADkWIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCavLyiBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQdynHcH9+CdDy8g/9GFYHJP6a+CW0v/J1RQ9rcnPj9FUK6DN
 StpVEJ4a+b68lAhbyqfXuyKDkCDQOOoUba9GoWlnNewI31roF+izpQMTbjlENeVOjlffzAKk+tC
 HZ22eDcNqwj8K8rOmJ197JiknZ0+iy7mTQZO1WJIrywUbt7zYI9s8Pe55UWR8yiVVm5se+ZsaGJ
 ly9wmZaDTzVf88fvVENElM5uRNUnEef1ZBt9HPA9s827hZwFE1uS5v2L9C4lvwIaAIEgDD8zApX
 mgZ4e/KC8xJeGDjexcrlfubSSYjFGNBPwSf0arYPAkdmczwzMwFk1tDGHlX9ukYEZCX/gg7W+TD
 hKwhgQpquVyzU37jipEtzQJq1giqW8eYB6uQ3dmlhuFKM/ZWhbmGJEBUmsXwKQUC4gUBhrJhnSm
 zKqnYt+PNz5v3WEW09Lk3OYfvwwdN287wouHUn5F00+XF/tvRRfscq/UcqZcGixMr/ZCVU+CxPN
 GaLdPgeq9CQBkn26m0wcXx03NZ9dUUeZ1hdyNtWI+rTg6oFQsdn7QR+q4IjVgDfsbjwqTETDy34
 BsMn3yHa6rFgb3ImGqcv74iXdan9CXwxtVXWTM8XKnI58k+cUl6HIJUCBWyxGnKfjnqKZFvIIbV
 MjGryUh1z4MWbI1Bj52ncUD+o0fgNKjZ2bg+Yf2DqiKXGu+5kwjM=
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


