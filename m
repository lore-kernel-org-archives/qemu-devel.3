Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6714BCA5FB3
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBjdd-0007R5-NT; Tue, 29 Sep 2026 22:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdV-0007PH-NH
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdT-00033v-7p
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:32 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNQHnn484429
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MTkxa+UQyrf
 o7nDKzdRO/u9CdA6JPxquBJDa9+sF+SI=; b=Q7vSwqeTpfd9ERQ9JbwrQvU6aTe
 Ul1CBPJGVY7jaixRHbwmAhA4tJdd2SoO0P/dRtcO8ab25t5FQ6VAt02TPMIedezP
 rWDoPlZGD08IgPYeLp8SzgrpVcTyQLpi+JbGweHvGNYLOCcwDOLSADbJJDjhdvRa
 xGiLPIwymMvQxdN8gkOY49s3JaI6/8LHPi7bPDojx97Lv674TMtNIdx8rZPEnhqv
 mCOMHcZ8m6YB6OyRoewItiPI8xmBdxdN8LzCHgn/WI5fze/jqHEP38x68jGphi3d
 tpvZe7hnGB4nv+XaZd0407kWVrBkFn2jH8h/YpbXde+sKs56XohVjfkRmWQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0dsx32bb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34344599f01so3801679eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733688; x=1791338488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MTkxa+UQyrfo7nDKzdRO/u9CdA6JPxquBJDa9+sF+SI=;
 b=fNAOrXohvwFXMIhzZQfVgVPdGDpa+jCirx40wfr91tbNGgiZLsy2bHcF6B6Jjga3Ji
 4yQxD3xJ0ioQWfNENNS5NpsNmyGPEd1oDH+L3SY470M7Gi8SrCxM43CoihZ0wkoBumet
 OMOMI+H1BAk0cO+Z+LjYLuHClyrnnu9NJTId2gNOnArgqygUNBn7XC97gZ6K9awFZlNS
 Mlk+58+5tQIz7o015qHbQI433X8Rxj2kH0z2krDd1ALyWn86e8UhTGQdWwEogvMdOmw3
 48VmQJUx7XjvAMhg3QIggWS/kVK4Pxkcrf3eou6qTRorDRZU3UF/9dCHFw2TVDr21CRW
 2dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733688; x=1791338488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MTkxa+UQyrfo7nDKzdRO/u9CdA6JPxquBJDa9+sF+SI=;
 b=JlUELKEmuM63GRpyVoa75TwTDXLTHnOtLpnkmvwowf9YsYTfzeVdYSFhT3SeRqoZC1
 B7eKtwIVl6EkSVOus0ShV3J8xW8yJcVJh3OQEYqdlJ1FZHRxtXcMtUTg3AfnVkeu8vRc
 WUlyraBRZEUyQhHZK1hNwBr4OnJSjdhC7AvolXOwiAiglp5ZeUyVUFRz8GmVLk1sFxr/
 +9LHPZJZlo5LqDtPK0KlrvjLoKBVQ3gfOvvewR6Uy5h1BggjAN7vGTmpmS17mVj6qXRn
 oD2KUxa00srP4qjZAZk7GslBfqaUyuWaVnZ21wVyDdk/gFQxBFZA43Rc07d0S6ky35rj
 Do5A==
X-Gm-Message-State: AFq9FYJn13AFTduehSrsJx3EvcctyzJSTVmhgisrPpqW7Y7adIZU9BE7
 cwnw1gQ79GwYesM1cvovLQIGqQucIl+jfv+ege6d3/uwrtf69x+8wmcUXo0ZjOHXOrTsRRavUCw
 S58AZGtyiTz1xEJhkEaodGzzJGPgmbGdhyHX4cEZVZdFB7fTLX5XC/nVzTh/Iiaa8Vg==
