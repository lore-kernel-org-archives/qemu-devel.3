Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C359D1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 16:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdsZ0-0003BY-BJ; Thu, 08 Jan 2026 11:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vdsYu-0003B8-Lv
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:08:36 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vdsYs-0001po-PL
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:08:36 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6088wA5b1570684
 for <qemu-devel@nongnu.org>; Thu, 8 Jan 2026 16:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=GF1iMDgQdkbluEyyapk5jvTB1KeW4yIhMBT
 0dL+M+VE=; b=atbA5Z5PZ+6NifxDBaijwWwaEl8dts8W9Qpi6TJXNTNtjoci2p7
 oZhGFrgQKITIkZUUA8g6VgnA9GoiCV5EFOKqCGeE4qhXMXcuy390R2wcZV9OA6PX
 rpJ//l3U7B/0gkuA4r3xFNBb1nNjPcWGXEqMnr1vCFViW2G1KxRV7HPubGeBg3HT
 TxQSWdl9exM9ApMHaRd9CUgg01xciGiKkTa2TLBRe1jHWOAemfGtKO+l2SM6H4uZ
 FqcbleBRXhTVkV1D0spLkTqLp7SWGIfm/xYXkviDmpkH/2TVLsf2cOFWx8vh9Cxy
 YWOw7xxfpaaNSRjtr0ejjhrG172/5zoJFGw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj9hqsafa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 16:08:32 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-11b9786fb51so15587552c88.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 08:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767888512; x=1768493312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GF1iMDgQdkbluEyyapk5jvTB1KeW4yIhMBT0dL+M+VE=;
 b=WkVPv2vN0/lLCqxu3LABz2iYOUSn0q7hJgUOY00D2hw1pEGQWD8KZPUQLLplbUofta
 t0nMDmeI56G6orvJpsePDKdUse0/qq90/k1NI6B+kr9CfI237U7q6vesgmxQGgw21Qc0
 eRhzh+v9Ny9pNW3C028NyxBoy1QiQ3I5HpmQgvKnHaA8vG+1kX5ddEG1w/4Gjl1W5sze
 gwEWW62CNzoP2tiCw5KbxSefP0eFaQGRAjw9+3SqToh1RGW8tLiguP9eIl88flh9keLr
 7ky6Ycypu2dgXX07K2z30p1ziTwZhH8+p3RY6t/3r371QNTEprQHAm857pBo3gZ/Kkan
 LNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767888512; x=1768493312;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GF1iMDgQdkbluEyyapk5jvTB1KeW4yIhMBT0dL+M+VE=;
 b=wgSlD66t5lBA6GTfvNl7fLHIA5DOAmZh5bl7ItupHJGnIhnIsg34h+5LSKXzy68YHX
 aySBkf6W8y9AJsmaTK7TqYdS5BI4yc0EuGg0+FvmAgagWA+M7yJTncqB/76GTn8mcEiX
 gdDx8fpKO/AdYku/+ewV+rniMnJCgipbqyMqEe2Ay0Xw237qSQ4wo7seFnkCqbqCrc0A
 z2ZoZ2CIAAx+oVbWGdURZpbDhMalfWk5x72+KL+UUw7eVf3Rhj/0kQ7JaIDnwzp+xGyY
 K8tGLPC4N3E1nCnASMTpToD93DZB91Et07o4CPdXu8R2Wu0J4pKDHG0lLLYVs+ZuG8oU
 rWdg==
X-Gm-Message-State: AOJu0YwXi6DDy7ZvFSyY4JiLwNr8BoczhAWYtGoxqxM9/K/1wc1tsk7K
 rGZKNSLnlB2zyTEb4d0xM4yoA4DH/n0wfRYfAtIXrLMr7cB2MWciOgTm2/+q8IyB6nJ01WacGdm
 n0YItMMo4PPnqAD9brKm/2m3soxr4oKPWGkWA6N8uxLPs10yq7zIflVt+JJmqdzHX4Q==
X-Gm-Gg: AY/fxX5r5jRcOOnv3Sy3i5hYJFP0xGB1Hm8L6M+oqIpc8N2oBwDejh60DTxX6PY9k6j
 hbv/R1WcvDW36YR7O+HMSmmggxQtOc90oKvSjV+Gotjv8GMwo1ksioIffLejY93BOxP4G9uVLNC
 k88JAQ6jjLplLKC5psRj3ZoV671G/dr3V/qAzJ/f9zpHONxuNlFQVbAaKawZvVNnaubY7jMxpET
 P62bmeiXYTOCt/g2Jmvq4i4UJhPAUzT4VjAS+SBhlUzX/xIZYgU2C6EuJLyc7O1aQhgV6OIK/po
 mHQbGKn7Ri9Zb7h3m23FL+ZAFfKRDadWw12PQNdOhfrsDYfMLAQyalStwXfyHwvOBK8FKj7xIWe
 sCFQEeXH/WKbegAffZTg6hSYYCKHTYZhSCwbPmFO+w1M3hWPkxmuisi+MmW93U1FleXyqJYZcGQ
 RhZ8qjHWu4ZklpgxZQ
