Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED728C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGLJ-0008Vc-8b; Wed, 12 Aug 2026 17:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGLI-0008Mj-3Q
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGLG-0007nr-EE
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:31 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2QPJ301087
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PJgb4ZmR+WskCzVafLInG1mhyEcJ7bjBiV9xVtr4/Bg=; b=Ug0yIDa8A2L769Nu
 PV3vI3hxjFAt/9ygRYAo/kU6YQfkWy4oeWIGi9LUfxIAyMdnv0H97xXoCZV9qGTb
 EoH44ccNAriEeqQJab5w2ustibJnohYYmGODUMJMMwkxyHDpzh6Zwq2CyNtp4LVp
 xQYmkhQdQs7rZ8Y1Xxvhv1zG5cMJxSg1CcXExTIPd8n4WifWPVjDrJtWRcZaeyFW
 7XYZ2OAbGL0kGoXnGE4+Nmo8A1XjtgpsGIFOPa8gBQlPcLOMYMulCHN9JywhQCoe
 XmmLXUIFmdBs2yMgzIeyd5lS4edKR03SEpH8uNok1uboMQN3axNFY1NutAjCGvJT
 550qGg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0pmytx9r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:18:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c12e43b98so17361811cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569508; x=1787174308; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PJgb4ZmR+WskCzVafLInG1mhyEcJ7bjBiV9xVtr4/Bg=;
 b=OXShCBsEJVk1ybSKwmyUWBmQCuOExDwr8Iomgpw8fpY845iyFNTu13LdAPOBjhrsUx
 +XNmPLsJNFWKp0ob62Aplx7DJEpHyjxhuQWmMi0ObyUP3qAXr9QDVZi63vcTKnbplk8q
 FouxA+CYyZ8vCCJHv8YSo4OrEIzh2UZXfZXbgPz59Pn1FIZoVtSUg8YZmFGPQqY10l3e
 Tva7eG7PE4VsVcKsUHNdA1T2vYbuAcaD3WDIBd08yFbhqzqmtSM6YRxVP9bVVdM3x2+5
 rtcnotu6Z0K44IxbsexpgwrffrzBroDnbrNlFmw0y/WxII7SSHCBEVMwcwaroFTgDzop
 MVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569508; x=1787174308;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PJgb4ZmR+WskCzVafLInG1mhyEcJ7bjBiV9xVtr4/Bg=;
 b=qwbVkm8eX802IGWo0v6RNJreFFBtUTRr9rtJO3aFvMdT73X4zI6zThl/HrtaG2waBK
 Ci1LfbIBmUixx3giPTD+CAIHyZkPZIGgMaeJFie3uyawr1KR62hcnePhNMGbtDwjlkDv
 BBBOQ3FYAwS8/uVkzCrGztkNorVd2FPv9+I9BEhqjR+FER9aosMQXp553RHzAch54nR9
 ueQHkz1b37X1ytMQu6mYkU/8aXjG0/bPuXQBA7F34w9gIsg3Mcl+hn6V0JcLrCiw9sQa
 pEm5Ng9l40CB3UoR1NMjkrR/3YEAFyWwYJ8p4vnpjTUGOkY7S7NvdId1OUoF0I1O+4to
 uZcg==
X-Gm-Message-State: AOJu0Ywv8Hfw9NyhuagcMpKNoyaQ7ylXLKbIoFyP3f0cqnBGDrqzwPZs
 kzAVwJEHkKTc+b74wsfVNkbFLpdWO2WGRX3AHUBBF3oLAYSkgsc4vyExNb25KBD0ke90fVrQVXg
 GnWrfuIqQZFleUjhMTZx27p6/3Dz2rzjEdb2IAeulGdYBtJZnK3PmrCjwju/MQJF0NQ==
X-Gm-Gg: AR+sD12T6+PQJiFtkP0ytKK0TP2ri5r9/Vm4CIc5zon0ZRmrj0272Bwa9NX9oEHk9YT
 Yv3K0KRLwWyRO5ogCPUFYekTZIuCZo0BEJEaEiSlEBKn0TNIzsEjCnAZDloRT9SBASDTWTMLmgF
 HZGPeNH0BK4tWdmMacH3GAx8Y9reHWqlXludZkGQVgf95DOOoKdPf1/ghRdmSPeFMWZprPA6aCt
 pcQlvZ0MjCBw6YL0o38/2xcf3WiZQkgP3W89cL5/6/F0IugOswKQQ3OOo+mUfpvy97637qNWGFB
 PXyHO7218j5h/XJdXYJGYQ7gnVZV+YR4s6wBupw0ajuGsKx0lsdgtOLdBipPZHxylUNbmO8rU1g
 1NRmQvDgESP/PBmwT4Cy3pnTY8BhAu+YUU3YT3Bxk7g==
X-Received: by 2002:a05:622a:60b:b0:517:78c7:d93a with SMTP id
 d75a77b69052e-52d73c86a1emr10400711cf.16.1786569508044; 
 Wed, 12 Aug 2026 14:18:28 -0700 (PDT)
X-Received: by 2002:a05:622a:60b:b0:517:78c7:d93a with SMTP id
 d75a77b69052e-52d73c86a1emr10399901cf.16.1786569507305; 
 Wed, 12 Aug 2026 14:18:27 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981d9613fsm36963725e9.0.2026.08.12.14.18.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:18:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 10/23] monitor: Reduce inclusion of
 'qapi/qapi-emit-events.h' header
Date: Wed, 12 Aug 2026 23:16:54 +0200
Message-ID: <20260812211708.92824-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX5FvDkgdCGiaj
 yRjyuEoUH0HsEe5Ohn8hZT2gn1xpq/kaKk+hdQ+72ncu5LmHX38bmYP7Fo9sGHea02zVqTgVf8I
 v9XaJggAJs1Bef0eCvZHcA/mVd6o2/A=
X-Proofpoint-ORIG-GUID: qiFIQuZW_WuLexxkueBzj7wXdSvFxQyE
X-Authority-Analysis: v=2.4 cv=C/fZDwP+ c=1 sm=1 tr=0 ts=6a7ce325 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: qiFIQuZW_WuLexxkueBzj7wXdSvFxQyE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX9QL3bRNM5Wnr
 RbigPK+KkJUlseDA4jcZDZg5JlBRzaY1jFnUSTY4TAREa5PcbqI1tj7nCQCptKEwyvvbqePmaBl
 kXeNQRDQaqS9eAkVC7SMRV1qQnU9zhu1mQI+luVA8nhUadJ73jr44fWEW4e4jUr4YOYvP2xoq74
 YMh6eQL666A5tUrgdwnjthVe0TX3n+JkGj0PS7w86iahv16Hx1dhfz3koiZ1v9ZZxJWeERDKBry
 3vJ0Vq7zFzC9YaDbT6PKGR++sr1pkPecHUcON1dawtQb6h/2A46zmjaaF1eEkm2fFedNY9RkHMY
 XYjskK7K4Wdkj3xEIGoUFk2XgEtY+R5W8f46qnT4UOdfF39S6T7FhiEtecZPWtXBszVQi/ZpCE1
 jhKcKVbOXEugoL2yqPFpsSapqOz+YBWess4mWNzTdLwfOL0pMOjRIHkOYPsy+BA6DERHeDqhyQj
 peXCo2ehDJFMy296uTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120171
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