X-Gm-Gg: AYBFou1w/vJueaz36Rfju4TIGo10UYcdEMHDr2ssTxrLv2wkHeo5Vkg4gfBvuvgNPqn
 +YNmskl6R0rtKeqq4ntidPwSSPchAa/rdAr7H4VJHcidJAtAAyTVj05cbnHdIftq10UfAWnml/x
 9rgO7Kbwftp6qdG6Hwe7TSSVaQ1DHUM9tR948Lx61eeMMNA/7xwHyxs2/mA2B8ThF49bHpo+AIa
 cH2RO2pFZraoTaNZIcQo8An5Wch3GT0v/x6RPdBZ+X7dEKUz4kZAGMVOtHgiwkxgu7BL6k2qXw/
 G+PZFaqcGMH3Jd0530InqnbRFTyrStT+ZsyHAMxKS3qUD5WVnQ5gNkp+NFD8crV3CiU12Q36J3Y
 mi5f9LtVaXc/w+42MML06agRqvvuBbbNwU9DXEZOYyAB0HEFmnp0NXy6Nls36
X-Received: by 2002:a05:7300:fc06:b0:34a:ab59:81ea with SMTP id
 5a478bee46e88-34cdd3a4c0emr109196eec.36.1790733688305; 
 Tue, 29 Sep 2026 19:01:28 -0700 (PDT)
X-Received: by 2002:a05:7300:fc06:b0:34a:ab59:81ea with SMTP id
 5a478bee46e88-34cdd3a4c0emr109164eec.36.1790733687467; 
 Tue, 29 Sep 2026 19:01:27 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:01:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 01/21] hw/arm/virt: make virt machines available for base
 arm targets only
Date: Wed, 30 Sep 2026 02:00:48 +0000
Message-ID: <20260930020108.217892-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfXw1P/qDuWjxUY
 2c0YFxYUJyXuXa4tJ9OU0VVXQ0sIzrTvJkMnx+aSIIi4bkuIm+FBahG8ynBpZZac/kj3yHv5TeA
 iRetlZJE4X11RCgxtWTr6e1AsLdYMbuevWDQ3Q1EbDNz52SKJScSjHnRi3jFbRYY+ub8pGe4Xhm
 PVmSUf2U9Y4lhVeVvisXa44zky87ZQGGkUQ78CJiGT2o1SWUM88betFd+B4pdGzwvBewcdVD1eC
 cuqSWauXLY80W8DPQNQDxyJto1rFG5p3Vn52PUBzJXAT5FH7Fqu3hgCjr2YyLNzMSuDo45nEni5
 LVGgrKtaBCAECDA2mOlanWG/mDvr9eNwbAayX9S2PicB12eOv7L8vHUf/JxvomtNwx1YMy5/rWX
 LWGnWyR9PDDz/ZoRAfCkt12qzvCSaCnwXrKr6zLi/LhRQQnChRQYcbWuwdsqXd2UAOq2tY83TdV
 hKJ776PY7bU5Ifcj6/Q==
X-Proofpoint-ORIG-GUID: ZpLbqDXcBdWPyWpXC156JQ3rQU-xGe6h
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX0xaU3gWzl8bF
 CG76tCN0+gI78up9Z1rS+7nc7PUQoRzEJIkHF3U2FrTjnNTIudJk2eGhBKlW1AY0Z0YgMSbgW5P
 vnDPZ7JFN8fn6z1c3/Hk4p9ag2DnygA=
X-Proofpoint-GUID: ZpLbqDXcBdWPyWpXC156JQ3rQU-xGe6h
X-Authority-Analysis: v=2.4 cv=DqvDa2/+ c=1 sm=1 tr=0 ts=6abc6d79 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=1X7eBb8amEZuXxL9EGYA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300007
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

The virt machine type name is shared with other targets, which conflicts
in a multi-target binary.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/arm/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3eecf094bcc..c6cabd3a84a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -132,6 +132,7 @@ static void arm_virt_compat_default_set(MachineClass *mc)
         .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         .parent = TYPE_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+        .is_available = target_base_arm, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
@@ -4434,6 +4435,7 @@ static const TypeInfo virt_machine_info = {
          { TYPE_HOTPLUG_HANDLER },
          { }
     },
+    .is_available = target_base_arm,
 };
 
 static void machvirt_machine_init(void)
-- 
2.43.0


