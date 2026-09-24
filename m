Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B74DC98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lKv-00032L-U3; Thu, 24 Sep 2026 11:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lKT-0002Lq-IA
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:25:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lKQ-0000V3-5p
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:25:45 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC4f3v2594257
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /OiUUsinsyrWu3FDQXNEW/coMbkcm3cDaSzZv0h9N6o=; b=Z822KmBJvCqVNvj1
 pLlHhnybkoSx0RwK+UzUbpPspDpdfjTRcMBENs3xvabBnZRakXZ5pHSlXatco5tN
 1DhKzYUfdBDIzDLRlMvumL7HdQ17gZG2YTGyZLRN9xRwe6RglxdjemIPnMe+9lXz
 vypjTuptbMQzvaieNe/WEdiEwgmheB/Rlm3aQ8LeqIqpRSiH/lYtA6C/z3H7fAyp
 Bsa2hI0ooLPSGSZADTVoX6tmnKTA3iuu5iWMxZm41VXv7dokF9a6fITspFbB3G0U
 LXdp8wG3WNgC+xs0HgrjLSuS40CmHzYodZuBdRyJA3WoRIpmFEzsv9KA0V2FWzHz
 YcRjxw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1tjh8vh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:25:40 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-790e3ca4c85so625340137.2
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263540; x=1790868340; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/OiUUsinsyrWu3FDQXNEW/coMbkcm3cDaSzZv0h9N6o=;
 b=feHRKt4dR+iqbDtGnb1FrosCndKXNwyg24OWCOVhYCGt0gAXlJcQwLdjxNRgjnuouH
 XtiEg4opVuUiGE7a9dD92xOIu7BoEySPvqkU87s4Kf0qSJ8yeWoddlwnRWCLcvJas3Tt
 co3z011puLQGZ4z2PGiAvmUu78os07+tQFWhsAK8oIX4lEQm1K9eltAHXaqPKBOP0ArJ
 x0eOzfMhEJLRFUg0HI0da5AIx65Rs9xhcInZlxyt6yEmfCAQAK7VWLMuJYUh/cX8RGKG
 5/fiXjqCQLJosxwVwyR64ShJVpWPH+l8aQCKvXlQTM+vgArbmLuH29qkxcPQVCx3TGsu
 k53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263540; x=1790868340;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/OiUUsinsyrWu3FDQXNEW/coMbkcm3cDaSzZv0h9N6o=;
 b=rDSNshij4JxQVIdpS38t/YyDxQhO0Qt159d4pRXNpJM+UeXqTw+UMDi5grgtqgm4ay
 R7Mxm6sg4vD4VqYNzX6T97n6WtuLnQhkEZHDdAyqHnwmYeSenGKNqdaZ1i38eZjWLYZh
 99icZsYPkj3U6wvUxw53dhkTetgXAYkJ1hWeul6FcvwQjQDnZjtLVlOHzvOfqJ/j6TdF
 VUXxrELdsZHU3PD+VswrbueddaPaue6uwnyUsk2YAbc58DbCBYEAgkbtyQEcF2RJoDcH
 XqHIcCJV+8cSELFc5Bna5jRg1Mjh6NgRTeGh4T0sfk8e8tumkEDLazw89bDtiGt6mvvF
 ONnQ==
X-Gm-Message-State: AFuF++mpaspcc+QMY4a0GiDkIMXObETU142XmhCmNpjPqtLGB7b9H90n
 OC+oVjBSxNxn+0KogbKYTBWRL6+nm/pPL3A/wXHEG0TgdKoZ5vI8lJH7bQD4SXMLz1x/OwOayzC
 Xz5IkwvqUL2DhWwCehyE5c9euRVV2AKHn8JWVVd/FKSo1WiIc04mr6IIKG+aDRtssLQ==
X-Gm-Gg: AYBFou0g5SwR/XVIqdHD/YuVRoPG8kx/ZRa9/F6YaY+Hlxfbt6ogFM7sUpZXIluMqer
 IIqAVBQGDipcKgIjQ8ODvsrjSsK044raOTynaGmyQXtRxR3ujGPS+zSZp1sf842z+WZ8N4yzRdp
 uSDabQQFqABeWMBqsIu9yzX9yP1faf6G4+3uw/161WaLvhAi0NRY+F7OXIjmkAUST6e/1+XvGsE
 1NKYc0E/9niFJeaCvOJEafzZrpwVPL5FLvs23X9nj/5l2TXjDZL0ndhYLZQqveJTXVKBkS1l5WV
 gYEo74bO/nCp9NPzilPCQdmzbRYWDq716lAP/LhU6FH63X7i5eotEE15EAHRfw50gpJg4v/Q/bL
 vdNQsxCzcoVR0yijXwYRRS0VnpYcv5b5x+tOxA1KN
