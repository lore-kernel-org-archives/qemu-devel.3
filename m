Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E9BFDEE5E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 02:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG6P7-0006ky-JZ; Thu, 23 Apr 2026 22:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wG6P2-0006jq-9z
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 22:36:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wG6P0-0008K9-AZ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 22:36:24 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NHgG0m1533461
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 02:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9Qq3yTydG2zA8fi3pUcOBjH4+Z/04c40PX8CcZNcxck=; b=Djjza6PN33SikYYi
 Q+B1e36z6FUGaGztOJdaPSrKJJ9YjsseCTe+l9rsdv7dBuDPxQJ/f7p2QHmwAnVu
 yVBmouYZvLP6us0nh2Om2p6A/DO9DUyoMfDdq+2FoOCmlzDl9VewrsdDi6oo3Yoy
 e+mDCeFl+9LWVkR2NQOQzYgw/ce8TRvIpVyT8qxZOVDwFANAHBE5MF3SJIG9NWaY
 7RPNinEETlzE7bpTh4viDWFDrpQzoJZ9BwECQHO/1vR/TO2ykOfgkeiCdxZzToc/
 y3ORKJsP+I5Vf+iW7r8Sp8uHrgZ+Adzr1Nwf2gjdfTHY+R841FWti9itap4qzBQK
 QCH1qQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqr26hvgx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 02:36:20 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c8ccc7593so8059674c88.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 19:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776998179; x=1777602979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Qq3yTydG2zA8fi3pUcOBjH4+Z/04c40PX8CcZNcxck=;
 b=jdcOSEsNxFuvzK9MZKSRVcDzy0OQ0yXyUnVIWdykgnG7QjvCj/ZZWswFg4w0StuoNS
 HI45WDXRdpyQDqni5W9y6TEFiLbqMHY8h5rsdUAkE3HxWaxip3HRgNFADvPlYVG1QFm0
 hCLGW1CQcc48Ja1l2PAMxXlp0VM29nPJzUt5lxFJ5VRwSnwAosuN/NW/Yz5EQliiN/aH
 g+e/cykV/3qONiozSF5NXdlqIbPLc0VHHHbKPmF08LBrGsq7gjjvciVTnpBt/Ni0DrR6
 dQT10rlU1F2aZwbhyWWFd2oKkCh6g4CG0iikDAox9S9edRSL2x5Y64b/rBV5TWMG5MhR
 DAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776998179; x=1777602979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Qq3yTydG2zA8fi3pUcOBjH4+Z/04c40PX8CcZNcxck=;
 b=dxw7JX5K6AodL119I9aow8j5/Pt+04ewIHX9tXI3jVCGqYFKQylC6LJRDQbkVvN6F6
 HF8bS6d63bP8Z27e+wF0I37SlIykqI7sQh4ssT/j2HgpmHecfj741pW7ynCocRPSoyuA
 byKbVp35cAfiburtsKDM8V5vOmiqMTgb9yPl7SLRfLhiR40qh0WZsBWvCt8jo3bdPdG0
 X3GXug9ZdryP4y2fnU/eCfeRupbLUCsrpWtiJ3duM9BMpQLjD+Y1NzWA8U+ddiaMi73p
 1InN8c85+vF2iSUAuBXsfNSJcMx67v/BWZLklkL2jfvWRAHrAkrsZJTjyWcEt4Clr+DT
 +Opg==
X-Gm-Message-State: AOJu0Ywqv0S9JUg3VHFKM9Mio+D0hnHzC1+ilAr+rr2ASgFmAuAmJ+Bd
 Sj1I3JrBhhu1ICAX4G5J7jYnZw0srftYkWqhNjAaE+8jQZaq/prNEqgI2dj3okR5F/UqcLCIS6k
 jxR7E3IastLhqcLb2weUWqi6rdgOY+9IKXHoYXPR4rS4oOW33yXLRuQl+Oi3v0fk85w==
X-Gm-Gg: AeBDieuZR8PDZeHxpB417ZDwYaV5S4Oig3aHLctXz5KpnewGt8tLi1ciapDAcyuxQz0
 R9Z+CSrBcsXswKhOcIW1yspa0OF6lP+dzC1aJabKMsHVAEXiT6oup7/r8+PlbgW7pzJ0woE+VG3
 375Y1j7zOhbJImfs3+Z5Q2O8di6Q1qe9PDbeajW9h2VrE84dF7fFKQTOjtSVttjcHmsLckNZAY4
 uhQAnxFXc2D57rOO/bjvVQN/uqY9MLo44ua5Y2Rlp6zruoQJ9OrFtdlGyV2QkDGlMb/B9jSX+RX
 0Pr2jvAUPopea/bjm/Z9ej4Cxxr6AeNzFsJj/PLIX1E3bw10hwLS4PXaBtk/UIiVfZy/WWM6LbR
 3v/huPuWtzJfC77t3RY5azJ+co55zfAw/aFg72fU19HohUC8nzYOtRFeQyrjPzYYs1cxIdD+yaf
 Rk2Y1X
