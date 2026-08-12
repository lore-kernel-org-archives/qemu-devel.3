Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7DEC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu80o-0007H8-Ne; Wed, 12 Aug 2026 08:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu80m-0007Ek-Rr
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu80i-0001wR-RM
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:48 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB46aI3265820
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H8bOmNlfoHQ6vnwoT3iYJ95B0zPjZH+NKe19ERFlx38=; b=M3sWdCdpohxbKelY
 B36/aULjuHqxOEbYxQ6ngac0K88ZbhDp8Uk2z/Bct0md9o8XvFfdGtzYnSOl8kkp
 j/Jp6MEKZk9oY/nvGH3o2W9lTrTj/j0vZuiNyQHGRY29M/Q5LajO+okntgSLDJoX
 Nq/phJ18dORlziboKFqkqkldpr5UqdZbm9P0kj5oO+g1h93XpQW4j7yJT2DL7NUK
 GQUSTVqTPRaufebd+CeIykeU3jqc3Sptqk7ka7ikofY1xJW+ahSqUi6BYTOvYFnN
 BWwgkh6T0o9BH70f7fCsr+WOOojWNMW9QrELZWGSOpbXxX5yFq5+HhUykHrkPihH
 8ajtRA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08jrksa2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:24:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c01ff996dso13817511cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786537479; x=1787142279; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H8bOmNlfoHQ6vnwoT3iYJ95B0zPjZH+NKe19ERFlx38=;
 b=jPnNxqWdTb7GHP1orqj/0VDiYdYjwDAJXwMalc+pIRgV14b1MYYKGnsYIUcavuGtVg
 710KrSD1EOCVSGAH8V2/dqUjauLOPUUlw253kx0516JpWX4m2Fe46LP/lsTe+5w2tkR2
 PpQ/mWP+gnRgNOoGiFRR2eLXxnbB8KQ7HKn3VI+Pb1iladHqQtfAJu+fyrHCZ0jqryU9
 K4wAPwsSu503pw+U81kQrcfuPD9PWyejQMWafo5F91W009LqKmHJdLGqTxxGHQQwTPBe
 TdMQYL5DuPx0DkOctvTysQkC081gugEZmnAJrrOWRIjzkTjbSJMVFN7b4uVzF549Waet
 3/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537479; x=1787142279;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H8bOmNlfoHQ6vnwoT3iYJ95B0zPjZH+NKe19ERFlx38=;
 b=lY0XQrC8Dly3DZCZKx0lSmA2+aHsEq0L7NE+utA6WlaPMlLm1sAmfM4/ducxLNqU1I
 0ULU6iXTCiBAXH7W33Yc3In4Zwt0pAqWKf8TJ9Pn/k16ec/Gy6wu4jIqveOyYU5GhObL
 xEp/LnII23nzBzZZeWueupjtt1eWwtXi7hdGvYHCtD055cLW3FEHdZvBnS9pO3hLSwWk
 cFyHDYk8Gqdy5Y6vOMTVhqxFseXIowvmbql0F3TLhrAAgoWp/aj0tOwZylw+h6urn0RW
 UkgotNFt7m0wnU6salxZkghA1+fAqBBYQFY8zy+pI6CXw7s30PiJrIJNxNfImw2X2ywW
 QWiA==
X-Gm-Message-State: AOJu0Yz7tBrHOThBye+NXVKaZoL8oaciubI32nGbE87TeFbWp0Di3mYM
 amI/ToNtQ8RHgM/u07V+0MnWqJKg80s36BZSSWOj2IyHJkZM8VacVAzg9/nP9kLrkjFQm5AmzEs
 I1XI8h27WmhK+6scZfzfIhbBYmjsbONQeNmMvE/ju8lOthu/k0rDx1fIlEWGStZEo+w==
X-Gm-Gg: AR+sD13SQpN4iy2x7RlyyXcwTCHq8kfF1X19J71ho+LhRHhHiUttKoAKwYZYv3y4e8q
 zga0Ekb4AfqeuRHxVa509Ts1RLjMt68c/Ihb+gH4DZL8t1cv20ZULSZAj5wV4OG4YEFtdaRssss
 jG1mb3tXwxRKEl+YGQ4S20kRceoZVP1GxTJ+Vsd52cmaiBPPF6JnX9QepXrtdz4eQ8Bj9Oczp8Z
 shqO48pzw2zltY+2Cjd41LvC3JsjKNO8N6RZ3liZKPp/g9ZCsmgqlXG5JIqmTq9iAJlVUC8Mw/U
 nZVm5bUtp1OHtKOw9Ld+9MNTfILGcD/429RUYpSntl3qFvXNEUmLbMeRIwhacSvZEKU5QLj2Vva
 JuQ/jSAgsJe2kByizx10RCkwCvy5t2XPq17Y6Pe2lNw==
