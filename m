Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC64C55178
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 09:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtN11-0007xY-Jy; Fri, 20 Feb 2026 04:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vtN0S-0007hu-Jf
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 04:41:04 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vtN0Q-0006MM-Jl
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 04:41:04 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-436e87589e8so1873961f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 01:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771580461; x=1772185261; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oDGEMbC7gxzBCAplw3R3Fio+DNYrc5dde7dLf/vEK3g=;
 b=wgEwu+u3DkO5ZcZsP5/1UoCDy4XoudSXVTGADeJ1a4koou8e2P0D1VbHaKNinfjY1j
 l72oAm4xyBwFCDkT5CW5BNMO1Ty7RffSGHcuH/32FH8O29VQwzBaKwK/J/icIs6Ttcxl
 YGj5YI3WW54mOJHYpWKobavk2xKf7w57omjXVF34BZ/1B2TPPwW65OJEbckvIVx1MIcR
 rsGuIu8gjJwA6r2KOcjEVvUcF/vFW/2AdeGoIyDiE18EPXQhtjZ7UCC6BxawSyTTALMR
 mqk04+MpCxopSGp3R4RozpvaQCseMSY5vqlWBUKuD6VFDOWyMMBCTTJzV+qkBwfTcL00
 2ACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771580461; x=1772185261;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oDGEMbC7gxzBCAplw3R3Fio+DNYrc5dde7dLf/vEK3g=;
 b=vPLt61TWwjegJwUABUm8TR02NN3jjUd/WBC2S96BLvOU7WNBBDGi/piNtzXZYKEWrt
 SY/4LqGtBAjPYXcqB/jqJCo2hBF3gZFCoC7zj1CpLQ80uYQYDPU3kWAd5LalbSLOCRq8
 bRUT/jSBQhUvQqxqWZJYGsNJx0jWR1hp3SPiT4/U0bGsLFdjp7VhTl3XUSJW2W8KCxSr
 AaYMBf1IkckRqpp5Vj/Q3BJUCa6n6hjpQbodxj5RXaWFvQHPiVqOeDb6wohWe3sFv6br
 W7OSyiD5tyY/eQ1OIwPmg0YG6kwhOaeg40IR0nkFdKdbTBaBHGprvcu/K4SrkqTmm3SL
 xddg==
X-Gm-Message-State: AOJu0Yzq9EAeVzmaMGHHdA1LVhuuC+Q5ydjLNQB9JOxQ7hvmvjkk4Trb
 RkJfwMwDL7d/gEq3aLIbp5V2XFKH4VpTNnuILEQXawkWJdea4M0ztA4C/Zpalo1xuNs=
X-Gm-Gg: AZuq6aKxisGbhkua3zoZ/V+WPdfALWVGeYiNLJz6Gmoy1jQbbQ4G2IRrziRAZMcr3r4
 p9YAkCf5NErvyokZfYxGjgu4YbYDJbTfpCjKAOVfk3zEY3o9FqpAgfvOGJnRCeVNyoknMeX7LLL
 keSxcdcpkSXLYxZcR7B0BwAPYe3RIdnmDZwnH20UgRA67346P9kIJVgejua6o/lCbGWyiZ0fi0f
 MWaa0jt/b0iQKstPLd5YGo/o+vtM2QFoFbPQlO/GukHyNz9vGypc+OullrhtarIOSrhClV2Padk
 G/3puPFavhKgebuwuL8S7KNf+ghVC3ioKMIF2i3h8FNgpbsm0fZehLhtWiOPYlfVFz0s9NoUxpx
 Byd27qLs8qtlCTHBqB/e/YWCkQxXKB2XA1DXZc2MUg5uTFGjKZVcGqDgJADXQAIfj6NJcjyOMqs
 2rBHW7HgW+aBDKK1XHw+OqPrR2vcukX6CmMKpRNs6YJoH49/CEt8QB66W/nP2uefkY6tQy48jqQ
 zzTdvBvy5dIKtRLzW04g9e9UIDahbFuDAHzSUY=
X-Received: by 2002:a05:6000:240f:b0:437:8fc0:87d3 with SMTP id
 ffacd0b85a97d-4396b08fa4amr2004733f8f.35.1771580460932; 
 Fri, 20 Feb 2026 01:41:00 -0800 (PST)
