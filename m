Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D0DC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LAh-0007TI-Ht; Tue, 01 Sep 2026 05:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LAf-0007T4-U2
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:52:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LAe-0007Dx-9u
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:52:49 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68179RAR1811504
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 09:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RXSFdJhduuq/vV0dSoh2i7hiqI/DLrn0WKuxvW2l1mE=; b=O5V+HEQL8s1i0THj
 XqPPq2c82rbYNaX92o5Brm2BgrweybL6qjZLhPsjFUd4OTNUYXWabWnKKYJdWo7+
 R3sjb84F2jP6CC3rH4w6np7afsdg6LwUuS5TacDGc8E7WJdM/DPvHDLo0b5svw1l
 y3v6TrwaltN6mvTXyRQUFT+8ijrzjXT3hh8NZ9xJkmYwN8NcA5iZ/Q2vh2t64p8k
 oGWWz/zN16YRNOE1pDIScKznDduMFcetk3HBqu7DBA3Bdv7AXu0LNgiNqTycRMHe
 NJ1eIS60IEZH2iVq2lZbtOgSnCW6yHqdE63GWABDSaJh27TcsEFMEHxGu8KijsJ8
 tM1EmQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdd4dv6mm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:52:47 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90e7de22fddso65659646d6.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788256366; x=1788861166; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RXSFdJhduuq/vV0dSoh2i7hiqI/DLrn0WKuxvW2l1mE=;
 b=KsZdGJJOLgzATOwaPN9Y9+jDXfQVxHARFjSCEyhuoQHmFn1j/FnKLdh3gNsuAesOjF
 xcXtZqqzKvElOiX9GFbL2tVfH81cCmmfoGlwzSOp97ARcbNuFdgcFug2uVOb/eKZSOD2
 j4qp2sjM1REGiAoPq0WsnQfpmx26l8td+pBHclFVzycu+WS99K1xemxruDVzpVp6fyAR
 NzgtoPTBt4YB8jyBW7WYopWrbcTiKyS1VMGWgMrmj4NT0FaWbVIwa0H5MLaf67kXN8XF
 FLLuoDp/+gZu6ziBmbcIV5Mn02IG6NEapBfQRgvL0PJ6giwQTBw09HoENskRsul6eKsT
 zayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788256366; x=1788861166;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RXSFdJhduuq/vV0dSoh2i7hiqI/DLrn0WKuxvW2l1mE=;
 b=rQ8G8u+zYohNufOMDMz6wbGcr1Uf27J0tlqxCt6XHAgfzkqwN3MvuiZf8knrM2v1Pj
 0WvmSQwT2h/cZCmCtKbcW3ZBcPc26EwIqWjYrNw2op4uS8Gs8E7rP/X56HUFCoLxIlSD
 vxYX3IUeP0kbtfyWIgspR6XwXN3+xpTOld0jUMeR4ryzwBXsZ4ZJrGNnZW9JR+eAFZox
 qrRyEZr3zd7NVB5sWBmEMOBPpSRCXDXDErtXEpF9ZMISYb3vk1iV5vZlOPnxycGPFnX4
 FbrqauXIeOREhcCIMMDgp0LzLVRFONFnDZ72hwkS4+N1XdewJnkSCraQgL6GLuvyeF8E
 5YDQ==
X-Gm-Message-State: AFuF++nCcYcAbyCU4hmvjf4G0q5xyOIW3nPUhb8IvbjZDxcjjDgAaHNG
 ZntA4xssF3uVPO4SVaX9yue60jJfH7XGoiBSMYPL3ETTDmsR0T1xWj4QYr0JQax7bsSuD33Mk5l
 3JXLwreKhruyoOFDT0UePklVCe62KJkD5mkUMM5+jEK1lKpkp0myjG9io/CqnhojJTQ==
X-Gm-Gg: AR+sD11c9VzvPOQhl6/c1J9ely0OhI7BKOjFypV7Ap4z5YMqIe/FXwQ4nIta5JAfDQM
 mEfy3K6jmPo7UZYfsiyIWJPQ6ylOetDYvdUsPcR4PNyoghBvg2/8IKA0pUI6e6k+kNm0calUfQN
 pWvfCbyJ0zRl1ddFztXhpOiHbU5IwT0/kKPIVXAUyZ8eYAtWBj+bhQkERq/9c7eNCsL7YkgpZbi
 sIEuYarMvnia3NUN95QgldkcyXHjXn2YMj89Ty8e8RA4BifObp6VAnNh47asD13CbKd9RnrryfI
 QJjbqt2ywHm9qkWvbHgkzb6dQoW38u+D49rOnCgSV6iWrnprQazSRDQKtro1Vt5KFM+dvwMiYlg
 hulkSoFQq6WZ5kxExpTEFXPZRpveZzK7I9xYGU4UU
