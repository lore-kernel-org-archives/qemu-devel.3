Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A599FC5CFEB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGKw-00076N-Lq; Wed, 12 Aug 2026 17:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGKY-0006ww-4n
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:17:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGKW-0007lV-Hh
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:17:45 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2QuU246263
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B+nReeGosnleLKDqAb59HHlaGs68hFMkcZj63B2f5Cg=; b=jOtew4ygSShIACsX
 pStnrG2DeJRrd4JvCw2OhUv7fOJDj7ObOpn+jmfktGZirqsS36c6aWmTiIwmJN3D
 8cfSbv3rSgBvKeqNOSXPRXQN1yulxZc5ymR5ZRU9fR0sEk+wkVVpebHz6tS1eHtS
 RHWHO2c9m3MllDP3bgxb4HQZ4pC6YNqMWq/6r/h2G7nd26ZTpAPLpZMBfb97L7xP
 2Ag8GgjS9d+ZhCAj4+ggq+9fms6BTityqXxrJ6NCohJ05lmkoVNx9ihFZJ+zqk86
 IWA3qKUb0HQ+Ci14DJah3wgtNl6yqaLwP17KojRwc3gH9eEOKBLozRkxs2OXIkTX
 E1d1Ew==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0uts1emx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:17:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e8004d60eso277416085a.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569462; x=1787174262; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B+nReeGosnleLKDqAb59HHlaGs68hFMkcZj63B2f5Cg=;
 b=XFzuVFfypurnhxpftrT/zEzJtxEMKC5z5H4a8WrWSNAEwdV+7py9OLSN4ilf8E2qHy
 vbuv/jVpXdMB+qxITJmnYRhDgaM36kwXJ2dLOsLLQdVK2xQ05EttFAKz6JqUoZ8COmrS
 GKbiH6rC3uLwmXBSsbR4o8DXeXKNozD28UNh8whItoZ8M6jnwiae9AebqaVtf7+Gaa2S
 NEMAg/LFiikPR0g8mKCKetaX+QryQFcGUZJ3lvPFmls9zK+7Cl1cTcjgHwXGDYS8FwC/
 iVwqoBGV/Pd+3KROD3lKSFIP0e0sUOQZq1wVrw3OryXakM698BzG4J/bppNHvqt5nuxJ
 kopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569462; x=1787174262;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B+nReeGosnleLKDqAb59HHlaGs68hFMkcZj63B2f5Cg=;
 b=ZCVeeIV1eY7VVPFRS/iQXr7K1rZnpw3uH8FhMFgy5+cYps33RTiQPoyvKWlwWo9zIo
 7MI7ZmQ65sx/teCUGZ5xf58H6GXZHtzSjzAlRcV4kgOIJF7seUSHX1P8eN8S3UVL/H3r
 ePR9v49+Zcuw4mOBNqoG+pRk5djjI8Gbs/QSznVqiXvVLdgg5gKhZ6K/Z5q22EO4FqSi
 iVs0WvLReea6Su14npek4z4tl5xGZ8LCsg4nARgFn6rCfAbbyyLDK/5onCQc1Iv5Ghlb
 Mt35rTbPN/hTUEnqt2CJDLJ1ZHFvqhjciB+uNfbgNEUwSjlHia5xfFysBj5rEbH5pSHN
 2f8g==
X-Gm-Message-State: AOJu0YzdZuevw9hucfh5HIq/ABosCEtCngQaVv5S2Crw7lPwiljFiJ5z
 rEgE5e5MW5YkQvmPTuJNU+bjJEXpMqRxTUmcCp9qk4ObmyWUJ0s3/oImuYqoQu4p1/Fe0e6q8Pd
 IigUznZsVX3CR6yFym3PnzaODY6KgS5zPpeGJAHuqkOlsRlYMhjYNhKy+qNJVxYk+ng==
X-Gm-Gg: AR+sD12bvDlJgywv/b9HBDNc4A5d3JA2W6cSguf7iBJ+mYec6MTUKi0aERTLqTP5t+5
 NNtEVct1FQAdjP+XAu36KgXP91eKyNMnshpUjWRrG7acI+5hfq5OFr+h7+fpcEaC44WKeujXFYB
 l6PqL99SWpr/CD8VsejbO8ncJ3JurUn0qs/CzfsUB6qpDwEqW+Fd9sCvmg8wxhilBmX+YLoeF+M
 xAXU4w2pOkVEmBZHvsuSKB5ZQGDVGiowoczrYxVlv40+8h+QF+TIGwRkxnOdl8XV5OJ41yds0/C
 A1PaGjyNhjktnUGronwCrWQSNbdtXXQ/jV2GRyQQXunq5k/vqbynhfhoIlZDQm8C38IakKnyvGU
 GWdHdMNzmsiUx/hSNFXGtQkh8RSUTQ1VkJYg3qPVKvg==
X-Received: by 2002:a05:622a:58cb:b0:51c:1568:3a53 with SMTP id
 d75a77b69052e-52d73c49054mr13596521cf.16.1786569462129; 
 Wed, 12 Aug 2026 14:17:42 -0700 (PDT)
X-Received: by 2002:a05:622a:58cb:b0:51c:1568:3a53 with SMTP id
 d75a77b69052e-52d73c49054mr13595821cf.16.1786569461566; 
 Wed, 12 Aug 2026 14:17:41 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a561296sm713044f8f.4.2026.08.12.14.17.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:17:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 04/23] qapi/qmp-dispatch: Include 'qemu/aio-wait.h' and
 'monitor/monitor.h'
Date: Wed, 12 Aug 2026 23:16:48 +0200
Message-ID: <20260812211708.92824-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WBGJ_kiiIjPGRIjQdmKkXvwqD2mWTex6
X-Authority-Analysis: v=2.4 cv=aPDAb79m c=1 sm=1 tr=0 ts=6a7ce2f7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: WBGJ_kiiIjPGRIjQdmKkXvwqD2mWTex6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX1NmU4YD0E7oF
 0bS9p5ze0QRQxvzBySi+MzM+WpLUe4wXldG2QFFr08qE9LOIVlWKG+rvJAO7Kfcf6UsE+obwR53
 O/bskr080KGh0qWkSimWqk0+nI7DJHU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX3w/tpbqFjUG0
 2S42lIwjZqQOUPDXoMWvZooUO6xOGhFMBpsHL9otGZSSFrUVdqgoupDWsEUVCX/3EwC/7x1yJ9j
 NlFVG2pw31sc7zG8T78+6a83XGGngyQ9Ihg7aDo4WVnNCZ9WU2tv18OA+VB2Mz1jFkDmxVMiZTn
 dbyKOy9xNu5X73R3GZ9td9zqefiGskpPudls81C450j1RDoNe+xmA+WVwyz8BqDtbGYCtiyPplo
 3ncrAzbSqlMUcMsCKvuFt0ERbQv9BJe8pIpo3tH1JY0/bqa6O2eVihJp8WvayMbl9J0cQ/rH3+s
 cvUbnRejZKD9N/vR4TRVIgXcjNZAfTEDhjymCRN0lkQ/VNAfBebzq9Vp/zzThlBHdxZFkpdgmYL
 7Tr7MbWG0KDiqtBWV8UzkHaZ/pUClIMCH8RSgLZUTBSxTVQ0XjeuNYBYgPA76Ng4/g+dBhNYNhU
 3wYTm3nIIkRgGTeLXzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
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


