Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3131AC5474E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 04:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjA2p-0005qD-Nx; Wed, 28 Aug 2024 00:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sjA2l-0005dU-Na
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 00:12:28 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sjA2j-0000lz-AV
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 00:12:26 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5bed0a2ae0fso7798190a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 21:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724818343; x=1725423143; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HKQ+Tr9nd7UKxDYpE7u+hcEQP2VtRBhfmqRFJl+mGfQ=;
 b=cXHt+fvqkSgvrFfhFXannXESVhwh+HkBiiykV+NWl6JGfV3sY/00YiajS5EBJQyPmZ
 MT+Cc/HaQTi0jt+hllMbinAqaXl51zfNteRelLCQi4Ip3hT7bys+Yxf0fNjhbiQiTDvz
 cMTQUFvcbLcv9t6sNx4UxsdmsUXDEzbmSmq4axXIlNRmvnu5tZq/R9Rt9tX78g07Q+DN
 PGOs/lCvCsBuyyzrBJaQMppzgRiRxDWmUftyhIuj6rk9fhqeTOtjKb/p5h18T0/rFRO5
 RnFjfoetUZfbCM8A9NbVB5z+ig4Bwxdp/D/brH/LCvhSlucSZj1TqXYs9aXhiQuw3p4h
 Jg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724818343; x=1725423143;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HKQ+Tr9nd7UKxDYpE7u+hcEQP2VtRBhfmqRFJl+mGfQ=;
 b=L3ghVDbm+qFc24R4ccBTWBN6nduwk4H6shGoz3ROiuMOKrqJ9g2LlNMLzwIXGcGAlV
 UDhQn456y6U9nyyAkHbTGEWkJX+zWpVtT4HOsq42R117DQqOU84C7Pz8pARrWyZKheWF
 KgUo9nDkLOGJpQnw8rLzap3iMwCwc8UUwjypRa592h9jb6Rqg6IPTIO1J4CMdRfE8Waa
 S6Gnindcf/7kyaDyzDCrTW8/e9Pp4Jw3b1lk3SAaXN8yOiI7elhiUGXWbAuwuHCqx+iU
 GsufJXUOvOuwkISOSdYS9HGeTJ2u3Hw9TlQZIpa1rdZ2wEXIQhyEay0Z/pfaBVyio5in
 y/bw==
X-Gm-Message-State: AOJu0Yy4iCbM2leDpvLEyFI8RbaGb9bIZ9iiub4FvaW5PDNYiGIRhH1S
 eTUNGUNVHYaZgNgBSPqcYdhwdE4Qy7C7Gv17Ids4qh1zWVUk/Zq1v/1lIFly3GY=
X-Google-Smtp-Source: AGHT+IEUzNsQxp3ZqdRsr7sMoP9R2SQEJ3xyJ6H0QOgKKa+CwR11MoaIuufOYhscZQLBVH6kSrl1Eg==
X-Received: by 2002:a05:6402:27cf:b0:5a3:8c9:3c1d with SMTP id
 4fb4d7f45d1cf-5c089165f5bmr10395941a12.14.1724818343161; 
 Tue, 27 Aug 2024 21:12:23 -0700 (PDT)
Received: from [127.0.1.1] (adsl-98.109.242.227.tellas.gr. [109.242.227.98])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c0bb1c29b9sm1712814a12.18.2024.08.27.21.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 21:12:22 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 28 Aug 2024 07:11:46 +0300
Subject: [PATCH RESEND v9 5/9] .gitattributes: add Rust diff and merge
 attributes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240828-rust-pl011-v9-5-35579191f17c@linaro.org>
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
In-Reply-To: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.15-dev-c2c95
X-Developer-Signature: v=1; a=openpgp-sha256; l=797;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=cb5hfvQlqbMpu1WXDHeHVpn8WY1kxaNKXHZwF2lZXrU=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm16cU9MeTVHdkRvQmhGWDUrRlVIZFhMZEE1c0tOCnpOUW8ydTlrc1BJVjVXOVM0
 Q0NKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnM2aml3QUt
 DUkIzS2Nkd2YzNEowTzZ6RUFDVW8rZWpMZ0JXSzFyL2ViL1FuUmRMdzJ5TGN5bEd3aCsyNDRJdQ
 owa205ckp6WG1SZFBRc21FWVpTNUg2N0h2YmNZZW9vL0ZMdzRud1BMZWNyZ3FKbnp6MGdqc1BLS
 EVFS3dtWHhRClR3T2xZdjBXNHEveVlWeTMvWlNpODIwcTdsZXFBSlFVRHRobFlNL0p6TGQweXVT
 OEZ2QmNZMEpFWlV0N0JLNk4KTlhtMHVhVHNXSTBaK2d6M0NzNHN5bmNwYUR5Z3JmZy95d3N2STJ
 WMW41OTZvSWlwbVhoYVRaV0JqU2pSd1ZaeApsMk5KWitHaUo4YWFQRzFJR0dwY1YyNm5SMzEwUi
 tXTFhlSnpqaXNRWWVITGw3QTdRdjJqOURiUW1hZ1hOYzhtClRoZjlGeHBqOVJ0bjJSOHBPT1BlK
 2c5enB5V2pSYWVTMnVHK3gzeHNUU1ZRUFBLMU9mWlNBRzhibEZSY1kxWVoKNlBKeGx3VWp1ek9Y
 MjdJSGtITW1RMGVHY3hUTTFyUTU3bFROLzVBc1k3YUh4WnJ6dGxoSUY1OEswM1JkVVlGbApjSEd
 xNzhabWppR1c4OVMxWVhCWGRCcW1TdHQxcVFiRlZUQU51bU90ekhibGpoNzQzRDhYTzZjcG1LRF
 MxTjRSCi9zWlhRMmh1RGh1SFVDeFhmM2lJd29qUTB6UVl3Qm1SelB0aVVvQkdqN0Z6ZEtQekh5e
 lJCQXZPVVhCYklrOXgKOGJGZ3FvVXRIOE5mN0g0QlU0TzRVVkFjQnFuSERXbXBGYS9FTEQ2Qlg3
 UXZyL0ZQUHVDK1ZURnJ6ZkM3bUZhawp2U0F3Q0R2ZEVKZUxCZGk3Rm8rdmgvMzhqOUMrblEwbU1
 RMWwxUHBRMnZmN3YvcE5GWTNwaWlNb3BiOHJMYUo5CnpUY1Zndz09Cj1SSHRECi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52c.google.com
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

Set rust source code to diff=rust (built-in with new git versions)
and merge=binary for Cargo.lock files (they should not be merged but
auto-generated by cargo)

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 .gitattributes | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitattributes b/.gitattributes
index a217cb7bfe96ff6c8548f510c62c6e16b2d5faa9..6dc6383d3d1199eca5479353cedb6d83d98d95ce 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -2,3 +2,6 @@
 *.h.inc         diff=c
 *.m             diff=objc
 *.py            diff=python
+*.rs            diff=rust
+*.rs.inc        diff=rust
+Cargo.lock      diff=toml merge=binary

-- 
2.45.2


