Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F5606A320
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HH6u5w+6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVAld-00020L-5O; Sun, 22 Nov 2026 11:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAlH-0001ot-Iz
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:56 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAl5-0001X0-3K
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:44 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so3997154a12.2
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 08:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795366181; x=1795970981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=58lcozQBlvFlvhWZsGJ8kScJExcsgoaAtpw1STdA0TE=;
 b=HH6u5w+6zSWmcjJ7oT/F2i7e0kPqONaz+8apvioRStr8d7EWa6g1RkjOi6bODszhjW
 O7byGtoGeQJVlh2itxIyjbGDTTt4bkzjTn8z2H3pT7jEMQW1sYO66B6e8E3ZOeGwPsEX
 cOUcnPPqyrNB9hUXe6KCwwk6eEEIJnhzjgoH0tMf2sDhvpJb/g3Uj0pr2cfxzcvZCGNE
 jKKscV4Z/1/QDGSpxzwaKuJb/bu7XUQpe79pjCrAUIpQyjr5Il+Y+u6F+sAHJczqUE5Q
 B3ar3TSSHaC9e7itwFCE/p7RMBeXvYD3xDteNwsIYHGIxuNUV6FlVYjjHELv0I4+LKi2
 7jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795366181; x=1795970981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=58lcozQBlvFlvhWZsGJ8kScJExcsgoaAtpw1STdA0TE=;
 b=DfLeYrufWq++uWmsnPIeOcFVk5G6kSa+ZSfNOw5Ed6MyOQJ6uBSgf/6RB4BmxiQYpr
 xgnSAufF8Zv72zY5VeSAxR/nYuMpmXBKMK1ZWZNILvy0re5Lv+zl7jUzJV3mQmyXeBhe
 4TNbapR+zbaG7l1PAsbpHTgjO/rmpTx60ctk1Lc7P9e1XeSBaOajwhvLYep7bQ1D8CID
 Co6krfr8pmC0rQUsxq0oz/lZw+QdO/683CdkIpaXDKPG8G6wRt8mpVkijYuVsMLAtfv9
 ZQ52uuUhdsate0K79JidfGyD1SUwnmcbW2ip6paKms1eULFyeTM0r4UGrY1Rr19iOOke
 dkXg==
X-Gm-Message-State: APuU4Z/k+2FnCAYOwjqCgHDze+Tuz4mrGordtM7IgY8pmVnOBRf7sUef
 lJioAZBvQzvwPrgB0qpWbAkWAKt7Ek9bEvHytD8m4MNs7amzGv+qUxzoEd87aw1yth0=
X-Gm-Gg: AZFdTZcC7x49qTALmsfgEq6bIDRfFzHLe9OwASPh4hsPg3uV2UDsKV6zLZicIzSE4gG
 yL2o7ll6k2HWH4jUJyxgrDEPsimyWnD+BW+8+vQXkux+xHxGbRiRGK8HBw+1yGPNKWNrod1M8+r
 40XkiWHgB8lWWXWXvuQ8gbHDUI7gxladnwjZQIIEK5uz/WTfr0gS7y1AUUKmp+wEBkj4nZrz9wv
 VhmE8bkoOh6qgrzZfDIcDKGPWp1SjkzqHY+8Bx5BZ7gzDDUDnecXFo6gWWQtw5HhwHXj3ChCA9I
 YIQguQY/HASc4SUEANwI60kmJVxZ0BqGw9ZVP3N+elv8a/ak7a5sV3TH3vfXFPNICs67RF+ggci
 7yUMNlvG6APwDoblxBHzoGPPEVCJq583sfd+QAKNfWIgOSeOOV2eUyodJb6s5rK/W/0WyyD9vbX
 i1uZ47Py1S5paTGKyBBtPwR9H8z/6LrTdh74/G7MfkG0WGBwQh7MLW3TlXazwbR1Gri7SG4vc+k
 bmtbz0TdPTxjL1yOu78uKhlN4ggLkU0kgb+88rRHIH2x3WwWRSDggztlmP0xqENrZp85lpG8qjk
 /uUjAbei3Zbu2S+fOb0wnKVVfVEKiOqZCwbNX9iS5KE7jlwOk3v4P9RIJiBtq3iQdzi4jJDy25Z
 PYOvHudmyuO1YYBPj+1TZ+1+L/x6LNHy6svVDWtjYAlUvYGBVwb5fnmQWPtbW
X-Received: by 2002:a17:907:3e88:b0:c26:1648:a06b with SMTP id
 a640c23a62f3a-c513aae0416mr795379266b.38.1795366181377; 
 Sun, 22 Nov 2026 08:49:41 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc2455sm325303166b.57.2026.11.22.08.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 08:49:41 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 07/10] iotests: fix test 162
Date: Sun, 22 Nov 2026 17:49:02 +0100
Message-ID: <20261122164905.59680-8-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122164905.59680-1-bogorodskiy@gmail.com>
References: <20261122164905.59680-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x52f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Test 162 expects Linux error messages. These messages could
be different on other OSes, on FreeBSD for example.
Add a _normalize_errors() helper to normalize these
error messages.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 tests/qemu-iotests/162 | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index 4f01611886..73a0c43e2c 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -33,6 +33,12 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
+_normalize_errors()
+{
+    sed -e "s/Name does not resolve/Name or service not known/" \
+        -e "s/Can't assign requested address/Connection refused/"
+}
+
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
@@ -45,7 +51,7 @@ echo '=== NBD ==='
 # NBD expects all of its arguments to be strings
 
 # So this should not crash
-$QEMU_IMG info 'json:{"driver": "nbd", "host": -1}'
+$QEMU_IMG info 'json:{"driver": "nbd", "host": -1}' 2>&1 | _normalize_errors
 
 # And this should not treat @port as if it had not been specified
 # (We need to set up a server here, because the error message for "Connection
@@ -78,10 +84,12 @@ echo '=== SSH ==='
 # expected to be an integer
 
 # So "0" should be converted to an integer here (instead of crashing)
-$QEMU_IMG info 'json:{"driver": "ssh", "host": "localhost", "port": "0", "path": "/foo"}'
+$QEMU_IMG info \
+    'json:{"driver": "ssh", "host": "localhost", "port": "0", "path": "/foo"}' 2>&1 | \
+        _normalize_errors
 # The same, basically (all values for --image-opts are seen as strings in qemu)
 $QEMU_IMG info --image-opts \
-    driver=ssh,host=localhost,port=0,path=/foo
+    driver=ssh,host=localhost,port=0,path=/foo 2>&1 | _normalize_errors
 
 # This, however, should fail because of the wrong type
 $QEMU_IMG info 'json:{"driver": "ssh", "host": "localhost", "port": 0.42, "path": "/foo"}'
-- 
2.56.0


