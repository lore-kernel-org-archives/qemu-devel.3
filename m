Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE8FC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu80V-000704-RH; Wed, 12 Aug 2026 08:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu80U-0006z1-Av
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu80R-0001qJ-Se
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:29 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB5G7x2397206
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DrbbpvJ8PS4d9Wmp3LH1rQVAhWTDBdxV8i64qa6nA5o=; b=YjFDWQ1A0UCd1IPi
 gb9JfxwiT9Jf4Al5d/qYvKnF5EtYQXsyPOnOAa+cUTlzftpTDrcyYynk+srdDJNk
 Bms6rbGXrHnxJ8l+2q0+O3Wp1DikcKm7Hu2dX3Ei55ETtDNZRUvkmMYtCmnm/1Jp
 MENkPVNpHPVWai0us112U5Ir8/yXs9JVLA4k376He69neg0twDmHw3afIh4g83/P
 CR5NXZLCHPklkdxxluGcykkVy4/Qt3+j3Ye8DvqIdWvVMy0m1rStLfwriaMYvGL0
 2ksO1cL/gh3BjUpNIo/lV2u6R73QVlzMXVI8QazNwx8wuzvr8Fdo1Q0Bg99X06PE
 SdT4fg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hfw1rmb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:24:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c12e43b98so10814661cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786537465; x=1787142265; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DrbbpvJ8PS4d9Wmp3LH1rQVAhWTDBdxV8i64qa6nA5o=;
 b=fyZ6xqCNXeAVSFoDuoghzOud6lp4kfg+ta2qq2/ciI+x+o+hfp1SA+GtGl4Cw0OB1r
 tEp/sAiJpYd1hxgf2DZ8/UefygTJRX3CwjnGIBVFfw6zAORNhd6Hzy6rP5vz5CJ4XS06
 IFBNbFNvDC4otFj9z4639Z/klEQt2XgVBc3GYDSStg1QPeKaXL4iHAZa9oHmlzIrW8In
 J4NJaCnw14l+a6gVK0s/54HJ/jnQ1lS3N8F+aFO7C/oxeDH+W/dOS/8lpEVhNR/5eICe
 VFEAy6kW26JrZYdr65R5KGVPHtcit4JiniAVWQZkiS4KARWxkG6b1upIxLJ5iLCW2o79
 R8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537465; x=1787142265;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DrbbpvJ8PS4d9Wmp3LH1rQVAhWTDBdxV8i64qa6nA5o=;
 b=WMMSK+bUzQmEjHijoVkv1A3ayWtHIFh78qVSsQsKaCbPs605O/SOUjrnAMstOLTp81
 6728N+qOxYn6pOVtbH4TPa6RLmm+jWvIWU7GISAJxiBIUYp6XaxFi28LjzBRUwzwUOZS
 yy5ZkJrxeh1HsPdDVI4YDnsMD570iI7MPard9cGmmK4FIZUrJggzaNCByMY0YS3xjoGF
 QjHxFZEl82AUi0qcCKlCga0ryWWU96hSU6JF2PeFQ80YmPi2QRoI2eCIP+YxkcNno6AT
 RGNYhrxVNWDwQhkMo4d1LQM4MQFCQBDLHAXGJCR8ot+H5OPok1uiVnwczaUNLNlWCtb5
 HrgA==
X-Gm-Message-State: AOJu0YxckVfR3N1gkqn8nyjmQHYtUfB6qujbgchPXeuw/l9UpfJJek6O
 Otek2CWCJg9T9OqUWGe4DUjNlITA6R3Sw94mYb54mrWtbUNRdVjfDlHwC4dcwLNz+ixHQeCWLgr
 knC8p21xP3CkXQ6qK8kF/bmUSDbdg2+6nps7q8gDMZRLm615bCoGR20y8pW3/PwukqQ==
X-Gm-Gg: AR+sD11OIbZ4Ehw4UJ/xid0o+WToPSAVzkLb7zojZW4mVeh/j8l7+MHpWPEzY+Dq9Uc
 NxHrxsS9W0J3OazKUiH7FEL9EnzImTUTVZ4iDqEUH0lFaSV9iwA79byNI6bXhsi0BMMkg/svR6h
 hj8k5Vj1EovCHqvcsjhxsYBTehMW6jB50/CvxkudS/zaw2VNROE/zSQS+s3CxQYsU9dgow2e+jr
 Uli3dzOzMryg1VGRUILQtoKwkOSoW8T9iHqNAsB7gZdMPdwkhIeEHhmqH7jNd9mpTS3RjR+l5Cb
 IHt1+gXD8702NyeHqjZYurdmIeMFU+A56u08McYU2F5JCG4TQTtrwOXxomMzK+5AT4HhZtEAb2k
 Wdua8VOV6cu4t1fCQWgLVlne6ShjsbfVsbjvkJFZHdw==
