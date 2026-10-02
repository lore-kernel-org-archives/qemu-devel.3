Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC025CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCdrl-0004HY-F3; Fri, 02 Oct 2026 10:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xCdr7-00046Z-18
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:03:39 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xCdr4-000869-8R
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:03:20 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 d9443c01a7336-2e4ba830297so1617995ad.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 07:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790949793; x=1791554593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rdntiJw+i8aSECp89xSpKJRa35ej9a/hc4nosI/BmRw=;
 b=eoMXfUqFgtQFS8bTu54GRZgksVZpc2Nw5nrclq+zQiNMPEd3cqSncHrrUszztPKdAe
 NAz6m4FtmDHIXGDTREFssXGT1Ldhry3sPIwmr30KgUhRs5DNM+uhrr3ZlI0L6cnGbX6K
 GHHA2573b4JELZvOy2F896M9PACFO/sLvphkZgHT291ORuaD2v2BSN8g4xWJKHV+OuED
 TeLTlM4LHRYMsakFWOkyM4E0CV8v+V94rl62epOtFMSSYOnLoypZZ2MM7Q5cPst5Nb2N
 +mYnFSXfA6ECcWlv3LzSigLmNSWywD9cPgPTfkDVdOaFqdMn7Ww3NV2l0iWUoB2mB2fW
 AeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949793; x=1791554593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rdntiJw+i8aSECp89xSpKJRa35ej9a/hc4nosI/BmRw=;
 b=g0eTjoPU7IpU/MI6oQdkXsoJfmOdRMDKdmrm5O8i0OAxFddMI55C7R8O6Ej6O54HH9
 Cx9mnBTzt3UEC/T3WvFQqV2WnJ2fLs3t05g1jfZT4t3PSHmtvh3X7fS5IV1c1AINPZyd
 l7OFcmcYlCxXlhQ1/S82JAkgoPm3ZxJMC7aylWTQcSSwJ49H7d0cvWPEcGHa1DjU5sQr
 MMYDu2ZJfjMogN+dYaU8YxIZpFsJb7RQCDSxcXjxRiPSfX9k8sxGMHFK0if5RNcvR0vz
 Y0CSlkoW1EPNjp5OzvHzkp2K7RrLzf4w5mOAgCaHl8KtwojkouaMwjJ6ha1X1dx8rfeX
 5wZQ==
X-Gm-Message-State: AFq9FYKQhn3dL/aUvsnJ6e1x7VNMuXcNvUd/iVhrXclYAwvwJQysdxLz
 5G3F/h5VOG3d2nG1V00RTTdsNSMFMtb7Y0jc2G7hWel1wC0KsB+DVmw/2zBjyjVX
X-Gm-Gg: AYBFou33zPyBrXYbsiX9wmXi8OtjOU7XZ6dzx0Zahba4awCh4Vup9l33Q5EYAI/Nb3l
 OKKsAgp3UvgLWilObbQSmI5ck3Voe1b6N5BKrsVE8ZOxi27Y8zARkr9bydxQswmEkIpA9y+uLz4
 hIbOEA0UGboQ6t5tpwvCYhLF9VazLye6UtspWn9SqhO8tZvg4f1vGoLeydA3peGWkI/8SHdjGyj
 O0SIBz6da0ZtayWMKwIB7ZGj5Kq2Rj4DSb6A/j4X8qyU/3GMyJNda5GCLBD73ax1t6KlWESx1+w
 YbksSt+ocYbcVBn9yK4Yye+pOmOqChzDWxM7To+BR+GacNh4aGsOV6/pUzk9UgCmLa/TUjUg6Uz
 3FUH3Jnd5K9PbJ3lP6eUtLfEX88qnA9FOdi46TbcHrZLwfvnsne4YtYEvub8Fva623inuGO3SVn
 ImKTnJkQKjQOUTdTN54ZFWL4KEiMECahke9ODR4UpG4xsC41NNMUrNJzjkvgJRkqxHaAPwEjMtz
 LRTa5dePIP3sXod
X-Received: by 2002:a17:903:186:b0:2dd:ad74:ac7c with SMTP id
 d9443c01a7336-2e49b67da5dmr26511775ad.23.1790949792627; 
 Fri, 02 Oct 2026 07:03:12 -0700 (PDT)
Received: from dt-VM.localdomain ([101.207.27.235])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f723a77sm7996165ad.71.2026.10.02.07.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:03:12 -0700 (PDT)
From: Tao Ding <dingtaodtdt@gmail.com>
X-Google-Original-From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, Alistair.Francis@wdc.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH v2 4/5] qtest: fix k230_decomp_gzip test integer handling
 issues
Date: Fri,  2 Oct 2026 22:02:44 +0800
Message-ID: <20261002140245.30214-5-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002140245.30214-1-dingtao0430@163.com>
References: <20261002140245.30214-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=dingtaodtdt@gmail.com; helo=mail-pj2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Cast slot to hwaddr before multiplication to prevent 32-bit overflow when 
calculating the SRAM input address. 

Resolves: Coverity CID 1685516

Reported-by: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 tests/qtest/k230-decomp-gzip-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/k230-decomp-gzip-test.c b/tests/qtest/k230-decomp-gzip-test.c
index e80113fd28..249c8ae82c 100644
--- a/tests/qtest/k230-decomp-gzip-test.c
+++ b/tests/qtest/k230-decomp-gzip-test.c
@@ -46,7 +46,7 @@ static inline hwaddr k230_sram_addr(hwaddr off)
 static inline hwaddr k230_sram_input_addr(unsigned int slot)
 {
     return k230_sram_addr(K230_DECOMP_GZIP_SRAM_IN_BASE +
-                          slot * K230_DECOMP_GZIP_BLOCK_SIZE);
+                          (hwaddr) slot * K230_DECOMP_GZIP_BLOCK_SIZE);
 }
 
 /*
-- 
2.43.0


