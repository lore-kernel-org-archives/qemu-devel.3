Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D161C531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3Uc-0004vG-0q; Thu, 23 Jul 2026 20:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UZ-0004uP-Ol
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UY-00069A-7K
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:19 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeWd91351436
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mdiBDK4eszg
 wnfAkPpeCdrUtqKiDiKlJZAaofAQ7NL4=; b=BqS4lDQvo2CMoFDdwLf7UxjVvHn
 QBesaDwoYZ353eAXu7Hb0LtTwaiMuHoUdRaYJVxVZ3zThclocNLVFdo7k3SNPs/9
 0ywAiNlX3+IocgNKvCxiY5ur7buPewxIGI+sWQsfdZSKY931gTLZC5KviFQ8H4kt
 /GHBbcMp+M+Dlf/ImJ9D89jib6GEgavZDRzpDSc28B4za567iUjj4yN8oNLhjVjf
 1K+bz+uIML19roJWN8gOtIcWKzYflP2c9ZdvLOutqUHsH8EXHDwk6p5K4P3X7KBx
 GCU5rQeOQaUTWD/prVSNReAtC01RTims8UxF5t33DZ42AHAkBvH5MbPsKmA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa099x1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:16 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca6bd8a190cso1694971a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851816; x=1785456616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mdiBDK4eszgwnfAkPpeCdrUtqKiDiKlJZAaofAQ7NL4=;
 b=FI59/3+GHqj7pHxDw2H33YfwI7OSfue+f1J6lZctaepGMsOadrAXlcxYxsMBjCbrGs
 EFKFJl9oqyYCxt58LFliATXvtjwqFs1QWNuKIci2xbhyrqPoA15gL6Go9OGDHaJFwgRp
 NVWAzjTdUvckl0tOw4qu9LW10kjqrDYM3Ti4RxnwvdPECuL8omhmC9YUpaJRDfC9npfS
 NW0AZk4zJgmx4uw1WaYCBa3NjC0KrCoMwVv3N4IWCU48Wz+MSHkiVj4WGGK1nkJThez8
 t+KrSnZSDO4a/UydnPrfd+Wh3P303I9ZTysUoV8Ofr1XM10Nd9hs3/2SQiVmlVYUD4ZL
 OzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851816; x=1785456616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mdiBDK4eszgwnfAkPpeCdrUtqKiDiKlJZAaofAQ7NL4=;
 b=Bv3BO+jielloRHehPC4USuTdgiBYDNT8avLmd1lX86fYZt1dTVOScIsJUpBNyr3zKK
 lrUwLJInhM7EZ8we3Iral7aVrxiiGfJL7ncCOBy0aYZItN0QMPvNzR6H2RCcpcnsWqN2
 IKGKWsC1QyVXAgAK3wgy3OAMELggApCFTJgKJTnYZg+7oOpyBEdhjcW5G2faDveKK1E8
 hIT2yZsqeWPi5On5NRBwbwQRGN1ZI5nBY+O+O+tQSX3xa6FH+5T6ri7/F3nz9+kpUKIm
 NA7GsCgn99Hk1Evf2A7QuamcoxjRHVTW751Sq+L30Ke/F2sDefhGWFdHFiYdx3Oo1oIc
 RSVQ==
X-Gm-Message-State: AOJu0YzJ9miaHvpXBrK/0OeyQoEQUu/s3QWB3OyLasscS7u59PpdFcVc
 iU2T4kVSx7DtfRAjRoXEwG3Cdkub/rXYDUC52do30Uok7TAAlAhGMRgiXD69Vw4Ctad+IY1pm6i
 8c20+lnzSgVIQRlpFhzQo051jZo/Co7ugv2BCq7P19stnART8khSmnTNo06YXU84sfg==
