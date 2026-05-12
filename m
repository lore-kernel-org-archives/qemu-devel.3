Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1431CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMoct-00084W-8C; Tue, 12 May 2026 11:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMocr-00083v-G8
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:02:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMocp-0000Sc-PR
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:02:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CDgIJN680110
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1dUHUq2pSY7R6GNpMijZrY/mundsQGHsq4YZCZ/UTds=; b=Bky8mI4jllJSL+Iu
 I0GitnDpr8U3lQR+rm8mTGsk4FJUUKfuYyWqtryJvtsYV4CXmWOjKc66/A09ww9q
 jFJiqN3s+HdjA5nzgszzEyr6Nd3MP93DfXT4BmI0TGS7lN2H3YbmZWZv2U0hp1uS
 1JKp4cQ/wPcTnhZdSLNVVboH7jVREB9MvRF9jdJHhtQqVEpCTGCfaBlGhSsKDjR8
 IPBqRWW7z2wWTHS8zkPWagAd6hxH4LnLCShqF7qFkEnL2XPpg5vOAYYs0cPCdedp
 cTJIjYXKfaf/ZrEGGxyRqPFArsjl1R/KVwg8pQYm6hHwMiUnKoJD/8hr9Iom8/bm
 71sqCQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e45avgb2a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:02:22 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ef37c3f773so6746910eec.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778598141; x=1779202941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1dUHUq2pSY7R6GNpMijZrY/mundsQGHsq4YZCZ/UTds=;
 b=aZ1Ge8DKLF8ttTPV6y8e3bvMjn/ChnUcZfvJpBR1GnTssgMzWmEq+zxku04LQ6fAN3
 osJjFWH+dHcdl/68yx7zcAWdTrJRXu23nQevatqTi0VEhotAQBMyjA9wQCHx9IDQQPG8
 wzP1NrgZEmHyWOtXb2MyY48f3p7Hyckehoi4yDzsf9zuoNXCSKmxvstbwHlUsucOTmsD
 EuuT/xqy2uyuTCRyAjhSyHy6SLrLU2FCcSmlswBlW1NHnrw/G9f4ddhxHMOa0/7aqWGL
 uJ2j7Z42jdCIkm1JcDYUIIngtjoWCTQ3lna3vyYAQAR3tEUWDZUegOU9+06o4glifR7U
 gieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778598141; x=1779202941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1dUHUq2pSY7R6GNpMijZrY/mundsQGHsq4YZCZ/UTds=;
 b=Ofzhb3HMzT3RMBVFZ68XzaDP2bptxLIFmM5uWFeiI26jslL1EwVVtGYLvt01LYuSAe
 wKFRrE7JJKAA25Wvwt/8N+uGzbxyiiH3lA2cuEW0WMp7hS+CWmu9ALzXivDZbJbbO7yJ
 lfXUyQuSLZEuKdkg78+8IRarWG7IHg0M5dHHcupCusPpfoTLdIEmTSd5S+TN6YgwKpfo
 NEEE2muIrvai0UOpmbC9cgUXenEv7rDFYzAJ818wD0Z6dlEDo/B/EkZ7gDTQbQXSLjWa
 AzwVp8ALbn9eZqGy9Z58CgSV03YUzKncS/KY7hfma5WUlGGYHpy2J5PYWz5Z5/OYFljB
 4T0Q==
X-Gm-Message-State: AOJu0YzlaWlcvFom+44XZxeK0Lp4dSmgJ/udLEn6qwd+1RJWCTaVYxLA
 19redViw+ipS3mIt9lV6CRaVgBDR3Yf1DZ35nCqFTxggv4ElBBODX3MdSdt5kAVR/wQ4BeK+pEW
 9J4aJYBWP9wTNp5kytce16Hx2Z6+ruwlFV0ZiWJTB3o2I6sm0ZJa07DhTcQ==
X-Gm-Gg: Acq92OF9LGH2fZgoHriX7RkONWsSp5CMeiwFxoYjh0R7kLNhQPdnmJqyfvX7gJbzrk0
 R7fIBa78NNfKIVeJXTt4OxrON2Gst3ovErOFrI11VxVZaewVllDIQhrCITXfxJs15Odbym5pBcF
 YqGDPtv/gJBzjFGU8HiUbQt87UnMB20CB1WJn1zXj2+e3hZTk8gWeuYcRirZTvOtgYWByRt4fme
 +wZ+T/rM3IfATxYRaTmMkJQpwRtCwdVONMVqJBlksyna0PxgQ+DCMoExu52YqRspth8MgXydeEA
 bImV7HMdQKjaRD+qj913vz6TMLbK1eBqEP35w1AC1kcF7N3P822fEIcHRw/Y0lMcGU+w3Fntc3t
 JdUQ65p/7br77e+gv4s4aMzlMQ0n9SqUUHt78PY5/s7K3X3aO9Q==
X-Received: by 2002:a05:7300:e421:b0:2ed:e14:42e6 with SMTP id
 5a478bee46e88-2ffd87c2ffamr1765675eec.31.1778598140577; 
 Tue, 12 May 2026 08:02:20 -0700 (PDT)
X-Received: by 2002:a05:7300:e421:b0:2ed:e14:42e6 with SMTP id
 5a478bee46e88-2ffd87c2ffamr1765553eec.31.1778598139697; 
 Tue, 12 May 2026 08:02:19 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8862d429asm18270335eec.12.2026.05.12.08.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 08:02:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 1/5] qom/object: register OBJECT and INTERFACE QOM types
 before main
Date: Tue, 12 May 2026 08:02:04 -0700
Message-ID: <20260512150208.1167711-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6LZogcWFNEesGZdstx8ZEvAqsjFFklVX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE1NyBTYWx0ZWRfXxUpZJl1XkEtf
 9yN6j/4bzNqUX69xzCL0rRUggDQYJPp0klM8nOFptWl9+KmY+fxlboJCKK0iG1E1hEu5/Y4A6M9
 X1E1L0vxn/+aRzN1W0c3V+ZjJoljJBldUznUYd/U4zkAgM62TiBXRA1XdvD5GQwVezM8xcyfKgn
 lR3dLh7xpvU1f6WENAfsp8ED/64GilICTSAQId3akDvrsEqwjxYBjdAwqA+2jbI+ziqU/TpgR+j
 DicaCXPxJ5cnSwxefgUdWa3JqoJrUBoZ31mJ1JrDT+/P7Bfp6kkBoDM3KEYIumnBCJiw8alyMGM
 BYPvGCj5lhCaLeigajpwqJHHDZWlAUwgXpkGI/8H+WQK7rjxcIUUnSN1anTS84gTKyyEDh6xNR3
 h+xo0vpkHAV1/7a3REvJ5rD9kKec1Iiwt5vEsPqiKE+EUMIv/++oNUUTWDF6Lw8t3GoCXcra5z0
 5ZPclZwrZM0WCV9nfYQ==
X-Authority-Analysis: v=2.4 cv=bOwm5v+Z c=1 sm=1 tr=0 ts=6a0340fe cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=W37sF3GUcAVBL6lWIEgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 6LZogcWFNEesGZdstx8ZEvAqsjFFklVX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120157
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


