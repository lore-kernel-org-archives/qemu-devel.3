Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E98CC44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAO9-0008Cs-5E; Tue, 07 Jul 2026 14:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAMg-0006eR-HR
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:17:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAMe-0006Zg-HP
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:17:50 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FT5VW045839
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S4UeV9GwVf1pBt2GklbwPNfwdgfJwcfzqHhzaPugt30=; b=JvCaTlFjIZPVua5u
 KFKkYM7BKUXBpyZlBFlHZ6MiBus0Oz0wfya2K617JnrzF9hi7uMYIPPCaTGUd5zJ
 Yh6rY/IVR1y8/K4E7Bvkx3mdmZSciH0nMKjMjmcAHPN/RLocjZ1AWv9R/SgxD7xe
 2yX5YraTazmTmgQYguwR1Al4q/eE6Q/YtSVHk36200IYSSPuZpUZIFskEWyFWX5o
 r3duCNzk4fwgq6j5Amjqrg9wxoPKJ/5fozPNbbcpSB6cmEc8cO8ryrm/3HfhGKPl
 2DYHYUthzFGieuSFWmL5cABYdqydt0AIdy8PbliO2PSKGz96umsk8OCA5EYTiGVV
 gyn7DQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w11trc7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:17:46 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92aea0d801dso457175085a.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448265; x=1784053065; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S4UeV9GwVf1pBt2GklbwPNfwdgfJwcfzqHhzaPugt30=;
 b=aVlUNUzL/cF7px3FyP4XjL+z5GVyIYLSyvNRYGkb+Mpfr7GFti5s6c4xKqVraDEnjV
 /hrqX2y7jArZloRM4tMpNl6EjHFHNe8VD87HHbTfSoxNJDTySj0kMCIDH4Glt8ShZVgw
 esIjdgDg405hYeJvl7ZCOsY6vbM++w2ZuWnWh+rxQNCal1oLTcRlMwD69/+cXqjl/L+g
 XQsieRwlwp0opJxzwESgKSGO8F7bEsIAAX7UrFQJ+39yONqzF3WVvowPjVhZSyZAn3hB
 xZopxPeeXztTtYcrDNvS8pkn/o+nuxOy4WjBXmh4YqNH3l5AkhtoU3qwjkAYcj5VO97g
 CDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448265; x=1784053065;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S4UeV9GwVf1pBt2GklbwPNfwdgfJwcfzqHhzaPugt30=;
 b=otrlg1LkkiOgddxhalAkwDssuFGDg7lQe8URfiOBcT5NIm6wyAN8ZMhntflEWdjU4i
 ppJGHM9T134gax1QXn/vSQIBzCS1r+Pihfi4+LQCoqQUpK0S+656GBFxdiylj8zaU1A6
 BSi/yxIdhjYN/W/0bYQng17dbv3KvkRhTX9c3V1W+ONC27syOTgNaNjB7+V58TSbUNzR
 9zhZkgE15EFKUkERa+IUPkKShq4PUcuKezD/kmguZoM0K2Nv0gbgKhB/mCIwUw4PzAS8
 pk2pUDi5astzr6UpswIwZ2tuQK5p5YQKlSTeiKT3Q1ECQLXqI+SXBTViuF0Ua6cxcaHy
 ECZA==
X-Gm-Message-State: AOJu0Yy9GFId3qjCtmnD+BppVBgfe6f2kUgT+v37n9s11+DBAxsyhhre
 2HugceTpj17mV8Q0DjxUFrAr0NuNJeoLXsRkovymt1wz/K0po6q5YiLYNYpr/1YmncwGPfiIBWI
 WRXO5gesqT+7nmFSQC8b9LV0TAXFEKIfsHG6iJ2JiNeEs96RQBohM4d0TBqy9Cay5Tw==
X-Gm-Gg: AfdE7ckdef2I14F4L2NnH9H+0DwQ3GeT6jtJcTw0ducP69qEbnGlXsGyBJP9gkFb3fq
 YXpaR1mSZR6UVhojdnCYKyVgh/kCQGWv00RIKodnEsky1GLeDvjnzioR67HGi2ccHkY0u2W+5Yd
 uYEXR/HN9G4kVkZ49LXTqFod4M+ygSPNpeVqhd1wKaDmrDXf+93b2hDt2mf7qmcDoE/g+fl2yXv
 NiWT1y90lO9pptcg8mkACm/4m90c5UuQgjElHegjcIP5ylIsh2m5VXIkQCj9R28RN6U3K/qX4zB
 m/lgf9EDsrWQkG1aQznh4IiMuY1Bhk3riE7/IH+/pPaZ8bbq0tPbi0Jilq1OfZVZZxpwzc/78Nv
 K3K4kLEPuOHOiP4qOODTW5zuEmc9B9xCXL2jSm38WD/x3ZMVGJpyQavkH1tdP/2ZVspIZ
