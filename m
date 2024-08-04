Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E74BC3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 16:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sadxC-0007XN-1y; Sun, 04 Aug 2024 12:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sadx9-0007WI-RJ
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 12:19:27 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sadx8-0003yv-6s
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 12:19:27 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70f5ef740b7so5353394b3a.2
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722788363; x=1723393163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5yPHK0BcrnV4vJcXu1DGMeOqCjHfwkVdDXbHbzKAaXY=;
 b=vGj4vImwvgw3QPdxvlUD8aizr4uejszOpm3xOwHqIpvbEb7bZ9gsXmEzNsYRdlGr3q
 bNJ/NMRPimZa5gELUcdzWWuopNe9sW0tsMnaQ2kWHDqphDWWyQiahhofZoS/zp5aCVDU
 TZmNpl7ibVL32VmKyqRNQuVY/IMj45Rn4GSW/ZWP+Yw0YvkpQsuS8Dns59DC7mGsZ+tU
 iGFzRK4br7M4jGa1AM6p+KrwUcWAkfoyU9sLGoinjgNkQbKWgc+pxdXEeaKyeH1stK9H
 ExdxQ6t8He3O6QWxWeB/EvjqsKyUzpVxlLmJJXuw5Km2t2yhQKI5SRPndMAIl/aJpY4W
 Oyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722788363; x=1723393163;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5yPHK0BcrnV4vJcXu1DGMeOqCjHfwkVdDXbHbzKAaXY=;
 b=f6dEiaGo/z9DecCnticIEZLRUCH2uUrS/xou7TEW1n1EBNoGxO+26tF8zwZKYSeq3I
 XKFJJlZ5iAxYS7cV6lI3vMQhDOlK4OwjaY/QMQZ9VF9lhHyaX8A0j/TOLnTb7qenuRE7
 vgUFprSc8gcoiVFtE9z9is/SxM4rOZknaFubsTYnN+qALy6inj4Dggn/+V8zT5l+sEqB
 dIXwmsHVDjqC8hFq5QMcrkEhVhrlYssnQ4BwjtxIg2IXbLCg/sdL6jrD2BEDXdxNXoQI
 0jlYQ4wjgaW9oEkmxIRwUQ8wztUUj9+4AaWHMtfoA7TxdKYWZDhT3m7NqlkTKTvdGRVV
 /Qrw==
X-Gm-Message-State: AOJu0YypGah4DznTIoqE0aYXRMMn5GB9iviCSAt9J1cN9S07tu7fYcik
 3T0hWuwUyzQwYKTcKA9R9IZJ1TOZrgmywr06GUe77/qqZIteQSTk7G7eEv8HoFVpCAwnD8WPgN1
 W
X-Google-Smtp-Source: AGHT+IFZLkS0dVvsS7jjEOzZFOpmx9X8HxtBmNTh42akqZpxNaXSmFJCdZ41vsuPyaf6WOkvib10Eg==
X-Received: by 2002:a05:6a20:9191:b0:1c3:acd1:5cdd with SMTP id
 adf61e73a8af0-1c69966b820mr13996083637.47.1722788363175; 
 Sun, 04 Aug 2024 09:19:23 -0700 (PDT)
Received: from amd.. ([2804:7f0:b403:720f:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec4169csm4117530b3a.64.2024.08.04.09.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 09:19:22 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH 0/3] configure: Bump GDB detection version for GDB_HAS_MTE
Date: Sun,  4 Aug 2024 16:18:47 +0000
Message-Id: <20240804161850.2646299-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42d.google.com
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

The main goal of this tiny series is to bump from 15.0. to 15.1 the GDB
version used for setting GDB_HAS_MTE=y to correctly detect GDB versions
that support all the packets necessary to run the QEMU gdbstub MTE tests
in user mode, resolving issue 2447 [0].

I took the chance to fix a bug in configure also regarding GDB_HAS_MTE,
which was being set even if the GDB available in the build env. does not
support the Aarch64 arch.

Cheers,
Gustavo

[0] https://gitlab.com/qemu-project/qemu/-/issues/2477

Gustavo Romero (3):
  configure: Fix arch detection for GDB_HAS_MTE
  configure: Avoid use of param. expansion when using gdb_version
  configure: Fix GDB version detection for GDB_HAS_MTE

 configure | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.34.1


