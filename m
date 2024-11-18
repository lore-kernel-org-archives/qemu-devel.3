Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8E8D591A9
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 17:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD5UX-0008VE-Ou; Mon, 18 Nov 2024 12:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tD5U6-0008NE-VF
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:24:24 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tD5U4-0002ow-AQ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:24:22 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2124ccf03edso90225ad.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 09:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731950657; x=1732555457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJI8STVH8Bo0tJY7LAmXxwBqwEyTRfjQjwFSYQdXg1E=;
 b=fw+0weitW8wMSegB//tppJ2hQYIZNdYcbPQ8cAgvNz8jSGq/gTT8Gy6pVomgHcUywO
 K/DuemwfMScvAMRZD7EouIfBfaI/o1Pxkq0KYInAGWBImuHJe58EZW+AuTjMzqnffp/M
 wYbku8pL+b3BwEy/rQBMJh0m6LL9aanPYlev+xBIP/wAW+DcE+bDojbB0gbOqFIRHP3e
 1UPQGijnkdfgOhph9KTL0lXBhDUwmIHJ7OHSBzhnwc9jNvs3c8fGPdwS9EU3c96r7Vth
 Oh8rfD3pOlSBJnVAwyl9qNHN7TjkXIvCv+4pF7XQVpvrqVia5qrFi+uYMK/GpxpJ4xfd
 GQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731950657; x=1732555457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oJI8STVH8Bo0tJY7LAmXxwBqwEyTRfjQjwFSYQdXg1E=;
 b=wZOCO5yqMJ6ZHGZNaEhCb7r+RGdiW8IBDZ/LyQl0blTAa4owB2GP1cyRatb+HzS4y1
 fBJFw5kAVLUHDippD50cixIRa2jFA4YAlB1QwZIEAVa3EtDPzF3KsTFS0ZOg1ymhgGCP
 3AQcYwLbPt7jkOA7FgMmPtHmuQXYuSWNZNyRLilz8dbVbK5Id3RmvRhSPftrCbvrUzwz
 I1TknuLt3XKDK1m/z+q6dcWYJf56PbNPc4iExkE7rX/ev8JmCX9TD7EMmDAu/QhnQwd2
 K5R6g3vPR++fvo6lvpvmagNjMWHtCVGPf58gtZYXfgiDbpRN6XRTCW8JVx4r5LrfOCQt
 zAeQ==
X-Gm-Message-State: AOJu0YxPP1d5artBeYFHLb9jPvsvCU9HWWiE7p3lW4kehaGh2clGCf+P
 8Q8KVhiJNM6BciqqKkDmr5c+w2ijuADWHKJ/+VZtfp1EydsgKwTlSnNJGLeFN/0MykDTWZcXz10
 UIktP6w==
X-Google-Smtp-Source: AGHT+IGKRu9eW2HfGpfNTqNSZ6X9JKssRl87etJ63B8V8eQW5O/yNx303ObNGLP/peeM6ZoQWUEZEA==
X-Received: by 2002:a17:903:188:b0:211:f6e4:d68f with SMTP id
 d9443c01a7336-211f6e4d9f6mr102645405ad.6.1731950657231; 
 Mon, 18 Nov 2024 09:24:17 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f55d04sm59469765ad.264.2024.11.18.09.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 09:24:16 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 alex.bennee@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 3/7] docs/devel: add b4 for patch retrieval
Date: Mon, 18 Nov 2024 09:23:53 -0800
Message-Id: <20241118172357.475281-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/submitting-a-patch.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 953682f20cb..d25c677d996 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -417,6 +417,16 @@ For more details on how QEMU's stable process works, refer to the
 
 .. _participating_in_code_review:
 
+Retrieve an existing series
+---------------------------
+
+If you want to apply an existing series on top of your tree, you can simply use
+`b4 <https://github.com/mricon/b4>`__.
+
+::
+
+    b4 shazam $msg-id
+
 Participating in Code Review
 ----------------------------
 
-- 
2.39.5


