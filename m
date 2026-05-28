Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CF7CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSaXE-0004z6-E9; Thu, 28 May 2026 09:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSaXC-0004yg-DX
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:12:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSaX8-0005km-VF
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:12:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vqvt124476
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=2VD1tzwDa7yMXVs8tT4zzHBWZk5uSTM6cVW
 eQ2acPxs=; b=nwqlmNDGD3EMoSdiQk5kEfocj0mRVV8YiXWQVRN3xuYutbkEaGA
 mDdlm7ElINHRpIL9YoQVTuP8ENK0YWfxcqkPpSSspq7X0kcHFa3jAKusdVXRCPju
 5Izwx4SqAHIUrAm56MK0UhR59NoUZOXvefYf8LqsscqBw70Rbdx6Oph4d6fkPzfG
 P69xGWZ9qVJFtG554sdDhqwaaflC24KY1GkdMafKJqyAz0fQXknOsILlIQ74tB2Z
 tM/5uO2/9pOvHJLbDibkT13nrwj3gaEpIwa7nkBI7hOrBM1Ud0EZkQjADADqoeMM
 T0rh4jFA7rEqwlZ3gBvv39sVRjb+mxdPgHg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ycatpy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:12:19 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8aca29dcd69so162631336d6.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 06:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779973939; x=1780578739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2VD1tzwDa7yMXVs8tT4zzHBWZk5uSTM6cVWeQ2acPxs=;
 b=LopTXMIguZgkJeTonAoTn/HIS3Qa0UOkwL7/O/Busdh4UTMa54HUd4gYlwrfwQSWV3
 Tpxd9K7Vpm9sSC6F8yhVKw/aQ8CCU/mYE4dJISY4CQQXI/rHQT/OSWM/ARrd16W6tQlH
 Gu38s3CJ4K9zzZeV4er9g3p/pmYCESwtxgxiHcUjpYqHM4r619LbG1ZciyMxGOQSptBT
 88IlP2H8RND8THQNsUUp2lHFDYCkfCS1mGvGd1GrcYBOEiNk4K42tcwfK/KWQH3Ux9Am
 s1E4uUlGNwjHQXlM75wsDD4msn8Ge7na0NUkCXR3rvYlEeabNB5982b0R6QWkkx4Yd+2
 SNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779973939; x=1780578739;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2VD1tzwDa7yMXVs8tT4zzHBWZk5uSTM6cVWeQ2acPxs=;
 b=S0fXoHoAvYPjeX9g3QwI78VkV7qysqOdEl5jGU4DFVhPTdZ/bi26QDFgOkkdwzNXx9
 lHuaQEGEhwTdD5uoPJmxLrLhV7v7f0ouU4Pm18eyIm9qKtiawI1a2H6T3jkt6+1b5Wky
 wt12z/ddoeI0JGgIXVr8oFSE/K2O2fWTWWBkNRT8JHe0iKog3YbAJ0vh2M23CxuD807O
 RVECz7h446/hJ0reBUXbISnbPWnzxIjsPrhZwX8KaYJfbQ70hR7q5Olfk79zfiICL5Ix
 jxmQX+gf1a1r9Yzq2qfTjW3JMrSVuApRAyqq3PLtA9d74FVcfszkhP3DwmwlIn0zK0rh
 VX0Q==
X-Gm-Message-State: AOJu0YyGorIicXaZ08YOxueloH3JqWFzzUMakT9FNrR8xSCZo6hmrqPX
 X6Gq1sEtxv+b3yfe+t6rOYv9A+ZPiBcrJytSy88V75ZPDH30FWsT4anxTb4I9xeoovfWv1QG5Az
 LbTGqUBgkiS8GF4mI4abq9HIiDeG3EJx1+vV8bBh8v85U7iivps0RZagZQ0vscQI5XQ==
