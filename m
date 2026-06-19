Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4B9CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiBw-00026Q-U1; Fri, 19 Jun 2026 19:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBv-00025c-GW
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBt-0001cj-Md
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:03 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYCb91286378
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=; b=fGsjYnvjJLt5rSoR
 30b3RWsvnOx1OaaN94cASWDrvjza7bzYVhROkr5oEWi7ljpBRrT5zydmyiV3omOc
 xwf9X/QyZUYZe1KbEWzbNneUT2UI4i+mUHRitIwnr/UJ4ZpsCJJ6Ywy9PsjqYUQl
 nk3mQxtc2iuQrW3nBc75ZiR6tGerUwwPuQ10Y1RkmcWK5FyHjZ3Cyeot8NnKJnh0
 wyc0M20Yrj51FdNsPMPtknlVgVMJdLS8d/q1owpdKvAO/jcpWKDiNtXHdMkw4u9W
 A8hPP+iW7XuwwhkHFw9Oor34FVkTuYWqspXc/y3SApINj1U3aUbW3PldQwwiHnpp
 FII12w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evy72k826-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:50 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so3761037eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 15:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781909990; x=1782514790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=;
 b=OYJuZMZYpx1w8qwbxHAdX5B8qkAOVYT75LRpxG0Uqy0xD5bDSiQFwEezk7ST9/rooT
 eR03k9l65n8WRwLkGigxqlDCGoS5/yKcUHAoykb6qA1xuDPuDoLjNt4X+UlWTaoq4iLE
 oEUXRAOb9dbeit/TomtZYKGH8/hD/JBdrBuz29+YOKeGwQjG2xETZHaK879Ve6wz1SvN
 xoaEdnffeh/jDB2sUI3oxRzIFS1vTgFk4QmYfph1oSTfPIybVjqLdUjvYUbP64CwkaBS
 cbomODA0UXCfy/zzCVqUqcnTqXEp6ilVuAo0/jPq+ngEplRK3GSs2ID0FWL7L4TfEsTA
 l59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781909990; x=1782514790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=;
 b=TMGmqNg831WnUdMXw6SBCFo3ag+gnuveT/bnF9NEHK7Ux+/Fe3ddW/R9kNyvZAjhMj
 p6i+QsI5YejbJAxBrbGCYU6Ut9IoKiGPt5VP82mh+rs6PT2WQfksat+jEmWQpfM/5Et5
 Nqyz7ZYJ9CebxiJd0GajLwudVvfEUyC6fxSXQPm0MqZ2VflIjhcnoiAu2nRQ5bO/qBHY
 gqt+nWEhcHs4zpZ4Mzr5ixP5qyq+T/g6SMX4ZOfDXPaeKcTkRfEpT+Y1QWAwl+A0yhjH
 7t1Jd6FuKw8DgK7Y5l16Wz/WHm001T1DjxoNQN0hP6U7y80DpdD9YqevvvD3dsdr2lSg
 ztsQ==
X-Gm-Message-State: AOJu0Yw3aZ7CpJpGU+J/OwVymah3qsJx9kyiuyHi2d3C7At8rkWnV6Ht
 e1wEIVPlQnfjdyhOQ5Yx0tkU5j3vG8zrsjfvNa0E37gLFA9GR8pJ1pVcyjHTqPaj80/3DzZwvty
 4E9HUI4bWQDCP+mW7pGO6DM1TvVO+XkTc2d5V01zrkxbTsgBomO7KmCvoz95ANB04HA==
X-Gm-Gg: AfdE7claamKaUdNhJLHIjTRWIs0QSwl/fbdUqYFgdt7qkbpe8xn6BOwGGuMWBTQshdI
 AZf0QilwDuTYTZjx4Bdcu0hdx0cObaQ930kcvGq+sgtFqnNzDkFbUzJn+DZFBMIsZYfd78MfDLB
 p21KPFr1aU8YWsZS05L9hI7PShLYWv11zKaH4/ZBuuwfYHD6qmxP+zIee4sitB5X8EM0Z1nV7fM
 Zq1APL7R1KU2tUeiF7LYqsWX56pdykoEtyR+3AYaa5Q3f9BHkCaXxtc90JyJD/Hctaf65f587l8
 5KRu3ire6UiXmZeIPe6jZ5c399IyY2wCj7QrsiEOxViVerD9r6LioZ32265SyjKYhkvwgP91LFg
 eGtsqWg3Ytccru1smAuJ5CydoRDdMftaNWPUq44NqHJkEDzX2qUNYIN6XW0Q=
