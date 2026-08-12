Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5368FC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGLk-0001fS-Pq; Wed, 12 Aug 2026 17:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGLX-0001CG-Gk
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGLV-0007pF-KR
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:47 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2Mew642256
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ONOj2kSqH/Uu4Rdc+2HQhntXUKyktLF2J9FIRZo+Slk=; b=K7BPbP2RDOvUu2mP
 XGcMhkftJ1d9TDBlaLtaHQkfP4cV11T0PAnbMHyL3MT8KDD+AS7h+F8hXwxjqjiQ
 WLNFzL1k7jGr1vfvY073pRwrPSFM8GyajdESIK3YBBR8jaqvfV8FAKItkumC1I0H
 1GrcZux981DHaQhJ/jK8XoAsjAylQ+hz90QIopzxhygS1DQhawwkIs9E3pCKbB6m
 /ThzX6xc0fbOgCZb92eGMaVCrLBqDc/6T1d2RL25d5hOHSR97IsFrOmuI51LkhUh
 ge4T+GIDL4ParvcmUDeVUALNpnZHMLtmCcCv9lQKWeBy7oP2ZbJfXiK7ECxTXprb
 BCPeJA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0wt8rrmh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:18:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso244841cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569523; x=1787174323; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ONOj2kSqH/Uu4Rdc+2HQhntXUKyktLF2J9FIRZo+Slk=;
 b=OR0Fryv2SCLtmfiiFsCRcYUkGdX69Bx/9f67+JOBqZf2IBGD3jsxkFHOJIVDoYY/w1
 xU2slZEyPM12O4g+t+YS04FbjYWv1hyKgnhhQiFdRUaDZgN1jitEQPiqKMpd3svuQaBQ
 j/XVKc+x99XBvXMJqxoCqbw7bF38xZ2URI6gPOzFYKCuaumhydgcyndxUx54bntgBtdr
 I+oWOZUYDLGZ/+/7UJixTjJzOh08dQe8gziRs98IWEuPG9hkgVf3ua2vOLyNx7hiwYZ4
 CjY/XPpv1q9d9doysbJCxF4yZKskj5xC3ooGCgA2gY1cOTyV2nivdeQoj0c+cRHqiMi2
 FOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569523; x=1787174323;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ONOj2kSqH/Uu4Rdc+2HQhntXUKyktLF2J9FIRZo+Slk=;
 b=rwMbk6hbzle4zG0iPA9f55dGbY4T/haw26fORjgItMbUjsi3W8Og5hlp+q2kY1zX5f
 RNIPVCSHL0siIg/CTpNN/6i3kXbEWDDcCkvqsnQbazg+ZNUXqZ/tdqH7HHsmQGpkHp7M
 NYHKeuSdd4A/745L+HAKXaMcKy5eU0bazJmXWfuJmRfISFOMjVOmyaF57ylrV+9V5lpa
 nGymui/2SEUc6+bXNaVKtFcg849m4VRDc6JPEv5TWSUSU5ZVNHt7p/otuF4Bbkpw6m5r
 GA5+p/bJDwsPLwp7tX7fd8JfetVSmnN6zmTBzUsBbLrQ2zBDH3dF+7fnhgW2vaWMQSLJ
 MZvg==
X-Gm-Message-State: AOJu0Yyl/j2XmeZt6YQxIK3H1VnjprkEx21DYviY62tpaNgqwNHSAgYh
 Uv8FUzI13JM7a35PzUxrpL9C8ym9vZ8XL1zRFv1M4yHkR04w/zDF6dzAl+df/CGxAw7ReW0f7hf
 qwfuplDew4edojTKvKilmMrsVUnJOVc0KoPQ0dpWNhykONwkuHGeD+VLHmn3iRDoaWw==
