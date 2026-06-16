Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3483ACD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZI8-00082v-W1; Tue, 16 Jun 2026 15:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZHu-0007IW-2x
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:17:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZHs-0004aG-Fq
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:17:29 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOZ6T303258
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gMjZZHZJ89izwlDeOSHN+o2bLfcBDraY3E0lQg0dK+c=; b=MSvIn/p/Se/71vFW
 mglrkgv2wzZy3sXxuQg5MQs3VovA5c34JdgpMd54RSZWWTUWT5NTW4B1O1uQA/PS
 ragSL53T/h85Jb+CwfnedvmXFAXBFqVEebibS+qxu4ZFgw2IPq70m/3KjPAGt7W6
 m1WGOEIdLpeLO0CdUGGpoXOsNXAj4RX1Jy4DR27VNe7Ns1kgnhUs70l67eql2Ox/
 owgNIVIVm/61rUgYZXuq252wENI4nhZcJU1kkSSQ8PZLXeKHczuosoVoyyiDDlMC
 AdpOKT7rghk0J/uuizBSohJd6/PsZc4Sgyj8To302EpsUQn5oJ6Bi/LyytFIAWnp
 jKMHAg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1epbda5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:17:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9157c8eb597so776887785a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781637446; x=1782242246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMjZZHZJ89izwlDeOSHN+o2bLfcBDraY3E0lQg0dK+c=;
 b=kMKA9TWpX8ZbBslFxoYcmPVvfjc0J+RXB1Ize4mvKOVU5zuh3OlQOZ9ICNkEdCZX4+
 q3H4oXj3APIOsBfA9Qvyf/LFQvaWHd8j376ItG/VUQ/0Md9ra+gFwJhxvEiXlC39ywNe
 mKUKQlH+Q6q+SxeLmW2fK9bq8aQgyjGkTkiUIVlpNanIEzXFCVy6i1Gr4pKXdmLbeXzz
 E6Qv4ydXpZ85kQQn9UXgomkQnYWTRprkFmZmVIafJOVcm3itRMkxc3fiRLLby+aJvBVg
 RZih0GzOaMfzaQiMVVjh7Sl0WoVmr7coXhYtuLcGV93CGxJD+d216VgiLdgoeydqpz0v
 70qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781637446; x=1782242246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gMjZZHZJ89izwlDeOSHN+o2bLfcBDraY3E0lQg0dK+c=;
 b=X7lBVmc4ZmGQz5FSe6tF4/MLizoTY8POIcUK8yRqOEMkvaIQc5x1RE4e5GzOsSxfFx
 gJz0HDHNou5Uw/+mFHtSgNVQEx9jU8nQYHZ2sChs99JnMiWFWFPhptk1hSZyw4uK5a/e
 UZeTYy8tH0kHK/gUOO/RQbg9mDWhFlVFb2mHh6Z/C+E8qYkq6yEuyMlOe9WuaeVrJ8n4
 4WsMfa75zZEwBcHRcNPY/buPA6uuvSWZX/iUwVBCAHOI4lQUGmELIkgSJwrrBk5GLqU3
 sepWmqJaLBI7NE1t6e/EQhh9VawhEZYuprQB8Y9hSQFxcpaDi/rJVD0FzUfIK4cRS9Qr
 zzHw==
X-Gm-Message-State: AOJu0YwtLuCDh6SOZePmeq9IgOcc0oDmpu6grw+WtkCVz/F8F3TrMMET
 RO63ayGjVC2kYyNi2NgiMiYgp7EMJPIxUAFkAsE3/JbKMYU4lfNvk/FP6kYANUst+X1rn6fVN1f
 O76Wmf3L6zlUqI4ntoyQKNovG+VshHJxWKcq4PBSiQmS3EpvV7SjvboLR71KGeiBd5Q==
X-Gm-Gg: Acq92OFcvKrdbWPiSc+uMoWPRvZfzV1bkfviNZu3aaKTrvQZ3/2LntxVHNqY8kZ0+ER
 VKWy7GyXtuO0m0vCw2EA4WCeRUhyP2tJeAeWwgTF1+LNmYG5t7sDv4k9rJRhV0jrIohMstgn2AF
 is+6zJGwOOdIkpvNs6kKlcpg7cAzo2Xw7n/u3gSa1ydSIBPH8jqOlcbk3Xzda6nmIPVekyIrvPl
 7LOWfc9bdMI9Rh5dw9RNMWMjyvhHnl7lH4FyM/f/C17XI8kui76xNujt34Chti5s7fdS7wWw8uy
 6zrSVO7JNhUNJkRNG6xOeLN6q+vpW5km4aO124FZzrydJdJtFedet8qvhkp8f5v5LQUnYl+Ds4l
 fiBugqdAZBD3pDcV5yNMx28XXDRZ4JPuQEOraATpOcl+z12judjKIrVx+LHe0iu/ERtV5OEyogc
 yjFn4=
