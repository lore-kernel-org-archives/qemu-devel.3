Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7CFC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ5x-0004fK-GU; Fri, 10 Jul 2026 17:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5g-00041u-SN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5e-0004xr-Ow
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:00 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3c9P1846374
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dI8KDH83gtjPcdzvlZUpW22Kn62ST4iV3p6dUzDs2OM=; b=ZQ9mjjkVilkHXNIV
 +SuavHSFRyNVF4x3wbZ4tH8eRCOStfl1uypDd+cxRZ799O+JCOML98jq/8QitykS
 ZBWyJ1XNdvyoXaVo0lstgxpiQ5c3LkFb/jtCGpnXvyeJjMH7ZfjuR5ihpZAjU9MF
 +JEwznzwoO8LoRSv4Kz3iZ0T9tHqAPAafLdXyd0vACoruchpNSyzIwYbm2f6M5P5
 LqLkp2iJ9L5PMCe7PdvH/P1KwiLUuw66lKf7AYozJKQ6QC0T5nr98Fosihn7PSIU
 x9beLoN7gQ0RwIFV+SSlq1wHNub1ivPUArIWh+rNvMK3ArsRwtCplpalN75HHhvk
 231iZg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb649rjqn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:57 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84877b362f6so1813603b3a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720137; x=1784324937; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dI8KDH83gtjPcdzvlZUpW22Kn62ST4iV3p6dUzDs2OM=;
 b=DTlvEPhaKHu4MSPVHtDAAOs8AG1zQ7JeCoG1T/jvlW/AQqhKDnvn1mkJH0vJoT1H53
 stbMlz5Kmz3u+NDWAGoiATzzNffwI9NhCiqku62ISufBufYc8IbitnnokvI8Y+xSGvS7
 r0aLqPv4v3A/jkH8AwcXOKB+q/XNEc8IpSutOHGpJlrnJyUclY94MpfCMhRPc+gWQTWJ
 zfCaZ/CGPhEi7K5avcrsy2futzEiSvJSdtNO7paBR/eqrmuS4ZJNJlRPv13ICERgmvHQ
 u05K0U64D2jOIKszvepkTTJUk687nwAhqL45rkNCkDgiNQUOGfFPSiC6dG+/9TWxZ2bx
 MtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720137; x=1784324937;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dI8KDH83gtjPcdzvlZUpW22Kn62ST4iV3p6dUzDs2OM=;
 b=LutO5kjvkJGi9iWneSCENVd2Ma7X2bO5C0otxYX86WQZra9beg/4wBthypBJPTG8rh
 WAf0jPwJWlklOb5w2HmKMCHjzvu5nT9t1Mia7UCYa39QIUIuB9JmmhpU54H0b5rl0xoQ
 +nWB3EtrCa8cFNpErGM3KVUql/drTJrVemCL2M7xXL0HR3GqkdcfSe8KpHuaiDXwGHO9
 wFslhPHYNdzjvI2Z1UhPY/RSRz+1rOiOX+V4Vw/kCzEOfdzrUrgcWo9kCoKA/jugYt9e
 KaBp6/1hwt5arygPnY8XLcNSQDARyd5TmCEbLm1q15K36oYEbvWMT4njGn2a+P/kQzYn
 grVw==
X-Gm-Message-State: AOJu0YyXWy/ALgno0SJsbkvCXTrC4PP/Rhqkh7R4yFXTWmYCmDvpqyKw
 FGOPDNV/EXm1KP4LA3YKk5Y/caLnCYOypElVEiCzmL4dBfqXcLT1xM0+XuZxWQylOjEiZ/1BohI
 n/RDAJ2JDi5upGz//Pfb2XUv48/hpxlJ1dhs82q/tAQT1IZ68leIrcBx53PadQAI59A==
