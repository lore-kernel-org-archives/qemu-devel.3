Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75408CD4F41
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 19:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNc8p-00017y-5g; Thu, 14 May 2026 15:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNc8n-00017G-PG
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:54:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNc8k-00025S-CN
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:54:41 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EIpPBG1847950
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ORt4ca0QIu9dtPwuxN3bwOkWfYxKslP1+sATyTxjCXQ=; b=ArZT5CRJyeioutyt
 n4/YlSIJTWVTrdnVOUPhjeeWNwyrny/eReRuF3u+u+G5ZCOsRTrRkwwuVa+SHR8R
 rXFGojMPyOX5CPrk6NqM3Oh+9jYj0pil5RrfUpVwhKN81gZJHGcRVKK7DdCisjIP
 mu+6Db46j36p/F2yBTqmF9+OWQz97x0tBDjRdpNtbOtgaT4149DvG9geLwtTyjUt
 Lw3+y05pw0NFthBzENmSy6z9hxDXiQ1Nf7msMKJcKW825kfqeFmvxKx44Zbw/MhC
 ab0wmu1o2sUrR2mQuB5tr7g3/nXC4OhG1iumOiTn/M3zsYK+b3wG9XIl+viu2bsn
 o4Mpmg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1t068f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:54:37 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2eebb099efbso5375465eec.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 12:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778788476; x=1779393276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ORt4ca0QIu9dtPwuxN3bwOkWfYxKslP1+sATyTxjCXQ=;
 b=PsvD4EqSB0IKgLRa+NDT/wr74aE4YGxyqjl0o1A5nt6sduz0Gj3FPP0lBLqzqw8XcM
 Ijwn/0w/5e8esFWi99CLVdpY/2c2jzO1Bk9Bj9p8zzGAMrvIT9MU++LTkynlpsSo3318
 Ks+YwQJEn2l8eFCapZFwcgFFaZ+1NSYsDArrMhoaBJivI1tCTK9n3uwA51dIFKf+UCLD
 HiCVBEaCQnyfbGn7DkxsIqT4eP4zbKDNoHx0COR1QvSnEk7EPEuPb7QuVdEX6Z6hPtxd
 qrZi2k5PLZezBaJzve33a5NdUla+9DW2UqsACQn8gXxQAQxHYB67woDE+MdkcPqxhYQs
 elMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778788476; x=1779393276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ORt4ca0QIu9dtPwuxN3bwOkWfYxKslP1+sATyTxjCXQ=;
 b=p+AaQXlPVUXu0UNThxqjPsXbjImmo1Xfye9YoP2roFphjh7OAUuOQTHgtyLvOxpUWe
 6dj4ep6U5+xFktoQVD0XesngG1uOq9661Y8/MNUQL7KQKBgmzGL+PWc1q6VOukcodnDk
 3IAx6jLS216jvcuyAnwg57N/czigcFL6Y+U101BsVnignYpSNOqou6/BCVEuciCoOp3d
 yPqp5Li1d6+2Gi0BRy4AjlOGvhT2eKgclSf9pRZuBH8GYc92GoDTQ54Yr+BW6uJuj9nb
 rhetRMuv9F+B5Y4Ikcs9Et2m1bmrlRL9nWNE4hM5j1VuCPQXsH0sH6c6zkoS3W9Wp+1Q
 mosQ==
X-Gm-Message-State: AOJu0YxIcOTh4ixob0KXUQooj+U4UfcOzPsZyPTY5jf12GvJaIDsGtz1
 qw9lty1nWnG7MJdTXuBFozM2ccQHg9wN4jdymAwLNSbpQ1wWl2ysMDkWV4VeF2LeWlaD96+oMpV
 3MZMAjRd6o51ASUCF2lGR4P7HjJ2XYvyC0VCNUtP+7UrPxfUQ6LkmBv4hkTzAkF8kU667
