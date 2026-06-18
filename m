Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE5BCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBwo-0004kD-Lf; Thu, 18 Jun 2026 08:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBwh-0004YG-RV
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:34:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBwe-0001ec-8P
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:34:09 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArhtx2611775
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jHevNA2PQi5G/JxFJ3sqFh2U78K5uaQK8S49VWFlG5M=; b=RcapXIrT2UgVo1Zw
 dU78UAIE2KGlWXQJH1bemv49jZoVmSBEmYFqlk3avrXgTRWP773gjd0GkysdwlUH
 AUaE4/21UHRQaGqukdTV5GLLLcg9mgxhVpL2UuS1rCQTndbauqmeUkIXk4ZZ8jtU
 AdtktUdzIjAL4IarcMvwcc0+P4IOqRy0zR1yc7gl4X1yvHwTA/V95jN0eK3n8ks0
 jfHRmRwIzHEEdBUJ3ZqXWP0GvsBaW1L39FZLKxxe3IfuuvNJPpuu91FkIstUkWaE
 sLKoZtnQdOXvnxlyxaBSutQFesz9dOFhNUCTiEDkbTBiWNJ5Hxf9T0ThHoel38w5
 o9y3NA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euw9vmuyf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:34:06 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-963d7e5ac77so323872241.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781786045; x=1782390845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jHevNA2PQi5G/JxFJ3sqFh2U78K5uaQK8S49VWFlG5M=;
 b=e5krTHUXnWrbvBnci9mJ/uKFefghse3wVik6U2PO5m3DEpcj/yz5efqTFEMMCXlwYs
 7yFlqSd0gnEyqJ7I2O/HW21TTkgzbyVqBcgNMter1WPI3B3T8TUQNZ+uxMkS950wSO4A
 oRQz04dBXEi7cNMAjXx3KGEbzjcIMfH/iaUU/PFqxnf9C0kffn0lmJCucY8anpO8greF
 OGCverwz5U1PCMVmFita36mbub4s4OwB6B/3LdebkNgjBOCxCSw1iqfFc1Kn9NLzvjeU
 Zi5Sr6DdhvBtb7i5rh8dFKcE3pW5MsZGTKHDna8hbPBd5HRZMyJS+2/3BtIG6x4oLjuT
 zvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781786045; x=1782390845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jHevNA2PQi5G/JxFJ3sqFh2U78K5uaQK8S49VWFlG5M=;
 b=aSjnSmw6CGBkoFcFf0V6aeafu4EevMrPPHAJeEliUk2jm+E97Cuz43ECsYYDK0Fyc/
 IWwvvp5KQieKP1vNLaeD8yW4NmRe7i0lxkERLYCvNWEXRqQUjgeEC2g0NucB6skLSJ2j
 Ci6ye7YP9MKL7Fs5MBRABCPdCkPSBRVawx3ouJQUZFiiagxwxI3Gd3SAe5IpLmOoMar1
 hPOT7z9NbCYVXgVa76woiD/wbpXbdw9i1AxUT2sYF6GCpjDX4bYuXG83ZEYcRlpjZmhd
 fSAfKDI8E/ZMSfH4HhMC38yxBPPEUYtbp9m2hl/DtXTsyMxaRrtgJWsaUNjF7Veh89Uy
 pjJw==
X-Gm-Message-State: AOJu0Yzt0bl8z4xOL+dMKQHIu+QVamcz4613dzIi1Tz7FZWY8Ou8v7OC
 A/32zlTkDx6lnFdM70L9cWaO1hyfBCK2al7J6hwKce0Zio4WRckEcTNA0X2K443zXR0zzjM0zWI
 8ZR7E84nyvf1DpfMUnfNB65JTPc42/6zIWi2dmqQ/jYxGttt+Cv0KfADvvxbES4RkRg==
