Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9412DC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGMp-0005Bt-A5; Wed, 12 Aug 2026 17:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGMn-0004zV-MH
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:20:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGMm-0007z8-4f
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:20:05 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK3CdM601441
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 09Cz3K5Hfu2RAtmfX/9+Mk8nsbjxtr/nJzshMm746yo=; b=f8j7/m+tr5HRpOCS
 9tayy8CmuL5C5fVmEKf4H0zw15KJXIRBHyqm/X7BHXAH+doNepd4B4pfVVCnRg97
 oXxPh+izYPhrzDDvjkKPMgFo0kk4yClaS70P0c0D1qcHC+NQUbqmkSpW3xCD1tqa
 maBLJAyP/avwC2rDhcnSGHJDEZQNC7JsDkwr8EliQV9lP202aywy0leJTAvdxKWU
 XFwn7zWiu3sMKFxlSSnbFADOc1A3XzkfwaXKbYCb2xKx4IKdAPAcH0ZPuYd8cdKG
 MAKPGVd+mzAfuHz4JP0vSRTENe7MDrBHiu6whn7yvBKY0D6sg8KMgPxVjs/5H66p
 h+Q/+Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0y04gd9r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:20:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1eb52e1fso480671cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569602; x=1787174402; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=09Cz3K5Hfu2RAtmfX/9+Mk8nsbjxtr/nJzshMm746yo=;
 b=Tcz7WCKWSCL49hz+1vhJUVpyL34OaaRJWGcVnPsh2bS+HRsR3+I3WOldqRvsguGYMM
 VnrNbm/oHcJb5LeW9TXU8veayDJx/RfgOc2vZ+tv57kJWlcdB87JuM0bx2mSZW6B8Lrx
 bpmFY79cloxHC1aZ+aRvnG47Kr+HILw6CYD8zlgWxCx2Q2mOn9odBkOdY5rj2/NW054L
 c4IpaqLviw4BYAmeZQL+TE9+CqnpkULUf6yyVpOMF1w2gP/+gnPJ+QfYE7hU3pl1PPsF
 2mB0PPxwd+4XGieKBD87oLXiZUNYJMx9B8nyFCcZC86knWA1xIFOS+igb4T/WGgUjuvR
 LAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569602; x=1787174402;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=09Cz3K5Hfu2RAtmfX/9+Mk8nsbjxtr/nJzshMm746yo=;
 b=F545fO1r3e9/eNMF4efFBIwbrAo6of+a4b/Tu0poZ86SxRTnFEH0SocdAYTrMaiv46
 FzaNJE5ySscCEqH1mc+bFBNmhvxkOL/vD7wsMNQJ7Fabz5eEnUOtArRQucyvjbtvhAW/
 vK8kLPXKHbtAmREZM5xSCBlINBnhlvZj+ZGGEk/WF6jhMF1sxtF144uz0nbib29syip+
 lwqMYJxp8TECRo5A8hegH3bckpUgnKVRRWtFk9wh3lkVl3xNZ65fm8B4k7tggU/nwfaJ
 k/r4UPU1qmQrELKwNveyt/R7ZDt2KZ9OAsEUkaYtIzKvntVmOJ+bE3hLR/RHKBcOfirK
 b+vg==
X-Gm-Message-State: AOJu0YydE1/XdE7/3K7hcnuLePY+4+RRTdzW1TpPCmK2y/6wo/xYYPLc
 /c/Z+LErOtF54rpHy0b0iC2pa+TEJLOv8NRTS4fVJS8ozIoEPNOB+H//AggAG7ERgXBzjoAZaP7
 hbRvfL7zANLMazDT3+k4zqltvbf8tLs1MFJwpPQAY77aAQuCCP2KjQWxuWvK0hw26cg==
