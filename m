Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB8DC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24u7-0004F6-FP; Thu, 03 Sep 2026 06:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24u6-0004AF-BD
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:42:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24u4-0006te-Q7
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:42:46 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHMOP055453
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T2IQzbtiIHH/wrbXe+4eGZPBx+zyjlpzsymxWhUzKuA=; b=cZDONQ1a2FAGJkRy
 TsxXthKQ0ivIyjalfVrKKug98oXYbzBMUg4sxoH33OVJEtq8CKkLP7VLyQxgoep3
 iCdy3XotrCzdNTJNY0Qwl5wqqDPt6/4+n+4h6rWobdTiBDzAywIaZG8zfDj6Rntq
 eV7ZXfvxPKuyvbbUR6OewpRvFK9d67ysH3LwVz9D00rErbIXlh4ifNpX5nPDGorN
 kkgJMfatYgLipHPcvjXJTXPRuV01UUJmVa7LzpxuaJneUJtRq/dnr0Vk4PgIEdJR
 oYFRcyCMuuBX5ZzS/03vENO01eH1kyLgRUvQsVZf5c2CREfACI2EMpVG94ZDk9kP
 cfFHAw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdvgu5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:42:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9390ca1a9abso355144885a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432163; x=1789036963; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T2IQzbtiIHH/wrbXe+4eGZPBx+zyjlpzsymxWhUzKuA=;
 b=ADvy9CbE0nBU76Vw5SB2bHv2sh3EfF05PG6Uzt1mLoeY8OqgMtkHNLKcZHj/kpTVj6
 ZK+TGGI1LE3ZZ7AGiSZrsrfm7YeJCYidrN3Cx2IlRRSrxYBXDwAA38uLkpy/ZgkMO5eA
 V/dkB/ODkA8mRw3tLEBTJwYr35dmEDVFoiMnienZdjlAs+FcVD2PvBWt6+3e7S/Pk241
 0itjf7HhATX/Ue4jY3Jer8xqw5xGV75KW7XDeB8QTsB3Ys3EqmtMT+bI36QXjHgT7mV3
 6iDFUPIbZkIo4P4opQVVjBQ39I/+aZ6TPrQahqT5ihpvCyg+3+B8ohCdNIIzr2w+xBYy
 AQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432163; x=1789036963;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T2IQzbtiIHH/wrbXe+4eGZPBx+zyjlpzsymxWhUzKuA=;
 b=JsjDO7MxQUkSwbcNGyQU/fF1xvOzFsTicNpK4CZtKaRSF2dNnuN/vaL3GG2Y1IG6X2
 Ag646qChQeHxIfZGul9UXhQa9CxRUXLYoxnRblw5s2wzCYZ4kRYkYODDXLEcgp1htHXO
 23KK9deZsX2IFCKF/jl0HR6QtDt/kMJdVNgbkQeCJ/7OkG/L3s3Kv2CcmA6dM5uvFQm+
 /xANNDxa5HFl0CHYYhF2t8N3aJqJ/Z2GrQyy1JgAFLgqwJuqr1mNmK1J8fYhxZFESMrX
 c2l9cCo31LRUPOd9hmqy/eIlZ00Ss62QJWwmce+T8SV0DgtiUU1+02p9fVhgRfEJd1eL
 SnJg==
X-Gm-Message-State: AFuF++lKjonzExw/FDBhH2FlweGfodi6a4hDXQlnfv1K01oO8Kw1YnLI
 7Ly9CQDygU8Buc2OiB5lgRrCvz2y2Bqf0+lNpC1yWQW4FuJsamJ26zmNPLxJc8mcT83euBZ72i2
 fqVUdoXucIWwQxIxCa/ImDmlNb+/Hc3ULn48xGnGTxdMa9aCRFcL1f9GWPTwCaDCq3A==
