Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F19ECD98E3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVrW-00057H-SB; Tue, 16 Jun 2026 11:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVrV-00056a-3H
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:38:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVrT-00065j-RI
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:38:00 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GDxhgR3764458
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=SQSOq1nUaTQYn+8T4eSNQA
 Rqvt0C7ZLcRVfVS7wEbVI=; b=P4/b5uy7eezpKyinhwPQnvqDw0gLG6qGfJJTfW
 pJFWe5LoK49zwx029X+tb4dOAWjuipBcTDMIFsnis3B0lvsKmVbSc1lSWK+o3ZPa
 NHc3zWRcbBnj6CwkPILgDDfAT5oJ39twmKnhn4LyHXF4TwtvwKSZrbBJqc40Gr6x
 UxX04VJcmyZtG5HhoPOiPZO8JAZ8RGGr87DfXOwL9bBOZLIyAGmcttijPyZ4RtPt
 4SR/Ijj6+XaA+kHpfrOedmQPKnsjD3Kaps6qkcm94v/cHobrFGRWbJPLgD7sOBIk
 yGJ9EY6BjupsFvLEiEp32DHLJeA5/bCo6Bflr0JCFp3R0Krw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09kam6f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:37:58 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6c4335eef08so4686691137.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781624278; x=1782229078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SQSOq1nUaTQYn+8T4eSNQARqvt0C7ZLcRVfVS7wEbVI=;
 b=bIURO/zXeRtI66ZeOEb1UaNhapeVCKse42EewjRYHBE6Wvb/HF4DipDy6NxHR5wkHY
 WIar4g/HfZyrLXdotSiwqbZnYKlLE8hv/07us/xc+XPUvZWSfYmuyhCjfvg0frUFLdXV
 JvHjTJmia1kC0yQOy+yIGUlmry1eu+Wzq3CeQM01KtaltQkQu63AKsD89EZQa5jYxucV
 q0hXN07R+h7m1cSSLpJWwHwpifLehlBa1fSbiGa1Jc23mC1/7x+FQroyINfIRJ3tqgyl
 oeZncGLFL/SD/A2PFYlQpi1xk17GPO5Lzd471CeRR1PKI3eBaTM2iBrEIG5CX8OcVAzV
 7kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781624278; x=1782229078;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQSOq1nUaTQYn+8T4eSNQARqvt0C7ZLcRVfVS7wEbVI=;
 b=sULRb3TJdArV0YfTuY7rS8P9ppc/uDyfNu8i42zKjyaESRfYWj5cAjy+pQSBk3YofE
 XbflUGF9QJb6y9C4I/KtGEj7bUJKfAGuLjokcsxilQRvVzwbWOXiPiEUMk1oTMJWMn6W
 GyTmTSnrtrIf4Sv5/Bek+5zFxqzq74PhEUie+DwLP1FNAaFm+x3MgCKjDVP7mEUPMcHb
 2OikLTLLwYo8ke+zioqx2cf0Kj/4044WTDkyxzj674n4Wqe8akgprKeDoQvVvecovmgS
 an0evlHQ5gv/w28qJWo+jCTRe/hmezCGDbaFf+PmOCxELU9PJwSwwk/xmUfchHtWoaIu
 Kn/A==
X-Gm-Message-State: AOJu0YxhdZoo6pmTOu0qwA8uWS0Wri6hGyHYeSIDNymK3Fr2X1Tu6/LT
 WO32DpVhmCf88YoP7tEahLayy0oVAh0v1ddWYE3Xss+3f8TGzhogKN3Zkl7ECb9I31XAyPMD0Nw
 UibXWTXjhnG1m/Mz+iONJvFgl0v19RVhsAM4cTqroliJxbcp1c6xOZ8eSUyr91vgdzA==
