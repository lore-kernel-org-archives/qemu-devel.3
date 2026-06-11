Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE244CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 16:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXiAz-0001n0-5Q; Thu, 11 Jun 2026 12:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXiAx-0001mi-Gs
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:22:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXiAv-0006aI-Qt
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:22:39 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BErk7R925731
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 16:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3ujoPZdqE+D
 UNIoTZmrKeYH519uAQoGPnpFXqAXiS54=; b=LM9gE/RTxmIJ4LUONVD+QAdX91l
 qm2tRIWq3k+lVLQw9E6q2gb7TyAwmf1VYS3M16S9sEu08iLOXUny69CiIjYHJlqj
 DyGBw4Lnu1OrRrUjyzRfB3m6OzhCEVxGbatPSJvXgEjpalZz0woH587uEyXvAwyg
 vLMFuLxHtFwsoUYFaKj8dcp1m18R1pzwcCcIsQl7sYuS6GK9+knCmUWNWk6hytNN
 ScIsEXT+1Aqk5iqm232w3Lt5XsSuTuODeZ00RJkzw53qc4xbf9IGGR1hn2b4eTiq
 MXDW1yYNEfxPHclJ7CIzyq//TT/gvs+UVfDNFJriIYTDfUDSLP9ytYyqpJg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u4emf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 16:22:35 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6c89de84f33so8237198137.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 09:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781194955; x=1781799755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ujoPZdqE+DUNIoTZmrKeYH519uAQoGPnpFXqAXiS54=;
 b=XTJUALbX65gZDwjQB8xtSBSt1cjt8cCmqv2pZ+ESjCdSa5E9aWtaYkSUnXhCbY1vcU
 FuGBXx1u9v1wd48CUFcETIcKtTY55FKFc5zM2aKf/LS3nF+d2xkzyxuqY+IHHvH+9Q9+
 RHdYwlFNxUu85/YLQGgZfUrlvDl7IC3OPtAOsYGwfwcDvTYMnbM+m8eAXRbanhubeXzK
 AC2jDsO0IcmvCbpP3qBkv6vjuDbHLYmspOFA/6V3FnwiwQQ7WCmTQiaHYItQAexHk0GW
 LcwE5L1Oa0r+35XRxJXrksrD1cIrCknWBiII1weM35n4mdjki5u4vTKNtXFh+pTwKVu/
 1jiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781194955; x=1781799755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3ujoPZdqE+DUNIoTZmrKeYH519uAQoGPnpFXqAXiS54=;
 b=ZfhgAkKD1B89P5UZT4gvU9bq3fpxhJj3ibNlSb3IwGhq5LdovNTo5CLL4l9LOKET1c
 wyoYd10Fg7iuZylDX2cf79gDVwHLOc514bL6yDhJ0SR3lH945+eJQQ2C8sithb+ug2qj
 Jm09SlslpNmu6IFHZLjQXhnrRYWt1U8Zmb1Zm9f4mL3DPkwmcJByxYW27RWEuiwNB/q3
 WOLEqzFHOc01Lm4RA0CFYLHqn3RT1T9u+Y0Ci3KyexBBpHnTkDeIydrZMkFWkk4Xwzcn
 U4hiSHXs9JWN3+7fRZKY1wq2RJ6eu/hLkrFzFI16lsKXqgPqPOML8YYreAt/dW0VjXc4
 gRaQ==
X-Gm-Message-State: AOJu0YwXJ+OuqXs5EVfdW2q0xwO5JEaI+7SHsx5futSteNJV/LDP33wp
 LI5vAv7fTYj1grfH7kzBCc2HeNz5yIbu/Jryx9J4lWlQIVGpASTFiTaw0Sx4dES55csOMDdUNpR
 9kVNZkSzPMkxrxSTGludauYoNHOwGbCmmRzMHqxAjth2vjittbKdRAxL58X4sMb9M3Q==
X-Gm-Gg: Acq92OEhIHIxNC3t6YiSZZzZO4R9IwtQWsfI0rGb060zr9GXfwQXWZ6GPEmKrFeXT3g
 nqXUv8GsdO6eEl4+U0lTCsdRwJbAZtE2ncPNEUlgdSy7vWl2L55VeZk4f0jMOy4VJG4pEfDaYX7
 9/uhmfQqnZkTcWHa/rcFm6okIPf29lP5HfhWEZhuJzMOujrNDEensSnLp5If29x8o01B5Q415w5
 mLDb79NjUZVIa6J1/qgC+tBLJyEehjExJnImUMokSklULAKOlgcnPEvqXfTPdaxSagelA4ZLTOd
 UQlvSI3VnmnhtreXAYk9J1efKpnqNR96cKCSiacKDxSfRPVm/wVMejMDYgCjx+le/n4p7rQvlB8
 V051VkN6bxz5ujnMA8+m0YKy4qFEgOASqFW/dgWrgcjCF5mBqaPk9UJCZJFI=
