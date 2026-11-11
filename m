Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21104606A32E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lJ7/aNVs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR6wD-0000yN-5r; Wed, 11 Nov 2026 06:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xR6wA-0000x6-DW
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 06:56:22 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xR6w8-0000rb-Am
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 06:56:22 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso32902465e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 03:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794398178; x=1795002978; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TWxHSQ8ryBlD3L9j3H0hyMhvnnhzjd+/n9i8IJwbImU=;
 b=lJ7/aNVsCvqVESAI7Gfe9o8lKtuxHcdOAnf39TIeXM8O3ISlT0aZb2fJbhMSO2D7bf
 4Kf/DgBxfXmzKZEkyDz4aAhl9O9C8fD+GayVaVfw4MV6m7xgCkYzQE+2wGnWXI8zrdem
 AfQCkwlsu6sMX5p8cDbc1/1i+OfH6iXQAkiyMpJ82zAiHlGxtS0It9ict/BkelNcV5oF
 wq7oDcKGzSX212quknh6kctbqM+et2H/hgyeUijIuM8A8i8eTzRR0uuAUGP96XGY8WmJ
 k35j3bze0/Yr72/9Y7Kmyir1aMQD7+9y5Lb/BqNVNyfK5iyfnf8uN6myL2zHcK2Tle5j
 E2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794398178; x=1795002978;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TWxHSQ8ryBlD3L9j3H0hyMhvnnhzjd+/n9i8IJwbImU=;
 b=MyIyNhP7dkbYVMzxQHN6+ivuao/OLM1u+4CeKO97QpdJMHWvmIzWceAQ08Te10pOfz
 fxie+widstdwmRZiSdjf5Cx4JWqIzXADwedPFrGKirrvhT4WgXoIoL2GzgDTZG+A/2yV
 dWYVt1UaD3kCNZPxMYoH2aq0najCTQv4bcY1PETHZGdtv38RADOGRX9QKu3blmmPZrr6
 O2n+te7wk1Ucq/esKsNpid6hRAEaP7/BByBpp055OROqHDnvmG4uNku8VPfHX4PlXeqG
 m4ZikhBx15chlDQI9WMWkWw0P4q0oIHWGj7ll8KR8H22IRG1HffPkeR2aFs+MmGtpScE
 R0IA==
X-Gm-Message-State: APuU4Z9SBNSsuYe4FHAHH9P/V7VRHkQBn10wkntdn3pu4X09cfsk1HiX
 8kY33w1+ZvExaEUhyv7Dcu6aa1a22FCJPLyW7f8w6sBA9jHoob1ZaXwtJqtIG/KSjSgzOt/tXlD
 YTCTT
X-Gm-Gg: AYBFou3hcjdkcTYXD57ruW+71JqoRilew/ag037gxxAjcj0u2L14lE51aF0m20GmuEB
 /4zWsUf2ym501aIEMEJhFwKwanj0pIvn/S4PA9KrlegTLwjT+Z4KTixQdnOLn2fi4/zPgCZfw7o
 MBvwaTxtJ9umGTfLB9OINpvzVKBY7izNW6RRYbl1II8A0XgIVDKO+dO8s4FbHXxD78gYDbq8cjZ
 kadZD3H9ix4bWnaggscb3V7HobjfCEcwl/zgb5Y+7VMdeFTO0nKb7vgEoV0oUIfCJgySJyjQxFU
 uX4YZDYNq+GWnQuc1y3W3hvhIKgbzh0ROwYeNXNJ+tp5k9U8wnGTl7zrqylncncue24tb8NZYo6
 /y14e0X2j7FfTCZAThO2YsMYHoMOYoKGpKyJmXABHeZYw5oqnoBq9u4P1a8rrV22t3JJOrOLNCo
 K2IHIYWWEPpA+H27/oV1cSh/c23BM7tpo9xKDSEh2yXBGXbrBh8aGU837F3pdJ2wspyoYBzb+3i
 qUYonqVXT71++iKRo2t7lY5YfHTPk39XUE08b79syg36VesewtLCZhgFunZYjNpM2Rbsn15ahFF
 cVX/eFAt9Ts1zlMnApQY8kXDLdAuOE+vXlmiuALWxG8rGmBDqXw+wGRNKqB0tNfpvGRrwq6sMnZ
 NhpujLayq3pt769JnXqFs2u8vKXqPqc1ZE8HoBWlVMw+GPWKUp6R73CjVKCjA/UaExvcNnXk+mO
 KOyexzKjXrT0j9MEbCstBiKZ/fTpNF8egruMtZYDzGOStVoUxzRwtGglPFTIzgene/nq65CSJSi
 Y8xjAY=
X-Received: by 2002:a05:600c:3151:b0:4a1:fae5:f2e2 with SMTP id
 5b1f17b1804b1-4ba09344708mr41010145e9.4.1794398178516; 
 Wed, 11 Nov 2026 03:56:18 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02043149sm128158315e9.8.2026.11.11.03.56.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Nov 2026 03:56:18 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PULL 3/6] virtio-snd: reject invalid feats in set_pcm_params
Date: Wed, 11 Nov 2026 13:55:55 +0200
Message-ID: <20261111115559.18557-4-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111115559.18557-1-manos.pitsidianakis@linaro.org>
References: <20261111115559.18557-1-manos.pitsidianakis@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index f1dc03d1b8..89406f0a3a 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -351,6 +351,18 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
         error_report("Stream rate is not supported.");
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
+    if ((le32_to_cpu(params->features) & ~(stream->info.features)) > 0) {
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
+    }
 
     st_params = virtio_snd_pcm_get_params(s, stream_id);
 
-- 
γαῖα πυρί μιχθήτω


