Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D808210F996C
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXsr-0001Iw-Oo; Wed, 08 Apr 2026 14:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAXsb-00011u-OV
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:43:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKPE-0005aq-Gd
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:52 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63838X812411822
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F0cep0TaF14MbTHyoNohBMjmTyEDCIMV2M5fWWT0+KQ=; b=Tn43e5wbMYYIsHuN
 Dnc3/2SieSquwm5eY/3oXAKMEKcPEduUXsz7fVzN+qfR81TDgzXVrO6kYYZtUxT6
 RBS+t8QrDHPvy6ugDg3YRB/ViLhWhsXBNKy4otynYvyDOQktu/foBhzXoa/eOWWG
 KG1Rl6eRGSZes5bdxtsbDLTDf5EyCz0icw3aVd2KOa7EZ2dZQwjwxy9j2UBKod1a
 ADo1DXHZY46Ash6qwTV0oaE9kNAAItOleotcWx7A7nkpethoO5sOmpm80hCSs20/
 6Z67MSdCqnCOnqXECsL0WFC78/TiV3hT+s0fBNmSp3XhN2lJ1BA8iiBrxxiSveRw
 CuAV9Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd61v9x65-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:22 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12c21dbc9c1so1092771c88.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622022; x=1776226822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F0cep0TaF14MbTHyoNohBMjmTyEDCIMV2M5fWWT0+KQ=;
 b=Xy16bFaDSnaHifbJfzrNltiShb27IIrCXIDpPBSwP6TzvVDkSgLd/3fwc5phyy2wBa
 1bL0yJum++J5O+8Tcb+w8/rfjAHavQP8YfhY6fS+WIp1rA4GsX8IR1ympaMuiUwtgHtB
 zd3feN9YA4YY9fUbtF3s2uBk+u3M1rpiJPXwRt2zPoDswoOya7jXJ+EaAQcTV4tNpLAx
 VufqNMUu3oldpacn0ZGtIxf/aY5xSHtX1YWCMm6iTmWeL8Z7UsouFbpVVBnHZ95A+J5U
 vu/HW55ShyVBM2VzDLCNOULNvrhusdp6EgYq/Vfc+2xxkkjKlqk1bI4Y63jfIRVgMvh1
 jPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622022; x=1776226822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F0cep0TaF14MbTHyoNohBMjmTyEDCIMV2M5fWWT0+KQ=;
 b=OXO8md/a8E6ZUo7asa5mVmW9hGhf6J7ghAtwJJaik++LJIDaVUPOw9dxN15kkKDFv1
 caif2TNeJLB9CwEQWrFR8xqmpigGq6D/q0CpInZu+6TeOCdhRMc4dLILPjBk6lcN1UNw
 IEKnR2xW+fOk2IxNtGAKOaZzJXKKBz6VOvXxc3BJ/87y05zaES79BjpmZtyo6kvWNsuS
 5IfRAvAUkUDBnGFu6GRkNleLpdsIs43j5nv10mB0Za/b7NVt8g8eqmiYq+hzPBJQMe4+
 88wWWvwWrFKuTVXWtb1uwFgMF40fis+xuWGg6MOH5FTqsMM2hYA5e9SMcEetqNY6PItH
 6jCQ==
X-Gm-Message-State: AOJu0YzyiEcsPV70eQqBpCIg4XNNnFL6S9jE0VebTeXDJ34FE8Io4+Fm
 wMDJnU5aZl6iYIHSISKxBuVJu8IywBkYcmAD4HOXoY73GeIcBy8QlFxZCfwWT8q4nS3MwGvjutu
 qciteiBmJHmoVGWdkxYhX4wlSVxohPyAmB004IyN0W26bxgXz4o40fWfdmq24W0eOAg==
X-Gm-Gg: AeBDiesXh34Dgvxwsa0TEuFFdsY7NFcSszf3ejGzXAETCOAWtkaYlfbeIdcRWraaBZ0
 VD5KOhSi867EB3J/9h3nTH6bKhWhCEKHBgKo/kl5ioOqW3fFgvz0/nld5UTvN5d4m1slT4St5Bc
 KdzrwpjZDXce4cPrkhUjnqA0T16RwDg1pW4yGZ+p3fYM606td1IzS6/iWpoFYUVrhT1i5pBEX63
 RAQeEBg05k5lCMUTI/HfUMe6B0YGw8+VDufsDRebHe+17SlUs4Mwmc49C42pvGdKVfq1TWtY6Zd
 sMWbmhRfQ9ZbVwSK0PgroO2KFLPaABNsg2b4/sEbuqCc5L5i7f8PmzqD6YP/TLYzhsC3qCufu3Q
 UHFQNiU3SwabCqsUAwhmJpOKebvSqwM/ckw5PO56Q72c82/pJ94UtAzy6uVBMVQt7NxhaRg==