X-Gm-Gg: AR+sD13Y79BWTWvsj14EB8K/A0ERQX/Tf36kZpK7I+YATRtWU65caXhG9lqSNL0iHkj
 jPQbXvCMEyq1kt4AWZbgjcUUqVK9xs3MW+Z3KWtHUGjUF8MqKXGQW7tOqqtOPFBOCAjLDa8jiUv
 1AjhCg8AUTWAKhpJEAe05BKGQ/Qwq3Mi7rS7MLogPfHE07BBGw5JXaPEtozeIiKPAMc6VbqR3v6
 HVIos0NM4GbY6k5+ycuP0mS5quvnkJ2L5zl6Re+dvToL4B2L3d10ra0zXNu5E86BbmsL6XI22vk
 uXBshCS8kCbkW8jUbsl+WSVZFCfZiosY9usX/Nb16ajyay2m2k3BEC8GY/YsJ4UPemQ0E5U0VO3
 CFPQLlWtjog1/P5wCXZM53zAqQw0OdsFg0BvFtzBZAw==
X-Received: by 2002:a05:622a:1194:b0:52d:6cf5:1c01 with SMTP id
 d75a77b69052e-52d73e2d702mr9676911cf.36.1786569602251; 
 Wed, 12 Aug 2026 14:20:02 -0700 (PDT)
X-Received: by 2002:a05:622a:1194:b0:52d:6cf5:1c01 with SMTP id
 d75a77b69052e-52d73e2d702mr9676621cf.36.1786569601859; 
 Wed, 12 Aug 2026 14:20:01 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981e2e266sm8712135e9.2.2026.08.12.14.20.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:20:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 23/23] monitor/hmp: Remove unnecessary 'monitor/monitor.h'
 header
Date: Wed, 12 Aug 2026 23:17:07 +0200
Message-ID: <20260812211708.92824-24-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX4l5+Cr4cSasr
 ZktoFgU8k75FZnlClMbTO3QkO40hAMVUNkuUx7MTjadsghgncFUtYERf1zcwHy/iry60U4gMXKm
 DhWe+EpBsgQWdO3ZxPdO0ILTXj60DLdXi+aPkPisDWtEXmPP0LVS9i7lckKXhVQIQnPY7WrvQ7q
 UTKh/i97LxdPbPcsZ6Rg6XH9gFprxYtwHnijg4bEM7OxEq9FOuAZ82OLtQbddypgimDEZtH8aZ7
 vO8TvfJeBJLTGwg0Jx15Oak9IKFHfbzu4+uNKswu2Ud40QoeiVMhkvh259p6ipzitudiyqXpcGh
 XMl1RLCFcRvL2HJ5TaTpriGrszch1/VDZjsNtlQ34WI84NydBrAuCRCTZc5Oirm3MxjTgE6qrNv
 m+yCtejaj4k9jlWKmfDuLj31rQW1BTleGR7Ccp6E4F6Vw6SSjPMt/uifzfcpwOqZDE8uh5CKRRK
 KLIb+9HiBJBBai1tYdQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX8tgXyzHmwEY8
 jJPXQGZrGNIi2heVYR1uN/NneFS0EwtnElMm1gH7ZZ5SmfIYeYBFoFnbTnEDbfVjU+y+pNJM8pI
 g0op/faURwOUDSqdYcsw7yWD1r/wx2g=
X-Proofpoint-ORIG-GUID: SLNOrz5-PJfXtvYXAO_4GF_a0ANQOjMW
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a7ce382 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=-VyI5JErSVUQEuwvVSgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: SLNOrz5-PJfXtvYXAO_4GF_a0ANQOjMW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120171
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

Nothing here requires declarations from "monitor/monitor.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/monitor/hmp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 9258a049bff..9be7fe28988 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -16,7 +16,6 @@
 
 #include "qemu/readline.h"
 #include "qapi/qapi-types-common.h"
-#include "monitor/monitor.h"
 
 #define HMP_STUB(cmd) \
     void hmp_##cmd(Monitor *mon, const QDict *qdict) \
-- 
2.53.0


