Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5680ECD37AC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 00:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLVyb-0000bm-1N; Fri, 08 May 2026 20:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLVyN-0000TV-Aw
 for qemu-devel@nongnu.org; Fri, 08 May 2026 20:55:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLVyK-0005xd-Gn
 for qemu-devel@nongnu.org; Fri, 08 May 2026 20:55:15 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648GWNEj2335604
 for <qemu-devel@nongnu.org>; Sat, 9 May 2026 00:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=G57Nouu8Cwy
 vuWiaefu+uNrgJj5uC88qon/6Wi3OVsw=; b=GmflL7XpDW1EWgDfZe+aWMaLw0k
 uf1EBmwFk7s4o8fm773vHZhuiOOGzHSLeOB93w5u2K/Mzorvmdl88ddV3JYNXUtw
 m1l29nW3cr8s58jzXwCoMmcrh34obUwJ1A771M7CBs41u8N0bQt+P7/ayBQzfoK2
 V66sMDoeRAAwNlukhuDVRNdG1TEP/SU/unjhBTkZW3yiV+Dqafz2mW5v97fPf2hz
 MxKnuwoYKe0ObVzN+pm16NPoTTNHQTZ1hBzymD8cPxdJFaTOe+11tIc4mJjzk+Ac
 7OffZyvFFYe/Ex+3MBzWdDAgP2gyjS7h4pg2v9vgS7TkLoZJg26dnN3PfMA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1keh9bc5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 00:55:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2f525565b33so3407949eec.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 17:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778288109; x=1778892909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G57Nouu8CwyvuWiaefu+uNrgJj5uC88qon/6Wi3OVsw=;
 b=fl/GrP8KYLJCIcBdoiwbQxRVuy6xO/vJOJh8NNZMCLzFQZesee0FvjweTg2xqBTap3
 D1ainsuSsHtLg+PC9wtnrEIzI08ro0NNUFkCl9YTlbE9+S2gSd5qYYHmnVYjD9H758+B
 7rYmdItgSKXb/LYB4SO5ZobWcQBXVptUunPR1KW3X9CPoYXT+CPhWq2tLh4RmOcjyAKJ
 B3gFpqwORTPLA1hUPFOxwWtNAfL9v7SERbumCTbFSjQ9bbczkG3Q3bK4zGwcWYpEnfbY
 RYGWWJaaVebvWd3cW1aR86tu279KfpqRZWNoRrvITlqms3ER0jcAjbmiaBiKvl+OD7A0
 OOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778288109; x=1778892909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G57Nouu8CwyvuWiaefu+uNrgJj5uC88qon/6Wi3OVsw=;
 b=UnEI+bnqJAcL3njAqLSImJHDtjvYTr/HpEZ0V+0uJ4CqLpqngb5yUrwAqPQIDgZOAt
 y3SNY/W+nJZmo3WD10jAZgBwEYVkyzbBLnfvdeo6MgdsDXab5yegmimbQ1d6yDwzDJO3
 Nn/0JY93J4iPCYPejAmdu+2kI4BLM6VaDdkIROlVDIORyU7+wK0CNYBBhmwdqglW4QAR
 IpzjNkC+I2uIIFBGpIfkUERJhTXLsS+sW0x1srDYStoWHBkhS3lntS2kp5z72QV0yre0
 zJe9CrxGiW1U35+bouwLWhPn1+QeXFT3WyUswQwM/W+RmMha7114C5A0G9V8Ng/JjCL1
 aokw==
X-Gm-Message-State: AOJu0YwEWuGrKM6rtdYMVG/v9sNZwQb7xCkk7WYG8hqLWMk/h9vKDJgp
 WKJ/LMpzQiqa/3wsjXBwmzBvGH32SJBNrjJcT9bf3Ba3HmxWc07TVLjAtQGK0MmrTyxqVFITlbN
 G+H03b/MLakgtjpgI3W7uiNe+CSZUAQ9twLq7HvlCr/MCoRZguime7xn4fadzI8ULqCDB
