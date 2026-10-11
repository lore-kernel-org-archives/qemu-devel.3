Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB40DCA9EC7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2026 18:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFyG0-0003B4-2B; Sun, 11 Oct 2026 14:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1xFyFe-00034P-9S
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 14:26:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1xFyFb-0008UL-SN
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 14:26:25 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69BIL4gq3179151
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 18:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:sender:subject:to; s=qcppdkim1; bh=TFbT
 Fpoz4msVzOvA76OFjh3YegaGvX7/iHzSOwQK+jU=; b=iIemfP4fbLcvqlyM4NVx
 wWzW9qc7PbkU8vLEBmh4yGdiPWmWL9YbYnMpJ2E8EJaZQqJKH0pRJMTzre9GTmUT
 x1tDp7DV36EmkxTjjeDYhqd0fZVctG6B18zP5ZcyXc8jYONwomPLgVsctIiWZdWl
 6ufKTlVuun26iOTSKxFPnulcOwjaO+5z7PFrPLMwmOhCULnziV/NVWsP8Aa5R/ZJ
 B4ow+J9niaXtsJY6soSbu2cLIHc6oDlwFoy2RlC0Xzc3d+EkS7Iks2CXlGGTJEqX
 AGOrjCd+TDkLFBWlQdAQre3DV4logubmuYQFmKWFsa6RI2Nyzepy82DmKpDCRmGc
 fA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7dr7kgvq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 18:26:22 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35a04491c56so421463eec.0
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 11:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791743181; x=1792347981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TFbTFpoz4msVzOvA76OFjh3YegaGvX7/iHzSOwQK+jU=;
 b=CuNGVRQIxPk2QOmfR9HAK8pE1LbqEmEKeUUfWKlL2q1JVEgYk7d9cHqLY4NAgoKtbZ
 9r63n07OOYrAn6oCGb1vs/MngLIpX27Z3C6vQuyrTHFh2i4LTBoD9TcAFxzZX0FDDD2Y
 vgVd0Ci0mqJVnxPg3pKP638Z9x3ZBMDl9Mwp8CAVkNXxTHlszVnyz5e+hX5P5uPyk5RQ
 aFiaLZcmEnf9qN8l4f4EsP+O3OBvJlRXcRgLTwiLiJqBiMl3cPtdr0yzY/AkYgKCJk4v
 eImwvfHwt6HiFJ4yHYbZgvVYhccjHSwLtgGYeQGi0KbdozW6vgYvBZ5ZuFluF9IiDK+O
 gTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791743181; x=1792347981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TFbTFpoz4msVzOvA76OFjh3YegaGvX7/iHzSOwQK+jU=;
 b=hLugdSFqvMwuZXCtWNQkrKL9PIPnZ9offAkXT3s4j8N9DOJ9O5vBuVdh51ebmIpx1e
 jU+TmUFpyo270c64ynrlIDF5hf/TUXp2QsekyucjMd0KFWlKrUm1t5u/S+pO+wdAuI1R
 1bRDiGM294XV7WdtikFxGW66ZKzKJrJtp+uE2R1X+iB+wkiqJm2eeJ8gb9u6HBRo6Y9I
 odrbf67U2EnajAnL6hFUhC6ZTVeU6iAWJETlIyWoqRwN70K/vc8i4tIE6r0r6Y3y7J9N
 r6QicaShTRYj6vXHzhPvKjMsNPnNx0Xy5em7qfe6CyYFjVh2jBpNmTnzMyQBnQerr6wV
 z16w==
X-Gm-Message-State: AFq9FYIfDwxEQ5lM9DyhnIRTwcvajS2NY/PVUejOreH3EVr+JV7gX39i
 GQZcvIdxZu/sAcWQ+iddLyLZz+O4ZVTBBSjzu8GdNoKg++ht0wAz8xv4e9W7OQDrRPduT56cIo1
 eXQNFHob3cRkOy+W5oiuY/NnHiANc5EX1JCHq9c3KzAEcGtBPGZGe/UoujmWiG/mZ5w==
