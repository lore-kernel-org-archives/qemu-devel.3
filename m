Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB159CD37BE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdob-0005Sd-9s; Mon, 11 May 2026 23:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdoZ-0005SA-Te
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdoY-0000GV-6w
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:47 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6Tx23443742
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ya0oQ0QNFTm
 fTOAMOGTepL5yKqAgtizlN80Sf1+uLeA=; b=Xd8vxvIYM0SaJbqIZCEfdiu45hj
 ieQvaDF1/C2akIrISmXPsScpli2FH7f9KaTctg8QMNHPg5fOewNmb1yxUZyYkI8k
 X09S0GAp/IogGhtPFtWnQ9f3ijTL1pAscYhVXc4Xip2szmOZDDzuP7HUS3yprzEy
 zRjalnhDrbPVTM91V5yhASDo7dEEN3yjvYxx+mX+fyI1ocwi48q+9dZs0Hf97arL
 HcDamtRaziCrKjDS+VdN7t951EFVWgVuyZGrdRB0OXZD/04rXfvOR/V/QVPTkrwu
 ZcHrLa9hKcO2JifmvEW2v3nIaZj/dKlRz/A2+plyEOMSfucXGrLBgWEW95g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0h8gg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:44 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ee1da7a13fso6635559eec.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778556584; x=1779161384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ya0oQ0QNFTmfTOAMOGTepL5yKqAgtizlN80Sf1+uLeA=;
 b=Hew+Ld4qjanH+H5gfgmuoj8nTBJ06PKmpugh+6HCTl+cSI/K+ppzT01Gtxd0eGl3p7
 rBUGY9VuD2QCTOGpGERIRBP67Nz3eMnXxBCq5EOG81R+XCslJEpc2EURzr0QcXT+ORo7
 JLtKQIzHf21pYCX+Ka22BRmIx6ZvvegjGw0F9GsosLYV6caCTDr7ZtxozbcUAGTc2Sk6
 AJUjYt3dl82NobMniNe81bR871gz3ftUuCKjjZFtj1abrN08ttjm6os9jkeXn8i1r2TZ
 NCD2BPcFm27KdoSmCdVk6WXzlRlTKoht7LWlirIlexZzEWfEjDIMPuV6oJCaaHX8zPIr
 c0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778556584; x=1779161384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ya0oQ0QNFTmfTOAMOGTepL5yKqAgtizlN80Sf1+uLeA=;
 b=XekC/9fX/k4m/iL7MnTPGdsKpn34KhyBc6p1nLH1pURDZHvZ0tOwAl74XEmSodxVti
 wxtRs8Q8Y62jYi35GUn6gQs2VNH2pR/7eBZTA/+zNPAZ2w1N51W5N/AZaGFqTIRln/po
 zyClc6iaYZNtZpA9xIf18bSomWX3Sntv0m3bN0yQ03+2fcw46XPTkEBtRPJ8pRCRuxT7
 EIB35Lx6Mj8dHm3m2OEFOXIa6qwuMwHk4KUSzHAHmkHiubBB5xlc2TPWDW4uDCE8vjsA
 133kyrOnRH7yTsf+bwFT0tHNZ2puOwK02EyXSdNzFyU2RG8FezPRkMDPzwWmlnx6Ng2E
 iDZw==
X-Gm-Message-State: AOJu0YxAIcxQIY/5RcAKCskryqAZKrnHgGGxD6hd7EPEeZqrnCupt7LC
 I2U5TfhKEhAFI/MdsDHeOnmJQk367ZFUwd0Yi0K75DeS4w3id+fndR4oO2xJtRn3oSfGorHGTXN
 1JxeX319rag0ZDSCSm5uPxR0iTc/lW5VCD67NE8fjEnH1J2DAbcV0CjjxcV2NeYwBIA==
