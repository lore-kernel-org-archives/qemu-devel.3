Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E4B60A261F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mshxkB2S;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XIU/y5jS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW9OU-0000Na-LK; Wed, 25 Nov 2026 04:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xW9OH-0000Md-N7
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:34:15 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xW9OD-0002OX-16
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:34:10 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9Cfud4048430
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hGnokdfMd69srtdsBIQOa9osDRPgnC3SGupDjDfwww0=; b=mshxkB2SMpzSlKJ/
 MUwag/bhDOKpuWEn2f224C0wmtcInmmw5xxgmd/YuMCQw6doHnCRGb82v+xnyBIb
 CkCKxsJrVhqPTmNLyD9+oCRT/V65ruxvgdxZca9mAhZX/w7kMMLaVCLsbA0DEMJS
 /uhXzuKpD7sPMQJcPtBRHkt1Fa05UIXnYcvWTjQXgFxpUYjO01ZqkxpCl079dqlG
 SlTSyac/7fJIfzWFFqfpc5TzoRY0oY5CiOGTqzKBEBpIRs2Eto7pJURrdKoXpj5/
 kzmX6xcrOonF17G3MdIduRWgFsZzwSYgqFJPU+jJ6DYwn+3mPyY02Ej9CjBl5gjQ
 WJUhMg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vuhr4dy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:34:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-948d83322f6so360631085a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 01:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795599239; x=1796204039; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hGnokdfMd69srtdsBIQOa9osDRPgnC3SGupDjDfwww0=;
 b=XIU/y5jSNYtIPOH5xzaQRS9EiakwHGpUbhwWZBPRkMKMVNiNPr0X6XftRIE901H6Hk
 99FMTdLTitxKaV6fzSUa3Yd3q0a6QbCRuluoanc7ybW09Re06f42ssGR5BcYaWAojTja
 cMVjoPeRClztzsd7e6HrKEZYRa3G7KEdJ3gI3QOOcT6tQ6mm+1DpIPpM8C7vXb8cr4Tv
 pvpT8TrgdK4YKM8QdejzvU39YGSmPMqw1HgtaB8x6y68T9tmNvLiRn4qpwKIteW8smHR
 eN0WqQx8KahWQ82G0gTVzORh/6ZozYaWM4Hii7vVZR43b+Z6X86p3rXD2QhXIdTqsztt
 fyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795599239; x=1796204039;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hGnokdfMd69srtdsBIQOa9osDRPgnC3SGupDjDfwww0=;
 b=VXxxCdlcDhcbKKmZm2CbSBa63nyQUeJ7Me0aGq/U8koAw/hiibx7xGZwtsZcCEuuIe
 0d9MImvHY9cktKJTqEo2FsSHAV23O1rr0LRQmKUgd8gEeICrrmGZ4f4dFpwn201tgczH
 byHC8RmfJjCZItdv3rP01s/MmmdxC50roOxms6kcuwVuv4oRsr4vjSxqrCWn2rdVNoMV
 T+u1+9zRUQSgwo8LgERjjVsusq1fG1xk/omDtWHzYB92sQdfQngGLTIZNN4MwcnG/JmS
 kXl9ilK+4NDckmw/cjVefBEdy2xgPL/ANeGhtbdt6PyapEVNjfZAWGie1r3HbPfROBRS
 GiRA==
X-Gm-Message-State: APuU4Z9o2eXwHw++2+SsFeCJG6pe7HPlPNyI4DFtxTXi1LDX+kXv34mU
 ItmXtsENtvWzcufKK957Stg1Vi2WH8yNsFEnTayh+vZ8Dk0cmrRTa9ZL4R3Olbr8ckaOiVEHxpd
 q87GGLcVVzSOuB8sBO2xiZYPILruxN6JAKoQ5vDToBlWTApd6cJOhwmjAGStrnwz59ap4