X-Received: by 2002:a05:6102:3912:b0:7a5:9a:3a31 with SMTP id
 ada2fe7eead31-7af1e0ef5f1mr1411008137.34.1790263539799; 
 Thu, 24 Sep 2026 08:25:39 -0700 (PDT)
X-Received: by 2002:a05:6102:3912:b0:7a5:9a:3a31 with SMTP id
 ada2fe7eead31-7af1e0ef5f1mr1410998137.34.1790263539234; 
 Thu, 24 Sep 2026 08:25:39 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5dfa6a7sm116799885e9.12.2026.09.24.08.25.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:25:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/18] target/s390x: Extend comment about PV cpu load state
Date: Thu, 24 Sep 2026 17:23:45 +0200
Message-ID: <20260924152353.36209-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RHkvHmOvbkCInAeASzMcvOyr5brApGgK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX1C7YZJWVufy8
 lXJOlgSn8IZhhNTk7US7PzfOIop+cVOEWbrOEbbDyHOWeTtF/XC2yr6c9I/+w5JP293wi3lU7Gc
 wKGbpLhL+8CT1dZJZA2EHIRh6ykHY3u6H1SqJef5OFga041e39psDW5nMm1yyQdTiMNiP52FaH5
 vNwQ4RWwF/8rJL2MYmVBoVN+FMQ1RBRTkfK7GAXUiGhubV9Pz/ZyS33EbnnXft3KLGeJ+w1D12I
 6kdP9He8GY/94X3E4y5HKAaVIBYqVKKayN9qi4RxMKK3w3jupHpv+FGCrV9qB6Ejhc/btCaKyHs
 np8EbxWqvBaoOHLNv8NWVH32OWYOA4GayVWLcvu08kkMMFWlTtTxAHuG0iuPaxAWhKwdzwZwbfK
 zf4Q/62WYfgRREQq+WsujjojerCiJyLsvLAkmtXI0IBNvQ3ODhlDgOkZXH6U2rYnNu/C4G90tKm
 T0iw2NdCYpxygkW8Eyw==
X-Authority-Analysis: v=2.4 cv=cK11IVeN c=1 sm=1 tr=0 ts=6ab540f4 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=Zim2CNJdGIBW3M_IfOsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: RHkvHmOvbkCInAeASzMcvOyr5brApGgK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfXwciDBHyC0CxD
 YqgX0Grk8Bq1i7wD1Q1BMdzIs7KE4m0A2kgO427Xk6rppUju2QQg3/Uo6BSK03EuanL2EkCB9wk
 rRJFj58nNzQaKq41mlalx/lceHgD1ak=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240063
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

From: Janosch Frank <frankja@linux.ibm.com>

When implementing PV in KVM we chose to add the cpu load state to the
mp state solely to have a way to keep the UV happy. The UV requires us
to set that state before running the boot cpu since entering that
state sets the initial PSW.

Since entering that state in KVM only sets off the UV call which
causes the initial PSW load and does not set the KVM tracking to
operating, we need a second set mp state to reach operating state.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260923082146.62803-1-frankja@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/s390x/cpu-system.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index c938c77d0bd..f12ef1bd1cc 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -73,8 +73,12 @@ static void s390_cpu_load_normal(CPUState *s)
         cpu->env.psw.addr = spsw & PSW_MASK_SHORT_ADDR;
     } else {
         /*
-         * Firmware requires us to set the load state before we set
-         * the cpu to operating on protected guests.
+         * Firmware/UV requires us to set the load state before we run
+         * the cpu on (re)boots. The UV load includes operating so the
+         * second set state isn't really needed but KVM doesn't update
+         * its internal state to operating on load. So we have to set
+         * operating again. The UV doesn't mind that since it's
+         * effectively a NOP.
          */
         s390_cpu_set_state(S390_CPU_STATE_LOAD, cpu);
     }
-- 
2.53.0


