Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB746606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J9K/q/Rl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U2ZFGvOH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiKi-0001g3-4G; Tue, 27 Oct 2026 10:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiK7-0008Hw-Rg
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:38:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiK6-00069s-6U
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:38:47 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoYfm1850899
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zoPhXt5MgTGgv/U6LVqqDHZ/DdlUZ9obDVPzMaBq3H4=; b=J9K/q/RlnjisB+Er
 Ojh2HXPqU2pggn+e1FVXrPw8CpCokKTgcm37Znl8KlPpr43dAKySIC+4zfbmVHyy
 d65HJLo7CfF08UETdhbZxtGvxEXLJZ9aKO3gTQbz7RfkMRJHzyKg9WW7lncGuhbj
 w4+rNMD0HErO1f3SiMP2Shlp9KZB+ZoYwVDsO58JOa9dWX9AxPRjqeBpkAwnOSvO
 sJ9Z9cFgK6B220YNmrrMNVDZlwiZIO3kTcte2yVsxwHXNh0evxApQ73S2cu5X/tv
 GdnfTOKF17yAGmqJ/PAgzkpLENf69SCi/UYegGqjydQzlKA25GXq4p7ezjDNWv6o
 uEfzuw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmc4fw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:38:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ada8bc8575so6405636a91.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111924; x=1793716724; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zoPhXt5MgTGgv/U6LVqqDHZ/DdlUZ9obDVPzMaBq3H4=;
 b=U2ZFGvOHDLRy2NKvqVKGxXpbU3epmifIaJ6pObV3gGI3Mb5Bs/cQXDWVTQtQ1EdXt/
 XggnTxvVwJGqVgQkOgnWs1OsTknCAnyKBDhtnkcGxhxQwgg9y6aPoILAO9kPDZF5tDTp
 wgW1GZltopwnwQJp83vt1Xcg4I4L4ZjL6U1ZKD7uqQN1QlQMl+1TE8jh52HclCfMhkBb
 wikrC6Axxy5yBKoXqUbSoXFus+g6fdPujkvCex3CTR8eXiJ1y/KVVpuekQnc3wHxliYC
 aoOMFo7ibJbzYU13Ahvi4X641+j9wuxVcnF6dbMaDa3NNKf7mNq1pgKu5/zc8TEe/5/Q
 N9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111924; x=1793716724;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zoPhXt5MgTGgv/U6LVqqDHZ/DdlUZ9obDVPzMaBq3H4=;
 b=bBougretMGK1W28cQPEyPHAPX75dPyEYKfBexxgF2dCQ2FVYImXsx67KoQc/qZC9tA
 sTUph71v4vF3V2O9KGh9Zf86/RnytHEWdmyZHJYkMq3O+oJ8qgamceOYX6LsEpbcqb7i
 3Jb/v34ZTa3q+xnZ9oWGyxaa5MhguACN17BKyDdo+Hj9Xfs4/uQ9uqaDcMcZgDFUuRty
 9+2PgZdDbBHRe7bc05mUMBuEIhkYrcrb2uFM7yI8YNPLmQ2iiRrFgrW7Ve2h7o38kFeX
 cROIDJgvdkGTen5MQEgFCB5HrjIxyBhs2SQQWPySlr2fDkxABQSD0rSlwwPE9AZ1g71h
 ETXw==
X-Gm-Message-State: AFq9FYIic0csdJJtAzgNCqDEK9uAiioTYTIG8Y6fo0g7VPq4kOT7OY/O
 JsXeYpDv9lP2Jb05M4RSChCZ23H1cJd3NsiWlEHB6JuxAb0bChwwZOOpptWlxpZJUqGKkXtEAmM
 8HLneZQz1cRmjvJlWqE7gJwQPem47CEVK4n4Ihy7xTAANNbNtpoXg0TJjQLPXpuNglg==
