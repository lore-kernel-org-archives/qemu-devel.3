Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1D0CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZsl0-0003XZ-EQ; Wed, 17 Jun 2026 12:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZsky-0003TO-OQ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:04:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZskw-00015h-JX
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:04:48 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HForqa3265031
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7pLB/PF4XMLflx/qFsUEYFQQEOlJ9gn1mMXvgnzh96s=; b=ohOYF9S2WoboR9gj
 e5wCSpnOwuVXh89lQWJjUP8/pq4OGVmvpMVnKEe85KhveAX3lozMDQa05ZpHxgFu
 TSYkb5DUdeJOoHUhyaRVVrzn+jcSam/qvxCSQZ9KRf3HLZNSY/XXGqM3KsJVpO5U
 Hr2lN593Atw1SqNf4kN2ClThwqXeYloC4LbhPLSCfttILWtBl8jX/SQWq9wpe0O2
 Xf07NdYf2mkuMfwCEN1Z85m3jSv2Z+ZW/QMa6yWzHnlvXPjx0ZB1K0gg9DEDwLYz
 fMw4hAd8N6mTDNRWcGBFs0YhYueEAcdoBIrWajzy4jcbH/aAiM+lpC8MU6euQ/5A
 77h7Tw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2jr80d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:04:44 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e6b73b3920so7261867a34.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781712284; x=1782317084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7pLB/PF4XMLflx/qFsUEYFQQEOlJ9gn1mMXvgnzh96s=;
 b=ELAH1L0O554J+UIiYUBstVVfpAkboAV9Ce4UqQ5coknWReL7c4LIxQrpXM4Bs/NSXZ
 yo8MBQXapWRoZo1LrXWixDeJHJR5Q3RNIVml6aaTPGTytIltSG8TALXVPp8cqzG6qcWU
 2wO6/4H55hBT98xlGeW4Edi6OSDjb55bAgcSySx+LrbSLrk/xarI5ZhYsdDrG0bwfLrS
 cYqCy06oOuRCGcUfHPxJ54fMieQ5vxiJErL0ZPb5b0a1ApPF/qcAFtwhvUSuw8j9NzsG
 yEcIAEZBe2i2xXNitsRPzyGhQq+axYhD7h4y050yXsVs7D/yz5fFrnoh5G6W3fh7Oi+Z
 cQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781712284; x=1782317084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7pLB/PF4XMLflx/qFsUEYFQQEOlJ9gn1mMXvgnzh96s=;
 b=Wdy2BbYM0/0Ts3YtUrp36kwJszXai7dy06qR5y3oPNljObEhBRleiKzb/9eYN5rsTf
 UPzjhRW4f/74hMQm59hBhfOIya7yXLq9XdWtcZgFJwA+Qi3I7i17oDONOd+6eJq7lrcg
 wxk6FeZPQbg5vf9kuKCpKbMVdtkD/kslVG7RhTlyGSxgwfwmv1SXKYlRKDHG/2LtsNVz
 cf8Fb4SqBxWrY6GDEPfd/uCTIlBHhbNUHBHzblRqRbmGAhu+KRaSj+4zbuvs5eVYJc7U
 ggGarOJ7Cr70xMnqmHvV9YTrT03WtQmpakw/u7+pUoXlKFmbZj6tuEcT2WP0OsVU+DCo
 /xew==
X-Gm-Message-State: AOJu0Yz+LBprOsUriG5Xddk9ztUC46FQHiZlBUx1eAR+NbRXtxmwzLqH
 WAQRq6YvtF3hd6bMvpyhVrG/0CF8UHGmlEX4bHvHheQBBUoizms+Xc7w0y+ZxJn06JUpAUrHbbb
 EVq4RKlmQqy2mpHBPgbFDak3jNWR4pYk0xzJLPdiPcapWP6hC5jsDrqOa5Doe0corIw==
