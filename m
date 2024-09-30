Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1309ACEB2C9
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 22:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svOjk-0005D3-Un; Mon, 30 Sep 2024 18:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svOjd-000534-EH
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 18:19:17 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svOjb-0003Nj-RR
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 18:19:17 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c42f406fa5so3618138a12.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 15:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727734745; x=1728339545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dBVisv6CnK8BsPMNbVwRBZnc5TuKgu+hW3tSFwMb0qs=;
 b=b2BUzSpxX3QxSnKFmiiSFoEcP0motgSrvEurekYYcWQXWhivIXE/vTRRxd8ieQUEXV
 476dmWNp/ZfHOQAJ+AMfdnQWg1xCaOi+v13XU/aIzj+NflYA83308yjFCFWdvz3SJN6i
 avRyxj7c15cD64LhRtVAoCaFdI+t5WSS9mypNT2mMWcnm4EWzL+i1rWLWiezAi6G4WOa
 lCQ4MxsLFD9j3Hwm9MOOaFJzT+o0ZS7rOfOVawRuLCIZY/Zf1jxZXJZK4YilIPprhLRS
 5COsKRUSbbdEmkBPO8GRWxdQxfo7bxWknqyV28DweahBkOfZ+OEPNfn3eitzn1DaQXml
 pfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727734745; x=1728339545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dBVisv6CnK8BsPMNbVwRBZnc5TuKgu+hW3tSFwMb0qs=;
 b=YtGe9Y6yZUmxUWpzKvby4R9/D1MjtR7qVG0GS2zDZB4iO/giMQZ9ckWsgFLTUyuKAF
 wBSieozmKJ6LdxEZLZRFvzEQoh6RrPL0fkRGPguE7atUS3B7QJYROvC/Yq1oR6xdUk6a
 4UaGvPiJb7jFLjmTBA8vIbot58cTA/7zbSlwE4+DTJDvNYerOCZB7hlwSH9Vft+fQe/7
 d/85Z8/Ok191iNOgd744LIdiMd2O2wAD2Dv8uIzJgphs7K/SMcxBfEXnqhHbgekDJWzY
 UgR6RtfJyWeYAZjr8g33Y2iZKYkcyDKpbTY/pSA0uhdopqTw3R0/nhbNtgjWjt/MvZkO
 85pg==
X-Gm-Message-State: AOJu0YxreLgg8OhztzG/GTi9KVeIUDvBJKKcg4HPbL8YPvkeOJtH7nFo
 VvwN4by6QFMicGBaMPrwNWaW4ebXsZDBx2O5mQXbVmnRmb6TESeKPP6M+ON2mog/2cJPjqf3zXG
 AQ0I=
X-Google-Smtp-Source: AGHT+IHOxpTvaM+STDVEyes9m3V2qBg7w84kuYxQ04CvMAqAi+3Rc2aPzXOrAoZRzPYdHNXnrHo+uw==
X-Received: by 2002:a05:6402:4347:b0:5c4:2fca:b11 with SMTP id
 4fb4d7f45d1cf-5c88260f022mr20417119a12.35.1727734745548; 
 Mon, 30 Sep 2024 15:19:05 -0700 (PDT)
Received: from localhost.localdomain (46.170.88.92.rev.sfr.net. [92.88.170.46])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8824051c2sm5002308a12.19.2024.09.30.15.19.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 15:19:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 0/2] hw/core/machine: Extract compat properties to
 machine-compat.c
Date: Tue,  1 Oct 2024 00:18:58 +0200
Message-ID: <20240930221900.59525-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

Extract machine compat properties to machine-compat.c,
make the unit target specific to be able to compile with
target specific compat properties.

Philippe Mathieu-Daudé (2):
  hw/core/machine: Add missing 'units.h' and 'error-report.h' headers
  hw/core/machine: Extract compat properties to machine-compat.c

 MAINTAINERS              |   1 +
 hw/core/machine-compat.c | 287 +++++++++++++++++++++++++++++++++++++++
 hw/core/machine.c        | 279 +------------------------------------
 hw/core/meson.build      |   3 +
 4 files changed, 293 insertions(+), 277 deletions(-)
 create mode 100644 hw/core/machine-compat.c

-- 
2.45.2


