Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5AFC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXddc-0001T8-Fh; Fri, 04 Jul 2025 06:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXddS-0001RT-Oq
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:27:15 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXddM-0005NO-FX
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:27:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45363645a8eso5188805e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624826; x=1752229626; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WmaBwAkuZQHP+oK9TN4Lu0vo2r1k78Te+JLr8F1aZU8=;
 b=FuM8uIVgv8yeN6fOCZ+YgOrsKME9GfubijYVBSetDkIZmhigH+jtdfnXMV95QsX0z+
 bbX/TaBt6kpLBl3Hh6W0oRqG4KKtqFSoTEo+WbHrMFjfhvfH1IBVHToawYlEv37eWF3z
 +aO/V5BhGWF+Dk6Fmpmw52MN6FtmExiqtbQ6A25KBuRMZCWoj2NL4+e3BfenjJYDIO2i
 Js3iOElh7LbIACkbbgiDoYg0YXlJRi473g1Th9vkDWrQ1+dV/k8qPZ7pUhPpoIrf55fy
 rSs2C1zCoSb9mOnCzaSVHAjlmKku3WgeYCY1o9j59FL9aiIA2+KPxRfT/bPjkeuJQa0W
 MIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624826; x=1752229626;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WmaBwAkuZQHP+oK9TN4Lu0vo2r1k78Te+JLr8F1aZU8=;
 b=FxFeNuFtPTChELb2ty4CmT6GfTPOoEDkofYT3Nxy+TmkiQtp2Wouk59HgYblJur8L8
 +sd1wTwBjBjSVNnZFsMqOMKxcjQoY6kQJ9ul0ff/Z6Q8Agl2ONC0WSUu/rfrlTFjXG77
 0oBOWBPlyVZPbSSIryIrBZjOODW5v3Z5710wOlShDxIHRzEKeNJU/ETylwgV8c7vBj0u
 aBopQJ2+V5PWVD5UlM7RLkWmXE9e7docI96Kc0dcwNliNzTtq1YvM2lOzT5Sx65rRTdy
 9lsYy1ovgctxxuj4RS9UkZztyOU69RyZhU56MUrOG3fDGgAq86XR4olKNa74tDX4aGbI
 I+bw==
X-Gm-Message-State: AOJu0YynBAnIr80F7R5c74Nk++Hlw/Is8h9UR6GJMLxTvnGdXI90lwVH
 V0zWVTf+FDBdrtZDHXSgrhp8zcf0DOLJHHac6Xiq1mM057QdPY+PQA8fdwcb0OipVfCKZtLkDNc
 g12w/KvI=
X-Gm-Gg: ASbGnctzdK8JOkwsLpBCoOvh4rkjuXSU91m/ETF27s2b5BO5b4Es87lB8TPzTj65d/Q
 GYTdLW/Kild7MuZQnl8U6m0/sFH/g5aloELALqYCauwnLcl99nHd701GXEppnSGomP9p6qi56yq
 RGYhZa1uStqJFJmAI+qOXJ+mXC9Lrdfzj/VrRLNAtItQ7jOsHBuq+HRrDXQhhETrYrtNmu7ji7G
 GiP2KehJcosW3hQIQoPC+lZvkYz+9UIh5BCbD0biOUcukeUJtJ9dfGFMIOu1PiScM3Ue1PO21uB
 JluloSEBCGhRz85d7+N8KO//vbVjxIKqe/Wc+IlXGWUiabaq8/TNEM3AyQK4sBCjhTNZ4CmK/PR
 YD5X4HA0F40NjBQESNy0vwOW6as5CvqE=
