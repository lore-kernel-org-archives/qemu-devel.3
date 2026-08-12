Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4485C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8oI-00069E-Bh; Wed, 12 Aug 2026 09:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8lI-0003nY-Un
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:12:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8lG-0006Z9-LB
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:12:52 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB489a3319901
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bJNJ71owOHpg6avfvSNvEMJvaX22jFH3qikkicdMvEc=; b=ltYxvqVFwHI26o/g
 1fp9ZEhoNEGLRxXeHqXwEesNiLqOjeOX7ON560nH1Gg3TqkyGMKwacznn6zkhJw8
 u9+zpdvt4qHLz0wU3v6jIl2gv0zSMvrFkKu6uWowlR9ovsAhIZ/T94ShF/yLruC7
 06n0m1iZTUus3hjp7K1ExJhT8IfNjs4a85Hj4Wkn3HmcUsuoP4BwkbN7xHA5xgI9
 UF6GSXuchXuHzRMl0gbHiyrkfkCg/4Su8LvTdmMNpOX1kBpE9K04wouYW2Y7AB6j
 stvU9fmfEn9rdZcDmD3MRCB1368alk9N4SvobcWn6RUfz6t65kPJ8Ts02yfbsjVD
 IdTzUw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0pmyrpnw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:12:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52d28f8737eso18265331cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786540367; x=1787145167; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bJNJ71owOHpg6avfvSNvEMJvaX22jFH3qikkicdMvEc=;
 b=QFPUfwBtR3l3Cbb6U9s1eEkCyo+KH2VgLpPDS9Q4nqiD+ZBEkUChmqqwC86v9UDpAg
 DWeXajicdXWaub6lCjN5njQR8uyqtMOXIY23yDfO/zChKM4RGqMsq2O6D3JbXTlQ9fxs
 aesQqEAAHVX8WBPZ9NbsKbRmymthWiB8+3vkzr4zo27JTLVzrqQOXI+vzGjsZpSDtnl9
 Dygc4KV46UOAJUjI/OwZsQSJqPGHa71JCQ2YMl/0bpBMv6yaoPV7nMyl3w3dM74DjOeb
 41FhGQ4sOz7k3r0EwygjpffyBDjntQheZrvr8NXFcQnnqpockZ3sTvGmtX+KKAX9wFdR
 Kh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540367; x=1787145167;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bJNJ71owOHpg6avfvSNvEMJvaX22jFH3qikkicdMvEc=;
 b=cOCV0C8R8wh+f1+gOe6Dx+ZHx1OJM7dXWIgNvZCQWDzu+D0syTwkuvtzzvEa9zbtUZ
 /IJ/5SW4QTlZsimnOKICDyy0QFv+bAicbYqy8jhu5+w5rAVHyZIGZ46JRkk6vzFCixSe
 IHBlHR+eSfGmA4vnqg71XVtDG5JK7JBz6xzarX0q5LyFHYNHwQkWKwKKoWKnYbJRYeRk
 GZ8hg7D8jSCrIaeNNhTHlFUOFwOVZ9J01qUExvnjfJXB5YgBGvWwSz1BlBt0LqIxK0Kb
 zy3uYUd72OfEAfuAgHdUAysTJQhmrQrsK898DdTJiLdu0iKgt9mCW77VgvZyI5ao+ue0
 wSYw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8JnGXZaJvKj7A98E7V4H5cADFSZVFpSMquhoHD/k2KIcdy1pWNl4mrOa+NcOk+K8XY2C/h73SZC27@nongnu.org
X-Gm-Message-State: AOJu0YxEKL4VQRMK+RVeVebmPdfbET2835nm7tn/cFfu1sjYs2Rbrp6Z
 ef55ewKx3+hRedSVljClMgOMmAJi0TEB28ESKF8fonBAhXGvwrAmY5tK8iTlU8yK69TGCKoU6AP
 yLB/UJ7WhL9n5PqLukhlsMIV3RuZGUgClBRRMuE16vemHPb/tDl1bTfCQkA==
