Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AD2CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdp1-0005cv-UL; Mon, 11 May 2026 23:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdoh-0005UG-A3
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdof-0000Im-O4
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:55 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6NEu1183918
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mTPg9Tf7ifW
 DGss8sKFesSmkWVGzI/NPJAjDNZ2kTdc=; b=DaKAUuCEb3z0kkSn+QZ56OA/tAu
 x8V0A8LdTf/KGVvTeVX0k9SvyKXXstL/dtULoddvKRPqYR9IfsLk2pa+oWMfSuWB
 PjT+p0BfKXMvldyFveqYVz/1vPWj+pwWAQQ24I82z+WRJc5cakGHl8STHjK7u+b9
 V5rEe9Ztd4ShjS3OdW1UXl205zGOrWCnmRsD7t+muTpIKRxTG2u4Wj0s70ovvvvr
 s3Zqv2IHu5gGkEJ8jah+HjHukBzKmuUiZr/MqyhO0wKk5HFyvyvRs7NizppRlGR8
 TF7GyAf3+T8DFRKest7eWzygeRq9MRPNp1taxttbwvJ6EYYPxrAUiiSov9A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nuy98wm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:52 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2fded513994so5355968eec.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778556591; x=1779161391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mTPg9Tf7ifWDGss8sKFesSmkWVGzI/NPJAjDNZ2kTdc=;
 b=PaXFeBJDxz6x4dDTISP/I6BDzolc6hrFpNlIW+nCmC84hhfJ4EFRQujP9F/u2La9rY
 CDgrxS/URrJu7tRaav4m7gFzmEZGU7VVfgoHsnyTATWRTX5lpHM+6cvZn6KyzgTrHHAX
 joG9DVGwk7kbmH7YKsp64Jo10jo39oGqRsCWmqNSM5ChQ838EWj9xJn5rDHCZg93hsSn
 Wtw6HgvIDyBSTXXEvO/jQ6UyfZYuT53xqKW+4WQ7L9gmkHtAATL9+yzqG3l5g9y/lSN5
 rDDmJCBwH7nobcISn/ztZ9qyZi29wJivt5BAbzPE8+aOSYBEAlOORSOmUYD8hfI/Fq14
 xB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778556591; x=1779161391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mTPg9Tf7ifWDGss8sKFesSmkWVGzI/NPJAjDNZ2kTdc=;
 b=KEwieFUj+I55U9RVEtguczu5zzwqjdSw8ol7NOoYl5x+NjKyE4R84lbNAPCng32b2C
 QGinxxz2Ew/E7FBEGj3WDyr3kEz1zsEwd1DoYlBxd8xBKor7F/HM1CimFX3rRNDHEYzd
 ZhBnME3MuPHZsFu9RQGatU6Qct09klmahEz0E/UnpoNqRG4B7hi62cGitiVXrJa+MHoe
 HsyPyMLn/N85r5hojcfIWsZgjNXhOgSK0d6DqWAvAprXsh5k/M/yd8mGdmWDWcv13OoD
 QztxD4V4PvYlTbiakh74EUgQKs/huM368CqSpEUK25AWaxOwuyrh2VKR+dR2JQ9A+Mb7
 yRsw==
X-Gm-Message-State: AOJu0Yz/wdkoSTjjQcTHvNbNNEP0moGYvuvJPVl2T9c/UsOEg7HMG5Of
 MkfdIx+bSztPZQNIOHD/Yd721Vnow5gKrrKcyt3b5R1CCxRg0s8BJNabJCEi41PhJcUzHMXLm4w
 V/MSckoA1htF6IpaPUTEEBLpclYQFa0QK406K362NFPtBXXGqnDOTB0zzlCbETJ727Q==
