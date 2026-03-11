Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FA9FD88F5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsM-0000uY-RJ; Wed, 11 Mar 2026 00:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0As9-0000oM-6h
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0As5-0008WF-SR
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:36 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B39gW41572990
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=1NRxbNElb3YTwRj2MfizMd4226hPdr1cJa1WEZAGp/0=; b=j0
 OHrHQvZa+10yNbJsgddXdnZlD8YuY6id9xkpQX41XQEXaHjU7HixcKhfxPfgPwZp
 0oXGP6YrEJCmJBad3oqlquoydJAYGO4k6tDVK7aJfuIt45uYP3IR1yt3Qw4Xqj2x
 CUHxd0+rn3ZyZH1qM5sHkIhYyZdI7XeWS5n352JhdRkWHP6zZ6avLg6qsZf8E0or
 l4ZWWCOXKKlqR1jcNSWY8/Im9Z0WeWDLK2qIPSd2sEazNuyBeOkLGk/YEsjEIO9j
 LYe3EWz9kaPVKmsfVOZ0L1oeKwHivKa+Ir6H8ySUuL0pvjGiW+XANasNp9Xp7G3w
 W9kFmn7THUUk6xgi7sQQ==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqgk9v3e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:32 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-41702ea8343so19797738fac.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202111; x=1773806911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1NRxbNElb3YTwRj2MfizMd4226hPdr1cJa1WEZAGp/0=;
 b=SgRdN9iWPM8kz1IMcaE9dWcqwZWTF/u9MNYJaEJHEvY7cg3csPH97Bw4I2CVE2fDwK
 JbC3pSPuT/02YwFXQ6CgsCMIJg7zd0Dc7f69nhGDyxH5lXYPcTnf4yEnKOP2yfufQX5R
 zWm9YpNsiXHccqZtx4SxZedqeaR2VT5PB61DVCl3EEGB5N4hxlKr6WZujdCPh4YONBGV
 I830dP9MxBk+As+znpfVo1n2ZUBQS2cIZPPDuH0QV94qvbEyaaCOr3hIwumdnSO7X8fF
 uIDmAOHr/7s8GPaeHyb+jkExsiNWYNUyEZfQLNnvsUMRFCQzCbhN20b5pYDmX44jqP/s
 8AgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202111; x=1773806911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1NRxbNElb3YTwRj2MfizMd4226hPdr1cJa1WEZAGp/0=;
 b=BkJq4QvkVBBMZx1GbwQlLg2ArzmXNNSqhOw/dhrAgmfq5JCPdmhPv3BbcF1aRkRoIR
 3NSslYij415qCQ+bh1zI1rSZQgYlBazHiaOc3GqjTSSI0crpq7Mg36YURBsOXTO2qdTX
 +90qekJsCXnZo+AcXcaUYZRJodpOwAxE+9jyTzizn2PY1kjaB5M5svCn3NTJfzr9VnQu
 d+vGTWMGXoM+6vauzsD05xYWM92QsFGH9RKFD8Lk/ashLbUZvApa7TqUfY85DOIzjxiG
 1xcKC+1PzHy7pMXPAkbIpIBFK11ZUTLL5ghqvFvl2FRSt6pou2+JbAvgDalxw+XNx+5A
 1CWQ==
X-Gm-Message-State: AOJu0Yzgbr+DD4Sk4IygqYIMPA++aVG0NDf9ctBkQ7uiodHPZ1xCVF1b
 lnTYZC4E/3XZaBSbwAWc4AtHIFNg/gdIdJnY6T5cqOvG+j3SH2VkWNW+Peb6geAk2uPavaL69la
 QJPMvIVcojUYIzRnRVdH4UAgRzD0FpluKXsBomdU4cbIxu9qCBElzFPmjCLv0PLd10A==