X-Gm-Gg: AYBFou1OpMrMNwXEJBFZRndlLnecAdwbtgm4F6TLFgTbemePzDd1Bm9mwp3LA2/O26F
 SX5WYwQuuhAYtm8fHEvz8TIfkuuSwRgGZSfj/HiHBaIapH1Gi6I02Oyau9818ymE3f52i+OqEuC
 v2FbQC0My+k6MN/+L02v5PFws/sffHMzh2IjCVfqhv2nSGNZCeReEcMb5Q0xWVKB8BbSv1H/H6H
 RBNHc9WrXt12Os0r9uel9h5vqkxmFHdVypzhvMJbWjepF6HlegIfV1+aozYaPXiK5OVd6J0x1CE
 orNAz8yR/a5gnH/s2u6v+GuaIrGJmVlFtH5kSKpuapr104wzVKmXKAcQ1OVTQYLGKkhhOw8jBmW
 vXWNU9+WBMqdo6bpltokuIVvkO2h8bkxLG+Gdwg16ZgtFYiQ=
X-Received: by 2002:a17:90b:2645:b0:3a8:878:ebab with SMTP id
 98e67ed59e1d1-3adead4c29bmr8471627a91.35.1793111923981; 
 Tue, 27 Oct 2026 07:38:43 -0700 (PDT)
X-Received: by 2002:a17:90b:2645:b0:3a8:878:ebab with SMTP id
 98e67ed59e1d1-3adead4c29bmr8471606a91.35.1793111923486; 
 Tue, 27 Oct 2026 07:38:43 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404dde70sm4056102a91.1.2026.10.27.07.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:38:39 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 29/42] hw/hexagon: serialize config table as little endian
Date: Tue, 27 Oct 2026 07:37:08 -0700
Message-Id: <20261027143721.4125584-30-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfXza3vazMzW8Il
 x/93eb6RobfEhNU5OwegydH2FPs+h6XA0eRAy/NaeWhS0FPde4J9HNy9aDMOs/tGgHKTLkfBeky
 O0eV6wkLhZiGy/N6nPL58g1ZTyAr4i4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX/LBP6eB/zGb2
 9uTNSsJDUzNqXY4yLf8XaeI05nBpfEhhE4bNUaIRozWfYDH4wrZoFs47yVG9OrdqHWJjStgI2aB
 j4icskbztY29aykQRxEfYwOpg7nchv6Q0N7cajY+yqmMtiRdhFQ0/3twyBNOzeJ9/FhnseLBKXS
 b06Cv6ma+8xcCq+Bd3rSxN/GgCtgezUQdVyFj5AQs5jtGS20Z2Ti3P1gsT1WsFV9UcQqT19I0we
 u4GG1aPiC7bLompjugaVSMSqIWtwL1FOCln60eK2l72VfYx98E3gnWuiq3i8xVKBiBjeq2obJJ5
 V93TVNo9l84XJ55u00GhtdBv11l+GQWMkLww5B48SPSLk5Qk/RLbkWJom6JPwyUEByEjMemyEj0
 BbsryvAdegAjV0Dm/EjS0CA9fG6aR/5w64zmd7AExcE0k/1Voz5vHASlrTkosM834uHXlmwD6Py
 gQmLgVTHhBC2bcTq0sA==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae0b774 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=5Al4mlNl2lj96zGDs44A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: fcWg6uhQk2IdR4NP7Jqm6ojzR0GwlEZx
