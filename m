Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C406C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QWd-0004kv-75; Wed, 23 Sep 2026 13:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QWW-0004YW-90
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:12:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QWT-0001BU-Jn
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:12:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGU37K3106209
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kRgYgQN0I68E441Z6FdMRIvgm0ZT03zmfUCw+g3PTWg=; b=JlLKVw0ElzDUVHJK
 Ni43HEFvUiXP2AWV7nFngcMz22cFMlCnfoc3+t0Cwia4Y9+WP8ij4NnrPRsf5WlQ
 d2fP/W9B95TUiZZm4kkY/mgZU0FXrw316l2h1GQ2uWh9GKrluD8Efb039ttAcQvR
 qlyXktrk17DqEQmKjS6IWJOD/vACBotomCV5U3TctWS9WtsvuM09ce+4fRkWGgpC
 2ObVsdFGIDUgsVd5No8Sc+lBFERhXKFM8x/g2kBYLaep+IvCfhqpghNlq9Jl+WOa
 a0PL2SbXfeqG+A4qIDdVhN+5zMmsM0CdKerhtZ0069dlQVaRdpHeCweCk9UTfvbi
 td8HwQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfmwh0y2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:12:34 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7915a83539fso1053749137.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790183553; x=1790788353; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kRgYgQN0I68E441Z6FdMRIvgm0ZT03zmfUCw+g3PTWg=;
 b=d6mDxwgaJeZOCENJsn+KJ0BsyBNyb0L21h+xIVq4OuoVzu/rYeQJneCGAmQAA/Vs8m
 jfT7JdgpG6K2N78mTcMKVOxC/MtjcTHsYO7vrFWvxoTsNn/IQyRHARrAfobRxFs9zMjF
 3LcP7hNQh1s8mzQ/40Jyk9KwAM89Zxz8wmy7iqgpo5iPQNPkJz0DIp3l7JL4MWbvZf4m
 RTcpmcjGtgEE6DJ3rox07badJkHG5Uc4ITyXjpvQCk+ajD3NJkhzSedbc8Nd8jDEmn/k
 aaBrUQg4zM6d9kYZ2yUJXoCP3tyhPSxCoV30geYQFC8Irgq1xxgDrwA2/CMX8U5QX0uT
 vmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183553; x=1790788353;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kRgYgQN0I68E441Z6FdMRIvgm0ZT03zmfUCw+g3PTWg=;
 b=W8/oq47mJKDGjvYH+NjZTyv8LyZLBdPkQgUx/BFps27CY4D624iSPIU4QARV4xTtQk
 seEo6b6NEFg1xJ3NgUuzcVwXxSSS0UgnP4R9J0Ibv/iOZFSdEqoo4zxQ3jhf+RdMwJLk
 Jaaa5dgwMvPIE0r/Jt4NEBDCHmfE12D+cem+CsFY87S5w+wfxKJjj/QhbxLj2e7pOIok
 E0AC4FF4ewSUlNVNR4lRAIKpSKy1DpTy24epA6IWq8vRzlusEjA3sMNE3jRwHh6XQ7lA
 xLo2qtb5DG486UkzTF42SgdKwEhaC2XVEN1XuhLMCkEpcLm0gTrpij7RvLqScn4kNiP3
 WLRA==
X-Gm-Message-State: AFuF++kuY5Euc/39pus6M98UBv+7Kb/vqfl5r204D1uOJOFTzN9Y5G1N
 2C58MUhbfZl4ujFZOkVtMlGFaTgNAk8rEpDCFSf0CYNMPfxEWpxPxCDA3+jT59zqmGfvMK0j6VB
 Z+0DAaWjTpuWd4AGK+z99KRCS1UxUmika8p+VF4JBVZQyk2Wcv0S1Pfo33lbA/KmCHa77