X-Gm-Gg: AfdE7cmSgTmo2yAUOTWrWsONjEQOcu7ChXa4gQldpZmargJ7f8m/Jko1M/TA3lOR249
 RrOIQ6mE7sm3n9/XJih+YHEpnVBc9tKzUM1faFsNUZ6y95tw8lD9k2R3CIA8DnVs4tOTL7/fdF4
 ewTe9ASFOf5DFEi6A4H6WpK7C3MbZIshY0AkvC31JGoRElMgOR+bPNvceW3BNH/nKgMKX1DLP0N
 uhaOZJ7G+yPAltWYBZo/PIAEGOlKVm0Zyr0V6I+2ZwYsjfhX5MEDrehw5p3V7ifdLFc0Beqwdqn
 xTWJgUmv+DXyfD1FJ+zUx0/UugjkO2K70vlmZT2z68RuLOv6X3WXF8daimBxaK1Ayejfpgno/7C
 BOQeSfmPEA7LVEJpkPqEQFeIduDOJYzn/LpZHJlFTRlhfC5rYczverSkhnmDQJjt85S2d
X-Received: by 2002:a05:6102:5348:b0:728:572d:80a1 with SMTP id
 ada2fe7eead31-728572dace9mr1318318137.21.1781786045504; 
 Thu, 18 Jun 2026 05:34:05 -0700 (PDT)
X-Received: by 2002:a05:6102:5348:b0:728:572d:80a1 with SMTP id
 ada2fe7eead31-728572dace9mr1318300137.21.1781786045032; 
 Thu, 18 Jun 2026 05:34:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa47ce3sm266409165e9.6.2026.06.18.05.34.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:34:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 46/48] accel/tcg: Have cpu_loop_exit_requested() take const
 @cpu argument
Date: Thu, 18 Jun 2026 14:28:23 +0200
Message-ID: <20260618122825.90331-47-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hs7QCFHu8XmPuXtPerjiaGKBFD3SpU8V
X-Proofpoint-GUID: hs7QCFHu8XmPuXtPerjiaGKBFD3SpU8V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX/YZL3Ax61p0g
 G8HKc26dM+dG8R0ivbnRMqET6PGO0CmNt1kdCSqY9Jxfr1EctJlMlMKaiIsDWqTIj4IysHZz7YO
 moKK4PKm5rWNXZqYYZtL+nSDCfDWmQiWyVovdaNcf2atPXXqpEiVFnjEPUiRARKrla1gmkrJxej
 wLsTa5GPxqJuzGiY8YiKdqRLTTg9OkCnHu7ljkWb2iZ+/1d1ITLiwg8Mib/gNLa46T8Hwbq1ZRQ
 FAJCWUMr6uoYUWY04usyg5rEbQlU0ddQaGKggv3XKpzVXvCAGjMMr9dAuEiUkEBVi/A7rWliTi3
 tv24dXJN7na8+k/0hCO8LGa+AJ9dWyALC/y5apqAYHkBbQgJZj/Eio13JqoqFcDmQqE/fXVm3a/
 1FelN2eKg0BDn71sTAAraHC/YbEdZwF0EjzIAqcYRFd+FlvPdGH/Dlpa9m2wH2+16LuL3eBjU+o
 9qH3jl4xpXF+fTMaPow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX2e6xYscMN6ay
 zI/98THJ1k3729MG0oKpGJJpjtNolZmhWkTo9twvRVdSdwymk/05QQmVXBbC2CU6Z9Qn05VjyLX
 gaECd+gHyObNO2XL2kF6wfYBRcRR5WQ=
X-Authority-Analysis: v=2.4 cv=YJKvDxGx c=1 sm=1 tr=0 ts=6a33e5be cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Cu_OB6cER5A0ZMY7a4UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since the CPUState argument is simply read-only accessed, make it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260617171438.75914-9-philmd@oss.qualcomm.com>
---
 include/exec/cpu-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index db67c7bb864..919ba41a013 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -73,7 +73,7 @@ void list_cpus(void);
  * call can be used to check if it makes sense to return to the main loop
  * or to continue executing the interruptible instruction.
  */
-static inline bool cpu_loop_exit_requested(CPUState *cpu)
+static inline bool cpu_loop_exit_requested(const CPUState *cpu)
 {
     return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
 }
-- 
2.53.0


