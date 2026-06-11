Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F5FCD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXzR-00083C-As; Thu, 11 Jun 2026 01:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzN-000824-Ic
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:30:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzL-0000yu-VY
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:30:01 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GSk93835182
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=; b=Svr9ydiPxjnFtFrj
 YJcmyOrPnlcLrHeewAt0mK0+g2w4ZWKqMA3BdPgtCtWYuOTRQC2npG7MAotWjwRp
 NKSDsp4RinW12eKe33fpKzjlDv2rY3kBrCj//gLqipEriVMXUPTGR0nyaq5scvu3
 ozkLObGOuUGXOsehnSOHdLwwQl5Cf6cMX2Hp3zI1bLW4sk9EDUjL/P9pYRe3F+Q+
 HRMhqx+IJAVz7h+50we0U1WvAnKz8uqkbzBq1IEmpDodruVbhBLWkL/tzPHRSKIE
 KxiDHy3RZ07fQrjXar/+la1O7Y6wVYzHSefrHPSHGvR83dPnrvQMJHd4nTRuhSMd
 J3janA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6ths7f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:48 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304d8613efbso8104035eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155788; x=1781760588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=;
 b=VvkXUpc2XFyfxhu+4CvbqYZeSrUjxZ2UtVc5i7M1Z2ZXGQvkMnKF2Gu/NXgVuEM5cR
 /EWmxgIbRt+U55JluKEK+vU9YfldjEMzJNXNK0Xn6TYK3DuPNmY5f3hS1DKZCPbzGJRK
 5fe37zGGTnd6KOcSDBfVkUkkSzxOgIJy0V3jc/J3ErSOJAPoBmcTHgBF2YxBaOOtLO8Q
 OUQcUYTcf010s6mf3Efgnn4bgAGgz/NbGysdT7VJJbSs3Qh5n0Sd3MJ5D1LAKRXUuVQj
 IQ91bMjUfS3Eu7YojHn2OHJ3ixfb8+aPe2ZXTijWHJeHiG5T5S5t7C6DQ5POipW2/Aa0
 y4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155788; x=1781760588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=;
 b=cFmDh+o52bRjhCHAkKc/MwphaHRZ4bXDYy3sea0VRQ7F3affNpuv5uonrLJEH46Qwe
 y2h8D74S8590rxRl3DbnSzq82Qf/EJhNk2RRLlJanfqRweKBbqRpWAwQH5G2sqhCbakD
 AacFTbe8lUSOQRzBHwD4XM9GAaTSc1S+Hi0xZUMRnymyFlMWEpTR2I9gjNqbkuw9/u3T
 bY7QjlhL7o4YC79U6ca2d73EMrzxr9I17wawjayp74FvXOhUfRI39ijEkPREiZekuqF5
 ANAsBUyxKeWpRtiBZ3mVZBrFIQnSdOwlZHf0oUl+MXY5beYqI+WaWPk/Vm/TgtLwUvmX
 bsGA==
X-Gm-Message-State: AOJu0YwlEKCZUYzm+onXQYvpjCftMTCzNC2R8LVCvNCyfb2yQJRzGzGt
 faDe4x8x5v5wY49UZuqu7c9bjk+042kMQim+/tT+SWUyL3JIunSH530ipsYrTjYjEjBjS2yXE62
 rH0D+NGDxUqy9n2YBEf8IhQdZSYefkyC/tt+d5Qfg37rm8B6q5rwZMZ3tF5HRRsYKLw==
X-Gm-Gg: Acq92OEsAR4dn9R+TvdGV64IQyMvqmXY4oNu/+tHwcnLdNyzAvM0YdKMa4heAdA0qpC
 wwxyvWXCuIqoBuviZfN9zJ/5AN/Qt+2ONGnpCQnS8VW+ew0cx7Q/BzTFkZBNG7lVnOZYv5c2xG0
 2G2YhTQfAzbbYPknZb6XtVzu/sOKItQVip6+voLsmrdUhJgNV1rGNHKhMqfjUDwVPa17WCePTJY
 i1VRvUZj4UE6IBVGIjLMrcglwQNW4aTiSo4A4vrxQDPfkaMb5JTk4xz4BiHrMjmsG0vz3GPuL5J
 npuvpw0nM+KqY0Kak6zOQHgHLwjwdoBTslZQR3gruDxItLl78FifvKExPiw7EFLm56kLFJBSmaV
 GI+5QsIa8U5TccxD8oiknTQMwqqCxt0K2s0wDkb9L6vEH3PPawUdTv2yahQTrqDF1nNxp2FCLww
 BEEquo
