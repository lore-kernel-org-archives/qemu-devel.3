Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A086CDB476
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9o-0003yW-KQ; Mon, 22 Jun 2026 18:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9m-0003sk-PE
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:30:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9l-0006qh-61
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:30:18 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJapXt2177085
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oY8qK4LAUtINTePvitXB1Xfo61hqyHEyBFAF6Gss008=; b=TNczO2WdsbPGtIZy
 6VPTVFOv1UwSwqjaIwEX+iKCArbujkeW3zP65/UoLiYZ57c8T3pi2V1NEC3qVDWu
 YA4lhjYovsC5lKCLpl8AAz/HpaAa9MLXaVXKMfVTFVL0Gvri29f6qIJMiRHiKhoG
 9hS+mDF+A/BNA/jv7OQuYnHqTg9Zi6dQBC3NJQg1l7ocJV20kSyvscSy+TQJgxj6
 22qi2XW0vRnRAT3QNNABbehTC2JrmDGx8fBod3mDQri1rOy8D8ROf7xSyeDkpj6T
 Uhi+BOAgEDP2PmeZQe375frm4qNPxZFrEgTDQ5uzgWTSplYc4+pbNzIVQvzl8XbZ
 UKPOLA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37hahem-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:30:06 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c50cd6cbcso1249287eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167405; x=1782772205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oY8qK4LAUtINTePvitXB1Xfo61hqyHEyBFAF6Gss008=;
 b=ipIapESedcAg/R7X8EBY++rhYI4Z9K+fxlZNDn6jkHZwf+25j9gpz+YLNvc1ELY0cZ
 x5lnFF9GRifdoVlPipim7BXGXa+ntA6t74m7SR4vtwaL1BIHCWnTqGJ+45frzkP4ONe2
 pFIHuRQ+Tv+we9aun+0LgWkjUD3MH4eJdQehtQRc/TLkuGTMVU9bk5ft+t2xO+CjORjA
 7WQ6vEDViYW3llDabogwYyM6tWQTWax0mQZuUKh+wDqy9nlDFUhhyNKzdCVDNirPk+lx
 Sl+dJ6WR3a3wULOFxraTNIJdhHqtxY+XnqGQGhX/S99F05cD/aAXGRFoqycJs7YWlrQM
 wP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167405; x=1782772205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oY8qK4LAUtINTePvitXB1Xfo61hqyHEyBFAF6Gss008=;
 b=KygawmV65KkTPi1E3+lTPlX+L/mFUFxHIwToimuFsBHb4RZwPWcg4hk8CCXfgLER0Z
 LhhXzOpMFiZ6QDdt4KgA3eugQrbOwu1zl7RnJV2dGcxihqshO+D1g+3nAn9lniQB03Qy
 3NTyQBrHqL5+X5Lv2mtm0nJGZEsnNGYilgDct5psLBK1WMWE9o9DR/xwMh3EtfhBvIzP
 v0t94OlPtPjgpzHtnTmQVAg7BX8A3xG9OMUAS3rXLGHCyOZyQnFksxPUDeQAZPqmOwtI
 Zox7aRPCp10nYXwxYBudIwqUrgxJGDG+fddmstx5x43Nn+cgW2Srl/FtpEXv54CuZhDh
 z+GQ==
X-Gm-Message-State: AOJu0YylrXmbuVmwQ8dpqIVPjp3DyTGpL0SguV1elmWhWMajf21Z7rGR
 YoIjgmG243DgrwNlTo0cVbldOuhtph6v5HfMuHHrvF7z5clzlUH98en16zH+GyRI33gqPjS9Mji
 ulaV5F4dL+r8ARqxRpcZ2RWuYQlqmTIxYhtTZiIKR5oOPz9qSgHDucCvR9y3jbF/8Uw==
X-Gm-Gg: AfdE7cmtcoCzqNr96jLREZ7xQHeiWQIgUYNWA7UiJrkZ8GYJ9SYCU9NNFcJHCgBolwy
 pyi4HTWb0tuCdJqt6BNQ8crmoFqscr4AgbC4LbAKH7KJacqPyZ+YfvDYrqJVt/mMUP6cVLrr8F9
 2hEnxP7Lhw5/M9nwpDSjJvhM6LBhJX/3CuneL5gkJ0/ksSkw9CEaUPqCBz8c0qjCtqa48L1oL9U
 ZfOJtCxdtT5BS76z1wCB7paqYXTf7Uc+5DuVNH/qq0+D0QW660WEdAOzYkYh3qEegtb82HAc1Mx
 RrCesBIaCdYyDnHejKGEaWs+hL8zai+n9ptaqmz4gufNd6C6T2uMviUv/aaYycsOKcTCFNUjiEj
 zOUy9cZuqDIm5gVk/Doi5QubjUqnudBifoDd1oFibyUnElfWwPqGEHu86ok8=
