Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63642CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4lp-0007ey-Gs; Mon, 01 Sep 2025 09:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1ut4ke-0006sZ-Df
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:39:20 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1ut4kO-0002xN-UB
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:39:15 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-24af8cd99ddso2765265ad.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1756733936; x=1757338736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gr2/2lP39GAEsoDx7lhOVCWmhPO18jyHTS+4tMjNbdI=;
 b=T9frMbwFOUAkofdodIpEsbPma1Mxh5l9EICXCf8UutBFVYo1s7W6SAsFgs9LKHPsq4
 FND9lx/eLABPtAwJPQ8ItQPmEiVtExrsFe6km1A4Qki0+BiV86evb53c/j4S2Q9cW6bD
 /UY+aFl2gLz8P/uVp2VFJUkW4Z9G+u53YswTlIKKHFthUkjuhVhGWQELoRf2+WAMP7wM
 jQhe8v/shwfzwqQ0urdFWt9jAr5YMWbaX1FW9bGdBwLKrrwcxrqEs7sfjAYRlmrNWLyM
 U2iMExWC4uQacYPhAK23EZHEa+gZl85g2V5DbpWMB3jV8ARZG2igJggcf7Me/fp+6jyG
 +Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756733936; x=1757338736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gr2/2lP39GAEsoDx7lhOVCWmhPO18jyHTS+4tMjNbdI=;
 b=eMgKFd81HRmxPOm/BhYFv0Pht9HGXzzmi8VFP5nVgj+o+RyT0cjELDTto5INxxpHeZ
 rOC0o31UgBPvYmIVrPUP59+62KroRtMy1GufSXseycbc+AdEoajPL2NylCMIK/wlqem8
 HX3NAAJ6HvYqTYC3Fz6ibe3f4inX1zunwUS//8+shTIbh/Ww3CEvzQkOYShC4RGyAJfN
 JDzEDcvRFI8blGs6jK5u5rOdJRCWAQLCNCN7hemftkCp3iQySyqtLBs0VEe2r1us0EMB
 SBP4kwWumZtP9lMHflzA9pfu3W4DgxSVTEudSHvdtATCdSXEuEiren/tw0LnTbCr0M1E
 JCvg==
X-Gm-Message-State: AOJu0YylVL7a/uesESQvU3NI4ZesyQRf5lvAWMnhXGKmHn2XYWeTqDz9
 Ss5TOOX7++lBOHzsVRFkfJt3A5iP0v3uCOcmbwXh7fWfOEmAGI23YksMWWKhGrTo8e0BjCEzQPj
 Bnl/SrwqVHJvoXqE/qnMc6oBw/hHpIyC1dQ2cD35wanJ4si4pOfMuOz7ONxzzpj4lgolwvPNpHY
 M9dfbCik7vnr6Pxh40q9LZEfhyLMtVh8FRHQYelOYPXw==
X-Gm-Gg: ASbGncsiLyIFc2zFeQj1suQ5zCIMRlFJzRHqfRF2iJVwvi2CjLRgwHlETs1a9HSseI3
 3QtHlknOxelL+/6YaIddae6hC+PcL11mDNdhZ4VWvfwOCfZOthiTul69EyPAMoSrzw9MXEqzr3x
 IRwb8lqVsmw3t8gm6mbK2imhyQsOjWGDAhj1GcO1C0w/aHGMH1j4ZMI9dniZ4ZBdRJcrXBsfYy/
 WLPgUytAYpnaOLue7/FQ4mtlb6lIdr46eP1JG5tLJKtBJVsn1CG0rA/CDbMkBGDxHgIKKa9HsvW
 8lRBNI3lW6SOwWDcEY3Dlo5QpPDzvJThjSSezf+4kJOhj8hVywKG6IAL36w+3LXovIVW5M7t0yz
 sAU5PWa96LWSMe52+2tiQxtsjYELmd2DksZIqt+i/kyJSc2nm3/MMRFN11LAxMIVvmyaGCJHIg8
 p4ag==
X-Google-Smtp-Source: AGHT+IFYnKHFeHe3jm/3xpu55jKc0Sfq9m4J3pEgTIyk6ABwQX/Pjp86xCCnP6lPIipmZ99wb6sPDA==
X-Received: by 2002:a17:902:c406:b0:244:55b5:7cfc with SMTP id
 d9443c01a7336-24944b19430mr97784755ad.37.1756733936207; 
 Mon, 01 Sep 2025 06:38:56 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da3bbfsm103106375ad.70.2025.09.01.06.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 06:38:55 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH 3/3] target/riscv: Expose Zvqdotq extension as a cpu
 property
Date: Mon,  1 Sep 2025 21:38:15 +0800
Message-ID: <20250901133815.1693077-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901133815.1693077-1-max.chou@sifive.com>
References: <20250901133815.1693077-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62e.google.com
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

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 95edd02e683..ed486113ba1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1373,6 +1373,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
+    MULTI_EXT_CFG_BOOL("x-zvqdotq", ext_zvqdotq, false),
 
     { },
 };
-- 
2.43.0