X-Received: by 2002:a05:620a:28d1:b0:915:a457:bf94 with SMTP id
 af79cd13be357-91d8b8addffmr187021785a.48.1781637446065; 
 Tue, 16 Jun 2026 12:17:26 -0700 (PDT)
X-Received: by 2002:a05:620a:28d1:b0:915:a457:bf94 with SMTP id
 af79cd13be357-91d8b8addffmr187016585a.48.1781637445634; 
 Tue, 16 Jun 2026 12:17:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f20e77asm49226353f8f.0.2026.06.16.12.17.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 12:17:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 01/10] target/arm: Restrict TCG specific headers
Date: Tue, 16 Jun 2026 21:17:07 +0200
Message-ID: <20260616191716.12932-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616191716.12932-1-philmd@oss.qualcomm.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I/ZVgtgg c=1 sm=1 tr=0 ts=6a31a146 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=bdUS605pY9qKDrP44OoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5NiBTYWx0ZWRfX6d3Pq5dBihn8
 URgcYMafRLldxdcGfac+Ong/AXaqrIVDC3ceOgekSeeP4LRn1NIVKO395iKUGfHqxmBWRfNuzPQ
 kpXh5n10DynCPmMWJ6Sptn442pcbm04=
X-Proofpoint-ORIG-GUID: HewU9jl1cdCI0yfxdWRtaYHkxLypwsuY
X-Proofpoint-GUID: HewU9jl1cdCI0yfxdWRtaYHkxLypwsuY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5NiBTYWx0ZWRfX/8Di9LekEHgZ
 H37QlCZ+TcGD51Ix4PfDCTi4BbCwmOrslTHSwqD4hCLTRv+bBBZEEC5V3OVYjisksBxEEtyD8cZ
 kvANth60hpEPPxLNevnyuqdtuXjveLEDVsvtCZ86kgxldooakt3TcpqFWlYtGblxULMYndt8Q/1
 4dY7HjiXyrsh4h+JPCep2IKPysstJfQ4pJzyPg3yjjPoAMYl1p46EhOludp7TW77qVFa4uTbRrs
 gZjDVb/e1iMaNDqegTt7FyCJlos6P01FI55rOAHvt4AWq6fD0CjQLMVZlgzBWpVbA106urpSnQ5
 JtaKUYVYnYdawCRAfqgGf3GOSaSC/9k/w7GZiH+2JvGYAmcQ2ILMmQnVy5T5yQgU7FcLjmnQKY5
 r+B6yuywsC805QRcfpZzv71s8NkFbsWx9toWEraXEBSdXpCNHlvn+axHWkf1Hjingi9dz6HbH1h
 DHSscaH8FTCR2LwEh0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160196
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

Avoid including TCG-specific headers in non-TCG builds.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/internals.h | 4 +++-
 target/arm/cpu-irq.c   | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f7a57d3ea70..fcce3804f34 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -29,9 +29,11 @@
 #include "exec/vaddr.h"
 #include "exec/breakpoint.h"
 #include "exec/memop.h"
+#ifdef CONFIG_TCG
 #include "accel/tcg/tb-cpu-state.h"
-#include "hw/core/registerfields.h"
 #include "tcg/tcg-gvec-desc.h"
+#endif
+#include "hw/core/registerfields.h"
 #include "system/memory.h"
 #include "syndrome.h"
 #include "cpu-features.h"
diff --git a/target/arm/cpu-irq.c b/target/arm/cpu-irq.c
index fe514cc93af..883e8a176c3 100644
--- a/target/arm/cpu-irq.c
+++ b/target/arm/cpu-irq.c
@@ -8,10 +8,11 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "accel/tcg/cpu-ops.h"
 #include "internals.h"
 
 #ifdef CONFIG_TCG
+#include "accel/tcg/cpu-ops.h"
+
 static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
                                      unsigned int target_el,
                                      unsigned int cur_el, bool secure,
-- 
2.53.0


