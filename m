Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2BCCA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 19:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulYKp-0007Dl-MA; Mon, 11 Aug 2025 15:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ulYKX-0007CL-Uq
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:37:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ulYKQ-0003qP-BF
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:37:12 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BH3E8l023153
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 19:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=jV4BqCQ7axPxM9PQmtQ6+XFZCzvC2QnQ974
 UJb/pmeY=; b=VR/7EjrxIL0d0sH6pXkoHEwLVj1CCfI/4eLnTFYooDH3DFmuPQg
 LUPmyuzLuhXJN+pTcbuHZwnZCu1vgkxciGu5iRWXV13M2xyNx0k0T/caU3ZJ2Hcn
 98HDN30yzudvOc7wZMXmI29QxHmVX2L+0vrSXpdF5jHDE/NqetkcBNjBu3o8mcuw
 JGPXaSfG48300WLZYhln3Gwk6L9q2Hsh5RHyzTv/VNir7uHZnmPiW8xLuUAVQjul
 OukbC5jUZSw7Ie0t+K+Gc67F1YEFfsnOR3ERZRu496a6Swl48Yz4QseUXbeRZVlx
 weojy5r7MNMRTIQnxGgKcTGNlX6tK/AtA6w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem49nm9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 19:36:58 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b3f33295703so7127511a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 12:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754941017; x=1755545817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jV4BqCQ7axPxM9PQmtQ6+XFZCzvC2QnQ974UJb/pmeY=;
 b=A/E1bl3ZuOB0JLMJLlcfzp2qsJ22OmAArJVN6LVxb4siECI6MOhGgICZR8kO7etCtx
 SMV0Din/Wv4gduqGGopkjcwVD5iC0CbHCdpV0QJBdYCnbDWs4ZOpgWqXehVIgt2j5Bcv
 epaHSHtXoQWdlO0O1q8cG3tVHjcRdBWzml9TL13KeugRaZD19xfVZ8uCd89qXHqGtKtR
 isalA5chePoIjkaHO+KKFtnBx+9c+VqIVbJ7eKv4MuZr8b9L6T5Wx7/srsPkz33SgnpH
 o85MztP9WanQBS9BqtPpuKam2p7JF3mLzIqM+0wbxlX0Nh5YoRcNjyZGGCT8JdNT0Mth
 NKDg==
X-Gm-Message-State: AOJu0Yx0B8N0NvD91o7W5d+dhzemhw2AaPxmdcibdgItQEnHPpD1Y6Si
 3zO88E0NFl0Dgb6GK4rPoBg07FMhFdpZSnxoaPoeuyH1TcqMUAThvLFSX77Tz9GMoXP8M6av/xW
 E5YUu8iufcKItSxj5NPpmJyon4iFMWomQxYqfbUOGa5uBBcBbhqL0rNv5I8eOBHXEnHwB
X-Gm-Gg: ASbGncsq3la0BPrzDOkL/D61NrG52eLMgO0uUy09I8mXswMynwcQE1cw++F5Q3QWvdj
 D/5mUEMNAur79e66BuD7lpdmP2Puf5was5MikGiFGcyyuKOqOi2WcrpJOUjBuTfLouivD6k0GVA
 01+0BHQtcQWxjc9CvMyLIbnlFn+i2xrLZZ9nB15txUcfkkJ79w0OU+bnN82AysxvxLTxAfT2JbM
 ccc9J5N6pRW0KxCdHu8RMlPyF7NzOaFzeiVaSXglMC/LoFoS2kI1DkER3PPdUN8OonJxeU27DvX
 ieCiKwuMprGprKa6EJwub+TG/YlLP7Ow8oA0zvB2+hnN6eM7EZIhPPptlSHN+eDzYp06JjLAlHc
 2DLEOEQetjwOKGCs=
