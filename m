Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAB9C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3ex-0005V6-RY; Mon, 29 Jun 2026 00:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dX-0002t7-GN
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dR-0001Nf-8E
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:20 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NCTw1771912
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k98P3mzy875bIQ72dfi4cpupNsJGfuDp4DlfWaLieyw=; b=peV6w3gYy8QGUKk/
 mFWTjOnDi0YUQ+0yg+YNJSykPc4LeiCbOYhO3SlFLYa2I0JayeJK2o2xF+2qHgut
 xOhP10zAujncWRP4uZ8rNLtwFXNNgXssK0Yxs0K9VhQXc71ZPC0EqBUd1erIGPIf
 Rr4+HSPios3XbhbGcp8ShtlCT19kjZQoVwMlajohm23I2CN+2r6E0uYp9VShAMQJ
 4Rz38eXkfit6ytpWGsu6wWX5Un2nB8XY8DAX9PoedTOXXIo/XjhjMCkjnNTYf2E2
 64FQU5x802f43hSJyw5Gj4VRSLlyfdMSL7kgvD/TuyUt6+mNSbf9tizDvu4/jkB0
 jJH1+w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27084dh7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:14 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30ca3374c6aso7999619eec.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707413; x=1783312213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k98P3mzy875bIQ72dfi4cpupNsJGfuDp4DlfWaLieyw=;
 b=Jdy6EwvOVz3cnQN1PqbZYkUvvP7qqxeHGpYDtZREO/e9Xze+wckN8T4FPVOInfSrpT
 CqJFWn9F/ZnnfnAMu/5mQNnouVWU2rdgnK504KOil3GFPWglHdfVBGweCi/zNH5Q9r1E
 /przE95KE0+6hV4jrzMnNxrOmRFY5jX5H1MlEHd/OwVpHDBNPk5ZSPHiHTrgY8Z7oaoA
 rFsJEns0TKUt7zn/cVGSsx+XjyQ6aZs2dUrXbrhLGlEQzI2eUZNeODf3KEFHRDCpXmiB
 wUzXTjPbGziCDX1FGDMSrUd2q+dTOLS+upo9Zta3kjNi2E2e54d6BohjlyP+QZ6+vHXF
 8ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707413; x=1783312213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k98P3mzy875bIQ72dfi4cpupNsJGfuDp4DlfWaLieyw=;
 b=W5aUuI7WxRlctoT5SSCI6gaceEAT5p1UQ48yBhmw7qPfu6PZJTRqMdYk+BR0vawZFj
 A8kAr/h0qFhERlsti2tY1UxlkqL5GX2MwUZWFxPx2UAcrNx6Zc+ZThBuxxGkiBRDU6Br
 6vz0kgZryvCytW5FLf34+nZK43LQ1Cld9Q0Pvwn3e9ZVoO+dH0+Yo5kHzPmLNntjshKB
 +r3vLsPYMq1iqcQa8gWc9Jlqwq1zkp6+kUouqFNqtUSEiqrgTybWhUnWRlfdY6QO++lb
 WvI0EH5+sOJQm6g54Vz//K/RUm0+jLZGqGV7oXNetmHUT6z1zPgSHL8+7bkGLhG2KUpP
 TBgQ==
X-Gm-Message-State: AOJu0YwQDw60rEZwKjKRIrgGJzj1/ANA64SCclSwGMSjq3Ms3vwCpvrt
 JYyeUUOls2ogeNmGxf45pURy4h1NLiP5Fs9uwTSm51ir1wFJK5hby661amKEQTUg6E1zqLqTl5p
 nJ0T7ZX9Xi5gpWSgc//mqi3X1lGaIJ7DD1RKyV9VhKBHT4Rri1dYw8ukF56f+sr7WgQ==
X-Gm-Gg: AfdE7cnp7R4JXWo4OzzSZFGfrwRAGLD08QitnUnFOEqyEmk7vLbeLuXc1lAsyAvsV+2
 4GWdBuS1GkT/jUNl/lVl0dd7lZWOOVnbRHaEs75EiZR/ybtmxGDvwisjOrCUa8hKS5DMl3qAUAm
 r7EALte7EbxD9qTUfcImFf6Als0deTp4MQ92RvU9aNUl8b1J3cOYdqC9TozuoGxUsIZnMcLWqmr
 itquAccJjg8K3UjsfI5WzsrNUA+VhvKyqgVkC5vN9H98jxMYINSN/3Wtez3bz+Mlo7yGMlpYMRP
 h9+7ViImPoBTDigWPpcdRD19GrOnfKx3bwGAsbfVnLPAaxreMMTnZUL7qyctVZFtyK9T0QMx4l/
 NAv/aMYuB9QTE4armHtk1tu627QGyifyzaeoREMBMdnk05BaIfcSUJ2YKj+0=
