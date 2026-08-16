Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF410C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvc8X-0001c4-2W; Sun, 16 Aug 2026 10:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc8V-0001R8-Gd
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:46:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc8U-0000fD-3F
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:46:55 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlLpG3951389
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XikjnrTT90zrVsPEvEW/wZIr9/0JdX62eGxESnceHS0=; b=IjvbVK69mRrIw7iw
 bvK7c7MFdxANatZsorH1pNPPdlXtPQxhr+6ll0uC5o7q3iL89OLBLrRIa7+A5T8F
 lbXzinifmj5VY62gDEttulG3Rx/zXqHI6Vhvv97iTDYmIbGcDhJxSW+fT82BhRwk
 uJ5GxDUtMzZbsRuQV255v7hbtAsDIvtU1tdKasOypIGkaFIxDwtdYBggER3qP9Kg
 whzeFdY3efWx0B5l9AeYNj/n0zxBcgrZcjpinyL8aKCEtxBVXqV7/2PDbOYQJJ4T
 jH8BbVdFCUk7BNCiXUkIY4i/2BdU4RbXCN2k57R0wUCj4ZudNaldZnoGwRsTp7Y4
 o+T/kw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghnum83-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:46:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e820609d9so245034385a.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891612; x=1787496412; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XikjnrTT90zrVsPEvEW/wZIr9/0JdX62eGxESnceHS0=;
 b=PnU2QryMjlx71Dptuc8CL7D0JuPP43Xi80SQ4UJGpZ0rr3/O2KLyfcb+NaJBWQLbqy
 RIBqEA65dhbjdr6WIl6w1D/9f+AgxA/eY/dzM2oP3PXX4PawddmpJg94DA4ewkZScoqC
 /lohcwQaSSIPECnN7Z5Z7OsSguWSWT6zIranb7DoUd+vXqs3L5mngyNYiK2tBJJcGz0c
 qiLspCClDLr2pESWtkCF1LaudzX5l5y/k6F31LjBq9xACFnLPunTeUicmFHsc/ZH0+7N
 rqMAVai9XCPyAdt8GYDM2gKQL+JEdLIS/bv7jz21oH5crdEPVJvEA9xR2w8RCx4gnNM3
 +gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891612; x=1787496412;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XikjnrTT90zrVsPEvEW/wZIr9/0JdX62eGxESnceHS0=;
 b=RVx0qV9Bc9v38Rb1s6Dh4IgrRms2baYQEICE+9yYVP74dUpLx33Kc5wBelNS9XpVRj
 5UfsluaqSYT1D1gx82kQPx1o7JRi0FCRphcEAm4FI2/8frQcmt/VklMSwt6Pm0flbC11
 Qv5z+JZLRfaU8BwOE8Z9QvM4346sf+KZd3P/UjfqDAmk+sedkWASC6v890pVOLKuSiP5
 TnporYvYZuu48tVy3aliLjfjHpIk9Btf/pFVaDwGjOOXx9x26MoEraDmw1cGZDcZg+YV
 sSxSbcxpqG4AnI0WsusiOyFxmwAJ0QgQga6LTSox/+Jmyc5MysovybPAGwVw3Pvoa54z
 fT5w==
X-Gm-Message-State: AOJu0YwS44dnIJ9i8chAE161wFDQ6STFBzL3iRrqFve+OjYI3jfjcYkr
 bqmZNIiTQiQnMnuMBArKbB4Xh2JpMJ7OE24xd2gRDHyhF1t4D96N10EWkfECz0U22YVIYjsOco0
 kuc9vz1FUPnFHHHvd2Jvf8Q0cXUNjPwDEDQE7MYk3W2+70GbjpubEX+axtIvpABWRgQ==
