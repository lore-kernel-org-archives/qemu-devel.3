Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC71606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PaVQSW1m;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T78TMAWD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUB2N-0000p3-8M; Thu, 19 Nov 2026 17:55:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUB2K-0000oC-Ky
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:55:24 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUB2I-0006Pz-6Y
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:55:24 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1F8Q373338
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=+OWBaK6wRxlY2ksFvNcJEy
 NqUaSB/hWBK4PpcQTxx1g=; b=PaVQSW1m8BhURItNLrR29c7wq3ia+/uoTUhoz8
 0aN6Ocp+jF99sjNdntTcTDMUi23+7MaImTPo179FjTEK/EsVA+MwPbXO7nb/Uxea
 uB5n9FZtn3knCxgXAh6QHLrtljudBimaBIHbxxkKbg/Dt83mIVzoi/FcByFE5EtS
 MOZbfVoTc15SLdoUS6lRJn3u0MsCLFKMCSv4ZM7xrSDgHTNOGJxKoOCWPHJUqFEI
 xXwDic2fiMLVxqf5XwlDt+XZx7oeMwjJYQgKuMjdMiaPqpBp9rYZmT7TX/agmVHT
 qSgII/xT0bPJ3C0NhzBHOVxaq7qBOAu3O5vofEgrTlqHS46Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xymkfyt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:55:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f33438950so60267585a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 14:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795128919; x=1795733719; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+OWBaK6wRxlY2ksFvNcJEyNqUaSB/hWBK4PpcQTxx1g=;
 b=T78TMAWDXOEZKIWZfXDTjMaO/RYP4E8VLt1TPcRJu2vvfT5fM9qUvDzmuZsiKuXTQF
 nIwaSqu1P0RVhvM46t48Zkkk1fnDvFjl9FA9M8ICc7HXuS1LUGxu4Botxdm3dEt3SOIW
 E/5FVM+Mq740gu9z32VywVPxKdR84eXQtn9a2zIgSsCs1hMmwlxOkpcvFppgP9elcNrJ
 I2WfF9i0PJ58Vrr6ojmmFtu0aAyshm6R0WCYrgSXjAFuu8HmFqd4uCudogp2AXkXrnpc
 qUQdwK29b05znZ2b84IxOBNk9jSlXGCQOVxtj71au8o+bkFnwSvaRVCAvGh/NBnmHjyJ
 5bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795128919; x=1795733719;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+OWBaK6wRxlY2ksFvNcJEyNqUaSB/hWBK4PpcQTxx1g=;
 b=JfywM9Fp1OCFmKgJZVDFfhPUWzHDqb0C5ZlV5du6U6Jq95GMRx/hV7v42Emzcgr5LM
 TVNBw2omR32gDqFGcbUXNkUqqEcdTiMAlKKM080U0XhyeUQVUzJgR3b/pT86TBsN++3V
 FFUUbC0yEMXfLA13ZrLdPK54j6ovjn8LOex26yzkrdZ1neS02JhLfTIT6GlRihhU2CD/
 dY7acSaLd1WHqXZV/n6ZrOWQ4Tg1p6mlb2saIkMOlNH+IQwobelyAJuxjYp5p6hST2iD
 vWhgROw55QS2YSVaryftLxcc50s37NfjSgQ5kTziMaxHVrq2WiJ1rKp/mREdMOMa/Xv3
 vBig==
X-Gm-Message-State: APuU4Z8os7uJ5sFJ6a/2wg5xaqJPnZNdARpVSklkGvbPiq22JuoCSBLS
 NGg5nBomJ2PprzxuaiHVE/5PBq5Ow35jIkoAE99Wu4qZpot9q3kvqGe4B3/Nv8RwtSmvv4gB/O2
 V9YhrN6T6AbfptEClXLEtpdlx/En9rUJld5LquSkQ427rGo7+lltRLOK7Xa5XNqfKsKoV
