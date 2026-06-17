Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35857CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtrl-0000a2-C2; Wed, 17 Jun 2026 13:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtrZ-0000WS-NT
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:15:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtrY-00071b-A9
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:15:41 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFpVQt3284297
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9P4eL9ltbGkKBF8dOq4ZNAdVms10Noobn3ujdQqaKB0=; b=G14XwF1zc3gI4Orw
 I/iTFpBq1t7N3BMWuSJq1q5wE94Hxzo9zt6MrLPJLgS/rpvM1oRbTnOJVqHjx0yv
 JwRiAb6ADzUKRr8PYI1vS09d1JBOSkKiPScnrBfExg1DS3PDV/yfJt468EuBvGeZ
 x2yTH6SbcPH1Rxe1Vmu86BTyXz3iioGxDXIJs3q6qGXoKQlidsXdf8mVnddkbLbN
 EzqtFLoNJw7ktm3EMjVlLD9lRSTIs2cJtCIUlDcWTDui2EcF/Yy2MorFm7kpfYLe
 YZVBFmU5W9Bpmsx5/KjFlyPnJtJvcVvt1SL30QWcxORRo3Fi7Gs4G8pI9fVToE4j
 pxjefw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueevmke8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:15:38 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6c152655acfso15718137.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781716538; x=1782321338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9P4eL9ltbGkKBF8dOq4ZNAdVms10Noobn3ujdQqaKB0=;
 b=dV5Hfckr8idslI+Q1PWvdy5XJqXaAaqTXzwlRkLG6NN9o0eOWjXKw8ZVYoKAF7Obfm
 J/yVdCOhKc3Tba89s1k29X+nDRqnzjnihKcF9XbfygdK8B7gia80stvwAADJwlOtpEjh
 cPQ44DdEj21BQWWokFUz1GqSQOxr1rL9Cxl/XkfT/fkR/r+nxDQBRvusY9JO+QHNx34I
 VFE1DlC52SDv37CPqpArISZ9yEKGdnkICv+oTmHPvD82UqTZr4swXkYZZ1KHPaOuU+mE
 pqaCvn3t3u8l3uoGIaY61H5gfjwO26eLezhQrj19/XbwjjZlTVL5jF9wodzdhaEpMeXf
 1mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781716538; x=1782321338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9P4eL9ltbGkKBF8dOq4ZNAdVms10Noobn3ujdQqaKB0=;
 b=QUA2y2DseU3GT+/YsMpoukBvtoN82Wyo85g9ftbhBim/4urdchwzixzD7IjxTqRxTy
 uDacLk03xXWyEKx5TUJEjMHepFWMXLc0QfE05neD+BX+hY9oDe1oEnopYBzTyjaGtOZE
 G2WU4nOOeuaExyqHFstG0rgR8ksrFVPcEmmIlKEKchgT+Un3Jd+eCxQ4x9q8Kj0uf4gV
 F9FNSbqHQcXj/vKsxbJUkwgPjarZgwHXbTiCjzPXRd5cJmoVhWKgzePSztX4HuEzy7Uu
 Gzwo9YfhytogSUefnHIwDxjDSFE6LJKpMO+3ITmjGWS6bCPO4WK1ai0RpSE9YomNI3o1
 quIQ==
X-Gm-Message-State: AOJu0Yz8qhBNHcq/5AYJIE5GnZU61FihW7OfR52TEKi3X+toiWSkn84O
 ykS5zcbDv4S6UwK7Xo1N7nGyXDm2FcFoU3kB73xsKPdkMZD5LlXl7BAHfjfX2vXmLVQJVV9MhD/
 45GZRNixDBQ+BnCBejyV4WgEsmqyTvW/wc8Xu6zHqurAGseNrCpKP53NzZgfrYczCzg==
