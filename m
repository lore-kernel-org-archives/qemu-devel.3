Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8D8D75E59
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 16:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEtHs-00062s-Ug; Sat, 23 Nov 2024 11:47:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1tEtHp-000626-TG
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 11:47:09 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1tEtHn-0000N0-KY
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 11:47:09 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ANFUCQI005126;
 Sat, 23 Nov 2024 16:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 //vVRbDMIWAdumv940/3em+M16b+ZbG/FXSeniT9bPI=; b=G2R4umucAmIvGNK0
 pdQiES+pxhywYNBs7zIpVkr7r3lwbB8F8sXwMN8LM2VzjfaCVDXKh+A6NCLqOZDP
 SOHjfYWaBKTayr6XcX1ml8vaX/T8nCMB8TGgLvaYqCCcskP5he1evMbDjmDOK/oP
 j6Ruz11Dqoi1b/8iXzQSeaCAc9rDppgy1hKkV+vlDDwKnlm21G+3UaAM97auBKfg
 oa2qHBLo3XpwOtja7M7vqNsmqmT6va9lTiVvJGU3qm4GbDM/urWy324DrQkBZbfY
 z3pJa8kd8UZwEG6ujEveFtwAkVEV3przBPT792smHlAtNcpjkdZ3oo3jGcmQErcg
 +p6KSA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4334dms8y5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 23 Nov 2024 16:47:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ANGl1eE030370
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 23 Nov 2024 16:47:01 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 23 Nov 2024 08:47:01 -0800
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <richard.henderson@linaro.org>, <philmd@linaro.org>, 
 <peter.maydell@linaro.org>, <quic_mathbern@quicinc.com>,
 <stefanha@redhat.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>,
 <alex.bennee@linaro.org>, <quic_mburton@quicinc.com>, Brian Cain
 <brian.cain@oss.qualcomm.com>
Subject: [PATCH 1/1] MAINTAINERS: update email addr for Brian Cain
Date: Sat, 23 Nov 2024 08:46:40 -0800
Message-ID: <20241123164641.364748-2-bcain@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241123164641.364748-1-bcain@quicinc.com>
References: <20241123164641.364748-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: -OmhCpnNk4n_JskJjefU7z6wpX1_uEnx
X-Proofpoint-ORIG-GUID: -OmhCpnNk4n_JskJjefU7z6wpX1_uEnx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 mlxlogscore=633 phishscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411230136
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgoKQWxzbzogYWRk
IG1hcHBpbmcgZm9yICJxdWljX2JjYWluQHF1aWNpbmMuY29tIiB3aGljaCB3YXMgfmJyaWVmbHkK
dXNlZCBmb3Igc29tZSByZXBsaWVzIHRvIG1haWxpbmcgbGlzdCB0cmFmZmljLgoKU2lnbmVkLW9m
Zi1ieTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFu
IENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiAubWFpbG1hcCAgICB8IDIg
KysKIE1BSU5UQUlORVJTIHwgMiArLQogMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS8ubWFpbG1hcCBiLy5tYWlsbWFwCmluZGV4IGVm
MWI4YTUzZjQuLjcyN2NlMjA0YjIgMTAwNjQ0Ci0tLSBhLy5tYWlsbWFwCisrKyBiLy5tYWlsbWFw
CkBAIC03NSw2ICs3NSw4IEBAIEFsZWtzYW5kYXIgUmlrYWxvIDxhbGVrc2FuZGFyLnJpa2Fsb0Bz
eXJtaWEuY29tPiA8YWxla3NhbmRhci5yaWthbG9AcnQtcmsuY29tPgogQWxleGFuZGVyIEdyYWYg
PGFncmFmQGNzZ3JhZi5kZT4gPGFncmFmQHN1c2UuZGU+CiBBbmkgU2luaGEgPGFuaXNpbmhhQHJl
ZGhhdC5jb20+IDxhbmlAYW5pc2luaGEuY2E+CiBBbnRob255IExpZ3VvcmkgPGFudGhvbnlAY29k
ZW1vbmtleS53cz4gQW50aG9ueSBMaWd1b3JpIDxhbGlndW9yaUB1cy5pYm0uY29tPgorQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPiA8YmNhaW5AcXVpY2luYy5jb20+CitC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+IDxxdWljX2JjYWluQHF1aWNp
bmMuY29tPgogQ2hyaXN0aWFuIEJvcm50cmFlZ2VyIDxib3JudHJhZWdlckBsaW51eC5pYm0uY29t
PiA8Ym9ybnRyYWVnZXJAZGUuaWJtLmNvbT4KIERhbWllbiBIZWRkZSA8ZGFtaWVuLmhlZGRlQGRh
aGUuZnI+IDxkYW1pZW4uaGVkZGVAZ3JlZW5zb2NzLmNvbT4KIEZpbGlwIEJvenV0YSA8ZmlsaXAu
Ym96dXRhQHN5cm1pYS5jb20+IDxmaWxpcC5ib3p1dGFAcnQtcmsuY29tLmNvbT4KZGlmZiAtLWdp
dCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKaW5kZXggYWNjNzQwNWFlZC4uMTEwYTY5YTZj
YSAxMDA2NDQKLS0tIGEvTUFJTlRBSU5FUlMKKysrIGIvTUFJTlRBSU5FUlMKQEAgLTIyNiw3ICsy
MjYsNyBAQCBGOiB0YXJnZXQvYXZyLwogRjogdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2F2cl9tZWdh
MjU2MC5weQogCiBIZXhhZ29uIFRDRyBDUFVzCi1NOiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5j
LmNvbT4KK006IEJyaWFuIENhaW4gPGJjYWluQG9zcy5xdWFsY29tbS5jb20+CiBTOiBTdXBwb3J0
ZWQKIEY6IHRhcmdldC9oZXhhZ29uLwogWDogdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvCi0t
IAoyLjM0LjEKCg==

