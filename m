Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD63C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFNR-0002u0-Qi; Sat, 01 Mar 2025 00:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNQ-0002tS-Rn
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:04 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNO-00087B-TI
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:04 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213GfWP005267
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qktWgrah5wu4OUf0TSlgxEt6Obwe/RRcAOofQ2rBqMQ=; b=Fa1S7jTVZ4LiWHxu
 CebjVatAUjd6gsEOqBnlR40gVaflEkLAk4f2oGsQAJIX34P8lbwFReKe1LUIRKve
 SneRCPK70ox2b9veaalpRd60Xv+r9iOyGr2G4D/xugaI3HVF70HAISyGbsoqUlCB
 v3O8tlMDwLqhFAA7G4LW7QVNfHWJjzw5NLCqLWxscIeHfS9BZaH4LcjcXkvZTJig
 XBu2QDyjTNkD175Ysma9+jbsHBU35ty45ewZ0Q7WqG9x0XLip05HjXIcsrwlL9Eg
 J1fB9h29PAAkDeq30hEYRQWk6fPlyY8ZBwd80AEYqoNgBEbHxeaqsDsYshWxaJw2
 zNDzUQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t6k06c8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2234c09240fso52019045ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806820; x=1741411620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qktWgrah5wu4OUf0TSlgxEt6Obwe/RRcAOofQ2rBqMQ=;
 b=XjwMzoDa5G+S4UK//hj8og/norB2Z1OoB+0aWfe4a8erSBOxKNiaortnGA5AK9+VXr
 9ZMLtMdmtbqwBWhHsuH9RofiiMQPowpCWj8Yj+ezZduCIKIn3f9et4jglJJW+8ev7atv
 YgKfjoe0K8fefrGik8cu5Jz46kOC5ilBoxLjp3Dlm/+SSXqWcbqe6KGdAk8ps53SXwwj
 /QgwzN6ckK6ZcXc85cF50dxdYYNoQj+kHdgiNOnoR8N4gz4a88hX8kMd1+0DkxOL/S0T
 MPsxqbvUxLk1wVmdu4oAEiBKh2KqdnO7LBF5DUDMQoparW/FKXNKqb4AnJ5qm4l1Qj0J
 sJBg==
X-Gm-Message-State: AOJu0Yy0SYuLKhKXkkYXTTmyvrpd7BHEZX4New7mzfIoQxoJ5sHX20L1
 Vt67w8D3fsmdZrlVSwp3kT90hy6SfSweGyAPc9LV8HjC6ql49akT4z/P+yesC3Yu6Mn/aJ9SMai
 rMJ4tD9v21hDC1BCLFg7IatHe/rLu+z/HHhe28AgUXfjWZ15GuKh1mPjijs9f2g==
X-Gm-Gg: ASbGnctrWXrP3rfNgwoJt1RzEnWnqFJMbxCnxIFP2kgQaqomFQbpYkRActNM1dBundk
 7lo5rI+uX/lQ4rhTL4lYON7wBGvJV7Y+vnQF3Y3WOnKctNFKbICGy2j79LJiOJiQV5duO0Sn0NJ
 3Z/QRYj+5OuQtpfq9U4kfdvoqDPH6jMDuXsqifXTwZdcCjIArt3/JEcYadm/p4hDhHyQHOeZT+d
 RdBaBt+mpw4RRktym5opmiyC3LDFp/MPszoquTtWylScqCpWbTlkrI2VGt2gPjET4eUznIsPDEd
 bRM5GWj/J4OFGGwveWCtQfcp/LPnMaJ99M0Cjh6nLplAcjEgVftv92FUq5g2I74k
X-Received: by 2002:a17:902:f790:b0:21f:768:cced with SMTP id
 d9443c01a7336-22368f6d018mr79566945ad.8.1740806819952; 
 Fri, 28 Feb 2025 21:26:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+dQS7lIxLUtE69EhrRxCJT0arVdXEBQ29P00z647XXC19BSpW0D/O2b9FjWF3UN+Mxa90/w==
X-Received: by 2002:a17:902:f790:b0:21f:768:cced with SMTP id
 d9443c01a7336-22368f6d018mr79566655ad.8.1740806819591; 
 Fri, 28 Feb 2025 21:26:59 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:26:59 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 09/38] target/hexagon: Add guest, system reg number state
