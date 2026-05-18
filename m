Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6878CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOv82-0003Ld-Ho; Mon, 18 May 2026 06:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOv7U-0003C5-67
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:22:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOv7R-0004bm-AS
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:22:42 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso28394855e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 03:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779099759; x=1779704559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tcXQkPyrj9ryl+0V331jklwK59WUdwO/zS4bfu+FcFU=;
 b=jqbec5puYKNtVv0J/eLt5B+eOwrdsVJJ5k4Dlu5MkFxCI3VHWX4SAlo1YzzfpjrfIM
 MA3UJbEIi4vIDFVnHUEAWcvJfl8Sn7182g2eCHRaEH7P4QUe7p7DWIlFKLzRibWkJ0VV
 0aGwewH7eavby4qy1qj47Wh/hkCzb5EiCzZ3hTkn1Xg5Qo0Jj00SIZX0oZXVcrS75aGw
 eAEax8ZawCpwWvdrPPzqBTEQ9qThpBdx9ZvV6oSdqnv8vwdz1WiG5OXIHmuBkWWk09o3
 doo4WnBzNAQm38MuL3xwqLm1w6vDBoXSYtjt1wzVnxbV0ZJQ2tWQS2Dhmx7qDe85XZXf
 Sysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779099759; x=1779704559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tcXQkPyrj9ryl+0V331jklwK59WUdwO/zS4bfu+FcFU=;
 b=mYE2m6ILWPheZCRQSXudN1vUkg4Lo877F8fTKmBsNi4/sRNwTtIiLwFgL27O2+w/OM
 /+3MrJb/L7VD4UyxlnZJ4QjAHB4dK81Cfoj3k4W1bhIA1VkTmBH8KD/e/yevo9e/ycd8
 fKLrPfxkdetu6P7l5sRO9RI5imIGzkBsQvidClysg1f8SoCQFKSQTQBbXn6cdeqiRW9/
 IAWFW+94U4+xtb85XE2iZWSv7CIkye0mhS604EqjNtGdWEtzeFQxcQhBjg2rIhcj+aFM
 0IhRQh1+8dTHWrXnTAKXSes2+/TfI2KFfyTGAs/UlHPM2KZ9Ev7z+G2rq2qak+rZJYsQ
 VWEQ==
X-Gm-Message-State: AOJu0YyQtXoKlBMa7mXJJJQMefWCix7VOBCUv6+k++UqHpBSSP9gHec4
 pli0oj7iFlGxMfRyUmc1sgqdj5rQkP86FOJtKG2hBf6FlVlK4FYOKeN/Cas0nRUtDDKtqoERWfN
 NMLiw4G0=
X-Gm-Gg: Acq92OEj0Z2587fJltyrHwImYXISAFi8ocfof0jOK7WDUxFNSSLuybtn2SEolmJth29
 DP+7OqYIlbYOb36eCc9HwpR1ie+j9Pu+xPXslFi478srywhqGVSK06fXn5U8Agr0WJiBUTi3s9o
 RS0eCevDIDVmPNUnW4a2FER7HGydkz2TvF5KkKIkETPgHkSUeTFFhZlH4GgtGjCRu3nOQda/tAD
 8xfhOXa5XDLVknAVY3nX/0JXJNHeVRhIzlRHGDQzJ3i/yfc/VmNXhTk6kniudXI25c2dHqtlion
 cOeC3FxooUN8HD7M11Om4jhrQ6fzqqyc17HRol1DH5pRIbg7O/Vy2NPa1nRVC32pTvUXUaFdB2c
 WEJ0ToPA6pQ/35RefouQOOqXSPKE5u5nrNZcxRSPvUMTVwm/sSSZBhQVXqbM4WALXrjrusqm61u
 B/kx7os08SL5pwpffwVD0QugLJamyyMi6RdEwbT4sLHnGjmdcrt4PGH53EwOQlHf/U3oh23ZrX
X-Received: by 2002:a05:600c:885:b0:489:c57:7836 with SMTP id
 5b1f17b1804b1-48fe6517fdfmr136750915e9.27.1779099758780; 
 Mon, 18 May 2026 03:22:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec39ff1sm38988772f8f.10.2026.05.18.03.22.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 May 2026 03:22:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>
Subject: [PATCH 2/7] MAINTAINERS: Cover debian-loongarch-cross.docker with
 LoongArch section
Date: Mon, 18 May 2026 12:22:17 +0200
Message-ID: <20260518102222.80735-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518102222.80735-1-philmd@linaro.org>
References: <20260518102222.80735-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: Song Gao <gaosong@loongson.cn>
Cc: Bibo Mao <maobibo@loongson.cn>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b1df7a4dd96..17ceb0db349 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -280,6 +280,7 @@ LoongArch TCG CPUs
 M: Song Gao <gaosong@loongson.cn>
 S: Maintained
 F: target/loongarch/
+F: tests/docker/dockerfiles/debian-loongarch-cross.docker
 F: tests/tcg/loongarch64/
 F: tests/functional/loongarch64/meson.build
 F: tests/functional/loongarch64/test_virt.py
-- 
2.53.0


