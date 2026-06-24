Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D27CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHjT-0004yV-PZ; Wed, 24 Jun 2026 03:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHjS-0004yD-Ks
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:10 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHjR-0002vH-6z
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:10 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c890110acdaso258274a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782284948; x=1782889748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQp4e741RWeqANR+AnBnweSrNx7Xk2H8EAfqd4DwHpY=;
 b=lDeBgAVYcMJQbxB6KeRTc1A1djl7faE67Y3C13PtBbv2ma9ScdDwrwDZy4JTEOkSbp
 1LQLNj8poNYDdKj/6HILzoTXP1opx2RhT9I5lgTUuT9wXzCYntCGWh/LDNPKugMk+Fpq
 2uM5soMRIfHDckGJYXXZRMwmxJUT4wtoOg0VAH+7jVAEYGeW3x8ww7dgh7I32laMdrpA
 JtZw/nwiG4Tk6zb28dYhRsLiClkVJcxmFsSTmwqTYcBv/weFIONitgiStktlvg8G6+GB
 r/qvaF6EN5bzArUhhvQ9tUzQD9tuAUe2Sq3/DPT95d1iacrmGiUeVFYihzZQ0enzkySs
 4DxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284948; x=1782889748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iQp4e741RWeqANR+AnBnweSrNx7Xk2H8EAfqd4DwHpY=;
 b=KhR64Uj6FE0hPK0OIcQySR4nntVEwIT3fdFWStgyEZNaPI6kFkPT9V7ifQMACoAb/+
 KGWo+N2mIeToULld/D3HSM/cSft6BDLztSfjYA6HIAqEF/7eS8lR35B490p88sTkL98Z
 AGB31CJgErYAkXpgQ7Zta1EqXNtZCOZWKl5S8st5tw+cIafX1/5pik8aZ5Fq0OB7lU+h
 f5Gc8A76MV0uBfwogz01QimpXMmwNuVHbaa5Uf5X2+/6Y0qpRwAx0K1vJ0R3UOBB68G/
 vHzl5glOfYZSgdR8OLV4Ka4/zfz6qANLxHwO8ZxM9Y06iiyhCKiU2rvNZys9JhwdpLmk
 WH2Q==
X-Gm-Message-State: AOJu0YztVl4Tdmfmzwfilp1DJtYHmXA7WTMF0LmBfOrlvlTopv4UMRpw
 hvtIW/8CikmXVjwih1QuskYdpZjjpbipODD7XLPdG0Or7/cBQqPweyp/voNW+Z0TNDw=
X-Gm-Gg: AfdE7cn/ro5snsS1Wx+CzIGqONaw62ek0H5fXz7uyK7QTsyMxLx+Ufdx7od6bpKbwrB
 q0+7fYXY7+ieKvXRiwNirXLVliEsTHetpkBv7gor8UezCiyndC+xdLmSajHes0sIFoLrO9lDCgQ
 ZSu6++ex17xXqL+XSzfXV88R3e2Ndyc6iZk6q4BlyRf/wddppQWnTSTlrVTZMWy+tbjTjw57N7G
 oZE/tpsntzIXhBAKaV4HfFb0MSme662pigN7BrtFhN+wiCHn7l8A3m3im92cv+E8wylGmhwYpZF
 cmMz1cLz3bH2qkE1Z7A1rswkp3yeRWsJyVJMEJXOfNsJNZ+zSe3Bwx47bbqDezUdlxLeZO8CEp5
 ni40+rSGIBDzfEuZm6YxYOJtXPdqzZjUYQGjApyF2yIePh80kiCmHhDuQtViM3RAW+03dkwBiVK
 1YRWEQJpmRrZRflxSkITYAgobG4eCOatwU+i1zhZmTagKFn7dPQbed
X-Received: by 2002:a05:6300:83:b0:39b:89e0:2e37 with SMTP id
 adf61e73a8af0-3bc51b6c387mr18632164637.14.1782284947662; 
 Wed, 24 Jun 2026 00:09:07 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::1277]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8e92asm10736569a12.2.2026.06.24.00.09.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 00:09:07 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>
Cc: Zhang Chen <zhangckid@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PATCH V9 01/17] qapi/misc: Fix missed query-iothreads items
Date: Wed, 24 Jun 2026 15:08:35 +0800
Message-ID: <20260624070851.13342-2-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260624070851.13342-1-zhangckid@gmail.com>
References: <20260624070851.13342-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The example is incomplete: it misses members @poll-max-ns, @poll-grow,
@poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
(monitor: add poll-* properties into query-iothreads result) and
commit 1793ad0247c (iothread: add aio-max-batch parameter).

cc: qemu-stable@nongnu.org

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 qapi/misc.json | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 22b7afed9f..c71a5fe657 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -123,11 +123,19 @@
 #     <- { "return": [
 #              {
 #                 "id":"iothread0",
-#                 "thread-id":3134
+#                 "thread-id":3134,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              },
 #              {
 #                 "id":"iothread1",
-#                 "thread-id":3135
+#                 "thread-id":3135,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              }
 #           ]
 #        }
-- 
2.49.0


