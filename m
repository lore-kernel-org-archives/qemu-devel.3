Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4044CD6E60
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 19:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUUUE-0003ct-Iz; Tue, 02 Jun 2026 15:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wUUUB-0003cS-Fr
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 15:09:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wUUU8-0006Xn-9T
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 15:09:10 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652D0xYW2884587
 for <qemu-devel@nongnu.org>; Tue, 2 Jun 2026 19:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=qJcRDGhOkDdFfBkNHmBvbenKCtvysPARGC0
 RLONE/i0=; b=GlV9sm6FRtDPqIsfeSMiUxa2J8rk8ATndh24XpR1cU2V2nKY1Ex
 lng5octnOKA8yzU00m1D+C2iRgbaoT5zhrdFU7d4io2lFeBuPcumXg+xwyyRuPhh
 Wxy+vnCs9Ksdc+gq+5UM5FT1s5vTd20t2yC0t0/OvXToeoeUkpjYcVX9RpSoLpw7
 IBM5O62g3iVqlyqipg7ZAJbFuzXuFmpHwJH9dfTUKh8/dMA80jA3tmI4UewTD8n9
 NYwB/QbTHTyRWMRyjmmOFJDWWgQ3hqOgPblR3ZGeenitM3iZRZQeK+pdBCkPmKWL
 uU8UT6cvh28IBaS760GKXdsBe10wZq6eyvA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsu134xq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 19:09:03 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-96388871d70so5184751241.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 12:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780427343; x=1781032143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qJcRDGhOkDdFfBkNHmBvbenKCtvysPARGC0RLONE/i0=;
 b=KhOoSsmB7fvqf0dTzJow/UOWmw0JIEsnvMutGM8SJ23w+LxrtusPga8pbLE/rPQXyJ
 61C8DyzA8sb2YaBHLCkyjaUcL8XCJaToU8r64GfdfniHyhtZsZoZWBgVSb8yvTrHD+VF
 bd3kDDRTJ8WCceJJUN7TZCyJLlTKfQSju1QSSuCixnw+nclepdso9A9peva9gNLVCOTm
 224Ii/lhUZ/ESCuXWk6M9C1RdUOVBADKHOi0leUHdivfZM2YzzbQX8el3akMyCnCZ1Qh
 K4dMmVEFcZ8DkniHv1xELRZIH4lXTxdh0UwWogquFO3H7g3bY1S8mz94h8+74hKbSnjU
 r59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780427343; x=1781032143;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJcRDGhOkDdFfBkNHmBvbenKCtvysPARGC0RLONE/i0=;
 b=RR8YZSSAZQUSQQs7+qcF/0pjV+MsQHGbhSg6jHpG6nEmolDPhUjzfY24nbnbqCmB9u
 geSFhlOGVf8mL6m/zpQAuaabA6g7OBxfhPzlNuArLdxagnVn8KC8qqXllvUi6XVCKFPi
 vLPYOBvnFRHsVOtWZX2XVYpPCFDOrcIQuruhci9jxK8lBY1gOeMgevETMrpG2rME8Dmm
 NRgWi0Z5BUXhLFOuiZqcGFrA/h6+0LDjerky5y3J617bLXQe2NaHaqlxJwEf1ASBEMcp
 79ENS1ARbGr0g2a0QC4N6t8HlyHSXDKcwWt8g9j3UUmlwA8/jRmz8YEqnGpNp/tqaZpA
 7Efw==
X-Gm-Message-State: AOJu0YzHxlWGTpeRPfiM5eDaggJoT7i/X+13vrNwGwj8j5NpBDilOYU/
 37bc5grMjsqUgfOeE2hfvYe+LlOQmfIwhPxlFR4c3MpXZ4KJDIrkthGlB1Tsd0e7oiKsBrWkBLx
 xilz6DkjYrAwkPyuho+BQPnuF8nuwnWS7jQd7oVtVsDG0Xue7nGQAA+X1AgsYkSuaPQ==
X-Gm-Gg: Acq92OFwKU7ErBHiZNa+h9w8+bOJLzimjEN2qVSllmxaj6f8zklyr7An1nmqDHTtDYX
 iZWau46JkgdveKagPWPV8K0P6pZJlo52QskZbpqmiapdx4Rls1AHYAh69eGf0JOt1XAZqt9SvXu
 Wsp7YzQeuDavT44cb5XuC25VhZ4b7DZpGX3EXsLksZPNC5E52T6TonIBoptRQu/gnM8j/301EUu
 DzR2/CiIhY3beh9O/xv5YZ52nrjEzJHvvjVrhDE/+8lls55M8JCFVy/jmC+BnRrjgLT9Qh+5OsS
 eqD6a6WNlicyx3R+ZtP0DPcGL96u8T64JR6VWI9ifBnX2BDGuDsdaFC/WbyMPmIu+b/NbD/KU5x
 kgfY2zKnjj2cZDf2hHxSobKl855dTODRcxe67n4zrQDdybYJVYpL80ilJuZ2dl7LKBZtACQ==