X-Proofpoint-GUID: fcWg6uhQk2IdR4NP7Jqm6ojzR0GwlEZx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Q29uZmlnIHRhYmxlIGVudHJpZXMgYXJlIGhvc3QtZW5kaWFuIHZhbHVlcyBidXQgYXJlIGNvbnN1
bWVkIGJ5IHRoZQpsaXR0bGUtZW5kaWFuIEhleGFnb24gZ3Vlc3QuIFNlcmlhbGl6ZSB0aGUgUk9N
IGJhY2tpbmcgc3RvcmFnZSBleHBsaWNpdGx5LgoKRml4ZXM6IDE5Nzg3MDM0OWYyYiAoImh3L2hl
eGFnb246IGFkZCBoZXgtc3Vic3lzIikKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4u
Y2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmgg
fCAgMSArCiBody9oZXhhZ29uL2hleC1zdWJzeXMuYyAgICAgIHwgMTAgKysrKysrKy0tLQogMiBm
aWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaCBiL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhh
Z29uLmgKaW5kZXggNTQ4MTM1YTdkZDkuLmM0ZTc4MjE2ZmI4IDEwMDY0NAotLS0gYS9pbmNsdWRl
L2h3L2hleGFnb24vaGV4YWdvbi5oCisrKyBiL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmgK
QEAgLTE3Niw2ICsxNzYsNyBAQCBzdHJ1Y3QgSGV4YWdvbkNvbW1vbk1hY2hpbmVTdGF0ZSB7CiAK
ICAgICBNZW1vcnlSZWdpb24gcmFtOwogICAgIE1lbW9yeVJlZ2lvbiBjZmd0YWJsZV9yb207Cisg
ICAgdWludDMyX3QgY2ZndGFibGVfZGF0YVtIRVhBR09OX0NGR1NQQUNFX0VOVFJJRVNdOwogICAg
IE1lbW9yeVJlZ2lvbiB2dGNtOwogICAgIERldmljZVN0YXRlICpjbHVzdGVyOwogICAgIERldmlj
ZVN0YXRlICpsMnZpYzsKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4LXN1YnN5cy5jIGIvaHcv
aGV4YWdvbi9oZXgtc3Vic3lzLmMKaW5kZXggMzgyZjQ1YmQwOWYuLjFlNjU3ODI1NWViIDEwMDY0
NAotLS0gYS9ody9oZXhhZ29uL2hleC1zdWJzeXMuYworKysgYi9ody9oZXhhZ29uL2hleC1zdWJz
eXMuYwpAQCAtMTM1LDYgKzEzNSw3IEBAIHZvaWQgaGV4X3N1YnN5c19jcmVhdGUoSGV4YWdvbkNv
bW1vbk1hY2hpbmVTdGF0ZSAqaG1zLAogewogICAgIE1hY2hpbmVTdGF0ZSAqbWFjaGluZSA9IE1B
Q0hJTkUoaG1zKTsKICAgICBNZW1vcnlSZWdpb24gKnN5c21lbSA9IGdldF9zeXN0ZW1fbWVtb3J5
KCk7CisgICAgc2l6ZV90IGk7CiAKICAgICAvKiBNYWluIEREUi4gKi8KICAgICBtZW1vcnlfcmVn
aW9uX2luaXRfcmFtKCZobXMtPnJhbSwgTlVMTCwgImRkci5yYW0iLCBtYWNoaW5lLT5yYW1fc2l6
ZSwKQEAgLTE0NSw5ICsxNDYsMTIgQEAgdm9pZCBoZXhfc3Vic3lzX2NyZWF0ZShIZXhhZ29uQ29t
bW9uTWFjaGluZVN0YXRlICpobXMsCiAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X3JvbSgmaG1zLT5j
Zmd0YWJsZV9yb20sIE5VTEwsICJjb25maWdfdGFibGUucm9tIiwKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHNpemVvZihtX2NmZy0+Y2ZndGFibGUpLCAmZXJyb3JfZmF0YWwpOwogICAgIG1l
bW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbihzeXNtZW0sIG1fY2ZnLT5jZmdiYXNlLCAmaG1zLT5j
Zmd0YWJsZV9yb20pOwotICAgIHJvbV9hZGRfYmxvYl9maXhlZF9hcygiY29uZmlnX3RhYmxlLnJv
bSIsICZtX2NmZy0+Y2ZndGFibGUsCi0gICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZiht
X2NmZy0+Y2ZndGFibGUpLCBtX2NmZy0+Y2ZnYmFzZSwKLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgJmFkZHJlc3Nfc3BhY2VfbWVtb3J5KTsKKyAgICBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0la
RShobXMtPmNmZ3RhYmxlX2RhdGEpOyBpKyspIHsKKyAgICAgICAgaG1zLT5jZmd0YWJsZV9kYXRh
W2ldID0gY3B1X3RvX2xlMzIobV9jZmctPmNmZ3RhYmxlLnJhd1tpXSk7CisgICAgfQorICAgIHJv
bV9hZGRfYmxvYl9maXhlZF9hcygiY29uZmlnX3RhYmxlLnJvbSIsIGhtcy0+Y2ZndGFibGVfZGF0
YSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihtX2NmZy0+Y2ZndGFibGUpLCBt
X2NmZy0+Y2ZnYmFzZSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICZhZGRyZXNzX3NwYWNl
X21lbW9yeSk7CiAKICAgICBpZiAobV9jZmctPmNmZ3RhYmxlLnZ0Y21fc2l6ZV9rYiA+IDApIHsK
ICAgICAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X3JhbSgmaG1zLT52dGNtLCBOVUxMLCAidnRjbS5y
YW0iLAotLSAKMi4zNC4xCgo=

