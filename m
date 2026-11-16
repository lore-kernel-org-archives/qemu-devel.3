Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B531D606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fk9yQHqD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ORhgF5bn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT648-0004ih-BA; Mon, 16 Nov 2026 18:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT644-0004RP-GA
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:24:45 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT642-0003Mt-OG
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:24:44 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfGDk2247139
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xn7jFMCM8TYYfzZcU1uXNAGSaAfBWVsHhhUgaTHd+p8=; b=fk9yQHqDeXiHER4f
 eqy86aR1y0o7LWVBrdpA3kihZTf6L5cLyVChPxQeC832U5TpyWz9kZo03ZqOurLX
 2Tjfe6zumgBqcNWMnoy70zbzfhnFuQYmWfK3nhJvlHwXRd/116Nm39CPoZOjLfA2
 3iUQ/WbOYKcRTxusOoQQ9h1pks0MHVoJwiuiQjwRvmIgszCc/l5jSyuH1tTQRbrq
 poTxk5UMa9XrA3oeGyI94k3ZL5vvGIXxhSs2jMfUx1OVr1d/ix/0aWAgjIXTUI0Y
 g3mFWQwmT2G8EjMKuuq0YsJ+4Fct21Utb4l6lXQe7xOtgU7ua3cdpu8fIEMSals9
 pv3J9g==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqyb0mc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:24:41 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-97e8be2221eso504302241.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871481; x=1795476281; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xn7jFMCM8TYYfzZcU1uXNAGSaAfBWVsHhhUgaTHd+p8=;
 b=ORhgF5bnmgTbzDs0/CrvHubRDLzcsS/nbammjUr0HwJY43eggIwmVRpVAHNDyRSFKg
 DMm0CQiM2JD3O8ZSDi5xyXfRdBJGAPGzpFd8iFlhfhxt3gl2z9yV3flZBQCsrCB6h7Cq
 +8jUCweDV8g4uAtBoaZbOhU8/n2W26Kw4vOd4hOnyP7t3rBZCSI+U4aJv9Y1r6yvrKLC
 HLM8qMpjoJDZ+B07IRvlBL7CWldaeecmMsj6H204OePXoWYXsFAfRnHfhIhAwaH1bzOm
 P4I0Z+h3nZ+MxSIw/NMQpZBtHLD5AvV/Gr42e8o1cTPHA4coNrDwO9W76rrkz3gAg3nu
 aQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871481; x=1795476281;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xn7jFMCM8TYYfzZcU1uXNAGSaAfBWVsHhhUgaTHd+p8=;
 b=SWvAbENRQA8Rs3fKK5zZUKs5/DMivhRCiZfCkefEpguifyxcgcja3zZ8MpxApRI93c
 7cA0/R43hVRk4zxhWlzA7IWDG6e2KG7kvXBW6snqipKmbugOLrXCuBTtov51Rqq01dhV
 dU1wLz7lp3LaiWwOKu4CjMMeYdpYBXliTxLEsZpNcmCpM6DxiluoKoRrUgO1lrSnvTXc
 SUN2+u6VJxMk13OffFaAYkcwUfNZyhqwPhKT715Pyck481jtu7sAa/osL3u05sUGrDZv
 DvcJoB82L6lxk+FUwXF9RxOAM27iYP9pEg/B2dgDRVBkmjPtbb58uBxkr5dGAQxaSIyW
 /7ig==
X-Gm-Message-State: APuU4Z9WAk4e4MotlGpGQE0ummOgL3SW725/yOie924Ak8AlnyeWI1PV
 0/rgDGNCDepj7Kr1OJdYwgCTeW4BA5Koy+5vVRCkOx1X2JMTVmH643uWMP1/ujcU29Yg9X25ZG7
 W3GPLx3ykijuzwTDz02d+tWr8NAoQVXtKrxzn8Xp9X/jxRhXu1qeZWmOl6HxiwouuZA==
X-Gm-Gg: AYBFou20bfuDxZrXje28uf9NA8XTN2lsKQa7EH9gms5uICxM6HBVWGR4Kie7Hz8MCds
 OrE/k92O51ZjFCQObJGEvL609wI1FKMqnE9Ay95RqHQXX4Z1VR65ua2FWmcSJD8FEVAmxs1Y/I/
 fCO2kdjEfhXPWOF4u5B3A2tYKedR/0nKLISEwEkIQG/DqswRgWdlovWm/NW0zvpkrqEcIsTdiiS
 ZA+RGLA03OXQ/Sl/YW0HqKDKqIgJwKot4p2JnG9h3JKz9/aPs5gfYIGHne2zJh4O5LKV5ZYFVZz
 YhPS4r2c5FhHCIQS2GeVQT3yyY+9tq6/eTnKmYTa24JZ62hwCOwRFJo1J/CYuEjBDAUpV51Vled
 16PIBGBkseNSvoQlPvG81PGqolRnhk7SZi1gUzWAZHggh0ynekClpCvahsKCn9fiTrupv9FtXQM
 zBKUlZmmzJYdTm9w==
