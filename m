Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BA3C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vAU-0006wB-3s; Thu, 24 Sep 2026 21:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9vAP-0006fM-TP
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:56:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9vAN-0006DA-FK
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:56:01 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1kuLw313729
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1+c5p2DNpW3gh7YJshe70CCBg57AgTA41pESt5e/Ez4=; b=WvfrQvd5gOGRTEFL
 p+m+ZoIG6TrmVKXBOQ7aR3pHz403Vco94HyeuwJ36JR8GCyu9CDA3qQG9RNd+RxK
 OkEuAaoiuEcyH9vKV/OPWYC/Ov1qYqcA1iKEpscufm1jo8qmsWF3Jvrn/TuZjEqF
 SCCYsqqh4phm0Xztm6CxX0bbI/6Ezn2RwupNVadSk1TEB/Uy1Li0LF5cMF0DuqfC
 plqui4QemcGpL4J4WxDqa2PsH2eHYPUmr+QHBPk66ooq6iCey0Q+GhEkXEomyIuy
 Sf7SZdbmF60kSEAgr82T51Vn6p/rPVqO5k+v5t7rroN1kxCn79fwrpVDekkoX+qO
 loeAGw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1s93dbv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:48 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso554753eec.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301347; x=1790906147; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1+c5p2DNpW3gh7YJshe70CCBg57AgTA41pESt5e/Ez4=;
 b=UNTWTaPQaU9XHoL44IDZgRSPSqFupTT1VTEpwRmBtaaVf5t8c7AAQMy2DgAnYpMWm2
 7YfSFCP7frZW3Tj0VtYbd5Nu/AdlK/wGj88tJ5q5NdM116y5NIR0JgUv32fEX+SNA+0p
 95YioLMgwnhE8ivCxhcr59RX7C6tNUFJLZVFFbK0YzsIXbIpGLmBLQBnpMBe4a/OQUMi
 gOywK1BBLFYwMpcBe6eLAXGlfaCPd1X1gbzrVgk3CNxLRg9dxwQaMwsj/o4Ql4jZyzC0
 QKV2ouxSIXgqlKmyLim1fX4imgrbjpz42iJTnXwaX8kUZhYp4v01y5hiPVQ736a7wieR
 2BJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301347; x=1790906147;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1+c5p2DNpW3gh7YJshe70CCBg57AgTA41pESt5e/Ez4=;
 b=MOuq1PtQ2bJOelk5OkoG2pnv76KJE7tJ6cj575dRckRlTupNcQpue2hwGNpKq5nCzw
 ellHCLQGSqU+ia2xSc4TFKjmsLhi7xgGu+SZyH7IvL4Sj+g6TOyGGcgVoeeAh0j0gi+L
 WL9HXl87xq+XhPszELOo53Mf2MKiTc0bSRvKAw0pOuTVpDa50vC625hNFE4tuGfOwYqS
 ZZTr0mHmw+0VjIlTnRbdk6bE4Ji0WeZaAJVCjNqVI3VZeVl2bnKSfxmtN77+ltRdkdMI
 eQh57+msxAaSK7xHo2WI5oDoLnK2azSKr35RR4xypKJTqecfapux1vbJKalIRFXBgZYA
 wg2w==
X-Gm-Message-State: AFuF++lJvnWk79s8uLhY1eG9ygPj/SXTcNC1G45KNql2DEeQr9pKCyf+
 LNp/Xr4rbZfCdRhe6ENHAcxo3TrJW5v6NmI1sEvoAHO5V210h5Z3tkvmnLeGnnnFMX138sqq4Va
 E1rwqQ/HNkvcccJrfkZLQYaD5P2Z8aFOXP1QgtVmqGToKmTuYL8XJTs4wvXCwVJuYdA==
X-Gm-Gg: AYBFou1ZpOE/tYJlh/GSCQKeBDZDxFzHGNRAYMPxLGprI2JbN5zaxnU0xiDPDZv2mlo
 pdkAIXGuLXSv12vgw5akcTCHQn9v19Ftcx/0OgdUqpWORFpIBiAuCx5XO3pp3dV8UHkiA5mhodN
 gYD8mtpSv1DoDkJyavHpl6p0KY3QgwT0I3S8uMzWQdDayD4DtFMhTftnUCgS62+ByJWM+coiLkE
 nJ55d5KOcL5+TlKkXvzpTumKWEFgVnaX77ueN+w3YBEGERPJiWYnUK/9D06bffYqx4ra7kSAevV
 oDtUJfvmx15+hdejkVFxSLwCvrZXRQoDxOYW6W61Alspet+AHyvnOSHPNmDcPkh9AqtIOT0ghzB
 GLoxmJ1UiyJHonYLbaAWo3Zfsk6cMzHPTyOOR9N9IHOyfmq4=
X-Received: by 2002:a05:7300:3c27:b0:339:85bf:dd89 with SMTP id
 5a478bee46e88-3400122d9f3mr4905468eec.35.1790301347066; 
 Thu, 24 Sep 2026 18:55:47 -0700 (PDT)