X-Received: by 2002:a05:7022:a84:b0:11b:9386:825c with SMTP id
 a92af1059eb24-121f8b68c16mr6180142c88.41.1767888511536; 
 Thu, 08 Jan 2026 08:08:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvqNPlhMuBcJS/Y016hz1jb6rnX1Pvps3TEK3S/BqtSjH9o3HiPp0a6lSM4eR83QvCG/kqXQ==
X-Received: by 2002:a05:7022:a84:b0:11b:9386:825c with SMTP id
 a92af1059eb24-121f8b68c16mr6180093c88.41.1767888510828; 
 Thu, 08 Jan 2026 08:08:30 -0800 (PST)
Received: from grind.dc1.ventanamicro.com
 (200-162-225-127.static-corp.ajato.com.br. [200.162.225.127])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-121f2434abesm14166184c88.4.2026.01.08.08.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 08:08:30 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH] roms/opensbi: Update to v1.8.1
Date: Thu,  8 Jan 2026 13:08:25 -0300
Message-ID: <20260108160825.171794-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GN8F0+NK c=1 sm=1 tr=0 ts=695fd680 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ewOVoc8TSmC0cCmMeNMfEg==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=HQSy5ryYd6bnL6R2S-4A:9
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: gHEVrm2NXvYvhSu3b6bz97JROwjSq_22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDExOCBTYWx0ZWRfX8xGSjKeY2B9G
 NvfE25ODLipQO/x6aPRVmgTtqHfORwvlus6hp2I4RBhVZvax+SPQcoLpDxv7Oq9jk7Ax3FQy619
 KJ05eaod6LtUgdMzXdBcqXVe0kz9KOUuVkTcdKC3L3Zu/xE7wnT56fPN/efAQOZecEAX1MKNWUY
 XbyHw5YV0aAEQkcVEGBO+K5h0TxK3dLZ+ItasNd8ftzwgH1DNjG5VHKMYAg/1mDXb19tYWD6RhV
 +ykg0yOS/RPw8JiAzGMhu2Ezrukl7uofQOJy0nE44b/vEFv2dnSeVt9QpuJeWaMZM1VMPNwpZu2
 U77raBoHlPAuSHtcL0ZYL7qf5mreT0//qNlNCLJJGGXtEOUaCeOv2aOHJIEeNlOsJtlw9TE6zm3
 mDIdlVAzhsnA54DRRscC/p4vRtN75ssHGs/XWAiuYHp725yrrXG6UpZpft4/1gPyFBpXkTVWfRa
 U999BqZ2II46eA9qGew==
X-Proofpoint-ORIG-GUID: gHEVrm2NXvYvhSu3b6bz97JROwjSq_22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080118
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Update OpenSBI and the pre-built opensbi32 and opensbi64 images to
version 1.8.1. We're going for the intermediate/bug fix release 1.8.1
directly due to a PMP related fix that was impacting QEMU profile CPUs.

Changelog for v1.8.1:

* Typo fix in comments of sbi_hartindex_to_hartid()
* Fix hart protection abstraction for platforms without PMP

Changelog for v1.8 includes, among other things:

* IPI device ratings
* SiFive CLINT v2 support
* SiFive PL2 cache controller driver
* SiFive Extensible Cache (EC) driver
* SiFive TMC0 based HSM driver
* SiFive SMC0 based system suspend driver
* MPXY RPMI mailbox driver for voltage service group
* MPXY RPMI mailbox driver for device power service group
* MPXY RPMI mailbox driver for performance service group

Check out the full release log at [1] for more info.

[1] https://github.com/riscv-software-src/opensbi/releases/tag/v1.8

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---

Alistair,

Please fetch the images from:


https://gitlab.com/danielhb/qemu/-/tree/opensbi_v1.8.1


Thanks!


 .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 268752 -> 270384 bytes
 .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 273048 -> 275928 bytes
 roms/opensbi                                  |   2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
index 02be3a72a8..530709633c 100644
Binary files a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin differ
diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
index cce35c65c2..fea7d35cee 100644
Binary files a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin differ
diff --git a/roms/opensbi b/roms/opensbi
index a32a910691..74434f2558 160000
--- a/roms/opensbi
+++ b/roms/opensbi
@@ -1 +1 @@
-Subproject commit a32a91069119e7a5aa31e6bc51d5e00860be3d80
+Subproject commit 74434f255873d74e56cc50aa762d1caf24c099f8
-- 
2.51.1


