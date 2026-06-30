Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA97EC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegY7-0003Tu-0a; Tue, 30 Jun 2026 18:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegWw-0002gk-7e
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:02:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegWu-0003mQ-Hl
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:02:09 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDW6o2942512
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TDGo5gmxoqPrcD+LvxaIY2NJFAfGqwPOje2LgjJRDmI=; b=p7ORiCTClpu620TN
 LMuRPjNAukUmjbgKVRK6K3PbYccUiNl0he/QD3zeTMuEtJUySjzDD/8EV7+le+x8
 94dOBxF5xQFJf4aMlgOIKL9KvMY8D0R3ziBMoEpsnbro9fk31goNq1NcqZ3q7wFx
 BIQQr+5Wtj/JnVkwr6SyCQfy0OVN5VJ/RvBJqK6dzNJFHYbXs8chVrSmMy/LZv8c
 LGT5VXeyJOJB6MOW0l5Pnc+0vpY07oNF7/vtmZs5RYVIRF+TnsM7pKb7ATwioNGi
 BxbeotabQLTY1L38lEnSFFWj1DuEhlwHsuViWP8jMHnijAdPkHmKat1SjiCGyEsA
 xhyf6g==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j99h42s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:02:06 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-486055c1c6fso38920b6e.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782856926; x=1783461726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDGo5gmxoqPrcD+LvxaIY2NJFAfGqwPOje2LgjJRDmI=;
 b=kUKqN2EBuZ6VN4FAN0odTzIHDLf7Qhqpuhe/EyS6K4DGkKWpf25UcczQ7hO9QTgmq/
 IyLKbfP9esxboD7Dj3wm8Jtnef54nNRwviJx7xpUxtJGEJhvrUqPg6hSuR/n3NTDAR2W
 j1hF4e5qFwsJyNwoYyCvH/XnpcCspWgSt6+rGT0up5bwCksBnBYRgTOclCOTi1j8xlT7
 wOafItjTyRcdJdAdSdyz40bVnlfW2axlAbYKY0uqBCl/gdi83PVVIvyRQ9zk1LzdNekP
 iGE7DX0nN4AMyhiQyLWAKIBFrwAgXfg/l7BtU+Xlqol63faQjYFGeoX7BKo4oSooHmCR
 XaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782856926; x=1783461726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TDGo5gmxoqPrcD+LvxaIY2NJFAfGqwPOje2LgjJRDmI=;
 b=VJp6ykQiuQzHsFvcylQsIl/sSbrZHMJP7DVidLXtNnG0gW3jBHjCjn+N+z3b1lKDDR
 ehch1QUIAD2yAN3Ujpirfk2Z0Gy0BbVVYBTJxiLFMr5ne8QNQ9R0amAIWWsmMw2jpUzH
 FpzCDrx5qU3B3GVRzqu0RF1R5cM0sA2yq+UEdlVIPE7jb2/B/dQJWM6WQnH44FTSLXVl
 VAvudC3bajlK0MuE3f9aHsbAD4xxI++KGOO/cX1HIn+2/6AQhogDB3ZSCcQyqwShOQua
 uSYCP1eCPqs1uxYvN+u3xtpSonjjaAgalZ7Ko0/xfVVrPzqodEZIUNnRwkdcaDadFc9P
 zCuw==
X-Gm-Message-State: AOJu0YxkCW/wQV2z88x3efe8gH9kiin42CqlXkKgEr5K3sLblxxpolq9
 R3X1D0YiYIlZu5Wnt9UWnjzgSa8Q4L5EXRqdM5IVROmAAXsKyJP3ERThJruUp5H4rBEmkds21pd
 wK5Jy1ksY1zPcHaZpLgMJKvWwUBN3I5lznXi0oAhIdBKU+kQikp7wu8ISNCPW1c27sw==
