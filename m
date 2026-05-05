Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EF8FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKM96-0005nz-7u; Tue, 05 May 2026 16:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKM94-0005mg-8s
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:13:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKM91-0006gS-LL
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:13:29 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so24083415e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778012006; x=1778616806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3bT1N3L6mxkj0r/8gWcaM12TxdrLt6HiffbP0SCzhlI=;
 b=JdlgvYEVaW1FkjFmAEG8lxQHoy+bdtMWrZByKBK6EWietfhCBPu6j7k+Me+gQwyftN
 vfCsooWDBrYw1vXDrytu2GOtsbYdj9SrAc3Dv04fi8UtSemAcCNcsCwTVl6Lp+OQuEIc
 hOCFk4e8SZA1gfECdez+CRH+Li5vy577m/Gy0/shppjICkvI6amM48tFemk5bJLVrB50
 F8ZZO/DL8/M1zeS4QcFP5PJAwuzBJJTAkNnkrVqwK0bblyUT4Joqw7K+lc/ESpF+YE81
 W0dP9P5wvpk9enMoOjRG3TNzY3R+j2wd9FmvKaZdWljqD8lEsOxymBbgcXoa0gE37NTy
 ZfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012006; x=1778616806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3bT1N3L6mxkj0r/8gWcaM12TxdrLt6HiffbP0SCzhlI=;
 b=bp/fEpVQP9B1W0SZWOLXq3lsQu3PD/x8raQBk0n5saC6BpBcc/SriQkCOvvcyFWCED
 vwfChV70V1Z87bAd3fFgaRutxdv3c09aJ0daSfQCGkIaRJ+e8Cr/X8ErOSR1YHR8pBJ7
 Jj6IVLc4yTfRbg5IetU8g7rqU0pGeeQrlcKjlliUclQcWNwtCtKyj8ZKWjdT9TTh3Wbm
 LItO9DySTKv5OQs7Bt6IxlwsZwbu77A9Ggnt+YWrJIW9u1+3Ne9ml70xHFBxrbfBRvYz
 jb+PXIMO6hCfyerwx9WePohFU/02tx6yz5Bs1D2VhZ1of8C15ExbkZbMZhTWPAqQtZW8
 opTw==
X-Gm-Message-State: AOJu0Yz8XOIzEWI8AvRrw4Qj8KZUrV3v0w6Wp3D1bMvq3gG0RsJ2MjHJ
 dzElYTJvy0beOHXR1cB7hf4iNMHMC8rYACplBXVFD+lYFt7eyeuXxajEopVYEdmxLnXebCR3TPD
 u2Opf
X-Gm-Gg: AeBDieurLcWXtRaMEclUXCuaYusgm7inNCvzD0AnfYW6JksK9ZbjhtYAf4X2JgUl3CI
 bnjdXSaW7nMwtyOOt/5rq4HZrYpBSxPcHJotlJ7FC92Tcf7HtF2raDKYMjpjL+UqCWEpSRh3hLs
 nMttB+3jH0r+C52JfPX7/9ME7oXhoGBWW2V096arjbA2okQkBIUSzDyKyfb8Aj4toKHjen6LTGU
 YuE4axF7HMUkKHnHf+6NNqgUA4RadpiaxTCakOPnyVfajjkzqIzpbl55Rg/Y5W3re+B8y5nmZmn
 E2AlqVo8umIXIzDWZ5Q3ek3axjcnpTSDnnPq9DM6aFsghNc+Y4+LNhtcyxMk0ZF1A1/BWoy5hoy
 O6xiRYu489LglQQgRHy3qWVTAC3DDHcINDPnIqndv6UXgz7xtbVeRa8kT3m7QiJ3n+/ZjzjbG5k
 MUDV11MHUuAIDF6+fnRp2CwBKvu+AU4fSSmA9hhRQ6pykAfBIZgyx3HRlmBhXtIZhjCk7+YXn0c
 USZWRb7+6UHZuLCO7F77lInOn1jyCeoq31JZcAlwA==
X-Received: by 2002:a05:600c:a305:b0:489:2005:b36e with SMTP id
 5b1f17b1804b1-48e51f444e4mr7504975e9.19.1778012005811; 
 Tue, 05 May 2026 13:13:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81ed69fasm497360205e9.3.2026.05.05.13.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:13:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH] net: mark struct ip6_header as QEMU_PACKED
Date: Tue,  5 May 2026 21:13:24 +0100
Message-ID: <20260505201324.932323-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The ip6_header is often used by network devices to examine structures in
packet data, and it's not guaranteed to be aligned. This manifests as
errors from the clang sanitizer like this one:

SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/net/rocker/rocker_of_dpa.c:321:37
../../hw/net/rocker/rocker_of_dpa.c:730:33: runtime error: member access within misaligned address 0x742970fe7ecd for type 'struct ip6_header', which requires 4 byte alignment
0x742970fe7ecd: note: pointer points here
 00 00 02 81 00 60 00  00 00 00 38 3a ff fe 80  00 00 00 00 00 00 00 00  00 00 00 00 00 02 ff 02  00
             ^

Fix this by marking the ip6_header struct as QEMU_PACKED, the way we
have done to handle similar problems involving tcp_header, ip_header,
etc.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Found this one while I was working on a rocker bug.

 include/net/eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index efe270dbfe..46dc9ed5ac 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -119,7 +119,7 @@ struct ip6_header {
     } ip6_ctlun;
     struct in6_address ip6_src;    /* source address */
     struct in6_address ip6_dst;    /* destination address */
-};
+} QEMU_PACKED;
 
 typedef struct ip6_pseudo_header {
     struct in6_address ip6_src;
-- 
2.43.0