X-Gm-Gg: Acq92OEsMJGFCOfG8suExpRBtxPnX3uwTShlkDG7CEMoh6unHRu6ED7XYNxLpZRihTh
 wccwr6YDvd2OBCZrTxbmHPo1mDuLSOgF5Cshdb+H2Umwy4xvm5QAOj7zt49NjQ7sb+kzvv6SZn1
 Xg7oUoSkx33pq7OgPVrbIyjhyipYLrTPN0rqPzETkKVEyNprFSHcfvi1+94GheJNu+tcVaM9mig
 DkZLWyphWREGe+/ex/xquCvWD2DxodCknTqdGwZpnFFxwg35vSWoecQ5aM3MQ5GpGuo/u2W+Flo
 uZSLmbM+GjhZLXM3tzonqPl+CEqT0OwXtcFWZaT7kJpBv3UsJEjqZ3nOfz5qpJHSxq/XYUYq63a
 dnR9v51eZvMrMIvTBXWRe6+GR4OC3hpuGTSwxncovDtMqphMbQgd0f970OsgMybvFvd0dpVQ=
X-Received: by 2002:a05:6214:2c0a:b0:8cc:c85:8aab with SMTP id
 6a1803df08f44-8cc7b61c1b2mr436561976d6.15.1779973938828; 
 Thu, 28 May 2026 06:12:18 -0700 (PDT)
X-Received: by 2002:a05:6214:2c0a:b0:8cc:c85:8aab with SMTP id
 6a1803df08f44-8cc7b61c1b2mr436561466d6.15.1779973938449; 
 Thu, 28 May 2026 06:12:18 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.193.103])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cccf5428f0sm25000796d6.39.2026.05.28.06.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:12:18 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 0/1] target/riscv: deprecate 'debug' CPU property and Debug
 0.13
Date: Thu, 28 May 2026 10:12:13 -0300
Message-ID: <20260528131214.2251075-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VOntWdPX c=1 sm=1 tr=0 ts=6a183f33 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=e/1ukXmujkxnBaF7Br2KEw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=bGfrn8OicFjwyuoRC2gA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: u8CyqbIwtWhhYM7JJMzMeYXAjusXXxt1
X-Proofpoint-ORIG-GUID: u8CyqbIwtWhhYM7JJMzMeYXAjusXXxt1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEzNCBTYWx0ZWRfX+DjM14ODMaR5
 W85vu5SEyWjO3FNm3KP9YNejNXC6eZR0BUvJIr++7MGDCe8GXzv3W9zWnLSQhJRsZ1WrHsNKXjZ
 nQsuYV2h0IjgbWSGIosTKUXHOXv5dXZMdQ0B32dSuaQt82t14WN4Gn9LMg/P0DuP5dEEyXmEBeB
 ySuNsU7m/y6qrXGBZBnsXFWoASsoQC+hhTw9kNg3fp74IIQiLBYA6C66QZQzpYh4Pn1gii5m5Gu
 jKZBPlRMDQZH2pEdmyqVYToR7uCJZlKOca5sofaMMJgwampaUMf7/llC339zd84YVW1tiR3YQGj
 re5dT8WtIXo8N5g7/rMlqK0o+Ij64Kb0vYIQFV5wjrneNowWqgxf4kLBFIBhMC+lgAm0b6pz3kq
 ln9lIaKrX0FdEVDD3DWLFUyDFoFnZ5jXgNtptN/ZyDdQdlcAiLxSaFnf703irDATXK+Mhy6aDJq
 552c12+c4hyd3P4l8Yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi,

In this new version I rephrased the commit message and the deprecated.rst docs
to make it clear that we're moving past Debug 0.13 and supporting Debug 1.0 only,
as suggested by Alistair in v2.

No other changes made.

Changes from v2:
- reworded commit msg and deprecated.rst to mention Debug 0.13
  deprecation.
- v2 link: https://lore.kernel.org/qemu-devel/20260527181822.1945644-1-daniel.barboza@oss.qualcomm.com/

Daniel Henrique Barboza (1):
  target/riscv: deprecate 'debug' CPU property and Debug 0.13

 docs/about/deprecated.rst         | 19 ++++++++++++
 target/riscv/cpu.c                | 50 ++++++++++++++++++++++++++++---
 target/riscv/cpu_cfg_fields.h.inc |  2 +-
 target/riscv/csr.c                |  2 +-
 target/riscv/machine.c            | 24 +++++++--------
 target/riscv/tcg/tcg-cpu.c        |  2 +-
 6 files changed, 80 insertions(+), 19 deletions(-)

-- 
2.43.0