X-Received: by 2002:a05:6102:508a:b0:7a6:85d6:8ae0 with SMTP id
 ada2fe7eead31-7d64d474d7cmr3582267137.1.1794871480976; 
 Mon, 16 Nov 2026 15:24:40 -0800 (PST)
X-Received: by 2002:a05:6102:508a:b0:7a6:85d6:8ae0 with SMTP id
 ada2fe7eead31-7d64d474d7cmr3582265137.1.1794871480448; 
 Mon, 16 Nov 2026 15:24:40 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7843bd79sm20956825e9.14.2026.11.16.15.24.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:24:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/22] qga: fix build on illumos
Date: Tue, 17 Nov 2026 00:23:21 +0100
Message-ID: <20261116232335.31593-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX/+Bx62l+xUiv
 6UPV6pCgnwpW0Ccv+TFw9N5BokWunTF256Wu2XdixfSgwanPH9BxhShV1L4Oy8VNVVHD9hq7kYQ
 Dq7n7KF5WHiTQGVCipKzZ6rg1eYPi54=
X-Proofpoint-GUID: RgF-eycBr0K3JFitZCUeSzPhBtKRCsDx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX6ORZxXheHl3v
 C8AUQwGGH+1Hy8TWmY/xlOBLfOgICfEyGYtE/SSUyp6YMBQH5iE4c00o8v36xPYSc304ESRIITn
 eNNbOmxYj0XAknSphbtMgjtscGPVoSQ6Y33Jgeb4Q0cA+0vB77nMtlnQTLt4/UfMeR6MedA496J
 qBtuOWptxXpXfnxtJDIf/1eu4ZHI0QQdy/FenWC9s3cRWgg+6kVuOavtMWckmIhHX9iSpa9XwQx
 ThZDJE2d1XejG1cXmpLK2CHNhNktcAbV+T3woO93HAVwae4zpqM9X2ebqAHIef7pnWUm6t7+pn7
 rkHeCpofZYWXkFcwL0eOkMg9UMyBByt6rguoR6l0ynuvWwS7DLdGTWIVO02SpYefy98yxUFAuaz
 eZo1/sdz63pCY/mlh2u/vHWyZeEZfvhKT/SdV8s6ShBEYwn64fWkPIAwWVVrDjgTqxEJL9Sdq9E
 L3+ifhpObXW4PJ8h2pQ==
X-Proofpoint-ORIG-GUID: RgF-eycBr0K3JFitZCUeSzPhBtKRCsDx
X-Authority-Analysis: v=2.4 cv=ePeGH3p1 c=1 sm=1 tr=0 ts=6afb90b9 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=jyaZT-J9KmfTUxG9wW8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Roman Bogorodskiy <bogorodskiy@gmail.com>

Currently, build fails on illumos with:

../qga/commands-posix.c: In function 'qmp_guest_get_load':
../qga/commands-posix.c:1408:9: error: implicit declaration of function 'getloadavg' [-Wimplicit-function-declaration]
 1408 |     if (getloadavg(loadavg, G_N_ELEMENTS(loadavg)) < 0) {
      |         ^~~~~~~~~~
../qga/commands-posix.c:1408:9: warning: nested extern declaration of 'getloadavg' [-Wnested-externs]

This happens because including <sys/loadavg.h> which is needed
for getloadavg() on illumos is nested under the "#ifdef HAVE_GETIFADDRS"
block, and is not included when HAVE_GETIFADDRS is not defined.

As getloadavg() does not depend on HAVE_GETIFADDRS, include
<sys/loadavg.h> outside of the "#ifdef HAVE_GETIFADDRS".

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Message-ID: <20261015173250.65942-2-bogorodskiy@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 qga/commands-posix.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index cfa5627a61d8..ae53eb356965 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -16,6 +16,9 @@
 #include <sys/utsname.h>
 #include <sys/wait.h>
 #include <dirent.h>
+#if defined(CONFIG_SOLARIS) && defined(CONFIG_GETLOADAVG)
+#include <sys/loadavg.h>
+#endif
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
 #include "qemu/host-utils.h"
@@ -43,9 +46,6 @@
 #include <net/ethernet.h>
 #endif
 #ifdef CONFIG_SOLARIS
-#ifdef CONFIG_GETLOADAVG
-#include <sys/loadavg.h>
-#endif
 #include <sys/sockio.h>
 #endif
 #endif
-- 
2.55.0