X-Received: by 2002:a05:622a:4816:b0:51c:207f:6524 with SMTP id
 d75a77b69052e-52d64817b7amr36736151cf.37.1786537479023; 
 Wed, 12 Aug 2026 05:24:39 -0700 (PDT)
X-Received: by 2002:a05:622a:4816:b0:51c:207f:6524 with SMTP id
 d75a77b69052e-52d64817b7amr36735621cf.37.1786537478479; 
 Wed, 12 Aug 2026 05:24:38 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d4e400sm7534885f8f.21.2026.08.12.05.24.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:24:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 09/14] monitor: Reduce inclusion of 'qapi/qapi-emit-events.h'
 header
Date: Wed, 12 Aug 2026 14:23:26 +0200
Message-ID: <20260812122332.72975-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812122332.72975-1-philmd@oss.qualcomm.com>
References: <20260812122332.72975-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3RaZh5-lCaPYyoUC9VziZHAGivp2RLkx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfX9rHj7qqylH27
 QIsl18mpZDLuSeaC/c7VYfSNzAIDyKiszJwxhwGy931C+FYiBfdFeYgGoPNLDZvSu7L0O738zUN
 /E8zPJoQrb5KrMtjyO6NKZx6wTOYaII=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfXwXVuc9hRrszl
 JANDExAdHroSPuFErqT0hPdCtCoJA0LAEn8jZ/Mm0XUKwNIdJ10fpmLCZDCTKcOuMA+K9E2CXFW
 ruvKaqi9TtnaOpI8o43c+P/8Z/fTf05lF290WwnY8WCP7sCYrasCsgQ8r5RTy5gmYFgpcd+xPJN
 ltra0gbXwqYfI36N/SK4Cpig9TdxBwoJ4m++cEdHPcktSXh5cuAZ1rpJvvQHgU+qpeLmloW29Sk
 CHkBBBAGgL5zVNh5+rh6h57Re2a37WcO0CWhbHyjAprbmBVAPu503fn4JOAAyTOSqUQbuUS4R2u
 QyPwsi16k3i0UkcYkisXtdj32zhTIR0Jum6hQ8umpMJtfDO1OSnMpAXcMqSYHqg1RiqtmMTXmia
 fHxmLlyS9iLH6Zud2qa1dMo4hXTZnvnP2aWPIw7/KaSLe77EyqaKrS2Kf7C9uLi8Yh3KjHWdFoq
 zIWtVuspcdP9WDZshxw==
X-Authority-Analysis: v=2.4 cv=Z7Dc2nRA c=1 sm=1 tr=0 ts=6a7c6609 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=M5_NfMGrd9FO49X1DvkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 3RaZh5-lCaPYyoUC9VziZHAGivp2RLkx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120100
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

"monitor/monitor.h" don't use anything declared in the generated
"qapi/qapi-emit-events.h" header.
However the "monitor/monitor-internal.h" do:

  107 struct MonitorClass {
  ...
  116     /*
  117      * If non-NULL, the monitor is able to send event
  118      * notifications back to the client
  119      */
  120     void (*emit_event)(Monitor *mon, QAPIEvent event, QDict *qdict);
                                           ^^^^^^^^^

Move the header inclusion to "monitor/monitor-internal.h" to
avoid including / re-exposing unnecessary declarations in the
global "monitor/monitor.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/monitor/monitor.h  | 1 -
 monitor/monitor-internal.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index efdd2165aa9..fa9f4a8a75a 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -3,7 +3,6 @@
 
 #include "block/block.h"
 #include "qapi/qapi-types-misc.h"
-#include "qapi/qapi-emit-events.h"
 #include "qemu/coroutine-core.h"
 #include "qemu/readline.h"
 #include "exec/hwaddr.h"
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 23829f32f9a..bc0932c425a 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -27,6 +27,7 @@
 
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
+#include "qapi/qapi-emit-events.h"
 #include "qapi/qapi-types-control.h"
 #include "qapi/qapi-types-qom.h"
 #include "qapi/qmp-registry.h"
-- 
2.53.0