X-Gm-Gg: AR+sD12c5id3tdMO1uUsChbHz2fKrhjdReV099E82Q9bR3cmUmbjbKJVO31Zyb2Jn8/
 VZzbLXjJpzHaAhcpud5pW0B60ONrYrWT7wYYnoq9TBW2eZsB6Go9fFpkH988kDkZUZ8LiSH652/
 nt5OvxQIOn3bLGZna1aSISW2MKlQc1XMnSK+6xEq/KBKCK+X5XXGEzA3MPPv7pDgRw1WtDFwzrr
 WLFJNXXsxYLIdkIRxshulJyWOqVtEgVJYSr8n7l23RBn09k8MBoKUy/p80xnMtEkCRkFfwPz7hC
 uJqTREyZ1LR0ObeuN0j5caOf5xmCC/gnFctRyJe4Mvz/wfGoGtL1sf82eV0w1fS6fGMHH52Eoud
 0j47GGNAvrfY68idq0f9ZRC9oE2bWBs4bYTVpwhn82w==
X-Received: by 2002:a05:622a:1901:b0:52d:3352:f7ac with SMTP id
 d75a77b69052e-52d73db1794mr8814671cf.28.1786569522784; 
 Wed, 12 Aug 2026 14:18:42 -0700 (PDT)
X-Received: by 2002:a05:622a:1901:b0:52d:3352:f7ac with SMTP id
 d75a77b69052e-52d73db1794mr8814451cf.28.1786569522454; 
 Wed, 12 Aug 2026 14:18:42 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b1bd61sm14922645e9.8.2026.08.12.14.18.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:18:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v3 12/23] system: Remove unnecessary 'monitor/monitor.h' header
Date: Wed, 12 Aug 2026 23:16:56 +0200
Message-ID: <20260812211708.92824-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLqvDxGx c=1 sm=1 tr=0 ts=6a7ce333 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=4VRd78mhg-xsesdjslEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX+9jdIunQKJm0
 ecW2zB8MO9fmP5RE5U8yVC9PoVWVHEsUe4h1MYl3kM+5A/aIwkLp/ClcIKrslAF+VrreTrFB9Rd
 ZqDLXcLtlqVHYmwAMoVbmvMVkHwgycgxWHxKrrnRPJRbUervA8UBmj0wVbO96r0IbUT7ZUNchFB
 /d/9RyAHo4iFp2j7j6dsqK60/D9fALoHisE6BU3S6Lj6uttkTLtug6ZDzaH29WDKzBOQTdekC4v
 kE6lki8zH0L/JUy1WmIisol9RjeOKrh9z4idftNMf3t6GEPvIfUenP2kBryaRqcE62LAZNYE6wF
 tM8V/SDEjzKJo2Uma8XPxdUU+tmOv4OdVLIVjwiwuY0JsJ80lCtXmUAiDayImj3vHrFzIyFGMdx
 nESwhtwatBeguKYY2vNqMkxr7q1rwTEAW+NqpoAW/AVtZG1oDWi7YVcBw+j0MzjYA12OqVe3BPP
 E+uTcSttoXnsDRn0lvQ==
X-Proofpoint-ORIG-GUID: GqKLzAWSVMkypGSumFFPXZngBa0aMfGu
X-Proofpoint-GUID: GqKLzAWSVMkypGSumFFPXZngBa0aMfGu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX3bekKK1OhQyd
 vOG98O0/LtGDUWKsuCTGmsT1zxjCCZD0B8lBUMtMSEpQ0tOoaxifBtLKHKddM2x0kzeAc6RH6P7
 gRD62pjqbMitAAUlG3ecSqOq5LJG9Ig=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120171
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

No code in device_tree.c or physmem.c require declarations
from "monitor/monitor.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/device_tree.c | 1 -
 system/physmem.c     | 2 --
 2 files changed, 3 deletions(-)

diff --git a/system/device_tree.c b/system/device_tree.c
index 1ea19629841..48365435ea0 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -29,7 +29,6 @@
 #include "qemu/config-file.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qobject/qdict.h"
-#include "monitor/hmp.h"
 
 #include <libfdt.h>
 
diff --git a/system/physmem.c b/system/physmem.c
index c21ea929153..21614e1c4d0 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -84,8 +84,6 @@
 #include "qemu/mmap-alloc.h"
 #endif
 
-#include "monitor/monitor.h"
-
 #ifdef CONFIG_LIBDAXCTL
 #include <daxctl/libdaxctl.h>
 #endif
-- 
2.53.0


