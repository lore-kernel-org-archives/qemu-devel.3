Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6417C55178
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 09:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtN0d-0007kE-IM; Fri, 20 Feb 2026 04:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vtN0R-0007hC-D6
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 04:41:03 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vtN0P-0006Ly-HL
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 04:41:03 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-436309f1ad7so1360137f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 01:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771580460; x=1772185260; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4YOqswzMlCNxwAWAnFKNUGVfGL/ym7Dl2W+MaYaNx24=;
 b=A48eDQ7FgnW/k/C8nc3KvB3CE0720q8sOgMJ+YdgvkZOXaxR68L/WeKFJtpJcIYUlr
 BM7VShoQ3DYzVLQGNt7Isr0dUb6UrPznvtvWq+Pt6ZZPefr0lwPtURp5DhybEAyw3sD8
 tT807NHs+7/WEC+RCqPJwqj6cWrESfvlXM7BDpYdr7habJODYnE8U+JOkRz5SOrGvGPj
 32GxT5SQEQivuUCSPl4S/bdtrExOkoUR/cPiLH/GshvhKbJuMJW1POhJTON9LN6oWbzh
 yFeVAlRs+KxEDUroTetkoamogcoZ3ohPDGP8oCR5480aUESQm97P3OY/4aBfaOU5ZeQi
 dDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771580460; x=1772185260;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4YOqswzMlCNxwAWAnFKNUGVfGL/ym7Dl2W+MaYaNx24=;
 b=H6y+Wf6b30/6OyBHKn97Zs8iZ/EG/kMn7EDlKHmSwn/jJa0Jile/D4uEi5Z6JoRHtF
 VxHzLF1h5IaEsl2F9xG7q/fI+b0CAvCkqWH4sig3Ql0Zuc+uScaMDdFgOxws3zVMooaQ
 1B45LrLJj6E/d3ajcJ8X7D23Hw8ErYZQH+t5HE2gRVWkDjOG7FZRLLBWRxL5yFON5ZNl
 j/I+JI6TyOVXwSaXXp+4YH0wzoenm9T3CKAqHrZDrbRNiYB1zLPGOpOiJff1TeroYucH
 qcBaAy8iTn6xDt1wZ3Wy0Vk/xsgpo5TK4hikntO6/lllvMXv5CVJ4LM8GZSkYCssHY2z
 5rVg==
X-Gm-Message-State: AOJu0YwcpVP0v2E+EsrzB5qxbDJGf73S/w2qbApK5pNwsldu0zRkzmBj
 MlhU3ElNk3xtdmFFu0iDbXvEoRnhCw4HrU61begtaLFDEjJ8pgEtjdVnD1KCxq9nBxs=
X-Gm-Gg: AZuq6aLiHBPQrdOrybL4sEuDhwOSyqWqM5eQoBIejIxtbDnkYyDZHMT4YDEDvUTtNzA
 jYl2q+VsjxKXVMOsfajfYuIZ6NdTJzUgWeHFlmOHAJLEf+duivX/YSNpF0RLBzSgIMy3VWx7etL
 0s8PjARgXxeDugycfcmXRaymBgek9THbS7q8dYaHxcDVNoqIUsElbNkrq72qLZowQaXhyahbvR1
 jFMxTYQx4UQCiVFc3GEJaYVBCZRKhTZFhHjj1LnQ0kGCJ9ZnUnBhPbpzvRJubYEwXSxiwyWxFDi
 GDSGcxRK6FvI6oAeNuXLM9m31/fce3irbDqH4vae3WMWVTHKgVSyJiKFCrsBx+8IWxki7sLwV1Q
 xlo8P+BLdIc/C504aH6e5pvXUs9QWr+UeftiCsJIC0y1ScJywL8BiMAWiR7lCKOAUKsG4ZusyhD
 7DUqCl5JHoN0F+E4hMEyXlr+zrJ7V+5L9UITilR0JvjxZRX6BqOkuvUUTDaUx82lCDMKnK/xIDo
 3b05StvcIdWcjoAAF1ZVK1qj3UlAUg9261S1Q0=
X-Received: by 2002:a05:6000:200d:b0:437:673f:e069 with SMTP id
 ffacd0b85a97d-4379dbb0ba8mr34868797f8f.59.1771580459875; 
 Fri, 20 Feb 2026 01:40:59 -0800 (PST)
