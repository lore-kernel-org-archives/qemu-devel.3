Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B5CCD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 16:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXiAu-0001mL-CL; Thu, 11 Jun 2026 12:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXiAs-0001ly-Sl
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:22:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXiAr-0006ZP-8p
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:22:34 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BEradh954621
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 16:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=M5qTzV+flpGhSX5RyOdBUPL1/rjE6dooWys
 3uXVSKeA=; b=hDnhxDGt9Jr8+1GinlncO8INTLe2GvZqhUrOerUQ5tAZFDnq9ke
 vbdLwlNCDTtg3vAVw35AlnPgBg9KfisckUJUIDURss9mqkc/Ij16Atkl+F0XEaMR
 lmpzWw6rqWZI7EaqzJNHiICs+UYkmUcDVJ99cY7rmU02H4EU4p5I1U5j2PfuwNL9
 Kh/ZDEXHlG9RI2QzSPheaHTNE0OARpgJ2s45caZUJuD/cLxi0z97LN82u+qZL9gE
 AnRSIKHWbXXJf21zD0aClA6YtnknGDiClbCCxcX/V+QW7cCnP5YuGgMelkXEqKql
 0gTKnpAv4GhukYc+xtOGmsP5e3qFZrjwdlw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqtb5hr2v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 16:22:31 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ccd83d58d9so1359676d6.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 09:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781194951; x=1781799751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M5qTzV+flpGhSX5RyOdBUPL1/rjE6dooWys3uXVSKeA=;
 b=jzephUHuIOGC1stgB1rNXFk41yWpB5d2b9jLeR82K4P9YznAujdi/e31HbGrmqAvBO
 xA0/8xko0zBNoTEIOILLubVt7yCz8Foi2d+50HQyc0kQT2/4p62JipCbJc7KUG7aAG/W
 ecGWDVmIRZTgn1H8QhQA2sr4Oc6CwnytiFp7wIQAJ8l7wEXBQWSqTBDomgd+YDEjuhY+
 yyAfF6A4AGprk61CyX54VxdoJUfKo4tn0cNDhM9xM/P6NwUlWWstX70+0x2fzp8zJsLf
 quFh73OmFk2G1LhZGkprYqu/3PS7dHM+SVFFXJRRwFQ7xczfRuvrwmq5+AFE0112ykfR
 cXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781194951; x=1781799751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M5qTzV+flpGhSX5RyOdBUPL1/rjE6dooWys3uXVSKeA=;
 b=W4Wo9lNsS0YU6hS9h+lx/KjCDXvP9hLJ7kmoM7Y9sAslsDZ++ZStN+FDmSvEDtta6z
 fezWRNIFmxkAQ0P5p5Bq7SsVJ3bQv1ligHZ4UXUr4fnIprbCnRGn379N1QKX4lS7A6Zn
 s/KH4cNPKsQACmEQ4vVAO+ybk/XM7NCtcAcqY93d01dy4eXVC8DDLsMMhKnPfkKpwbt0
 oa6/N85ffn4QnapQnUIkZYcD6Yfl//KyspDoTVPJivUoXnsQkAvr3PK2qVqV2AnhPq9A
 fNHrtXBl46oWbqkLELDUjRLLl8WxyaXYJkGQxwinICbdT1ya5EwsTJfcwk25AnNSTkQ3
 5V6w==
X-Gm-Message-State: AOJu0Yx4Q9P7NDoDf4iegj8pDUxWDh3WCI2+Rpa4Byg/ERATXRASoCa3
 tHlST3T61DPrFckOanrzFAlLTDhCWy93sRlXf2FnjATJ+e3HRXR8R4eQ8VABOI0BofGJVmZRHqd
 PYGwMcbZEbGrPI02UGYn3hKnjZAlyKWBCBzlq0SoO40ebK+JjCKITzGmb9bYf8CHODA==
