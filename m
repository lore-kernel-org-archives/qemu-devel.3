Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA951D35173
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xV1-0001R0-CC; Wed, 01 Apr 2026 11:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUf-00011A-33
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUd-00086H-82
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:32 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631CPvYF1285902
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L60dLV4ixSII0grXEbX4YAePTbGtmAiQiJLENJcnCBA=; b=XNlZnaXyrSLWpHoP
 2eMEecQTW6zcYi+AFy//2IYpAu/V2DlFhu5T/jS+6IiefOKyEJ5rHuayXsCcpvY6
 eqmAgNDNCL257PbgoCXAjto4SrhiH1QY5vMd8yk+xKP0yRlbp1imdVDIVoeH2ccy
 9V0+o89+oWxUrMD/ZgtNsSVoKuMZPgTRETvjqHMZ0mDsLKgsqBWDFlNSaRV2EoxN
 AM5CYN/lwfVbpryz9tcmsfOQe1pi8YGAdimxE9hn6jN4elCSCZlYn8/z60g2oi2Y
 26Wo7USgrIPJS+HCMe/TZFH9pJQhyyxUlz3f81xb6xYnJuY110lUSuH25JO5EDuG
 l+ukGg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xm3t2yx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:18 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c895e7de52so8299432eec.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057296; x=1775662096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L60dLV4ixSII0grXEbX4YAePTbGtmAiQiJLENJcnCBA=;
 b=ffUR9ZdQL58Pq1oE/ql2od3APdsb2a7epQTNpcIDR6DbNBOnmOhWwocJxwynrAbROV
 iF7FbUHXLYJSvScbMc0thNZ/IPwHLjM8KUuAPdI8PE4Lh2Dlj+mHgzFegaQ8K2ZCWfTp
 hi8/Pgy0iIeJVGL5YAigSugMg/l+GZYbyLFo+jw+cXAmP2tR38Tj1jDGSlPE+XkEWAQt
 qdhb/1Alp49KJ6Hp+mRV8txBNQUS7Bh9NsLDPmpuW0OSs/3dYAPFtxmFAM6ny5mGx69Y
 C+s/kcohX4mLJOHlmA54SNcG724TXBxILGsWMhyrgUr3WpjgTe74E828MVpo5k96z60W
 h+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057296; x=1775662096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L60dLV4ixSII0grXEbX4YAePTbGtmAiQiJLENJcnCBA=;
 b=Ft8A+50LFlDdAQ5C+22V6KcYN79kl/fA68PLAODRxAXy9z1nPYmq9QGg3A4I2T7M2F
 0scDOyv8xVYWhi0y0vTxfFjXlSPhHHwhkKOcVsOsfC6BMWbQQsGSaW9CgWzIE3nSwGX/
 Jvrge76DZM3mvsGw7ZaMapdruLdRS8RwFJ90z/4xGk2N3wzYot6EU9VTGrwyGfUB9vvK
 RVAahLe567+/6SaAz02yZ3xgJGSJJdBIIl+5SCYQh9D7fApeTpe89CsF1m75vodVCWIK
 tjwb0HEjCYyDhF9o+KDbAPdzLZnBO0WURCsEOIPQ+U93m3+WyZDGJAn1i5iRKNW7AcBr
 qJDQ==
X-Gm-Message-State: AOJu0YzGnIAAojjhwdR0YQg+SzjyFtYJ99J+nNSg6GlbjDmpfZgRZs3M
 1YrdKUjHtx5MMSi+J/wV23MDIQpoJIUd8di2TdsgFyCVrc2nWfLQ30hEGs48AjOBuVSC09BKpCu
 dd6JG/qnen6QGwGMQdx53lXTHTiWkkI8EezG24Rlv/7Sv+bu1axFfK7DfdLP8sYdLQg==
X-Gm-Gg: ATEYQzz+nmZnUTi0k9fIO2vMXq5/WWI1U+H0TMFR9Ggmw8UpQJvrc3aQPbyTVzquNax
 G7CypLv2tHhyLYF4n0RyqiTvlYEFRQHGRzFqXOwXzMgXxsY8z42K2OIWLGKjxB5+RKb4r3UnSrT
 HD/g3+Bmgy2vvU6B0XVQNvE/0HbI3sJF1lnwnIAs9V/cpZHQZbonbvD5Phoyaz6coJ8FnlxPPlh
 GdUszlzhxZGkAZsJp2qTNWO0UWwocRyt3xb5z03GWBJTF6Q4v7rKB0SfuER07COZ1V78UtE80rX
 IrH1BaeFhwrnhf0spB1MLp61OQt2Gd/bcUps5Tg6vDlKuJhsCPfLCHddvYoXtvS2YFjWuBEGoFv
 wW9hHGtd7x7GZEnBot7pHHfYuIw/oH9xbhHELtnIQgrI7v0sNKozdnqinAebqZ7WoKu3qag==
X-Received: by 2002:a05:7300:2213:b0:2c0:becb:7640 with SMTP id
 5a478bee46e88-2c931276dd6mr2370223eec.12.1775057295696; 
 Wed, 01 Apr 2026 08:28:15 -0700 (PDT)
X-Received: by 2002:a05:7300:2213:b0:2c0:becb:7640 with SMTP id
 5a478bee46e88-2c931276dd6mr2370180eec.12.1775057295050; 
 Wed, 01 Apr 2026 08:28:15 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:28:14 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 33/37] target/hexagon: Add cpu modes, mmu indices,
 next_PC to state
