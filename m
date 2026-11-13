Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049E60A2600
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IYzlf946;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fgPeIHsM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmx5-0004WT-GX; Fri, 13 Nov 2026 03:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <himanshu.chauhan@oss.qualcomm.com>)
 id 1xRmvh-000308-4D
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:47 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <himanshu.chauhan@oss.qualcomm.com>)
 id 1xRmvf-0007VF-A4
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:40 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD8V1Sq3826891
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=oN6mXz/c7yi
 x4xzGlnsgM4bOUuCxsp4u/erF+z45B48=; b=IYzlf946wIX84WC3YFUI73FNB6f
 RN4SVqhOC5lgAQdJHN1ULUr/UrM91DQ/Ju/IXXRsJAyutySgp6x+D6cXgHCHKUfs
 3ZEF7dquMUe10HBJEc0R/Cle0KtwgFyl2EOQcupTHrCuaJ65fdpfU4nYHAa/5lsy
 GpoI5CaSi7OFklAKdhpIIjLrVkLpV4ENAI+BujEm0LdvfozK3YfUqLcqdRIt7SKD
 otiJ6oVR0z7EgWrxQ0oz0JARtXOjCmkz7l1WOQzJVkbrgL7M08VreQxS5uzIdaRk
 rJGuvZqT+w0SNHck4kyZCbWVCOcjxV+siTM1XvNPXbEpGRPgLMQ0cyzB9/A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwv37gs1d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:46:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3724667bc16so422203eec.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 00:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794559597; x=1795164397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oN6mXz/c7yix4xzGlnsgM4bOUuCxsp4u/erF+z45B48=;
 b=fgPeIHsM1BQeEcv86sSiCp5l/8gTyzKKlLZV/oj96ws/Nec7MZD6flIDDULUwt+QqY
 Fm6EDxxiqFr4Pia/UZct0BwAktpTeXwjE23CHrRdUmuNUj3jke5u7ariv3t02Do/LtK2
 8K7nzgMAy17dmng4FuuBn6RZhkehQxyqVB6qsMQgWRhktwle8Ly9opLxD4/2mc1PztLH
 djXhwqirUhtVAvtJf//10JaoJ/5ZoWD9AYIWhm1DeR4iJPE/x/jlUqlbsBD5Ui7Rni9i
 cIGQaQ5bxOrSxDhZkTcMzlBADsRq88jTX6g21wIEJyW3nQTrGMTAVWEoN2SpPdFQUCYq
 OZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794559597; x=1795164397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oN6mXz/c7yix4xzGlnsgM4bOUuCxsp4u/erF+z45B48=;
 b=i5VZeNCT5fH4TKnIqzt234l39wFfD7UmoA91mapn/G1lZJlDVfjQ8W7+chyrIc9j3K
 /rxA9ElsmoJp1k1Bs1JQwor71VtdnP+FvyAAK0zN0EXtmezYwJSaibtrFFLsWhjh4VCP
 RMlPU5KOyn1cymZyj+VMGOIb25t5qpFTQvGQ6cdIAFiCk2382yHxc/ftEcWqNaBtEERE
 co6sQDscucq8Qfnx5SZoMiMpHrqcqblRhL4C0n+QkjzddJA8s/C75wmQ3XY9nAIPlSOe
 lwWlQi6VUho+3JWYNUVVXwmEBTks7SrtL2DsElu7AFfkNvbKh7FiIpRQARCKb/zHMMar
 807w==
X-Gm-Message-State: APuU4Z82RzKutxsLL2Pm1E2WgWCGOrw6UyHydS63+UBc4ZxmKZbf30AO
 3jqtuqc9/u/RKNXpNFpaJhWyY+KdZEOSwGDfDJNfHPLFh8bPxgF0AVOMA7mzmfECJfMo4qSSVX0
 kkebse1kPQay3mYmpY9vh+zTnZv+Zr95p8dCkckwaiC3B1GcJQbfocuhsMXcNRFo35g==