X-Received: by 2002:a05:7300:fd0f:b0:30b:dd58:e167 with SMTP id
 5a478bee46e88-30c07038f73mr3254055eec.29.1781909989708; 
 Fri, 19 Jun 2026 15:59:49 -0700 (PDT)
X-Received: by 2002:a05:7300:fd0f:b0:30b:dd58:e167 with SMTP id
 5a478bee46e88-30c07038f73mr3254046eec.29.1781909989291; 
 Fri, 19 Jun 2026 15:59:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 24/74] target/hexagon: Add implicit attributes to sysemu macros
Date: Fri, 19 Jun 2026 15:58:21 -0700
Message-Id: <20260619225911.159473-25-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX7k91HXueJPP1
 D3THjUxnBz2jXWaRHz/nDt11eKzBMLy6E/JWVtN2SIjBsWd8TEymm9T0CGQw10QdiamqUPVEhux
 JNRk4Ss17BPwlwbwbrRlPZQ6klqTd8LZB1Dh/e0nkwyvqyP95Tbo6GWY4iV/6BYtt7fwdpIeEc8
 2CoHwNhjSrXGcCtphOFDtpzKl+ogJp2NFiQO97vdh5olTnmXoLoeBbY/vfPDsvOP2XU/VFn92vZ
 Tdwwpfv8ShJle639DF59GRWueboID//3D/h4ZfnKXO40wgME+aJEIzsBUzO9icE1UPEIhBt00KA
 R1bLbd4KWeAEq1fymUsOIm0pAE4dUa1MsOnAwYPqGQVB3+//4qHI3NhV8SrO8Ob9Ch5RZAzZHyQ
 mJxz8jstL/pqCDIASJEME7q6WH0+in0DGvlFr6v/Ce8XkbVYQ9/k6isn/kXttq5I3wxl2GTwakz
 LjuVowvGQ9RTLDCWkcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfXw9eHdF8oh6u9
 ZNXXYxqbl3Ff3o9PRtEfXT3r4ufmjnJC4AlaQiYdZ8cWt41jdyLK4lyk2nm7ceI6XFcuqqNWw/Z
 BHpTwTWGpQDCmqaqRieZZwSHqdmuQmk=
X-Authority-Analysis: v=2.4 cv=I75Vgtgg c=1 sm=1 tr=0 ts=6a35c9e6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=jiUnMIOmsb6gMTORg9AA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 61GAHI6xrip9vjb5N9OE_kJ0eahN56rp
X-Proofpoint-GUID: 61GAHI6xrip9vjb5N9OE_kJ0eahN56rp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190221
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgYi90YXJnZXQvaGV4YWdvbi9o
ZXhfY29tbW9uLnB5CmluZGV4IDhjNmEwNTg5Zjg4Li5hY2FhYTNjOTQ0YSAxMDA3NTUKLS0tIGEv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29t
bW9uLnB5CkBAIC0xMjgsOCArMTI4LDExIEBAIGRlZiBjYWxjdWxhdGVfYXR0cmlicygpOgogICAg
IGFkZF9xZW11X21hY3JvX2F0dHJpYigiZlRSQVAiLCAiQV9JTVBMSUNJVF9SRUFEU19QQyIpCiAg
ICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU0VUX09WRVJGTE9XIiwgIkFfSU1QTElDSVRfV1JJ
VEVTX1VTUiIpCiAgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU0VUX0xQQ0ZHIiwgIkFfSU1Q
TElDSVRfV1JJVEVTX1VTUiIpCisgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmQ0xFQVJfUlRF
X0VYIiwgIkFfSU1QTElDSVRfV1JJVEVTX1NTUiIpCiAgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmli
KCJmTE9BRCIsICJBX1NDQUxBUl9MT0FEIikKICAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoImZT
VE9SRSIsICJBX1NDQUxBUl9TVE9SRSIpCisgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU0VU
X0swX0xPQ0siLCAiQV9JTVBMSUNJVF9SRUFEU19QQyIpCisgICAgYWRkX3FlbXVfbWFjcm9fYXR0
cmliKCJmU0VUX1RMQl9MT0NLIiwgIkFfSU1QTElDSVRfUkVBRFNfUEMiKQogICAgIGFkZF9xZW11
X21hY3JvX2F0dHJpYignZkxTQk5FVzAnLCAnQV9JTVBMSUNJVF9SRUFEU19QMCcpCiAgICAgYWRk
X3FlbXVfbWFjcm9fYXR0cmliKCdmTFNCTkVXME5PVCcsICdBX0lNUExJQ0lUX1JFQURTX1AwJykK
ICAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoJ2ZSRUFEX1AwJywgJ0FfSU1QTElDSVRfUkVBRFNf
UDAnKQotLSAKMi4zNC4xCgo=