X-Gm-Gg: ATEYQzzN6j+yuCqxLGle3ybiXiW6XQDtMT6ktFnD0Wz+ODxTxpBdEUUw7bNF+sO2mBn
 v3dOhTH1Cx4/KlJ7Cg0V7VuMMuWbPiidHn726NRMkK8Y5m6VOk2ca4NQSKCDnjuLWRsg/mQqgof
 3u6Px+VeY1PkpRG6109EKL3VCJ6QtWA9+ZsvULIhZn+sQk7tTGkxV6+Sv2MVwJXzVy57oN6lQDX
 LaS2oZ6YjqqA/RD4SDrMtdsbSc72TkWGRCFtyVNOBaLzCrVvw06B11Ni5yeNCRxox8S4vwe9V0e
 Yzj6WamDWv45nygCfs+oWU2D9o4nbbsbb931ZR6Az/L5vAROvjQVNzb11MVR8LALIBzG/Zm8dd6
 XGrMJRvjy7DrlAnWfTg6BCrcvGSLXOWmX+WO+tZmIG/JFzUgAtUcv3wxbifa8oVigeTwCRA==
X-Received: by 2002:a05:6870:ad0f:b0:3fa:47e:4de4 with SMTP id
 586e51a60fabf-4177c6a71dcmr935656fac.24.1773202111433; 
 Tue, 10 Mar 2026 21:08:31 -0700 (PDT)
X-Received: by 2002:a05:6870:ad0f:b0:3fa:47e:4de4 with SMTP id
 586e51a60fabf-4177c6a71dcmr935641fac.24.1773202111044; 
 Tue, 10 Mar 2026 21:08:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 18/32] target/hexagon: Implement setprio, resched
Date: Tue, 10 Mar 2026 21:07:44 -0700
Message-Id: <20260311040758.1068731-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 5HwytQkvcWyRtEAjt7Iq0R1j9_ffgwHR
X-Proofpoint-ORIG-GUID: 5HwytQkvcWyRtEAjt7Iq0R1j9_ffgwHR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfXz9gyRSPsxbZl
 FZCeIzcMKJr4sKwaYpX6JH0F1N2Zi6EWuYp+dGNaCi/aS1TN41o7G6Wvp56I/uJmHGNyk6nlunS
 u5D15ddHe3IhWxpb94HJ4aNCSAd+cHygSDXpZ6vWtgrmJa2+B6ugVC4LmAccybscm3pJjZHsef+
 hulkPWMmPwqBZi6l3OQ7qlgVMiB0dHogu0HQsPAtdYisIuxh274rR3yjenHiZgaov3y/w32iAqn
 QrVkwqAmkqLFDSGvRzaWtD8R6NHCp7TbHCbeWSC7LLFMBD0EOUpbdOhOwSBt0vGaR63yhRnnzhc
 vYGbEn7v8yXZ/+4CEMyLUHX1SNeouLq1TD8M4TCzdd4wCf7UYl4nwuGyhGKkwKWwFBokY6Ivx3e
 r1q+pAKe/8PLcRbTAbVf6MNwivGDV/py1IrkSGd4Z1kuSxuNsKztZTU/ly8IebvtPwKCwhV0XEs
 xMy5wDWaqKGVYnXFlWA==
