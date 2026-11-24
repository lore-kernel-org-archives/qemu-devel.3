Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF99F606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=izLmeoIy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVjrc-0004s0-Dj; Tue, 24 Nov 2026 01:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kmehltretter@gmail.com>)
 id 1xVjrG-0004rU-5d
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 01:18:26 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kmehltretter@gmail.com>)
 id 1xVjrD-00074T-S5
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 01:18:25 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4ad6219f7d8so3410784f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795501102; x=1796105902; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uOV1rCiLY62P/nI4Baot3t/wE+AmQOYl2DP3s3BhmQI=;
 b=izLmeoIy8n49KsY9dthqEbdxuP4bcHXGHETx5aNjWqgLLN4ORtzjlr+ZhIu20R5igX
 r3qRV3zAwMCDSdUZQKbP2PVSd9yu6q2PKkpEe/6wK2TDmS1UBOYEhDXrqhfimo4rYh+w
 V3riasnjOO/gXBs74Puofat4n/EADcM4CYXrGy/I/nSPztIQoBNVyA51GmGeX8vZiju4
 08lK6jBccSGKjZrsNOJ3vVwxZbslyjEOoTrPsA9xZ33w8ERgdQko8te9TTW7Ku15xVdQ
 pEGIXAhw/WZyOHZre66dhB/M1JY2D6VOHsmDKXv63CR6tqUnmqQybfaKNI5jNd9GgeA9
 A1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795501102; x=1796105902;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uOV1rCiLY62P/nI4Baot3t/wE+AmQOYl2DP3s3BhmQI=;
 b=pc3C9Fq2Gibjkp1k0kuYhaws+dSZFBg25U92bzTfWRdlfdpchx5KuMrYlHtdgBSvby
 eVgPYr0yZgeB3t6ce8PwublsQK0PToxqdFpSLp3l2PK10Vtu41XyKp1EAZqyCZcUJ4Ox
 aDgOHYZ4zBwedkqNrrI9PyS2EXaQdAZlCvWaP8xSv90vWS5keEDdYEFEKSYX7EreBVdI
 YVq/ehuANr2yT0uoi4WhLbfxWJ8vW7PWm2F769f9b20baDf+ovAkzl3VqQiW+8go7o+z
 cEgXTUAzljwfFgU0Iv27POXLS1FQgHQvAN1RmrhXtialWYYnydth6wG67AGYMvmN9CXG
 L1iQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGwQx2I63CXVg94u86CwiLqQciVALMmuyjj8TDEw5/gfpfX5TcrV0OHa7S4bvJDsKWJLHmudupBHB+7@nongnu.org
X-Gm-Message-State: APuU4Z8/kmlf54mVvSj60xWzJ7K7BFpYldfi2uGBCeXC2ppDZp1fK5ci
 D9aQW8GeCuDuaUPN1VRl5yQ+w2fhXvpui7PshHD6fNBRe8CQhtgG/AFQ
X-Gm-Gg: AZFdTZeKuDMgm7opRpwlNKDvkOQP9YVoytgOb3R8NpDSaPk0Sp9ykYsv3+0tcEcDg4O
 WqX2Gl4i2NLpe8YCkfRIa16k2cM/75svespYXbAQ85/TvME3aI9YVwRlluc3iaq5tWjtdswKBO0
 XV6xkWWW0ONw+mqzPmONZ5zdj7rYkARHY3UVgFjZEmqStXKlMkVTtUKddy0OA1aZ9axjfmVjs7n
 HANVNEut9geaP0W1iR8w0DwM5zshAbdB1G8FNiR1SAlpOD3X+ZJVnBdA2qhnExFipikKzArBqCn
 WrKNewMtLakVlQelyLmnyv6i7liuZ0IH2z+eY43R+BKG70FFLrMzSMqvFaRyfTYvzeHw2UCKYSt
 +atXvsqZ9PY5K8SOk7YSStPelTzSASs8QUN3zHVVcqeVg399gM96TbRujKmXxTy1LfM3XizJXaD
 Gw7N8NQ3gg/tn7Tg8K6Vs4H87OutOoUsdF98Vtzoq/HTInhS2Y1zGQYRutV1lEm483sX7VQPhrR
 P7WyQpedR48mXyvNH0Ex7f3EPVJHDsEqDRFeQgPfd7fm6zsZdEmWxEON4d8mi56H7PB9cAqeMn1
 BzZ8nIKVh+InEO4IYGOmhajYCBk9iqbJt1cXa7w4mPsoJt1UPj+snerZYsF83sBq3/Iq4n0/ukh
 p3Dp0O4LyfEtsaqJ0GRR5rwRQfs0Jl4FFcsDbrSvfpqQqLVf7RH61KvZurnnSrGQY6ftRxnem6n
 gJ7g==
X-Received: by 2002:a05:6000:4a1b:b0:48d:f996:1814 with SMTP id
 ffacd0b85a97d-4abba0cd3c7mr25390698f8f.57.1795501101911; 
 Mon, 23 Nov 2026 22:18:21 -0800 (PST)
Received: from MacBook-Pro-von-Karl.localdomain
 (dynamic-077-002-108-156.77.2.pool.telefonica.de. [77.2.108.156])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf6804sm25662184f8f.10.2026.11.23.22.18.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Nov 2026 22:18:21 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Harshit Mukhedkar <harshit007k@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org
Subject: Re: [PATCH-for-11.2 6/9] hw/sd/sdcard: Validate migrated blk_len in
 post_load
Date: Tue, 24 Nov 2026 07:18:15 +0100
Message-Id: <20261124061815.74999-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261123225349.54981-7-philmd@oss.qualcomm.com>
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
 <20261123225349.54981-7-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=kmehltretter@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 at 23:53, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> From: Harshit Mukhedkar <harshit007k@gmail.com>
>
> Migration streams are untrusted input. A crafted stream can set
> blk_len larger than the 512 byte data[] buffer, so a later block
> read passes that length to blk_pread() and overflows data[] on
> the host heap.
>
> Reject such state in post_load.

With this patch on master (2bfbe39d0fff) under ASan, the #4725
mutated migration stream (blk_len == 4096) is rejected in sd-card
post_load instead of overflowing data[] in sd_blk_read().

Tested with patch 6/9 alone and with the 9-patch series applied on
Debian 13 x86_64.

Tested-by: Karl Mehltretter <kmehltretter@gmail.com>

Thanks,
Karl

