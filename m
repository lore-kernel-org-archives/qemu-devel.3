Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F193C55180
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 09:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtN0g-0007kR-Ke; Fri, 20 Feb 2026 04:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vtN0R-0007hB-Cd
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 04:41:03 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vtN0P-0006Lh-9I
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 04:41:02 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48336a6e932so11895055e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 01:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771580459; x=1772185259; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SIJ/aOmBJLiUk8hgsB8l2oViBbvawbOAhl3S0dnBdUI=;
 b=o8Y/kj0cHhg1qmY7S9+4gvgVFByf2doI/UnF4HMQOExUWDhrHx1WQNFO47ZJ2vcaDR
 IC9/h7HVEttMVG6UJcjkKgEMjFl1avvT7OQYd9jrMt1YGLKCItXVBIT4g2fE7dByetAk
 j4W1aU/2tyCy6zV35YRxgMBtJwmViNPufG6vYA3BRW6ol29LUuWPl8UiBQgUQV4Aw9Yt
 mDhs1VcJ3JibGpucyywWa4HKS7kRPopUApgLYMQEDW0OD5qKX50Gx0P2WWEZg2EU/hUb
 Uuh3a+cSwt0y4NZ/Q4av76DktXy0W83SfWcLNILi/7VI+uuoMxPn8r7vCAMgaWNI0VtU
 qXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771580459; x=1772185259;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SIJ/aOmBJLiUk8hgsB8l2oViBbvawbOAhl3S0dnBdUI=;
 b=DwJoMXEcL3nenM/HodZ8+T3t76TOR4vqm2yTb1Qkgvjk7KAFoPbK/6bQmUvTnM3wst
 02Z9Fhw+OLpsQnvD8RX27InY01EE8+5W928S84JBtWCqjJkvmywXcU/rpRmOH7auW5p/
 MoMtuBkFUTjBxha86ii5aXhgNb4aAcfuf57FdtuZx7DSSICJO31qJVh+MDkga/nNDUQ+
 YmJBIWMZ2CvB/TKzgKYaMEtjvISG1je7vhx/aLP7B4dCcWC5hcdjFOZdWjLrR5TdWj9T
 Zz9pfyhWmxgAus3F+wAzhCAUJcVgR2ZWFp+rL1lCeu+fhVFJZs7cFMtjcbdcW4pW2SAW
 SQxg==
X-Gm-Message-State: AOJu0YwgdmE8teoVvXTuVs1eiLtpAjpRjSsXzvXwBOCXzzS3Z9WuEBtt
 JpBUhO3OY5VtI5hrhx5hJAbLgcqeMB75KPuuKLdYmWPciw6z23TeezfxsoF8OQco/50=
X-Gm-Gg: AZuq6aLhwcYCaySTvJmVIa4sh39q7fnteCXRZpqaT27Z3As3luItJrQd45GUsfiWbTA
 ZvMIQbEWiozOJG28Z7banKGbD13lB+/nW7xs9TP9q7+WG+FvPq+cG80N21lS1AKDsN2HU5pX7GP
 aRlsxZa8P6blOmS8M6ZjO4xgPa+gmLsLIM8Zo3lR8dqLpvXQN1YWOKUbG0zKdmb1FdtUJsKfkER
 mmsrvtKtqKv0ZouVq8giRtJmLwOMEepNZjDH8ulmxa1KzKdK2uFcLfiehGeFgPb6+smQ4J+tthc
 zInRjP372VdDKIRa4E3YmsPlnqvF4V/mbXW3Z8eedIb4jsNBoZdaFaXUdgJZmOkvKAfNmQmfe01
 cVneJ36SkO+bsUY+CHvXGvdiWW0mySp3vLjnUvZg20niXeRPL593KMt0eYV7XwupMHhiR58dUu2
 hDmQOC2JMKq20ejgSmzsBx9tW5ID7oD72HYbrGezzmlbgxqzD7KdHcazyUoLvBw2a7JZ2nj3AWB
 bUv+RscJ11qyBkB9IsZp4NAjtOT6KlC5VEzVEbhFQiHZ/Tt0w==
X-Received: by 2002:a05:600c:4454:b0:483:7432:a761 with SMTP id
 5b1f17b1804b1-48379be8ec0mr371974035e9.24.1771580458784; 
 Fri, 20 Feb 2026 01:40:58 -0800 (PST)