X-Gm-Gg: Acq92OHD6LC9AVfO+Vm3Rc2rHIu6X+5yMPtErFPnb8SOvxI5/ucOyjF0rp2UVtVS24j
 hZGLeVUbYY+LMXmwpvUzM+jxJdebb5nYmyYwZXnhpPVXvIVUkD8vWPsM5r8whC2LRIKaxo14yJW
 vI4x5liAs5Cgz3tn0OkGRGY+zPpTd8O8ZSatOJdbx/10zke9QfkSaOFEabIrpULGfbxpEXkJlN1
 sSTAouYW0mTnQSFdDlcuSZaA3iLJwMaHJfkEQ41OO8g6L+GuLfAJpleRW2TjnAEBJ6EhmvZ3JFT
 0zbnTdnQwcI12/+jEOdRhCUBOMv3lW+3X8zq73vhjOz0G+xZGgCZ5++FvQuJFFd+A86lv/BGjg4
 Ytv9EdPPjDp5c6aLYEdIFZxT7X/O/JmUwHTBuFwd9LrG5CZd4ieiGPZnv/tU3
X-Received: by 2002:a05:7300:8622:b0:2f2:c336:7736 with SMTP id
 5a478bee46e88-2f550b4158amr13029324eec.29.1778556583795; 
 Mon, 11 May 2026 20:29:43 -0700 (PDT)
X-Received: by 2002:a05:7300:8622:b0:2f2:c336:7736 with SMTP id
 5a478bee46e88-2f550b4158amr13029310eec.29.1778556583284; 
 Mon, 11 May 2026 20:29:43 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884750ffsm16054317eec.19.2026.05.11.20.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 20:29:42 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 05/14] target/riscv/tcg: use only isa_edata_arr[] in
 cpu_cfg_ext_get_name()
Date: Tue, 12 May 2026 00:29:17 -0300
Message-ID: <20260512032926.1978818-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V+xNF+ni c=1 sm=1 tr=0 ts=6a029ea8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=rzj_1jqBoIplMVo_UVEA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: wp9PSZsVaQLFwSCn2pl6IpsRP6smxlsR
X-Proofpoint-ORIG-GUID: wp9PSZsVaQLFwSCn2pl6IpsRP6smxlsR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyOCBTYWx0ZWRfX4Uz1dRoSB889
 vCn1+TzuDKnKxdYwimqca120JVP6y77S+a+fJNvDVzPLP27pdREbe1NS/TR9uFn4aoMsg0F574A
 DlrUVG80SlNHuLl9DaswKXGIq1vR+BeQHhOWDi3R9jS6yaTWRXKccQhfuJjWqz2GWJVAVELXlxB
 ZAp7qlc+5fVN3NG1AEGpLYlCx3+SgLMu2rh8dRS6/m/1XEz6yoRiXC1qJp7XE4RHn/xBvLiZqGs
 1rT191ZUaWpEKvq5XyD31QQLrCclQrf3835GaNpGwfwPfDWx/RW1AvPgJr8ZTjObM1tqEQ8O0uz
 XOavfp/OyrPNGTt1uSfKLvxsNqkc9c4A0TBFUEk50aKubREiOd2G5NTMMBiG0Ap5U4X++19cItk
 YIhom/Y+sU/To3EyXsdFmRe3abhd6sg8Q95Cv8yc0XuMfdP3sJu3ONOHIoOLAfRsaBfkhQhXz+n
 Jl2mcG5dxyXZSgi82SA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120028
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

We're using both isa_edata_arr[] and riscv_cpu_named_features[] to find
an extension name based on a cfg offset.  This is reminiscent of a past
where isa_edata_arr[] didn't include entries for internal extensions.

At this point we can use just isa_edata_arr[].

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/tcg-cpu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 92406bf41f..704105d3df 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -311,7 +311,6 @@ static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
 
 static const char *cpu_cfg_ext_get_name(uint32_t ext_offset)
 {
-    const RISCVCPUMultiExtConfig *feat;
     const RISCVIsaExtData *edata;
 
     for (edata = isa_edata_arr; edata->name != NULL; edata++) {
@@ -320,12 +319,6 @@ static const char *cpu_cfg_ext_get_name(uint32_t ext_offset)
         }
     }
 
-    for (feat = riscv_cpu_named_features; feat->name != NULL; feat++) {
-        if (feat->offset == ext_offset) {
-            return feat->name;
-        }
-    }
-
     g_assert_not_reached();
 }
 
-- 
2.43.0