X-Received: by 2002:a05:6102:14a7:b0:633:d7ec:153e with SMTP id
 ada2fe7eead31-6ea30842a83mr1283701137.28.1780427343122; 
 Tue, 02 Jun 2026 12:09:03 -0700 (PDT)
X-Received: by 2002:a05:6102:14a7:b0:633:d7ec:153e with SMTP id
 ada2fe7eead31-6ea30842a83mr1283666137.28.1780427342644; 
 Tue, 02 Jun 2026 12:09:02 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-6eb649b54e0sm232986137.9.2026.06.02.12.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 12:09:02 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 0/2] memory.c: make memory_region_dispatch_* report
 ACCESS_ERROR
Date: Tue,  2 Jun 2026 16:08:55 -0300
Message-ID: <20260602190857.1506939-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MEBzt2ihk1AmaO8TcGyzdbP8G5KZRp-Q
X-Proofpoint-GUID: MEBzt2ihk1AmaO8TcGyzdbP8G5KZRp-Q
X-Authority-Analysis: v=2.4 cv=MKFQXsZl c=1 sm=1 tr=0 ts=6a1f2a4f cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Rs_2ymaoJBA3R5O5yRYA:9
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE4NSBTYWx0ZWRfX7H3FheorsQaL
 Jx+GmJ9JD2BTf5Fgl3iZxv3qfOVHLu9oo7TcshQiCM8cYlrycFoPrL3l0wBUu1bOPAMPb5a5QjB
 UIb6aZdlEEhlOjlL8adh0J0AF9BkEfiv4Kj/tSZN9HciY/Pqf1SRjbN+HH7QtblExZsjtWT4CEG
 DTHdnYPRX+aMDMMIufmcpptBnpGihm+IUkmm97bEB+xKv0Fjc/dIyQfpesPfB+SBlf/gfsj1xHu
 y1/DlxCoNjv02j6TAtqCzJYQMru3KxKKmOiIjNb4ay8d/SCtpx/JIAITQyT26kxHvT2AKykHwr3
 dGQlXAc08SPKSqnWQ2MlQcV6v1SfzvrRY2gY0j8Wd2Zm+YN0sC3g/2scQO2Git4WBMZmV/FrJzq
 K9pl2IxZV2EqfG6ndA07JW/kET2B+K5oXbexyj7iYc7E68y+L1t7DZ8gISihnGu4fUuu/UGR7/8
 pNmKQ/M0Arg/qamlmRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606020185
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

Hello,

I decided to propose this change after working in a RISC-V gitlab bug
[1].  In my proposed fix [2] I had to make assumptions about
address_space_ld* error return, which is always MEMTX_DECODE_ERROR, to
identify that in that particular scenario this is a permission error.
In RISC-V (and from what I can see other archs like x86) an ACCESS_ERROR
due to mem page permission issues will fire a different fault than other
errors like page not found.

The core logic is on memory_region_access_valid(), which already makes a
distinction between error reasons when we look at the qemu_log_mask()
errors, e.g. this is being characterized as a 'rejected':

if (mr->ops->valid.accepts
        && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
        qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
                      ", size %u, region '%s', reason: rejected\n",
                      is_write ? "write" : "read",
                      addr, size, memory_region_name(mr));


but memory_region_access_valid() just returns a bool, and we remain
oblivious about about the nature of the error found.  Patch 1 adds an
extra parameter in memory_region_access_valid() to write the reason code
for a valid/invalid access. 

Patch 2 changes memory_region_dispatch_(read|write) to return the reason
code from memory_region_access_valid() in case an error was found.  This
will change error codes from DECODE_ERROR to ACCESS_ERROR when there's a
permission error involved, so before proposing this change I did a
search in all cases where DECODE_ERROR is handled via
memory_region_dispatch_* APIs.  I didn't see any code where a
DECODE_ERROR is ignored (i.e treated as an OK result) and that would be
impacted by this change.  Gitlab CI didn't complain about it either, so
I feel moderately confident that this change can be done without too
much harm.


[1] https://gitlab.com/qemu-project/qemu/-/work_items/3502
[2] https://lore.kernel.org/qemu-devel/20260522172502.320529-1-daniel.barboza@oss.qualcomm.com/

Daniel Henrique Barboza (2):
  system/memory.c: add MemTxResult arg in memory_region_access_valid()
  memory.c: read memory_region_access_valid() err reason in
    memory_region_dispatch_*

 hw/s390x/s390-pci-inst.c |  2 +-
 include/system/memory.h  |  2 +-
 system/memory.c          | 25 ++++++++++++++++++++-----
 system/physmem.c         |  3 ++-
 4 files changed, 24 insertions(+), 8 deletions(-)

-- 
2.43.0


