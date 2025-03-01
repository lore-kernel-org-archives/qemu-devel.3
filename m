Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560FFC282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPr-0001bB-FY; Sat, 01 Mar 2025 00:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPo-0001KE-5N
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:32 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPk-0008SY-TY
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:31 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213JRpC016337
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pdumTwo7IoMLP0yljPwpI+Lq3xCKO+++UyI7I9bZTkI=; b=cFN4razFsRMAzmyd
 u+ox75wlXaKMR5yU0IspsoFeKTMCyqIdFZFn9wNxHWcolkehPy6ENbnTlDHQso60
 KR2EJWg/Q57dEXxYzjsxI6xol7mPQX4ZGaM4bKw5FcNn/PTFqOHAhBkTtFuXOTAv
 tevMfK2g5/aNzqQe7G8sJGdmXiWezCV2xT7vBzHTS5jCPjVBTAg4xggebpDUsntN
 F38/Y2xhTGX/ZnlHZNLW3nD/SQWyeKNJ2JM9dezyBaLx9kq24/OtWRFuWXGrj1vU
 KFUprsRdcMg5OuW7ABh7+Ooh+7SQDd1BJCWnt1VxGdjHvY4I+oD4+vOKQmRznPOq
 nAQfCw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t7hr6an-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fe8fdfdd94so5864278a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806966; x=1741411766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pdumTwo7IoMLP0yljPwpI+Lq3xCKO+++UyI7I9bZTkI=;
 b=Yi9e52qS2uwo1yMT1gDIxlCFnK/TPRuebJGwZffaby0mFTDD0sO2/+NAiHz3UukJ8z
 gaHoUQxvt6eR3GsIkJi+PWCaW5Fh4umWxvhQPoN/Z6xsQlIcksNkc5VWnc0DcJsV05q1
 8vk7pfVIIMVFosJguytnk5Cx/UZssOFOFFwHiDGKs0TDt7lxS/l2xZHxTywXGzMPhpQx
 Euq6c4woIhy6YDECLCEK8M3G4ysvslwtbE/9w2z2JtkEuLMc57jJWuCm5z3NmdSH7Rpm
 rlphH0BZVX3QcyxfaVa+3j9hKNtPSWyvJEVu3LYwD1DiTIHNXm00V0ad0PIUnT8K1G8A
 7UoA==
X-Gm-Message-State: AOJu0YyllS9L9tpYJ1k82SMX1Mqx2tiIz68kbte8+iRjssEcRjnqq6Jc
 ILv+tgPs6Ugd3gtgOUlwJc9S2861eT4RfqbaRzllBoJqigFNwo4vcquJKtszHlw6Jdy/JpMn6WX
 jpW3o/XDoPr4JsctQsPTUoxh6hnA8YMlUwc1AENLaYAJgGwAATyug/ZbeIkA4xw==
X-Gm-Gg: ASbGncsNhm50oI211LtVEjmDpaByo55ANcGG1G8TnzcjQ7ARx1d/AGwsjuXTyWkM21r
 etdI/W8tBvNpvGcobIK51DItAkcbstQjnBBIJUCHuBMFxn2gYRFAeHGHvs4Y7H5N0LGMxw7eWs/
 wpf+i4KieSeBxiFk4WXRcj39swgWspaCvntCUcyrr+eAAxDSgRrllDgPZ2RyJaa4mHKvH62GIft
 12WPkHQEkfuNMKqlIEAjH0K8BepmH6WO3kYAdA/w9qqseScX3oDoyynBrxm1Epix9QtLamjbI4K
 fJkcyp1NWMikpfj63K3c+L8oD8oXR6/gdNR2qKm83klpYH1yrI5BoN1F+Llib5n1
X-Received: by 2002:a17:90b:3ecd:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-2febab2eec2mr8956311a91.6.1740806966358; 
 Fri, 28 Feb 2025 21:29:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQ8OU8FPPJFKUFAOhyTJCyu/+CD1ujdlzdvqKDdYaaOiE0POyrdUPsivnqt5o8HDw/26ERwA==
