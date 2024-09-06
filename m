Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329CACE7B09
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smYlJ-0003Rs-Ax; Fri, 06 Sep 2024 09:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smYlH-0003RP-Qb
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:12:27 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smYlD-0006WH-1E
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:12:27 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c263118780so2270857a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 06:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725628340; x=1726233140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CZbA9Xj8AVI7VKUv52gsJAZ5OnIcvPooFRjUCPB2pOs=;
 b=B1nBTO0s0sssT1/VyO1RKpIoK3gPesoRk7b6TeNfqu7DJLCx/HraFyOV/+II+q3FD4
 GFtAwglijFi+rWCw7ZBjPv6O/6it4ZG4MEBeg07xVk4ujupJ4SeaLharltygG5fO4fP0
 ENMUm8hRdmplOa1abdWtqbang/LkuLmkLWArxQWL9Wl+X8ZgQwCJuVKDdffmfSjUnq18
 1Bxuzyj5L4AtgSWD7DvVpqMDZUrdWBJtfVHT/pHxUyd4xnNc+8Bw49h+YBqNR0AiIzda
 1Fhsx6wPzzR/nm7IoPEpxyAHraaa12KTLrauyeavfrhHPADwq4fOFDMqt+lk2LkFOZMv
 u4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725628340; x=1726233140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CZbA9Xj8AVI7VKUv52gsJAZ5OnIcvPooFRjUCPB2pOs=;
 b=Qd2FBjSckoYzS77E4UTAm8aHExEKKC4fpBOK9CTQSkt6SJDqeYUWOrA8PH/NC5uHAo
 be1d7sRREs9XQlkldF35P0Xvg8PDmwa/Yy2TxHytgarT3jDgGLFcaE5YNcSD/pCZcuE7
 ROigGzY2ki+xI/dnUQbPvpCM6nBGyfUxH+xV3ocp8EGmAr07b8avGwYoGkP2N1p3FRxI
 StoVZSh+i8ulxu7Ot02gCCUkWHmAsvzcIfTbfUP8CP9SiENWPgGxldRFkw6TyfOFF4zg
 RO+X0n7POcf/G37+D1iu5zz48GgugBqmIyF7FMsVl7/tZq3w3xXlF6xbLniS2Or2L/Bc
 rRtA==
X-Gm-Message-State: AOJu0Yzb/cbDqJ0hf3J0xD5RDNBa/6QL+DEY6eWXtzVYGS7+SGkJkCA3
 zGRO1FJmvcv2ltpBh5axUEBnNtw5wnwv8LDeQ7okZipjKnl5Fjpnvx2SgWyiRHRjrr6vfkFUM7A
 u
X-Google-Smtp-Source: AGHT+IEcLrsAVZnuJ4Sv4i4Sl6V4re5Z2eG33C/8I6uDlvXJLj32IJtU8/S3pKfxBeAUJa0RRpeo8Q==
X-Received: by 2002:a17:907:96a7:b0:a86:a417:72d2 with SMTP id
 a640c23a62f3a-a8a88667ef1mr202530766b.35.1725628340381; 
 Fri, 06 Sep 2024 06:12:20 -0700 (PDT)
Received: from localhost.localdomain ([80.215.236.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a6236d164sm272694766b.111.2024.09.06.06.12.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Sep 2024 06:12:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Octavian Purdila <tavip@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] tests/unit: Slightly expand FIFO8 tests
Date: Fri,  6 Sep 2024 15:12:14 +0200
Message-ID: <20240906131217.78159-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Mostly add documentation while reviewing them.

Based-on: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>

Philippe Mathieu-Daudé (3):
  tests/unit: Strengthen FIFO8 tests
  tests/unit: Expand test_fifo8_peek_buf_wrap() coverage
  tests/unit: Comment FIFO8 tests

 tests/unit/test-fifo.c | 209 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 201 insertions(+), 8 deletions(-)

-- 
2.45.2


