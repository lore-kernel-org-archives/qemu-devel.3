Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75329CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQhT-00014E-3o; Mon, 11 May 2026 09:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhL-00011h-HR
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhF-0007T9-UN
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:26 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BC4IqS108024
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QqsjhQa6wXC
 EAmuLc30WAj8/J+uLGDsmHrfdtiaK2YA=; b=TAom1yxLti+cjBE64TjVfqSeIwp
 37vjCFCv05htX+rgmAHRAHD4Unyb907iboEu2lcSl8j5w2RT8MEn9sYej7Fjr8F/
 oue1XjDKoVUcNZWzOy3i+BFeqqC6b9VDt1tkO6TdqjLi+XNM/zW9Lw2HQsTFCRZ6
 WKBdH1r81rd15suU7RdnR4DKbZP9Ebgy3k361GXnfwp0WgHLgGR5ZNfpApRTJTZ2
 kYkY0HTssWpSLtNiYKDvMG7XSEq0RyROR8FkqqcaLtUWcMPjSaBDSO0we75QrcTE
 Su2nopx+vl8c6DSZPj7ihnRuiN1Jr2ku99LwxgnK3Y1ATZyN5BXoYYu4yow==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3esyr9v4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5104b861649so123536141cf.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778506158; x=1779110958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqsjhQa6wXCEAmuLc30WAj8/J+uLGDsmHrfdtiaK2YA=;
 b=FPZUpRff2AjjnlGLeJuirwKgF5j/WmK/QgPBrAZmWl6l2M3AZu5qwXVK7NUaI3073/
 LjPJzlb5qIu+zVxHf8EKtnKbApEqGw6NUNAd9GUeXrTo9U3seK0qGVMw1G4t2wzy/Cmx
 1GgCS56xBk5gAoRY1AvTmK2U0/VICFhVRJvb0cqJ+OCEgwgAHv2MfXUnImSVKVo47872
 p9eHoi4mUlfmk/TCpgYmoqrvrZJXJntutkPEtIkvzqhnQQLVZ19B9XXtEK+6n69Re7eD
 u1OLzLY+gmBiHkJ55OXVYXw9PuC4SiF3qyNX9fEMFWRUeDo8i3gf+QdKc5kNncVIGGmK
 /J9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506158; x=1779110958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QqsjhQa6wXCEAmuLc30WAj8/J+uLGDsmHrfdtiaK2YA=;
 b=lxFQQM7N//u8ywotRnAkZg0kPo6DNuLTU9DC3AfjP5mZLB5CeQWKlgznr2/vBfclRf
 xp1E0xgiY+k5D1fZJgiOsJxXc9SmYPT0RwTMYF/vhvkveekyZ010hWLDLTTrJCMF6vLl
 1+1qT5/ofHwS0+o0Y0D/+seLvGipL53mypdN/8dewfzpfXCvlO+llARagIidXgDiPvqb
 zDGe+YXZ9sOXCFp32V3E1G32b9UWb0pz4NU/TbXrFZdR5VE1t6VvjtA9NTulAYKkPxqV
 MC8vA7W1mmaXTRsZAEaI/SJSNPLdEGrH8rJQuWTLzf+5wpQfMtGEEELhTQuUP7WH2Q/l
 6HXg==
X-Gm-Message-State: AOJu0YwZwlBNLGM44Lu6P3thsqz++N7YeNAWX4SGCt0JDPrZiXUIEGwv
 3ZlH11m8V+ONnc9hFxu6i6nyab++SWBsUgT5v2EdE/uQDJNo4LhwBpHPlmX0ASQbUCwFAmO1mo6
 Q49qc2sBFijIWJG9mruq8Pq9LE3lRlMTUxtL8NBomi5nN0+BPQi5y8AMRRDwiK0DcDQ==
X-Gm-Gg: Acq92OEooYDDVlcvH3GJ3AfK4Nj/VVtRDM4AStV7O/EsWFj//a/C3l4J391Scg6dkPg
 f/5mv8w8i+N6LBbjAV6RrKyGPOZlhy7wQiFEXe4Sg+UsKNrvSr1znWoZQEN6iYd/4529EhndBS/
 xbN/NQDP1Hx0ceR/xBbJFUsH93ecm0V/d1TVbkaOZ5kBPUbm/+QyUGE5lB/T6Ai2jvbgVXMSZJM
 ccc+w87+FDRYRWLw4JHN0rFKypznyxZoFo5yb6VGwlVn/rv80RNJ8v3/CvVQYgJRvjostVuqKNS
 IxY1wfv9ereQgH2zc8Q7SwOdfSBMVnubOMCgqbe85BCalRZ6g05/CN80HlUT05qveSD8ho8VJRN
 ytfEsfzhuVC9xyRYk+qrABUZRxtT4O2i66yS9aH+rn9ZivJD8jxOFD/HtW5s+
X-Received: by 2002:a05:622a:580e:b0:50e:60b8:347e with SMTP id
 d75a77b69052e-514621e5a59mr365429491cf.59.1778506157796; 
 Mon, 11 May 2026 06:29:17 -0700 (PDT)
X-Received: by 2002:a05:622a:580e:b0:50e:60b8:347e with SMTP id
 d75a77b69052e-514621e5a59mr365428901cf.59.1778506157240; 
 Mon, 11 May 2026 06:29:17 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c81b3fsm95250326d6.29.2026.05.11.06.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:29:16 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 01/13] target/riscv/cpu.c: add xlrbr isa_edata_arr[] entry
Date: Mon, 11 May 2026 10:28:58 -0300
Message-ID: <20260511132910.1738069-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
References: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0OSBTYWx0ZWRfX8ZWeE4oPiayC
 L82CaRGCJauOM4GlA2FzoBOmxF7KCFStQ7Ec8ujeh/NCTmeGW26pqVkGJVisT95PeVbC6+eoW6v
 DTYVus2pBL0MzW7E6eOTB/GYp2jfBDqk1NxOfsBGKGreWn+5+PipJH7nJj775kdb6TnDcbBvN/9
 guZycA8jkUOhA5hwvYQ7dpiWk9oA8g59sppcg+jxbXTtyTly9+BGo89PSOm21wAjZJZJZYesoLi
 7dy4znEMrb/bDaNPu3HhrP98yBbf1Lj1F/4IhSDXPDVCj3P+zfzE2P63btX8e0gBM9YJ7VgXfj3
 vn0cpHX4WQfwuZ8jJ5AKDRK/IoyVqDes1rjqq75+A/jUqsnCKcnRr0QDtSzHqSBMq1Ycyj9bWuK
 hcEa3qbtgVq6lYUrOAULwLZfMNmEZSiPVFHHhyvUrfYf4RSogMImC/haQuqwVlXlRmo+5XnF3N1
 MnnHH2QL3+uNIIxTl7A==
X-Authority-Analysis: v=2.4 cv=AI/DAN7A c=1 sm=1 tr=0 ts=6a01d9af cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=CgV5rzeiBz6kM6M951MA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: GiaM-UeHN9sYd5Dn5l4L0UHvD2_0T8Fj
X-Proofpoint-ORIG-GUID: GiaM-UeHN9sYd5Dn5l4L0UHvD2_0T8Fj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110149
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

The entry was missing from isa_edata_arr[].

Fixes: 32bbab666 ("target/riscv: add draft RISC-V Zbr ext as xbr0p93")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a13727c0d4..a9d9d16c1f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -255,6 +255,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xlrbr, PRIV_VERSION_1_13_0, ext_xlrbr),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
-- 
2.43.0