X-Google-Smtp-Source: AGHT+IGbQHsfbQBFrEPHwu91StZkfBVfmWVDl4xlMPVz+HvbLxIXSkpCT8/QWL+WrZbT1Ec7t4cTMw==
X-Received: by 2002:a05:600c:4e8f:b0:450:b9c0:c7d2 with SMTP id
 5b1f17b1804b1-454b31164d6mr17694835e9.11.1751624825758; 
 Fri, 04 Jul 2025 03:27:05 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-212-125.home.otenet.gr. [2.86.212.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bead7csm51037475e9.39.2025.07.04.03.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 03:27:05 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 04 Jul 2025 13:26:57 +0300
Subject: [PATCH 1/2] rust/qemu-api-macros: normalize TryInto output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rust_add_derive_macro_unit_tests-v1-1-ebd47fa7f78f@linaro.org>
References: <20250704-rust_add_derive_macro_unit_tests-v1-0-ebd47fa7f78f@linaro.org>
In-Reply-To: <20250704-rust_add_derive_macro_unit_tests-v1-0-ebd47fa7f78f@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=xz4NgQWywi0WoWatkOhYzMW2AMSbS06NUeZImuSER0o=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9aNngzRDVHYkZZWExiVys4cmpNcGs0WExiUkxCCk80V2o5ajdPMUEzdTBkeXNJ
 TStKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUdlc2R3QUt
 DUkIzS2Nkd2YzNEowSlp5RC8wYUN0NG9peXBRcndyMUtyZVVNS1JEdUhIWnNQcEZXTHpRV1l4RA
 pGdFExaytSMCtzZWhKbGdFNmhQMHdCcXFaWnY4Q1BvVTF0NURwOS9HZXVVeVArTExlTlhMV0tMQ
 jg2M2Z4Z1BtClUreHoyQlFvQnVCTDZRcDVaSXlJUWdheHBXY1d6aVprL1NQU1ZBRHo2NFA2UERE
 Y041RTVobDBqMzJkREs1aEsKbzlyeVdqR3Vocm9NeG5JcU5kYTM1V1pQc0JSQ3lhRkUxTE5FbHp
 TRGI4V0NuTlhHTnFDaHoxcTBPdVpja3ZKLwo5UmZSZ1RxbHhqNk4xQ1RNeEozQ1kyOUxaYWZ2bV
 Q1RWh5elNZd0VDeXhYSjVNa2lidjRyTmJJOXI4NGFXMGVpCm9KelY4c0d0Tlk3Z200NXdsVXptb
 nhQMzF2aWlsN0c4RVhYUFQydnpiZ2VPWnRUTmtyUzVxZ2tzZG5MbTFNZ3MKZGtnVGVkSEdoWldZ
 NlBVRG15Vm1OWkRybFkwd3Q1NVJ2aE8vS2tTay9wMUh0N2VraTR1Rzc1dGVxUTFkN2pKawpNMSt
 BSDUyVTA1L1NFbFB0Y0xSekRrcWdwTW5rL3IxUjdrY2lKZ3NURHBvVWNMWVFzTlpBclFLSXpmc0
 o0QjkvCk9vMThTR2owbnRUZ1lsend0SEhIMGpSTXJEdGNVUWFUMlE5WC84MW1KczV5N2l1T3R3b
 y8zb3huMkYzWS84c3UKSVQ2WllvMEpRNGpLN1A2N0NyZDFWZE5CdzRRKzd3aHFYYzd0NGcrYXVS
 OEtMbU9QckdKbVZGWklOTFg0OU1ZdgpEK3crUHBSOWE1QldLUVdzSi90NjNTK0EvS2ZJZmFhMnF
 Xb290MjR3enBGM3lBcW1qV0NJMWVhYnRIN2V3L2ZyClpyM0twZz09Cj03c1dQCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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

Remove extraneous `;` and add missing trailing comma to TryInto derive
macro to match rustfmt style. We will add a test in the followup commit
and we would like the inlined output in the test body to be properly
formatted as well.

No functional changes intended.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 rust/qemu-api-macros/src/lib.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index c18bb4e036f4e7737f9b95ac300b7d1e8742ef1f..4b30bea9eafc7924bf593113c3f42c5b1010c4b9 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -201,7 +201,7 @@ fn derive_tryinto_body(
     let discriminants: Vec<&Ident> = variants.iter().map(|f| &f.ident).collect();
 
     Ok(quote! {
-        #(const #discriminants: #repr = #name::#discriminants as #repr;)*;
+        #(const #discriminants: #repr = #name::#discriminants as #repr;)*
         match value {
             #(#discriminants => core::result::Result::Ok(#name::#discriminants),)*
             _ => core::result::Result::Err(value),
@@ -229,7 +229,7 @@ pub const fn from_bits(value: #repr) -> Self {
                     #body
                 }) {
                     Ok(x) => x,
-                    Err(_) => panic!(#errmsg)
+                    Err(_) => panic!(#errmsg),
                 }
             }
         }

-- 
2.47.2