X-Gm-Gg: Acq92OHxunS9+dYWpAozSsZWpbA13ix5O71QpsVms5CQua32Inn5yMt0VYtFYcMCB/G
 Mb1r6EcGJAUBtXBKG7/Mhl0H7WSVbgfv5D/83zNGms3Mj5ByLAbn1YlwgdMLLcZWtvRjJcFzqfO
 UQe2+2O5C+qrO6wQasRQ7Wsf41/efpNS2UQjPhf0G+frIwVs4X0ZOSYXMmxNMwCzZhYBQAJWrpR
 UVEmPIDIXtD+zYvLiLhL38z2U3iPja0B6HK04Oc+RgJoXdRrsM6MkPqQoDmgTrty/rkyWu86qSc
 z+LoSFTvzWDyJ3W+zLAZJfRt0cOBO3ovEIhjBqC9eRo/Pqzg0OidRVxGjrnZn1pk86rbOp/XsVr
 8y7fXKm/Se+RY5SYN54a3OfBgl0uml+Wip6WtNFnp7UqjF70iDFQPdzmq0f6y
X-Received: by 2002:a05:7300:b919:b0:2e7:120:137b with SMTP id
 5a478bee46e88-2f547f6f1a0mr14743074eec.0.1778556591162; 
 Mon, 11 May 2026 20:29:51 -0700 (PDT)
X-Received: by 2002:a05:7300:b919:b0:2e7:120:137b with SMTP id
 5a478bee46e88-2f547f6f1a0mr14743056eec.0.1778556590727; 
 Mon, 11 May 2026 20:29:50 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884750ffsm16054317eec.19.2026.05.11.20.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 20:29:50 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 08/14] target/riscv/tcg: use isa_edata_arr[] in
 riscv_cpu_update_misa_x()
Date: Tue, 12 May 2026 00:29:20 -0300
Message-ID: <20260512032926.1978818-9-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mbJlCPiauWthZFqGkap24YKZNo8Z0YR1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyOCBTYWx0ZWRfX2+iwP+x38SGF
 MtDLFBGiVD8PXeAsINAKUnCz9p8hNjig3MMF+GbJVO+E9jJ2myk4m8jeaEXMdOSRfGjK4FUg2Sn
 iVJT9Ai0tAYQU2gy1WwHH2HfEEKKqyIMggAk/jNkOUw3sZ4LZumwBJQmZuXvvStWHkdKD2jZLeX
 cM7510BX4bjH4DZs0ozlr/8Fngn1t/C/gmRwkdxVu1F7rv3j32leyl+aJ9Pl22eHJyDrEOyZhOI
 1ACOWWnJadowe7HIcSiP2JdYWPTsmZei288nENnUiXS7PJdtMCL81l8ikWsrWbymBmkqDt76m9B
 U/yC3Km8kqcEoGilt6Br2U7+6VKGAnrJzmKoAOyhcZP7Mwn/2h2ldlpGc4r6YEeg1o+OpZZfYgw
 dYbf1au1DD23vGaOPpbL+3Sl7apNHT2auGtU849OOI1zq1e1uSEHuCuR4ncrdW463UVXdVpZuu4
 kYmup8/YfvVrk/e+1YA==
X-Authority-Analysis: v=2.4 cv=UZ5hjqSN c=1 sm=1 tr=0 ts=6a029eb0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=-wH2MJB8CLgRmXORNoQA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: mbJlCPiauWthZFqGkap24YKZNo8Z0YR1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120028
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The non-standard extensions, in this particular function the vendor
extensions, are all riscv,isa names that starts with 'x'.

In theory this is a bit slower than using riscv_cpu_vendor_exts
(isa_edata_arr is longer) but riscv_cpu_update_misa_x() is executed only
once during finalize(), i.e. not a hot path.  We're accepting a tiny
performance hit as as a tradeoff for the code simplication we'll have
later by removing all riscv_cpu_* arrays.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/tcg-cpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 8dea22bae5..b7d59f40f2 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1155,10 +1155,11 @@ static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
 static void riscv_cpu_update_misa_x(RISCVCPU *cpu)
 {
     CPURISCVState *env = &cpu->env;
-    const RISCVCPUMultiExtConfig *arr = riscv_cpu_vendor_exts;
+    const RISCVIsaExtData *edata;
 
-    for (int i = 0; arr[i].name != NULL; i++) {
-        if (isa_ext_is_enabled(cpu, arr[i].offset)) {
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->name[0] == 'x'
+            && isa_ext_is_enabled(cpu, edata->ext_enable_offset)) {
             riscv_cpu_set_misa_ext(env, env->misa_ext | RVX);
             break;
         }
-- 
2.43.0