X-Received: by 2002:a05:7300:3c27:b0:339:85bf:dd89 with SMTP id
 5a478bee46e88-3400122d9f3mr4905443eec.35.1790301346443; 
 Thu, 24 Sep 2026 18:55:46 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:55:45 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 39/40] tests/tcg/hexagon: check the two HVX predicate build
 paths agree
Date: Thu, 24 Sep 2026 18:54:28 -0700
Message-Id: <20260925015429.2579174-40-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX//P4mpuWfBQu
 eayMBjsMyDW6S2cdlJtS77BFPO4h+560cLwVLIxkVG23PwgO4fYMH1iCo1cHRsAZ5opaV7ONvod
 +dX8kOQRDqwufBseZ6Hp6p/4cjLoEjV7mN1CoYeoGGUQO9X7qCI+sVA6jyU09F4yvI731o+NX5M
 eO+UPBOs+pMqM3uXWRZk0jR52hKrvvOhflqjq5NziGAYMP+9zIXdCEbRjRVmecwDw5ZAE3ju6/T
 hgyvZR7TyKTu0A5Tjf7Si31CL+F7/Mo5fjQC3NkawBurfCMzsrH6NdbQIfQTK9bY4IlfyanZND+
 c5xe4WeYtYkuFcWDbvJa9A1PQPWo7WaoIy2L2/kTzLhEEjnbtsOWBUvLCTJepg/jvTG8W54UXA6
 bMsPt0HijWRyo7PLGjBF09H6prq2cWwJ33ndboEz3G0ylljQnX55XVKGuOh19wkNmRc33C+Jc7o
 9niieCyDRuQp0479ITw==
X-Authority-Analysis: v=2.4 cv=VPxIDNPX c=1 sm=1 tr=0 ts=6ab5d4a4 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=jjHI2IJ3bfbFesgfRcwA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX9mEc9kdOb6r8
 xM6xaZUnIlpe6VlsxI4iuXRUGopQgi/VUfx+2ZVcerJhd8NSW5Ocj6I4u5Pi472mxKwFO7/64sn
 kCH1UonvYLR2ubZfBScvgVWyxcWQBdY=
X-Proofpoint-ORIG-GUID: mfEslH-64UEhIGErsdZknE-s3370T6Is
X-Proofpoint-GUID: mfEslH-64UEhIGErsdZknE-s3370T6Is
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250007
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

