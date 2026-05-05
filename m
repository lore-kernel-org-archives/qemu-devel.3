Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38A6FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 22:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKOZB-0006Ox-0v; Tue, 05 May 2026 18:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOZ9-0006O7-Dl
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:48:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOZ7-00069o-Lp
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:48:35 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645EKDuw912453
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 22:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wSZ/Spf9jTX5omsj1ryEHouCjhpkZKbrn85CwyPrVfE=; b=cEGyDVbfLNLYyKjB
 OwyZspW1d2IOsyAQkx41bTy8EpGZGuJqNpNsMlUlIbzK4PhHnbyQceV0lm9CEuIl
 a09PwDBODKlw1dh49LN6bo4cp0L9WXHxcpRD2iYTLwV4/YMLWCkH/BV0dz6BQdOS
 SAKdAYrdx+vN0OmLuK73pLxl2jXGZztxSvKy5cHrQIrew4aw/TpdGDdqDRkSe+8w
 WHJ2RnDgv6zo4LG+aR20VH1RUmkm72m5CvSvXdskKzPFYJliz6nT/YSKfDAq/Ypo
 nznfvE6qsp4HGhmMGrFDAIyKLWUBZOj+hymsiDJ+XvlTtOF/hEQ/Wv74QqHkEPDe
 GEdIIg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyj7jhwpe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 22:48:31 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ee1da7a13fso5850313eec.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 15:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778021311; x=1778626111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSZ/Spf9jTX5omsj1ryEHouCjhpkZKbrn85CwyPrVfE=;
 b=R2vClSh7zopBe5LED/R7BgemW0bS0Nafe887Z1XrvgV0EXq1fiqkLEG4EXgH7YYFm7
 sklQMbVC+aZ7HYs5RHLjSq2s+Sz9F7h+PFuadw5lal9gw4YVIQ4q/eBneKT0XSsxpZYI
 YJ9vakVo/bFvAtxXNHGgi29rpi9ZPAXMwoLPAUaPFjys/5/fqVpU/w+p+fSRKw4jRi57
 nda6192xEGsoUAPEk11+BoFNy0jVm7SQSOGVy9/7S94wE/S0Yylqe5QWnxxmzOmU18KL
 GjKxviukSdg1je2e8xcPPvSB2G78gksObsH7YmO2a/hBYzNaA1REYhFXQvYyDfx7lMFw
 8E8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778021311; x=1778626111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wSZ/Spf9jTX5omsj1ryEHouCjhpkZKbrn85CwyPrVfE=;
 b=XL4vsIdF1/xMnjlH/amKWeaDmRn9TASnlOSX/UTCwfRzD/5xG+4TG5dhgYazkNeLH9
 4mIpskZLnHDxYQNupwn6ZggvQLjYVXr5C6O0qoQEGjYsn2Js29QCSY7IOqkxMN+n6y1W
 bd/R3gPmQfxDR6ZwhzXCt98qosMwbzF7gnX5FnwVUi7BRf4I4rvvrse3lw6y9naQGB+i
 3H0AGymLOC5cSajdEwhixchbur4xnE660/GLXTK3qj35L96QApJJ5LB/lPkvrLVkooQa
 +YeqWlV7cXoyacG+8izXZSwtJQIlOY+bTL0OUeXmJvYy6XpOl+XaNVMgI7xr1vEouKL3
 iwqQ==
X-Gm-Message-State: AOJu0YzDMhtuw22mP4apRDtKzxs5fW7wZL6vnJ/dSbMotxtl6t/BN03J
 PAeQZKGaRKVSlZZjwVQrVpHTj8kjeJSqN7VaKXiANbkp8H5bQIuyy+VPeXLWrECvbpFs+GCExxm
 hK8CWmos/hxZjWhEJH98WU2Dnkg1xV+6O/WjGAmyf0Rb7bUfqKsDm8Jsv2aVxR4rZ1RGV
X-Gm-Gg: AeBDieu8S5T7+ke83ak823nE1J1JvubCq7ibLW34veIKjw2nmlwa1yrhjDUtrqtxjUr
 50Xx+FYUjITBSiO9YkBWzNwJtXyDskkN6JVSC4WGusMUhLJRReauVJ74QEun/h+cDdikvyxsiRc
 wWggMeYvIqASNDg/6Pa9FioF/CUrI4puQ8hPQ74M95yIdAkj4xeYc3J57elV7SdVK+aw2FyRT9O
 qNks63uWszsAOZSbyyA3gaUwlI3JeO502r7dBq4HKZtdgMBceDfHV9i4W7gx4MYe4pl2YG+fL03
 VJkDmdYTWYRmAbQBToSKNbV81XA2yh4pmHTYAid4647+jEfOPQxDwoGtGpjYsHCCLsKwlfq+QN5
 sSRBeU1AbRGZfhTOLNE6z23GHnlLlTFPRUqY3EnRcxr4EBS/TEbszxfnvh0QLCOnBQwgwYz/Kvw
 5GDi/TvqDO6+/oNhQuXe3nKgozyBw=
X-Received: by 2002:a05:7300:434b:b0:2da:1874:f3bd with SMTP id
 5a478bee46e88-2f54fa52a90mr515732eec.16.1778021310621; 
 Tue, 05 May 2026 15:48:30 -0700 (PDT)
X-Received: by 2002:a05:7300:434b:b0:2da:1874:f3bd with SMTP id
 5a478bee46e88-2f54fa52a90mr515720eec.16.1778021309956; 
 Tue, 05 May 2026 15:48:29 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56d4cf2fdsm898953eec.8.2026.05.05.15.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:48:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 1/6] target/xtensa/core: register types using type_init
Date: Tue,  5 May 2026 15:48:21 -0700
Message-ID: <20260505224826.2698753-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIyMiBTYWx0ZWRfX5J/oDmpNLa4Y
 UMKHnOOsh5hzqhXPTvFa7HWzypZbOHwzKWVJZ7+9T1EmlAzY5WHzM6heF+rsfbzdgaq6zxP60QQ
 Fy5Y/rlaeQzQ+7sZQ0aDUdD4mDtmiPA5i0OhydzfTWctNh2seCuFy7M+cWDF2O1WApSiRfcU77L
 Y31tIEI2Q7bSB7J09y1Fcya5rLkQoLTkPg+Sg+YA5N1UVcfBcUwI6B/ysiT1It9yUR37XkSvhKA
 RYhWVkh1JQRRkoVZNVPpWIKKRpzwg8d8jPSKE5BDUwFWRkXKfnNzogF7mQTJei5nr3klOOEj3FD
 g7Twv8GxS1LEUQEzvVMB4q3Z+lDjNFBlm0t1Q9Eehn8XYcnmNUsxJe2rJs+tha3kKgGVQxmdC24
 4xE+meRIRFvyiRMg9lUC/kXRtFRDiW4x7ClPQ35Pq874340rTFpQgBgGaD2X2+2iP/JYsSfVmBB
 ozMe+2bsc25+kklZKDA==
X-Proofpoint-GUID: ya0yOFljRTHmD0k4pUD6Uq3ShNF3EMzk
X-Authority-Analysis: v=2.4 cv=FpA1OWrq c=1 sm=1 tr=0 ts=69fa73bf cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=W37sF3GUcAVBL6lWIEgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ya0yOFljRTHmD0k4pUD6Uq3ShNF3EMzk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050222
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


