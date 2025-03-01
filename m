Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB1EC282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFNn-0002yI-JC; Sat, 01 Mar 2025 00:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNj-0002wi-V6
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNi-00088Q-90
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:23 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213KcR9007742
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lwcWCE75lC/AkKZ8pbE03botEWLpkgN7wlY2MM72h24=; b=VvBTsWs7/pq5Dhrd
 5Q+FvQvroWBMyMHDpRjHUGbnQSgNGydOj72y1E9Wr2s40Gna8faj09WmjRDCn3Ek
 lBxLSKs+A+pPW80wF/0NGoYXHs7MvLYujIaEP+DR6DPmYxOc+yCDKyeV/cmg4HSe
 QkJn6dulRJ6AuDvRuNoTFj+a/J4VJQZ6Ro0o1SU30Z1XtEWnPgyEnMJD8NjisYac
 M+l1TYBoN0T4DFqE0jRCLtM54j5SdY6IHjHbVpd12UBLuktYxb4xojiwy44W9qWN
 Vh22o1MoI9HuLB3zxG0KIzAFGrc+egh9R9uBz0T9UyVdAjTkgNvONzzl3zENcf2Y
 /zdN+w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t88r696-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2feb8d29740so3584903a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806830; x=1741411630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lwcWCE75lC/AkKZ8pbE03botEWLpkgN7wlY2MM72h24=;
 b=ab5WwimNV+snZBpuIW6FFrYQF378PnEuQ+ijCvpnkP0YFpfjm6WMfCWb/lcZ1sfPp7
 mpPJe/nptec3clTx4MLB+3lWrR4cDM/QY7YXyVSfomHQNaXdi98S/FvYYiDo03iwNCLU
 TpKZE9b07NDx//zTxTX/jUO7Jvs6lPNrWr14iub+aW4r24cL6aT7fv/kuVe+n5GiwZXq
 DXXAWJXzQfmp5+jitssRu7dSyEY7Rx4OSyg5ygDNrUvkEvAW0EzstcpdqK6riR1zXSTP
 3G5NaJinQKsbbczjxzrfJONtakt8lgGlFRIOwAjJsffy8r2d0V6hL6QqtOppHt9EkuN5
 WDXw==
X-Gm-Message-State: AOJu0YzxAYKwyNwZWVqcxsnwGHNLplxKhjwjiTRreZ6V4XY54A7tPIv8
 Cu8FICh8luZHrKtTTaZ175oqHj0KG292nN/kJduWDdV9St9017CL1OqXOHteZW/Rjnp8+Y/xtEf
 IEaH8oZ/eS2R8MMsiG+YRZ0M+JK7rLB/sFSJq42mj670OnmUEf5GOnqKeyB+nuA==
X-Gm-Gg: ASbGncsJe0JWN0aduMNeqFw4UeQf3ny0xZ8/R57iJFauuCZbQN4ladYItwjO58J52oA
 rn21dNTK4ozAtPRfvrUdo/lcge+NJ2vDd9IucRXfP9FwlQhHwP5QY80VdL1+k7qD7Bj8hf0Uycl
 KqgXrdE9hiyDA3PZVgQnTuFkPCpsqzIsIxQ9E3cF3/aiRb3GdP3qO0eHd2hjSoiu+7LhnQ5rOTS
 Mt5ZSLnqinK8kx/qeyCDTH47C4RtKdnkYiY4FUT3/sAWG6TAcCFjay+UQ1B6JXo/pcNZXwYVi/r
 sVUNWs82kARgMX5bGxyjFybl0g1bmkuPy43bSOrbQFa0eiEmLzVRIRqiDUbfgkpm
X-Received: by 2002:a17:90a:c10c:b0:2fe:dd2c:f8e7 with SMTP id
 98e67ed59e1d1-2fedd2cf937mr1415619a91.10.1740806829936; 
 Fri, 28 Feb 2025 21:27:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvrMwZ+g3kiNrOGi3aFsRdSNAFdqq/TgXvR4csn1jlK7p0G01MY+enBd0ewqrottO0133zAw==
X-Received: by 2002:a17:90a:c10c:b0:2fe:dd2c:f8e7 with SMTP id
 98e67ed59e1d1-2fedd2cf937mr1415585a91.10.1740806829556; 
 Fri, 28 Feb 2025 21:27:09 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:09 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 17/38] target/hexagon: Add vmstate representation
