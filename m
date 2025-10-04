Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D015CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wSi-0003a8-EF; Sat, 04 Oct 2025 03:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSg-0003Zt-Qo
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:46 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSf-0004uU-22
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:46 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3f0134ccc0cso1766961f8f.1
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562023; x=1760166823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/CqJTckq6yAIGwHr2Bju04MLAAhhBopFLq2oiS9pX3I=;
 b=Rk3WYZ3iLQ3nkrZYG321brt2B1Tt3NdkeEwP5n6EaVVqbiTRt/UnslsQjN6Z538fv5
 lViW+JlS19GFe2gm7kXT5fB9zcVMj0MWh+sh5PCCapC/N6oHEku8ls6LafEyixtSdOof
 OKt9qa1aSLVV2jF+jtMX6X46SZOlvvE5zk1isIRpNyIWAD8MEp2bCofUMWSJpUxx+4ST
 QN9pypsEyNrqyMtC0BUu6HAJh8G8aj52f8v0eSmFnWsmdbGuniwTeXetmRzNRxmVAudc
 8XgWGNUFCd/hnEsFh0jLn1LtdG8dMme6ch+IxTETjl9BJFNFVw/7BthK1BX2m4wFrWEj
 umxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562023; x=1760166823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/CqJTckq6yAIGwHr2Bju04MLAAhhBopFLq2oiS9pX3I=;
 b=fI+Xz0UO/aHj8FJRCxd59OClFniikToGWJPLCsac5wzZZMQzTXzo7InBB/SZ5KXMo5
 q0bavCN4C02LPtOsDPnmrR3INob5EO3mEBhIV7oPOHkbs6fPv10kB64Mw1XpWhffzxSo
 TJ4LpA3qqYuhKtG8BbrvZ4hGVkuR2vC2/UpT5lXGAqnft+OIuxI+94bxAXZQ5OiQ9kaY
 D8voRVIl++KLpC2GNgrC2C+/VLXXvJI5kDOwaBy1hBGrztRi4nmdYs0e75XmpNHppWmK
 fn9u2zCWY9MN0ko0aVTwbK26V9KmEpw1urzO6VgdJMK+WauFeAutVPmDs6sa3xLtqWel
 cZ5A==
X-Gm-Message-State: AOJu0YzN2PUwxoLTtPszm+PAre0/S9R0MeJN0TEtOZCED4ZGODxLjirE
 0EYs5T1uKAHaOl9J1/gECpWd6clQiF6l886n68aeMInQretSSt7uZwzjXVRbbOdcTR76apMzEha
 c7UL1y8WTFA==
X-Gm-Gg: ASbGncvLnmjFxju6fZuFmH7VdwlhMSVzsAadLQAXpD8DeXYeDDxGv3vAuVFXmw2t5bV
 TIjC4CEFVOg6hSz3hnBAVRrcm43/vCsS4m426TUSOWOvyJ7IVdCYnbEWT88IlIXEmG3aJ81UZFT
 eSz/bFqDytFSmiK8R8/PoBH3y5jNM5HRSt9wc8MMyD+tUsFqddVtGacIx12q+UVgOk488a4augU
 LKNk03T2NVoqrKbDhYspt0CiuBF9fPz1FWdf02bag2itg2Tuw6dAZ9cL6PijPRwZHlFnLpt6Ft/
 BSgoVF9kvPTXeEppwCxX2748uUmUDVHOk0aM83yw8JGuaLHxjffmXD5JRsR1cfTaOFKfRP9Tfh0
 EjBpWeJYGHyx/bTBiNdC78fqaU08PxS+vUOUCI/+lGwoCxuounz1RDffoTz+l9E5jHTO/pnZ7xB
 J9kOrs0mWTc8UJ+65SIugwY4YW
X-Google-Smtp-Source: AGHT+IH6IAmfrlgIUPoTFyJhJUyQNXRHpYcyRyv9NIiPXYpp7zusekAii/srbXoUJWRwd2yvUN6Dhw==
X-Received: by 2002:a05:6000:40dc:b0:3c7:df1d:3d9 with SMTP id
 ffacd0b85a97d-425671c0c7dmr3698414f8f.39.1759562022854; 
 Sat, 04 Oct 2025 00:13:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97fbsm10929348f8f.34.2025.10.04.00.13.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:13:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/41] docs/devel/loads-stores: Stop mentioning
 cpu_physical_memory_write_rom()
Date: Sat,  4 Oct 2025 09:12:33 +0200
Message-ID: <20251004071307.37521-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Update the documentation after commit 3c8133f9737 ("Rename
cpu_physical_memory_write_rom() to address_space_write_rom()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251002084203.63899-2-philmd@linaro.org>
---
 docs/devel/loads-stores.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index 9471bac8599..f9b565da57a 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -474,7 +474,7 @@ This function is intended for use by the GDB stub and similar code.
 It takes a virtual address, converts it to a physical address via
 an MMU lookup using the current settings of the specified CPU,
 and then performs the access (using ``address_space_rw`` for
-reads or ``cpu_physical_memory_write_rom`` for writes).
+reads or ``address_space_write_rom`` for writes).
 This means that if the access is a write to a ROM then this
 function will modify the contents (whereas a normal guest CPU access
 would ignore the write attempt).
-- 
2.51.0