X-Gm-Gg: Acq92OF7IcQIRaerw3tC7vGUYQxsVhtC2j3iGkKmPWKlxiMNujVk76QdV+5cB/Ns7Z3
 nRxaUFcTAKQNip+4mbC5ygo8yCcLG3/EE0sHp7nh4Bv0UOKcWcqJUHKQ9cLuWNEO+YxvIqF160h
 3/uh5bS+WNQmpwU8vwfDaLJI5biTTs3ZuABFNUGBBut3YsmstPMAtRk8xq3XymHd2EOXESVORH4
 oIbmNsXPRR/REoAfEpspRp7I+nAjAA7anrlcOIeFIXUGD+cy3a9GD5Zn4tt1wzI6VpBM/5QheGB
 6bHEtiE9poD4sJGV8fxeTQqnMPy50EcxJFBWGoIf2fsRB/LavAawEuI5Nf40nA5ZTQiFR3xjqa5
 9jSWeA2klLKwif8+U3MJhKQeECysyhVp5NbbFJEU+EVi4kBhf3P/E1WhtHUlnzXHeWJ/+cVMo1E
 6XTGoyaA==
X-Received: by 2002:a05:7301:1018:b0:2e2:27bb:a48c with SMTP id
 5a478bee46e88-2f54df9f289mr7325694eec.14.1778288109056; 
 Fri, 08 May 2026 17:55:09 -0700 (PDT)
X-Received: by 2002:a05:7301:1018:b0:2e2:27bb:a48c with SMTP id
 5a478bee46e88-2f54df9f289mr7325667eec.14.1778288108457; 
 Fri, 08 May 2026 17:55:08 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888c3b301sm5352610eec.23.2026.05.08.17.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 17:55:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v5 1/6] qom/object: register OBJECT and INTERFACE QOM types
 before main
Date: Fri,  8 May 2026 17:54:48 -0700
Message-ID: <20260509005453.3984184-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CJIamxrD c=1 sm=1 tr=0 ts=69fe85ee cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=VDdTCajPACCFXhBZtZ0A:9 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: AXAmRTR3BIBAZEdbiYq8HW-0tBZSYkJl
X-Proofpoint-ORIG-GUID: AXAmRTR3BIBAZEdbiYq8HW-0tBZSYkJl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAwNiBTYWx0ZWRfX6ql5z2GJT74e
 F9L92ltxtZkUZJJ+/W3saXGlr2NXMQ1JLnQFJ/p8zQIiLbQsaLjiFxAFwYSc7tkzwnsEq+RaQPi
 5QXY3piuOqCAYZ8f+lVzcMs7qpC3g2iHRksPJzC0P9KWb0GqlUL41TQnbFALXvfq/0XAgErx5nN
 cvL2hz5riHOXajH8VF9E6/OgBw0DX9/whKNsE+WAEcnWeCfYobuqnsjfbjRA0Py8V3aziVf9xcy
 fKU53hIEJkcPr/R1tRcIJQp6AbsZmyH5hBt8LYabokEA2tfTULks+LQ9G0FshXRfbueViJNqWsZ
 OeASvM3gij9z9MBhbKLuuF9dI0aD26t9Tq3Qclun8i829GzEAj7UZpZzHqq5XWinEoezsdjo0Zg
 FkaER9/Eu0NxWkcy9qrwrP5zM6sfu56OSbk7TDmQ7JvFTihEnxemoOgIU2MdxK0ep4Kbk4GUvZl
 EA77sh8xWbEge/FW+Pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605090006
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

Those types are special, as they are the base of all other QOM types. In
next commit, we'll introduce an extra step in module initialization for
target-info-* types.

However, those types depend on TYPE_OBJECT, which is only registered
at MODULE_INIT_QOM step.

To avoid having to introduce another step, and modify all code calling
module_call_init(MODULE_INIT_QOM), we simply register those base types
directly in the static constructor, before anything else.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 qom/object.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index f981e270440..a5d268d0722 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2839,7 +2839,7 @@ static void object_class_init(ObjectClass *klass, const void *data)
                                   NULL);
 }
 
-static void register_types(void)
+static void __attribute__((constructor)) register_types(void)
 {
     static const TypeInfo interface_info = {
         .name = TYPE_INTERFACE,
@@ -2857,5 +2857,3 @@ static void register_types(void)
     type_interface = type_register_internal(&interface_info);
     type_register_internal(&object_info);
 }
-
-type_init(register_types)
-- 
2.43.0


