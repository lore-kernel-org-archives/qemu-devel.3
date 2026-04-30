Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC24CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 20:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIYA6-0002t0-V0; Thu, 30 Apr 2026 16:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIY9z-0002mp-MU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:39:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIY9v-0000tM-Ay
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:38:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UI9fLQ1988268
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wSZ/Spf9jTX5omsj1ryEHouCjhpkZKbrn85CwyPrVfE=; b=b8Dk3zsLGhijR8oD
 zFLtlJ4VzJR9cQrYWpSLrm0VmREebOYDV4opK2eZUxmnJ2AM1Wxg8zpzh+zMNY60
 AT3uWLWcaFcmfPoEEB51NF+OiuWK9HcYTVpmLnmxZOGeKhutCB4UOmSt50/qvew0
 Gq1JO90Rb6rZq7po+lCB9canGCTS22WIft/dU9DujUR8XghlAHc+WCm/a9dgfVV8
 m3N5NcDIrXYT7pmtoi56Jlgai8Ctzes1lqfTLkm2AHX7/VYlTyMhlLDECuSFM80n
 bexj2/0R2Wgw6BIcv72ZTEwJmRh2TKu9EWgL7xCVVUWPqbt98UeFJvY45dzvauKD
 88pcBQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvc458mg6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:38:53 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2bda35eab74so1169716eec.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777581533; x=1778186333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSZ/Spf9jTX5omsj1ryEHouCjhpkZKbrn85CwyPrVfE=;
 b=X+eRSDFCBC4EcOWXIqRyXWSOZCwKfx3gqAv587ZQENuFx8z16Fw/pQxg3E2Hljr/Bb
 9WGNl1mdkPJtS81U0R1/2v/OQjNIhD2RgZxvuadK9IJAkntYkhzXrzrbj0zZkg5cwxLs
 rqvS4/pRlmqaFgCFiK5pbaQJ/adfn+OeXU/y72eZK8UEwnwqQspeBlvEpm0mLovw6Oaz
 8lVQoy+nYAFuQuuES3lyPAwGybWGQHLYx4+GC4Syyt9BZRnXHQsZ9J/c4XZdZfBbhdYL
 HeIIAd0sri0QMraSciR9Ye5Oo83we/7LLu/k8UR2BY9z7iCueatHUWYnTPjjbHocl56t
 UPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777581533; x=1778186333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wSZ/Spf9jTX5omsj1ryEHouCjhpkZKbrn85CwyPrVfE=;
 b=QXohenI+hk4qPhLiEcIphniaE27v0AoU5qzs4zoF4HEDtpKdCyUd+JZYbVg/c5XlM1
 PHZZ+oMVqqO4L7kBhT1fjegqx62nNb1AMND5ByAXEVRJ7S4RAhQ9lwGOBy8O8LgUM50Q
 EfgzWTOucr89IBz5cW1FMw5vqoApFh98ytsLW3VeYS6z/wRVyXhlsFXkSXf/1EyVIQK/
 7jslVNtWnmXe22NO8UNWSpNsVaVjOeYGPCXvYgrH6RMy9prV3XwwXQJcWlIlJAjf43xY
 IDdU7w7k19RD1yTVDrxSHLllwDlipGsI9Mm+WRSSMMA4F+uiJCcLtQVroo92eqlR5v4C
 lajw==
X-Gm-Message-State: AOJu0YzjTI2fn1VKmxtY76g9vMUtxim9FQPAazw2vU6hGQRZ8KZwsyvb
 fM8NLFN7BdzFErXToTG3PLxK9AEmekbNOqf70ItYfSqF+hlZaql7VKHPZe11iyYq3gZIxd2VLt3
 2tBAVAnR0+q2C1zmfyk4/ygkZ/2G8UW2ajeogemQH8S6j94jnq6+zx5LYxLJgrJtXx1fm