X-Gm-Gg: AYBFou0mpNL/k9rqIqFZTS0tx7OesaebrDvaT4GBLRrHhL0SbJj6XYpmKo7IUTqxtBS
 plw9Rpyjo8bUIFtpcpl2g0qRm14kWiHj1zcrO7+l5yoM9e8seN/FLKQFVHtWsRmxaGhkJ0yoeDE
 yEYGuDqrkbJnSjWo4gPkGo3ITgKpiZ9nik7Djt3OkUEzzGDWfXcDeEwfnXM8xp+Z77PT9V6mlhY
 7EuMCGFNI9pswp9lIT6dTLIo3lQ0MvGGaZD+Qsf4YuCwkdDW1woqfA/X86Btc3kmvzEgIO2m4fQ
 M+SCdQW8GLWy5px9tZXSnB01XAhcXzuwX0Xf6EQAO/Y/tVHvg2074w4bqPx2smCT+hcPwduh0g8
 PSuSAdSAgqm2kFmZk7ARPb93UvLxhI2MSGnsvN9cG
X-Received: by 2002:a05:620a:379a:b0:937:e422:85cd with SMTP id
 af79cd13be357-93960cb8415mr997264485a.7.1788432163288; 
 Thu, 03 Sep 2026 03:42:43 -0700 (PDT)
X-Received: by 2002:a05:620a:379a:b0:937:e422:85cd with SMTP id
 af79cd13be357-93960cb8415mr997261485a.7.1788432162784; 
 Thu, 03 Sep 2026 03:42:42 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e72df2sm13692068f8f.1.2026.09.03.03.42.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:42:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/51] target/avr: Constify CPUAVRState for some cpu_*() getters
Date: Thu,  3 Sep 2026 12:39:09 +0200
Message-ID: <20260903103936.62355-26-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a994f23 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=064F3_fa85QpgnnSfTgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: boJgpaLCSfWHHSexorlnKHQR-fmirgEO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXxnMVz8PXRsGy
 op52oapCJc+hpqZXteVGd5DBmmp2n6XBXi53DdOmxEZNAGkIJJrVeBl0z5ZOrh4z0VisiPxfSs2
 WnLJ0fwFn8qnOE9Q+jomOu/RC84hE9n5/ZaqkZYu2Q0CIB1cj4s1dcEoBldGECpnHlCpeg0Ws/4
 vj1XrXvos9uukaW9hUxmiM+sRXqnBtZcTCoAoFfzE3sW87hppKtc5+d4mGen59NnuO/rOzU4ZBG
 QMfueCJ4vRBSa1zD1XMLixVOWifTgzRIpAOGLRAspI4PdNZ0g2Vv1ksZ7VdtwFiGP57qXvFoGln
 3P4SLrZmTIGaZbvmYxgfKwTAww+UW9+OQ0jzmF0RLQGQdWWXFnWMkl9Skb5+qj0Z+9V67FrsUhc
 xBer/SPTStwkgTX144th58E1CXVSGmVLjdLH3zWlODMSgruG+LvoM4ECP0T++Xc3taDNoGoHV10
 Z0KATKaJPHq7YpAbgPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX5c/Cptua7d9c
 x6yRXRU5OiGmwPcFMKQsPlaLloUlJEb1KaJBwgQwa5QkPhj9wuiaqClAexk9oeIY/Ogcd16o91Q
 OuBJBZFsA0WJUTRBLEPzSZW2fJegS6A=
X-Proofpoint-ORIG-GUID: boJgpaLCSfWHHSexorlnKHQR-fmirgEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Add the const qualifier to CPUAVRState when the
argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260901095229.72018-8-philmd@oss.qualcomm.com>
---
 target/avr/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index a818db753b2..1e4e839bd83 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -183,7 +183,7 @@ int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int avr_print_insn(bfd_vma addr, disassemble_info *info);
 vaddr avr_cpu_gdb_adjust_breakpoint(CPUState *cpu, vaddr addr);
 
-static inline int avr_feature(CPUAVRState *env, AVRFeature feature)
+static inline int avr_feature(const CPUAVRState *env, AVRFeature feature)
 {
     return (env->features & (1U << feature)) != 0;
 }
@@ -204,12 +204,12 @@ enum {
     TB_FLAGS_SKIP = 2,
 };
 
-static inline int cpu_interrupts_enabled(CPUAVRState *env)
+static inline int cpu_interrupts_enabled(const CPUAVRState *env)
 {
     return env->sregI != 0;
 }
 
-static inline uint8_t cpu_get_sreg(CPUAVRState *env)
+static inline uint8_t cpu_get_sreg(const CPUAVRState *env)
 {
     return (env->sregC) << 0
          | (env->sregZ) << 1
-- 
2.53.0