Received: from [127.0.1.1] (ppp-2-86-215-248.home.otenet.gr. [2.86.215.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac87sm58432818f8f.3.2026.02.20.01.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 01:40:59 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 20 Feb 2026 11:40:14 +0200
Subject: [PATCH 3/5] virtio-snd: handle 5.14.6.2 for PCM_INFO properly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260220-virtio-snd-series-v1-3-207c4f7200a2@linaro.org>
References: <20260220-virtio-snd-series-v1-0-207c4f7200a2@linaro.org>
In-Reply-To: <20260220-virtio-snd-series-v1-0-207c4f7200a2@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 qemu-stable@nongnu.org, 
 =?utf-8?q?=E7=BD=97=E9=93=AD=E6=BA=90?= <myluo24@m.fudan.edu.cn>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3420;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=eIDOkQYI5WtmiaHhWjG4FMdUEZV9lpcnfdevuvn+qwA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnBtQ3duR1RxMjgxTXVEMDdkZDFrbXg4VnMycGxBCmlJeEg2clZDTmFaT3ZiMEh3
 OG1KQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYVpnc0p3QUt
 DUkIzS2Nkd2YzNEowSC9kRUFDTVROQ0prcTdHbWxSOTAzS3FUaXV5TkRDVXZaRmM4K3ZRbHFJSg
 pqZ1pJRFlEbjZHWmlraEcydFBmdFFvTFJBS3VRSWNFaU96TjQ3OGR5em13SlJCaGpieXJGTitud
 Etya0pYVkh6CmkxVDlLVmUweFR4VVRqUzRrTHBQaVZnekc4aXhHdjdNSytETitva0I4THpLVVc5
 UG9RejFMUmNRbDhnZFNqNXIKVERWRDNpcjhiWm1RUWluWEZtUDlYeW5DTHJhc2FhZGV0K1JINmh
 ZbnVGdGlLL3ZPOUJTdU54NnBwZDdBZHJubgpZUWtoRlhtbHdHb0IwTEgyb09LOFVRUnIzRld4Un
 hIMEFaTDdnZU1MU0ZNR2YwTmtrZzJmY1pFdWNEMVVmbmtaCmsyTVlNc3dZY1UvRGdac3B1T0c4Q
 0N6K1ZvNlVKbjU1aGlzWHpkTlVwQWE4OE5zL3J2dUdLQjR2WlhlK3JwZFkKOUFTTkRXUUY5V2lP
 aWZjbVNDNkJmYytNU0YzcmV1U2VmMElpSlNzbTdqclRNUDFPaEpySmpObGZjd0p4VTBVcwpSSlg
 2WE1SeTZPY3BNbGZvcnhjMGprZ0tPVkI4VlJhei9oZkdsMW9BTUhtWmdyZnE2UFNna2tQNlpEWT
 VpVmNqCkFaMTVGcUxlSmdhMWcvT3I4RVU3S2w3d1VZaWd5Z2hSQXdvZzI4ZzBtN0RPNTVvQTdvS
 VdsMXpOcFA3SkJtcmIKcHl0bDRnQW84V2ZGR2pKZjc2Lzk4SGE2WFg4VkxqUkFCMDEyWkRPYkpJ
 TTJZZm5FaEZzU1ZXdGJVbkc5UFFLMwpUZVhyR3J5clVhcjJKbUVrQ256aVZQWmJtVlpKSS94dUF
 QQ0hxN3JuS2xoZGwyUU82THZKWkhsbTNYTzQ5cW1aCjV4MG1Pdz09Cj1oZSt2Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The section 5.14.6.2 of the VIRTIO spec says:

  5.14.6.2 Driver Requirements: Item Information Request

  - The driver MUST NOT set start_id and count such that start_id +
    count is greater than the total number of particular items that is
    indicated in the device configuration space.

  - The driver MUST provide a buffer of sizeof(struct virtio_snd_hdr) +
    count * size bytes for the response.

While we performed some check for the second requirement, it failed to
check for integer overflow.

Add also a check for the first requirement, which should limit exposure
to any overflow, since realistically the number of streams will be low
enough in value such that overflow is improbable.

Cc: qemu-stable@nongnu.org
Reported-by: "罗铭源" <myluo24@m.fudan.edu.cn>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index fd03efc12043b67bc6f3a16315d2bcc46ddbe990..e9c24d679538f0d375c7da05a836833b0897f698 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -156,7 +156,7 @@ static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
 static void virtio_snd_handle_pcm_info(VirtIOSound *s,
                                        virtio_snd_ctrl_command *cmd)
 {
-    uint32_t stream_id, start_id, count, size;
+    uint32_t stream_id, start_id, count, size, tmp;
     virtio_snd_pcm_info val;
     virtio_snd_query_info req;
     VirtIOSoundPCMStream *stream = NULL;
@@ -179,11 +179,34 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
     count = le32_to_cpu(req.count);
     size = le32_to_cpu(req.size);
 
-    if (iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
-        sizeof(virtio_snd_hdr) + size * count) {
+    /*
+     * 5.14.6.2 Driver Requirements: Item Information Request
+     * "The driver MUST NOT set start_id and count such that start_id + count
+     * is greater than the total number of particular items that is indicated
+     * in the device configuration space."
+     */
+    if (start_id > s->snd_conf.streams
+        || !g_uint_checked_add(&tmp, start_id, count)
+        || start_id + count > s->snd_conf.streams) {
+        error_report("pcm info: start_id + count is greater than the total "
+                     "number of streams, got: start_id = %u, count = %u",
+                     start_id, count);
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+
+    /*
+     * 5.14.6.2 Driver Requirements: Item Information Request
+     * "The driver MUST provide a buffer of sizeof(struct virtio_snd_hdr) +
+     * count * size bytes for the response."
+     */
+    if (!g_uint_checked_mul(&tmp, size, count)
+        || !g_uint_checked_add(&tmp, tmp, sizeof(virtio_snd_hdr))
+        || iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
+           sizeof(virtio_snd_hdr) + size * count) {
         error_report("pcm info: buffer too small, got: %zu, needed: %zu",
                 iov_size(cmd->elem->in_sg, cmd->elem->in_num),
-                sizeof(virtio_snd_pcm_info));
+                sizeof(virtio_snd_pcm_info) * count);
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         return;
     }

-- 
2.47.3


