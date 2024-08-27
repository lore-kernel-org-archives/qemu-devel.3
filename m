Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5016C54735
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 11:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siuIo-0002to-Op; Tue, 27 Aug 2024 07:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siuIj-0002dI-I4
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:23:54 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siuIh-0000js-Qz
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:23:53 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f3edb2d908so56098221fa.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 04:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724757830; x=1725362630; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9YXcnKmZZZbUSRgrSbJVZ31pesRUIn2Cw54Q9JgSGWk=;
 b=EJRWp+l6HaaEgg7AyrhtG5ufbxjIxClJj6y/6rD5gfe+0XKT7x5ilvb0kiZYPVx2+r
 iDYhX8YjLjxLGjx6s7eBMSOzay3oZqo2cAXRuSEeulcpGq90H+ubQg/XuyBkLyhwI9tu
 yufWntfzlwbi49Z9wO6088ovBDv2x1EwpiQCZjZhS6JWdFwHveLl1NxhVLB7xpFcl3uG
 I+6Pwge/kKsFiFslavXkPntwYjhDC7+wzb36IlI2WtpPLBUExLmerDtgXWibFqJZ5VVa
 ljSRQFWB+8vPGkl1pApXLpwSUMFAbMmjpxMKNykyzbHHRInfaD0ufMRIVhP/48enEeTk
 aZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724757830; x=1725362630;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9YXcnKmZZZbUSRgrSbJVZ31pesRUIn2Cw54Q9JgSGWk=;
 b=OVv0qk7JLE+yph3jKh547cuR5lW8UEUOiTLPJjPtwooGIfgSvASc+sneyo2ARLP7U2
 glGBB/S4nMgxJ3ooi4gj+hSCcd3zAkFZYEHb/7vJzVmJAJIA4F3JuPfzdnhOG7mjNx7b
 OYSJ+4kUuVSi04rNstUuD9eBNzyDk2v2P/X/FvVw7OrJpGek+R84NVvOjj8LzBiX9sFV
 k5p0s9TexUVCLog7bL9iX/ILtP3Xm5TG5Gwf1LBcPKaKmLgqCEKfvThOnTCGXIgcuyWe
 XIXtrW0Ynu2gDjjkdLlUxt7BS9EL/FY0GYgQ3NxVU8GuZzDedWFFPQc6JV29axOxpL3u
 LEfg==
X-Gm-Message-State: AOJu0YxYDjVr95mW1vs9UJOY6CUgunoara+CwXfeDWwXlW9GOOjAvO5j
 u8lzPQ6Q6gahfvRR1s604udP5Cj5dJSoXIr/otCdYMTFHRA8BzQ2SF8kQJMOn0k=
X-Google-Smtp-Source: AGHT+IGEh5TBKm82DVZd0yzPMTCsZS/oeKsOdFkmdioj8U9ubSLNJCuSoUqJVgbHM52Lo7Iq7SFnIw==
X-Received: by 2002:a05:6512:238b:b0:533:6f3:9844 with SMTP id
 2adb3069b0e04-5343875fdb6mr9127861e87.11.1724757829676; 
 Tue, 27 Aug 2024 04:23:49 -0700 (PDT)
Received: from [127.0.1.1] (adsl-242.37.6.163.tellas.gr. [37.6.163.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e594fa62sm96280066b.198.2024.08.27.04.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 04:23:49 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 27 Aug 2024 14:23:14 +0300
Subject: [PATCH v9 5/9] .gitattributes: add Rust diff and merge attributes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240827-rust-pl011-v9-5-e90b9c28f861@linaro.org>
References: <20240827-rust-pl011-v9-0-e90b9c28f861@linaro.org>
In-Reply-To: <20240827-rust-pl011-v9-0-e90b9c28f861@linaro.org>
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
X-Mailer: b4 0.15-dev-b8758
X-Developer-Signature: v=1; a=openpgp-sha256; l=737;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=yNbUsDh4+C8FtuJmA0XrJ1SGNb062y+eEXSraBcKoO8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm16YmMwbGJPT3FvelNhSHQrMkhxWXZETGowVXZFCjlIQkRkVklTcmhmdm1jcHlp
 S2lKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnMyM05BQUt
 DUkIzS2Nkd2YzNEowS1RFRUFDWEJXSTNZckZEdFZtcWcyaWdQQ3JtUlUyWHFEY1B0TDkvbkZLVg
 pFTG5OcUFwQUtQS0hjdGtjRjhqUm50S1dBRmhsQllURFZtNWV2Zlhhc0Z0ZnJIbU5oM2tMMzNyO
 WxNY0N4TTJIClNmZGJwUHN3ZjdmUDNPeml4TDFpL1VURUNmL0JSOTNCdWpiNHZGREVpb2lHOUlm
 OVp4R2xSeElTU1VMYXFkTnYKOU0wZ1Z3cm8wZ3Faa2tOc0xGSCtRb2pqZ0hrcGpkWFIxTEx0UFc
 5aXc2bDltQ3BQL0NKVU4zSUVhdjVRWGlHNgpaRUpxTnBVQlRnWDBCVGdpTzZiWFUvOFNXNXNib2
 5VcERnNXpaVkhGa1JBV1R1Uk9pOTZManY5cXF1Z1Q3VXZvCm92Skdabk9TMlFJUjdjbCtuaGxtM
 mQ1MzA1bTE0QmJzNVg4NHd6NlBMK09hcmJwU3VCRm5FbzVYVlhTSmNpcWkKWHZGVWJtSmtFMjRy
 NCsxZVdlWjNYTXprM09CSFNiN0psMUNsN0ZGOUxDck5WSHlRRmhFbkNldmNSR1JGVlJDMQpuaFM
 vUnovVElwY0dvbnAwRUpSa0N1eGpQV2lvdEIyQjRxb2cwWkRvVUFrQVhnczlTL2dxVjdCTTRLOT
 haVUk1CkROYXl5QllsRWpwdGFOZTB2Z1ZHeDluSVBZN0JkYjNwQjlhU1pYcmxOb25nMnNqeEV6Q
 UtHa3IwMUgxYk1yc1UKaVdSQm90TXdhc1B4L0xtblJ0RDhWREN3Q3VQZ0dOQVI1WXdiWHppZ1kx
 SWZmVkFoZGVLU2E3Z3huWFZjWjBMYgo5N0NCdkJwZmU2YnlUWWx4d29NWlp4bWNCOHl1L3Q1Tlc
 4amhvQ0FNQkx5b0FJU21xUTNJRDhsOFdaSVBsOTBFCmNRZzBwdz09Cj1SQXpICi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x234.google.com
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
index a217cb7bfe..6dc6383d3d 100644
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