X-Gm-Gg: Acq92OFJ4lVQN+VSRGo1IxCdtIiL1uBrTl3+ZezFmatgDHgjhrfiIub38mOqVs0oKP1
 dZvcM8AMX5gSpYLJs45YHkQmI0j0HnDZXdMXke1SFlPAaGyIIvcChLsb2io8XerFmBZZ979hC0h
 6mdo8wtpNcz7WR1wP1ZNcyf/m7OfwlfcKpIw1N5Ej/ndx8J+h+v++KG4rqTTTpc3Zw1bPFtAKDp
 RITcERUZxkmNO/nQpVTbghbxXfPdzArTd/DDDw9s3nbkOv7r9a3sR5ReVPxY1k5FhLZC/akHArV
 J2s+eJz9TKpxIreV7ZzQrG3+jJ1onEOFqsqFYHCp8p4afJuJWBIU9en0Wo0iXOrhqPGp+7xjX0p
 yiQFhjS/6qFhJ6hQcXaaL1YGJjPExralOJa15VyP0ik+t5KXteBCx6kB71zE=
X-Received: by 2002:a05:6214:20a5:b0:8cc:e6fe:c77 with SMTP id
 6a1803df08f44-8d1d8246c61mr52256436d6.7.1781194951275; 
 Thu, 11 Jun 2026 09:22:31 -0700 (PDT)
X-Received: by 2002:a05:6214:20a5:b0:8cc:e6fe:c77 with SMTP id
 6a1803df08f44-8d1d8246c61mr52255656d6.7.1781194950649; 
 Thu, 11 Jun 2026 09:22:30 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d1eadaea6asm21879526d6.40.2026.06.11.09.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 09:22:30 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 0/2] target/riscv/cpu.c: satp-mode=bare changes
Date: Thu, 11 Jun 2026 13:22:21 -0300
Message-ID: <20260611162223.2361941-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE2NCBTYWx0ZWRfX7goCMq/jGMNT
 2xbTNcm59yfVIWnAcYyclXaQ6lPkMZ/f4lQ3kcit5/JYCV0ScVMe2H5Og5ZjBFW96ZHklf7+r+K
 4FdNVvcUUynjLrFPVr6Q5LnVPwM/rTpmr4UMkaMoX9/jEtBIvRKSLQfdeSBCwEXLaGPS85t53CL
 mXGKCB6nTbp9MOgWvWMm/otpSTCaY1qHdObE5E+rh7OJcyFphgU03ipNi7RXxyhQWKRDzO85ULO
 DNb46UDIcQB/fsQkBfX3hKEiwBDbx+O0v3HjSWNTtXZPTR/VfniftRt0+Z9yTkM9PXF0XyMtO0t
 B48kzQMtXbcrqzwO0VZ5dDR6NSOwO2kSjVFjMTMGQBuT89AOmn9/MQPYNIFe1lJZ0awzPwXevpY
 MSELCRhVLa+J8SRY8exOPQq+LEMm+s3FhvfnctaIJTIMYoWDkzn9fFrGex7218PFEhUkHKQODnY
 M0i7debMeBozNuMarlg==
X-Proofpoint-ORIG-GUID: -3jtIkMQj2MvWhTwIln7mOdmeu-F8kkZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE2NCBTYWx0ZWRfX8KeJCr/rSuZf
 dpGTXCSMVizxKGtyBoLcjvyqiu4dCEOjim9EmPfv5u4lsZwAjyPa3F0xZqNE/C2dKVNcL5VyrAy
 q/UpSGFuL0QoYILZZbRJvD1pi3vC74E=
X-Authority-Analysis: v=2.4 cv=e6g2j6p/ c=1 sm=1 tr=0 ts=6a2ae0c7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=BzRXYrBwBYCcU0ehAu8A:9
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: -3jtIkMQj2MvWhTwIln7mOdmeu-F8kkZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110164
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Greetings,

Here are two mostly trivial patches related to satp-mode=bare support.

Patches based on alistair/riscv-to-apply.next.


Daniel Henrique Barboza (2):
  target/riscv/cpu.c: add 'svbare' satp-mode
  target/riscv/cpu.c: do not default to svbare for bare CPUs

 target/riscv/cpu.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

-- 
2.43.0


