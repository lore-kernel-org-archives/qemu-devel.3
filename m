Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8439C44514
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLKE-00039D-Ro; Thu, 16 Jul 2026 08:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLKD-00031J-A8
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLKB-00079B-Mg
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:24 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBiMWp2637086
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xOMAENftPDT
 dIMAyjHhGBMJXVoQqIYtsgYzFdOIVgm8=; b=Uns8eWrSezoS/0X4kCgD1Kcy3G3
 5tVOIGRtYjfTJgbHoE639b4g5920jU32UE80s9Y6JcwcwpmHRGpb8kvtanoA+f6l
 Fa1qS2LEhcpo+mtEm4f0+V32BU3FHN7fi/leDu7FQARPGHsBOay6uw5jZqAzPHju
 Egmat4+2vOm+Y3hA91pWb4q7f4O22MbwU2YHyV/T+KQf5IIKf/8m00kP/rt5/P6f
 RAhksYuGO99lhd5F9IZw6NfrtFT8gsis9pY+I+LjBFyHibjMfi+g6cW60PwCKFxY
 6gHlpcSg7RgMC5VbKM3ki2gqjcwBomhM+UqFpg7awTxA+J4dFoh2yYWcKMw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feuex13es-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:22 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ea75996387so161612346d6.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205382; x=1784810182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xOMAENftPDTdIMAyjHhGBMJXVoQqIYtsgYzFdOIVgm8=;
 b=TxS3uPa3OA3Y7ehgAXJqYqC39AajMQ5cJtTiQEswZw3lYe6S5McdMgSvz7bYhxasdH
 hMeStiZKRg950zOSkpMokr1jepgEk6tDgN0x2XfZD+NvB+Z1F9/tSF07/QaGX+fx9RGn
 OmPdTEFN56FLMtRqmFkIstrASPYLVGLbQ2nRL8ns7GcFR8KZEySXErJ1sldO9KFktJek
 ByyUjIEydeIFqn6BHnKnROVn2/Mw8rbp1KC1Ia+zXya4XvjQjAuJilEraMWYGaeVInE8
 byhWecHOoWrBuoPpOqW3cesLwrXR9DpTRzHt59GTIg2lybkfnN1xm7WGV2+AGnVdxAOk
 WoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205382; x=1784810182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xOMAENftPDTdIMAyjHhGBMJXVoQqIYtsgYzFdOIVgm8=;
 b=Pyac8DItegv8Yl1nXDLGNWUN+GD8T0pfWPoQJKr7/JeHfXggDHBB/sEzph2vprNUSA
 lYCm1X3nlSEvFminlfBm0HDkU/vLYKn68EJ5zRRhKpPuJPj7ekO2h6CawHFUGq6Xclyd
 VXjCHSvGuoEwgtasDlZ8eReb5D6QYvoyNn8/0gLZ8ccfMNCNiOmvFNWV0U/3uxmInq8y
 gh7xI27mXHrCan/BGmUZpiOU6jkCtX3ke/PpMr/3xaTJyPs63hDib6YoK81RY2/o1Oi8
 ZTM0wxEFH+1r7dICw0jfUqymD84qxhXxXNzROVazo61AAuusTeA4XDmrHq7znhFCB8rI
 cpig==
X-Gm-Message-State: AOJu0Yz4skA6XK+EvCOkRp9pZBJNY8bDIiVZlxvgqV+3GxQW3jm0kzUe
 ZEMf6UWLTveedwQZEcLjpzRFV9mecggB/RYM4QXRR77bmqYUqagAf0Lo/PIICBgqwoQ0/7rl/P8
 LdK1UcnaiE6xWuglpLeEdl/FCdFswVXBSPYDDgAq5Nro55PbDPmj8wnsKPkai0jzJTg==
