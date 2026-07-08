Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434E8C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whVRs-0008E4-LG; Wed, 08 Jul 2026 12:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whVRa-0008D4-W1
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:48:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whVRY-0003pa-4d
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:48:18 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668GLJat3347806
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 16:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u4SjX/kL0LY/kM1PytxvTZh+qE0lU2yNtzzv6qTPFa8=; b=Grc49p2Fx/zz0CJF
 7j7iY0WIr+gZqwmOOIWtAVOemsFV1K2hplrDwRMeT4b4i8inHJAfM0ThmJxC/fD0
 swSIg8pXDK+U2GCcMQTa6EPmwbNxpzbwc/CMujtVcxW5sVbkDzKOOBg//pg2MvdK
 jzI/b71Wl+hMzXLQllCXAt7Bnr7e/5QDmsbHa6gKdizElGzYY/TtfIbbSK3bwDQl
 LmOxbgOUauFMdU6bDXQMn6wSTOfYNHWCaOD4JBbx9cVNJXzjntVmnJAv6u97DqFI
 GXrvCUGj/w5c6Mc/FIQHZlLh3jbrdFX4pcuagx+CL92WA7umECE6e8Shac7xsLCF
 vSbA9A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9g7hjv1n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 16:48:14 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88da04b719so879326a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783529294; x=1784134094; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u4SjX/kL0LY/kM1PytxvTZh+qE0lU2yNtzzv6qTPFa8=;
 b=OHJ/TEWJjpMQgOhhF6qcAyrmGiinru49Yjr/2bCze1/0bzMTjjvldu5b7Pm0zV+6cD
 B/jOL/l8QuoYeHhJp1vLI9qyIc4fU4BCPu15gR4aIinYloZmjSZIcwoklA7U7Jqcv4DD
 cFd9R4G0zg22OQfFT/8GMoro2E1mTzudDiwpNJ6mhc+sqINduYutMG80P2exC1MCvMsh
 6VqBul+o9tHVgYzyGNoDdreBI48GyOUnr8qVPl0giTSEhNCWvikR0AosjWtc2rErNFak
 m8J9Go03TxVJjTVpA/oFpLFPFzh7QWL7t20Q9OSqbkrb2nRQqQgxwbfFMGpcg1+U64NI
 Ahyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783529294; x=1784134094;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u4SjX/kL0LY/kM1PytxvTZh+qE0lU2yNtzzv6qTPFa8=;
 b=NFknz7ogR6U6ccWqgfK3z1NvKzdg4u6XNbAt62mhNeh7IsI/9/ho4gM7Pj9hrYRHU4
 AMqfqTyPEBiY3Ea2/CHkQLsFt/rTXtzanRgVp5jet7RkChuIpt+AaEvMT3pD1g3eE+09
 p7VItDLgbDYD9BNbOOzE7iQ/MuF2x1U/YbderHtZRLCGUhzU21pcOoIc2AY9S3RDWYwm
 +bUj2r9jZFZyjFP+/X/Tan3mWr+6MoSRMIoqTkYqxJfPeDCYw1IeyB4zVvyR1Hm0pFUc
 vThk8QAdXMWwUcOwhQ6rtuqr+eXYVRWueByM5XzY4Tx9wAwjEjjVPicImejkk5AlgCUh
 7pdA==
X-Gm-Message-State: AOJu0YzBdRcUAq50Q15Lc+zOUcw0JE9fa8358ojLw5P6I+/6QWh3fUvC
 6pZ/8bodCpf5oFhtyTihJoN1QslR8c8LcAjzeXqGidU9pfFnQCSmduQK3TUEPR6YhfZ0vkz1VJ5
 BbQVTBb42fDxamCg9jNfQPXmzq66aKefUnP5RjJTOIPjmHXd8JAJg4TakvTxI+scJug==
