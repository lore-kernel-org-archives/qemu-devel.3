Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7B4D32D63
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 14:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRWlh-0003ve-67; Fri, 05 Dec 2025 09:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sholz8530@gmail.com>)
 id 1vRTU5-00042k-TW
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 05:56:21 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sholz8530@gmail.com>)
 id 1vRTU4-0007o2-HZ
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 05:56:21 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b736d883ac4so335691166b.2
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 02:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764932178; x=1765536978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cwraOVn55NoeKBLaepSIkiLFyMSjVTl94hKTzSj4IRU=;
 b=ld+ewap8IjNOaIUg9ud6dARfMElDJNM6QR1VB/HRiIbGw3QgQED4R/og7mHE46ZbbK
 GYh5iWeiiupnL3XlAhlCyqevwvn1h712X2GUQFV7EiyQawpUjannOidAUfE8qrG/l1Xe
 C+N9fTCqbJhxCeUagH18pBwWYxNez6JpZBPN5hcraUEt89foubJtat4tGy85ojvSEf2T
 dR8MJZjq/1psXdUWyUi/CDZaUIvn2gWI6HWPjuWSXuWVO/wOse2VUzW1l7G7dj2CP4f2
 MIUQABkcvwaoCVs4ZQlsnS3TkZ8WNwJ1SuMee2bT4nFmYPPw+Hqtug5tCM8BehJr98EV
 W6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764932178; x=1765536978;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cwraOVn55NoeKBLaepSIkiLFyMSjVTl94hKTzSj4IRU=;
 b=Y+MpBZXRCcZT7VN2di7GsdQcICtfOQnpDHNzO5fUF/n1I+rpBEtyP9NtKlqYqMnnqY
 hM7qlIoXPZaMLAmpVglbfozFtXNet7L7WEHZXqXrpxA6R6uKBUQZ8vfp70ftcyipxaJW
 2ycoWXqiVqzx3xypCDERVySjfH3JGnQY/LgzGfPol6lqN0FigBEdN4s7AJbXiXwU6u7L
 ReV4vn3LtL/7Zdx913F3wpqHA9xbwsqmF4JrSFNQKmlUG8pM9OQpKIy7ZyFRCvAwPChq
 1NR1bbuKCg0VMGmu6x6oY5lV3HFSy3ZfMKkeKcZzfrHK+EqTQYPeqyF0KEdp5oj/Tej+
 mZ7A==
X-Gm-Message-State: AOJu0YyzThyKA0GMp39F7FrB4XFpLzlpyONc9MQcGrXYL6Qg89RdXRUP
 eU5PP78hjioRiB7hQONy9DGRQFEOWtxgWgjsC+t/d5l5gjzoB/xmsDF+f/MiUpTA
X-Gm-Gg: ASbGncuXFtB34/yLL+GOMY1nZRxh800CwWPvARLax7UeB4y4X0hbywnwW1IYWzBc1Mw
 2JZDw3Pb46vW8VjDDsPZ20mJbugLHRyK8/WLox2PdlI3f7lWTO4VSgMAFhr6OObNgsEhkomZ/7r
 QBaD7z/sT9+IZ+41rcRD3y3NfyqIcRZfTu84IPiOgp9rAQ+gNarJ7j/aVDYT/xlMZM9IiVkKkvX
 fPZio/0D4SECtXusccm2ZRB/kBCavbpRSUb9Np2uCpCltMyJaOHL0ooECYVye98lvwVdXayLz8g
 83zxnNzCFissXge9hjwrva8Kzy/hHYEMhud6W0tkIPggr3aezWNsThqMLoWHUiOrx39r6HOIVl0
 DhC3LbEF+cTcskVAjnty8/CKJd7dyjKtflHmgOi0zmMESarkQpbtlYDo7aGz0J/ez1EcSHKETso
 C5cRFipGRvZzkTmLg=
X-Google-Smtp-Source: AGHT+IEqCqRZseJDI6nzVS/ydCi6GspEh2Ulm7EaOrJI3m5g0Zvfu5jb6QWB7hsRcrBoLkCsTUZJ6g==
X-Received: by 2002:a17:907:2da8:b0:b71:29f7:47dd with SMTP id
 a640c23a62f3a-b79dc734de4mr978723266b.46.1764932178064; 
 Fri, 05 Dec 2025 02:56:18 -0800 (PST)
Received: from spc.fritz.box ([2001:a62:621:2d01:31aa:7bce:7c8c:aedf])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79fe78c9ebsm211243866b.5.2025.12.05.02.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 02:56:17 -0800 (PST)
From: =?UTF-8?q?S=C3=B6nke=20Holz?= <sholz8530@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?S=C3=B6nke=20Holz?= <sholz8530@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] contrib/plugins/uftrace_symbols.py: unbreak
 --no-prefix-symbols
Date: Fri,  5 Dec 2025 11:56:14 +0100
Message-ID: <20251205105614.13673-1-sholz8530@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=sholz8530@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 05 Dec 2025 09:26:41 -0500
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

Since 8a545a336d, `name` is unbound if --no-prefix-symbols is passed,
causing this script to break when that option is set.

Signed-off-by: Sönke Holz <sholz8530@gmail.com>
---
 contrib/plugins/uftrace_symbols.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
index 45fb79c7a5..21704541a6 100755
--- a/contrib/plugins/uftrace_symbols.py
+++ b/contrib/plugins/uftrace_symbols.py
@@ -98,6 +98,8 @@ def generate_symbol_file(self, prefix_symbols):
                 size = f'{s.size:{addrx}}'
                 if prefix_symbols:
                     name = f'{binary_name}:{s.name}'
+                else:
+                    name = s.name
                 print(addr, size, 'T', name, file=sym_file)
 
     def generate_debug_file(self):
-- 
2.52.0


