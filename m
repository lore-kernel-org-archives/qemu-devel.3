Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2811C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5DA-0007T1-T3; Mon, 04 Mar 2024 05:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rh5D9-0007SB-Pz
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:06:19 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rh5D7-0006HQ-O5
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:06:19 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dcb3e6ff3fso17404985ad.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 02:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709546774; x=1710151574;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hf8rFfw1McJn3z3VsNsbHmy2YFs5g1/mEqXgQ2kHlrs=;
 b=rTa0aC+rFXLpcCPnKV3QAyudnkGL4cUd0Bm5OkTuLnp1Gx/LdtWzzRN5B+Jgf6QLYy
 CI42XHIxfl/V2EiaZ721T4xFhHoZggcXeOpIe9tMBORl4Ge89h987HRACUYh7LsK8vTS
 dumIW3D4oNo/dXeeQVhISOTpijS2s/EEIEMZt0k/ExnGKJQ3NQZIuiyWAbYsjmc5Hul3
 8HY1LGKRx1YHgpefNBNpT2wiOIrR23Ur1GoJy7vmHVr/D0Ow7UFFvTq9qRtPHnTDuGHZ
 3Bk5NAneY+FDBNfcWuROJVUavIhrXdCqY0NJqGwJ2v2L+16afGgHR5o0nne1L6P2BI5i
 yDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709546774; x=1710151574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hf8rFfw1McJn3z3VsNsbHmy2YFs5g1/mEqXgQ2kHlrs=;
 b=m9i9Ie8SpRYbLikivBQXje/J2m2aekVy2OllKl7+VeIUkkGBzFz+Yd4Zw6+8dda1wK
 +uewm08jCFQrJYuyPa13YEc7TpItFj4GJVwB4DVk4Sj0J0GEtjl7r2B4T/gHUKs6zB+v
 NpLUwokv7PzkfAlGV/f6Ww/A+e5S1R2EJZGacqlsZqjbJ8AM2vZitSswMf1eiPW+kxcY
 7HComnnpjzHgLqJuo9uNXX/Nw4spCRmnlIgihqY2wuWL4BeYQuvOpLKQDlUUfdegutHA
 Q1InyTjh1ceoO0HByKvsjwDkDJFlIu6iEv+s4anTVtwOU9NPiLVdWt2HDby/56sYvdS1
 VgPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0rgj6sWqwokvSR0LXQsnkX+bCbKLW0BoXmly67WQm36nTTeaBcLcgu6zjQ6nTN+FZbtVrt4H6PHNnNHf5c5h+Zwy0w0Y=
X-Gm-Message-State: AOJu0YySj0kV3ic99s3fqq8bQUwuz9/m/1kRn88Y79g2RkpVHqcN1Zir
 j3i0uLoHPJZjLC65e7bTOiQjaDQNtDXdWXDXy/NpmudDngVuqzKCrSuZrMv+74wpoedNKWcMUdc
 lCas=
X-Google-Smtp-Source: AGHT+IGt3Y9sPyyIpGwiS9Eqb3a5g4P1yZLbtb5piKfpJv3IMLhQA0t/vke7ZaOQtn7d4gbzWdEM8Q==
X-Received: by 2002:a17:902:fc8f:b0:1dc:f7c2:938e with SMTP id
 mf15-20020a170902fc8f00b001dcf7c2938emr8351252plb.38.1709546774242; 
 Mon, 04 Mar 2024 02:06:14 -0800 (PST)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a170902e19200b001dc95e7e191sm8091570pla.298.2024.03.04.02.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 02:06:14 -0800 (PST)
From: Mattias Nissler <mnissler@rivosinc.com>
To: stefanha@redhat.com, jag.raman@oracle.com, peterx@redhat.com,
 qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v8 3/5] Update subprojects/libvfio-user
Date: Mon,  4 Mar 2024 02:05:52 -0800
Message-Id: <20240304100554.1143763-4-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304100554.1143763-1-mnissler@rivosinc.com>
References: <20240304100554.1143763-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=mnissler@rivosinc.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Brings in assorted bug fixes. The following are of particular interest
with respect to message-based DMA support:

* bb308a2 "Fix address calculation for message-based DMA"
  Corrects a bug in DMA address calculation.

* 1569a37 "Pass server->client command over a separate socket pair"
  Adds support for separate sockets for either command direction,
  addressing a bug where libvfio-user gets confused if both client and
  server send commands concurrently.

Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 subprojects/libvfio-user.wrap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/subprojects/libvfio-user.wrap b/subprojects/libvfio-user.wrap
index 416955ca45..cdf0a7a375 100644
--- a/subprojects/libvfio-user.wrap
+++ b/subprojects/libvfio-user.wrap
@@ -1,4 +1,4 @@
 [wrap-git]
 url = https://gitlab.com/qemu-project/libvfio-user.git
-revision = 0b28d205572c80b568a1003db2c8f37ca333e4d7
+revision = 1569a37a54ecb63bd4008708c76339ccf7d06115
 depth = 1
-- 
2.34.1