X-Authority-Analysis: v=2.4 cv=M4JA6iws c=1 sm=1 tr=0 ts=69b0eac0 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=9hY_xzidxOicKg_qOOkA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgaGFyZHdhcmUtYXNzaXN0
ZWQgc2NoZWR1bGVyIGhlbHBzIG1hbmFnZSB0YXNrcyBvbiB0aGUgcnVuIHF1ZXVlCmFuZCBpbnRl
cnJ1cHQgc3RlZXJpbmcuCgpUaGlzIGluc3RydWN0aW9uIGlzIGRlZmluZWQgaW4gdGhlIFF1YWxj
b21tIEhleGFnb24gVjcxIFByb2dyYW1tZXIncyBSZWZlcmVuY2UKTWFudWFsIC0KaHR0cHM6Ly9k
b2NzLnF1YWxjb21tLmNvbS9idW5kbGUvcHVibGljcmVzb3VyY2UvODAtTjIwNDAtNTFfUkVWX0FC
X0hleGFnb25fVjcxX1Byb2dyYW1tZXJTX1JlZmVyZW5jZV9NYW51YWwucGRmClNlZSDCpzExLjku
MiBTWVNURU0gTU9OSVRPUi4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5A
b3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDc1ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNzUg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIv
dGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggOTA5MGE1YzIwYWIuLjM2ODIyMjE5YjRi
IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTU3NSw2ICsxNTc1LDYyIEBAIHN0YXRpYyB2b2lkIGhleGFn
b25fd2FpdF90aHJlYWQoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IFBDKQogICAgIGNw
dV9pbnRlcnJ1cHQoY3MsIENQVV9JTlRFUlJVUFRfSEFMVCk7CiB9CiAKK3N0YXRpYyBpbmxpbmUg
UUVNVV9BTFdBWVNfSU5MSU5FIHZvaWQgcmVzY2hlZChDUFVIZXhhZ29uU3RhdGUgKmVudikKK3sK
KyAgICB1aW50MzJfdCBzY2hlZGNmZzsKKyAgICB1aW50MzJfdCBzY2hlZGNmZ19lbjsKKyAgICBp
bnQgaW50X251bWJlcjsKKyAgICBDUFVTdGF0ZSAqY3M7CisgICAgdWludDMyX3QgbG93ZXN0X3Ro
X3ByaW8gPSAwOyAvKiAwIGlzIGhpZ2hlc3QgcHJpbyAqLworICAgIHVpbnQzMl90IGJlc3R3YWl0
X3JlZzsKKyAgICB1aW50MzJfdCBiZXN0X3ByaW87CisKKyAgICBCUUxfTE9DS19HVUFSRCgpOwor
ICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQsICIlczogY2hlY2sgcmVzY2hlZFxuIiwgX19m
dW5jX18pOworICAgIEhleGFnb25DUFUgKmNwdSA9IGVudl9hcmNoY3B1KGVudik7CisgICAgc2No
ZWRjZmcgPSBjcHUtPmdsb2JhbHJlZ3MgPworICAgICAgICBoZXhhZ29uX2dsb2JhbHJlZ19yZWFk
KGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdfU0NIRURDRkcsCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZW52LT50aHJlYWRJZCkgOiAwOworICAgIHNjaGVkY2ZnX2VuID0gR0VUX0ZJ
RUxEKFNDSEVEQ0ZHX0VOLCBzY2hlZGNmZyk7CisgICAgaW50X251bWJlciA9IEdFVF9GSUVMRChT
Q0hFRENGR19JTlROTywgc2NoZWRjZmcpOworCisgICAgaWYgKCFzY2hlZGNmZ19lbikgeworICAg
ICAgICByZXR1cm47CisgICAgfQorCisgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKKyAgICAgICAgSGV4
YWdvbkNQVSAqdGhyZWFkID0gSEVYQUdPTl9DUFUoY3MpOworICAgICAgICBDUFVIZXhhZ29uU3Rh
dGUgKnRocmVhZF9lbnYgPSAmKHRocmVhZC0+ZW52KTsKKyAgICAgICAgdWludDMyX3QgdGhfcHJp
byA9IEdFVF9GSUVMRCgKKyAgICAgICAgICAgIFNUSURfUFJJTywgdGhyZWFkX2Vudi0+dF9zcmVn
W0hFWF9TUkVHX1NUSURdKTsKKyAgICAgICAgaWYgKCFoZXhhZ29uX3RocmVhZF9pc19lbmFibGVk
KHRocmVhZF9lbnYpKSB7CisgICAgICAgICAgICBjb250aW51ZTsKKyAgICAgICAgfQorCisgICAg
ICAgIGxvd2VzdF90aF9wcmlvID0gKGxvd2VzdF90aF9wcmlvID4gdGhfcHJpbykKKyAgICAgICAg
ICAgID8gbG93ZXN0X3RoX3ByaW8KKyAgICAgICAgICAgIDogdGhfcHJpbzsKKyAgICB9CisKKyAg
ICBiZXN0d2FpdF9yZWcgPSBjcHUtPmdsb2JhbHJlZ3MgPworICAgICAgICBoZXhhZ29uX2dsb2Jh
bHJlZ19yZWFkKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdfQkVTVFdBSVQsCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCkgOiAwOworICAgIGJlc3RfcHJpbyA9
IEdFVF9GSUVMRChCRVNUV0FJVF9QUklPLCBiZXN0d2FpdF9yZWcpOworCisgICAgLyoKKyAgICAg
KiBJZiB0aGUgbG93ZXN0IHByaW9yaXR5IHRocmVhZCBpcyBsb3dlciBwcmlvcml0eSB0aGFuIHRo
ZQorICAgICAqIHZhbHVlIGluIHRoZSBCRVNUV0FJVCByZWdpc3Rlciwgd2UgbXVzdCByYWlzZSB0
aGUgcmVzY2hlZHVsZQorICAgICAqIGludGVycnVwdCBvbiB0aGUgbG93ZXN0IHByaW9yaXR5IHRo
cmVhZC4KKyAgICAgKi8KKyAgICBpZiAobG93ZXN0X3RoX3ByaW8gPiBiZXN0X3ByaW8pIHsKKyAg
ICAgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwKKyAgICAgICAgICAgICAgICAiJXM6IHJh
aXNpbmcgcmVzY2hlZCBpbnQgJWQsIGN1ciBQQyAweCIgVEFSR0VUX0ZNVF9seCAiXG4iLAorICAg
ICAgICAgICAgICAgIF9fZnVuY19fLCBpbnRfbnVtYmVyLCBlbnYtPmdwcltIRVhfUkVHX1BDXSk7
CisgICAgICAgIFNFVF9TWVNURU1fRklFTEQoZW52LCBIRVhfU1JFR19CRVNUV0FJVCwgQkVTVFdB
SVRfUFJJTywgfjApOworICAgICAgICBoZXhfcmFpc2VfaW50ZXJydXB0cyhlbnYsIDEgPDwgaW50
X251bWJlciwgQ1BVX0lOVEVSUlVQVF9TV0kpOworICAgIH0KK30KKwogdm9pZCBIRUxQRVIod2Fp
dCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IFBDKQogewogICAgIEJRTF9MT0NLX0dV
QVJEKCk7CkBAIC0xNjgwLDggKzE3MzYsMjcgQEAgdWludDY0X3QgSEVMUEVSKGdyZWdfcmVhZF9w
YWlyKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnKQogICAgIGdfYXNzZXJ0X25v
dF9yZWFjaGVkKCk7CiB9CiAKKy8qCisgKiBzZXRwcmlvL3Jlc2NoZWQgLSBTZWUgdGhlIEhleGFn
b24gVjczIFByb2dyYW1tZXIncyBSZWZlcmVuY2UgTWFudWFsLAorICogU2VjdGlvbiA2LjQgIklu
dGVycnVwdCBhbmQgVGhyZWFkIFNjaGVkdWxpbmciCisgKi8KIHZvaWQgSEVMUEVSKHNldHByaW8p
KENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCB0aHJlYWQsIHVpbnQzMl90IHByaW8pCiB7
CisgICAgQ1BVU3RhdGUgKmNzOworCisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAgICBDUFVfRk9S
RUFDSChjcykgeworICAgICAgICBIZXhhZ29uQ1BVICpmb3VuZF9jcHUgPSBIRVhBR09OX0NQVShj
cyk7CisgICAgICAgIENQVUhleGFnb25TdGF0ZSAqZm91bmRfZW52ID0gJmZvdW5kX2NwdS0+ZW52
OworICAgICAgICBpZiAodGhyZWFkID09IGZvdW5kX2Vudi0+dGhyZWFkSWQpIHsKKyAgICAgICAg
ICAgIFNFVF9TWVNURU1fRklFTEQoZm91bmRfZW52LCBIRVhfU1JFR19TVElELCBTVElEX1BSSU8s
IHByaW8pOworICAgICAgICAgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgIiVzOiB0aWQgIiBUQVJHRVRfRk1UX2x4ICIgcHJpbyA9IDB4JXhc
biIsCisgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBmb3VuZF9lbnYtPnRocmVh
ZElkLCBwcmlvKTsKKyAgICAgICAgICAgIHJlc2NoZWQoZW52KTsKKyAgICAgICAgICAgIHJldHVy
bjsKKyAgICAgICAgfQorICAgIH0KICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwogfQogCi0t
IAoyLjM0LjEKCg==