X-Gm-Gg: AYBFou2g3eIleKKr4rUtzYjMo06U3kyoGaWEf2+l4Ds7mBh+xf3nGhRACdKF2eEqrf4
 ZVxNpti6xbSiQfrc5BmF9gIjH2qxnPJ71Jvj/WV0G1/h6KAWsEcjZ8BtPnugidPseFqL5ExmHPu
 XeqwnuDvLlaIuCd71yrYYb94ClLC9B2Go8JD+h7lDinrWKajXUAUXk8lxT4jqEu0obu/j1s+fp5
 x/bd2lGI2rM2GjIFC5RwAU3arIsQbatYOb4G5P1xFUXao0rrPOt3F4GWQTbPoLc9mltDbHLY4rF
 fTOfRKX9d/IVLTob+1ZHVg7SjFDGK7Kw6E5NRAlhaD735uWQ2k8HZE6dt+p3PBRN5fa5e1ijqjq
 /1D5B3aFM58FnmOLfMPVy1MpIfAz6NC6sDdqLYxkovRSfdAiPBiwSvtoDEf4v2chS1JeyJuiw7k
 tqpKcLnzEfR0u3qfTaJKt2rC1XOUzchdCbO1Etde/TtMSxVw36EI9TuUayUEzQP2zoGufAnKQ2
X-Received: by 2002:a05:693c:41dc:20b0:36c:a1bc:6102 with SMTP id
 5a478bee46e88-37960385e62mr1635992eec.0.1794559597204; 
 Fri, 13 Nov 2026 00:46:37 -0800 (PST)
X-Received: by 2002:a05:693c:41dc:20b0:36c:a1bc:6102 with SMTP id
 5a478bee46e88-37960385e62mr1635972eec.0.1794559596686; 
 Fri, 13 Nov 2026 00:46:36 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379559189e8sm5689242eec.11.2026.11.13.00.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 00:46:36 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 1/2] target/riscv: Keep tdata CSRs available for disabled
 slots
Date: Fri, 13 Nov 2026 14:16:21 +0530
Message-ID: <20261113084622.738278-2-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113084622.738278-1-himanshu.chauhan@oss.qualcomm.com>
References: <20261113084622.738278-1-himanshu.chauhan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX4y7GOadqfz8z
 tvptIENw2uBkBBxxr5x6V4LLHmI5Jo4f9ixjdpiqmOA3A/2hmMb67fDEMSw4m2kMPD/DP4TfiNR
 NvX2X54mD+FrOe3xVTziVsz5cRhwoW8=
X-Proofpoint-ORIG-GUID: luh694NahCH69Q1I6uN1g0EikHUnG2-v
X-Proofpoint-GUID: luh694NahCH69Q1I6uN1g0EikHUnG2-v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfXyxVOrlWAfOI/
 WUyNSTO6Dmxrp5oeNBGxEX881G5XREDJEcgHipC4Lh4iwsTUI44eH9ZYq2XYz72kcK4sd40n/QO
 QkV00OzAp74JieD3CEetOEYDi+lCC0rP6qnE/XlYnUy3HuIq5HoiJFjf2K8Qyfh3pUGYv4Z2/y8
 9dpXeDqBjECdp5zGyZfgIc0wlgu2cfjuWLzupBpgQsGIr9P7MuMPoScfEfwGtOLsc/SjTAMUTFi
 hnShBxcvkSgX1C2kmYdoWOBiS1nYPh9QNir8zZXx+ustsfw9BRRVI2Tg7FMXNszG33LPc9xiwJx
 kGpN+tDSdt7IHhDExoBMUZG4hEUqpxl3r+1p4h9EPThyhnYfE/9/NgWQf0wEcLSFisd+2DTVahU
 dFHizyblChKFSpg0JdqCgqczUd8oflz750u/wa9hBKdFeGNZgOhfLrugjfQ/u78Jyyjv/Tk5SjV
 t+ncW9/sScsyRY5tbfA==
