Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6795E68179
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIYc-0005mm-JV; Sun, 22 Feb 2026 18:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIYa-0005Rf-3Y
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:08:08 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIYY-00064l-Ga
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:08:07 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4837907f535so33156115e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801685; x=1772406485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EfTtfTTU3wlW3mcARDFC2+pUKQHiKvLPF7i7ypFyE5Q=;
 b=DujAFY4RksngvSuLrse5anQOYps/x1pO8B3xNU5kK6hSnpBcadmkbPssBsSXjIkZKf
 6z2JHPiyHi8ZseJzcKTG9hB3Ya7lsyaZ1+DDFKmJrgRi1/4d8Y28LytgbEkjNtE1hYpP
 b8YTxjhUubtC9/upYR4YAnRyPM+OzPWfQc4sHOkB5wNyI+uCf781AMHXen9r8C3JMCIT
 U/FQyfJnZwqgrMlSFHsluWtFAOyXMnNPi9YvS0M0079z5RCK+5/RGWaaC/NmJTKjE6MS
 kr8FlNopeoUrCRT3uQsgTq6YjfUjUov7/Uvuu4RQZ9uHix9qdyEdUUw/7ywtaAFLK9nD
 pVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801685; x=1772406485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EfTtfTTU3wlW3mcARDFC2+pUKQHiKvLPF7i7ypFyE5Q=;
 b=i6jit8lzPRyaP1WFya6U6uVQq9ABZZk7DBb5Pu5WY3d3O0mougbBOoz4vgiR9bfQ1E
 UYqjk+7PKvQYMx1bNkGLfbhHTmH32snPlNiv+3mGf//4mUrx4lnqXSIGCwEFov2KUbYY
 +d7M9zqkgQDl1lNQuH5aOBYNO1YG/zvuTwgWBgRR9GiY2hrj/CFGLB6G2zr1QvB1Rzr3
 vGxPVlZrBxFaqg9JbWyXk0pU0jsINrGrW72/pta+TJKiJEzzFQWS7HVHwTHz6z+jn8k5
 zACtyB8y4vJlt33Hcgo2H2lBH+ERZAOldZ1M9jPuJXx9hDnxivHi7uJOA5Wil6sVrtfm
 D7Sw==
X-Gm-Message-State: AOJu0YwgPY/xLuJJ8GRq2r/XPdrJhnCqWf4jkTkg4fHU4sJmV3B6oKSR
 JWez4+++PF1Qj0b7p32hlbNxkBXJniMQnf+rleLujZZpdndEBTtAUx8zbTY+SqU/RGSeBiotQ1B
 x4vCyW2o=
X-Gm-Gg: AZuq6aIy1N4GW2dzDYTokJy8P/WjIrQFd7rNgd+eKRtcLPjL9bE0u3VpCQT6IcUXFGm
 bsofWWhtY+XjtZuO5SwdFFjt5AFC79VJwhU0kUQHwXIWepqDOqgrNzRoF2RclpmFvXktAJB4Vni
 kFucQQE617HG+I7fRqTCl9Ib0VmFUCCAMZYVn6V2xJtcgJ+E4oXBfJWQPKrcuVhE3Xs5gvaad0u
 uZLfDc4kAfjTajKn6RM3/LxdNQRhviFyUamzLJ5MfSK8+gVP+rhzmmrOF8Hr995iqop6XOZbHFT
 D6nrjx7s7uHBSaviUa+tSWk9XSUsKUDcgLgr9xyuqhANAsN1l7uTpygjxxhnaqLit7/BIgWTcrp
 4HomBqZWJ+MmQQxrIzXqC3oV8UI1XCeP2zzI1P2/tvTnPmQu7+Sj3rb5v7CyvM8Anl2uaEdbN5C
 +bo/GZKGDT9qxUnSWVy2GpDWUmmp409aQtTiPPkAeODDVb4VN3lsEU1DEF3jYoXhqN2e8Rh/7/
X-Received: by 2002:a05:600c:1e1d:b0:483:702f:4633 with SMTP id
 5b1f17b1804b1-483a95bd8fdmr117245725e9.4.1771801684671; 
 Sun, 22 Feb 2026 15:08:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970c09897sm15226445f8f.17.2026.02.22.15.08.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:08:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/20] net: mark struct eth_header as QEMU_PACKED
Date: Mon, 23 Feb 2026 00:05:59 +0100
Message-ID: <20260222230602.5756-19-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The eth_header is not actually guaranteed to be aligned.  We attempt
to deal with this in some places such as net_checksum_calculate() by
using lduw_be_p() and so on to access the fields, but this is not
sufficient to be correct, because even accessing a byte member within
a misaligned struct is undefined behaviour.  The clang sanitizer will
emit an error like this if you run the sifive_u_mmc functional test
with sanitizers enabled:

../../net/checksum.c:78:47: runtime error: member access within misaligned address 0x561f52f35011 for type 'struct eth_header', which requires 2 byte alignment
0x561f52f35011: note: pointer points here
 00 00 00  00 33 33 00 00 00 16 52  54 00 12 34 56 86 dd 60  00 00 00 00 24 00 01 00  00 00 00 00 00
              ^
    #0 0x561f20608459 in net_checksum_calculate /home/pm215/qemu/build/clang/../../net/checksum.c:78:47
    #1 0x561f20117bfa in gem_transmit /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1386:21
    #2 0x561f20115c61 in gem_write /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1650:13

SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../net/checksum.c:78:47

Fix this by marking the eth_header struct as QEMU_PACKED, so that the
compiler knows it might be unaligned and will generate the right code
for accessing fields.

This is similar to commit f8b94b4c520 ("net: mark struct ip_header as
QEMU_PACKED") where we fixed this for a different struct defined in
this file.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260212140917.1443253-4-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/net/eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index 14c34f530fe..63f598d7cdd 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -39,7 +39,7 @@ struct eth_header {
     uint8_t  h_dest[ETH_ALEN];   /* destination eth addr */
     uint8_t  h_source[ETH_ALEN]; /* source ether addr    */
     uint16_t h_proto;            /* packet type ID field */
-};
+} QEMU_PACKED;
 
 struct vlan_header {
     uint16_t  h_tci;     /* priority and VLAN ID  */
-- 
2.52.0