X-Received: by 2002:ac8:7f53:0:b0:51c:1005:d096 with SMTP id
 d75a77b69052e-52d648063f8mr35285331cf.24.1786537465005; 
 Wed, 12 Aug 2026 05:24:25 -0700 (PDT)
X-Received: by 2002:ac8:7f53:0:b0:51c:1005:d096 with SMTP id
 d75a77b69052e-52d648063f8mr35285071cf.24.1786537464552; 
 Wed, 12 Aug 2026 05:24:24 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c98d264sm50385175e9.9.2026.08.12.05.24.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:24:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 07/14] monitor: Include missing 'qemu/lockable.h' header
Date: Wed, 12 Aug 2026 14:23:24 +0200
Message-ID: <20260812122332.72975-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812122332.72975-1-philmd@oss.qualcomm.com>
References: <20260812122332.72975-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfXxCcO4Q+Q1jvu
 JhgAvoWpHYU6tO6t5Bubp29MBYCQP+xpCGYGbe4SaTS28MlVen/nOZf9wUuklvzdXhF/I0sP3wB
 KaoP0BizFRVyTXDEsmw82lAo2uKeZfY=
X-Proofpoint-GUID: 5zng6HjfxsdKNGBjoNkIW0YMrInUV7jz
X-Authority-Analysis: v=2.4 cv=fpDsol4f c=1 sm=1 tr=0 ts=6a7c65f9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=_5bDPQybseJbp6lUwYQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 5zng6HjfxsdKNGBjoNkIW0YMrInUV7jz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfXzBfNJvCuhShm
 T/XrtHkm/WvJ2aLaDR71gpyTLPsZJ3zvULHYF1iGH9Cmwc3B1R69vZBw6/KXlpJJIYGfXkfRKN5
 HdGhPQ+ZtdXJ2DFBW176BYhcPrwkdLcN25uSfnOa5RHIgDyRjg6fNSestS2Ulr55hvF71T+CuT1
 5E3g5JR/xYLX856lha7HKz63fQ6izU2PJtMIOiyUsTuSfIee+d9X2WFC66RmooIOo9C6Qn53POZ
 Bm/0w75i2vRMUrHJzgG8AOO9aYSN3k1W7JnfG6fSeufVrnJJmkPA9oDVYJAGE9GBfTFSp+6uKIR
 wpFtNgxsXeqg6iLEmOHVbeOrCxGzJfKeVz2sY43TKbRO5CMeE2eXegTowHz0KgIHtu31dtHa+/d
 p9vkJ2kCh67wohE4PmYSjpnOEFRsMoGWPOVgFmMBhPL6Nl4ocnBFw1Weuokl9qVHHspAHBsk+Ib
 jiQSqJxrUh9i9ZUwf2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120100
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

Files in monitor/ use the QEMU_LOCK_GUARD() macros, which
are declared in "qemu/lockable.h". Include the latter to
avoid when refactoring unrelated headers:

  ../monitor/fds.c:146:5: error: call to undeclared function 'QEMU_LOCK_GUARD'
    146 |     QEMU_LOCK_GUARD(&mon->mon_lock);
        |     ^
  ../monitor/monitor.c:176:5: error: call to undeclared function 'QEMU_LOCK_GUARD'
    176 |     QEMU_LOCK_GUARD(&mon->mon_lock);
        |     ^
  ../monitor/qmp.c:164:5: error: call to undeclared function 'WITH_QEMU_LOCK_GUARD'
    164 |     WITH_QEMU_LOCK_GUARD(&mon->mon_lock) {
        |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 monitor/fds.c     | 1 +
 monitor/monitor.c | 1 +
 monitor/qmp.c     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/monitor/fds.c b/monitor/fds.c
index cc35d2ec334..abe5f13487d 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -29,6 +29,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
+#include "qemu/lockable.h"
 #include "system/runstate.h"
 
 /* file descriptors passed via SCM_RIGHTS */
diff --git a/monitor/monitor.c b/monitor/monitor.c
index c75ae815343..6af09f2f6ea 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -32,6 +32,7 @@
 #include "qom/object_interfaces.h"
 #include "qemu/aio-wait.h"
 #include "qemu/error-report.h"
+#include "qemu/lockable.h"
 #include "qemu/option.h"
 #include "system/qtest.h"
 #include "trace.h"
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 6ae1098d39f..aec03157750 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/aio-wait.h"
+#include "qemu/lockable.h"
 #include "chardev/char-io.h"
 #include "monitor-internal.h"
 #include "qapi/error.h"
-- 
2.53.0