X-Gm-Gg: AfdE7clxHssGoL7Wviml17EwYOxUV3ksokE78wvo8+lRWBsIlyvRJ+3RCpdASLgQTu8
 lvEBE6G3a6QSsaj6XgYiIf2EPOWE0UQ+tfv2i14UvtTF1YWf7WzILZOkHhIfFYCsKsCWXZGO4f2
 5CehFKau27Fm8Nv0W6Xza6NDs9nj4RFm9dsh7yj1iGFSp/w0wZhrjJItVpa6qkG3i+yzM4cw/mT
 6b95Zl4QAjx4SwwNIpvUsvoNEPmdjniVGqjjGm/qBrNHtWYAwEyuc5RtZTG+lj+Sfw8v8EeeTUv
 IEoZEFOsiVMNeXn1a2i5Cw1e4FWJdRZ5Q6W+zJMsfu3ss8AuQNDxkCcRnjos0EjAcyYJRfU6M27
 9EjzfKOdx30FWS5FyMOXJLzXBZ3YWZM8jPrBRwj1vijpEdeHoonkRfHgckFCwdl8Poiif
X-Received: by 2002:a05:6808:4fd2:b0:48a:a666:e735 with SMTP id
 5614622812f47-495eae3b8dbmr4806518b6e.16.1782856925333; 
 Tue, 30 Jun 2026 15:02:05 -0700 (PDT)
X-Received: by 2002:a05:6808:4fd2:b0:48a:a666:e735 with SMTP id
 5614622812f47-495eae3b8dbmr4806466b6e.16.1782856924654; 
 Tue, 30 Jun 2026 15:02:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4d2bc5sm25317705e9.5.2026.06.30.15.02.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:02:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 08/33] accel/kvm: Always define
 AccelOpsClass::supports_guest_debug
Date: Wed,  1 Jul 2026 00:00:35 +0200
Message-ID: <20260630220100.1289-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX3AScE8v4KGpd
 uj/PLyM0iWFjFoTZG5EHUyH/thjg6GrSiNar4+yiewHEfnpcbQZkPJPJyNRRQ1piUnvzl7TD3go
 hGg0N7IzvtTFoWn7UlQi0qcynSeIMUs=
X-Proofpoint-ORIG-GUID: yJ4b-sQRLu9KsYjNESKNcdNYCw2d7EsJ
X-Proofpoint-GUID: yJ4b-sQRLu9KsYjNESKNcdNYCw2d7EsJ
X-Authority-Analysis: v=2.4 cv=bNcm5v+Z c=1 sm=1 tr=0 ts=6a443cde cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=9RVOebA3_GiVrJoGtMwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX9y1RIgg7C3VD
 dhTHC6XUGbKMWpQpI68EqqOL8ErSfFBisjYPRM7iWpIEPaxqpkcB6BMa9UmISC1PxRLpeqGNm2u
 5gVyBSE28otp2EJafODXSQwM06GzuIYS7QVGnL3YVwZDERy4bfSdD2gKCVTgL798MzVfKFONOzj
 IoiyaBd3UwgEGQ6qrx4OICQyfMmiUEU/Q1bmRjxE8RLpbcff/siQKC5ANIp3ZCqbX4gZKmaEa15
 iUM9muaZORkBUXiiWCmtQxqeZAUE97bw+WgayX23EQxDzEa61txX4wqIe+PfYXsfRE4sba0m4So
 ymrXr7BPGQQW19P2IC68CeMr80H/miutxnXJgIUZlrfQ+1X6aJPRxqziUg/lJ2Ij23+w7m0KZns
 RF/taCRP55Eb7ihFyCWv9FH/yOk/w6Hw1jqpHpFGvpYnVENnKZL5ydOCKL6U7pLMq9yPfRudZqn
 NtdutPyzb/HMc7BTNzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300214
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Whether TARGET_KVM_HAVE_GUEST_DEBUG is defined or not,
kvm_supports_guest_debug() still exists and can be called.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/kvm/kvm-accel-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 6d9140e549f..d7967bc922f 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -105,9 +105,9 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_pre_loadvm = kvm_cpu_synchronize_pre_loadvm;
     ops->handle_interrupt = generic_handle_interrupt;
 
+    ops->supports_guest_debug = kvm_supports_guest_debug;
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     ops->update_guest_debug = kvm_update_guest_debug_ops;
-    ops->supports_guest_debug = kvm_supports_guest_debug;
     ops->insert_breakpoint = kvm_insert_breakpoint;
     ops->remove_breakpoint = kvm_remove_breakpoint;
     ops->remove_all_breakpoints = kvm_remove_all_breakpoints;
-- 
2.53.0


