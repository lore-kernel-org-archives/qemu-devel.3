Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052AFCD98CF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY37-0001v4-Jw; Thu, 11 Jun 2026 01:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2n-0001Zz-7R
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2i-0002dO-Ho
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:32 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GQNd3817119
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tgAJ4HcMC3qBKz4UHv9oQExAihjS+9YI3bIUztCRvx0=; b=M/X0Mxd8Br5h0aei
 B2DQ/b7cN/5Si03V9bc1oYm7BoneUQXbJ0SDgH5NacaqPfXxsLU8TIp0j3o/6gwS
 7pUXt/iD2JBhMki9kDjZ/Vjp0ty+Dlgl+r83JXmMkgrWlyhBcSQ2vfl0oT6rJShg
 4SLnq68iGFuV67aelrvqGYdp9T48JYKQvnMC+lWEYQY+GsOhntANCTWFgLbEUIok
 cIu9y6m0PMaFB8lrag+qiDCWEPxouA/Y0pFegbfp07SlwQr3DnRsei/bnxVkUgF4
 +qEUqd1SuHqPmPGdWHTMUu0Hg4UYJLsUxtBUoOP0BxIwFGVTyoKf0t56GiF08Eu8
 fTVfOg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6uss6h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:17 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30761ab3483so6234426eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155996; x=1781760796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tgAJ4HcMC3qBKz4UHv9oQExAihjS+9YI3bIUztCRvx0=;
 b=K0s9qZ1V/mMVaX+zv0HywNMR4fdnifudcfpxAeQK5Bp6oAENhHrULUQ2ODTEtxc4Uo
 8TsFM9E501iKX/Zt2/TMogKbSaJ6i2FhprGg5XPn9ywD19AZt1YM2+l/hba7KcerICKu
 /V4YRYnfQbdB0yO1dB7qz9L/CYFMnccC0SvzVAjsekLzR6/A7iXMeaU7U3PotCYoW/a0
 w+SAN6K9O17N+M+TOXt9VXkrxZcnxrx13PHOoe/DaLq8sqmgswTlPwQTEOCbS3EasnDk
 0CWdbh01lKnG5pUCFAraMO9tVS4sNLM84hMXJOXT8KvIpS1hbiB8pJQ7cd0QZYyEDBHX
 1fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155996; x=1781760796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tgAJ4HcMC3qBKz4UHv9oQExAihjS+9YI3bIUztCRvx0=;
 b=ZMqYnIx/GO53IQlfCxowhSyLSPS+9rGPj+rRQG9QnoEiIls1hFkmFAZZkCA9R6e8eh
 9x6mZBkCJ4fg/lZaJR2jHOAGdTwb4F1InvcAMJH2vHEX4pJEMY2zDea7ZK/0gc4ntsJU
 VQHNnIST6XQj8c5YiugVBVHuqfxNSt3GcK7WM8tILS8Frd1MLCDPEJhE6ANYqquaOk1C
 YdbGZzy5nIm4b+OFs/39aq7zUwOJkIUWuZ4cGOmYnBguvz+Glg3qJLak6vGmqR1WJzz/
 WWIdj0llV34XXFc8gcG5eE8mgMMyMJntFmdxMfAbS+b3Dk6sTsbViVtXyKqjXB+uAxVr
 ncUw==
X-Gm-Message-State: AOJu0YwCaBNo+xK2g2hd4zJ4wljNnqXMPO2SYWXGG2hJZF8LllFyGSo0
 Gyxfm9CcF6PdHkYsZDKgTL3qfel+Iszbkku7ibq1RUDKEQyV4tcf2qgHTRVMC6cXEn49aCD4jug
 T+rmrG17+Ub53DZY/Q+0gFVsB27k/oTuEALf2clL9cvQND5xOtDuqwCWKn5KRpzir+A==
X-Gm-Gg: Acq92OGOnqpLxC3jbOfwu41Zm+NlRSNE5q/n4gzkuiGLVKZqnyx6Mq1Zqg4MKm5p6Ur
 hefcRgOzjPPa7Epim7Vqr0EHzRLXNHaGNBVcHC18butpuUD8S5EdOQw45TpqZpOWGKWXKGKdyRw
 mHozikB/tgxXOydqmrLnnNhsg2uRuVtMkscwRaY0TXFDWfSQFkzJzPsFlyizjAjzzEuL6bP+Jw9
 zguTN4y5AsobJYIZYop4zaYyMfi3w4dbDvER30/cTUjabCykm3KQAj4UL715qohCjOerVQuhoeT
 HUGtNt3T7EyDdR+27o8i9nqP1e8ty5bbmqDOS8fcfdzN2ZpEGhOzKfPGqqp/TO9jMkcWoK0RreS
 rSld9B+KHduYbOMcEoRtL+BRyh1Jdo6Ittj/b5X8KfPfD6nsG1zRx/Bzz1MHkhnoralNeMEQivm
 YYC1ZS
X-Received: by 2002:a05:7300:4352:b0:2ef:9961:27fa with SMTP id
 5a478bee46e88-30804b8a64emr1188910eec.18.1781155996484; 
 Wed, 10 Jun 2026 22:33:16 -0700 (PDT)
X-Received: by 2002:a05:7300:4352:b0:2ef:9961:27fa with SMTP id
 5a478bee46e88-30804b8a64emr1188878eec.18.1781155995928; 
 Wed, 10 Jun 2026 22:33:15 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:14 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6] target/hexagon: Implement siad inst
Date: Wed, 10 Jun 2026 22:32:34 -0700
Message-Id: <20260611053249.3918491-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=FJ8rAeos c=1 sm=1 tr=0 ts=6a2a489d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HdTxHAvixyPUp6pof0EA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX9EXz/85dS7jz
 HJmQZ5iyn3WtiMIYJNEqRsJyQYzNpslxtSx0pn9sKrKZD9Dl/cvfexQ11jQgPnXCuhPxJCuhVv4
 Iz70iWrji21YKea0z88S5GLzQgbtFuE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX67xth2NSzRrE
 fQO1VTLL9hKomCwq5NmZEAatDlKCa60AdgHpk2Yzuragj9zEQY1Smfvqa+zwHd3qlO5NseQHltf
 QVyB3CjYZrlImvQrPMs9n/qWovw1HSaNEiVZdd+Fu9ZwPEyHnJVoyqy39O0Rc03LPnjKSgjPoUs
 GcBgyWSpOfnyZ6Ti+3T85a5OY81+uQS0+NcUQmDWwmSnOFERwURYi1avMvmXbvMwxUbHzKe66Rs
 oTiGDIZqyCodys6EsB/tFvatHEdAGRGXjB7SSYuFKSOpQqnn6J1fWZ49jtuOP/uyjW0aWCSx/1r
 qPmdWIiP3WIuqe5ihXjbq71DKkcQo+hDPGfmRh2ouJYRKe1qL3J0JP4hhrlLfEFzweuNpapWMZH
 uGkuroLmVz9iq8P0HrA/78R5S4ygKcC9lGkfr0zZZ2IXATDDcjWa/JOLlqUqgbZqzGFe1llwrd4
 8JH/UYP9H4FvhQ6XrVA==
X-Proofpoint-GUID: lx-xbVezeFhp7ZgjwhAHCm45gsU31AOM
X-Proofpoint-ORIG-GUID: lx-xbVezeFhp7ZgjwhAHCm45gsU31AOM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110052
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
bHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggNjExMTYyYzUzMjIuLjNl
MTAzNjA5ZmQ0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90
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

