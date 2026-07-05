Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEF5C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUsl-0001EM-BM; Sun, 05 Jul 2026 18:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUsI-0000da-UP
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:59:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUsG-0000QD-6Y
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:59:42 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665LxHuG2858828
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VdLq6Zfki+3ghFdFd7ctb3ThvHqHp9sVmMt32nHNdYM=; b=c/dS3s/7BLSYeImb
 wcy9ePil2ZrePKFOiouuJC5XmgaSiF/oi2febYIOKYUU97T5HS3fKYLAcxAWbc0a
 jLgJ2/D+gz9di4Q/w5LgcUF0xOpgExtMspYlbX/iCcIcZmD5wfN+0qOPSzR6CS6o
 sGL/V1JImQWRropU4vCSNXZqKpVm7NBu1jDPUTtlsMrN+NT+kRDtAvPG2zUqBBQd
 i28wA/FYOT+VeSSF6gzQNOwBb2q2pj31lVbN+EDX271kQwYUrAEw9QvWyUlxK5Q/
 iXXUGzXYwhIQB6/eSzqDaIbi5aSHN3mH2vg0K6pgQV+oebomAmKSpC54TNcPCcfR
 hdhyjg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td3bgmc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:59:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e53b8a302so216664385a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288768; x=1783893568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VdLq6Zfki+3ghFdFd7ctb3ThvHqHp9sVmMt32nHNdYM=;
 b=hXuL6dXn7ztjbqEDf0tuPYZMeeCViK6+tqcN86nbslb8XXBhwTD+Rz9OM42xhfP+KA
 QdC8Yz/k+Jbf55b0h+EXEVGIs2tY4SxYMoA4fWwttGtc5UTe9+vn3keh5NS7yAxBUfM7
 jD2w5vRcionurqvP8TjFFPTryRFb065hL7Fh3SuUynr97wu+Z6n8ze/8PdAL1w6Hr/D2
 fC5McDKBHqwkeE9yeDtUNhs5XD/QAm9jpLxQxnvIM36pcpl7utiT/WJg838XCmH4maY8
 ltPvsC0JGoMA0p7JIDnNn9J911OxgILiEtwBlV2I2ch0Cumjuf70nEj6fy+Ue7otqXxn
 QO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288768; x=1783893568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VdLq6Zfki+3ghFdFd7ctb3ThvHqHp9sVmMt32nHNdYM=;
 b=mYvgEy+jZcDcY5HUcd1HzPJNWKA1vl+Y6mPACH2Bmob1ue2ajzmq1OrqJYUDx252wK
 CDZ2jPOO5Uex4C5eEXJKO6GVZHBZBQcVqHR1PsE2eU/sZyYPE9UdfNjz2gcaXmtQDrG1
 +uRq/U54/I7ht4EUZwlkTgJy0OPE/F2unvcY5gmt05m+G3IVUgPNySZJ57ZZ9ox+Zepb
 17cbxbhfq8PSkq6xrhZBuQ8hV7zhff4/wS0LPsJHaRsX3hO+gZYhvZdfrsAj0Fyu0kQH
 3xUpPGHoJ1PnpHMJxnwjEOYQxiX4eS1d3Pj2C95teeQ10GQBzibCLT0RSHaE8aEuNxdX
 wvtw==
X-Gm-Message-State: AOJu0Yyx+GUGl+xwgyCenZFwp/rGzr4JGDXKJbSKlG6HaLcNDR8O8kPT
 4422grWqk6ffIavWuOsvt+IzAbvYp5aMLBw88deF0qQAUw985FC3/qY+NL4+6CJsX5ZRNp3+c2+
 Ilq7LQyuIKaOAWN338f6YCpfj0seL1mFbcwBkNnd2GmatSZHxPTNGinx6E64nJJP9EA==