X-Gm-Gg: AR+sD11Hvf7WmPL4OqzHhNH9Lq6GZ7hSodgnjdrhRs9IK0GFuN7C6R1N+1J0VrYqeS1
 Hjpihhy1z/SjeQQn7NhgwhpZIT9rCHn8dMREhKFkZIoFi3Glotr9xxU3QXW1TzpTn5h7FA7820N
 jt2sRWN6MdnbvMI8ZFgnW4F3NI/FPqqnJen5bNue3bvqtPOi+nxw6hEsYM5VSrf/TPk6oS1S9b5
 cGYlcJLxWbp8o0J9ecqaHTVS3v/ihlp/a6oBGdihHhTcwljzgear++4if0foqitc3FGinAZwsc0
 Svckvwe8ZQgDwvofVjcgjgkDtn3qFGWkcyzlUQPAXVBYElODBL1dxmHgLfDrKyMTko9gR5Us+MO
 TOL22UXzQpKrpgt6FN51ze1VJfkqg8JwNclwSor6siw==
X-Received: by 2002:a05:620a:8325:b0:92e:e376:cf97 with SMTP id
 af79cd13be357-936d23c6b7amr1697144985a.44.1786891612359; 
 Sun, 16 Aug 2026 07:46:52 -0700 (PDT)
X-Received: by 2002:a05:620a:8325:b0:92e:e376:cf97 with SMTP id
 af79cd13be357-936d23c6b7amr1697142585a.44.1786891611958; 
 Sun, 16 Aug 2026 07:46:51 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996128cffsm47237265e9.15.2026.08.16.07.46.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:46:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/56] hw/mem/pc-dimm: Use qdev_is_realized()
Date: Sun, 16 Aug 2026 16:45:06 +0200
Message-ID: <20260816144556.69009-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfXzsVV7vtarhYi
 1ZJqiSXOsAhm7Buv4GLGnj69WGrEH/RSD57W/iWNEAALZx7vP142vEQTFgMFCaZcME9Hbi1OwI2
 F5jUSJ/APbP/WyVv/14isI0GcLTuJ2o4FHAWnrrkoBkkssAn7ghLV7Qo8p+vYDIn0al3ZlJJkvf
 BlequqEe9MWma4O6isHqtw5o+ciHfYAZIttlqvT3Y1H56rzxskcZ2UxUAUfkyR+0a+uAeunkAWo
 c9MKPIkZ7q1IMLyOjTkMoJ2657w7f2RLjqOYDB5luLaqqbFqjZUGacK1C4xxddwCgnRKAI1DGqh
 LMQMiBs2BPwqK5gK3rsQRNd9dXtTY17BNJAgruGA1epfaFADT1HaA68CM4NwygmfrmyxnOEy5lV
 PNfL+Ej6Y7tV9dgRzFGCpTZJUswdKzec4216nmUrc+FB9VkOYiU+B6HqZauD0+Ih7gQxhZ7NSWh
 ChMi9n3Dhl3Gj3ry0fg==
X-Proofpoint-ORIG-GUID: K5inoFZueQ7aT8fLeDX-uetrEctzYNgR
X-Authority-Analysis: v=2.4 cv=QN5YgALL c=1 sm=1 tr=0 ts=6a81cd5d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=uRxLgUfnyXHAhkBXUOAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX+aQUKO37h/cD
 15b1AuMBKj6M8qnaLimCeKu6SXt/jMc0+///+NjTZQCMICnky6KlNp3VJCYKf7MoYwXhchYjBKy
 8EiqQvMTukw6VZgAmBxblP+v5CqkQ7o=
X-Proofpoint-GUID: K5inoFZueQ7aT8fLeDX-uetrEctzYNgR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
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
Message-ID: <20260721-qdev-v3-6-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/mem/pc-dimm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 3efe47f499a..68862926ee2 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -103,7 +103,7 @@ static int pc_dimm_slot2bitmap(Object *obj, void *opaque)
 
     if (object_dynamic_cast(obj, TYPE_PC_DIMM)) {
         DeviceState *dev = DEVICE(obj);
-        if (dev->realized) { /* count only realized DIMMs */
+        if (qdev_is_realized(dev)) { /* count only realized DIMMs */
             PCDIMMDevice *d = PC_DIMM(obj);
             set_bit(d->slot, bitmap);
         }
-- 
2.53.0