X-Received: by 2002:a05:620a:6302:20b0:937:5aaf:8c7b with SMTP id
 af79cd13be357-93947fccb9cmr748050585a.14.1788256366348; 
 Tue, 01 Sep 2026 02:52:46 -0700 (PDT)
X-Received: by 2002:a05:620a:6302:20b0:937:5aaf:8c7b with SMTP id
 af79cd13be357-93947fccb9cmr748047085a.14.1788256365816; 
 Tue, 01 Sep 2026 02:52:45 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce171c3sm58834755e9.8.2026.09.01.02.52.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Sep 2026 02:52:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 02/21] linux-user: Uncast void pointer argument as Object
 in target_cpu_free()
Date: Tue,  1 Sep 2026 11:52:08 +0200
Message-ID: <20260901095229.72018-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901095229.72018-1-philmd@oss.qualcomm.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=b9qCJNGx c=1 sm=1 tr=0 ts=6a96a06f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=2RGiIWwp3e7TAFkeQGYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfXzCVk69g1/uGc
 gyzxe1io0wueSJ+JWxPWDVJoEzun/xjdogK1VxympnpTrejQTaJXi3tNvtdiS5fy66x2VtsB93m
 TXxMkmXH51sfo6e8erZLQB65rlXOqMFERiMbgB5iY8vA54DESdly2344xgpBV17sEvSqikOvWci
 CNknHagsgqdhMCgRgnU5MSKLzG0p+D1twMFsD5VTyMfdT1U46ron6bP5U94O6qChSDjI0FiP0Zr
 em2/z8f5smYRslb+OpRN9FlA8sIQ5GnOeKCxxcUYFSak9FojjVPCHZFBQmgjp2tZqGvAszy5j4+
 auBIQfj3jG5CxF2vEYA2OuTJJun3NSIcVcejGeYF5UdOMscH+HPLZ3T1Pe+ydpjNVUPCQN2vhRY
 MqbMfzU6at3EzM+12YUDaBapwXMMd+eecQ5jM7E5Xz2Ye9yoXLfgithoBLYC8xcTuaKx7bdU3U+
 rgSneGCxA28E/vdCgVA==
X-Proofpoint-GUID: ISlpxpiP0F1c0th09YjUknMOqGsx5j6n
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX7Z7W3Ezy9vsI
 2wsq6SZJVC8qtHvwNoa1iwPuRkfVy+myOZho/M5o4TCqWPMfi+3S8VVKhv+yH2KN1A/1DJna5kg
 64t+XC63LfPmlzqeEjwOwFq7nlyQV1U=
X-Proofpoint-ORIG-GUID: ISlpxpiP0F1c0th09YjUknMOqGsx5j6n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010087
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

init_main_thread() is registered as Object::free() hook, thus
take an Object* argument. Uncast the void pointer as such.

While now cpu_env() accept any pointer type, next commit will
restrict it to CPUState* type. QOM-cast the Object to CPU type,
otherwise we will get:

  ../linux-user/i386/cpu_loop.c: In function ‘target_cpu_free’:
  include/hw/core/cpu.h:604:31: error: ‘_Generic’ selector of type ‘void’ is not compatible with any association
../linux-user/x86_64/../i386/cpu_loop.c:331:19: note: in expansion of macro ‘cpu_env’
  331 |     target_munmap(cpu_env(obj)->gdt.base,
      |                   ^~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/cpu_loop.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index fe922fceb5a..2f733b0b477 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -326,9 +326,10 @@ void cpu_loop(CPUX86State *env)
     }
 }
 
-static void target_cpu_free(void *obj)
+static void target_cpu_free(void *ptr)
 {
-    target_munmap(cpu_env(obj)->gdt.base,
+    Object *obj = ptr;
+    target_munmap(X86_CPU(obj)->env.gdt.base,
                   sizeof(uint64_t) * TARGET_GDT_ENTRIES);
     g_free(obj);
 }
-- 
2.53.0