X-Gm-Gg: AfdE7cl+hf3qvoVaszViTVUNFsyTcXLdcOFGf4fPWVdFWbS6YLP99u8UKXrvmF4dZYQ
 wKbvk28XB4jm5sNOyODR4etTpX0OsMp1dbPGreNysOtBCRaWiti7+4MFl2ivJzOuF380HIYuNAW
 I06QbG3h8HEg0dmMQWE13bYDvz+hhBtXdrPtGNDz+uA2kF5BgIqwiR4gR3JpuQLUF3J5/VVnHRx
 CiXzd9i6aPpPaKPZ2RaTQH7HwA8xeAiEvEbtXA0h8n51NQISV8NM+gjpU0Z8QrY/GNEmnWiRgxL
 yO4J365MkwlirphUp2ow9YAmYNsGSDFoM0xdkjLIqst9xkDhKIqlI1rzLBUgAt6iG2zAS7kWWDQ
 QZZt1X/OuIJ//48GFaVinW0yqiqLjZCLHvAc=
X-Received: by 2002:a05:6214:61ca:20b0:907:5c68:54d1 with SMTP id
 6a1803df08f44-9075c685694mr50836296d6.18.1784205382187; 
 Thu, 16 Jul 2026 05:36:22 -0700 (PDT)
X-Received: by 2002:a05:6214:61ca:20b0:907:5c68:54d1 with SMTP id
 6a1803df08f44-9075c685694mr50835746d6.18.1784205381572; 
 Thu, 16 Jul 2026 05:36:21 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-902de1fdb3bsm191609316d6.23.2026.07.16.05.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:36:21 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 npiggin@gmail.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH for-11.1 15/17] target/riscv/debug: Advertise icount trigger
 type in tinfo
Date: Thu, 16 Jul 2026 09:35:32 -0300
Message-ID: <20260716123535.3709148-16-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
References: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JeeMa0KV c=1 sm=1 tr=0 ts=6a58d046 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=NbQ-Mm45WIPNpU4tq3cA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: 1oiP0ygXI1sENsd51PoX-SAW0waP-aJ_
X-Proofpoint-GUID: 1oiP0ygXI1sENsd51PoX-SAW0waP-aJ_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX6/tlDDOt6t9P
 BGnVLJHxQEj82bBZ6Cb3qGHc9DzUsFfdSpFRadp9jVMvf3D4uNfgh0+7UUfFaHGY+4xHlg87CTx
 /o7/UoNUhfRU/zs8z5p6fmBa0YY+0FY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX+3jyydCb10zf
 yBHOtiqJ55Ncv0qEghwVR+KedC8RBrg7IepYpiXq7JAHjOigWRqmpjv5CGdIKEYTcE+Wxdv4fns
 S2lXylqaJ+YsxQx7UGr0FGtnWhPz8xJilQOYKA0e7MQu1I4vr+Xn229z93a3SEFGAg/KA2CIjzF
 wCaaRbh6Rh8hqGCps8TdG0UlO0rFfaanGaecxELk+VgSIvPqm/BGNVxxInenf9+6muqsQOn7X7T
 9UvyzKD1HQ3qrAjczAskv6DE/ZUY3bLPURO2fCTg0oaze3702JQmAts1ZVlmcuOGjkTv23eWzWP
 T8VUh2uYHOSFQQlKTYDreDDgIebjRbMy8lXTu/x5G7Zw+Byh7U5AsknNHx1x5O8K61ZUMNmYnz4
 OTZbMG7TdaHWxEK03mo72C6qjQX/9xWaObCBqOETBig3Nk/Nc4LFbP4zUZ5+L11+xtaymo5jhWa
 AWXQrOl2YB597SfgFLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160129
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Nicholas Piggin <npiggin@gmail.com>

icount triggers are supported so tinfo should advertise them.

Fixes: c472c142a7 ("target/riscv: debug: Add initial support of type 6 trigger")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 09d4cc03f9..9089d2ab78 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -958,8 +958,13 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
 
 target_ulong tinfo_csr_read(CPURISCVState *env)
 {
-    /* assume all triggers support the same types of triggers */
+    /*
+     * Assume all triggers support the same types of triggers
+     * TODO: set 1 (version 1.0) in the version field when we're
+     * ready to support it along with 0.13.
+     */
     return BIT(TRIGGER_TYPE_AD_MATCH) |
+           BIT(TRIGGER_TYPE_INST_CNT) |
            BIT(TRIGGER_TYPE_AD_MATCH6);
 }
 
-- 
2.43.0


