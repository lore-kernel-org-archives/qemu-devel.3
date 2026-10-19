Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B41E606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IiPXoaJA;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SxSVncna
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIryo-0006V4-Qx; Mon, 19 Oct 2026 14:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryn-0006U2-HZ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:21:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryl-0005qn-Vg
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792434059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=925o7/vyTRiQuTc9YJYdf05nUSpc4VVdjLEaL/ZmUI0=;
 b=IiPXoaJApB0cSghE/kvrYNys+WldpweFdhp2a1Q1zwjRVY6x6/IdqJHU1Afeadl5lg46Lc
 0hXQxG8bYSnPKXwoN73bLV8oZRvd89jcsFWLZEN93teaiQdYbb0MjN31nwie7pPyF5/D3F
 H5uQ1kXE6vr7RQAOVSKybrZ/WTOfhRg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-CKpQyag6N0O5mpqLhHEnYw-1; Mon, 19 Oct 2026 18:20:57 +0000
X-MC-Unique: CKpQyag6N0O5mpqLhHEnYw-1
X-Mimecast-MFC-AGG-ID: CKpQyag6N0O5mpqLhHEnYw_1792434057
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48af5a07314so1488640f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792434056; x=1793038856; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=925o7/vyTRiQuTc9YJYdf05nUSpc4VVdjLEaL/ZmUI0=;
 b=SxSVncnaOU4NpWmWPsLV/X26MieMIDHHD5AHb/Jh1hFt32E5JEJtovyyA1FhlCjqCj
 6/43R88x/cv8ywBPpD8f0qJrd97MNvLJSD9RuhO3dtJNjVN6IZ7yBdZEMWOAAlz5fKka
 iA6Nkw+uIflmmQaYK2/ApbUrleAZZgR5NumnSz4EdNQ9WOsA8jo8o6G3vUF2Ub7IkeMp
 4LTIhw81qvYh2xYLhk+kSKWkRql0RPE45hwgmkHBjIkkrk91RxkgFIE+e0MeDkMocIFU
 nCVOzZJ6YmyzjppIbbCdiggwxTJUDNE19ooLf8sWtjcmpJ1axtPYvya0BNI/eredaGEm
 vZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792434056; x=1793038856;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=925o7/vyTRiQuTc9YJYdf05nUSpc4VVdjLEaL/ZmUI0=;
 b=o4JLTnZ+waeGW3iwWsjV3iqat2RzKnAv0H1cC6ni2tajr1AYwOhxY9SzhxMSoZcU9z
 Ga3K0Uowr+HB8b3k9PeLQqgyf3FQDUlxyfAU5UJENxsUzxQpgzswgViXJIyxHNPHmokB
 fI1S9sMBNjPD0Mm3/M4kQc5Jb2LqnXKuA+QWy0rbRZ6BPpdPVD2765MXVBxDA487vjSf
 X2j00swQrRGKxsskru8GKRhcTlh9/VQ7JcqwpUgQoxQPUxCAUnkrULVjzCeHZ5VOgH9S
 P7aXKHcQZZHVf9YiDK1chk+Why9D11H0vdgb2Uv+ucUdIVt0Y968++DSCu8AekaV7ZDO
 5HUg==
X-Gm-Message-State: AFq9FYL/nIAXp0akLFrizZ1V74vmlABkIGXl03fhKporoeEe33ibB1GM
 MMjfGTu1cUZ6j7HvG9kCxYU8gexL1kt6+5hFrRDYWVGdFAwG1J/J2BLvbSOkFLPdO+y0z4yT2QR
 /DdlQyJn4f0x8ISsMXmle9OL7XMO64HuyFKczbeSOPH6oPtYn6MrUWgZk
