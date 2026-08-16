Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB64C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvc8I-0000fn-6Q; Sun, 16 Aug 2026 10:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc8G-0000fa-Kk
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:46:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc8E-0000eB-V4
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:46:40 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkqSL3448447
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eS7FJd0/KrECC4g3ko1OcyrpwaFR6JN+bKkTPyN7QGs=; b=Et7mgn5qNLD7IUbb
 dH1/V2It5I0vVeCFqARigOLbRA4rMQHEATUyRpeTJ5nhnOOH4jp648NCRA84qQIN
 YyPr0UsE6TMCpFnNlvoY2KKlxWBAmBPLqA8H/6aNCRieE+dXP3KLdLXz3YUjpMdE
 jVxgcniwWPZFFq80QPGqCizqe9vEyRryIEKoEifNJUAElmibSxONH9XW0t7CVM/V
 eWWy0GGBLFDce2X73IPsv9xACD/s/DUPGtbsUPfEAdxDUQ8COYKTlxvB2tCKjkFx
 zBHRgDy2KakfR8eHQ0E/TsCOD95b1I1jJNIqK7XxfYCufE3ORKYCFD5saw8mwH3c
 MSuiqA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghk3mp4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:46:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936d067836eso255755085a.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891597; x=1787496397; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eS7FJd0/KrECC4g3ko1OcyrpwaFR6JN+bKkTPyN7QGs=;
 b=QHb2aLEApbPQaj9pN3iTyySRfZWSYz1kaMfjK8vflh4KGOBSF8HwiF95BsI4Erzshv
 jbVjZBdhhs2L4lgLtTtwFp3ojBAXaNY9yKPxFPFOopsFE9KYiQ03c9sWAC/zKK3+5vSS
 afY+80CAPH2jvr+Y4fckBmzQCPvnfrkJgYs3g4K0LoIc2gRjneQr9UfGPkIW9Pv5sPCP
 Dz40clJC0Aa9bcvA40OZlqMqI5/9NVtpxOHfrj6DCcTAT6aEIf0ur+smDijYxaG57Xto
 XMy6BH1GF2Z2YF+n6/KR9hQn5/0b2itU3+V3cwUmeXl8VpsJ0Tuymmjg0E/N5YjBZ2Av
 L4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891597; x=1787496397;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eS7FJd0/KrECC4g3ko1OcyrpwaFR6JN+bKkTPyN7QGs=;
 b=WiELp1LZZR+9ZxP/pKN4kBARu7lEUKTmyGCWWko1SqmfiQVF5AyKhpa9D5PA893G8T
 I37ArXu2m8MeUx91bWrAl24hk0Iv9iqXD4x3Y38/6ivwlnRlnkCOWqF/NEmi8R/RPEZ9
 84MrrVgauqteLy70VmTD7D8AE4ptuYnwpK8kQlw+7YtmpMk1LB7ZzUdJSwCIsWu5kPRO
 wO8zFPlfJZIoCs8NNHEwlDQSwgRO+cjhgmwXVFuU5El1BQot2E9Q3qBHEkjeVdeySiiw
 yG+nx0eFCr5ONQXyqU2ZAHCCBQQNwvxST51uuuTeQ+21aw23fcbia4f+mDLZjlV2mjHS
 5ikg==
X-Gm-Message-State: AOJu0YzftSsUJfYlFbfqsyCmSltjt8v1z5g3Ok+GmLRe2uY5gGZ2BRyb
 etPF6EkUfRoAC6GjXuT58OF6AuH+4pRglPpO4Xie5Vjdw4zFsZJezjYCNd3nwqzkfnMVvw8Wlbb
 ZM+6oQGGzTNqiY+XDeh5/DmuuXwHqKF51MUVrX5tiXE/JCnFRHNgfw01k6TsHuCx0YA==
