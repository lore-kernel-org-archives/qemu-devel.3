Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB96CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcktg-0006vx-2j; Thu, 25 Jun 2026 10:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktb-0006v1-OL
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wckta-0008VF-8U
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:35 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jsti2009329
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=; b=BpTmkpX0NHIJNbpC
 WK5KAnIsZ7ywb2eeGdWQAusQTfO+CoMcqE5qohX0ebaphpQ3l6lWIXnCTmH90Bg9
 duQAaMMi/D7TCpVFTm8iAcc+yOqPxndXISLbj2asElwTm8F1bDyi74PBwdzz6fdu
 jDtdh7e1CoNMbRvvcor5ejdUjnJ4BdDNuF8DkTOudCplmgggvDOiGEa8DsKKSWZK
 MiCAXbqgu5LZt4KHfkwWo5gtUrtnGT3Hl16sXcRS418hv5DLXW/8sT6C5YmSub+M
 eSOb2ecrrLeB2OjrvXaB32opMzdp+7nwEUhP2EElpoLcbzE0AKOU+GLzYk/W65up
 MrljVA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uhmjjwy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c13bb8ca9so3003073eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397041; x=1783001841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=;
 b=Jmk1uHw8kjhyhItKOQURX5gTxvuYcmJvf0coPg5aNQJMfErsm8X1rzOc9ymSq0Y/0U
 DBrFvshkr6aXe+VDvi926mxcKhXVeRRd5LUo0DxtwOTpjAxSRzYT1unKmz17fel1vg8i
 lNP0EymmQnluSmJ4zDBhgoiOvo0vN9UVZW4NHY71l1whai2+vYGHsbKP2GPOKbkubLFZ
 9uzemABdS0K8KSk/APxKEoxvQfaVBnkwoXgH0ssozve20SyDQo4b03slalOjf1P6NaSN
 AdCH/LCIPm0kkM2CFCg0D7sMO5RbEQv7I+NywSPPxKx0gYWg7XpUTVzpOj3n49QxQGd6
 JY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397041; x=1783001841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=;
 b=qTQC1s8q14Q3SgDt4zIO5G8dSQF7uwewVkHQCl+SJq66rGR5y6ujhgvaunIOfY3Vfw
 4PWIOZOEdBjY5D0DBFMO0cUFHaShC+aHH7Y6pOXZcQcOncj6gSLarSe/eNys87BXqTMP
 j8etA4ZaWwYiSdcaF99zSZSTgJi6nEHqGfEJdku49B4Mo1Yv6scepS+BDfxbEqnGZLND
 KJ/lszotCvwcPBcn0sMiJHwy83JqqGvfYOQyaPF/Lw7mtCwSdleYapE+rAmT+y4Ad8gV
 flY0qJFrvLq+9weUJF/oEklZx8G/4QetzTtHEkCSsNOSEr8xUNWF2ZTQiHINlloGwpNI
 uB5g==
X-Gm-Message-State: AOJu0Yw1ylDOm/vcV/BOsHt6K1d9ayIGfn/pxBKfmSxLUFAO/HEwJS12
 ri9jgkrFNttYzbsDLByh8ARu/v4lq7SbxE6juIyPXE+coTRvBzlEKFwBK8XFaXOl1CfN8+h8vvw
 5wpNzMlpkgZktd1DHGHM/5nN/3hnHtTJMzwHGBDeLDNBTfooiEACp0UuQ9GZze6MZiQ==
X-Gm-Gg: AfdE7cnxIvsk45JBMl9uoJDNEi3JsEQbGfuc5xUKpCw/S/QLH3EYgUqPvxhBMHT+Ec4
 Oo+htDXr3ZotK20EnLS+GF3856LMYDCLq6wp6z+W2lUGdQMHW1D5OD9TzYuRMaCJweBZxzn/xmI
 c2DYnp+ZJ2TBizamMip8ip22e4PddUlVecSdQndUBIBWUurFlsQqYg5X2TzUaQbkwK8IsmCH13L
 4CZ09w2NoCQRhyRYJUVQF2W7/LnbUUcXw0Kvpgg6Esb7jn1WRupFSeGuTmBCnMpd3BZx6avlQV8
 ozVTRUDNmWJukDborZkLRlNE6lYhs93XnVaghdb6tUf31c1ZfTgLg6SAxOsIaBVAyU1QxsO1Bfn
 /LCw6rxqWxeAP7+wxZESp0zXUcrovrQ8/a6N1Qqed1Ix5MC0T9pZacYQwgHE=