X-Gm-Gg: AYBFou2pF5Dzoee3HNg2ZNvoPwU5zEVdbz4+19/kLbyaYr0ydxuds2ucFeEElvgfT1w
 eP8CU6jdonylzdFDBGt/eVEhlGeij+nxakWjYibYw7mdD3vHKWkp7y+z8PMzGevM5HQY7Pi8qdi
 NDXRg7w7xs9myfoMoCauSii/vjJobGWv7pukY8UIz9jx+XtKB6g1mlLnEM8mMCjEs8jiSVacoWG
 0L49Ph1dKhHbA6oUvgHQtY8uDvx0ohUG6lbbVTGRiRcBXONvWn3pCRDDd13YPTOG7PhK90Y+jb5
 KqsAliop9D53od0CIb7t8NqJUyUmPGw51WNqnPBh5+OdcrRYIKluoXIDM3iGZlCpvxj/VHF+5hR
 jG6/yDT2I6526fx0xqH0Sv/I7cGw97H7oSy+PGV896weidw44/Dlxv5CwaA==
X-Received: by 2002:a05:6000:490f:b0:48b:9d80:53a5 with SMTP id
 ffacd0b85a97d-48e07bbe5d5mr17013363f8f.10.1792434056515; 
 Mon, 19 Oct 2026 11:20:56 -0700 (PDT)
X-Received: by 2002:a05:6000:490f:b0:48b:9d80:53a5 with SMTP id
 ffacd0b85a97d-48e07bbe5d5mr17013317f8f.10.1792434056025; 
 Mon, 19 Oct 2026 11:20:56 -0700 (PDT)
Received: from localhost
 (p200300cfd705ccf50633a9a8543b8b67.dip0.t-ipconnect.de.
 [2003:cf:d705:ccf5:633:a9a8:543b:8b67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d823ca7sm442110f8f.38.2026.10.19.11.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 11:20:55 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 09/12] host-utils: Add u{add,sub}{32,64}_saturate()
Date: Mon, 19 Oct 2026 20:20:25 +0200
Message-ID: <20261019182028.45305-10-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019182028.45305-1-hreitz@redhat.com>
References: <20261019182028.45305-1-hreitz@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add saturating addition/subtraction functions for unsigned 32 and 64 bit
values.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/qemu/host-utils.h | 62 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 1db9dbb138e..848e04c8fb1 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -636,6 +636,36 @@ static inline int64_t sadd64_saturate(int64_t x, int64_t y)
     return ret;
 }
 
+/**
+ * uadd32_saturate - 32-bit unsigned addition with saturation
+ * @x, @y: addends
+ *
+ * Computes @x + @y, and saturates rather than truncating the result.
+ */
+static inline uint32_t uadd32_saturate(uint32_t x, uint32_t y)
+{
+    uint32_t ret;
+    if (uadd32_overflow(x, y, &ret)) {
+        ret = UINT32_MAX;
+    }
+    return ret;
+}
+
+/**
+ * uadd64_saturate - 64-bit unsigned addition with saturation
+ * @x, @y: addends
+ *
+ * Computes @x + @y, and saturates rather than truncating the result.
+ */
+static inline uint64_t uadd64_saturate(uint64_t x, uint64_t y)
+{
+    uint64_t ret;
+    if (uadd64_overflow(x, y, &ret)) {
+        ret = UINT64_MAX;
+    }
+    return ret;
+}
+
 /**
  * ssub32_saturate - 32-bit signed subtraction with saturation
  * @x, @y: addends
@@ -666,6 +696,38 @@ static inline int64_t ssub64_saturate(int64_t x, int64_t y)
     return ret;
 }
 
+/**
+ * usub32_saturate - 32-bit unsigned subtraction with saturation
+ * @x: Minuend
+ * @y: Subtrahend
+ *
+ * Computes @x - @y, and saturates rather than truncating the result.
+ */
+static inline uint32_t usub32_saturate(uint32_t x, uint32_t y)
+{
+    uint32_t ret;
+    if (usub32_overflow(x, y, &ret)) {
+        ret = 0;
+    }
+    return ret;
+}
+
+/**
+ * usub64_saturate - 64-bit unsigned subtraction with saturation
+ * @x: Minuend
+ * @y: Subtrahend
+ *
+ * Computes @x - @y, and saturates rather than truncating the result.
+ */
+static inline uint64_t usub64_saturate(uint64_t x, uint64_t y)
+{
+    uint64_t ret;
+    if (usub64_overflow(x, y, &ret)) {
+        ret = 0;
+    }
+    return ret;
+}
+
 /*
  * Unsigned 128x64 multiplication.
  * Returns true if the result got truncated to 128 bits.
-- 
2.55.0


