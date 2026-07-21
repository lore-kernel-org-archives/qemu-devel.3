Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380C1C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7tp-000657-QT; Tue, 21 Jul 2026 06:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7to-00064u-M7
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:40:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7tl-00035y-Pg
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:40:32 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARvNs1252118
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DIzpMBVIX9iNrP/c8/KMOEKN80fjo92tfLWtNpAZBd8=; b=eSC5/TMK80oRXZVz
 MxqT71J4lRUQukt5BDBZpqA0RZOPveho5T9PqbcmTJeJjHpT8xwQEbSLUPryZ67d
 iZWqkOq8aZwzwPm2S64KK5Ob6c+dNfhka/qXeuqnJ5KHxz8mkQRB0gIgxDrAtg/g
 nJ7unpbENhBiatfg2XJ//84CX7x5rK9mm0aZJoUXwXtyyyagUjG+EAVqqWYJuxo8
 SNCV7LQLUFlH4sUlhFgTuMzF94UJ4z4mpw1IWMDRyC1cPOO8hz974ap7fMJX57hN
 1VeSdWsxtmzEeLjoDXHlmOreXv2J3XdrPUo+s1mI8oMCHZC7rXrh1Fx2VDLLMLz9
 k4VZiA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqvcbyuq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:40:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5174a236220so205537221cf.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784630428; x=1785235228; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DIzpMBVIX9iNrP/c8/KMOEKN80fjo92tfLWtNpAZBd8=;
 b=Gt5vdY1c0zHvrP6j+lnqT+D5h2cnkLQX16MaZHLVdWL1aQvsVcpUkrw7CZ87hSajCk
 FQcS4Ri9w9U7O0jbnfWynMLnEK9f6nM5Od7hTsh8Vp9FKuXpm7dg/strL/WxjPZ7yrDG
 fQGAiL0TAtU+2wjuuozOwvcwv9VjrV2PrsMHaRpM/9PWqURTGlrZEq1NPTksIVfAr5ck
 2thdPW8X4sw6APchV2VeWn0ay0kjobbRX5NUUaXZEPNo6VdFzZoBXzS/VXtZhhOMheWw
 IYANc7ZD+sKKGtJvpu+JDYL2yneIsnJX8GOBYqBiuC2ocxZ0LCQnpuA34wx8jxsuYc7/
 mqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784630428; x=1785235228;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DIzpMBVIX9iNrP/c8/KMOEKN80fjo92tfLWtNpAZBd8=;
 b=hF8yRJimqzZ1sP9q+4NbrHBfpueK6rCmZZUS5iySS2w2BGpWdab77WsvfaAe780h/X
 VF13aWeqSq1MKwp76+osYW86Uco5HiZYbA47687rKVLfMnr0KkADaDritBBHWfQpfr80
 kQzJtO22e9WoEDZJByY4EHuracnzMuQJuVf0o5Quxz+VDSe23PLM3wrw4CQMR7xTqUSQ
 Eauwmi5xgrgd6MFJXEkPah265jAtDrwz0KV/reqFunqDfkE9lQLhsHAJ1INMpFWjS5Eb
 BLvW7fQuHDxbiiGNWPFhssNxZg2U0qLQvVsEVd0PVJIMRKyZVEMJFdxHfy2oed6nP+BS
 8Ewg==
X-Gm-Message-State: AOJu0YzEhKfy10wTdDIwfAtBeOJvl1mSgdpd3s5VY6D5mTW/7RE8Ky+r
 HGBzIO14397Ziv5+IM4FCGGG3qIF8T1mtYURSsAvumoqBEVE9xp0mr7WMyrYDwhc6NJTq+6ysDq
 abAl09yWs+lg4fY5lI+heu9N4VYesT4UYg3zjssaf1oXhxGzc8NxHpYZzHOQtQ/gE3w==
