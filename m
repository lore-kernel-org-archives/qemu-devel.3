Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF7ED7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdFb-0004Nz-Hj; Fri, 19 Dec 2025 11:22:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdFV-0003vg-OD
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:41 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdFU-0006R2-Aq
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:37 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-477632b0621so12141135e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161354; x=1766766154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdXBVU3cj91wzneTl+TIyd7O42kKkcA3SVbxfUbxdD8=;
 b=H5nxFDElV4iJZ+tryvMzh4ZifttGZfyjcPkOJZ7fncUwYU6fYxoN63HEdyWB0+9Ix8
 SzU+/I4pJejjDY+WSfHSuLgzO73NZE7RwcI79lHQo0jiMdJmSWdqAvGDOvVgYGsk+0Pm
 IuOsMTshBBVewrvDMl48zlFb4KHtUXEn64xISN1ZWY7lP+YVluQ7iDhZoks/XklofqHZ
 2wwoGtRuNkrEUkQOEDudzeN5g369Kg1/gkx8Eq2OrBVli9lpmfFTPjwnrp4KEryS4pbH
 SDvQANoiZKj2CfJvbCBXIUPcFbikbbIB482qUkV++sYEfDkPuWfF41yTkdSUip7/0/vj
 1p3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161354; x=1766766154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jdXBVU3cj91wzneTl+TIyd7O42kKkcA3SVbxfUbxdD8=;
 b=qT0FlLt28l7qVtt3HceJW6qHYgX4mks6oIY/SXfzKu6lJEQbYAzBvdHn/xvq+MBtIe
 gKv4pJvqJ6cM28am4+HyNNJpNQDNgS46fAKMMudedqpAWMGcn/Gw52YLD2aO25RPa7I3
 Rsk2YEyUFo+RGRLL4w2jTIih6NpvEr9Mt1eh8GzM1mry5HcbKcG1KsdQE/IjY66VKSYz
 8L+sXRVasWJU+3Z7Uc+evwlROzogtG5Zav7GYvNYHjnAi0z2HCWQpsJrYDK8rDUg+Saq
 0mZOmOCMeiqK86mV6LdoK3m5dPjBBGlaaCqcEitjFVUKAM0nNS3bh8NNCPpCzgxrJPbZ
 8ctw==
X-Gm-Message-State: AOJu0YzFlz6arudW5VZksNxz5+qXkdBXM7YfcRDOWhE+64xHRY1ORVeg
 21Fkr48dfhYA9gZPzdDb07f0EP+A7JTjbXWvsemzgGj2uuV1L055jwB8luF8tIUCodFLKXGNeOP
 Qc7Mntcs=
X-Gm-Gg: AY/fxX63Vygtb+ht2bMJ1j7jR+Jwtjw0aNj0OtZJReuQz4CkB5wcH94vWjA7rBn1WsK
 5HJyNRQQkKKLjUxk7e8V7ugfu6FANVP9mt5zpsMe8wMrSagFd/Xv4jl6/RizOJ7xyIVra/OBD71
 m8/3RidMQu/Xxai2yz0CPHeAImz6a7IFuAZ9BO4wEpvFVH/tPzdPQPYG3dy7eps3XQBLOWg11Br
 wo6N8miZbFJpvExx+1b3V3z9CvAKddjYE6GSbI0Tookg551j1E395Ksr2Jb+MaqgxxMczQZ3ORU
 P6LooGxVpSlniZAS4oesQMGcnnYUjBuHLAU8rljUUZPQNtcO3UstjZuiYRDMUdBY28s3EO8eq4L
 taTKuS/OD6Mw0zQzh5Q8T5o7US9axa6MYvct+VN59SCyGXjqPo1o0ePKFSWyZgT0i0ImZL1XiaA
 RYDGhFMSsN+F/JTjsrKYfsPhjTkz2/aKSoC7dVZHJzyOcbcaIPOQtPBcM3mVedvXWeE+s4ESo=
X-Google-Smtp-Source: AGHT+IENXpG1ylj1QuiuuBJFplyjWUiaO+RTYMASUvP8MtDPgH4aGS2PZ6z3vknEd96VziWASpDIEw==
X-Received: by 2002:a05:600c:190f:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-47d195a72fbmr30685235e9.22.1766161354391; 
 Fri, 19 Dec 2025 08:22:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2724fe8sm133542715e9.1.2025.12.19.08.22.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:22:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 22/24] system/memory: Restrict legacy tswap()
 'native-endian' API
Date: Fri, 19 Dec 2025 17:19:49 +0100
Message-ID: <20251219161953.72724-23-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Guard the native endian APIs we want to remove by surrounding
them with TARGET_USE_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll unset the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/tswap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 72219e2c431..624e2cd525d 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -21,6 +21,7 @@
 #define target_needs_bswap()  (HOST_BIG_ENDIAN != target_big_endian())
 #endif /* COMPILING_PER_TARGET */
 
+#if defined(CONFIG_USER_ONLY) || defined(TARGET_USE_LEGACY_NATIVE_ENDIAN_API)
 static inline uint16_t tswap16(uint16_t s)
 {
     if (target_needs_bswap()) {
@@ -68,5 +69,6 @@ static inline void tswap64s(uint64_t *s)
         *s = bswap64(*s);
     }
 }
+#endif
 
 #endif  /* TSWAP_H */
-- 
2.52.0


