Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF332C5472E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 00:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sik34-0005GG-8M; Mon, 26 Aug 2024 20:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sik31-0005F9-6V
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 20:26:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sik2y-0007Lr-F4
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 20:26:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QJGRq2006780;
 Tue, 27 Aug 2024 00:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=0PBXELqD6uwJtusDu94PP9
 fSgDMH1M6FEAboEL9D4fc=; b=SWNNFFWchaPTYNpgfmFAmnI5SC6BldqH8F94wA
 +haPd/zz+/3Lq2cwtbf2tyHX7BdX+bcIwqBLiUwQZEceCjjCkAIolibe4J1aMxbD
 gP85sZSd39BAL0mPHetefPaTeyBqTEQhlGaRd5c/UiyqRgSQoFpqaowuigzJMMzW
 5qmgbiRmrJEheK+TgeeeZoFyiAqEn/PsfTMZBOh6wiC+JgGUXTPls69SbLmAIuZu
 G14wlzYmmINza0DGHhGm07CM8egsbZnGpOzYcwelS19lt0XN2Mw2vyQlC2S61c9+
 gA4a9f62BPE054hvZT6YpR+cvPrGsOMQ8WdDxIkxVp4xQIQA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41796kw578-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Aug 2024 00:26:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47R0QpnZ026024
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Aug 2024 00:26:51 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 26 Aug 2024 17:26:50 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <quic_mathbern@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PATCH v2 0/2] target/hexagon: event codes
Date: Mon, 26 Aug 2024 17:26:29 -0700
Message-ID: <20240827002631.3492200-1-bcain@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: EYMcY0c4CtzB4xSuAZR68Utc0HEoe4z2
X-Proofpoint-ORIG-GUID: EYMcY0c4CtzB4xSuAZR68Utc0HEoe4z2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_17,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=622
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 spamscore=0 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408270001
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Q2hhbmdlcyBpbiB2MjoKCiogRml4ZWQgdGhlIEhFWF9FVkVOVF97SU5WQUxJRCosUFJJViosZXRj
fSAtIHNldmVyYWwgb2YgdGhlc2Ugd2VyZSBhY3R1YWxseQpjYXVzZSBjb2RlcywganVzdCBsaWtl
IFRSQVAwLgoqIEkgY29tYmluZWQgIlJlbmFtZSBIRVhfRVhDUF8gPT4gSEVYX0VWRU5UXyIgYW5k
ICJyZW5hbWUgSEVYX0VWRU5UX1RSQVAwPT5IRVhfQ0FVU0VfVFJBUDAiCmludG8gYSBzaW5nbGUg
Y29tbWl0LgoKQnJpYW4gQ2FpbiAoMik6CiAgdGFyZ2V0L2hleGFnb246IHJlbmFtZSBIRVhfRVhD
UF8qPT5IRVhfQ0FVU0VfKgogIHRhcmdldC9oZXhhZ29uOiBhZGQgZW51bXMgZm9yIGV2ZW50LCBj
YXVzZQoKIGxpbnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5jIHwgIDQgKystLQogdGFyZ2V0L2hl
eGFnb24vY3B1LmggICAgICAgICAgfCAgMiArLQogdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaCAg
ICAgfCAyMSArKysrKysrKysrKysrKy0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCAg
ICAgIHwgIDIgKy0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgIHwgIDYgKysrLS0tCiA1
IGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQoKLS0gCjIu
MzQuMQoK

