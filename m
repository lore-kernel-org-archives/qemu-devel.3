Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A5DCA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI2U-0006sC-Lq; Mon, 01 Sep 2025 23:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2J-0006Te-1F
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2G-0004ve-Hc
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:22 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SgZ2016289
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t/+RS/dILureKsj4+zFn/U26oQZlnVC8JXhx/wheCqw=; b=BQL67BfXcRX7KVBO
 TsYwlPVImOOKQfKyAueCvcfomLnIeDkUUj2/Yebz/cFgEsMmaqbSDPO5lpSaZq5f
 3TDbHkwgteV4WePJXtwP5CJN0T0WRleeOrd74mkBuDJZWDgj4IAyHOVsTavokD6c
 hz5fpAPXuCCZdOr9DIDCZq4vc/oL7FtkBGysgW0HyV1LB3WNwxs89SEswxoIzfsW
 hb4GdL6SfRktPcDjL7Sklhig6aOUKYeasMfiHfFfUdUW3VAFxSSf+kfn/e1lBrFv
 QQpJeoYUtBUbhD1yuujj5BzKzJA7wqgWHlO/iBWHNkwY8M9IXARoP+33gYmKNTjc
 IEdawQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urvyxdnj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:50:09 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-24b0e137484so3703945ad.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785008; x=1757389808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t/+RS/dILureKsj4+zFn/U26oQZlnVC8JXhx/wheCqw=;
 b=Da+mzxaFve4SIxuXzl+Ohp8X51Su6/LYvRn5YltHmoWv1Xm3rwsxbOLFFn+vAmhIST
 TPREk0M8qfM1E89/rY3cgmXP/MiPPGwpb26yWkyjQtXHkPkPMb2isiJkE57EfyCGY6I2
 BHZwaKP8Rtq9/SgvvLhScWfIkz/DR/1DZ//+Vr6/iZI0BqutTC6GsgqlsiKW4gQ1fTIG
 THXh5XAJmIxUFSRxGtsg6K3t++1+wJtUn6We+lDYsP6YV7eBBp8Tk6jSmobLsksGBUS9
 YNmTGJUCRxBkSq7AIkUfvqHaqMdUe7tIIAjStj6ApREo95FKMpfUjwrl58JYgMCUWzWc
 ffbw==
X-Gm-Message-State: AOJu0Yyry4bJwLun4eI9AZAFINBtm91G8fpg+5SGHVD+OZvzUeMnQdkE
 6k7jcmoS4rqEqCTEniJbB5FvUY+0E0px6KfpcDDHz98bp13Yl+QtjsTofXgC7mQDj/CwIRfVesN
 YeKUjSyaXWQxVjIIVlO3hwoVUt+A2jfs27hH4Ep5Ho4TzCzG5bJ5Z4ahh3cUSXqqtuF34
X-Gm-Gg: ASbGncvEnL3jB8yd2aKjy37QLoK5x6tFVjuKFMaYRkJk8Vq5iTV1x7Kjj4UESE4AvEh
 b8x1PjPl/XdvaNbNX5FKbpZoCU7pKSQqj0rOP54HKFFrzWOwDGGSO5AIQTeBJo0BGO2rVFWTRYZ
 Dx8ZP1g/82IT6kc3r7YSCrDK9CEyqa/bPTkj712CBmIYhMX4m6qc+akfnCaGo6xBrl/yxAv/Z74
 WGtBGMs+wPGPXSVaIzUhzGnCwEUc7lqcU65K4jqarjca/3bmRBY2v/OE7otP0YF6lfrrn8j7Eul
 igipwMhPHac6LkeYTcar+MZmuyUDXGqufMFUaj17JJJ+trWQ9ml5CxwHEaMzwP90eS/+V41acic
 G8aNfDe0KX/A2
X-Received: by 2002:a17:902:c952:b0:240:44a6:5027 with SMTP id
 d9443c01a7336-249448d6fa9mr131692235ad.15.1756785007962; 
 Mon, 01 Sep 2025 20:50:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqzyi589CngXXKG2iJ3O0Px5SeGGafxjLxTm8U23puJsRMaepd3vBLvbB24J1E1nGxiQ801g==
X-Received: by 2002:a17:902:c952:b0:240:44a6:5027 with SMTP id
 d9443c01a7336-249448d6fa9mr131691845ad.15.1756785007486; 
 Mon, 01 Sep 2025 20:50:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327c5fc5055sm14117932a91.14.2025.09.01.20.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:50:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Sid Manning <sidneym@quicinc.com>
Subject: [PATCH v2 05/11] hw/hexagon: Add support for cfgbase
Date: Mon,  1 Sep 2025 20:49:45 -0700
Message-Id: <20250902034951.1948194-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
References: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wmpKYHGpxLRKamlYdmCmy-PPeNFJdkOp
X-Proofpoint-ORIG-GUID: wmpKYHGpxLRKamlYdmCmy-PPeNFJdkOp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX6n2kEppgXLBt
 8N+SKabuGP+XetWy5+FNBM5E4Sn+mWTEcOWUszhXJFdxc2V4I9UmgLEtW1nFEWYvr/xARk4NN3j
 8cncgZUPj7rF1m8s2NzLC7rXJ77m8n/v0D230f6Y0yRK259dg3PRDqkT0kZXmtIpBjRL81bkSyi
 To+tXn0Bk4M9EKQ+fK/RJNRVmYX6VR37QWBAjKSO8O4xVY4LI0M277M/zws71x5wWWgdCi8oify
 R1WxTuhbNPQ2tY1X0pFuDqILR0nmffT/8Jf1s4VX2KxGgoTEHrNy0B6wQWyjVQj6nhJcLt2wXZl
 Y0aRpD1u1g7jL0J6F8LstNIVa01aK/nulJC0OJAMTSPWEr6GHMUVrXs5DNaB4ZwDz5C4tE3paDo
 DJFty9o6
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b66971 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=nfi2BKWVWryVphq1m2UA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sid Manning <sidneym@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Sid Manning <sidneym@quicinc.com>
---
 hw/hexagon/hexagon_dsp.c | 10 ++++++++++
 target/hexagon/cpu.c     |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
index d491a21a76..486dc41f5d 100644
--- a/hw/hexagon/hexagon_dsp.c
+++ b/hw/hexagon/hexagon_dsp.c
@@ -83,6 +83,12 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
 
     MemoryRegion *address_space = get_system_memory();
 
+    MemoryRegion *config_table_rom = g_new(MemoryRegion, 1);
+    memory_region_init_rom(config_table_rom, NULL, "config_table.rom",
+                           sizeof(m_cfg->cfgtable), &error_fatal);
+    memory_region_add_subregion(address_space, m_cfg->cfgbase,
+                                config_table_rom);
+
     MemoryRegion *sram = g_new(MemoryRegion, 1);
     memory_region_init_ram(sram, NULL, "ddr.ram",
         machine->ram_size, &error_fatal);
@@ -136,6 +142,10 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
         }
 
     }
+
+    rom_add_blob_fixed_as("config_table.rom", &m_cfg->cfgtable,
+                          sizeof(m_cfg->cfgtable), m_cfg->cfgbase,
+                          &address_space_memory);
 }
 
 static void init_mc(MachineClass *mc)
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index ba78a04bdc..6cf9250b99 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -405,6 +405,8 @@ void hexagon_cpu_soft_reset(CPUHexagonState *env)
 }
 #endif
 
+
+#define HEXAGON_CFG_ADDR_BASE(addr) (((addr) >> 16) & 0x0fffff)
 static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
-- 
2.34.1