Date: Fri, 28 Feb 2025 21:26:07 -0800
Message-Id: <20250301052628.1011210-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: odTB43FyBYZjVifC9gCZGXOPJw4mcEb0
X-Proofpoint-GUID: odTB43FyBYZjVifC9gCZGXOPJw4mcEb0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=929 mlxscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503010039
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
aW50ZXJuYWwuaCB8ICA0ICsrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgfCAgMyArKysK
IHRhcmdldC9oZXhhZ29uL21hY2hpbmUuYyAgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysr
CiAzIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0
YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9pbnRl
cm5hbC5oIGIvdGFyZ2V0L2hleGFnb24vaW50ZXJuYWwuaAppbmRleCAzMmU5NmYwMGQ5Li45NjU4
MTQxMzE2IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2ludGVybmFsLmgKQEAgLTMxLDQgKzMxLDggQEAgdm9pZCBoZXhhZ29uX2RlYnVn
KENQVUhleGFnb25TdGF0ZSAqZW52KTsKIAogZXh0ZXJuIGNvbnN0IGNoYXIgKiBjb25zdCBoZXhh
Z29uX3JlZ25hbWVzW1RPVEFMX1BFUl9USFJFQURfUkVHU107CiAKKyNpZm5kZWYgQ09ORklHX1VT
RVJfT05MWQorZXh0ZXJuIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX2hleGFnb25f
Y3B1OworI2VuZGlmCisKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCAzNTVlMWVlZWYzLi4wZGI5MWE5MzZhIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpA
QCAtMzcxLDYgKzM3MSw5IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2NsYXNzX2luaXQoT2Jq
ZWN0Q2xhc3MgKmMsIHZvaWQgKmRhdGEpCiAgICAgY2MtPmdkYl9zdG9wX2JlZm9yZV93YXRjaHBv
aW50ID0gdHJ1ZTsKICAgICBjYy0+Z2RiX2NvcmVfeG1sX2ZpbGUgPSAiaGV4YWdvbi1jb3JlLnht
bCI7CiAgICAgY2MtPmRpc2FzX3NldF9pbmZvID0gaGV4YWdvbl9jcHVfZGlzYXNfc2V0X2luZm87
CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBkYy0+dm1zZCA9ICZ2bXN0YXRlX2hleGFn
b25fY3B1OworI2VuZGlmCiAgICAgY2MtPnRjZ19vcHMgPSAmaGV4YWdvbl90Y2dfb3BzOwogfQog
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMgYi90YXJnZXQvaGV4YWdvbi9t
YWNoaW5lLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMC4uZDlkNzFlZGY3
NwotLS0gL2Rldi9udWxsCisrKyBiL3RhcmdldC9oZXhhZ29uL21hY2hpbmUuYwpAQCAtMCwwICsx
LDI1IEBACisvKgorICogQ29weXJpZ2h0KGMpIDIwMjMtMjAyNSBRdWFsY29tbSBJbm5vdmF0aW9u
IENlbnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgorICoKKyAqIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKworI2luY2x1ZGUgInFlbXUvb3NkZXAu
aCIKKyNpbmNsdWRlICJtaWdyYXRpb24vY3B1LmgiCisjaW5jbHVkZSAiY3B1LmgiCisKKworY29u
c3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfaGV4YWdvbl9jcHUgPSB7CisgICAgLm5hbWUg
PSAiY3B1IiwKKyAgICAudmVyc2lvbl9pZCA9IDAsCisgICAgLm1pbmltdW1fdmVyc2lvbl9pZCA9
IDAsCisgICAgLmZpZWxkcyA9IChWTVN0YXRlRmllbGRbXSkgeworICAgICAgICBWTVNUQVRFX0NQ
VSgpLAorICAgICAgICBWTVNUQVRFX1VJTlRUTF9BUlJBWShlbnYuZ3ByLCBIZXhhZ29uQ1BVLCBU
T1RBTF9QRVJfVEhSRUFEX1JFR1MpLAorICAgICAgICBWTVNUQVRFX1VJTlRUTF9BUlJBWShlbnYu
cHJlZCwgSGV4YWdvbkNQVSwgTlVNX1BSRUdTKSwKKyAgICAgICAgVk1TVEFURV9VSU5UVExfQVJS
QVkoZW52LnRfc3JlZywgSGV4YWdvbkNQVSwgTlVNX1NSRUdTKSwKKyAgICAgICAgVk1TVEFURV9V
SU5UVExfQVJSQVkoZW52LmdyZWcsIEhleGFnb25DUFUsIE5VTV9HUkVHUyksCisgICAgICAgIFZN
U1RBVEVfRU5EX09GX0xJU1QoKQorICAgIH0sCit9OworCi0tIAoyLjM0LjEKCg==