X-Gm-Gg: AYBFou3qVsnzJeTC11dSP+E7+oCTiWQZWutLvRxw0mmYkutXAo1n4fqTdxKrteZtaSF
 h5JPf016/PS14ZBdZgsiBvKaGuQQN55dDipb3OZNCWrz3f/nEhT39+3XP8r1jZAyFObGtsteV9N
 tkmhrPEtr0UU3TS4eqAvHqqMelBQUrLAcjNzVqepo6vSucCw8hyc5a5Awe408e8K3Zo2LpXc/9E
 QRGzgy3no8GCGhNqgsIFKzKrW3EMFcpQIVqnN/+4gud//5CRJ9iUXUAmU05Q+zJqNWXFV0tQ6cY
 wQH2AvxuO6m6egUamvE1WttHam57SBMGnUjKhGGz6TcDSTWP3u257UCZOxuuZsPHVBdQAFexe+S
 tbYfnQU9Y0qs7UhKDhqI+0f6YXzf+x+/DwAnLi+tYmot9OC7HGn14z/4=
X-Received: by 2002:a05:7022:c84:b0:146:5f73:d45b with SMTP id
 a92af1059eb24-16a54fab691mr9918463c88.3.1791743180999; 
 Sun, 11 Oct 2026 11:26:20 -0700 (PDT)
X-Received: by 2002:a05:7022:c84:b0:146:5f73:d45b with SMTP id
 a92af1059eb24-16a54fab691mr9918432c88.3.1791743180475; 
 Sun, 11 Oct 2026 11:26:20 -0700 (PDT)
Received: from hu-sunilvl-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm22505284c88.22.2026.10.11.11.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 11:26:19 -0700 (PDT)
X-Google-Original-From: Sunil V L <sunilvl@oss.qualcomm.com
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>,
 Drew Fustini <fustini@kernel.org>, Sunil V L <sunilvl@oss.qualcomm.com>
Subject: [PATCH 4/4] MAINTAINERS: Update Sunil's email id
Date: Sun, 11 Oct 2026 23:55:52 +0530
Message-ID: <20261011182552.1071742-5-sunilvl@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011182552.1071742-1-sunilvl@oss.qualcomm.com>
References: <20261011182552.1071742-1-sunilvl@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kSxdOaL4x56AXETQ63m2D87r-xCpAyrh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA3MyBTYWx0ZWRfX7YOX2s96StkP
 Bz0n2+XqEh4BLHSWJipexhNRGHcwDNw2s1jFvDJFJj2neJiH3OmqV/F27EGTfOxD3GobUhvM+nw
 LzyrD5Wd+28/pnDFlJKQx7exZQIm0ZU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA3MyBTYWx0ZWRfXyOrxmMLjQ1EP
 ywLXOW5ox9D/GTWZFlB5EtA3I6QZnOqS2FhF+4Zuz8U5R4nMCfNd/aIhx7azfPMX+0QphZDlo6d
 bvVMvRcqwo60ufnWF+Cmgp5Obrr+drEk5XKKLEmseyDOJRSOprN14O9AZ/y2MH06bado7gl8D04
 CObeUyK9X7NNjzHEUHTDGE6sgNrbGOdy9dvO4SSq8Ix9L229lknDx2X16U7Q2dulSptwYTOkoMF
 hHIVYcZjg0HAqjUl/4Z7KFMCDFmcEfwSb0oRzqHq/jc5Yimzn838xbeNxIgtmas1lGg6kAw8Nwh
 xz/CSjXCin6JxfO9je1E4E4xizUKEPxXNOziTA9t4OsWUyBKjsxv7ydSm3fBRSDnLO9pWd2xMvR
 dK9fmgxPv415Cu8hwYelvVcqS39nS6ao4EMkH5J/QEJvvz5KptRQ390Lb1LRvbqrCWki9/hFjBS
 PSMVLxg18kw5f5hVQdw==
X-Proofpoint-GUID: kSxdOaL4x56AXETQ63m2D87r-xCpAyrh
X-Authority-Analysis: v=2.4 cv=asknmiZV c=1 sm=1 tr=0 ts=6acbd4ce cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=bDdBU3oEAAAA:8 a=69wJf7TsAAAA:8 a=iDT6BKECi1uCQsOPTuAA:9
 a=bBxd6f-gb0O0v-kibOvt:22 a=DN7SgORnOiO7RqxRx1GC:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110073
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Reply-to:  Sunil V L <sunilvl@oss.qualcomm.com>
From:  Sunil V L via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Sunil V L <sunilvl@oss.qualcomm.com>

Update my email ID to qualcomm.

Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cc426451c2f..5c2282088610 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2335,7 +2335,7 @@ S: Orphan
 F: hw/arm/virt-acpi-build.c
 
 RISC-V ACPI Subsystem
-M: Sunil V L <sunilvl@ventanamicro.com>
+M: Sunil V L <sunilvl@oss.qualcomm.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: hw/riscv/virt-acpi-build.c
-- 
2.43.0