X-Gm-Gg: AYBFou3ntEQ6LFAo7aAAWfADeUfz+Z3mcqoZWMhegdXOTS3RVsEHWxlCx+trXCNNxUq
 SMNtC/RzAknk1P+Ngk+blod2B52U/YLFfTxTUQqTBMI7A+62xkxDjPh03x50GvLuEeu4Sn8dRw1
 CIWwKXH89LpdnRmG+KA8NqoZS/1dy5ldHpCovQ6x9BXLMWdBGv8nWY0KZHoHE+gTt7xmPytTAAH
 RTqthpvyq6V3KADCpiCNRPDd9SY9HRkLfH5SQfFkwZ6LNrtDDWgh1p2O9K+osJ/XSYiSb/+QEKM
 wOKfCfIrt5d7OwjUHqWEpkgn8vuP9v2/VwKkocevGgXAxQUl6yBjF3sk640Gns06ivLX8Ds7Iq7
 3L/sXrsLlPYIKgX9GW1B8+C/7j0FWra1lgPpgH5qF
X-Received: by 2002:a05:6102:6886:b0:7a1:f951:664c with SMTP id
 ada2fe7eead31-7ac1c78da3amr2579090137.19.1790183553515; 
 Wed, 23 Sep 2026 10:12:33 -0700 (PDT)
X-Received: by 2002:a05:6102:6886:b0:7a1:f951:664c with SMTP id
 ada2fe7eead31-7ac1c78da3amr2579062137.19.1790183553101; 
 Wed, 23 Sep 2026 10:12:33 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886848646dsm7548518f8f.10.2026.09.23.10.12.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Sep 2026 10:12:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v3 10/21] target/riscv: Skip empty MIP updates
Date: Wed, 23 Sep 2026 19:11:04 +0200
Message-ID: <20260923171116.31276-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923171116.31276-1-philmd@oss.qualcomm.com>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX9H+wpou1ekqU
 uQt7U0UufadhaNWIpIZnBguSxglLMsK1Urv/Rns/3ze0Kd4v+aHGDjsg8UpVk+w+YSuasBtvcPm
 bdjB3iB/JZGQtD9iEO/rLkPpabU81327BQSa+T4ueL3JZoyr18GK1pLcm3fGQULN7HLgM7EBvdX
 bMCNB4nh4Wm8O/tJ5QNQoLq13GoLHXVUeFLTcZ8AS36huH9UAQNdhoHtLG6yROpwg1AohuzaVK0
 iYUKJjEWyUnWWv+3G95ztX8tWHq5imxvE6HcSUSakPQ9fkWQIphrvtsKCgzttWvs3IXycJWGKfL
 oAd7zzDZ+3d7Td0BoJsVEQtpnOBnQHyNRo3yuqzlXgWH4IcMUyJBEv9aImCbr/uS+dvc8C7hOq0
 qH801sbWSXxKaNy1pyIo6OH54tKb6Aq9wVsnUiHPBmHL3VqG1sURI0XMS+cZkdV3RqOYivNWBXJ
 CQwe7mKs9FIjzg7lwBw==
X-Authority-Analysis: v=2.4 cv=WK/qzXsR c=1 sm=1 tr=0 ts=6ab40882 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=EurB-bMe9Chw_IDMuCwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX48e6AZF4AZsh
 QiHOsbe1Vfoc6BhoPEcWoANIjAI0rM9mF+ehGbjAGCE3SmVv3bBJxHnQf2nsB4sfmH4xlYo1Omx
 9v6Hs2Z0f7rYiaNAId9NcoqDTWBGing=
X-Proofpoint-ORIG-GUID: 8OqJfbTzi4uD0cZeknyzl_3dMZxrnSyE
X-Proofpoint-GUID: 8OqJfbTzi4uD0cZeknyzl_3dMZxrnSyE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Return early when the effective mask is zero. This avoids taking
the BQL and processing interrupts when riscv_cpu_update_mip()
cannot change env->mip.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/tcg/cpu_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 07d92226527..be64f9ee8f2 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -580,6 +580,9 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, uint64_t value)
 
     /* No need to update mip for VSTIP */
     mask = ((mask == MIP_VSTIP) && env->vstime_irq) ? 0 : mask;
+    if (!mask) {
+        return old;
+    }
 
     BQL_LOCK_GUARD();
 
-- 
2.53.0