X-Gm-Gg: AR+sD13LxsN3xg2DBZ8XBF6jnAbd8SQQ+GTQpRdpc3k1aohzlRjdHCyBUfCXTJMnEDx
 t/ZtO+0sBliydkWt4s7pkspjM9x8Rc6/FnxfA+z7LL23HzQ8s1BGgOIu2egVIEh6xI3CN+ojvkY
 a6tzW9iA4dePvlgpkqWJK+fYKf/30q0tUKFg+GCyfeH5EEZN8yPuQxCz0EKLjYKBBI5RW/GEo1s
 mL+cgYYDhhuIZjMpbzcbMVR1NOHPeLYIKfJ6+P8Wf/0fvBR3GRoqGOpvLay9N4paEJqzzDfN613
 rncPyXjCVBGgRuI2zCgoGFNDSyIjXgOgxavI/K1qECp7DJkQwFhy3DS6NqddFGKDc+ivJDTaPnZ
 ACeOls1djwOQOqUuFE25ht77Q05fhTtNbOq42LIH5GQ==
X-Received: by 2002:a05:620a:408c:b0:933:ada:c3b2 with SMTP id
 af79cd13be357-936d2382749mr2009148085a.34.1786891597105; 
 Sun, 16 Aug 2026 07:46:37 -0700 (PDT)
X-Received: by 2002:a05:620a:408c:b0:933:ada:c3b2 with SMTP id
 af79cd13be357-936d2382749mr2009142885a.34.1786891596488; 
 Sun, 16 Aug 2026 07:46:36 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48294e70f8asm15871664f8f.11.2026.08.16.07.46.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:46:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/56] hw/intc/apic: Use qdev_is_realized()
Date: Sun, 16 Aug 2026 16:45:04 +0200
Message-ID: <20260816144556.69009-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfXxdMka1zYFqPW
 qBJdEDklBSLy6Qh9QeVaOxg60uaDAO7HGYzPCnO1FZdG8lZezSnmr8LZwbbPzdBmNpWmcpHox+/
 WC85lY/Ku8QQmcjW9qbMoyhvAsxK+bo=
X-Proofpoint-GUID: AaNUQeyumpKvX68ArsvNrkMefH3O0VEN
X-Authority-Analysis: v=2.4 cv=f+14wuyM c=1 sm=1 tr=0 ts=6a81cd4d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=uRxLgUfnyXHAhkBXUOAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX2Dx/KYxeUXyI
 f49xQ7FxxSzSLKiBD05GItiV8gOBVMVHV1AD/M414cEgyhJ9okCyHcqLMXy/apJI06z5YC45kwB
 5awf9cnd/nvqLMcwO6xBZKXJ0aZdlkqusAm5t7FLbByaN/kAcHutMAs+gUTrF91Qjw6mtAArEpI
 tFnX9yhw9AvTcNeHxJC0w73WDqt1VZmiqpoPU2O6EyJWUVd7lMvOpFJ6sAjrTuGzVKcS09JV5F8
 hH3HxnaMYjRWOdi98sQfKkKX7oB0dG+ciTbu1yv3Lo9+top/qekcEtVvKVGONXLugzuxZIHCQmW
 SrnRpMsU4dXQbIKFns6IeWHWvechHhBpkX327jxNDFz8V1i3qLd+6onF584joFR26miXJu/J+bv
 uM6fTgHmcVDPA+aXJX6Ff0Z7KaBq3n/j0Hy/NUIRzJeuYX1RwmQIgfSZuhYqZV3DL81aPFSnbIV
 QsYQ/K5jJDLA18LYeww==
X-Proofpoint-ORIG-GUID: AaNUQeyumpKvX68ArsvNrkMefH3O0VEN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

DeviceState fields should be accessed through qdev helpers rather than
directly. Use qdev_is_realized() instead of reading
DeviceState::realized directly.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260721-qdev-v3-4-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/intc/apic_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 49c03a5bcee..0f0f37d4573 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -424,7 +424,7 @@ static void apic_common_set_id(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     uint32_t value;
 
-    if (dev->realized) {
+    if (qdev_is_realized(dev)) {
         qdev_prop_set_after_realize(dev, name, errp);
         return;
     }
-- 
2.53.0


