Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EE4CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBvI-0006zt-As; Thu, 18 Jun 2026 08:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBvD-0006rE-Oc
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:32:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBvB-0001EP-Gm
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:32:38 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAtVon1516072
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 De66LsRwg5NCn74KfPCcd8Su6NLJVp7+yfcDMyL91sk=; b=Az/N90F/VPim7lll
 nalq9c1PrEHaOWOFEDqSj0K6+Ig8ZwHAwEy6LSecuLkdTiEKRJhHgb94eOUhDItX
 cDpn072r2bD0VRltLyFlfNQqw9qkRgTZzK5X2d1K4niOqsG+Bd0hnHd+fiLeGRCQ
 P50JIj92L8M0qNScK3meRrgSZZMQob95bJ2KIAwFXiWJR9EpAatrkfSHAcGMUxb0
 GYawpMrFaLlLl+mYtTqA3rpsAMquwCFETXyCorA0hIZbRmOsTssbf0iCAjBeqGfN
 iD5/N7BfZIrPd/BU+/gR+REXuaSiUIFJzyntaGwe8RF6EONIEq+rWzEINsbC0bk2
 ZSEzBA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev19a3arj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:32:36 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8cecb6dee57so37631056d6.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785956; x=1782390756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=De66LsRwg5NCn74KfPCcd8Su6NLJVp7+yfcDMyL91sk=;
 b=PLaepwQw6D7eg+XODYLEZY5hlmKZ3m2068vXtziPvHgUpHJkNsVJpWzasPFUH+8Ay0
 XwetErB1LTgDUtq/mpEk8zJTp4AuxCowUKOcNc3BDYuHY/iXISCl4e30vtr11nFVqeWx
 Cda7hreXQ8EgK85i1T14+RHIvzOtARvsZA19Tl3SSEjOhWphyaG0hNRbkhXZSG1zQ9AF
 Ny2VepMLqMlR2DTKFJwaC24cXa5oTcKJi6K/8m8bQE6JBEYQgnKzu3Jf1gjN613eCmxG
 RyWRtpAIOvYwm2zm2H2EKBwDYLKBExyO+4rW9FK9Y3RDA2h5SO8ss6PJ4Pu9f/3pLu9f
 4jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785956; x=1782390756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=De66LsRwg5NCn74KfPCcd8Su6NLJVp7+yfcDMyL91sk=;
 b=aT50ZKkK93r/TW/9Fh2G7TRbA4RphuXK+Zoq41+ma0jzpIZoZmwoEfqqr1/iQ37p5L
 fQwNs8XbyO4POIzQwvJwqp/O9uyiLehvQIVpBpipBWJ/5V2XDWo2tD54U+T9cSkxqyMt
 CGc0EuYikK+GEMjsLDBarMSXT1C5RxLfb+QlN/n2ebb0m64tHbCVK+PAiIFgaGMYnP2r
 8c2zoODRQryDI8Scx95ae5t+veccUlXrixTu7yzGsbpJ4mf6kepJSvnLi8vrqzBCUF5g
 AJaOPFmN24oHxmObBcVd4+sSOU4k07oO+rCOdhhpaXshwM9OATRPN6Ak2WHr/MzWQ6ob
 UpzA==
X-Gm-Message-State: AOJu0YwferxWQ6GHhQjqbDc/22qV8d9LTWYFAeZy5kS7oF4tk1gI6oRh
 JkLGBXzfyJT0i4opAUR+hKafr5tbOZg7BztvkRqd1zsX7ucaX9E7OjrCQnyEQAnX18FTr+Y/Wih
 PciexaYtOzSbuF883wP7yI0X+JbF7p6BtZ8DZmVBbvc+rHZUX1ppe/dgJnSHXRY9o4A==
X-Gm-Gg: AfdE7cmviChu7aMns5TqRI5OkX6SbrE2PEkcvYckc6085VwKMDzc3MUsvOQB7kvURhj
 DliEaTD7jQf6Wo3VvEMHM/U8BkfiUc0lAJSri45oL2VHQj0X/CUO19x5YS1TQ5m7p/fa3AVzJ0M
 tViOUWuy4ZBds8fvJKPWmR9zfqf4kjQ9IUNqiU7IYvdoh2UbX5aj/KC3SXAfQBrFRenxL1AvX/G
 vCluktDZoMOt6EZl51K2j1ti9SPkmNbuTac1Nk8r03uHUunHmJEGaf7X3OXKY/F7/zQjC3jOZ/6
 E7t04eyaNQFPA4aolFKxjTV/02nMjJAc/yGzLtLbRQw0vJaOv+3r5+JjHQiR7Vht0xeCcTYaTlH
 MQiXuZm4/wfBJAoWoMa8qo4ROAB+xXfaFo/tl+VQsq1GOHJwnQXLqS+E1qOdBtg+ubXOJ
X-Received: by 2002:a05:620a:2887:b0:915:4217:bf0b with SMTP id
 af79cd13be357-91f08bd2c35mr510676785a.19.1781785955766; 
 Thu, 18 Jun 2026 05:32:35 -0700 (PDT)
X-Received: by 2002:a05:620a:2887:b0:915:4217:bf0b with SMTP id
 af79cd13be357-91f08bd2c35mr510673085a.19.1781785955328; 
 Thu, 18 Jun 2026 05:32:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619b9b7750sm35007039f8f.6.2026.06.18.05.32.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:32:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/48] exec/cpu-common.h: Include missing 'qemu/thread.h' header
Date: Thu, 18 Jun 2026 14:28:11 +0200
Message-ID: <20260618122825.90331-35-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YbmNIQRf c=1 sm=1 tr=0 ts=6a33e564 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Cu_OB6cER5A0ZMY7a4UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX04GVx19A5piH
 ryp83s6g5FwA42TmUESvmUIzq43A3Uj5iA1+kmrjCD9YW/PMybe8++ALi4kKiTNVzlAdEwhGyrd
 Cz+DxWzBRTCqAUUthuc7tjkSkQ7eB/o=
X-Proofpoint-GUID: Jiay-HUox8XZb8dHjquCTBh_8Kk7bGYH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX/z42VuQB4ag9
 x0TgkZP3UkNrUwheOBPPeFZ2uOECQXUCWNewqVKnCi4QElxQwZcokjKzDDavOr+GLBXfdP9FzXw
 8FzbYInw7JeF+KmjKKEcATgvP/oxRmjuolyNR+VNyqT9YTYo0qzz9Xna9NHhEKBGxzapuGoP6ZW
 i15wUU+MV4gGAZuXkSVhkYy7DtvNHHscHXZ6LQfuKLI2v5m2cIcw9MYaeseIMYEYhSNES7u0o2H
 dGp8XmZRkAa91LXpEQj5r4UJF8G49nvbINhxPLU8lYrSprZ+OvDH1CnZ2HtFTooXLk2v1AEJFNf
 61cNKxMEiY/2FFc1ndC5p/7agD6nAQtF+Svi2I3k56KIdO1IYScw0+d3v07ecWfMbirNtT2EEaE
 ArByrU1v9IbEF74fPAQUaogPvorLWNGkxuDwMQNgyH6omfVrVsWlG6NODMTCIDNUpEO07mrn32c
 q28ecLXG2RsjobjDYmA==
X-Proofpoint-ORIG-GUID: Jiay-HUox8XZb8dHjquCTBh_8Kk7bGYH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260617160426.64461-3-philmd@oss.qualcomm.com>
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