Date: Wed,  1 Apr 2026 08:26:53 -0700
Message-Id: <20260401152657.314902-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=L90QguT8 c=1 sm=1 tr=0 ts=69cd3993 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=6d93uPKVDIcG5a3x7xMA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: mDypj5CHby_TOuTeCsonhC1xLc7VgEGr
X-Proofpoint-GUID: mDypj5CHby_TOuTeCsonhC1xLc7VgEGr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfX/OvDjJOA3NIQ
 C2p+yPIqgBYTdmNlrAXJgFiPgg56WpRwZMr4iDnqwCrAZ8ncUjeoKaUUepVaLduhn7uGbw45Rer
 RE28qVI3q7Hr1K+3pWjTK7I6tkDv1JDK+hcY1+1A8l/5dHhd6yTAcRlJtI6lUlADlpW+x213WrG
 kJ83PezOYddMIm2bqag2MolCucYfZWVbizn+oud0kJyqSIYb5l1ODnmhP8R3McntGwQR/jPnWEf
 E2S/nssk8w0l/XTGRlbB3WlgvGGyREJUuLXQneRbz61oLcrT5Mzr9jVz5jIG2KO0zp9i/i8KbNh
 WmYrIg7DywbTDQnRy4G8VKmEgf1/znH9FyRmokoJq9zTHp9vrkCjYxQ5wz5hpebmWFVijjZ6VEr
 Cahmfr+0/mYEVr0b9XZ+ggzJD+CpkZ+Y3/RA+DXu9KiB787ODJeH837oYyzu/ZTFtHWAjv/bXZL
 QbAUrdH4C3UARh6ywbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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
dS5oIHwgMjEgKysrKysrKysrKysrKysrKysrKystCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyB8ICAx
ICsKIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5k
ZXggZDNiN2IzNDY4NDEuLmQzMzYxOTM2ZDA0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9j
cHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtNDgsOCArNDgsMjYgQEAKICNkZWZp
bmUgVlNUT1JFU19NQVggMgogCiAjZGVmaW5lIENQVV9SRVNPTFZJTkdfVFlQRSBUWVBFX0hFWEFH
T05fQ1BVCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyNkZWZpbmUgQ1BVX0lOVEVSUlVQVF9T
V0kgICAgICBDUFVfSU5URVJSVVBUX1RHVF9JTlRfMAorCisjZGVmaW5lIEhFWF9DUFVfTU9ERV9V
U0VSICAgIDEKKyNkZWZpbmUgSEVYX0NQVV9NT0RFX0dVRVNUICAgMgorI2RlZmluZSBIRVhfQ1BV
X01PREVfTU9OSVRPUiAzCisKKyNkZWZpbmUgSEVYX0VYRV9NT0RFX09GRiAgICAgMQorI2RlZmlu
ZSBIRVhfRVhFX01PREVfUlVOICAgICAyCisjZGVmaW5lIEhFWF9FWEVfTU9ERV9XQUlUICAgIDMK
KyNkZWZpbmUgSEVYX0VYRV9NT0RFX0RFQlVHICAgNAorI2VuZGlmCisKKyNkZWZpbmUgTU1VX1VT
RVJfSURYICAgICAgICAgMAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisjZGVmaW5lIE1NVV9H
VUVTVF9JRFggICAgICAgIDEKKyNkZWZpbmUgTU1VX0tFUk5FTF9JRFggICAgICAgMgorCisjZW5k
aWYKIAotI2RlZmluZSBNTVVfVVNFUl9JRFggMAogCiAjZGVmaW5lIEhFWEFHT05fQ1BVX0lSUV8w
IDAKICNkZWZpbmUgSEVYQUdPTl9DUFVfSVJRXzEgMQpAQCAtMTExLDYgKzEyOSw3IEBAIHR5cGVk
ZWYgc3RydWN0IENQVUFyY2hTdGF0ZSB7CiAgICAgdWludDMyX3QgdGhyZWFkSWQ7CiAgICAgdWlu
dDY0X3QgdF9jeWNsZV9jb3VudDsKICNlbmRpZgorICAgIHVpbnQzMl90IG5leHRfUEM7CiAgICAg
dGFyZ2V0X3Vsb25nIG5ld192YWx1ZV91c3I7CiAKICAgICBNZW1Mb2cgbWVtX2xvZ19zdG9yZXNb
U1RPUkVTX01BWF07CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCmluZGV4IDQ1YWM5YTNkMjRlLi5hYjViZmIwZWQwZSAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTMxNCw2
ICszMTQsNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2Jq
LCBSZXNldFR5cGUgdHlwZSkKICAgICBtZW1zZXQoZW52LT50X3NyZWcsIDAsIHNpemVvZih1aW50
MzJfdCkgKiBOVU1fU1JFR1MpOwogICAgIG1lbXNldChlbnYtPmdyZWcsIDAsIHNpemVvZih1aW50
MzJfdCkgKiBOVU1fR1JFR1MpOwogICAgIGVudi0+d2FpdF9uZXh0X3BjID0gMDsKKyAgICBlbnYt
Pm5leHRfUEMgPSAwOwogI2VuZGlmCiAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVYX0VWRU5UX05P
TkU7CiB9Ci0tIAoyLjM0LjEKCg==