X-Gm-Gg: AR+sD11SfEOcKRN52HKZTj5EqmoSozQDm6EiwFOkeWIJ6wtzqasr7gKFIW2ZRY7Tpar
 nT2KR6xGmu2tVwGDK4RsJm1k1rgWvUWiWWcS75fDRfdkm03Pnb0ZCFb4nvuOy9G8FjrCVZm42tE
 W6QLFlzPk4cciitiGWpi1bb/fNBQ8nyelI2qmysOMgzyR96x6OTP4JdvAfmHB7o0qjjLbK8J0i+
 y/PQgJl7NRamjCfEGgncMgmnVcs7KQ3UisSD9ZWr3tU2m3+L0iBMQAc5fziDcxnoo+rOgo1N/oI
 03OgVy6RoLXctCmHAmFjNObgQdvivzx2oRTP31Xb3NbK+Ay8a5sHBjNJ24gT6xua4NeaXVQ9dPo
 taragGO5Soq4Rx+VaR2F2x+OeLQSRbYlIcoQqrknOiA==
X-Received: by 2002:a05:622a:558a:b0:51c:775:c175 with SMTP id
 d75a77b69052e-52d64875bf2mr40966011cf.40.1786540367430; 
 Wed, 12 Aug 2026 06:12:47 -0700 (PDT)
X-Received: by 2002:a05:622a:558a:b0:51c:775:c175 with SMTP id
 d75a77b69052e-52d64875bf2mr40965171cf.40.1786540366894; 
 Wed, 12 Aug 2026 06:12:46 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d709dfsm7268835f8f.35.2026.08.12.06.12.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 06:12:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 08/16] monitor: Include missing 'qemu/coroutine-core.h'
 header
Date: Wed, 12 Aug 2026 15:11:39 +0200
Message-ID: <20260812131147.83188-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812131147.83188-1-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX7M9ICXG1rYXS
 myzVnkAG+dAGVqEnjWPArffd9tj/ct1GejEhGQKMKOt4Nn8dhn6/L8pYcx71s6aBdLd8W2Eq0VE
 I/Q70kbOJl4bDMqZZVjkiLw0oJ3Uxlc=
X-Proofpoint-ORIG-GUID: AainjCKa4WWjhfegtgEYEpc2zughJiGa
X-Authority-Analysis: v=2.4 cv=C/fZDwP+ c=1 sm=1 tr=0 ts=6a7c7151 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=neFa9O3qn1L-Jj73aAYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: AainjCKa4WWjhfegtgEYEpc2zughJiGa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX/1Zd1kA/PE+Z
 /3DePM8BwrnNvvSpRCn0brUt/JqK1QiCJbWsz2PseeI9JftIQ3RBwLxfUHMlrDND4R8XQOkfvUt
 Ci4SKqTyZH9zSeyd0VjkZX7MoTRSMoC0ioFIPRP+39I9I2ByJnJcYllrqzqkf80cJBgqmlCs10s
 1ias3xF5d5Ul+WXretmxib80I+3kXXDQsjMx7KG76KmwiRV0oll7+XGEei5DNbUVdhenotvSerQ
 oqnNgtKzfZbMg/xuCPQwlyumDtnnDOaUsPnErs1SY1tH3Bojf77E+5LMjAQ/EKNaCtHLOV5OKbb
 9FjKy0Jg0nCp4AfC2yC5RYwIwO3yNF2N/iR+LzY/YY1AQG0IPb52cw8yFCKo5BWKWFQmLTMkb2z
 6kAxTwXEg22Wd1VlQBQS9jZeK3y2cniD1tU49qP9ZTRlcDsDlYhzJ2Vmq0uihjb0Obpz9RWukBv
 +k/1jjZJWzzTk53R+NA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120107
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

"monitor/monitor.h" declares monitor_set_cur() which use the
'Coroutine' type, itself declared in "qemu/coroutine-core.h".
Include the latter to avoid when refactoring unrelated headers:

  In file included from ../../target/sh4/monitor.c:26:
  qemu/include/monitor/monitor.h:32:26: error: unknown type name 'Coroutine'
     32 | Monitor *monitor_set_cur(Coroutine *co, Monitor *mon);
        |                          ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/monitor/monitor.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 890497b0d22..efdd2165aa9 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -4,6 +4,7 @@
 #include "block/block.h"
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qapi-emit-events.h"
+#include "qemu/coroutine-core.h"
 #include "qemu/readline.h"
 #include "exec/hwaddr.h"
 #include "qom/object.h"
-- 
2.53.0