X-Received: by 2002:a05:622a:11cc:b0:51a:8f3a:13b9 with SMTP id
 d75a77b69052e-51c747955c4mr69790711cf.16.1783448265170; 
 Tue, 07 Jul 2026 11:17:45 -0700 (PDT)
X-Received: by 2002:a05:622a:11cc:b0:51a:8f3a:13b9 with SMTP id
 d75a77b69052e-51c747955c4mr69790241cf.16.1783448264510; 
 Tue, 07 Jul 2026 11:17:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f2186bsm35236255f8f.36.2026.07.07.11.17.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:17:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/23] target/mips: decode Octeon CHORD and LLM COP2 selectors
Date: Tue,  7 Jul 2026 20:15:24 +0200
Message-ID: <20260707181529.60191-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DMe/JSNb c=1 sm=1 tr=0 ts=6a4d42ca cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=f58Cf6jUHuCqYyNe2GoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ZdZ0wK1uialqTqmIVfTPVqP95_Zq6s2p
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE4MCBTYWx0ZWRfX0gm3h5NadPEn
 kOAggiOPxQRXQ2mZJ+51FySyeGxCQ9WxG9nqMU8PctUetuwmO2ZYYgeV/XGXssEYbz/Rn+mACUp
 hiGHJtdT+b6l+p0M17oPHgn9iC88iSY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE4MCBTYWx0ZWRfX3E4b1CHHxjdZ
 yAU+H+VuwaCcv6XRz9jamaPND71xNwKPZT/15LPplzmVpIsSa2RioeU0raT7sPwd+ExvKoajC9f
 Mt8kfQlLm2T/oawXrN5C8fHwm05J5hA/S/jcU/QFj3SzlPWi39R8CnYNeMVfmHknhvWheVF/1a4
 V+8f0xZQaz7iVUy7u/CYpGM/+6KyPLLT31q2O+LoQRg//B+GkbbgTJA6Z2jAk+EMnsU+24HrwuE
 EQmzEMGC8hPWZ3H5SddlL+5eRC3nc40WlIK5CqzKH+XmfzcJQMZXlqs0xsDtUJwAm4BVo+As5cQ
 DylgueULOvdRNLAP7ycpvxMxqearxsBujE0McSMs9h7fZ7ruQaTQDAN7a7z18Pn1GOA4M4AGNM+
 6xE+L0Me4aJ+j+W9LAiUDg8D4eu2HhZrcprv3Csq3CAIVt5Ur2TfujhnGYpl2oCB9XdqQ6Va11U
 tpKSFIMsyfMXtNKzutw==
X-Proofpoint-ORIG-GUID: ZdZ0wK1uialqTqmIVfTPVqP95_Zq6s2p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070180
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: James Hilliard <james.hilliard1@gmail.com>

Add explicit decodetree entries and translator bindings for the Octeon
CHORD and sparse LLM COP2 selectors.  CHORD and LLM use their own COP2
selector window rather than the crypto engine windows covered by the
preceding decode patches.

This completes the explicit COP2 selector coverage by adding the
remaining CHORD and LLM register and operation selectors.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-19-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/octeon.decode      | 13 +++++++++++++
 target/mips/tcg/octeon_translate.c | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 4ac38d264c8..a8c944e6681 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -167,6 +167,9 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MF_GFM_RESINP0                   010010 00001 rt:5 0000 0010 0101 1010 &cp2
     CVM_MF_GFM_RESINP1                   010010 00001 rt:5 0000 0010 0101 1011 &cp2
     CVM_MF_GFM_POLY                      010010 00001 rt:5 0000 0010 0101 1110 &cp2
+    CVM_MF_CHORD                         010010 00001 rt:5 0000 0100 0000 0000 &cp2
+    CVM_MF_LLM_DATA0                     010010 00001 rt:5 0000 0100 0000 0010 &cp2
+    CVM_MF_LLM_DATA1                     010010 00001 rt:5 0000 0100 0000 1010 &cp2
     CVM_MT_HSH_DAT0                      010010 00101 rt:5 0000 0000 0100 0000 &cp2
     CVM_MT_HSH_DAT1                      010010 00101 rt:5 0000 0000 0100 0001 &cp2
     CVM_MT_HSH_DAT2                      010010 00101 rt:5 0000 0000 0100 0010 &cp2
