Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBA8C5DF70
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcDA-0006U8-Ar; Sun, 16 Aug 2026 10:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcD8-0006S2-2j
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:51:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcD6-0001tU-N2
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:51:41 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkuZH3631486
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BAZpjJELD8Y7PWd7W4pzVBIiRrNQ8Rvfd6NAipLgY14=; b=SqZuudpCQpQqqoBN
 FfMuS9CEb/4+CfOM9VZIFC5KWO8z2BD+0iyEEeIhbu2Mk85qVJGQSSrSv0hQUIjP
 lARN4dUjUEGwSmEMtE+8Re2R0oEMo+rA7YujfP5KZHrKf7HqSn1TbLXoo45pFQ2f
 shEGVBdHO8/jiE/Tk/pagdKOYqcQVJI8WSHpueSAsxEfcAPlNhNTQIvKwGRnCUWh
 /+uOm5P1M51G3BOv9XOPyTUmi45S2/DVnf5FpjsEojKw4TaTdGuaEs+9v2QCB2Rr
 wu4XQG/HfLalNFcjXbkwhlDouxKZj4bn6lOClt5OnEg09n/mDt36/ZvjZYtO0Imz
 QVA8kw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghekq8c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:51:39 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52d7b3adda4so25655491cf.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891899; x=1787496699; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BAZpjJELD8Y7PWd7W4pzVBIiRrNQ8Rvfd6NAipLgY14=;
 b=f/tFyzC/AyyNa+tCCrHEX5c7VlixU5wNx0c5Ui/j8+N3jErdb743CPYgkvL0IEg+xK
 s49SJ7Ge59kVeB/fJaW+IGf7+KzSFl4jWtxOMivqHhv4UBYy6ClF6mbcZOIUoGsTiKCb
 YgmKziVWTgvBkOGVHu2S725bm9w3i1ZDQ98/QOUA5JqY3sThDnUKWEh9JFh+1lHL3rRk
 APDBZMGdgZZ9/Jh8VFl319RVvh6WbBm0Zx4vidIWVqzv8duTPeLR0HYQn0QZOYi8GZeD
 U/xbAZGWsn9NAjd+6ipWnc+4qK36/3q7ulU2VjF1GIkGQjBHZ24NmIBIBxDP6UixEozD
 ZpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891899; x=1787496699;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BAZpjJELD8Y7PWd7W4pzVBIiRrNQ8Rvfd6NAipLgY14=;
 b=mq+iN80q63bYsQEyerSeMJfn2DA8Nbqc7jRHOpBmdjjmDbf3ZEKORX5h2ryzusEhPS
 qS4ZAqYRhY0qFCFtB3GzfDMARJRb+LUzGRfZBwLCVz7G2+jurMhKgmQMwoYgJulmhjqd
 lB/kO4qHrctfDGc74NDuu/FypqlyWZx3S1aaef0aNd+L0tB4a/OoBF25TZRZ28DzmzSB
 2eeYlaoHaDnZpR2JLbSNdmgc3/lVsdz3+cIFqBYhomhiUbaPEjCtr/rXs5P50w90qIRc
 Y3JNC2sNdGAn6npGrwqVm6qPAOb7SCw91qT/2Ox6JLJQqsiVAtceI8Z+IbEmEj8w4VqF
 kgGw==
X-Gm-Message-State: AOJu0Yw+PdoZkAHVCEnzvoxb819HFy7Hw/kNQhnhVJCoHR9vfBGRxXZ1
 XCwqafegbAGMuTS90H/DSv0FMiqeN3ww2AdGO+0YQ0utjeDuwmHK0gDTeubBuQpVgr7SyZHUCqN
 G+8rzOmrptqzwwgXz3Z/IEjThx2+38yprb3G/5ngN3U9MxxeSyPZ/8LHLxMofDQIEiQ==
X-Gm-Gg: AR+sD13IPf1hrbQPYs2pk1E57hgg9GKZ1ZCJmb79Gyu95J/E1nIQrg9qNOuVqmez4jJ
 KFelZ5te4wLUTf+e6xU9gWiPUxm6xbmpKJeYmvWYXRUIMhxxYeyiSDfEpUj7tkV5FunzE1emH96
 otIt1o+CwfDMfa24upc+jOiXvOc5SW0oT7e3oZkNQT5A1YJHq6rzuysf/JZzmqUJPterDImICec
 veYScOMkWPyVXlX674K4q7Sx0oFb2DA31CfhVXA5BhM9zy484c1behlSUor75sl7MqpQfH0knj5
 x4EmcOPFtQdgOa0z7eTsNHdr5SHLxnJI5m+KU56Fp8/2tDsBoXcnXKl7/MkKwVFFJ3T1eo09zip
 rQnqtnBkhY9JIGWa1LPBfWSK7s2LuqTWDqxDWB2v5rQ==
