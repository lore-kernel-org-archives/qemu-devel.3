Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70659C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 09:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYMpu-0005u7-BI; Fri, 09 Feb 2024 04:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMpt-0005tA-AZ
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:06:17 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMpr-0000i6-Rf
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:06:17 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33b2960ff60so1010785f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 01:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707469574; x=1708074374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cbHg54FPHaJAybTU864EBj6Jitha7wqkJSQ/7bQlzd8=;
 b=hanzaiZp/UjZOvb+L23D5Z5zIYNeTv/wkTbrNI25TOgiZpadU5xLq/Ji40wxPv2h0Z
 m4qIYf7jHQ0E+JbN6ikSIN1YjeQWpc7vAb70kw96s66AkQyQ88U4mNpdRYB5X6+M3UKz
 SmNJazXhK8DKlxPHkPIqby7VwkW64cpraDuHsam9VWNG8aSodCbgYXyQE0n9MkLklrwI
 CTh31hqLF6ZeQjzZHQYNviGZ4MWJlZeu1P7QOIeknUEbzamA5fOA3PsatUcIziE14yqa
 aqw+2P4iZ4YmCKV7if7MlAtsLxDsRcP2LqM6sn+xuBWh3gp5xmvA0mX4u3GaDaWKf1FI
 Uxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707469574; x=1708074374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cbHg54FPHaJAybTU864EBj6Jitha7wqkJSQ/7bQlzd8=;
 b=MLdpbIKfe5H31a2OnzExJyt63sU0Y/rwWO2+26Nex8/Eb3OIMHjGgs0kjdbhPOFoGg
 RLXaeiaf1f/UHHpzp+13VZYj/JgEqN3RY5uLX36lQKSNUXX/GD6nlxc1wFgx2V1CqfBS
 Gpp/Uo60K4rLFtQvQaY5IptfrOds0zjANS+TNC3Y8i3zIqlkfTKWvNmDlOSFFOVf7B8o
 qrivJT7fEJRiHUFYerKOew/XArWjnR8ddpPHxr6AmLCb+LehAnRGPYMaLmIwI4l+s8mQ
 hwcKZK9AD/XyNlGyk6w0absSRMJqNRhz3okpW+Wa9JW/BTNGKD0BF9YIVsS2b2l7JvSY
 OZjg==
X-Gm-Message-State: AOJu0YxH+RCCPukRKE0XMsQZZUIZ2zXe1loBM4JwO9qHLNWQP14CifQ4
 JK0VZeOm6kNTbQozpDPMrq95TVPV3WPuodB795JgD+Mr93RZ4fDhHRy0sMWJACMNwHKzuhF42fP
 Zxcw=
X-Google-Smtp-Source: AGHT+IEmDReOz6uzNd/D5T9A8WbyTeQf91g7NIr3GrjPAwa8M/BElQX/0/K/hFq0yA/yTO2ezFKP6w==
X-Received: by 2002:a05:6000:1a53:b0:33b:5815:d51d with SMTP id
 t19-20020a0560001a5300b0033b5815d51dmr401595wry.18.1707469573810; 
 Fri, 09 Feb 2024 01:06:13 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWku16lK5TdvqbK5E8TSrNxxNti3z+5EMDbdlezJWGUk8YLHx6nV1B6W7gSItbUm63/Vak4kY6sEJ6SaMvE77baMkwaehd2kuoGue61ULXqNaKN1sv5J5ttQtpDEyOZ/h75wb97LmnTPEI3O6frbkMwx2//9TgnmjasQCKBOq714/FSCGEM8oSOR5FKvcJWvUbMnS0pEySDa+yKLFURdWx3hJKGI7Fw7/mQn7b5ADm7XCI3//pH2PEpD8dpfBIaY45yEnszxMOAQgMs+2tIOlIM2Jc4d0ifjzfX4XDJnHexXWdCjyJCi8AeU+PmOPiU52kJBI8MzYrb1vdFbgBfiYJVYOcTI7s=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a5d4e89000000b0033b4ef142edsm1256117wru.110.2024.02.09.01.06.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 01:06:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [RFC PATCH 10/11] target/mips: Remove the unused DisasContext::saar
 field
Date: Fri,  9 Feb 2024 10:05:11 +0100
Message-ID: <20240209090513.9401-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209090513.9401-1-philmd@linaro.org>
References: <20240209090513.9401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DisasContext::saar is not used, remove it.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 93a78b8121..2b6646b339 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -49,7 +49,6 @@ typedef struct DisasContext {
     bool mrp;
     bool nan2008;
     bool abs2008;
-    bool saar;
     bool mi;
     int gi;
 } DisasContext;
-- 
2.41.0


