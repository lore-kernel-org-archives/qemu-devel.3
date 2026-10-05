Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D70CA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDqbT-0006xc-Mr; Mon, 05 Oct 2026 17:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yundi.eric.xu@gmail.com>)
 id 1xDpmW-0001ss-HM
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 16:59:32 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yundi.eric.xu@gmail.com>)
 id 1xDpmU-0007Zg-6K
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 16:59:32 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-93cbee4b010so132377285a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 13:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791233969; x=1791838769; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kOIV1zUG+2y+LCYyabP7QEGAPX4iveRbB6Db8e+t6T4=;
 b=VMPHkHTQgcs9e1HZdB+0xwPt5qUPlwL3NI9/GMYYhVmaCKMSbMSyuJLqZpcqbsdAyM
 y8AjNTVH6DAIaXglBPISO/84bFX8zRAuLGFyYhkwDLk2cj6pen1eheHWd3zfZ0px1yrl
 ZJYdq0nIUPGXFj47YdBZNPpgBSd/peI2lMGUbcyTe59iN2CN8KzdCWOb0xnYuyZlkjFv
 eoNjs7JkxGMqirT9rWxVN/MiAqCWk7v2H54C/lHg9Uvz5OCbm+7bYKFEktZ5Og4V0pii
 eQ5v5R+W2Ibztg9bOIU7SbP5rSRvL8ns5PKZt52uQTYCTVnnXaIG07Z7+W4ZdRi2sx2Y
 cBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791233969; x=1791838769;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kOIV1zUG+2y+LCYyabP7QEGAPX4iveRbB6Db8e+t6T4=;
 b=kaYJoXHbXnKzJrqVPsPTQSd0KR7k+4vrA8QYX5UqjpFExxuev1InqpZLRyVuFT9QUT
 2myjJhzOUb4K48Xz0/vzjbLwN9cbSS8yBMQewq38qu4s/1aOFq/8nSh7pQL8jo7OH0hI
 9EOjTjB29U26OlpCOyn3WgFQ3Q4+A1TQedOsNZ+prXk3RdkYBG4k3YNNGv6I0YRIJN2/
 7faeuNVoKKW6pADLNCvIm6R5Nu5USEr66+TmvSRDWsiKAC4Dxub2gpNMoPscHzyCw+ul
 nUfrVXnqyXbfhIcyEoknPvxc91Nf6puPMDSnSrp7DJSUuMX1sYPWUKM8MvILtO7hQDDk
 G5kg==
X-Gm-Message-State: AFuF++n+CJdiq8Up25+GkVr2vQG4M2JgJ2vMGxIOwEgOATBueHzuZg08
 eykBYZMHsnNxzr1830kR1bZyg9dqdtHLNhdn2KZ6p4PMtZ1I2Elt173Y4FbIY/Jt
X-Gm-Gg: AYBFou243oPXt/y/bIaqPHQwUPhLp3p0lNbMnAlHT7R6mw045sT3sC/ePSKmhRfWH8X
 w2VZSnmQq9bL4J7CKUF95LLjMvdps1TcqfodswpUhLtN/uw+jzCg4cd2Oijqnc3Zxk2dqvxh8iH
 Aw1yVg9WkNb3Wc7jDTGHUg2TnOupFXVrvEEKcn9Pk9sK43d/JQ3ymQF1J2ASsEDSARrHG4GKUou
 LPsuI3DwwHzTUXeDQ3Eydeq26eIofPAmibZxNmovJ5HZGE67CVPyZx7ikJlzAYfEriYztt/Kr/i
 phZYtHmWVb5WqBiQLpNIfnBf0soXjer0+9g1uLzUqT8UrImI1VKy9K5WpqSI/o5N7xJiI2hu9gG
 O23/bMR90ATkFYvW5IcfWbaxsBXntZPouR+LYnUYUARRhHHok0RdQz0OMr+Qd0LRp4Ogew02Nn7
 BuBdFI9Bzay9UafaeQKJaZoQkxkQ942OkNYYHxmNsl10s8seqjweEJYxuWMz7evKRUapaJlHkh1
 JZFhlCpfQE+DPH2pdvE97D+GGiziGVy6aRraonIl+aT5qXyM560KJgsNiD+sKVb+g1rRuaIFfdE
 OPAR9uHd373Xg7PamQExxw==
X-Received: by 2002:a05:620a:2626:b0:93c:c4b9:9b12 with SMTP id
 af79cd13be357-93e50e4a6d3mr1335716485a.4.1791233968642; 
 Mon, 05 Oct 2026 13:59:28 -0700 (PDT)
Received: from [192.168.20.246]
 (host-183-232.ilcmi2.champaign.il.us.clients.pavlovmedia.net.
 [66.253.183.232]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93cca21d8fcsm978835085a.26.2026.10.05.13.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 13:59:28 -0700 (PDT)
Message-ID: <1e5b1f1f-1d7f-43cf-8883-0e0ab2ec88ce@gmail.com>
Date: Mon, 5 Oct 2026 15:59:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yundi Xu <yundi.eric.xu@gmail.com>
Subject: [PATCH] hw/display/apple: Fix obsolete PGDevice function
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-trivial@nongnu.org,
 Yundi Xu <yundi.eric.xu@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=yundi.eric.xu@gmail.com; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 05 Oct 2026 17:52:02 -0400
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

PGNewDeviceWithDescriptor is obsolete. Replace with
PGCreateDeviceWIthDescriptor.

Signed-off-by: Yundi Xu<yundi.eric.xu@gmail.com>
---
  hw/display/apple-gfx.m | 17 +++++++++++++++++
  1 file changed, 17 insertions(+)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index be0061b9db..e730909c7e 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -767,7 +767,24 @@ bool apple_gfx_common_realize(AppleGFXState *s, DeviceState *dev,
  
      s->cursor_show = true;
  
+    /*
+     * PGNewDeviceWithDescriptor() was deprecated in macOS 15.2 and removed
+     * in 27.0.
+     *
+     * It is replaced by PGCreateDeviceWithDescriptor(), which is available in
+     * >=15.2
+     */
+#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 270000
+    s->pgdev = PGCreateDeviceWithDescriptor(desc);
+#elif __MAC_OS_X_VERSION_MAX_ALLOWED >= 150200
+    if (@available(macOS 15.2, *)) {
+        s->pgdev = PGCreateDeviceWithDescriptor(desc);
+    } else {
+        s->pgdev = PGNewDeviceWithDescriptor(desc);
+    }
+#else /* (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200) */
      s->pgdev = PGNewDeviceWithDescriptor(desc);
+#endif /* (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200) */
  
      disp_desc = apple_gfx_prepare_display_descriptor(s);
      /*

---
base-commit: f7ada39edacaa5c26b30e98b94017b0b2ccbcf94
change-id: 20261001-fix-pgcreatedevicewithdescriptor-3ec303c2500a

Best regards,
--
Yundi Xu<yundi.eric.xu@gmail.com>