X-Gm-Gg: Acq92OGADR+ndY6WASunboBmzHoThBfPJRHSVeLJG662IGwzLpbuMCOfkQ53KxH9gkJ
 JiP9VpHGNdAWppXzg9Oo05JWtjeAJfFmhKEGSCtJiEUo/GhQBYTUV79hCiIwjcRjg+939CXzNWG
 rO9nq2XmqJ6lD1c6FBxGE7+coVBXjdu5GjYv3SK102KAUrCIrLj7qDiNDOO2GKWDwlvWrTlBFB4
 f+JPCJXf+1CFNpYq4O9gr+uGeh5kBJ1p+VOIDv6AQoII0oz+2+VDYD8j8sn8KJnBdpdNEoK60t+
 0f0m+EVatmmewVoJfIE67Vtsp802iyoPW0K/nlU3gBmiNuufnKUP0ojKMMSPtQeblwoPgRZOkto
 OC0tDRGPH3z6VKS/Zip86lY3cMZuB9U+T8H1kRrEguMl8Myy3w8GIFW2J2g4VJ42kfq3i
X-Received: by 2002:a05:6830:6aec:b0:7d9:f50f:96ad with SMTP id
 46e09a7af769-7e90b487758mr4072201a34.24.1781712284156; 
 Wed, 17 Jun 2026 09:04:44 -0700 (PDT)
X-Received: by 2002:a05:6830:6aec:b0:7d9:f50f:96ad with SMTP id
 46e09a7af769-7e90b487758mr4072140a34.24.1781712283684; 
 Wed, 17 Jun 2026 09:04:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d4fsm59645021f8f.24.2026.06.17.09.04.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 09:04:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/5] exec/cpu-common.h: Include missing 'qemu/thread.h' header
Date: Wed, 17 Jun 2026 18:04:23 +0200
Message-ID: <20260617160426.64461-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617160426.64461-1-philmd@oss.qualcomm.com>
References: <20260617160426.64461-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1NCBTYWx0ZWRfX3r0CAX5qgVV8
 T+hSRKQ1U0jj/7gzkNHhnvnrOwukLuCnNGjg4hoRoZAnMKHL9LL0SQlaPq8LbvYEuck8O9XUd8Y
 oByG93F7ZNNBxkonhv8kYNmMHk0UdPjPEGA9qixFQxrHirEILrExiQiHpX19z4GUUPT/DeQPBFX
 qa26QZEG178fhEHdgJTUA5INUjChMmLf3ls87G9kdexUIrX5iQ9IM+WwPMCAp+BCOldBAxi0Khc
 i1RLr6pq3tOewC8elSDT0BUUozCIINcvuopBlsUBhmOq69rw+CVA51A6LH15pdJ2Xywxnhjcsce
 AEAh9DXwkSlnKTs2rXoDRiRESk6gSdJ5yL3b2dPHdZougXftiUdE66N3iDW25pUfEYpSoTXWPFs
 HcTwcLVRbU6KACm/gHug04eOLJPXbNZ0cPw9NNejZ9zeenDkO+mIAqx5PkUak499mCMlR8C421b
 Xyqnp+Nywi9MB1XGU0Q==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a32c59c cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=F0IBwpKotLoxzzTqpwsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-ORIG-GUID: vlMLRUnc25RCXZ8cpc5mB_sL_z3u-_EF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1NCBTYWx0ZWRfX8ZHO6fxLILZI
 WhEbu5jT9YomLL+dO53YwTyx95dZfibbLnFm8vXD87/cisGnLE9pm51kgCxTgCVGgyu9vC/ZaaE
 CnHwTNasK+Pv5H8VJexgVK1kpI9u4SI=
X-Proofpoint-GUID: vlMLRUnc25RCXZ8cpc5mB_sL_z3u-_EF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170154
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

Unfortunately we need to include "qemu/thread.h" -- which is
currently indirectly pulled in -- to get the QemuMutex type
definition:

  extern QemuMutex qemu_cpu_list_lock;

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/exec/cpu-common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 74337d84640..8cddd32ca8b 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -8,6 +8,7 @@
 #ifndef CPU_COMMON_H
 #define CPU_COMMON_H
 
+#include "qemu/thread.h"
 #include "exec/vaddr.h"
 #include "hw/core/cpu.h"
 #include "tcg/debug-assert.h"
-- 
2.53.0


