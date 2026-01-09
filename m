Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3400D26D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFjj-000091-4d; Fri, 09 Jan 2026 11:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFjZ-0008K2-5S
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:53:10 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFjU-0007aN-AU
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:53:08 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47d3ffa6720so45558325e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977582; x=1768582382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GL8P56C3QKW+wYSnHUjfX38VQq1YNg4U4yN3Hx8cg1U=;
 b=SMrXUnlgxkdix7WG9eS+UKr8Pc/N8jeUVkwaBkUeVf+augTimWW/UTUKeipHVhrSdI
 IhL+YGTtLtmzOuDV17m9vnPwOvqymOio+oY/ExM57uQIpElV/7cNxKA/KdJ+raOvkWCN
 cEgn5MOO9pfCIlrqiw9b7tbyzIEnTsX40d1jr+Plhe2qlzqH70ryMi+2szCjmq5NrwH+
 SUN6GhbIKgyB4FKRC3C4pUPQZ59pwb3cNISnnW7r/gqjKrX+WXelvtJ7WE6SDg66f6Vj
 IjPsHtFFHT+thXa1icZ8Q7hLIfAHlBqcmSAuhKvGqKaX/+RhTUS44ND61k1Nl4JEaq/q
 7zNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977582; x=1768582382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GL8P56C3QKW+wYSnHUjfX38VQq1YNg4U4yN3Hx8cg1U=;
 b=sZdIi53XNKiTeuXVhEG0VBvORUfyapJliyH15P7kB9pUiSRgySyRn8MuaWk8L+AIBC
 JGhdXQX5Teac8mnTvUW3R2bLYyTjMvJ4HC96CyzMVeWcqJbq+npquyWOEGVCI37RIRa4
 Xf12ejlu79BGZK5Q6/QESsjcz4F+fIiMkOyXI3kjjJzZAvuuq/KmTcMpSxhrH6g8I2Zh
 //kBJhMqds9JmOnUDInL1KdGfNifXFmWQHQrMhy9vNCLgksLg96OVPLTOHd4Xhvvzof7
 VEqNR8GWwPDm4eArObStRMlkUSqf+nwhO0Lri6luaZl+vviYuVVLsuwJ9upRRv3gDHwM
 XcJA==
X-Gm-Message-State: AOJu0Yw8WszGdPW0WmUtwJPA7tOktkIUsNgsKEor216u8iyYnfEmHts4
 9vxJ35/Fzt0xTLR/kP5H8wW601JTOQV1OgybrLTVILRu6VMiMriFVF3FQWUUcGTuMSXeWLsPflV
 1eF4OY+U=
X-Gm-Gg: AY/fxX6rBm7Y8jjFxXnIDsW1W2NfxCxl64hkWHQNjBY6MFEcIdGC6VWyjjDUIt7Powy
 DvDQf21BJ13Vart1VkC8IaWzweNjjNBxZPmWb5JknrclYnKHspUV+Yb76ubmkhJ2+bA6rDsuRpv
 SzvvigcS1NvuYsZlDFRZY3Yipt8JGqmySmBIPcpFmg/R3Uc4UWSl06R7y2TRzqnFyzSDLD58khd
 9aE5E2SnFYZh16sZPA7ir+H5O1LJeX8BsBDKuSnIorcypGRa9V1lmP5hpCYNmQZxa39O0y836kR
 65pfAEaaxAcE0j2MBUgMd+bKxsief+10aa6eQNfjvjCptDmwyr3899IKTRa/3N6nW2D1Kd4qlgO
 WbHa5z02xc9WEs57TLKbmkdOjXpLRj/mGmmvTFFCySTUxCH7fH6/Pif9Bi7woGbl2LyHlnNLqtU
 iI3JlXzGeqI3mrSZBuF54fXpl7kY1fviD3irTZ4QHJvQ+8MkQ/fm8hr3n1i9k/
X-Google-Smtp-Source: AGHT+IH6UBEzw2dRoWqX6WmBU+nTdEZ23v8QzwsIiecIaSZ0jAFlFKudKC9BI4Cfwp3Xdyj0+Vr6vw==
X-Received: by 2002:a05:600c:1e1c:b0:477:58af:a91d with SMTP id
 5b1f17b1804b1-47d84b0aa4bmr104709775e9.5.1767977582165; 
 Fri, 09 Jan 2026 08:53:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653cd6sm228678875e9.9.2026.01.09.08.53.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:53:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 18/22] system: Allow restricting the legacy tswap()
 'native-endian' API
Date: Fri,  9 Jan 2026 17:50:54 +0100
Message-ID: <20260109165058.59144-19-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tswap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 72219e2c431..9e94fa0021c 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -21,6 +21,8 @@
 #define target_needs_bswap()  (HOST_BIG_ENDIAN != target_big_endian())
 #endif /* COMPILING_PER_TARGET */
 
+#if defined(CONFIG_USER_ONLY) \
+    || !defined(TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API)
 static inline uint16_t tswap16(uint16_t s)
 {
     if (target_needs_bswap()) {
@@ -68,5 +70,6 @@ static inline void tswap64s(uint64_t *s)
         *s = bswap64(*s);
     }
 }
+#endif
 
 #endif  /* TSWAP_H */
-- 
2.52.0