X-Received: by 2002:a05:7022:45a6:b0:124:9dea:188d with SMTP id
 a92af1059eb24-12bfb7670d0mr11370595c88.30.1775622021906; 
 Tue, 07 Apr 2026 21:20:21 -0700 (PDT)
X-Received: by 2002:a05:7022:45a6:b0:124:9dea:188d with SMTP id
 a92af1059eb24-12bfb7670d0mr11370572c88.30.1775622021301; 
 Tue, 07 Apr 2026 21:20:21 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:20 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 13/28] target/hexagon: Implement siad inst
Date: Tue,  7 Apr 2026 21:19:38 -0700
Message-Id: <20260408041953.1899532-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX87ABw9H0OyZg
 wo4OSxMYb4QzJcP5+Is17RBp46ndOeefdQqYEZlX18AimKi7MKkzF1BqMOThk9s+LvpgQRRodCb
 ScSKKiDQgz4C+iEJ3FCvCmT9LOvx9LDEKAU1ekn/VOkvOxkrPNiBz3SECA7c9VdrAzl/olxzZy8
 oVe8RzICLl1yNJUVFGomJm8r8fuxlBcqhdGRAiuAtIv1ahpP/RRVD8nBlAFCcovX2nzFfA0DhzR
 dysfUPrNj+caAO/Ch9q1JYF3ojqrB5sGDQ/FZMRgqb9WcDtJL/XzY705JL9Aqx/ZD8pOXjReVeq
 5MRbHOPVm6r2XSol8hgu1VmRpf76ZlgfccRPkzr0oeZBhM+E+e3RPAPH3d4GIqtbxGppPDTZhNv
 qn+2xOhD7inz2XEhucU2c+auFYGOFjZRCdON2bcrFpqMXWFWgaxdZr/hbn3BmNPmYFXLSDOx6XG
 Z1xNMaV50NCaskzSCpQ==
X-Authority-Analysis: v=2.4 cv=FecHAp+6 c=1 sm=1 tr=0 ts=69d5d786 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HdTxHAvixyPUp6pof0EA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: PmR1WOs1BRYWyG1a4lgZIVUNnfYh-xHy
X-Proofpoint-GUID: PmR1WOs1BRYWyG1a4lgZIVUNnfYh-xHy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpzaWFkIGlzIHRoZSAnU2V0IGlu
dGVycnVwdCBhdXRvIGRpc2FibGUnIGluc3RydWN0aW9uLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBT
aW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENh
aW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYyB8IDE3ICsrKysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggNmJjODI4N2U4ZmUuLmUz
NmViMmRmODZkIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTQzNSw3ICsxNDM1LDIyIEBAIHZvaWQgSEVM
UEVSKGNpYWQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBtYXNrKQogCiB2b2lkIEhF
TFBFUihzaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKIHsKLSAgICBn
X2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHVpbnQzMl90IGlwZW5kYWQ7CisgICAgdWludDMy
X3QgaWFkOworICAgIEhleGFnb25DUFUgKmNwdTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7Cisg
ICAgY3B1ID0gZW52X2FyY2hjcHUoZW52KTsKKyAgICBpcGVuZGFkID0gY3B1LT5nbG9iYWxyZWdz
ID8KKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9T
UkVHX0lQRU5EQUQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJ
ZCkgOiAwOworICAgIGlhZCA9IGZHRVRfRklFTEQoaXBlbmRhZCwgSVBFTkRBRF9JQUQpOworICAg
IGZTRVRfRklFTEQoaXBlbmRhZCwgSVBFTkRBRF9JQUQsIGlhZCB8IG1hc2spOworICAgIGlmIChj
cHUtPmdsb2JhbHJlZ3MpIHsKKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfd3JpdGUoY3B1LT5n
bG9iYWxyZWdzLCBIRVhfU1JFR19JUEVOREFELAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpcGVuZGFkLCBlbnYtPnRocmVhZElkKTsKKyAgICB9CisgICAgaGV4X2ludGVycnVwdF91
cGRhdGUoZW52KTsKIH0KIAogdm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKLS0gCjIuMzQuMQoK

