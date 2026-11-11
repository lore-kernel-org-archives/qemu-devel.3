Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E3606A8AF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Of6drGpn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR6wF-0000yU-6Z; Wed, 11 Nov 2026 06:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xR6wC-0000yC-0h
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 06:56:24 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xR6wA-0000s7-Ep
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 06:56:23 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4b4571ff080so34810955e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 03:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794398181; x=1795002981; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=deT7/8dVqq8EzS8IotxxiSrXTLCGELXQrjI04Q8VFnk=;
 b=Of6drGpnjqQjZYTeDhLXndJKoqLuf9Qf8VJamTxlXMSeDfFPMrkKWduUl/kQ02lnto
 rZMqmI+kgHIf7oz5mLED05VcsFs0lQJpDLge217q7rODlE2i3SROK+40snJiue7cOtYT
 iyqXcUfZYQ1uhZuK5y2JdK2rLh7KirOAOVgLEx5/piPA8kblQ9OIEs1tBLOpDlM7vpCy
 FKRgEHj6UOuDlteYpEFtIWBbZVbvrZwSbRowZrpr0JCC8TsH1U6fAOEHbDHQG4MZH4dr
 sWsHk5aWnvXONMsAcA4d4JyaQeBDPRKpP1od0D1xhG8SCgCPI6QsaVxrzVJ3l0NfUOYM
 B2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794398181; x=1795002981;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=deT7/8dVqq8EzS8IotxxiSrXTLCGELXQrjI04Q8VFnk=;
 b=HWTTILvYzLW8/imzD5NVWRTE5X7Nr68+HjDc0NCEcd0Dfm2E5LnSyA8Z4kGoWmybQQ
 W+JiEG830CMAo4m0n2cCESWT8/oaJQCxJwMg4CHpS1OJ5psJaI5E40VdbEkMqxYfdopb
 fqKznqeqRxla1CHqb0z9TGZ/icHV0j85ANb8eo4+uDKcU/zEc6kymLPyIdNnnT6K3Ep1
 5eFPIEDHrXZCasUWiIaJNNxcIc/mVKkjMq8XYO+0KTC8d2vOa6bKpRs5degbxCX3XvgH
 ymAt+HrC72Rx1hPFsEGzLqvEbgF1R4fxW6j7ftHiGaPxm5DkUv8WhdlCMXpkVJdWnfd7
 HRrQ==
X-Gm-Message-State: APuU4Z/DXtkNC66sdzXzxQXrsn5ncNwP5dx7XiTUAp2XpQjpVP2M8aza
 vLIDFLvjWAdoDzwKQCJoEil3Fh/I3wzQrAaA/aGtAMmcLBlFz/QlUU0AuUh7NvQhkBub6V0/QGZ
 qwseP
X-Gm-Gg: AYBFou2eoHqEL2yCNlpulBRPmfPZNxymZ8ZPvJ6T7RlbjwbZrMOALOK7frPsipOWL+L
 DLreKzSt5tZcRkBExWPRoQ/gDozh0etqbEo05X+ejf/T4CYuceSc3J1kZr5cikWybBLiegC1hH2
 WKgM8WdqnGENTYl2Ew6OXEBwOC/90+KoDSkjBE4zROe2XVbTY5F3/eLnGjMAYSsfCSIfz8tO3az
 bovpO5QUt9zySEcla0KOTAAUSZgAW9EoKDIT05WGU5r7yztxB8rDdICzeyUPdiHQKlfkglpNtT0
 q4hKHS04dxaRjVc03FkA3S3tMNmqDcywhRXgZ/mbzpbPXI466kFW79q8WQR1de28QmXNJAZOsa9
 G1x0xGMmkaYVsb3766t2eVm9TXh6slU9stmCnqqxHUUrywOzsDkv+VPEyxCRcKCMboyF0NuEX3r
 Sw//GwSGmRvWGxAWRLyx988WLsrwgSyi4WHc1rqkUjIXqwhmg9TBe/sHRMNsg3YzbtTpe4aPqwq
 V65Xa5cOMobms0vmX4PWU6LtloKwFQzqJ9fgQXkhvCYOF/OLZlDWTnZmRoL3WIXzsmpXqUKWu+W
 r4Fj/2ZHr0Zq7t7EfgPNnBHhEPBqLpOkBLlGRYizIk3rCqmI/APgq08Bkz+s4pBQ//7tC2SLyhH
 qz5cbMIqdy6X58CO/v1lXCTh5F2lc7Dq+l+Q8PtLfcdfxZzxSd571vbrb399YjiRJ6ZCEoLmULT
 6pOtiJr0usn4vsVm/MZ3dx5kkOjZmsLBi/0Ky0pvbFnT5ZzoStPHs0I4yBlA==
X-Received: by 2002:a05:600c:4f4e:b0:4a1:777b:8a12 with SMTP id
 5b1f17b1804b1-4ba0938184bmr46207195e9.14.1794398180752; 
 Wed, 11 Nov 2026 03:56:20 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02043149sm128158315e9.8.2026.11.11.03.56.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Nov 2026 03:56:20 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PULL 6/6] virtio-snd: period_bytes divides buffer_bytes
Date: Wed, 11 Nov 2026 13:55:58 +0200
Message-ID: <20261111115559.18557-7-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111115559.18557-1-manos.pitsidianakis@linaro.org>
References: <20261111115559.18557-1-manos.pitsidianakis@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Add a check for the VIRTIO spec statement:

  5.14.6.6.3.2 Driver Requirements: Stream Parameters

      period_bytes MUST be a divider buffer_bytes, i.e. buffer_bytes % period_bytes == 0.

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
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
γαῖα πυρί μιχθήτω