X-Received: by 2002:a05:7301:1486:b0:2c7:3a7:c792 with SMTP id
 5a478bee46e88-30c84d50a3amr2934848eec.20.1782397041476; 
 Thu, 25 Jun 2026 07:17:21 -0700 (PDT)
X-Received: by 2002:a05:7301:1486:b0:2c7:3a7:c792 with SMTP id
 5a478bee46e88-30c84d50a3amr2934781eec.20.1782397040718; 
 Thu, 25 Jun 2026 07:17:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:17:20 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 22/76] target/hexagon: Make A_PRIV,
 "J2_trap*" insts need_env()
Date: Thu, 25 Jun 2026 07:15:39 -0700
Message-Id: <20260625141633.449487-23-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=cqerVV4i c=1 sm=1 tr=0 ts=6a3d3872 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=923NME1-z-asBZaYXDoA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfXzIjKqskj7e3A
 Ev8DnRUlc4kS3PM7ORNezWYKmxca5DR0mWlV/76k8LTG8NVGu8cLZjXHN1DFSyTK8K+C70JMQHG
 91OVii/+ThmhZqMHvPwKQIxKBbbZwp9z8hPyyTBs/nLjjZnUq4SHw7815kJ4LZpNRX1DEgEsxzy
 BZkyttF/NkhV6fy3VZ/R0HW8FZ9cy/5h/q+uKceF9gmYoF9ljX4JIEa3X/I8fsc5heCW5wQ5qpP
 g/b0926KSuua6n6xGhf2FBSeDJwlmcTZVEYJL481DsF30hAhGAIE8Ze7W9lFdnK+VUelPbb6yb6
 ZUWzCy5y9oJQifEMLWflW1UtQitnBfhegABjN28oMseF4ZCvof0MSed1ml15w/wTm5FLUlI0+yR
 n2v56KuhMIbE9zqzvsmEdGQbwQqk5bsUuFznchOGJ90RvGuewmJTWWDkJJ6QyB5sB6sIhIEq3oi
 HQu5cN2tUXHKFY0kYrw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX4Ox8PJ0D+KPP
 3nbYp3L8dO2xHy8O4y3JFJH2Y5nBfRiAwfoDbxDWmaCGGcbYpdKavJAwxJa122IzxJM0/22Ry5t
 Ax7k5TI2iwd5akzNE/Ptkkh365Z6Pug=
X-Proofpoint-GUID: MR5FK1zTFIBjzXy_-SUbQAHAcPQFw6kr
X-Proofpoint-ORIG-GUID: MR5FK1zTFIBjzXy_-SUbQAHAcPQFw6kr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250122
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
eF9jb21tb24ucHkgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IGIv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQppbmRleCBkZjhkM2JhNjU4Ni4uYjU1NWUyYjY2
M2IgMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKKysrIGIvdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weQpAQCAtMjUwLDcgKzI1MCw5IEBAIGRlZiBuZWVkX2Vudih0
YWcpOgogICAgICAgICAgICAgIkFfTE9BRCIgaW4gYXR0cmliZGljdFt0YWddIG9yCiAgICAgICAg
ICAgICAiQV9DVklfR0FUSEVSIiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKICAgICAgICAgICAgICJB
X0NWSV9TQ0FUVEVSIiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKLSAgICAgICAgICAgICJBX0lNUExJ
Q0lUX1dSSVRFU19VU1IiIGluIGF0dHJpYmRpY3RbdGFnXSkKKyAgICAgICAgICAgICJBX0lNUExJ
Q0lUX1dSSVRFU19VU1IiIGluIGF0dHJpYmRpY3RbdGFnXSBvcgorICAgICAgICAgICAgIkFfUFJJ
ViIgaW4gYXR0cmliZGljdFt0YWddIG9yCisgICAgICAgICAgICAiSjJfdHJhcCIgaW4gdGFnKQog
CiAKIGRlZiBuZWVkX3Nsb3QodGFnKToKLS0gCjIuMzQuMQoK