X-Gm-Gg: AZFdTZe4NCDG5aPVWtLUHmTPJyWkhFaeqGnE2JTnUtmK/yhsBqse7v7r/4e8nvNuyyB
 +I436VsVi0FMJdKShJJ74TMrBCBS0/yVDnLJ1P0/L2qimZZ8p76sEBd36SqLKKfxEv/6pWcMfdF
 9EeJgoK8ZiwY6gbbUxTalFxvxyFAG17fPM220zJjVUZ64izy3JoJmHR74J3VLy2mc6xJOCXWC8B
 EQIDgSl+gFwCbtBI6gaDq9IaVZLI8WloGGigLQ50FJb1gxCAGP6Quo6f1m8LA4Ih8HS0bMrZRxy
 Bh+OGwKzosLlaOnpaPX5vhEhMktAD3aqvRWFLidAConhgCHQmAqzvpi+aMvbnmelrionFSTmEgr
 3lYLzo1gjS4mRNkZiQp4+btVrGGESNSrirYbfDR0hvJ629lFxNvJT9VtUGEfZyMeVZ29wdqir0G
 8h+8xeOd4dhoASHQ==
X-Received: by 2002:a05:620a:171f:b0:93f:1dbf:6cec with SMTP id
 af79cd13be357-949ba9f9892mr2869151785a.36.1795599239535; 
 Wed, 25 Nov 2026 01:33:59 -0800 (PST)
X-Received: by 2002:a05:620a:171f:b0:93f:1dbf:6cec with SMTP id
 af79cd13be357-949ba9f9892mr2869148485a.36.1795599239014; 
 Wed, 25 Nov 2026 01:33:59 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9067a0e6sm231187795e9.4.2026.11.25.01.33.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 01:33:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH-for-11.2? v2 1/3] system/memory: Clarify TCG effect in
 memory_region_flush_rom_device()
Date: Wed, 25 Nov 2026 10:33:47 +0100
Message-ID: <20261125093349.97805-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125093349.97805-1-philmd@oss.qualcomm.com>
References: <20261125093349.97805-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6b06ab88 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=5wrY_-AilEM7huzYGDYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: _ez0QAAvFN5IXO9oG72kay5Kt91B3fYK
X-Proofpoint-ORIG-GUID: _ez0QAAvFN5IXO9oG72kay5Kt91B3fYK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzNyBTYWx0ZWRfXyR+Qjt7AqIbf
 AG47CNkJnBE+mz1KsSKrq6FgPUHyt+HY8CV7jn52/liBTRUIcXQK/+rIvG9w2RSKsYH/6NcN3fo
 FxhXy3haDy+t++OwGBF8WgheFNzIsN0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzNyBTYWx0ZWRfX72HOLAhcHV1J
 lnay/BxTd5eYTmfkqjqnPznIBECX8y/SRGrH5EAxmZZXcdUwRsWCQIRYaoan2v1sQUmcGcCjplQ
 Kho8rKYVIA6R5ZB8Z1nnipu5fn7LmR9qw8wXBZj+3D3KWBG/2//WGpRBuKlCUuf94duyyAW9J/r
 +qEmTVngzFo5lzAuoJ4F6DSKpCuf+Ka5VWhzhXSbDHS1RCXnuDdS88cGDS7leDKcXz7cOnWkz+0
 JvNKEzFeBcWHslPHAzEWwJdToVbak9k1DsFm/5cDiXlxffHTRfTa7l24fBKJP+oyzCETyujrXBt
 AdIenjaZ+yapIAr9Cx+E6S513TWw9c6KoSii03avKLfToXf03YMM0K2GafZ4/0sJh7bdYPR1qUc
 ArdWCdsKFcfHgSc3i3uhlcEQ6K4YFPLGq+psJKpzHJBm3ljZphcXXsqd8MM+/AVbPcOFpr9BkPw
 oa9VUQ36d/FSxO7Hb3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250037
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The flush marks the range dirty for every accelerator. Under TCG,
the TBs of the range are also dropped. Document that.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/system/memory.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 027ca81bd2e1..298310cffdd8 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1919,8 +1919,8 @@ void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
  * to mark byte ranges that have been modified internally, such as by directly
  * accessing the memory returned by memory_region_get_ram_ptr().
  *
- * This function marks the range dirty and invalidates TBs so that TCG can
- * detect self-modifying code.
+ * The range is marked dirty. Under TCG, the TBs of the range are also
+ * dropped, so the modified code is retranslated.
  *
  * @mr: the region being flushed.
  * @addr: the start, relative to the start of the region, of the range being
-- 
2.55.0