Received: from [127.0.1.1] (ppp-2-86-215-248.home.otenet.gr. [2.86.215.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac87sm58432818f8f.3.2026.02.20.01.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 01:40:58 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 20 Feb 2026 11:40:13 +0200
Subject: [PATCH 2/5] virtio-snd: remove TODO comments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-virtio-snd-series-v1-2-207c4f7200a2@linaro.org>
References: <20260220-virtio-snd-series-v1-0-207c4f7200a2@linaro.org>
In-Reply-To: <20260220-virtio-snd-series-v1-0-207c4f7200a2@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3727;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=F4m41JzkxYeW6cKRPP2AdaRHCDLj58SlDviQ6p93058=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnBtQ3duVXMzNFdsOHhTM1lzckFsa2pZV1BmUloyCjVjSlRxUVRDSkpRQVRFTm02
 TkNKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYVpnc0p3QUt
 DUkIzS2Nkd2YzNEowQ3ZXRC85aExlNzRsZWdKZlFhZ2xmYWdJK0NNektLWGsxZmFmVk0wK0h4Rw
 o2NTkyNVZ2cG1ZRklEa2VwYktudUxYdllTenZYaW9rMHg3aDNKZW1BTmE5eDVoRkNHT3Naa2ZhU
 nVOOEdtRkVVCngzTHB5YSthcExjNkV0eDdCMEJJKy9aVStkUmNvODhoRHQ1SzNUdWtZSjc0d1BI
 d3hKcWFXZDBZc3FpTjJHekEKZUtVQ3UrMnk1eWk5bGU0TnRlNUIvSktSYjhBOUErQys2eVp6VDZ
 TS1lGY0k4S2ZiM0x2NDJqMXZlV3p3a3J1TQpnWDNHeXdQM0JzajROTkRPQkxlakRzMUFFMlo0Yz
 krenI5TjN6TEkxdW1OQnltMWFyTnYyUVlqaU1rSDZhWHBwCmUvUzFCa3N6eVJDb0NhUnJvS2pEa
 FpkbE4zR1ZGSks3eUtuZlhsdTY5V0VWSURxc0didHZpZ3BBL1B6ZUtUeWUKSDhqeTNYU0NBck0r
 eHdyUFFZZ1RFWXR2bGMydXdpaDRsTGZSZlZOTTBhcHg3Y3R6ZE96ajhpZ29rNlVLYmZaNQoxRHg
 5TVJMNEJlTFdnaHN6MXJwQjhMREFHbWFXUjRiTi8rV0FKY2lpazV1TjVRYmNyWmhobGxheHcrak
 tiVlFjCitEQjZDVHNCbWlEZ3VVdTV6OFZhK2pqZGJoTGViTkFEcTB1MHBuWkN1TVdvMTVueTNnZ
 mo4WnN0WFpkVUpHREsKMzB0eDV5SjhBdmZBbEM5Z2tiU290STE1TFc4YUVPbEttRHV3MzNPejFw
 S05aSDlZMXFGMkQxWmIzQjhhSXN6YwpRengwYWVaS1pSRU9kMHFnUUd3ZXBrenVhbWdyVnMzbTV
 qcC9jOXRRVGVNVE1OdDFHamtCb1ZJWVYrUllocUw4ClhDUlljdz09Cj1OWlVECi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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

Replying with a VIRTIO_SND_S_BAD_MSG error does not warrant a device
reset. Instead, a device reset happens when the driver requests it from the
transport.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 9101560f3879761d99b2dc97e48864958edfb3bf..fd03efc12043b67bc6f3a16315d2bcc46ddbe990 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -168,9 +168,6 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
                                sizeof(virtio_snd_query_info));
 
     if (msg_sz != sizeof(virtio_snd_query_info)) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         qemu_log_mask(LOG_GUEST_ERROR,
                 "%s: virtio-snd command size incorrect %zu vs \
                 %zu\n", __func__, msg_sz, sizeof(virtio_snd_query_info));
@@ -184,9 +181,6 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
 
     if (iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
         sizeof(virtio_snd_hdr) + size * count) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         error_report("pcm info: buffer too small, got: %zu, needed: %zu",
                 iov_size(cmd->elem->in_sg, cmd->elem->in_num),
                 sizeof(virtio_snd_pcm_info));
@@ -244,9 +238,6 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
     virtio_snd_pcm_set_params *st_params;
 
     if (stream_id >= s->snd_conf.streams || s->pcm->pcm_params == NULL) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialized.\n");
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
@@ -297,9 +288,6 @@ static void virtio_snd_handle_pcm_set_params(VirtIOSound *s,
                                sizeof(virtio_snd_pcm_set_params));
 
     if (msg_sz != sizeof(virtio_snd_pcm_set_params)) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         qemu_log_mask(LOG_GUEST_ERROR,
                 "%s: virtio-snd command size incorrect %zu vs \
                 %zu\n", __func__, msg_sz, sizeof(virtio_snd_pcm_set_params));
@@ -609,9 +597,6 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
                                sizeof(stream_id));
 
     if (msg_sz != sizeof(stream_id)) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         qemu_log_mask(LOG_GUEST_ERROR,
                 "%s: virtio-snd command size incorrect %zu vs \
                 %zu\n", __func__, msg_sz, sizeof(stream_id));
@@ -623,9 +608,6 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
     trace_virtio_snd_handle_pcm_release(stream_id);
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (stream == NULL) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         error_report("already released stream %"PRIu32, stream_id);
         virtio_error(VIRTIO_DEVICE(s),
                      "already released stream %"PRIu32,
@@ -668,9 +650,6 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
                                sizeof(virtio_snd_hdr));
 
     if (msg_sz != sizeof(virtio_snd_hdr)) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         qemu_log_mask(LOG_GUEST_ERROR,
                 "%s: virtio-snd command size incorrect %zu vs \
                 %zu\n", __func__, msg_sz, sizeof(virtio_snd_hdr));

-- 
2.47.3