X-Received: by 2002:a05:7300:e78f:b0:30c:ab4d:da3a with SMTP id
 5a478bee46e88-30cab4ddbb1mr7792896eec.44.1782707413412; 
 Sun, 28 Jun 2026 21:30:13 -0700 (PDT)
X-Received: by 2002:a05:7300:e78f:b0:30c:ab4d:da3a with SMTP id
 5a478bee46e88-30cab4ddbb1mr7792857eec.44.1782707412461; 
 Sun, 28 Jun 2026 21:30:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:30:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 65/77] target/hexagon: Add PC to raise_exception,
 use fTRAP() helper
Date: Sun, 28 Jun 2026 20:58:18 -0700
Message-Id: <20260629035830.1520296-66-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=ObKoyBTY c=1 sm=1 tr=0 ts=6a41f4d6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4FQt9sIIQT5CW9ciUtIA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX5uBNSyna1dUm
 p0Qml4MKWBXAedpUF+malw/vnpsNMu5UBrr8+EP12qt/yPsVgjxop86O41t7peNGf2Q0LC0h2wO
 WNC9B99GoaEEo87N5uw08IWfZUx3HrrWIDxa1Nck+qLF9WgQRwlHh3jl1unxPSsjQ3OTb0zshzD
 n1uA2N3olRzdZW/ro+G2vwmDtVUZvktIt4lStSvg2e6JruOf0s4hjY24HzbqY097foZnHPynf4z
 aU/oRx+pbU2FXIqEAKfUUh6vtcP4WHP5fp3El0HegMP8dffyc2XYowxaPlijWj0n3B06EEovFC9
 r811pZDnb7meZEFPQtShtDbA51DJHbBNomFuQqqbXsCk+zbGGiO7D5SetLhD1x6y5soSB/RJsaz
 tVynx4uLv53af9bA1RTU8HEIyxpfknfwa7XWgvppns08AUjM3SrDO3jfcqLrCDux8E4JkPxxfVT
 jz239Ax1HBuIQ1GJp1w==