X-Authority-Analysis: v=2.4 cv=ZeeIpcVA c=1 sm=1 tr=0 ts=6af6ce6e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Dl6hwa1UTsAzBJgR6sYA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130034
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=himanshu.chauhan@oss.qualcomm.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The tdata CSRs belong to an implemented trigger slot, not only to the
trigger type currently selected in tdata1. Writing zero to tdata1 disables
the trigger by selecting type zero, but it does not remove the slot.

Keep tdata access tied to the selected slot being present and let type-zero
slots accept those writes while clearing any active breakpoint state.

Fixes: 95799e36c15a ("target/riscv: Add initial support for the Sdtrig extension")
Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c | 50 ++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 8b58cbd07a..2067657c81 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -53,20 +53,6 @@
  *     1 |    2 |         tdata1, tdata2 | Address / Data Match
  */
 
-/* tdata availability of a trigger */
-typedef bool tdata_avail[TDATA_NUM];
-
-static tdata_avail tdata_mapping[TRIGGER_TYPE_NUM] = {
-    [TRIGGER_TYPE_NO_EXIST] = { false, false, false },
-    [TRIGGER_TYPE_AD_MATCH] = { true, true, true },
-    [TRIGGER_TYPE_INST_CNT] = { true, false, true },
-    [TRIGGER_TYPE_INT] = { true, true, true },
-    [TRIGGER_TYPE_EXCP] = { true, true, true },
-    [TRIGGER_TYPE_AD_MATCH6] = { true, true, true },
-    [TRIGGER_TYPE_EXT_SRC] = { true, false, false },
-    [TRIGGER_TYPE_UNAVAIL] = { true, true, true }
-};
-
 /* only breakpoint size 1/2/4/8 supported */
 static int access_size[SIZE_NUM] = {
     [SIZE_ANY] = 0,
@@ -165,13 +151,17 @@ static inline target_ulong build_tdata1(CPURISCVState *env,
 
 bool tdata_available(CPURISCVState *env, int tdata_index)
 {
-    int trigger_type = get_trigger_type(env, env->trigger_cur);
-
     if (unlikely(tdata_index >= TDATA_NUM)) {
         return false;
     }
 
-    return tdata_mapping[trigger_type][tdata_index];
+    /*
+     * tdata CSRs belong to the trigger slot, not to the currently selected
+     * trigger type.  A type-zero trigger is disabled, but the slot still
+     * exists, so software must still be able to write tdata2/tdata3 before
+     * selecting a supported trigger type.
+     */
+    return env->trigger_cur < env->num_triggers;
 }
 
 target_ulong tselect_csr_read(CPURISCVState *env)
@@ -729,6 +719,30 @@ static void type6_reg_write(CPURISCVState *env, target_ulong index,
     }
 }
 
+static void no_trigger_reg_write(CPURISCVState *env, target_ulong index,
+                                 int tdata_index, target_ulong val)
+{
+    /*
+     * OpenSBI programs DBTR slots by first writing type zero to tdata1, then
+     * writing tdata2/tdata3, and finally writing the desired trigger type.
+     */
+    switch (tdata_index) {
+    case TDATA1:
+        type2_breakpoint_remove(env, index);
+        env->tdata1[index] = 0;
+        env->itrigger_enabled = riscv_itrigger_enabled(env);
+        break;
+    case TDATA2:
+        env->tdata2[index] = val;
+        break;
+    case TDATA3:
+        env->tdata3[index] = textra_validate(env, val);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /* icount trigger type */
 static inline int
 itrigger_get_count(CPURISCVState *env, int index)
@@ -995,6 +1009,8 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
                       trigger_type);
         break;
     case TRIGGER_TYPE_NO_EXIST:
+        no_trigger_reg_write(env, env->trigger_cur, tdata_index, val);
+        break;
     case TRIGGER_TYPE_UNAVAIL:
         qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exit\n",
                       trigger_type);
-- 
2.43.0