X-Gm-Gg: AfdE7ck8fHFySiAmfEQQykdncybceS6NFOZPsY4r4xYtrKdXSER75ZBP3CwAuBglb9e
 QASq1/xXSYaAgw0efW7F4KrGPv8nB3kt2cNgA645xOOYLryxiQaflIlkN2IbUJSshmksrAIfqT3
 g6pHdM0YDtJz16bppD0rNC5ScmwMZX2qz6g8Brp/S+nIG2w1OZ/JgPd/J0CBycB4f47AXSQVsAb
 m43RUKm8BOe8EcSzsBfV7HHKHp8SWAtCzld4O+MWRY3mLmJ+iSdN+XRPFyMlZouJjXbcXRp5lcE
 JnQeVLWRZoL/Fac7kQbf9/6SeLeRDpD3kEIdNpq1s4QieC3tXjtknOCEjC4jVhRMMu3hIr3pXzX
 tO7vfSElcSQ97Zkvq2Rto6zVwXqp8kEtDKmd3yrNKPNHFgQPTkxGoupen7A==
X-Received: by 2002:a05:622a:1f0d:b0:51c:13d6:b4e3 with SMTP id
 d75a77b69052e-5213e67f164mr164452011cf.64.1784630428197; 
 Tue, 21 Jul 2026 03:40:28 -0700 (PDT)
X-Received: by 2002:a05:622a:1f0d:b0:51c:13d6:b4e3 with SMTP id
 d75a77b69052e-5213e67f164mr164451801cf.64.1784630427723; 
 Tue, 21 Jul 2026 03:40:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49563969482sm158369905e9.3.2026.07.21.03.40.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jul 2026 03:40:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/9] user/guest-host: Include exec/abi_ptr.h
Date: Tue, 21 Jul 2026 12:39:58 +0200
Message-ID: <20260721104004.84934-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721104004.84934-1-philmd@oss.qualcomm.com>
References: <20260721104004.84934-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfX0oc1J/zFd+dt
 8hLQhsZb0Im5WvFBjHV95nD97PA1KKix0A1n2JjsnnquA0feTcb79Dwa6b3CNz4jNLRxrV8DM9a
 fYLhcwCR8DDise8wWCaeQPOYVuVwFVM=
X-Proofpoint-GUID: WWF3wnVkLrnrgDaP68_5oI1Fb1SazEW9
X-Authority-Analysis: v=2.4 cv=OMYXGyaB c=1 sm=1 tr=0 ts=6a5f4c9c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=xfvfwgUyMf2eb4QU6igA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WWF3wnVkLrnrgDaP68_5oI1Fb1SazEW9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfX9uSC27Txs+2p
 LacO7tUVlS57msF3ODq4oHrAAoFqZMc6dzmFi2KF8x4NXTftX5eTTWRr+NRWONefS5LGyrNEXbM
 xAqecBVAR+D5cuhTAb7Aeq88YfitNyj0UNGx56hnfKs7P4SK1bGdrV8HtsqgN/DLIj6+3cgFWn9
 F5SXT5cYd1BN6ySX/HJG9kljVKVfW1RLEphG6pPy3mNG3p4VMt3yFf259QLdTgptbTDUqrlv9xd
 jSzrW7+jjWBmEgX/PHk+PmcBKybVzELYTojEyDPYCAkHtDF8lfUBLA8h2mEBXwbsStCHDbgUNdE
 Zhllq2hJ7F6Grl1dLGvPyuu5ctrLrFIGMaG9tBbMVSa9DesLdsGIS1jHQSPqsF3hEZc7gSEKwtl
 BSQO5/VkH6H67DizM1dRzcmmVeTIM35AXdAGxuLNty4pWlUY8TtLoBIcWm4XhlH7H0TfKydx8ke
 j1lo4mMCod61yXzl+eg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210112
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

From: Richard Henderson <richard.henderson@linaro.org>

The COMPILING_PER_TARGET block uses the abi_ptr type
without including the proper header.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260717232306.378988-2-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/user/guest-host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/user/guest-host.h b/include/user/guest-host.h
index 506efc097e0..f136f81f5d9 100644
--- a/include/user/guest-host.h
+++ b/include/user/guest-host.h
@@ -80,6 +80,7 @@ static inline bool guest_range_valid_untagged_vaddr(vaddr start, vaddr len)
 })
 
 #ifdef COMPILING_PER_TARGET
+#include "exec/abi_ptr.h"
 
 /*
  * These functions take the guest virtual address as an abi_ptr.  This
-- 
2.53.0