X-Gm-Gg: AfdE7cmM+Qbg7v/h+yYtvrhYO+X7wcOE1vhpdm+pMesuu8okgdOq9D8Rg5T98KfqqH7
 Lz8xOt1bXj3COOxl/WN7grDtCHnMybwW8xq+4aOEkcRKqwN/OR2fqzgPK1DAhoDNf1LEHN8947A
 znXV6KjTZuky1F8icecYpyw38VN1dcfoOyin3PtHJHDDqEMGER7VJmYMN/DAC+1kcrWcfzctlOJ
 47QGxJ/n+D+yXIB9MubdYwiwn37s77vXHXDlx5AVvR5o1O0TSZKJoT4eCqNp2FgyEGW+89CAU+k
 YikuY5lrp/D0j3sPRkAFCc2daBD9r92gw0B1T4eaNtejI9+/irqKDibKpMPqEHfQYn1fEKX/w0K
 d07Dzwgrjo5SnMiBgdPVUpFYAh9JKNKHKgm6apLhd2EH8q5zvO5sL6+b1OQBgxJUhxwmJ
X-Received: by 2002:a05:6102:1626:b0:634:92c:bdd0 with SMTP id
 ada2fe7eead31-7245cec5b37mr2671022137.6.1781716538096; 
 Wed, 17 Jun 2026 10:15:38 -0700 (PDT)
X-Received: by 2002:a05:6102:1626:b0:634:92c:bdd0 with SMTP id
 ada2fe7eead31-7245cec5b37mr2670987137.6.1781716537625; 
 Wed, 17 Jun 2026 10:15:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a58becsm165785325e9.7.2026.06.17.10.15.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 10:15:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 08/11] accel/tcg: Have cpu_loop_exit_requested() take const
 @cpu argument
Date: Wed, 17 Jun 2026 19:14:35 +0200
Message-ID: <20260617171438.75914-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617171438.75914-1-philmd@oss.qualcomm.com>
References: <20260617171438.75914-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX8xFrtBr/WigK
 Yiw1ZrOLIwjTNZruuX7TffGf7s/vZ6N6nSHQcVPTRipfyIV+ksm0NXg45Y0ZPa4CU65BbNuNTqw
 TZcbpLjPFXQgzLvrLFkZTIusigLetlEe+fgiTsSxjLLPE3MwgOfr+XRrsJ9WGU+MpIDYhpg1LiR
 w1qsrjGgdLq+u3DtkV1XLqBPnVLc0/nMIQbd0IHe5INQLb95QSDmfWMDZ2MP/JaaB8A0hT8G5tv
 4bwGQ0EZ6JIXSnNU1dnIASnJ3Po9s7/0CdxkS95uD2XHn4yqTa5d/zwZraBLiqvl5FwXjyRf7Al
 kvmoYhCj8kxZZCEiqXKWRhr0pt3KQa+IoZPUNPkp9gpAMP/YiTEU+0iIggQyjOIsk+KHRIk/7XT
 RbQzwm8Prahdz2wRL6hqkf1HdlgvP7wgVt1uwiw6e10KwDb91TwXLFkoCUaft847eNGFNiXxi/R
 Q91jStPLBv62xStSFVg==
X-Authority-Analysis: v=2.4 cv=LM1WhpW9 c=1 sm=1 tr=0 ts=6a32d63a cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=F0IBwpKotLoxzzTqpwsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: BCsUcU5lUbE9rEmavX07RdzX2C82tOWj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfXykT/KyxYLrVo
 lG/wNwjJ3tDBT42tf2Muc1W0ciOfNUfsyUaNOUSxBIkN/7/6sXM3paZQCUcxTCl7idMm08xkMd9
 qwgYIkCMaGWeICtSnuK5pB3CqcflAbs=
X-Proofpoint-ORIG-GUID: BCsUcU5lUbE9rEmavX07RdzX2C82tOWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170166
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

Since the CPUState argument is simply read-only accessed, make it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/exec/cpu-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 3757ab15967..9919ffb1838 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -76,7 +76,7 @@ void list_cpus(void);
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