X-Received: by 2002:a05:6102:50a4:b0:631:4580:6a33 with SMTP id
 ada2fe7eead31-71d5ca70b3fmr2345171137.21.1781194954656; 
 Thu, 11 Jun 2026 09:22:34 -0700 (PDT)
X-Received: by 2002:a05:6102:50a4:b0:631:4580:6a33 with SMTP id
 ada2fe7eead31-71d5ca70b3fmr2345107137.21.1781194954188; 
 Thu, 11 Jun 2026 09:22:34 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d1eadaea6asm21879526d6.40.2026.06.11.09.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 09:22:33 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 1/2] target/riscv/cpu.c: add 'svbare' satp-mode
Date: Thu, 11 Jun 2026 13:22:22 -0300
Message-ID: <20260611162223.2361941-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611162223.2361941-1-daniel.barboza@oss.qualcomm.com>
References: <20260611162223.2361941-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pfUQzTAdSVnid5AoRAJ4ElWW79PUh41v
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE2NCBTYWx0ZWRfX0pbTOKfXVfse
 Foz5LSsJxSwbO5fGTuYpRjwHrPbu1+RTqiEAQVWypX2QULER9X1VYQQbvywqaa3eb8+m3f53B5n
 bCoLkLCylm2JIXUSdIAAz2JCnZ0e2QU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE2NCBTYWx0ZWRfX0xAw6xAlJ8tX
 h4uZQIVr7pvnIy97Ilf5FMjH9l2UVEzPLHBXi8jYpPaRgfhdJnVWsnSmO0aAbZLIV0QXqs6M9gO
 bBJTrcemE0Bo76JTm5oVoJcYI0NmRdq8s4jiZ1qv//WCmt3EwSkniAdFzzq1wYb/OAIRIR3FKHH
 ada0HtKtxwj11rlEv4/HrcEofpkFzgnaQEbF3zm9LDl8uwHwoRh3t3hU3VUQdmQyo0Pz+yy2SC5
 C+5g309bVJiyxreF2O0ZauCpMyvAngYqfW5J06RFlZymGjqSP6qEavZN3QYDw1N97wtAcgAjinF
 ITpjvEWpgmK91CfLqA9+lbymOV8jYWTStsjFOhAVRiFXlpLPZobRPQ+yOufxwADEHsdbKchM4Vt
 NmZm7SUq19XgK4rvYp0aY3yMpeGZ4/P6E8tOkaxVlqYqdEhdus7vMWpxpgCEh2n3kx0ohLV3f76
 vBqOhTmDS7cuc/2GUxA==
X-Authority-Analysis: v=2.4 cv=F5lnsKhN c=1 sm=1 tr=0 ts=6a2ae0cb cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=0YmiQVT_MXrfFZhh7UoA:9 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: pfUQzTAdSVnid5AoRAJ4ElWW79PUh41v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110164
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Seems like we forgot to add a flag to set satp-mode=bare.  What we're
doing instead is to set the CPU default satp-mode to 'off' to set it to
bare ... assuming we know the default satp-mode.  Otherwise one needs to
do -cpu X,sv39=off,sv48=off,sv57=off,sv64=off to get a bare-mode CPU.

Add a flag to make this process easier.  The name choice is based on the
fact that I didn't find many references to 'mbare' in RISC-V docs, but
'svbare' is a flag name that toolchain uses to set satp-mode=bare.
Might as well use the same name to help with cross project compat.

After this patch:

$ ./build/qemu-system-riscv64 -M virt,dumpdtb=fdt.dtb -cpu rv64
$ dtc -I dtb -O dts fdt.dtb  | grep mmu-type
                        mmu-type = "riscv,sv57";
$ ./build/qemu-system-riscv64 -M virt,dumpdtb=fdt.dtb -cpu rv64,svbare=on
$ dtc -I dtb -O dts fdt.dtb  | grep mmu-type
                        mmu-type = "riscv,none";

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c1b10cc7ef..d968daa404 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -421,7 +421,7 @@ int riscv_cpu_max_xlen(RISCVCPUClass *mcc)
 #ifndef CONFIG_USER_ONLY
 static uint8_t satp_mode_from_str(const char *satp_mode_str)
 {
-    if (!strncmp(satp_mode_str, "mbare", 5)) {
+    if (!strncmp(satp_mode_str, "svbare", 6)) {
         return VM_1_10_MBARE;
     }
 
@@ -1053,6 +1053,9 @@ void riscv_add_satp_mode_properties(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
 
+    object_property_add(obj, "svbare", "bool", cpu_riscv_get_satp,
+                        cpu_riscv_set_satp, NULL, &cpu->satp_modes);
+
     if (cpu->env.misa_mxl == MXL_RV32) {
         object_property_add(obj, "sv32", "bool", cpu_riscv_get_satp,
                             cpu_riscv_set_satp, NULL, &cpu->satp_modes);
-- 
2.43.0


