Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA95D10398AD
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4az-0000EU-Fw; Fri, 27 Feb 2026 15:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aV-0007mv-Ce
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:27 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aT-0006uE-On
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:27 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RH0Jwc1912525
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5mEhb3HljndXAyE8QX75Y254zPaeDGDFK7PEh2xH1rs=; b=hwSwc8PawXtHHmhs
 KldJzo5guYVHp5HkbaGjnPax+kEr57fbbwUep9xIH+13Bcs/UUlHkxoUgbkPDFaz
 Kz2Csfhb8GlrGANyWeC3VYJIg2mlqHVKj3cTSWNb2w0ckfMC40K4TNOYj83gYPjt
 Ebw8P2B+8Ku8CE+vbWvVpjfRImRDOXmliaN9Ks4tOgKVrciyx+VmdH5BOOzhR952
 xZX2TmYTY0OzOj1zU+DxA33zF1ngNzMfGqF/GySe+Kgj3Avz/a7H6RYLjM5Z4Rd5
 jt+MLjd2e3r9iQe0tV6h+dJlrXlAZSxiyC3usRJdDvzHy/krrndzOD3i9t6mXdyj
 /r8TNg==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjuur4gkd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:14 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-6799654a158so21383848eaf.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224634; x=1772829434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5mEhb3HljndXAyE8QX75Y254zPaeDGDFK7PEh2xH1rs=;
 b=UtordEesd3c0PIUZk5pLC/RzRTQNYWMzStI0KSRbUkOLQG4ICEQH0ZkZZOwVDaxEgv
 nuUdE3rXH/UXtAWnCQ/JlmmSm6A0x2GQ4F4UMS8NGw3us3ZYpeZgGaRpUAzAl7P6MvP3
 iyk/N7JLCtTLcDqEQv5TkjHlj+4VQDiG86cPuBTpNv+IDu5AXkJPmakbxLZ605KmbI6i
 YuVUDHcgjwQ4+d5E5GouHejv/fyW9EjmoqO+o//m5yp/8kPh5x826/pHCFA4zS2HhfdR
 zV1dLJ4kxMKq8i55J9GPGX4vgHpIYCQmYnw3PvbzksQAxKUprarh/EfarcsVW3pAbHnH
 4MJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224634; x=1772829434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5mEhb3HljndXAyE8QX75Y254zPaeDGDFK7PEh2xH1rs=;
 b=WV4yV4Zw7IgpdnKw0d697yUVK4uUQGMV3yrVCNFCTWazOCYHUAYpQV1dHDgO5zEscO
 uSC7WhFSOWuAI30frFupqirF7eHNM0xYDBQN0aBLMoopYvG7qxdx2/Z3J5pviXrK9O0D
 tr3+SX010joMHqx2tZFkioM+3xuuszEdtZloyr5AXO5ryy/TffpGuFbJKJtuE3uSHaBa
 x+w450Jx6YyQyPZ/cqfw2ZIBYTX914FxvmqjaRdsaTpV8b3jqx5pDWUsMggVfPh6+AvO
 hMlCnvHzy8dGt9JTnPCTcgZBtjwPqqihTUGynHJn2ysAHesyiNuFwqZRz9nBSboZyuwZ
 Erxw==
X-Gm-Message-State: AOJu0YxmAiBiEqLzIiibMLAHFQ6DiLDDQrZQ/E9ngIHV8RWb1MRIL3e4
 uJk8NqWGo5T3avG6tHBhY+GdC8OoRpPQb5+YRlIdVZb4rw/IKsFiwOsmdO5nnmt09Myjaw41oKd
 zor7mFRcgMe2hRQOgDfIoUwMoDPZxejNq3j+M0D2TOcf/UYtaXcIIXb2kn2gjiw88GA==
X-Gm-Gg: ATEYQzybPqh7rJcBliLoqC/jyxhYrbkmrHojkp9xEIR+mFKBdKXiQOZduvGwTe8VehY
 XIuIO+oh49G+chVWWk8UhdVbYIGLr00VIpfuPv3rVkQw6VGzCDxMtDbptn2Uc18JGTtB9Jy6m4E
 TZH+5vRGLd/xc+J7HVDH+CHCJCTdJGcKQ202+OVA5zPduwdH3zg2O78ExNRHQh3AIo+YNIG+AMU
 zxcA8bt1oW1a26Aq1V6MzP7mJSE7ERfJ5motrXqqXNRc+UNk2Fly6fuhZuE7di7vvdflxW6guuc
 o8RizoJxfReFTkjiXYoJ2fHMX6/uwTxzzcgLzJenokj16GFZZBjBnS1zW2AVgxMm9x60jJ8fmQC
 9Apg/HXCJ2Yj0CxXDpF0N/Dd4HAzqKeGSxsR6d3Rv45KDYEBmPaxidXQtaNClflAXB1PkSg==
X-Received: by 2002:a05:6820:1747:b0:66e:77ff:4f25 with SMTP id
 006d021491bc7-679faf91349mr2222888eaf.72.1772224634154; 
 Fri, 27 Feb 2026 12:37:14 -0800 (PST)
X-Received: by 2002:a05:6820:1747:b0:66e:77ff:4f25 with SMTP id
 006d021491bc7-679faf91349mr2222873eaf.72.1772224633793; 
 Fri, 27 Feb 2026 12:37:13 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:37:13 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 32/37] target/hexagon: Add a TLB count property