X-Gm-Gg: Acq92OE5v+gMG50TMJIFj0y4sMNNIpI1e+9sFJQfhwbjA2TmpJyzW0EyIMd/1kRGXUr
 Tb0awuLZu0G3OtMwfDZCFWT0R2xOCOk9F6F2v6OX/v3N/T4BRTEOq/vc6A2YKRxu5vDVReCGouq
 9yC+VlCTqQjqrIMOpEUIAT38jdgsk0bJ9zJB/Fup9FpRZD/dtTvGTjtCNYmBS2VNjZ+5g7Pva+k
 LrJN4TSwN9Nslfx1hdoYkFz1jWsDdYK/Jntsy5Avwm0narabCozjCXkNAUAqX8luzrO+MQ5XJYg
 6V7LF7MoSABi64+PAXl3EsPOlte+nObczYZn4VUm7dqsH1zUKVgkY4cV1QHlUYjL3CjzL9hoCy1
 MrGWa2DCuULRyIYqgzp0mK5ekLP63QPWJk2eRd/WzdW6oRmZFBCUkMkyFxOou69/F53ZAryXGQi
 UAnNsqwqHBfPXdtwj5
X-Received: by 2002:a05:7301:6006:b0:2f5:301f:64b4 with SMTP id
 5a478bee46e88-303982b11afmr543703eec.12.1778788476025; 
 Thu, 14 May 2026 12:54:36 -0700 (PDT)
X-Received: by 2002:a05:7301:6006:b0:2f5:301f:64b4 with SMTP id
 5a478bee46e88-303982b11afmr543680eec.12.1778788475470; 
 Thu, 14 May 2026 12:54:35 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bcc5asm4180636eec.22.2026.05.14.12.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 12:54:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/5] qom/object: register OBJECT and INTERFACE QOM types before
 main
Date: Thu, 14 May 2026 12:54:23 -0700
Message-ID: <20260514195427.1706609-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514195427.1706609-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260514195427.1706609-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=D7Z37PRj c=1 sm=1 tr=0 ts=6a06287d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=TGpnWNUbWJQoO7jwSJQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE5NyBTYWx0ZWRfX1WugZiDAVUnK
 a5V87n9N8zQvZ/k4AGfYIr75S7dYpLfwWfUf+t2qKO9f0pJS4Qx+h0Hgo0RgeSQe2tAVIWUx6g5
 +oUUnixXmcEYBIfkeuGDRci+7iA0Xd/4WGmIEIqxLS3ihMct60GglaMfj8JoXqmApFGb23JqAVq
 sHxYrNgvADR+W6ueobxdsVDlKR7lNVyOA21qY446M63PfAXlAJlYWq/dvjOfcw90Ocr9pMZgAJz
 DF9psvxRuETAVTjn75HgBuH8khYTDZjevCRDGiGFCOTJ5TCorPCDuDFr9eUPIhtaacuslF+ndww
 cPIquazRr4cRHd3iBQ4/ij7XB9JQ+88tN+PSEihakrZ6ZKVHShuV/BXuKghtrvnpwLYyGWxSp3j
 44QytGF18UNmh7gz4UdxvAAVWMT/4u7s+HU1x1MT1fTpC1yiLUWccEx1n09VMW/uY5oryU1rFbD
 Qs5Jc/1SPz3j/S9cAyg==
X-Proofpoint-ORIG-GUID: zsFwt8hpw0cDU9XbhOysPWgY9tIccRch
X-Proofpoint-GUID: zsFwt8hpw0cDU9XbhOysPWgY9tIccRch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605140197
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

Those types are special, as they are the base of all other QOM types. In
next commit, we'll introduce an extra step in module initialization for
target-info-* types.

However, those types depend on TYPE_OBJECT, which is only registered
at MODULE_INIT_QOM step.

To avoid having to introduce another step, and modify all code calling
module_call_init(MODULE_INIT_QOM), we simply register those base types
directly in the static constructor, before anything else.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260514172303.1484273-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 qom/object.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 59fd79738d2..b82b65a3a18 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2844,7 +2844,7 @@ static void object_class_init(ObjectClass *klass, const void *data)
                                   NULL);
 }
 
-static void register_types(void)
+static void __attribute__((constructor)) register_types(void)
 {
     static const TypeInfo interface_info = {
         .name = TYPE_INTERFACE,
@@ -2862,5 +2862,3 @@ static void register_types(void)
     type_interface = type_register_internal(&interface_info);
     type_register_internal(&object_info);
 }
-
-type_init(register_types)
-- 
2.43.0


