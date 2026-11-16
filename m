Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9818D606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oknyOrdx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aTXmqlhX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT65o-0000qW-PQ; Mon, 16 Nov 2026 18:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT65n-0000nY-If
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:26:31 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT65l-0001Wu-IF
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:26:31 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGNPx1C2053491
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j8fT/F67eAjmOowLhsNkdHdviU9qnUdLOGVhbOVptOE=; b=oknyOrdx7MHh5ORp
 5IRhqxGKSnXRTiIsgtyE/w+gqEWSxopITkvfi/8o7Cp+WMHI8tYO5uc8O+onvgXW
 M77VMu6CECBWnvvzUl5zhBXPKAR8nix9YVSUgA76Er3OkgScwgCYkQNRubV3BxCK
 1/CeLxSdfZ5bjo01Ll/oaMeiDr4TZICcydaTgSno9NThZl31TQbL2Y9wlLpNjSI0
 d+VM9o2PWeLIc6bSSzhzvGPUP/Yu9p0/9v3CVoSY73KiCBgDKdqmN81B8/SvR+e7
 /tNFIVGllGhmoy/t7gMC94KP3ceGYfwOdqOV3rx4Xd+hb6AtBMCw3KEWAVgESXWv
 dsMiEA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqgk09x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:26:28 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7d2c415bb8fso412150137.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871587; x=1795476387; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j8fT/F67eAjmOowLhsNkdHdviU9qnUdLOGVhbOVptOE=;
 b=aTXmqlhXPAzHAKs3f9AnQVCHaEFwH0hAfCwzNFaJcXpP5vxVNuGu6dtBNBn1yxp3wF
 XrR3K5blyT49aY9URN5OlSi6MvzUuSwjcGDuIYPzzRGq7FCkEQmP8dbyQm5tulB0AEa8
 v2om0BIw1x7MZiknoLs/RA9oVl6lNZvgivOsXmhEZUEJ6LJV1SriyVljMSytYzol0PK4
 msVthmjqwBi8LQQkKe6DSatlV+f48ANWVNesW++f8Pd5BK08FWLDVrPsomOP9wYJCBK7
 F1X5RfAY0dUuzA8oZxeeQWQMUTer3+2tXBz+2D/vXj9/UHDoxg4nXZ60+iNpbfqGGFkB
 lAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871587; x=1795476387;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j8fT/F67eAjmOowLhsNkdHdviU9qnUdLOGVhbOVptOE=;
 b=xp87n/w4WbxcNWfADSBdUAY7PmqwgJxC/sg4ZzbmWig9CRdeNJZ0EM9wsEkQJtaXug
 eFqcweV0zetjeJDSuWzUGtBcStLuyydrsDWt/4tluYA4DLBTOrlXqDSrX0meDEVp0npR
 qiRBEOuRqgjeUblgmQOfTpGgcTfVKt7Ai4RCKAzRlhdMEDCsUzjiO3llIZ35lW6M3vG1
 NLo9ikyfDpVqSCzSvhniZmTy3yWPwptAtvgESTEO/A+2dzir+KElWXyrTtEc0F4bAFoy
 nMVqJBoS+pZ1ThSiTDvDnBUrvUr+twedQ48ooaYUehrdXUMNTgl9ZOojSeNUIaccO9zv
 Cgww==
X-Gm-Message-State: APuU4Z9EH3zFbZGH6208U+FoGYZxonYYQCU8B5EbkvlyS9xfBkxI9zBr
 aqL02GiQvAyeoEqdKdppUD4DB/1FkRScM+chDJYHOVNADj/T24Q3YxxOqVxDiKCf69Oz4fvFUbN
 dA8h9Dw+tPxqF7KfYLLIB9rSFg87viA10Wfj/nz1s11IcplQgmCdlAO3U278hl9+iKA==