Date: Fri, 28 Feb 2025 21:25:59 -0800
Message-Id: <20250301052628.1011210-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 1QG6L_FX1DU0ndjwiFk6gMHVTrmRe5ye
X-Proofpoint-ORIG-GUID: 1QG6L_FX1DU0ndjwiFk6gMHVTrmRe5ye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010039
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
Y3B1LmggfCAgOCArKysrKysrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgfCAxNyArKysrKysrKysr
KysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJnZXQvaGV4YWdvbi9jcHUuaAppbmRleCAyMGVhMGFk
Y2NhLi5iNzc4OWEzYzkwIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90
YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtODIsNiArODIsMTQgQEAgdHlwZWRlZiBzdHJ1Y3QgQ1BV
QXJjaFN0YXRlIHsKICAgICB0YXJnZXRfdWxvbmcgc3RhY2tfc3RhcnQ7CiAKICAgICB1aW50OF90
IHNsb3RfY2FuY2VsbGVkOworCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICAvKiBTb21l
IHN5c3RlbSByZWdpc3RlcnMgYXJlIHBlciB0aHJlYWQgYW5kIHNvbWUgYXJlIGdsb2JhbC4gKi8K
KyAgICB0YXJnZXRfdWxvbmcgdF9zcmVnW05VTV9TUkVHU107CisgICAgdGFyZ2V0X3Vsb25nICpn
X3NyZWc7CisKKyAgICB0YXJnZXRfdWxvbmcgZ3JlZ1tOVU1fR1JFR1NdOworI2VuZGlmCiAgICAg
dGFyZ2V0X3Vsb25nIG5ld192YWx1ZV91c3I7CiAKICAgICBNZW1Mb2cgbWVtX2xvZ19zdG9yZXNb
U1RPUkVTX01BWF07CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCmluZGV4IDBiN2ZjOThmNmMuLjM1NWUxZWVlZjMgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC0yODgsNiAr
Mjg4LDE0IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmos
IFJlc2V0VHlwZSB0eXBlKQogICAgIHNldF9mbG9hdF9kZXRlY3RfdGluaW5lc3MoZmxvYXRfdGlu
aW5lc3NfYmVmb3JlX3JvdW5kaW5nLCAmZW52LT5mcF9zdGF0dXMpOwogICAgIC8qIERlZmF1bHQg
TmFOIHZhbHVlOiBzaWduIGJpdCBzZXQsIGFsbCBmcmFjIGJpdHMgc2V0ICovCiAgICAgc2V0X2Zs
b2F0X2RlZmF1bHRfbmFuX3BhdHRlcm4oMGIxMTExMTExMSwgJmVudi0+ZnBfc3RhdHVzKTsKKwor
I2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgaWYgKGNzLT5jcHVfaW5kZXggPT0gMCkgewor
ICAgICAgICBtZW1zZXQoZW52LT5nX3NyZWcsIDAsIHNpemVvZih0YXJnZXRfdWxvbmcpICogTlVN
X1NSRUdTKTsKKyAgICB9CisgICAgbWVtc2V0KGVudi0+dF9zcmVnLCAwLCBzaXplb2YodGFyZ2V0
X3Vsb25nKSAqIE5VTV9TUkVHUyk7CisgICAgbWVtc2V0KGVudi0+Z3JlZywgMCwgc2l6ZW9mKHRh
cmdldF91bG9uZykgKiBOVU1fR1JFR1MpOworI2VuZGlmCiB9CiAKIHN0YXRpYyB2b2lkIGhleGFn
b25fY3B1X2Rpc2FzX3NldF9pbmZvKENQVVN0YXRlICpzLCBkaXNhc3NlbWJsZV9pbmZvICppbmZv
KQpAQCAtMzEzLDYgKzMyMSwxNSBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9yZWFsaXplKERl
dmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkKIAogICAgIHFlbXVfaW5pdF92Y3B1KGNzKTsK
ICAgICBjcHVfcmVzZXQoY3MpOworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgaWYgKGNz
LT5jcHVfaW5kZXggPT0gMCkgeworICAgICAgICBlbnYtPmdfc3JlZyA9IGdfbmV3MCh0YXJnZXRf
dWxvbmcsIE5VTV9TUkVHUyk7CisgICAgfSBlbHNlIHsKKyAgICAgICAgQ1BVU3RhdGUgKmNwdTAg
PSBxZW11X2dldF9jcHUoMCk7CisgICAgICAgIENQVUhleGFnb25TdGF0ZSAqZW52MCA9IGNwdV9l
bnYoY3B1MCk7CisgICAgICAgIGVudi0+Z19zcmVnID0gZW52MC0+Z19zcmVnOworICAgIH0KKyNl
bmRpZgogCiAgICAgbWNjLT5wYXJlbnRfcmVhbGl6ZShkZXYsIGVycnApOwogfQotLSAKMi4zNC4x
Cgo=