X-Received: by 2002:ac8:5f51:0:b0:51c:19af:6341 with SMTP id
 d75a77b69052e-52d854d29bemr195527431cf.36.1786891899087; 
 Sun, 16 Aug 2026 07:51:39 -0700 (PDT)
X-Received: by 2002:ac8:5f51:0:b0:51c:19af:6341 with SMTP id
 d75a77b69052e-52d854d29bemr195527151cf.36.1786891898724; 
 Sun, 16 Aug 2026 07:51:38 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996113beesm50108045e9.11.2026.08.16.07.51.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:51:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 39/56] qapi/qmp-dispatch: Include 'qemu/aio-wait.h' and
 'monitor/monitor.h'
Date: Sun, 16 Aug 2026 16:45:38 +0200
Message-ID: <20260816144556.69009-40-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EKc2FVZC c=1 sm=1 tr=0 ts=6a81ce7b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX9dmq9PytgrfK
 07IUtzzO1MxHfwkj51NsREpY2I7qWEBqixnGBqoh7X88M2aL6+6V8YmwVsoTPTks4l+bf3ycLHz
 HUoLYIaw+3LTD7vgFNpUmJAWXnX2iaY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfXwwgVC9YMK8zd
 fU4QuySP9gpHJt7xWde1H9mQ4haH/nWAvpKvlDYrWFuK4PDKMV1rJzbnLPRVQgWkgSUbZuTrpp9
 vcirrvVbZN2IxZbbXOFcnJFPH8rJUfwLY0LAboLfL6Z8yDP/RNXMKnHZOmEaBAw1Gtn9oZ4AGMk
 lcL6s0MyRKAgvSTvG9X82qf9bnBVkFUvIFVFT6hveow2cgqBfwHoGAd6v2hrwz7v8kyaFy+oKJu
 VyuvclDPc2eDjPg/vQMO0PIg4B1t2IerhTjtYdOTFdoaN7swafAt9nG8hbeuZruC8BvrKxkzlz1
 GxHe3FB5saR6etfe+XuYEsbC+7G8RMxlf1GqeDYgg7qAuWvw+hOFHH8Uqa21rocStRnQm3zXkVM
 D8H1fRSwugL4AcUEMaYp8aKt8Ai+Qra2lKSDjOTrAjDeA6a2rHXETHR951PAwZfo6a76PA9asj3
 nGnBf3fYKk3buH6P4/A==
X-Proofpoint-GUID: NhMJ6q6EfYRRovXMRcMafy9W5joUv6Mb
X-Proofpoint-ORIG-GUID: NhMJ6q6EfYRRovXMRcMafy9W5joUv6Mb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160119
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

qmp-dispatch.c calls aio_wait_kick() and monitor_cur(). Include the
header declaring them in order to avoid the following build failure
when refactoring unrelated headers:

  ../qapi/qmp-dispatch.c:126:12: error: call to undeclared function 'monitor_cur'
    126 |     assert(monitor_cur() == NULL);
        |            ^
  ../qapi/qmp-dispatch.c:141:5: error: call to undeclared function 'aio_wait_kick'
    141 |     aio_wait_kick();
        |     ^

Fixes: 41725fa7eda ("qmp: Call monitor_set_cur() only in qmp_dispatch()")
Fixes: fc1a2ec7da5 ("monitor: Fix deadlock in monitor_cleanup")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812211708.92824-5-philmd@oss.qualcomm.com>
---
 qapi/qmp-dispatch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index e3897d51977..965cad64998 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 
 #include "qemu/aio.h"
+#include "qemu/aio-wait.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qapi/qmp-registry.h"
@@ -24,6 +25,7 @@
 #include "qobject/qbool.h"
 #include "qemu/coroutine.h"
 #include "qemu/main-loop.h"
+#include "monitor/monitor.h"
 
 Visitor *qobject_input_visitor_new_qmp(QObject *obj)
 {
-- 
2.53.0