Received: from [127.0.1.1] (ppp-2-86-215-248.home.otenet.gr. [2.86.215.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac87sm58432818f8f.3.2026.02.20.01.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 01:41:00 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 20 Feb 2026 11:40:15 +0200
Subject: [PATCH 4/5] virtio-snd: fix max_size bounds check in input cb
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-virtio-snd-series-v1-4-207c4f7200a2@linaro.org>
References: <20260220-virtio-snd-series-v1-0-207c4f7200a2@linaro.org>
In-Reply-To: <20260220-virtio-snd-series-v1-0-207c4f7200a2@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 qemu-stable@nongnu.org, DARKNAVY <vr@darknavy.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=+nx2QrnlRIm3S/jbuxu8fqDVQkgNviNcgiwjLhvkTyM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnBtQ3dua0V1WVFKVWExdk5BSy9IZlhDVTFNb20zCjQ3MVd2Si9zSEdzWjg1NzdJ
 T0dKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYVpnc0p3QUt
 DUkIzS2Nkd2YzNEowSjkrRC80aG1Fb1JBOWUvL2FNR2drQWI0dEVXejhIRTZhZWZERXNDdlpzUg
 pTSVI5RE0yNHVjeDBYNDVVb0c0MHVTSWFlL0NnNi9vbzBxcVFCRktUU21ZUjdBZUFwbTN2dmhCM
 Et1WnZjdk00Ck5oWEh2UlI1WmVqRlNHR0dtV2FWdzlsZEhwU1VjSzAyNGZxMkFDR1l5Uk5GOWJj
 WnB1Ni9OMlRncmUxWWxKTFoKNm14UXgxbGZIazc0MkVmb0x6blBsUElFMThBenJ3R21aMXhVN3p
 EL2trcHpBUWM2dFZQZEFudFRNdUVBSExlVgo0K2gxQ2ZLZ0c0aVZ6aGIybUZlVDlKRjNZd21ZUy
 9lVDRzQk9Bc1VXTFlBNitRUTN3b2x4cXBwV0hhTkNDWEZCClN4NWx6b01keGtMLzM5QVlSYmxvR
 np1OEVPTzVLZEpiTFc4UTk1U2ZYdnp5WEM2Vm1ZUFZvendyZU1MN1BXV0IKQ2VzYjV3SGZaT2FM
 eVBydmtxKzA0MTdPVTRxVFJ0NzJaUWRnYjBHM2ZBdGpJQ09JOTRBazlBQjdtMmhsZmVDYQpNdmk
 xQ0l6YW0wY2g3SlNCSUhDaHJjRzQ5N01YSkxVRjExTWJ0QllXY3dGVHVUWHhwL0pBUEhNL203N1
 k4YWtMCkJkQm1KMVZOQ0tWUFc5UlZqK0lua0Q5TnE4RDEwOVJkUC8xc0RYRjk4Y0hoZkZtOE9jS
 kJSOFM1Q0JvUEEzd3QKMEc5QmtqaVg0ektpQ1JUZHFIb2RaMUhVb09MaTcxK1NnWEJnd0pZcGdq
 bnBINHZqdmtSMzMzdUZXVEdnbTBkQwoySTdzbFdmWHBpSEVDL2luMFVOVnBSMUQvcTI0T2tiY2F
 oZzkrdm5EVnRIeldIR0l6WUpUK0FUNHZXWDZCQTZWCjIyeUZxZz09Cj1wYWJUCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In 98e77e3d we calculated the max size and checked that each buffer is smaller than it.

We neglected to subtract the size of the virtio_snd_pcm_status header
from the max size, and max_size was thus larger than the correct value,
leading to potential OOB writes.

If the buffer cannot fit the header or can fit only the header, return
the buffer immediately.

Cc: qemu-stable@nongnu.org
Fixes: 98e77e3dd8dd6e7aa9a7dffa60f49c8c8a49d4e3 ("virtio-snd: add max size bounds check in input cb")
Reported-by: DARKNAVY <vr@darknavy.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index e9c24d679538f0d375c7da05a836833b0897f698..3437211f7904ac77265d8ace8c1a5a582c0be96d 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1255,6 +1255,12 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
             }
 
             max_size = iov_size(buffer->elem->in_sg, buffer->elem->in_num);
+            if (max_size <= sizeof(virtio_snd_pcm_status)) {
+                return_rx_buffer(stream, buffer);
+                continue;
+            }
+            max_size -= sizeof(virtio_snd_pcm_status);
+
             for (;;) {
                 if (buffer->size >= max_size) {
                     return_rx_buffer(stream, buffer);

-- 
2.47.3