X-Received: by 2002:a05:7300:6c29:b0:30c:283:9042 with SMTP id
 5a478bee46e88-30c58ceb368mr337150eec.30.1782167405125; 
 Mon, 22 Jun 2026 15:30:05 -0700 (PDT)
X-Received: by 2002:a05:7300:6c29:b0:30c:283:9042 with SMTP id
 5a478bee46e88-30c58ceb368mr337123eec.30.1782167404557; 
 Mon, 22 Jun 2026 15:30:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:30:04 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 38/75] target/hexagon: Implement {c,}swi helpers
Date: Mon, 22 Jun 2026 15:28:27 -0700
Message-Id: <20260622222904.607771-39-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: _o_54_tcK9atm09mz21WmA5sWKH5lX22
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a39b76e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KN34Fzpn9o_w8YhA2GgA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX1Ynw5exyLl04
 ql6FKu196OMVPHOMJTn49NWCw7rOJXacy2P/tqhV6rOu/qiNSRQumtuEueliI2YNpVB22GeVvCg
 6SFpN23IOUde4L/uW1iPtzqvOyXkFoI=
X-Proofpoint-GUID: _o_54_tcK9atm09mz21WmA5sWKH5lX22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX/nPEPqnyGiB5
 3aaJbCKFFNBu2dmmJ16XdyvABnzWmKRcO8uKtBR3s1LG6ugAYRaR+Ur+xgLC6mhu2kb6mItFzpk
 fkJMnQVpBDbZUTQOXCrwypha1qY8GfMGaWvZByZdDpurQKrQxSyoIRtO8NJ0kaBrfppDUlFotT+
 0/UzMPqct1h/YbGrI9IHBY5yA0AyUWnCSGR1khn9RjZCln5NtbodBRKjwxs14Hu1oKaHbKU1h+4
 hud/mSisGCPYKiu56YXjuh2Joi+bvhn0N2Lu0GVBZgk+Z7wCFB8XUC7pBXPUfHP3AzobkC5EvUk
 bZa+hCctMdBgxgaCK9eUkalU4hpyTk4c+RrpMX6wGUj/w6wrHkn6v7odeo5FnaK3f1Rg/KG19cc
 nlEYOBuIgReJbzq1mdRMiaBa4IUi6ASoYuCqbQWXr/ZbScgek2hdFDxTCyQ7yCDlNaesykRekky
 ORwXx93ea6tG21TcX3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220216
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Cgp7Yyx9c3dpIGFyZSB0aGUgInNv
ZnR3YXJlIGludGVycnVwdCIvIkNhbmNlbCBwZW5kaW5nIGludGVycnVwdHMiIGluc3RydWN0aW9u
cy4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29t
PgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+
Ci0tLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCA4ICsrKysrKy0tCiAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXgg
NGRjMmI4ZTYzYTcuLjc4Mjc2OTZjNmIyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMjQsNiArMjQsNyBA
QAogI2luY2x1ZGUgImNwdS5oIgogI2luY2x1ZGUgImV4ZWMvaGVscGVyLXByb3RvLmgiCiAjaW5j
bHVkZSAiZnB1L3NvZnRmbG9hdC5oIgorI2luY2x1ZGUgImV4ZWMvY3B1LWludGVycnVwdC5oIgog
I2luY2x1ZGUgImludGVybmFsLmgiCiAjaW5jbHVkZSAibWFjcm9zLmgiCiAjaW5jbHVkZSAic3lz
X21hY3Jvcy5oIgpAQCAtMzYsNiArMzcsNyBAQAogI2luY2x1ZGUgImNwdV9oZWxwZXIuaCIKICNp
bmNsdWRlICJ0cmFuc2xhdGUuaCIKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2luY2x1ZGUg
ImhleF9pbnRlcnJ1cHRzLmgiCiAjaW5jbHVkZSAiaGV4c3dpLmgiCiAjZW5kaWYKIApAQCAtMTQw
MywxMiArMTQwNSwxNCBAQCB2b2lkIEhFTFBFUihzaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIAogdm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9M
T0NLX0dVQVJEKCk7CisgICAgaGV4X3JhaXNlX2ludGVycnVwdHMoZW52LCBtYXNrLCBDUFVfSU5U
RVJSVVBUX1NXSSk7CiB9CiAKIHZvaWQgSEVMUEVSKGNzd2kpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCBtYXNrKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgQlFM
X0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfY2xlYXJfaW50ZXJydXB0cyhlbnYsIG1hc2ssIENQVV9J
TlRFUlJVUFRfU1dJKTsKIH0KIAogdm9pZCBIRUxQRVIoaWFzc2lnbncpKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBzcmMpCi0tIAoyLjM0LjEKCg==