QSBRIHJlZyBjYW4gYmUgYnVpbHQgYnkgYSB2ZWN0b3IgY29tcGFyZSBvciBieSB2YW5kKFZ1LCBS
dCksIGFuZAp0aG9zZSByZWFjaCB0aGUgcHJlZGljYXRlIHJlZ2lzdGVyIHRocm91Z2ggaW5kZXBl
bmRlbnQgY29kZSBwYXRocy4gQ2hlY2sKdGhhdCBib3RoIHNlbGVjdCB0aGUgc2FtZSBieXRlIGxh
bmVzLCBzbyBhIGJ5dGUtb3JkZXIgbWlzdGFrZSBpbiBlaXRoZXIKb25lIGlzIGNhdWdodC4KClRo
ZSBpbnB1dCBhbHRlcm5hdGVzIGV2ZXJ5IGVpZ2h0IGxhbmVzOiBhIGZsYXR0ZXIgcGF0dGVybgpz
dGF5cyB1bmNoYW5nZWQgd2hlbiBwcmVkaWNhdGUgYnl0ZXMgYXJlIHBlcm11dGVkIGFuZCBoaWRl
cyB0aGUgYnVnLgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZp
ZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2Fp
bkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMgfCA0
NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA0
NSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2Mu
YyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMKaW5kZXggMDI4NTg4NmMyYTUuLjQyNWJh
ZWU3YTMwIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jCisrKyBiL3Rl
c3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMKQEAgLTE4MSw2ICsxODEsNTAgQEAgc3RhdGljIHZv
aWQgdGVzdF9zdG9yZV91bmFsaWduZWQodm9pZCkKICAgICBjaGVja19vdXRwdXRfdyhfX0xJTkVf
XywgMik7CiB9CiAKKy8qCisgKiBBIFEgcmVnaXN0ZXIgY2FuIGJlIGJ1aWx0IGVpdGhlciBieSBh
IHZlY3RvciBjb21wYXJlIG9yIGJ5IHZhbmQoVnUsIFJ0KS4KKyAqIFRob3NlIGFyZSB0d28gaW5k
ZXBlbmRlbnQgY29kZSBwYXRocyBvbnRvIHRoZSBzYW1lIHByZWRpY2F0ZS1yZWdpc3RlcgorICog
bGF5b3V0LCBzbyBjcm9zcy1jaGVjayB0aGF0IHRoZXkgc2VsZWN0IGV4YWN0bHkgdGhlIHNhbWUg
Ynl0ZSBsYW5lcy4KKyAqIEEgYnl0ZS1vcmRlciBtaXN0YWtlIGluIGVpdGhlciBvbmUgc2hvd3Mg
dXAgaGVyZSBhcyBhIG1pc21hdGNoLgorICoKKyAqIFRoZSBpbnB1dCBwYXR0ZXJuIGhhcyB0byB2
YXJ5IGFjcm9zcyA4LWxhbmUgYmxvY2tzLCBvdGhlcndpc2UgYSBwcmVkaWNhdGUKKyAqIHdob3Nl
IGJ5dGVzIGFyZSBwZXJtdXRlZCBzdGlsbCBzZWxlY3RzIHRoZSBzYW1lIGxhbmVzIGFuZCB0aGUg
bWlzbWF0Y2ggaXMKKyAqIGludmlzaWJsZS4KKyAqLworc3RhdGljIHZvaWQgdGVzdF9xcmVnX2Fs
aWFzKHZvaWQpCit7CisgICAgSFZYX1ZlY3RvciAqcGNtcCA9IChIVlhfVmVjdG9yICopJm91dHB1
dFswXTsKKyAgICBIVlhfVmVjdG9yICpwYW5kID0gKEhWWF9WZWN0b3IgKikmb3V0cHV0WzFdOwor
ICAgIEhWWF9WZWN0b3IgaW5wdXQ7CisgICAgSFZYX1ZlY3RvciBvbmVzOworICAgIEhWWF9WZWN0
b3JQcmVkIHFjbXA7CisgICAgSFZYX1ZlY3RvclByZWQgcWFuZDsKKworICAgIGZvciAoaW50IGkg
PSAwOyBpIDwgQlVGU0laRTsgaSsrKSB7CisgICAgICAgIC8qCisgICAgICAgICAqIEJ1aWxkIDAv
MSBwZXIgYnl0ZSwgYWx0ZXJuYXRpbmcgZXZlcnkgOCBsYW5lcywgc28gdGhhdCAiIT0gMCIgYW5k
CisgICAgICAgICAqICJsb3cgYml0IHNldCIgZGVzY3JpYmUgdGhlIHNhbWUgbGFuZXMuICBUaGVu
IGZvcm0gb25lIHByZWRpY2F0ZQorICAgICAgICAgKiB3aXRoIGEgY29tcGFyZSBhbmQgdGhlIG90
aGVyIHdpdGggdmFuZChWdSwgUnQpLCBzdG9yZSAweGZmIHRocm91Z2gKKyAgICAgICAgICogZWFj
aCwgYW5kIHJlcXVpcmUgdGhlIHR3byByZXN1bHQgdmVjdG9ycyB0byBiZSBpZGVudGljYWwuCisg
ICAgICAgICAqLworICAgICAgICBmb3IgKGludCBqID0gMDsgaiA8IE1BWF9WRUNfU0laRV9CWVRF
UzsgaisrKSB7CisgICAgICAgICAgICBleHBlY3RbMF0udWJbal0gPSAoKGogPj4gMykgKyBpKSAm
IDE7CisgICAgICAgIH0KKyAgICAgICAgbWVtY3B5KCZpbnB1dCwgJmV4cGVjdFswXSwgc2l6ZW9m
KE1NVmVjdG9yKSk7CisgICAgICAgIG1lbXNldChvdXRwdXQsIDAsIDIgKiBzaXplb2YoTU1WZWN0
b3IpKTsKKworICAgICAgICBvbmVzID0gUTZfVl92c3BsYXRfUigweGZmZmZmZmZmKTsKKyAgICAg
ICAgcWNtcCA9IFE2X1FfdmNtcF9ndF9WdWJWdWIoaW5wdXQsIFE2X1Zfdnplcm8oKSk7CisgICAg
ICAgIHFhbmQgPSBRNl9RX3ZhbmRfVlIoaW5wdXQsIDB4MDEwMTAxMDEpOworICAgICAgICBRNl92
bWVtX1FSSVYocWNtcCwgcGNtcCwgb25lcyk7CisgICAgICAgIFE2X3ZtZW1fUVJJVihxYW5kLCBw
YW5kLCBvbmVzKTsKKworICAgICAgICBmb3IgKGludCBqID0gMDsgaiA8IE1BWF9WRUNfU0laRV9C
WVRFUzsgaisrKSB7CisgICAgICAgICAgICBjaGVjayhfX0xJTkVfXywgaSwgaiwgb3V0cHV0WzBd
LnViW2pdLCBvdXRwdXRbMV0udWJbal0pOworICAgICAgICB9CisgICAgfQorfQorCiBzdGF0aWMg
dm9pZCB0ZXN0X21hc2tlZF9zdG9yZShib29sIGludmVydCkKIHsKICAgICB2b2lkICpwMCA9IGJ1
ZmZlcjA7CkBAIC02NDIsNiArNjg2LDcgQEAgaW50IG1haW4oKQogICAgIHRlc3Rfc3RvcmVfdW5h
bGlnbmVkKCk7CiAgICAgdGVzdF9tYXNrZWRfc3RvcmUoZmFsc2UpOwogICAgIHRlc3RfbWFza2Vk
X3N0b3JlKHRydWUpOworICAgIHRlc3RfcXJlZ19hbGlhcygpOwogICAgIHRlc3RfbmV3X3ZhbHVl
X3N0b3JlKCk7CiAgICAgdGVzdF9tYXhfdGVtcHMoKTsKIAotLSAKMi4zNC4xCgo=