Date: Fri, 27 Feb 2026 12:36:22 -0800
Message-Id: <20260227203627.932864-33-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: -sCKspYy-axEaD-GHO9YjmAQs5QxCRgu
X-Authority-Analysis: v=2.4 cv=PN8COPqC c=1 sm=1 tr=0 ts=69a2007a cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=azW6tTbyexnVTLMhPEwA:9
 a=QEXdDO2ut3YA:10 a=rBiNkAWo9uy_4UTK5NWh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX6IvOUgR7WSbf
 z7uFwKQVxeNn/O4/3ZBcSJ3kxUcxwqHJsZ0ZlKoxC2wb+S+w4CEf+knLZuDHLSXHEipmT57uIwv
 3FXGVfi3PbFa5yJjE1vkQlsWPNV3aWvnVQ/aNJWr7B/DL5FjdvqFIiOYhwkXhR554RMxsiBUtg7
 uFENut/1JG+lkxI0ai0BkgEm1xBDNlW4besyobbaVdQBxjU8AGMfsDyJgGTFbExs8iQK2qIvK2w
 tzVj9AsQFCBT6oUEcwEQTmbAJ7R9d5deFaUjDZeSxytxNH6zNLHR0u1xS4AXSakV7boJKMcGuqw
 /AmZ8TQc/Oc93UEXZBpi9Ewu+QlrRXKEiglaEh0cVHDu5NU2VL4mQyjyXm8j41pNdF1PkMyR5tI
 kelY0wBo03OyE2e/ugH3dp3u/eoznOEmhLGVGhAysLrWi1E15OR18cl5MZNvomj3+9fnWCz5Hyj
 +Od4KcDTDXxk6SljkVA==
X-Proofpoint-ORIG-GUID: -sCKspYy-axEaD-GHO9YjmAQs5QxCRgu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oIHwgMiArKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgfCA1ICsrKysrCiAyIGZpbGVzIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIv
dGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggNzZlYTM3MjcxY2EuLmUxYzY1NGRjOTNlIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApA
QCAtNDQsNiArNDQsNyBAQAogI2RlZmluZSBSRUdfV1JJVEVTX01BWCAzMgogI2RlZmluZSBQUkVE
X1dSSVRFU19NQVggNSAgICAgICAgICAgICAgICAgICAvKiA0IGluc25zICsgZW5kbG9vcCAqLwog
I2RlZmluZSBWU1RPUkVTX01BWCAyCisjZGVmaW5lIE1BWF9UTEJfRU5UUklFUyAxMDI0CiAKICNk
ZWZpbmUgQ1BVX1JFU09MVklOR19UWVBFIFRZUEVfSEVYQUdPTl9DUFUKICNpZm5kZWYgQ09ORklH
X1VTRVJfT05MWQpAQCAtMTgxLDYgKzE4Miw3IEBAIHN0cnVjdCBBcmNoQ1BVIHsKICAgICBib29s
IGxsZGJfY29tcGF0OwogICAgIHRhcmdldF91bG9uZyBsbGRiX3N0YWNrX2FkanVzdDsKICAgICBi
b29sIHNob3J0X2NpcmN1aXQ7CisgICAgc3RydWN0IEhleGFnb25UTEJTdGF0ZSAqdGxiOwogfTsK
IAogI2luY2x1ZGUgImNwdV9iaXRzLmgiCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUu
YyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IDk2OGRmMWI3NmFhLi5hODkwNGI2NTFhYyAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1
LmMKQEAgLTIzLDYgKzIzLDcgQEAKICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiCiAjaW5jbHVkZSAi
aHcvY29yZS9xZGV2LXByb3BlcnRpZXMuaCIKICNpbmNsdWRlICJmcHUvc29mdGZsb2F0LWhlbHBl
cnMuaCIKKyNpbmNsdWRlICJody9oZXhhZ29uL2hleGFnb25fdGxiLmgiCiAjaW5jbHVkZSAidGNn
L3RjZy5oIgogI2luY2x1ZGUgImV4ZWMvZ2Ric3R1Yi5oIgogI2luY2x1ZGUgImFjY2VsL3RjZy9j
cHUtb3BzLmgiCkBAIC01MCw2ICs1MSwxMCBAQCBzdGF0aWMgT2JqZWN0Q2xhc3MgKmhleGFnb25f
Y3B1X2NsYXNzX2J5X25hbWUoY29uc3QgY2hhciAqY3B1X21vZGVsKQogfQogCiBzdGF0aWMgY29u
c3QgUHJvcGVydHkgaGV4YWdvbl9jcHVfcHJvcGVydGllc1tdID0geworI2lmICFkZWZpbmVkKENP
TkZJR19VU0VSX09OTFkpCisgICAgREVGSU5FX1BST1BfTElOSygidGxiIiwgSGV4YWdvbkNQVSwg
dGxiLCBUWVBFX0hFWEFHT05fVExCLAorICAgICAgICAgICAgICAgICAgICAgSGV4YWdvblRMQlN0
YXRlICopLAorI2VuZGlmCiAgICAgREVGSU5FX1BST1BfQk9PTCgibGxkYi1jb21wYXQiLCBIZXhh
Z29uQ1BVLCBsbGRiX2NvbXBhdCwgZmFsc2UpLAogICAgIERFRklORV9QUk9QX1VOU0lHTkVEKCJs
bGRiLXN0YWNrLWFkanVzdCIsIEhleGFnb25DUFUsIGxsZGJfc3RhY2tfYWRqdXN0LCAwLAogICAg
ICAgICAgICAgICAgICAgICAgICAgIHFkZXZfcHJvcF91aW50MzIsIHRhcmdldF91bG9uZyksCi0t
IAoyLjM0LjEKCg==