X-Received: by 2002:a05:6a20:7352:b0:240:2234:6835 with SMTP id
 adf61e73a8af0-2409a93f02amr936981637.27.1754941017163; 
 Mon, 11 Aug 2025 12:36:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/uEetUZkcvNCUymebqCVTA5QqeYuof4YKQ3DNb7d9uHBfZcQqoilbkx83g57dKhVhlxvWQg==
X-Received: by 2002:a05:6a20:7352:b0:240:2234:6835 with SMTP id
 adf61e73a8af0-2409a93f02amr936948637.27.1754941016711; 
 Mon, 11 Aug 2025 12:36:56 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbcef6sm27677171b3a.85.2025.08.11.12.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 12:36:56 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v5 0/4] target/arm: Added support for SME register exposure to
 GDB
Date: Mon, 11 Aug 2025 19:36:50 +0000
Message-Id: <20250811193654.4012878-1-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: n1XJ6TC1ynXANggYP5jQehWv48leVuJJ
X-Proofpoint-ORIG-GUID: n1XJ6TC1ynXANggYP5jQehWv48leVuJJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX7MQVlxrijLEo
 ds6X0xuWUZb4uRIgmv+Qk1aeUvgq9LdzSRBg08T4JLM2XYD+tJ5BmiXsRuinHLV/lC3CnCehviw
 4j1FvHm6BuQJcqQ8Q0r2vxSs68vG8ayXs6FadIHTXXuunGl6rYvEI2Z1nebGBAdpoq/C+YUIlq4
 VYa+AxlWse48NIGlELfOVSEW6tBEHxy6G6pjHH60gQYGF+Os7YRGg/EG9W2OKDsdRvXjljvo7BB
 i3XWekHTIPPmur/LX3TJLPVD2HBQNkqru/wUAw6ABWMyVFXYec7VUGYn4r5pJtco5U1m2bLoGHe
 rBxQnDd1CJcrOZr6/SD4ovYPZl27mQDUtQqvKInPE9KnaHtUNRNKDmfXRpd7nyA0frEHMTsBZ99
 tTkvVBSP
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689a465a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=2OwXVqhp2XgA:10 a=biMZx1JPJxggwWgAjZQA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The QEMU GDB stub does not expose the ZA storage SME register to GDB via
the remote serial protocol, which can be a useful functionality to debug SME
code. To provide this functionality in Aarch64 target, this patch registers the
SME register set with the GDB stub. To do so, this patch implements the
aarch64_gdb_get_sme_reg() and aarch64_gdb_set_sme_reg() functions to
specify how to get and set the SME registers, and the
arm_gen_dynamic_smereg_feature() function to generate the target
description in XML format to indicate the target architecture supports SME.
Finally, this patch includes a dyn_smereg_feature structure to hold this
GDB XML description of the SME registers for each CPU.

Additionally, this patch series increases the value of MAX_PACKET_LENGTH
to allow for remote GDB debugging of the ZA register when the vector
length is maximal. Furthermore, based on suggestions from v4 review, this
patch also changes GDBState's line_buf to a dynamically re-sizeable GString.

This patch now also includes a test case for testing SME register exposure
to GDB, based off of the existing SVE test case for the gdbstub.

Vacha Bhavsar (4):
  target/arm: Increase MAX_PACKET_LENGTH for SME ZA remote gdb debugging
  target/arm: Change GDBState's line_buf to a GString
  target/arm: Added support for SME register exposure to GDB
  target/arm: Added test case for SME register exposure to GDB

 configure                             |   6 ++
 gdbstub/gdbstub.c                     |  25 +++---
 gdbstub/internals.h                   |  25 +++++-
 target/arm/cpu.h                      |   1 +
 target/arm/gdbstub.c                  |   6 ++
 target/arm/gdbstub64.c                | 122 ++++++++++++++++++++++++++
 target/arm/internals.h                |   3 +
 tests/tcg/aarch64/Makefile.target     |  23 ++++-
 tests/tcg/aarch64/gdbstub/test-sme.py | 119 +++++++++++++++++++++++++
 9 files changed, 314 insertions(+), 16 deletions(-)
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sme.py

-- 
2.34.1