@@ -261,6 +264,16 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_SHA3_XORDAT15                 010010 00101 rt:5 0000 0010 1100 1111 &cp2
     CVM_MT_SHA3_XORDAT16                 010010 00101 rt:5 0000 0010 1101 0000 &cp2
     CVM_MT_SHA3_XORDAT17                 010010 00101 rt:5 0000 0010 1101 0001 &cp2
+    CVM_MT_LLM_READ_ADDR0                010010 00101 rt:5 0000 0100 0000 0000 &cp2
+    CVM_MT_LLM_WRITE_ADDR0               010010 00101 rt:5 0000 0100 0000 0001 &cp2
+    CVM_MT_LLM_DATA0                     010010 00101 rt:5 0000 0100 0000 0010 &cp2
+    CVM_MT_LLM_READ64_ADDR0              010010 00101 rt:5 0000 0100 0000 0100 &cp2
+    CVM_MT_LLM_WRITE64_ADDR0             010010 00101 rt:5 0000 0100 0000 0101 &cp2
+    CVM_MT_LLM_READ_ADDR1                010010 00101 rt:5 0000 0100 0000 1000 &cp2
+    CVM_MT_LLM_WRITE_ADDR1               010010 00101 rt:5 0000 0100 0000 1001 &cp2
+    CVM_MT_LLM_DATA1                     010010 00101 rt:5 0000 0100 0000 1010 &cp2
+    CVM_MT_LLM_READ64_ADDR1              010010 00101 rt:5 0000 0100 0000 1100 &cp2
+    CVM_MT_LLM_WRITE64_ADDR1             010010 00101 rt:5 0000 0100 0000 1101 &cp2
     CVM_MT_CRC_LEN                       010010 00101 rt:5 0001 0010 0000 0010 &cp2
     CVM_MT_CRC_DWORD                     010010 00101 rt:5 0001 0010 0000 0111 &cp2
     CVM_MT_CRC_VAR                       010010 00101 rt:5 0001 0010 0000 1000 &cp2
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 76792c9c874..a0db6630c7d 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -235,6 +235,9 @@ CP2_MF_I64(CVM_MF_GFM_MUL1, gfm_mul[1]);
 CP2_MF_I64(CVM_MF_GFM_RESINP0, gfm_resinp[0]);
 CP2_MF_I64(CVM_MF_GFM_RESINP1, gfm_resinp[1]);
 CP2_MF_U16(CVM_MF_GFM_POLY, gfm_poly);
+CP2_MF_I64(CVM_MF_CHORD, chord);
+CP2_MF_I64(CVM_MF_LLM_DATA0, llm_data[0]);
+CP2_MF_I64(CVM_MF_LLM_DATA1, llm_data[1]);
 
 CP2_MF_HELPER(CVM_MF_CRC_IV_REFLECT, crc_iv_reflect);
 CP2_MF_I64(CVM_MF_SHA3_DAT24, sha3_dat24);
@@ -306,6 +309,8 @@ CP2_MT_I64(CVM_MT_GFM_RESINP0, gfm_resinp[0]);
 CP2_MT_I64(CVM_MT_GFM_RESINP1, gfm_resinp[1]);
 CP2_MT_XOR_I64(CVM_MT_GFM_XOR0, gfm_resinp[0]);
 CP2_MT_U16(CVM_MT_GFM_POLY, gfm_poly);
+CP2_MT_I64(CVM_MT_LLM_DATA0, llm_data[0]);
+CP2_MT_I64(CVM_MT_LLM_DATA1, llm_data[1]);
 CP2_MT_U8_MASKED(CVM_MT_CRC_LEN, crc_len, 0xf);
 CP2_MT_U32(CVM_MT_CRC_POLYNOMIAL, crc_poly);
 
@@ -395,6 +400,14 @@ CP2_MT_HELPER(CVM_MT_HSH_STARTMD5, hsh_startmd5);
 CP2_MT_HELPER(CVM_MT_HSH_STARTSHA256, hsh_startsha256);
 CP2_MT_HELPER(CVM_MT_HSH_STARTSHA, hsh_startsha);
 CP2_MT_HELPER(CVM_MT_HSH_STARTSHA512, hsh_startsha512);
+CP2_MT_HELPER(CVM_MT_LLM_READ_ADDR0, llm_read_addr0);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE_ADDR0, llm_write_addr0);
+CP2_MT_HELPER(CVM_MT_LLM_READ64_ADDR0, llm_read64_addr0);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE64_ADDR0, llm_write64_addr0);
+CP2_MT_HELPER(CVM_MT_LLM_READ_ADDR1, llm_read_addr1);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE_ADDR1, llm_write_addr1);
+CP2_MT_HELPER(CVM_MT_LLM_READ64_ADDR1, llm_read64_addr1);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE64_ADDR1, llm_write64_addr1);
 
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {
-- 
2.53.0