X-Received: by 2002:a17:90b:3ecd:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-2febab2eec2mr8956294a91.6.1740806965925; 
 Fri, 28 Feb 2025 21:29:25 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:25 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 28/39] target/hexagon: Implement modify_ssr, resched,
 pending_interrupt
Date: Fri, 28 Feb 2025 21:28:34 -0800
Message-Id: <20250301052845.1012069-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: -99BKhbXAM043Dy98MftoArDp4P3AziK
X-Proofpoint-ORIG-GUID: -99BKhbXAM043Dy98MftoArDp4P3AziK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=511 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
aGVscGVyLmggICAgfCAgMyArKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMjAgKysr
KysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIvdGFyZ2V0L2hleGFnb24vaGVscGVy
LmgKaW5kZXggNzMwZWFmOGI5YS4uM2RmNjYzYmFlYiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaGVscGVyLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgKQEAgLTEyOSw0ICsxMjks
NyBAQCBERUZfSEVMUEVSXzEoc3RvcCwgdm9pZCwgZW52KQogREVGX0hFTFBFUl8yKHdhaXQsIHZv
aWQsIGVudiwgaTMyKQogREVGX0hFTFBFUl8yKHJlc3VtZSwgdm9pZCwgZW52LCBpMzIpCiBERUZf
SEVMUEVSXzIobm1pLCB2b2lkLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMShyZXNjaGVkLCB2b2lk
LCBlbnYpCitERUZfSEVMUEVSXzMobW9kaWZ5X3Nzciwgdm9pZCwgZW52LCBpMzIsIGkzMikKK0RF
Rl9IRUxQRVJfMShwZW5kaW5nX2ludGVycnVwdCwgdm9pZCwgZW52KQogI2VuZGlmCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBl
ci5jCmluZGV4IGYzZmZhYzgxYjYuLjcwMmMzZGQzYzYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xMTc4
LDYgKzExNzgsMTUgQEAgZmxvYXQ2NCBIRUxQRVIoZGZtcHloaCkoQ1BVSGV4YWdvblN0YXRlICpl
bnYsIGZsb2F0NjQgUnh4ViwKICAgICByZXR1cm4gUnh4VjsKIH0KIAorI2lmbmRlZiBDT05GSUdf
VVNFUl9PTkxZCit2b2lkIEhFTFBFUihtb2RpZnlfc3NyKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpCit7CisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAg
ICBoZXhhZ29uX21vZGlmeV9zc3IoZW52LCBuZXcsIG9sZCk7Cit9CisjZW5kaWYKKworCiAvKiBI
aXN0b2dyYW0gaW5zdHJ1Y3Rpb25zICovCiAKIHZvaWQgSEVMUEVSKHZoaXN0KShDUFVIZXhhZ29u
U3RhdGUgKmVudikKQEAgLTE1MTYsNiArMTUyNSwxMSBAQCBzdGF0aWMgaW5saW5lIFFFTVVfQUxX
QVlTX0lOTElORSB2b2lkIHJlc2NoZWQoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgfQogfQog
Cit2b2lkIEhFTFBFUihyZXNjaGVkKShDUFVIZXhhZ29uU3RhdGUgKmVudikKK3sKKyAgICByZXNj
aGVkKGVudik7Cit9CisKIHZvaWQgSEVMUEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB0
YXJnZXRfdWxvbmcgUEMpCiB7CiAgICAgQlFMX0xPQ0tfR1VBUkQoKTsKQEAgLTE3OTMsNiArMTgw
NywxMiBAQCB2b2lkIEhFTFBFUihubWkpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCB0
aHJlYWRfbWFzaykKIHsKICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwogfQorCit2b2lkIEhF
TFBFUihwZW5kaW5nX2ludGVycnVwdCkoQ1BVSGV4YWdvblN0YXRlICplbnYpCit7CisgICAgQlFM
X0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfaW50ZXJydXB0X3VwZGF0ZShlbnYpOworfQogI2VuZGlm
CiAKIAotLSAKMi4zNC4xCgo=

