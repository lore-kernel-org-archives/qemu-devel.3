Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2ADC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 20:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trjrY-0001Fg-P5; Mon, 10 Mar 2025 16:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3R03PZwcKCmQMQONQFKIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--komlodi.bounces.google.com>)
 id 1trjrS-0001DK-Sz
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 16:36:32 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3R03PZwcKCmQMQONQFKIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--komlodi.bounces.google.com>)
 id 1trjrP-000119-D5
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 16:36:30 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2242f3fd213so52261995ad.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 13:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1741638983; x=1742243783; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=U6kjlby6gR+5lUKTiKqGDet2q5G17Sdtz8VHLqhFM2U=;
 b=j1nmOdPy5Zt9btbmsVXhyUJeO2RhqvC3bOhjKQ4RgEUIC57FQmJlfKwukl9X7oD8qZ
 8aPhHmAlWBOKjdDFHsDnit6AXx41s1XngECmgiI4jgXdODpsbpNBJnjv2ap3GIxbqAkv
 f+Hr0JddhxoUAMTPoj+wuhWmYkkxSrzQHQ/lY1/7wfgjmUCqzWejfuaItQBb2/6TATQg
 la9It9lVhuYOea8AnlSs7B8AcBSrnN5W0ZHZCtJ/cx0iILio348QpJaU5+aHhUfAhbsj
 Pkrubps7ErWQW6KNW4rVYn+FvrqOtPoAl0+qf4H0oGVBA1tOSfYkhjdSWPlQqimON/b5
 BHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741638983; x=1742243783;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U6kjlby6gR+5lUKTiKqGDet2q5G17Sdtz8VHLqhFM2U=;
 b=O5LDFKbpHigc8COjr9+/bs5huwzIybEov7iiEOFEZ9Stb/dUZsiPVcriIw444rtnrz
 LP0+aCOHoOUus9+hKz65mVMlJzpvsu3U5WYlOwVxsoEdtsLjN5g8Ohjlqj2Aifw29OeP
 fM5o47HHJ02FSp8enFBEo5IscjI0TI9XG15MAxqtPECVVumj9715HsA+MCnszwlgbFSf
 y7AW1HaHIGeHv7+Zt8v9hqLfpREaO15RuaVGv7fdhjagBmdxWmhhtYxs9bkwDRlSB9jL
 ewEIF5cIIXMkoVZ2xFMEhyBsUeJpjcO+lOyCdbdtXB4U77d74IlyHGKrz3rPSLGcn/U1
 fIYw==
X-Gm-Message-State: AOJu0YwceV19pxuPxqB0BCQGF3kKWdGnF/GhY3eFOM+C4zUCoC9czWTG
 WoGOIT8RAZGpBBXkga+uMBYIq/v3vta+C/UpEhEye32aNJLTDIWHmKhr7Xd8Yq6TXzwnVM7ykHM
 l96vEYL7cUG8yA4OUlQMWbX1wtd+jHG0TDsS9xzsSdTl7887QoG8XGGcAi6WYyET2kBarRN1jbY
 NEMGxbebsnc5Gs17FTcXx50UzyDtoGAir2Uv0M
X-Google-Smtp-Source: AGHT+IHqU2Jea/hS4O1+U1/rJCq897uTnq0UXG7T4EqSAQOJrOGmwftBjx5X3ybdUdvGlzjCjirY5ZA4dMTA
X-Received: from plge14.prod.google.com ([2002:a17:902:cf4e:b0:220:da6b:5d08])
 (user=komlodi job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2405:b0:220:fe51:1aab
 with SMTP id d9443c01a7336-22428c05613mr289463985ad.38.1741638983645; Mon, 10
 Mar 2025 13:36:23 -0700 (PDT)
Date: Mon, 10 Mar 2025 20:36:21 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250310203622.1827940-1-komlodi@google.com>
Subject: [PATCH 0/1] util/cacheflush: Make first DSB unconditional on aarch64
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: slongfield@google.com, richard.henderson@linaro.org, pbonzini@redhat.com, 
 komlodi@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3R03PZwcKCmQMQONQFKIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--komlodi.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi all,

This fixes some TCG TB corruption we would occasionally see on aarch64
hosts in certain situations. Specifically, if the host had CTR_EL0.DIC
and CTR_EL0.IDC set, and if the TBs generated were very small, the
instructions in the TB would sometimes be garbage. This would mostly
result in a SIGILL when executing the TB, or sometimes a SIGSEGV if the
garbage instruction was to branch to a garbage address.

If a host has CTR_EL0.DIC and CTR_EL0.IDC set, the aarch64 cache
maintenance function doesn't execute a DSB, which seems to be the cause
of the corruption. I think it's because the ISB guarantees that the
instructions will be executed, but doesn't guarantee that any
outstanding writes will be fully committed.
This only seemed to happen on very small TBs, which I'm guessing is
because there's much fewer instructions between the TB being generated and
executed, which could lead to writes not being committed before execution.

This function is intended to be a copy of the upstream gcc one, which
does an unconditional DSB, so we can fix this by just doing that as well.

Thanks!
Joe

Joe Komlodi (1):
  util/cacheflush: Make first DSB unconditional on aarch64

 util/cacheflush.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


