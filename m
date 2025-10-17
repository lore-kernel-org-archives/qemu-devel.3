Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7241ACCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kEC-0005jB-A7; Fri, 17 Oct 2025 09:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kDm-0004uH-Ou
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:10:16 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kDW-0004gm-9i
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:10:13 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso1330068f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706593; x=1761311393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFKu1ozhaHpdAj12FHVUlzMeiE8N2MTuFr4PiE9GBwE=;
 b=FSxlvD60ueGTdvMx7njQyZ1LZEz/NL/+JxgKg6K70EN5sW20r7vdNBPwynqFL6TBe9
 JhnQcmU/Nz4S73STqGMSfGcWienGIS14ZatRloq/YC0wPvKw6MDUt/2rFcIy6P908TyG
 5XQ3ebbYEwUAqq8codJ8bErt3BFXdYTU5HREqnVHFMDLMjUNe/kL2B9hyPcKq7dUvPl/
 /rT1oLNsTmiHSmfloxf1Db+wXInF17eEZFj27cbk7EFdLWlMMJvxxJEL3qJCitYqzKOx
 mwK2lqvgTYcWS6ZBz4803gqc6NfQQE4V8vi2DrB1NVV5HCeeCmVvxSBtxBD6vH0y6ohZ
 DSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706593; x=1761311393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eFKu1ozhaHpdAj12FHVUlzMeiE8N2MTuFr4PiE9GBwE=;
 b=jcgoms3YAn4yBuopztUUhb6IfOT8UfBqYk5zK46+gugqgBudybRycd41TrmbODLPn2
 e/6Y5HqU1Z12km5osM6W2QKYTpn4Ex3NKpP6KzL6BwWiTMJ4/NAlD7PMqbyNkz8lpqYB
 a/UQ9QXdimfuwGmjwLqDYyPcTRd8Qs+Frukp8Df47KUXlmLPirqMk5+x8xZ4j3WTXw9N
 SPEpqfqVGV/Idf0VG06zS1JSdxDWAtj3c/UPLWVi+zZ+CD1cVTzauJHtCJDVYCNcr7Hi
 bgmGvrXbped8ruYBQPC0j/9pvzdFwPVpqwLmS1zFiIz4zN42ga/3ae3oCaNbTF7cl+5s
 b3ng==
X-Gm-Message-State: AOJu0YxobsdBcrt9pNlP1q7mImFtnbGJQEgZD5d5jH2yzkQfMt+3G4fh
 P/H5XW4YqHi4vbFwqAuUX3LqdHxzErGnXInvPl37DZXRdFlO/uaz2KGMMo+9jJFTSx0Lc+B49C/
 +DLcFx+Q=
X-Gm-Gg: ASbGnctBbs33kB2V6cySDPvjueNjqhVknIZW6DDRWoNhd/RIQYZT5RUH8lvVw5rJGcq
 2r7BBQDA1DZhE7P4Sw/Uc+4pZE8jNKi7y/e8E+EU8P7pJJrbjjvYWxJcP8MdTe4V9IKi2BrFOrp
 PH5G69AyejWdCfJKVSfF9t/v3FkH7xm+Rw5wZ3jQ6x0NOF7L3GvDgx/qUb6g5EaO/WknuiNykpY
 q6P+MU8cBh2BsfzD0CoIbtBv3PdPkJze2gxsQPjidtSTUzX6k0jtUsyKIiPUTlaoiOSt2d0ThOi
 Y5ljADEDOdx0CDjBCMwwlECeB6LLjV1/6xUaftibIyyyPusernFEvwE/LEgGnPWsvWSUobvaEh8
 GHGu62UQyVRFiwspbpnY+BViOfTAUQszPX64mqvRDq/Q9h4cibrrqnHzDWus8KOdV2I4ixP34xd
 g02EhPCwiuc5Z4/mrtNKE6rKeo963PFSlgxZeOFmhUuyuHSBkWn1L6FXMzNVeR
X-Google-Smtp-Source: AGHT+IE9D14EnEh6r5ayWynENo7rhlBVs5+9hx6WqNcyncvun2mxUnzMRjwkSa9cvdDzMC7LvF/GyA==
X-Received: by 2002:a5d:5d01:0:b0:427:7ac:528f with SMTP id
 ffacd0b85a97d-42707ac53b8mr1656002f8f.33.1760706591735; 
 Fri, 17 Oct 2025 06:09:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42700072619sm8986487f8f.46.2025.10.17.06.09.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:09:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 18/20] hw/arm/virt: Remove deprecated virt-7.1 machine
Date: Fri, 17 Oct 2025 15:08:17 +0200
Message-ID: <20251017130821.58388-19-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
References: <20251017130821.58388-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7218badc8c7..4a8a2a91b07 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3586,14 +3586,3 @@ static void virt_machine_7_2_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_7_2, hw_compat_7_2_len);
 }
 DEFINE_VIRT_MACHINE(7, 2)
-
-static void virt_machine_7_1_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_7_2_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_7_1, hw_compat_7_1_len);
-    /* Compact layout for high memory regions was introduced with 7.2 */
-    vmc->no_highmem_compact = true;
-}
-DEFINE_VIRT_MACHINE(7, 1)
-- 
2.51.0


