Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4706C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIL-0004Lc-RW; Mon, 29 Jun 2026 09:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHM-0003dU-B3
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHK-0006FK-H2
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:03 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATEAo2579076
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X05v3GkLKVJ5oepV5+STkOz6Fp+VxO6RAfpTWbT6B70=; b=Lqy15T6mxBrM0ByZ
 gkZiTbTt4cnkZ8QnxybyWy1en0YgUUn2O3VM6MqSXd+gcADhKUBw6zq9biowXGYk
 /XJvvUw3fEOPBU1SNvoL7pxssOE99Zeg18QYlSkdTRN104lCdT9EnOs/CNIfbPAV
 86+WkZFdRu9FDKkgN1ACciilQp5Xuk5w6W0rA/brThl2S+CoOz0DkloDxdfxVbtL
 om/5kN2u5iemuKM11//uKDKzGiiOYH3d88RrliX1T2pextvC4X3vBIr9bRHndRDg
 ppYxdfig9/JHJLc9UeKasvYqpMjJBd4vwDaA7dupk/pwabS5hALHjVdkojwXdCgy
 W50VJw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7hksg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c8e14ebb2aso28194045ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740640; x=1783345440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X05v3GkLKVJ5oepV5+STkOz6Fp+VxO6RAfpTWbT6B70=;
 b=XlX3Hm8uXNIQt5tpV/6Nw7bauN4N47w9rX4+wVbc0Ymk0cSh1GXFHb+ABcG6P1prsK
 2cZehNVHLpAVgZ3HkBmhy/QR+66tAM0KdngJApZhPlX9hlNNyWrXn726ODTnPDchocCq
 phzv7+KTilQds3udAK82fEn/GYFnAKMOkPxJvR7OMf4DaVB3KohbHlLvzKKs6BRbMGth
 lWhB9h2Z0dEghubZhMCH8bykiZ6n2qMaEjkwOzSiENaxr0klg39MdQg9fuISu/Hw1v8W
 mMJDH9UmP4qMld+qqumqn2bOXh58NVArLej5dnqQv32IKTtswQBqAtjCgeLScDhqJSQR
 9RYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740640; x=1783345440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X05v3GkLKVJ5oepV5+STkOz6Fp+VxO6RAfpTWbT6B70=;
 b=pki3sus0/46VtPqNC8GHtTfj1/GIfDzRwguOKy48eaNpadKIqOi0y1pMH/skWjkC2m
 /1uBNQbL6WN8+PYAuqPcdWi1k/b0CMJ6FCiAZjCL2a7WnlDm6l/hl4KD0Txns07eF+99
 KGA3V6h+lLF7r+KMo2zHaAOKBBWSXYNPkpgf0xtPq+rjtjDQPbieQqGhkWwsDn50TcDj
 nnheOajUeCycb6zyqlrknkGX53k0R4HOvO/unqmSsusr1bJI1t0ea0As2X0LfAN6Y4my
 gFICCf+qFmDEgQe/gAqR10TrWL/wSqm1DOKtO1EUXkeggOcigVU7HJuHKKvc6MlAJ+T4
 N6lw==
X-Gm-Message-State: AOJu0Yz7nwckW/TsA2pf0b8vjLT8J9yI5yi/j5N0lfPAOgPCfB+bBDwE
 EcCn9wayjcfnN+C7Bpd7amZ+OWtBoGDCRXITZCzozXFYi2p+MBO2MwNSBTwRIjI7YBFHWDDUVIf
 0+hOMqShoGmqhZiEGOg3bbOLYPnH1EvRswMGYdNYQhYgNBIokJ5bktkMexggjWdCE6g==
X-Gm-Gg: AfdE7cnx9CSTt542jSfhHFAki/GcdnYTlFtOELINw3/SuL0F+bD4kkTKBS8jXBvVTxK
 WexpC7okoZol4z8UERr9LWdo5Xr2SWNrEV4F03rOCmh8zbQ442IAEHp5eQI9o2gDN23utSljGiV
 n00P1Byt5UpNVBcQkJy8qYxcx5TbJiH01ii13Eny9Mlzvw+glPJymTvuW0k5ZFpcMNCbhRii+wu
 hHW10WWz8Ksq/U4iioJlOxcSy3g8B3s4Z5pCtuZ7DzO+tM90k2LT4q11o0AivPbeBqP+2DY8SyD
 JKq3UgeOpRRnM6FMfZJmlDQcZKX/EQSYe2EnDeTxfKpbTNMiCvcCmh7tIBb8wFZOyMpAeNOFxL2
 XpJ/mnEKpOLUfrn52kdIdoVlMnL2Xx2OTF2Kmq7sPq/41vUwxVhTuYum/iEE=