X-Proofpoint-ORIG-GUID: lt4tiMq5Z0xM6nJHigwB1KPErRxJc5CY
X-Proofpoint-GUID: lt4tiMq5Z0xM6nJHigwB1KPErRxJc5CY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX8iZB3OuhR4U9
 7rYtL8C33EL0STmqzjV00bY/33gwu9YqAO50YJ5CjOyGwAlVHV5QHaB/vSZ+a6bI/mBIxP/g2GT
 Th+N91zm7JbRDiJ+apNo6HJ4N7sAVq8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290034
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBZGQgUEMgdG8gcmFpc2VfZXhj
ZXB0aW9uIGhlbHBlcgoKUmVwbGFjZSB0aGUgZkdFTl9UQ0dfSjJfdHJhcDAgbWFjcm8gb3ZlcnJp
ZGUgd2l0aCB0aGUgZlRSQVAoKS1nZW5lcmF0ZWQKc3lzdGVtIGhlbHBlciBpbnN0ZWFkLgoKUmV2
aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmggICB8ICA3IC0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgIHwgIDIgKy0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTAgKysrKy0t
LS0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCAyMSArKysrKysrKysrKysrKysrLS0t
LS0KIDQgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oIGIvdGFyZ2V0L2hleGFnb24vZ2Vu
X3RjZy5oCmluZGV4IDRhNThlYWQ4NzdiLi5hMjhhZjBjMjQ1YiAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vZ2VuX3RjZy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaApAQCAtMTM0
OSwxMyArMTM0OSw2IEBACiAjZGVmaW5lIGZHRU5fVENHX1MyX3N0b3Jld19ybF9zdF92aShTSE9S
VENPREUpICAgICAgICAgIFNIT1JUQ09ERQogI2RlZmluZSBmR0VOX1RDR19TNF9zdG9yZWRfcmxf
c3RfdmkoU0hPUlRDT0RFKSAgICAgICAgICBTSE9SVENPREUKIAotI2RlZmluZSBmR0VOX1RDR19K
Ml90cmFwMChTSE9SVENPREUpIFwKLSAgICBkbyB7IFwKLSAgICAgICAgdWlWID0gdWlWOyBcCi0g
ICAgICAgIHRjZ19nZW5fbW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBjdHgtPnBrdC5wYyk7
IFwKLSAgICAgICAgVENHdiBleGNwID0gdGNnX2NvbnN0YW50X3RsKEhFWF9FVkVOVF9UUkFQMCk7
IFwKLSAgICAgICAgZ2VuX2hlbHBlcl9yYWlzZV9leGNlcHRpb24odGNnX2VudiwgZXhjcCk7IFwK
LSAgICB9IHdoaWxlICgwKQogI2VuZGlmCiAKICNkZWZpbmUgZkdFTl9UQ0dfQTJfbm9wKFNIT1JU
Q09ERSkgZG8geyB9IHdoaWxlICgwKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVy
LmggYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAppbmRleCBhYTM2MDRkYmRjNS4uMDMzZTU2MTlk
NmIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhh
Z29uL2hlbHBlci5oCkBAIC0xOCw3ICsxOCw3IEBACiAjaW5jbHVkZSAiaW50ZXJuYWwuaCIKICNp
bmNsdWRlICJoZWxwZXJfcHJvdG9zX2dlbmVyYXRlZC5oLmluYyIKIAotREVGX0hFTFBFUl9GTEFH
U18yKHJhaXNlX2V4Y2VwdGlvbiwgVENHX0NBTExfTk9fUkVUVVJOLCBub3JldHVybiwgZW52LCBp
MzIpCitERUZfSEVMUEVSX0ZMQUdTXzMocmFpc2VfZXhjZXB0aW9uLCBUQ0dfQ0FMTF9OT19SRVRV
Uk4sIG5vcmV0dXJuLCBlbnYsIGkzMiwgaTMyKQogREVGX0hFTFBFUl8yKGNvbW1pdF9zdG9yZSwg
dm9pZCwgZW52LCBpbnQpCiBERUZfSEVMUEVSXzMoZ2F0aGVyX3N0b3JlLCB2b2lkLCBlbnYsIGkz
MiwgaW50KQogREVGX0hFTFBFUl8xKGNvbW1pdF9odnhfc3RvcmVzLCB2b2lkLCBlbnYpCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jCmluZGV4IGI4MjcxM2JkMWMwLi44YTM3MjNjYmFmYSAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAg
LTY2LDE1ICs2NiwxMyBAQCBHX05PUkVUVVJOIHZvaWQgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25f
ZXJyKENQVUhleGFnb25TdGF0ZSAqZW52LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50MzJfdCBleGNlcHRpb24sCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnRwdHJfdCBwYykKIHsKLSAgICBDUFVTdGF0ZSAqY3Mg
PSBlbnZfY3B1KGVudik7Ci0gICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwgIiVzOiAlZFxu
IiwgX19mdW5jX18sIGV4Y2VwdGlvbik7Ci0gICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IGV4Y2Vw
dGlvbjsKLSAgICBjcHVfbG9vcF9leGl0X3Jlc3RvcmUoY3MsIHBjKTsKKyAgICBkb19yYWlzZV9l
eGNlcHRpb24oZW52LCBleGNlcHRpb24sIHBjLCAwKTsKIH0KIAotR19OT1JFVFVSTiB2b2lkIEhF
TFBFUihyYWlzZV9leGNlcHRpb24pKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBleGNw
KQorR19OT1JFVFVSTiB2b2lkIEhFTFBFUihyYWlzZV9leGNlcHRpb24pKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBleGNwLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90IFBDKQogewotICAgIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2Vycihl
bnYsIGV4Y3AsIDApOworICAgIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2VycihlbnYsIGV4Y3As
IFBDKTsKIH0KIAogdm9pZCBsb2dfc3RvcmUzMihDUFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0
X3Vsb25nIGFkZHIsCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3Rh
cmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGY1NDUwY2VkN2RlLi5lMDQxOGVlOTkwZCAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vdHJhbnNsYXRlLmMKQEAgLTEyNiwxMiArMTI2LDE5IEBAIGludHB0cl90IGN0eF90bXBfdnJl
Z19vZmYoRGlzYXNDb250ZXh0ICpjdHgsIGludCByZWdudW0sCiAgICAgcmV0dXJuIG9mZnNldDsK
IH0KIAotc3RhdGljIHZvaWQgZ2VuX2V4Y2VwdGlvbl9yYXcoaW50IGV4Y3ApCitzdGF0aWMgdm9p
ZCBnZW5fZXhjZXB0aW9uKGludCBleGNwLCB1aW50MzJfdCBQQykKIHsKLSAgICBnZW5faGVscGVy
X3JhaXNlX2V4Y2VwdGlvbih0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKGV4Y3ApKTsKKyAgICBn
ZW5faGVscGVyX3JhaXNlX2V4Y2VwdGlvbih0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKGV4Y3Ap
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjZ19jb25zdGFudF9pMzIoUEMpKTsK
IH0KIAogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitzdGF0aWMgaW5saW5lIHZvaWQgZ2VuX3By
ZWNpc2VfZXhjZXB0aW9uKGludCBleGNwLCB1aW50MzJfdCBQQykKK3sKKyAgICB0Y2dfZ2VuX21v
dmlfaTMyKGhleF9jYXVzZV9jb2RlLCBleGNwKTsKKyAgICBnZW5fZXhjZXB0aW9uKEhFWF9FVkVO
VF9QUkVDSVNFLCBQQyk7Cit9CisKIHN0YXRpYyB2b2lkIGdlbl9wY3ljbGVfY291bnRlcnMoRGlz
YXNDb250ZXh0ICpjdHgpCiB7CiAgICAgaWYgKGN0eC0+cGN5Y2xlX2VuYWJsZWQpIHsKQEAgLTE0
MCw2ICsxNDcsNyBAQCBzdGF0aWMgdm9pZCBnZW5fcGN5Y2xlX2NvdW50ZXJzKERpc2FzQ29udGV4
dCAqY3R4KQogfQogI2VuZGlmCiAKKwogc3RhdGljIHZvaWQgZ2VuX2V4ZWNfY291bnRlcnMoRGlz
YXNDb250ZXh0ICpjdHgpCiB7CiAgICAgdGNnX2dlbl9hZGRpX3RsKGhleF9ncHJbSEVYX1JFR19R
RU1VX1BLVF9DTlRdLApAQCAtMjExLDggKzIxOSwxMSBAQCBzdGF0aWMgdm9pZCBnZW5fZW5kX3Ri
KERpc2FzQ29udGV4dCAqY3R4KQogdm9pZCBoZXhfZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoRGlzYXND
b250ZXh0ICpjdHgsIGludCBleGNwKQogewogICAgIGdlbl9leGVjX2NvdW50ZXJzKGN0eCk7Ci0g
ICAgdGNnX2dlbl9tb3ZpX3RsKGhleF9ncHJbSEVYX1JFR19QQ10sIGN0eC0+bmV4dF9QQyk7Ci0g
ICAgZ2VuX2V4Y2VwdGlvbl9yYXcoZXhjcCk7CisjaWZkZWYgQ09ORklHX1VTRVJfT05MWQorICAg
IGdlbl9leGNlcHRpb24oZXhjcCwgY3R4LT5wa3QucGMpOworI2Vsc2UKKyAgICBnZW5fcHJlY2lz
ZV9leGNlcHRpb24oZXhjcCwgY3R4LT5wa3QucGMpOworI2VuZGlmCiAgICAgY3R4LT5iYXNlLmlz
X2ptcCA9IERJU0FTX05PUkVUVVJOOwogfQogCkBAIC0yMjYsNyArMjM3LDcgQEAgc3RhdGljIHZv
aWQgZ2VuX2V4Y2VwdGlvbl9kZWNvZGVfZmFpbChEaXNhc0NvbnRleHQgKmN0eCwgaW50IG53b3Jk
cywgaW50IGV4Y3ApCiAKICAgICBnZW5fZXhlY19jb3VudGVycyhjdHgpOwogICAgIHRjZ19nZW5f
bW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBmYWlsX3BjKTsKLSAgICBnZW5fZXhjZXB0aW9u
X3JhdyhleGNwKTsKKyAgICBnZW5fZXhjZXB0aW9uKGV4Y3AsIGZhaWxfcGMpOwogICAgIGN0eC0+
YmFzZS5pc19qbXAgPSBESVNBU19OT1JFVFVSTjsKICAgICBjdHgtPmJhc2UucGNfbmV4dCA9IGZh
aWxfcGM7CiB9Ci0tIAoyLjM0LjEKCg==