X-Gm-Gg: AfdE7cnP+C5yg6ERBZeBeVhblWdPW4rnHYsDGmBzc0BsWnogq+nGkZYLq1Rjd0rCI2t
 c8r+wMCHnp6Kvd9T2XXyuQwWD76bCUurZBqxyQce0wyZ9MrLnFfd2ThSdyYWqBMbTDYIlQfsKzD
 tCobI/aSHo9Fpv2exQwK5HIBznSvZDwqKCqVEJzwFkqyV+RCVAVaEbuwysYP2VOXlIhw8Bva/Te
 HJFPx0FR82Va4F7P3eZ2hgweomGJAFlwNzI1sBzWG6vCRcQNeRKv+DlYjvB63XWIEt84wSnHyX5
 Ad131ACz9FBIDsqHT2M79t9rbU4BabRN1YXs1Ezcu0H8awpuRe7Qxm48XCZZXS9djRyX4Q/v8vk
 pYFMNCTceryCYXtvyQn22ZT+ECXfqFbBFnDSbkybMwJLnZ0jcqFRUP1usIKDqGlPoJntz/fPEGs
 VRI3J4EQ==
X-Received: by 2002:a05:6300:2290:b0:3bf:a0e5:99a5 with SMTP id
 adf61e73a8af0-3c110b45626mr666814637.47.1783720136753; 
 Fri, 10 Jul 2026 14:48:56 -0700 (PDT)
X-Received: by 2002:a05:6300:2290:b0:3bf:a0e5:99a5 with SMTP id
 adf61e73a8af0-3c110b45626mr666788637.47.1783720136362; 
 Fri, 10 Jul 2026 14:48:56 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:48:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 59/98] scripts/probe-gdb-support.py: add mapping for mips
 architecture
Date: Fri, 10 Jul 2026 14:43:03 -0700
Message-ID: <20260710214343.2065491-60-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VZokBYVbe1DZgwR8AioDlyeNOkr5RfUL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX8cdgtsIkWNKv
 2xdlu6Hk98kCkl1jVy9uQuzDRtLR8rZuWW7rO08zS6E+xKPZ0mwdaaGYce1Q1OdIaYL2gaarkFN
 2XpL6EDWCQjtvXLSRj9Ta2C3/rslvmF1SNVxyORq0n02PP1zNXkguecMqZqxM0oPUB2Yfzz6rhT
 zBc1MZBeksJswP7zMdTPvXH3gNR5umAn5wGvbu7+yvBGh3Zn6Vq42QByVfPF+Wby+iY86ABH5w7
 t++KV7boiFRUZAdjBRFtfOS3JEA9o4jvgM6V3s9bY3311Dd2/uZz8EgGE6oWBsmRRVY0qXuQMGq
 jtfD/ONwqtrRPVtQbFVQj4qs3Xd1FNQ7YoXBOxo7CVApGk6T9HsKlzAELOSwSk4Gyz+0dBdMUbp
 6suZdDOSbLlQl9n5RN41A2Gi7z0Iwt+4+G6OBNrW4l/xSlSC6eeqhogD4yecKgseKbm27B2Hevm
 i2g0lHkW3KXlgjGs9/Q==
X-Proofpoint-GUID: VZokBYVbe1DZgwR8AioDlyeNOkr5RfUL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX7QdVWdDBSJR7
 R61LX6yxMQP11G0ITrGVs9MoqKVaTuVSMV93oSW32zklhAZWnmME+2l6Do7XqxypMKHaats6mdr
 gwV/coj1uKcifR6YBNZA5ESDB9qEEIk=
X-Authority-Analysis: v=2.4 cv=VZfH+lp9 c=1 sm=1 tr=0 ts=6a5168c9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=plJD_5OMxHvttXuW0nUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100219
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/probe-gdb-support.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/probe-gdb-support.py b/scripts/probe-gdb-support.py
index 43c70302873..6e3b2579770 100644
--- a/scripts/probe-gdb-support.py
+++ b/scripts/probe-gdb-support.py
@@ -35,6 +35,7 @@
     "Loongarch64" : ["loongarch64"],
     "m68k" : ["m68k"],
     "MicroBlaze" : ["microblaze"],
+    "mips" : ["mips"],
     "mips:isa64" : ["mips64", "mips64el"],
     "or1k" : ["or1k"],
     "powerpc:common" : ["ppc"],
-- 
2.47.3