X-Gm-Gg: AYBFou0oVnQuYkefygAMl5m80kSBt90HvewFH/FXcKNk4wct73rg8mXlxBofLGY62PT
 LJL9s9Ic4DQJrbFWFQdvcurnP7oy8v7PaULtXMRAWSeTGxGBZSvKqBujnk6CYcXj0eTDcoY72J3
 y2KsYNSp0gaald9Hy6wQc/hLle0tH+8hGEQUCSb//JPTydw+h1eInG1iY/qPxVPo/Z3AXX9EEyg
 Ee9HhCuKIyFU/+WYvgEvuZjVi/I1GdRHCCkSM0inw+5aMofH9QZ8msL0IfCPoq4l6OBNOX6evAT
 Tae0aH1lTfti8+0q9xwadhAAoukmY3/itnk/Djd0gU84FtfJYRlKHXjpX7RcgOOu1i4W2i4F6SV
 JcCQzdj+uNepyTNdLGx/mAhWYHDJX2zShK+Nwxo4Lmnzdx5CRe9I1rTmZC1e/FWt5gqkhIf5wkQ
 6Wi6l3gf5xQC67Fg==
X-Received: by 2002:a05:620a:8396:b0:944:192:85ef with SMTP id
 af79cd13be357-949ba95dfc3mr191354385a.22.1795128918884; 
 Thu, 19 Nov 2026 14:55:18 -0800 (PST)
X-Received: by 2002:a05:620a:8396:b0:944:192:85ef with SMTP id
 af79cd13be357-949ba95dfc3mr191351085a.22.1795128918456; 
 Thu, 19 Nov 2026 14:55:18 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fec7sm1916130f8f.26.2026.11.19.14.55.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 14:55:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ashish Anand <ashish.a6@samsung.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 0/4] accel/tcg: Yield round-robin execution when another
 vCPU wakes
Date: Thu, 19 Nov 2026 23:55:10 +0100
Message-ID: <20261119225514.4080-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA5MiBTYWx0ZWRfXyMdhCY8cVT36
 W4QCkxUsHKw9CcNmOFBgIwQ32MZ177NZKIC0MRNZyyEDzIaIAz5+5bB7H/kXg0I0c2wwWfESJ72
 eAWxI2o9IFvrngG2T9v4wdTk+3pSRdQ=
X-Proofpoint-GUID: wYP3JyFp2B0IMADi606ELYr_RKkWNgGa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA5MiBTYWx0ZWRfX1/i3rzrxJfg5
 PZCVTjE6tevFyzUxMjHA5KJ1wK8I+xlISkwaZ/+wkjgPQaeVSB8Qe92kjgUlGFuvLXdjGNYvZXV
 qr1hUXaMgzm7Umdrgyn8R3Pf9zROm8xOMXuBj0FVMT1rh/nWDUFl/KTj11NcvEHrZE9WS64Q/FR
 jTmIuFeT/8Kcu4PvCfCX1aEyDRJmIIr8GvQwE7EVtXsvMmJqQxQQsgzLsU5pohkOk8b520esGbx
 SmGsIM5Ua/V18CPFAFnoXyEkPuqEk5LSCevKpDHdb5V+1wg8/YtpjruS8D3RpDklcF6LCd3Wm4s
 nKVe/xzbEXyy61d/RftD0PMuz0F/temITFu2juM4SNyGRSHsgBeJN1vu2+53xzVNhS6CnwlSsbI
 VEuIvdCYaM+nSA42nDskcn6znarG62kK3EoHY8+1T9C4E7n/IPVS0LjQw9YdksVYSfFY4e3vKss
 hNnjdOSdzvvFMuGKjzA==
X-Proofpoint-ORIG-GUID: wYP3JyFp2B0IMADi606ELYr_RKkWNgGa
X-Authority-Analysis: v=2.4 cv=WKPqzXsR c=1 sm=1 tr=0 ts=6aff7e57 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bx8ltnTHI9QTFQl5oWUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190092
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v2:
- revert c5ec1bfad103 (Peter)
- cover icount_handle_interrupt (Alex)

Philippe Mathieu-Daudé (4):
  accel/tcg: Yield round-robin execution when another vCPU wakes
  accel/tcg: Check current CPU in icount interrupt handler
  Revert "target/arm: don't pass env to the sev helper"
  target/arm: Kick other vCPUs on SEV under TCG round-robin

 target/arm/tcg/helper-defs.h     | 2 +-
 accel/tcg/tcg-accel-ops-icount.c | 2 +-
 accel/tcg/tcg-accel-ops.c        | 3 +++
 cpu-common.c                     | 3 +++
 target/arm/tcg/op_helper.c       | 6 +++---
 target/arm/tcg/translate-a64.c   | 2 +-
 target/arm/tcg/translate.c       | 2 +-
 7 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.55.0


