Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FCACE8E7A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 14:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3yRZ-0007Cu-Ep; Thu, 24 Oct 2024 10:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yRO-00079u-Ca
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:04:00 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yRL-0003xf-TO
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:03:53 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9acafdb745so196016766b.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 07:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729778630; x=1730383430; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8Qgg42N8SuToqImklsCIv0xNcAbCllJIjfd+s7ENKDE=;
 b=YvwCchidzJFAYBLkeCggH3glPoFBSqVKI6wNXScIUyeEPtfBJofvenTSA9YFJd/zC3
 M4iev+BUW95yK35WAQY7omYfYcfp7DfsisNi5hbIaTV4lLcBqsfoALfu8hwOdtXkld87
 yIYz7Qqlvf6dB03QULBMjVhKo9/jGP9yoCSvanvT1TDlXURjHoO2Gb8Liu3ADTG28d4o
 3tmvOlipagZEEFEOxCoR47+w9TEkTAhR2gsiJWX6u8H1z9Mn2YXAx9G8B4NOqWDPGlAi
 1LiZgeUNKWc7h7Um/KsDm+5xPle6FiExulsXA8YM3VykoNdvulySDfYH7roZn7GHrGb9
 J7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729778630; x=1730383430;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Qgg42N8SuToqImklsCIv0xNcAbCllJIjfd+s7ENKDE=;
 b=RxW3hg7ECeQTh1hqZkW+Odz+HpXh4T2SJOJucDmEUqgyOkON68FCx7tbNmNGNz4IZD
 IKZPVvT1QA81sEU9eNSaPK0k5Pvs/C2QLGs/t/+UX7NbmvMRHca1p5CUYHljuam/QX7t
 taQmNOBusK35Faq9ZTjZ/M0xZR511pJjVghgwtXA2Yel1v7wwNN+Tf4FIGzmT78pgUYu
 de9eV8dBix0pfL2kTyrMkGHdxV6HXMwG/fZecX35Zy1/gus5n869Y1er8RCNGYFfQesI
 noerPOCWsh/3w9qt/V/Nnnyszs0z/hX3xDqkTGLZBPSu/9Lr6uGy9X0L5Mfs48i5EuqT
 L+FA==
X-Gm-Message-State: AOJu0Yyw414YxajHwX7No7Z9gzPUxxCUS7VAM6AMSw6IdlwCxJaR1UxU
 L4jrBhkCi/GAi9evGwTD0usQN3ZG0oxNjBVss0olWOFg4lNgCRHEzUptU38UjwE=
X-Google-Smtp-Source: AGHT+IFXmSbnHJhHsJg856w4Wo5guxUQvrw+8QKSwCcJ6BivTfnSyFN3SBBQpSQeunB3GnJnVqSuLg==
X-Received: by 2002:a17:906:db0d:b0:a99:fcbe:c96b with SMTP id
 a640c23a62f3a-a9ad1a5eee0mr225800166b.25.1729778629072; 
 Thu, 24 Oct 2024 07:03:49 -0700 (PDT)
Received: from [127.0.1.1] (adsl-113.37.6.2.tellas.gr. [37.6.2.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6878sm621407566b.86.2024.10.24.07.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 07:03:48 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Oct 2024 17:03:07 +0300
Subject: [PATCH 09/11] rust/pl011: Use correct masks for IBRD and FBRD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-rust-round-2-v1-9-051e7a25b978@linaro.org>
References: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
In-Reply-To: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>, 
 Junjie Mao <junjie.mao@intel.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: b4 0.15-dev-12fc5
X-Developer-Signature: v=1; a=openpgp-sha256; l=926;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=NKJsSY6EnujOR9+vYFNGnvQMyXTGi/+JMzK/b442IcI=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5HbE9qdjQrZ3JWeElma0w3ODB4SzlUSWpFd0s4CllWcFh1UzllLzNLenpETysw
 K1dKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnhwVG93QUt
 DUkIzS2Nkd2YzNEowRWdGRC85TUZuN0svSnNwMEVVUUxZTml2QTZKVVJabnNqbWI5ZSt2dE82VA
 pOU3plNUNISmY3SklzamM4d0ZaK1VqcUpVWEZSd3k3bkZCYUdvYVQ2MzI1Y3gyUUhuMHh0VUl0a
 m5LeHNKUDBLCkdoeWpPT0Q5bnRoTUVHRGE1dFN6UFgwbXNEbCtBN0JOSGxCcThSRXVNWGhlMDJt
 c0lKYU5DZFBSWTJJZzV0cDUKUnZvcUdqSVFEKzdxdFJSVVJGK1lrb2YvVHpoVUdJYzJFWFQ3QVp
 PbnJwNzZ0TjQvWlAzTDM3dy9nMjdrbjNUQQpOVzlndHA1NXR0eDMrN3NENHp6SnJLTVF4MWdmMX
 FlOWZmcEhoZkxQYU1qWVp6SE1iM2FnZTUvQ0pBMnhiZFFVCjVtOXd2cE5DT3hMQVZhekZHYkx5b
 nVFNkZiMWtiZWNTMWMrRjdQYTRFR2cyN1paMTNodFNyazNJTXB6QkdId3cKeW5WRzNrTFpRNVdQ
 RGtvVjlTbFdOY0lKQTJVY1BhTXJESlRic05NV25YVGlQQWtEYnMyR0lXUnhCSm84QTR6NQpVUVF
 CQzRieHAxNXRDOWkreHc4T2VEWkRDR0h0VzkwL0E1TWNYTlNuTXRWRkgyaStLVGN4dktvQUZrSn
 FiMGU1Cmh4aGN5OGwyMStYcTZwcWlZbU5kMzA5eE9RcFlKWk1DMzM4MzV4K1QySnpVelZpQ1M3b
 lVFNEFoY3N5alRhYUwKQi8veTR5eC9tK0pmS0hzYTAyb0Q5SzBENjd2a3VpYVdjR2g4N24zbnZO
 aUsrQWhORUdPdjg2M29NV0VpeUMweApnYjdGYmxVMjV1djdyWGJuSW95c0RLM0k2NUdiTWhwNUh
 yWGp4TGNOOXFlbURZWjZOQlg0M1IxMm9wbGZ6NmwxCjI5eUxSUT09Cj0wVHd2Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
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

Port fix from commit cd247eae16ab1b9ce97fd34c000c1b883feeda45
"hw/char/pl011: Use correct masks for IBRD and FBRD"

Related issue: <https://gitlab.com/qemu-project/qemu/-/issues/2610>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 rust/hw/char/pl011/src/device.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index cf1964fecdfd6d9dae3378890aa8b515a1ddc036..6d1353dafc14bfe73703b5cff7e1ff7659de220e 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -21,10 +21,10 @@
 };
 
 /// Integer Baud Rate Divider, `UARTIBRD`
-const IBRD_MASK: u32 = 0x3f;
+const IBRD_MASK: u32 = 0xffff;
 
 /// Fractional Baud Rate Divider, `UARTFBRD`
-const FBRD_MASK: u32 = 0xffff;
+const FBRD_MASK: u32 = 0x3f;
 
 const DATA_BREAK: u32 = 1 << 10;
 

-- 
2.45.2