X-Received: by 2002:a05:7300:7fac:b0:304:bce9:25fa with SMTP id
 5a478bee46e88-30804607632mr1190541eec.4.1781155787944; 
 Wed, 10 Jun 2026 22:29:47 -0700 (PDT)
X-Received: by 2002:a05:7300:7fac:b0:304:bce9:25fa with SMTP id
 5a478bee46e88-30804607632mr1190534eec.4.1781155787498; 
 Wed, 10 Jun 2026 22:29:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com
Subject: [PATCH v8] target/hexagon: Add representation to count cycles
Date: Wed, 10 Jun 2026 22:28:50 -0700
Message-Id: <20260611052857.3911981-30-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfXxwdMV47jkwV9
 fJZo/QZtStbAbIqUQQaUXdhG/e6boMKvYpGrLMspNJZOd4YlUxEjMSsa8rwTKWGihRnWrzjjyKA
 yyrvbedfrfrJh3lMUPiaYgiNWevbYwB4pkaKGIBj2Dw/o07+Y9AK7CryI4MrN7KHPi+bHLQjbud
 zfh92ExHqoqrPyI4uw9d5elTr2CdRb2FbuY/1M+k4ZtPmixoJl2Vmoe3VkLLUuS90KxKf4WbTJ9
 346xqDJqp21aq9rWHPfYrXczsDYR76WlVejtgRN5w9aa0Io9kOeuYzM9YH7KJ7EvBvZUNE+qfBe
 k2gWIQFMzmU/XX9HAjhMz0STkp+BrJssx1JOPiO6eKEGtcKON3MDZooedTXC9lFSr837RcLExoS
 nggUZm2myR06v0DAo+52vewpOgBjDTIui4YBml0i+aFx6UuJbM7B4b46AE/0Ua5FpCysWHPnSeQ
 w4qnbsx6XtJAFs68vnA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfXw64ROp4r6NK4
 8+Rddk0bnGgE+hILo5KUoEfnCcR6LLobOrKVeAIRT+vsNcm8MXv5vkfOv5DGxnHO/cp9rrvfqWF
 zBhj+4IqJfdlxgMo9dPFoIzPOwtAgFA=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2a47cc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=gmA5YO3DfmenxuRff1QA:9
 a=tsLLKIjAKpJP5df9:21 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: nN1PdegPS0ckBZgVtFeV0BYY9QM_Fx-g
X-Proofpoint-GUID: nN1PdegPS0ckBZgVtFeV0BYY9QM_Fx-g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

QWRkIHRfY3ljbGVfY291bnQgdG8gQ1BVQXJjaFN0YXRlIGZvciB0cmFja2luZyBwcm9jZXNzb3IK
Y3ljbGUgY291bnRzIGluIHN5c3RlbSBlbXVsYXRpb24uCgpSZXZpZXdlZC1ieTogVGF5bG9yIFNp
bXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2Fp
biA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5o
IHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IDRiZWE5NTNhYzcz
Li4yNTQwNDU4YjM3MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFy
Z2V0L2hleGFnb24vY3B1LmgKQEAgLTExMCw2ICsxMTAsNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVB
cmNoU3RhdGUgewogCiAgICAgLyogVGhpcyBhbGlhcyBvZiBDUFVTdGF0ZS5jcHVfaW5kZXggaXMg
dXNlZCBieSBpbXBvcnRlZCBzb3VyY2VzOiAqLwogICAgIHVpbnQzMl90IHRocmVhZElkOworICAg
IHVpbnQ2NF90IHRfY3ljbGVfY291bnQ7CiAjZW5kaWYKICAgICB0YXJnZXRfdWxvbmcgbmV3X3Zh
bHVlX3VzcjsKIAotLSAKMi4zNC4xCgo=