X-Gm-Gg: AR+sD11NxIiU34oqn8XZVuzUoEUl8qKcqg0e49yv/8XJB94gEEFW+6mecQYp5ycJy8B
 NerFfKXr4pKAJrMVAMR/AKA36aTJIkdGOs12KA6+goo0rWtgTO6E91VWAJvH/1nOVSQfDQcXPqb
 i+V/czQ398t+6lNILXSRiqjX+NHyy4fGoRCWreK5SX3jPYIpk/yJMa/7FrKcyNAzzgOBJiAypT+
 dcaYNHTEZ5woHSIgKuqtRqcMrwLdAkwMwGEuC6rKYjZdf5wC2fXccA6bmtqFEixPEiMZrtXJh13
 8G6AMDbEZSafQjPP0jAGg79XGjVv/ZSdPajtNWvOZmsqjrpRarhTC4b15bHGyzF83z8aCHuR1XX
 TKhEg7f8kKITJhCHvFr3ykDyAHFfBcvrOt6SIXCbznxVgOcKFPgl0YAG6bWtA8vaqDzYLHWk=
X-Received: by 2002:a05:6a20:c79b:b0:3bb:21ad:40d8 with SMTP id
 adf61e73a8af0-3c44b1c8595mr5456648637.39.1784851815938; 
 Thu, 23 Jul 2026 17:10:15 -0700 (PDT)
X-Received: by 2002:a05:6a20:c79b:b0:3bb:21ad:40d8 with SMTP id
 adf61e73a8af0-3c44b1c8595mr5456625637.39.1784851815534; 
 Thu, 23 Jul 2026 17:10:15 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 14/27] target-info-qom: use TYPE_MACHINE instead of
 target_machine_typename
Date: Fri, 24 Jul 2026 00:09:34 +0000
Message-ID: <20260724000948.234657-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _9BONK8Z_cMkmuTVoJ5fiUulTmTTnRgV
X-Proofpoint-GUID: _9BONK8Z_cMkmuTVoJ5fiUulTmTTnRgV
X-Authority-Analysis: v=2.4 cv=e/k2j6p/ c=1 sm=1 tr=0 ts=6a62ad68 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=GZffiWklSP4Kth4U-HQA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXzaVNEDiVg7dO
 JJ0kiVr/W8Nx/9u+sfu4/NXLF0kedWnVfLpoz1ay/U3WWu60wDU6r3zDVylKYTNboWC5GpHglAM
 b58ipGzPSz35hSKXBKhS6UoeTHPEQOFVSomZrSBojxLjDAVBdvxT5Ov0TfXzBZDYJAGAOYCW2/f
 vNcLnqIRWAS4gMlcVjOJtHchxRsp6HjKjd66ZLK2WiQDfgWg3y42Kr69tlSu3ugZvpTf9SGfbb2
 cqVgcfr++oyl8cqCEFMknn1+n1cG++9CrQLh5tEHEqVz5tl6Dtc8cWkWPCBzsYnXABJ2H2H1PWE
 3JK6ZlBcuuNh2WDaVF7fGHyLf66WCJoeFyQ8uJoFf3vingKkF0LwVf6moR1bgPNptWRR5sPaz5W
 VspIsj7z0vFlFSNtgvrzRdBkFbI/eNbvoNqKFbDVSEtcZ0++b4gbLy1MJJ3NfNLemZCtIzqypxd
 7ujGjWWS+5Y0a+N/SQA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX7N+O344y8cc1
 M34s9Im00Mb4nvmVwAo2fCl6g7A51CLWCuie0OB8ftKfmmlOgYYRrG5u7RD80NayiJKUSYnCW2+
 Om0RLPU9xV84lTs33JL3USmVC4D7eSU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230233
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Now that we implemented the new filtering logic based on
TYPE_TARGET_SPECIFIC, we don't need target_machine_typename anymore.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target-info-qom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target-info-qom.c b/target-info-qom.c
index 67102c31a80..7ee2614b324 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -13,6 +13,7 @@
 #include "qemu/target-info-init.h"
 #include "qemu/target-info-qom.h"
 #include "hw/arm/machines-qom.h"
+#include "hw/core/boards.h"
 #include "hw/riscv/machines-qom.h"
 
 static const TypeInfo target_info_types[] = {
@@ -67,7 +68,7 @@ static GSList *filter_types_available(GSList *types)
 
 GSList *get_machine_types_available(void)
 {
-    GSList *machines = object_class_get_list_sorted(target_machine_typename(), false);
+    GSList *machines = object_class_get_list_sorted(TYPE_MACHINE, false);
 
     return filter_types_available(machines);
 }
-- 
2.43.0