X-Received: by 2002:a17:903:286:b0:2c8:5de:a84e with SMTP id
 d9443c01a7336-2c805deae4emr112667335ad.10.1782740640271; 
 Mon, 29 Jun 2026 06:44:00 -0700 (PDT)
X-Received: by 2002:a17:903:286:b0:2c8:5de:a84e with SMTP id
 d9443c01a7336-2c805deae4emr112667175ad.10.1782740639854; 
 Mon, 29 Jun 2026 06:43:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:43:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 51/77] target/hexagon: add simple cpu_exec_reset and
 pointer_wrap
Date: Mon, 29 Jun 2026 06:12:06 -0700
Message-Id: <20260629131232.2487780-52-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX1iDmT2QvSwEA
 rJE8LwqWn7FqlOxUALcriF8dXn5aNK0ILCSR0LzUISGGOKJ+KdXW9P3MCVvJv1eLtdSe+8m9YAi
 K8vm7VTNWTZsUva8Bty9reTAbO5yk3c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX6EZWCpgBckco
 9HrqiYMU64zm+2/+JcyaPDcM8CsNv4S7IVmU4gDKcBVnB3IkU80F6OMY53KUD7+hEXiqWrH/s4U
 zvan8c8JwAbvcQa4lisndWHYSARwhshk9IkOTDHOg3eEZ+WzTDdP/uzIHnZKXOAiRUmIeEyrWcL
 euNRLm0TWnGVjFfFtUuoBt6Rog63rnkrZkvcnDuLPd7CpnacnqtLZgTP8D3EL+delgypGmknTSy
 C9kopjh2rFMrScEgsOBUhGul4JVqclK6U5G/jb9V6RS9aYdFFPx/QeDm0lMWDeW0QauloUneyAC
 5P1bsmG7C2px56vKwHkG48alW6a/PwPMlczt7p7RYeOkh4AqfeS6n6CbIf+g3Au7qSJkb1yRvQF
 xXir4N8Ii5QUX9Ww7z3DKctFvINGC935gVuKxzUoP9fmrvVWP5TFDYQNG2nMYASYJKHhXhUvkjT
 Nv+aVkihSr7tcM+KwiA==
X-Proofpoint-ORIG-GUID: 9F_H1rfCHwZFFEXSPyciAph78gXDWUfN
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a4276a0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=O9wV_FzQyngHLK0UYg8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 9F_H1rfCHwZFFEXSPyciAph78gXDWUfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKU2lnbmVkLW9mZi1ieTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8g
PG1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgOCArKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXgg
MGQ2NTUxZGQ1YjYuLmVkZGU0YjFkYjg0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUu
YworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtNDk1LDYgKzQ5NSwxMiBAQCBzdGF0aWMg
Ym9vbCBoZXhhZ29uX2NwdV9leGVjX2ludGVycnVwdChDUFVTdGF0ZSAqY3MsIGludCBpbnRlcnJ1
cHRfcmVxdWVzdCkKICAgICByZXR1cm4gZmFsc2U7CiB9CiAKK3N0YXRpYyB2YWRkciBoZXhhZ29u
X3BvaW50ZXJfd3JhcChDUFVTdGF0ZSAqY3MsIGludCBtbXVfaWR4LAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHZhZGRyIHJlc3VsdCwgdmFkZHIgYmFzZSkKK3sKKyAgICByZXR1
cm4gcmVzdWx0OworfQorCiAjZW5kaWYKIAogc3RhdGljIGNvbnN0IFRDR0NQVU9wcyBoZXhhZ29u
X3RjZ19vcHMgPSB7CkBAIC01MDksNiArNTE1LDggQEAgc3RhdGljIGNvbnN0IFRDR0NQVU9wcyBo
ZXhhZ29uX3RjZ19vcHMgPSB7CiAgICAgLm1tdV9pbmRleCA9IGhleGFnb25fY3B1X21tdV9pbmRl
eCwKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogICAgIC5jcHVfZXhlY19pbnRlcnJ1cHQgPSBo
ZXhhZ29uX2NwdV9leGVjX2ludGVycnVwdCwKKyAgICAucG9pbnRlcl93cmFwID0gaGV4YWdvbl9w
b2ludGVyX3dyYXAsCisgICAgLmNwdV9leGVjX3Jlc2V0ID0gY3B1X3Jlc2V0LAogI2VuZGlmIC8q
ICFDT05GSUdfVVNFUl9PTkxZICovCiB9OwogCi0tIAoyLjM0LjEKCg==