X-Gm-Gg: AfdE7cl0I+t7+QUav87PgN/soaYstRSEs46KhBQBI86ttea8UPH2DzMl676xdg3v8JG
 ASJsTjlF4OexCyB018mkaygOCHQlwe/o2Q31c+Xgpif6KubI1sKV7+1jJO3bK4ALvYoAYLJwe4j
 9LHSoup+E2q0tHjg7FqYVWKY//73n7LtUp8Ro3IzP4TuAXoYcZQrmezk3FBOkdTe8RT7tb7i83m
 jH3Atva7BDe+Vmr+Lw44odjFSAyjBEd4A44uuKGT0bycff/EUlMRIcwjg+ukvwJQPYYbAZhksX4
 hExSas9E/OfhVaOVJAwHydP7lmqzgnovh4AfU9/Orgx3yfu+2+uFfhQbDvBnyVd7YdAyI79Ux9v
 CVB6vM7TzdWUhphhyt4IIwf7RKMKfEUuL2DK66MMc4tUSkIiWMqwc9/m8GrKBVm6vY1Z9TRbufZ
 SUmVMyZQ==
X-Received: by 2002:a05:6a20:3d0b:b0:3bf:7ab7:98a4 with SMTP id
 adf61e73a8af0-3c0bc95bad7mr4308090637.27.1783529294081; 
 Wed, 08 Jul 2026 09:48:14 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d0b:b0:3bf:7ab7:98a4 with SMTP id
 adf61e73a8af0-3c0bc95bad7mr4308059637.27.1783529293617; 
 Wed, 08 Jul 2026 09:48:13 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f5975sm20603290eec.4.2026.07.08.09.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 09:48:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 3/4] tests/docker/dockerfiles/debian.docker: add missing apt
 update
Date: Wed,  8 Jul 2026 09:47:57 -0700
Message-ID: <20260708164758.1168667-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708164758.1168667-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260708164758.1168667-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE2NSBTYWx0ZWRfX6Dlu3VmCaVlc
 +EiI5dQEn2viViUnVyYNbX5SSZd0X5JTOipBs42hxgoun1mhB6LRc/qXH8qpDcx2OJA4XvPBW+I
 FGDawKosDK6uNVbgER522fuFK9u4hazem0hnKRlLWBXtrRxUARiuR63dyPlGWhZ+6KwJxizSgl2
 YL9bl73+UcWe/h68D/2u/xzfdIDGc9CMhwgWW+lm8mxEh/4KS1bp/jp85eUSd+a6hhx2QOulYnz
 F74obkqWL78+RcNYRduiJqN6zGaleNBW7nNmNek1urVRMT0u7YZbe6b2u8P650w+twrzOYoG8U2
 YFoVN+d5nTf/rw6Iz8ymFn8uB/qtDD8mJrRg7ewinPbU2hOhDXXtYbarUzDM1/76x2vaiLemUpL
 jtH77TxwMBeX9F75ow3M49bP7aNW+sHoFcnHbH5SwY4gAre5qUbzU5RarJs86LiZJkFNbaaOBlE
 jiJvLnkD0wWqmFY7VkA==
X-Proofpoint-GUID: 89FIbO0jQZlcxHfeLGfModcUd9lZ1dgE
X-Authority-Analysis: v=2.4 cv=TMp1jVla c=1 sm=1 tr=0 ts=6a4e7f4e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=n6MYwUk4AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=TfQWm953iMTqW6bhDMEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE2NSBTYWx0ZWRfX3pSnoMj3HeJ+
 xsL7kU8u8C9HK99UgTT9XJ1xkT6iRinA2fupHLyeyi8rWQLBvo/KcmM4OEO3RC+FqHycfebcnQ2
 MQEizzD0tRG00RY+QMPvvmX14EPddKE=
X-Proofpoint-ORIG-GUID: 89FIbO0jQZlcxHfeLGfModcUd9lZ1dgE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080165
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

RUN statements should always use apt update && apt install together:
https://docs.docker.com/build/building/best-practices/#apt-get

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260707214655.1138626-4-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/debian.docker | 3 ++-
 tests/lcitool/refresh                  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index ee8b313d654..413986d3f07 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -157,7 +157,8 @@ ENV MAKE="/usr/bin/make"
 ENV NINJA="/usr/bin/ninja"
 ENV PYTHON="/usr/bin/python3"
 # netmap/cscope/global
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+RUN apt update && \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends \
   cscope\
   global\
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index bbbc6d3c46a..8def84d946e 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -111,7 +111,8 @@ RUN apk add clang19-libclang
 # test
 debian13_extras = r"""
 # netmap/cscope/global
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+RUN apt update && \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends \
   cscope\
   global\
-- 
2.47.3


