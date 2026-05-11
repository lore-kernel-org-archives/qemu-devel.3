Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8969ACD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQhX-00017X-Ds; Mon, 11 May 2026 09:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhS-00013w-VN
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhN-0007bS-9Z
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:30 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B8I7Bn1850699
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Bjp1sgfxre6
 nCi3ara2aT0wWFV1CJrM7sYzkdeuhS9E=; b=d0Zrax7/JyqPhWuGFb19EnHaTXG
 WIdlZwKisyvY2nLID8TxEVC85dlsqaedcKGVhDigKz9CqAhMgLUxDk30ipuilD//
 KtMAZ56A+5BY6O4t6TzWOp+9/9U5YPXiWHYK3o/x6hmyN0QdPdRIPrltrex7vWdA
 l1LAxofp5zIGs6NrVpWR5MIuvgJBTDkFBHzKbqUcDqMJt+kQ4m1ImSYdOzDnVqRz
 6OhhqASqdlMFkfnSc4qsaD5/zFHzLtqAjSFmt/tz5MAcm3f91T+KGc9Pug++fNLn
 nvfxmnPFfkfhMy2JRcVpUPBMyVv4l5NvuR6PZXDWFO6pele+kKvFcg5EPdA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3bfvh41c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:27 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b597b14a22so39649286d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778506166; x=1779110966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bjp1sgfxre6nCi3ara2aT0wWFV1CJrM7sYzkdeuhS9E=;
 b=FKvDlWNR2KDGM/QcdIFdezOsFpSFVx2GxEGYu6YZaQQXw47/lk5UnP6z1A8OilTOKq
 JtfhrXw1N6kGMS/qJH0QHvkcp0MULF5ps7wkxb50+mJ7EO1d1NWQ2tDvUwbNYTqVb1qe
 vknJJnpBct/Qnep42lPjKXkhtbYQIe+cGraEvLVSZwQxf3jGmzS0fx5Gk2aFM02y1aNW
 gtaPIMbL9ZqHmAbZoLErkLzy+cEZsLkeymGoZA3H3h21Vdx07dW6X1peYmSXo/7UE525
 U1vBMqDozxeyDcOeD7VfOBH1G2gvhJfUZmR6653oSI0ZcoPyMXCaQKfx4/myDiWrKpCF
 cEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506166; x=1779110966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bjp1sgfxre6nCi3ara2aT0wWFV1CJrM7sYzkdeuhS9E=;
 b=McnUteRP+JFIxqnNlni3oP5SxSDDZ2Fl91SaIjhYQYZYfCDUyJ6O5yRARa0iE3lUJx
 cdnIKcziyMTn62tFuNlQkHKINfELqOfQZ1H+2PUHUOLsf85SXAwXUnOii0RWuIU4GNSy
 cvhaEbhmxnWcaaCiMn17QB7QmllrX6avGoxpnx4LTze7/hWx+p61gSvKny35e9xHP2RG
 ipCWd+YFQehy1zCDRTa1i/eZ8g8TdtKYqedlgAQYGA9d0Go0Wcfxh1qmJavG0fL17Uau
 yLF1ZqAsmnptewLrjGXl7BF5k++a+/zRLx06bmhsX39CBtfF3luhBhwbJ1EcyaAaNfVm
 4KKA==
X-Gm-Message-State: AOJu0YyqIaznmz5uDAEY+LdVluFQ0sJiLqjeYwf5aqz+t+jZOqJWt6Aa
 fVqohYTHOsrkQf2c06yfI+IEerW3PMgIHayJ1mGT1suUpiiTJdCNHl7IWGiXL+PZL0a8wA1xpZt
 xSansm0tjbz7HMFc8ZrkEB7wSCg3zof0/vhfvF2cfdBcYx3ArHIJm3CThmiaP3YeOJQ==
X-Gm-Gg: Acq92OFw1ZMpF/s62Y+Q0zPLcC8a2PsXKhtg1Z3TiiRsR+SbLhJaAo3PgF8/Bbi24uR
 xpKR9CSNGfY1qjrrrxP6KeYoaenMti7YCP48hhEjeX621W7IHw8VNYlRbbjv7ovPTruVb3NA2FN
 iz2stcm95aaMAfK63Lk2ElNDa8ZmFqxW9HMYjzu5DqPbHk7B6/HAYNMvBD5nNYN2sMgnZnrtsLA
 yLM/fLs2W4iVL6362dbpHsBLESZSp4qFlpmo2LJAKwdL1rMmA4o8jQqcQPzhBHqRBfZgvWBle6V
 oycwwOX6vKP2mjANXVSpMvYiDTH5GFbLVKjG3asXQUXNMFfAeOKmy4HZVz475Th/qduoN31WkYA
 TVUujNkxM+JECVdqO71I38KzQMGMDkfxhL2ZhDszrYVmxj7fKPYC6ih2gcjW+
X-Received: by 2002:a05:6214:5d0f:b0:89c:ac42:e119 with SMTP id
 6a1803df08f44-8bdb749862bmr256505446d6.8.1778506166251; 
 Mon, 11 May 2026 06:29:26 -0700 (PDT)
X-Received: by 2002:a05:6214:5d0f:b0:89c:ac42:e119 with SMTP id
 6a1803df08f44-8bdb749862bmr256505036d6.8.1778506165837; 
 Mon, 11 May 2026 06:29:25 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c81b3fsm95250326d6.29.2026.05.11.06.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:29:25 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 05/13] target/riscv/tcg: use only isa_edata_arr[] in
 cpu_cfg_ext_get_name()
Date: Mon, 11 May 2026 10:29:02 -0300
Message-ID: <20260511132910.1738069-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
References: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Fa4HAp+6 c=1 sm=1 tr=0 ts=6a01d9b7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=rzj_1jqBoIplMVo_UVEA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: b-714ttszO4IeabYljw50wLyB5t8bsF2
X-Proofpoint-ORIG-GUID: b-714ttszO4IeabYljw50wLyB5t8bsF2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0OSBTYWx0ZWRfX84joRTzctKwC
 JsvVr/GL5PmL0Ava+BrRDx16/q+AIyHZUnBfi/ECEH3l+hsHRcw6xz/ZRU+sZavO+zVWXwEzqFn
 62eOjZQG5PvUTFqtIt9LBwQje/BVuPyx7cQtht9LmsQWYYvla7J24Es9LwShN5EgvUtfRkbNv+f
 shdFN14yuToDND3s7wnf3SIDhiV9Z0wTwExPfTyoRDpXpNohWs9vyukyNkG0ROJtcO0vTft9rKe
 q5jwXO4VOy7kQ8z8zqrq4JReFi8m1QWu7I1IiuD8/LO/uUxdynEgNLWfm0Hxtt2cs77FWviVuog
 +xksn1Obg04Eo0j+Hnfyd3Py/+CsXRZCYzCg+4GOBRvQpof+YYYK03ZXuzTyvnxUsqE32aHDU8j
 KLTG5Dsh4rTzGWLkfwPCp2mh4enV9/nJwe+EE4UB2DnAUagUHTdDmOx5LYpSiWHPwtcKDK4DqUr
 dGepHyvqQvYbHO2eUaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110149
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
index 492dde9f8a..dd058eb3d4 100644
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