X-Received: by 2002:a05:7022:eac1:b0:12c:8d32:9378 with SMTP id
 a92af1059eb24-12c8d32953bmr11970540c88.32.1776998179322; 
 Thu, 23 Apr 2026 19:36:19 -0700 (PDT)
X-Received: by 2002:a05:7022:eac1:b0:12c:8d32:9378 with SMTP id
 a92af1059eb24-12c8d32953bmr11970525c88.32.1776998178822; 
 Thu, 23 Apr 2026 19:36:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa6134sm31240868eec.3.2026.04.23.19.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 19:36:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 3/9] Hexagon (target/hexagon) Add Hexagon definition field to
 DisasContext
Date: Thu, 23 Apr 2026 19:36:00 -0700
Message-Id: <20260424023606.2556830-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424023606.2556830-1-brian.cain@oss.qualcomm.com>
References: <20260424023606.2556830-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 7a2toVMBJ5ir3xfL8lDs1lbVn7-MDQMz
X-Authority-Analysis: v=2.4 cv=QLhYgALL c=1 sm=1 tr=0 ts=69ead724 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=qvChV9ao02qsrf_68UQA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: 7a2toVMBJ5ir3xfL8lDs1lbVn7-MDQMz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDAyMCBTYWx0ZWRfX6dsPE6zkoFXT
 jtBFRyZSyrchNzT+B6QTPuznKAA3Mqvu2Th/x7mt/0vBROvsPa+zD7OmbB1c6YHsXdmv13cV8Jf
 JQnmhAZtKvlqA11AKTDsMSWujm3KPFkSOJbIeWl9pbarLeYPk4EfmVacq8IEpF6mOp2jBfBREqx
 JcvZW3MVoLsMonuuKMLwC7SkDqdlp2fXknVcxz7PBWiPyA5difEZZcX0d+M56jdrqDyNxTketZK
 v8OV8UEuTZDSVWmddKmVP25920AWXZaNuVTto6A9/KsPkIARBT1Ihf7dG0XuRSqEioKZQyjZQ1p
 bSVIQ6Cu6wTj0OXxqnv8V4ajGUGxCuzwbvhnxO9u0/7ytlXB+k5gw/IfSSjOqXjziN5PFY3K5sW
 MaxS8KunVJbaeNzPbcTaDdMgTmZjB5vAai981zU0YRw53LKGEin4QBoRLwHg13i+Qfmulw23afr
 kNMU5fqJbjHxWVcTNmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240020
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KCkluaXRpYWxp
emUgdGhlIGZpZWxkIGluIGhleGFnb25fdHJfaW5pdF9kaXNhc19jb250ZXh0CgpDby1hdXRob3Jl
ZC1ieTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgpDby1hdXRob3JlZC1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBz
b25AZ21haWwuY29tPgpSZXZpZXdlZC1ieTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4K
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oIHwgMSArCiB0YXJnZXQvaGV4YWdvbi90cmFu
c2xhdGUuYyB8IDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5oCmluZGV4IGIzN2NiNDkyMzgxLi45Y2RjYmQ2NDE2NCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKQEAgLTMw
LDYgKzMwLDcgQEAgdHlwZWRlZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKICAgICBEaXNhc0NvbnRl
eHRCYXNlIGJhc2U7CiAgICAgUGFja2V0ICpwa3Q7CiAgICAgSW5zbiAqaW5zbjsKKyAgICBjb25z
dCBIZXhhZ29uQ1BVRGVmICpoZXhfZGVmOwogICAgIHVpbnQzMl90IG5leHRfUEM7CiAgICAgdWlu
dDMyX3QgbWVtX2lkeDsKICAgICB1aW50MzJfdCBudW1fcGFja2V0czsKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5k
ZXggNjMzNDAxNDUxZDguLjEyYzgyZmQ2YzVhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtOTg4LDYgKzk4
OCw3IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fdHJfaW5pdF9kaXNhc19jb250ZXh0KERpc2FzQ29u
dGV4dEJhc2UgKmRjYmFzZSwKICAgICBjdHgtPmJyYW5jaF9jb25kID0gVENHX0NPTkRfTkVWRVI7
CiAgICAgY3R4LT5pc190aWdodF9sb29wID0gRklFTERfRVgzMihoZXhfZmxhZ3MsIFRCX0ZMQUdT
LCBJU19USUdIVF9MT09QKTsKICAgICBjdHgtPnNob3J0X2NpcmN1aXQgPSBoZXhfY3B1LT5zaG9y
dF9jaXJjdWl0OworICAgIGN0eC0+aGV4X2RlZiA9IEhFWEFHT05fQ1BVX0dFVF9DTEFTUyhoZXhf
Y3B1KS0+aGV4X2RlZjsKIH0KIAogc3RhdGljIHZvaWQgaGV4YWdvbl90cl90Yl9zdGFydChEaXNh
c0NvbnRleHRCYXNlICpkYiwgQ1BVU3RhdGUgKmNwdSkKLS0gCjIuMzQuMQoK

