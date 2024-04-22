Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0730C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 12:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryt9z-0001VZ-Mt; Mon, 22 Apr 2024 08:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ryt9p-0001Px-CJ
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:52:29 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ryt9n-0006NQ-Pt
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:52:29 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a55b2f49206so157555666b.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 05:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713790346; x=1714395146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ryj3LUKTxknJY3WZ9Mv00I2tlS5waRJIK0LpVRq+Bp8=;
 b=oNttCjs0S3jm09+kEi+l8PLJlaiNfLDkvGUJmTEYNDVR6TprdkvApl7hgcTDbnX9hx
 y9Zb1XrcjIT8QWJnBWuY2e2B/0tIx9b0UbiLCuZ2Jk6eNlcHibBWC3mHs5gyV9JopARV
 ge9y1n2bpLuH1+utAw6SQ0RDis9UpAoT7VlvLZ5gd+Y9Re5UgGFqMJNmANlT6U8Omm9F
 pI75nRNWM5KSnAZx0qZbgpwiVFWUMtNfdstT8as51o2VdG6Pl1pRbPYnshJgwqc2O6hY
 10bK6r5Hm1jeMPtCYGcXMxCwwmumFXq9afJz/VW25UIqDX2nPhj3SPnNGLKT87KNksjA
 nG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713790346; x=1714395146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ryj3LUKTxknJY3WZ9Mv00I2tlS5waRJIK0LpVRq+Bp8=;
 b=AOD0IhVv+1p8J1jIgVDn2sCHbMK8uCtvePzh/T+cXJh8CwB1PkPhdnHEC0Y1yKJcma
 ndmviqdK3E27/KPnLcEmId5Q6JIOcuE3A2GRGKgzZ2EtdAnR3Z7JcBxqsVxYO/q+TINz
 IrbJ90/zL6o1Zm2E25PGCs8eyhaWKa5mZScRaIZK4mz9nf8STaWfDBPrr7fhSbg3SZdd
 /uBLS2wRcYU7ltT5waz4uLVDOlHr0Z/P028IJJ2sqoVuYuQKxQGgp4bG/mHtgHODXXIK
 Cm9dkvAyZe9Wr5XVfPvqW/KBbc254ekG9eXQOw8U0gmUwYJlC+zJL7lhwBzlhpA3ZOGA
 hQ7A==
X-Gm-Message-State: AOJu0Yz64VVcu2qtiyDqAaKWOp+dHtaWQuTn4XjKHBYDTWeBdX8+zfJG
 DMOqmlR07tyZAmiOfByW03sEbB+LipiZs7MzJ3kxKcJt0gm+D/8nTJf2Od2yAIchoRvKya6Nh9f
 R
X-Google-Smtp-Source: AGHT+IGxtT4XI9qPuHes1nZ1WgS1eljmmXdC+Y+a403e2n2D4fPleiu6/Q/ntHa+VDSvnZWK9+2DYw==
X-Received: by 2002:a17:906:f590:b0:a55:be3b:c6cf with SMTP id
 cm16-20020a170906f59000b00a55be3bc6cfmr1656601ejd.35.1713790345950; 
 Mon, 22 Apr 2024 05:52:25 -0700 (PDT)
Received: from localhost.localdomain (adsl-53.37.6.0.tellas.gr. [37.6.0.53])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a1709066b8a00b00a55bfb4e3b6sm593574ejr.217.2024.04.22.05.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 05:52:25 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Zheyu Ma <zheyuma97@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v1 0/4] virtio_snd_set_config: Fix #2296
Date: Mon, 22 Apr 2024 15:52:10 +0300
Message-ID: <cover.1713789200.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Changing the number of streams via virtio_snd_set_config() did not
re-configure the audio card, leaving it in an invalid state.

Reported in https://gitlab.com/qemu-project/qemu/-/issues/2296

Manos Pitsidianakis (4):
  virtio-snd: add virtio_snd_is_config_valid()
  virtio-snd: factor card setup out of realize func
  virtio-snd: factor card removal out of unrealize()
  virtio_snd_set_config: validate and re-setup card

 hw/audio/virtio-snd.c | 174 +++++++++++++++++++++++++-----------------
 1 file changed, 105 insertions(+), 69 deletions(-)


base-commit: 62dbe54c24dbf77051bafe1039c31ddc8f37602d
-- 
γαῖα πυρί μιχθήτω