X-Gm-Gg: Acq92OFUsgFi+yPlpeDlEDgQWuVp+PyMU76Z+bd0TMIYlEQFvV1ALJa4xIn8B/6SWsI
 aJdUgDXBEjLAtrA2+QwK+J0IAYYNpB3KuGIGZl3XSnDjp0VGVoNCZGSad+Tk8LoQQ/aHeJlLnhH
 UA0rH+li6fZx+1Ek/FNkWaIhevA7MC3S1R9u59ffAvX6d3osvjc7lkt0Aj/vQuZkvwHjoYmMcAQ
 5LtACRZmiJwK61arcL7MBu7yWE5zRqauS73LaxTBO2zRghsnRKxrOmr7J7OUzfMaSDuWhSZEnsh
 oFHMykWAxnEOBOI0eTvtfzNw2WkzApCO2T9E/v+k83OFk1CDkHERdMTfHjQJV8wfD5Rf892B+NC
 NQkFWFSo8hj3uV60NaJdcwMAAAxF+KlxrxDYpVfvA60NhegTYlH1WMEBhFVJF/+2//ZAe3fOjnk
 BDFo4=
X-Received: by 2002:a05:6102:3f9f:b0:650:967f:fb32 with SMTP id
 ada2fe7eead31-722d7d65ee0mr2794109137.3.1781624277729; 
 Tue, 16 Jun 2026 08:37:57 -0700 (PDT)
X-Received: by 2002:a05:6102:3f9f:b0:650:967f:fb32 with SMTP id
 ada2fe7eead31-722d7d65ee0mr2794078137.3.1781624277227; 
 Tue, 16 Jun 2026 08:37:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa3abd0sm98032185e9.1.2026.06.16.08.37.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 08:37:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 0/2] system/memory: Rename cpu_exec_init_all() ->
 machine_memory_init()
Date: Tue, 16 Jun 2026 17:37:52 +0200
Message-ID: <20260616153754.93545-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX/qncE+eIuGMJ
 OMvTiYBuo7pFc/QsNd2P5L8eUfeIeVa0j1t20yJtrkEnJam1SElC5GTGypNaXSU3wLx2bavY62b
 o5fojdg3q0PpttNTirjNX/hDY8SNrJE=
X-Proofpoint-GUID: 3wbuysrfNRLXvzNrDdr18Q4WWFu1Sl6j
X-Authority-Analysis: v=2.4 cv=DoZmPm/+ c=1 sm=1 tr=0 ts=6a316dd6 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=-4qgqlqaFbubNfLM0sYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: 3wbuysrfNRLXvzNrDdr18Q4WWFu1Sl6j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX1N7kyh7vpyJm
 9qJBl1hd2SxtpKfvmgRpvjNGd50hJ1RcaW8xsQrSLZjAKg36ML8RYg9T+quVLp8PZINFuhgyIms
 x/PCZILIxsa2X5BgyCJx53rT6SWQM6CPIk4T5LRmbL/wOA9rhFUU9liPOewUJCtoHeMNLcvLr7e
 Sa1o3s+/vPPoISGldEZiKLVMKF+yZMeE8GgoR+glfKuF7y2x/CZK+I8tTtaDOHz3+IMuN6vlFTy
 xbjnuV2YeX8msxvK+7q2JuPbt7bNlNlzqqMda7h3xZssiPwUJ8qFsi1cKNNoQgS3/OAa1v21+Xh
 1HJ3PI5hfp6y5TPdwA2GtxU61TwiQwNDvLl+vau1LMX3COab47tupxLCQPtBPd75LHvv7jSbkik
 qKxlzTUAq4nAWTv7xpLQprl2vnWXKeVjPiu/M6jjHLaMuMTM1kQ81XktsWdrzsF2IBt0aimFi3U
 4wtHNSe409ZMkvq9R7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160159
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

Make sense of cpu_exec_init_all() name, renaming it and
reduce its scope.

Philippe Mathieu-Daudé (2):
  system/memory: Remove unnecessary CONFIG_USER_ONLY guards
  system/memory: Rename cpu_exec_init_all() -> machine_memory_init()

 include/exec/cpu-common.h | 1 -
 system/memory-internal.h  | 4 ++--
 system/physmem.c          | 2 +-
 system/vl.c               | 3 ++-
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.53.0