X-Gm-Gg: AeBDietSgnX3kAz4kcmCIlefk2X5To1ie8DSlcdAsyI08Ng6OuFZel9WirrLxlTRbU3
 Y3MhhYXlYiaXt0dwCq19pxSLsR+QlJjfIQqqq/MeMv+Clfqsgq2ld3N4GPN4+czDwAsLZ22eK0X
 TC1l+T505HzPJ6Zx8rpOoOzpI8b+gaen8cfnnA+ldl8jLXiWSTKxNDD+cRM88CITB7zKyeLu1Vs
 RtPVepFZa6UGtcI+bWv73cBN3UG42vz2HFuKQYwwjI5DC5g9IfeHsAdHAg/vsDWbI/DAU1n00yn
 o+Sxc6lgP8aMg11qfmDrzza5TaLYRYPcrtL+eSfZ/JMf4QBqkmw7uy86qqzUUr3WH49swMFyDfW
 aA2movoCRtdiF45zkHsXzgfoGex46f+ukch/qn1mvRuR3We3whztupW65cWsj846LZo+FvXd8EG
 QVf2kgpyTlOhJ3MwuY
X-Received: by 2002:a05:693c:3618:b0:2de:c709:3bc3 with SMTP id
 5a478bee46e88-2ed508bc481mr1548484eec.19.1777581532856; 
 Thu, 30 Apr 2026 13:38:52 -0700 (PDT)
X-Received: by 2002:a05:693c:3618:b0:2de:c709:3bc3 with SMTP id
 5a478bee46e88-2ed508bc481mr1548464eec.19.1777581532190; 
 Thu, 30 Apr 2026 13:38:52 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3889d628sm2202341eec.6.2026.04.30.13.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 13:38:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 3/8] target/xtensa/core: register types using type_init
Date: Thu, 30 Apr 2026 13:38:37 -0700
Message-ID: <20260430203842.29156-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIxMyBTYWx0ZWRfXxR+dVYkxVlS7
 j0bCXipso+pdhwxt0Nwa6ErZLEUZMcZQGdKZ5HWL3jTa5siqaABBXsJiYl5+pxBNJ4ndzTn27b+
 si0ZA74/8jbRE15DP46eJ6UjCgDALYZValr5F0i2Ev5ibsLvMyIQR0lOSNlV2RpdkrVmR2s02EB
 cVP9AJji99X8bsZqktkx2qmWFclMkqAJJFQvJ3EKhjewsk+Ei3R0XQmF19av/byqX50S0apDKAB
 eze5NbiTJ++ZBIf0p3zNGR7qFGoHkz1puJ8sqH4u5aGCMDx7sBSXSp+jKw7rgvez1e5VFMusY01
 /zd/e0lZLCrG/niQdR3y2m3DnJXS/8WYk4fYN43Rwta0D6MRuMsKg3AaSgKWhJPjCAxlfyXkQov
 jiIALk8cONzvDy80gUDgywYnWJ1hMGsukgE/86n8ovMCkaYxcR2EIi63eZN//hs1mroN1vE0t2d
 Unz/cKANKMZ3McdqoWg==
X-Authority-Analysis: v=2.4 cv=DP+/JSNb c=1 sm=1 tr=0 ts=69f3bddd cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=W37sF3GUcAVBL6lWIEgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 4wOaFA82bcYNyfdXePBDD-H8YOINklP1
X-Proofpoint-GUID: 4wOaFA82bcYNyfdXePBDD-H8YOINklP1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300213
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

Instead of using a static constructor, delay registering those types
until we call module_init(MODULE_INIT_QOM).

This is not yet a problem, but since we will start initializing
target-info types before any other, without this patch
qemu-system-xtensa* fails with:
Type 'dsp3400-xtensa-cpu' is missing its parent 'xtensa-cpu'

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/xtensa/overlay_tool.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index 701c00eed20..b9eaffa4871 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -451,13 +451,14 @@
 
 #if TARGET_BIG_ENDIAN == (XCHAL_HAVE_BE != 0)
 #define REGISTER_CORE(core) \
-    static void __attribute__((constructor)) register_core(void) \
+    static void register_core(void) \
     { \
         static XtensaConfigList node = { \
             .config = &core, \
         }; \
         xtensa_register_core(&node); \
-    }
+    } \
+    type_init(register_core)
 #else
 #define REGISTER_CORE(core)
 #endif
-- 
2.43.0