X-Gm-Gg: AYBFou2f23zU/NiVEVI3cSK80+/aUQFpW/4rBCyP95AgoWdjld14kJ2IlXO4dsWfVQP
 P0UcxuzgN0npEbNowJgCdWRli3J/UOWh3chBU2vfDxAUM6P6flofFlnu5JJ2jE/DSMNZGlzR3mW
 lkFEP0bptQXn5vhJ5b3qhG9eM/hBdLgLvlvgt5R5RYCgB0t0JOoMB8QwFej5zdC9g2v1RPbdRNt
 kFy1LDLY3w9JIz2hwnDt+v0yfbWPYfR5jQv5pbZugmdVUqT9BunSXTHWgxsP6ak+nCTBRkYzEWE
 /ZBXMF0kDYzb5z6ekymStGHjdApff51Zk5Gy7fY4TeVZ2meCbFV7cTBs3wGLx7k0W3ucFcVJLHp
 c545ox8w/jC1iPgSdcMNkc/Z4KZoj4eqO+Wf+K+bUNSbtw6mZIL7eWbN7HxHlZdu4H41ngMCf3t
 dtB3zYYdNIWXeakw==
X-Received: by 2002:a05:6102:4426:b0:7c1:5862:a97c with SMTP id
 ada2fe7eead31-7d64d874efbmr3192739137.37.1794871587040; 
 Mon, 16 Nov 2026 15:26:27 -0800 (PST)
X-Received: by 2002:a05:6102:4426:b0:7c1:5862:a97c with SMTP id
 ada2fe7eead31-7d64d874efbmr3192729137.37.1794871586432; 
 Mon, 16 Nov 2026 15:26:26 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783965d4sm23464325e9.7.2026.11.16.15.26.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:26:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/22] hw/virtio/virtio-iommu: Fix IOVA address lookup
Date: Tue, 17 Nov 2026 00:23:35 +0100
Message-ID: <20261116232335.31593-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX+bmgWvqBTjpF
 ABWtiHp26JadwUVtRwPNrkqIvKJjJ28e/+i51pAiCnTbqWcxRE+7tAJZn+uR1U8Abbj87bCt5es
 c6RWp93YuWrVubkWndgLYD538qrZHL4=
X-Authority-Analysis: v=2.4 cv=epRKXYpX c=1 sm=1 tr=0 ts=6afb9124 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=Pp0a0HNKNNij_fokifwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: 0t1yvNu1r4d1foKUhjRJn6g_CeZQwKe0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX5CBKTcvOSc+d
 4HwOcONqrj9Jaog/KZVwJEmjGCptk/zb22suiuQrDcDoBdDewSAFZJ9m9B3piPkf4qo3FqxPLPc
 I8TEZyKmHW5o8EyC1/Wv89KvcYeAUcRtFFN2P+YAbBR7Nh5g9rT/0pldSyGF3B3M/5N4ubQC9rP
 v84jw3TGVNPHFUkVZPUH9z3UvYO7AvDkhgyf5e8K7dTw5s+pjTcvlx2Jfpl0wDhi+4Nm+9D/SI+
 17siXEomZzfi1Oq79Iw3C1hdIhM9cIhfbB1nlgKz08djbfPCOEDaTBGhQ18QKNZLedm40B92wAS
 NTJaszlfsWDMUtJjskh8w/IlbM6C7Wen4T8DaxSM01XF2FxvL5eiotDhGcuLbOvI/MMPH3Ey8Ct
 O31HTP72W9lYznALcNvqnQxWCYQAiCNdDy+u7hZRWaoben4t4XOwBVRyA9mgicl7hEFh+py6Fz0
 8XCE70AYU1Akg0ArZNA==
X-Proofpoint-GUID: 0t1yvNu1r4d1foKUhjRJn6g_CeZQwKe0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Eric Auger <eric.auger@redhat.com>

The translation code checks the address to be translated
belongs to mapped segments by calling g_tree_lookup_extended().
This uses the interval_cmp() function. However the interval
is badly formed with the .low=addr and .high= addr + 1 instead
of both being set to addr.

As a result an attempt to translate an unmapped byte just before
a mapped segment will not fault as expected.

Example: only [0x2000, 0x2fff] IOVA range is mapped.
An attempt to translate 0x1fff will succeed

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4754
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261116173857.367638-1-eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/virtio/virtio-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 208815096fc0..b9ecab01eee4 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1185,7 +1185,7 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     GList *l;
 
     interval.low = addr;
-    interval.high = addr + 1;
+    interval.high = addr;
     granule = ctz64(s->config.page_size_mask);
 
     IOMMUTLBEntry entry = {
-- 
2.55.0