X-Gm-Gg: AfdE7cmRP1w2sfqJZ3xur+fNgaiJ6Fyj6yPpAl/ZCzrm/r9TmGtzhFUURPFFUGNNSNx
 WpfBd0+umWJzyzDfPJF+fL73JH9Za0gfk34e03hD3sHjj+KskAaCXOlplTJ8BPNRkNyoL78FBQ8
 awCFWodbCRcWbexq1rq0l1fXYt8FS77CNKjkzoT+vz3eMYU52PvqsM1unh6Ja/mqSQ3RSmxO+qq
 TWexvi4YVycwie/tWsfKTTyAw9636TF8zt6AG1Cv2flKiWd66QddJ8BH2EaXVkJKHHgnFHuIBaL
 vUgK7JoRtZcmKKGnY/LHZzsmQ9Xn2IPXMeL13hiWVq3yGRFj2Ywt19HNqCDqyD5ptDZshrtptQO
 p+bN/m9YKW/VZoNqCU8ys7rSo/VblLK9dezn1jjpG4MiwuSVYjGOKFpg1T2PnS9q6GiVy
X-Received: by 2002:a05:620a:6489:b0:92b:6805:eae4 with SMTP id
 af79cd13be357-92e9a50fa0bmr1124321485a.65.1783288767885; 
 Sun, 05 Jul 2026 14:59:27 -0700 (PDT)
X-Received: by 2002:a05:620a:6489:b0:92b:6805:eae4 with SMTP id
 af79cd13be357-92e9a50fa0bmr1124318985a.65.1783288767432; 
 Sun, 05 Jul 2026 14:59:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b0cesm18580294f8f.22.2026.07.05.14.59.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:59:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 15/32] gdbstub: Make default replay_mode value explicit in
 stubs
Date: Sun,  5 Jul 2026 23:57:11 +0200
Message-ID: <20260705215729.62196-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfXz1rTv+9YtS8u
 GG6bmGgxOYZHiTiAKnGBjXsxV+5E2mkj4vuCBEAvEYB4Iuwb3zXv75ml3LtryfxZc6dlUKolxva
 YAeFn3kK1XTWPv8oVNxJPL+qG5a1pvs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX+Ql0WD+MQRgn
 0zKE77ftSCMQMxQmgtNKvntyw4uvXxJflJR3J+/cQzBHpvxXdRAJXya5+jSv4ObfFpGwjs9Tvb3
 8TkQ+PRS7+XjkS+ID8oGAlMnJazXm9wCE1QEbvT7aCcp9DM+DPBfMTexl79/RyCp8LodV/c1IOI
 61f0luPec4X2Ks11uwtdeHDK59qGsGNVlQsilloNa8TSUrE7LOFa+P599JMqF4HBXTjdNvwKxsk
 BVkdWLWHFgU1iPWa9UGAB9nQgNj6Zukdzwfn7VXsdBhcCQ0uR6qkKYrdU8YPFIGuf7BTQluNDJb
 tF/9yi4O+NK5MuZSRBONH4uDgCP30hKgvBQKC6Pl+5lOVag+GrVFnBb31c67ULx3vagvOBHLMuS
 VAlH5DWdDO+KlvSErFYr1FUpVYtqeIzF1VPhHa6uikwFkKgHUqHkuPAc5IE84ozIYE2RN2+z9t8
 owJgCZy/E5SH//aSakA==
X-Proofpoint-GUID: B44PcyiH7iejRUsi8Ll2guOVbR6G0cZl
X-Proofpoint-ORIG-GUID: B44PcyiH7iejRUsi8Ll2guOVbR6G0cZl
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a4ad3c0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Cu_OB6cER5A0ZMY7a4UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050238
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

Make explicit @replay_mode is stubbed as REPLAY_MODE_NONE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 stubs/replay-mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/stubs/replay-mode.c b/stubs/replay-mode.c
index 439d97e4a87..5bc8f7d6589 100644
--- a/stubs/replay-mode.c
+++ b/stubs/replay-mode.c
@@ -1,4 +1,4 @@
 #include "qemu/osdep.h"
 #include "system/replay.h"
 
-ReplayMode replay_mode;
+ReplayMode replay_mode = REPLAY_MODE_NONE;
-- 
2.53.0


