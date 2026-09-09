Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9137C79FB5
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x49VV-00070L-Qt; Wed, 09 Sep 2026 00:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x49VU-0006zx-1c
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:01:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x49VS-0003u6-Gf
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:01:55 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688MgWbb045619
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 04:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8E4Ymq8STrxDCYX6ChWdHbC8ym/xjtdtnv8X50h5ink=; b=CW0x3E1x3FCI+xEE
 KjHK0GKluXYI7i4A/vaZfqwRHmNhhtIAmNwvLl80UJ3Y11hF1MU584It61EGDctv
 g6kDSa6tZkLhhkPhdKxK6Zqeaf1SLvr4jjjOf+nK9iRlBKBJp51hHNZHu/jw1VU/
 cY6I8LeCnYbOHb2r6OdIVGIZQTkECfCf+1Q3lnLUzaT2KMtpYkvfa2S85aXTU+Kg
 hJiOct60Or2UiPJbUq5x/cdNAK7QlJeWVwoN8jMVSkMGj16ViSI/40OuCbknVBwS
 9dIO2ByUVTfaKZ5/pW8ORYwozGGwnvY02nufBQinWrhC+ZfJvRSNjOD+6gU4uppW
 BLDiIw==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqewhyvp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 04:01:53 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-6b1b6df25efso5692112eaf.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 21:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788926513; x=1789531313; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8E4Ymq8STrxDCYX6ChWdHbC8ym/xjtdtnv8X50h5ink=;
 b=CLX0mCUL1hF+FBoGqUYHJv9PsZUEx1eOBnNJ3Qu0K0gaz2O4Q4u2wQEJEOGbu8d6oE
 dabw/6Mlk6UqEq22h5PsQHQ0/h9jUzG8TdQ2f0sjyek/I+4Z4it2NVT9h4WTExz/7zTp
 41HDngN6087R47tVxHhJSFdrY2yfG56ldw1KulNvNevvLhPepWzU0521JktMdxQoVZHH
 m9Xcf/QMSYc/D65AsN1HXi6rwmDIGRWF2vDVLGdaC0heweS+68SH8kpvS8QBRk8MX88f
 uygJ6/jh2BEa2xCUK8XtHQjqNGdRP4yNPrPEgDcGEBWIavFrvGmMXkyK0RY34GcMNDN0
 wzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788926513; x=1789531313;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8E4Ymq8STrxDCYX6ChWdHbC8ym/xjtdtnv8X50h5ink=;
 b=sJazB/Y/7UrDAUQ6whvtxH8sHI44MVFTU3aNttWW3Uf1YBPrE1phKwxZswJPDE0qq3
 VA123z6IWw66dEc2xgyO4XSEp6qKJJhaG5ZjUluPBlSFjtYDxh6jhMPT60PbJnZG094L
 gf+fcpNIBE3KNkE2slBn/FYUA9iyM1kjymT7j3Du0aGOn5jN4SCdI4NjNfkbOlooZPhG
 7cF4oPjcS9n5QdIM9lwHNnUDNmKBqw58HtOesEp6kev4ZlZa/D9usHX+dlea1JG3aoH1
 nBWvW/dxP1K4ca1lnQBZwOmja4d6yGqiB4goG8NBMJayGToMEBIUorujvwFgdmm6hGdc
 ywBA==
X-Gm-Message-State: AFuF++mz8W5YYQBBzv9ShpqKXfeueSK2fjkhsPrXieOBfq+ShWDkMI4r
 7tAL0rMorEdkpMFb4bPmCuCvHLKKBjvzxpFzwncqilsaqbJZvLWspIS5V6tAkQ8tXa6FJxhic+u
 VFTUnXOmUkd1wZiOzrZeSngBNffY7mEwkv1JwkCdCQEMoCsf4O9xzeyYz2btwj8/Ngw==
X-Gm-Gg: AYBFou0m0qtrMPUGAogAbInFKCa28iMD8sApeYabPjIvNE4rMaR9/PNZelmdOIIXP8C
 Fbbuutahm193n4hrprgEJffzLXLK3F/VsOCdBketsReTg3ex/VVFvvLaAaqfA5prbRFGB1cbN6b
 NnGcoGFhBYzUxEta8hQzkKnqCl+oR+nrl8nmNahwZgQOc/lAY7JhKsp/qxs89qb/MJn+lofBjAK
 sxdDpTbz3v2Khum8xTaXaw4UZgfG/Seb9fweTdhz5xrpIfhhd/xHOdph6jgVY/a5MBFJaIr+4/S
 qTAmUpFpyXs54kEneFxkbUJEmY0JJbMKBQzIGQenqWQ4bPT4gHldp40w+DRbeyA648r1N7ngBsk
 mjJmMLMh3b8WiE0v7NULP1xPwM0qXalqrmke+yOmqD/OD6hg5
X-Received: by 2002:a05:6820:168f:b0:6b1:a11a:eef4 with SMTP id
 006d021491bc7-6b6fbad3850mr18715435eaf.14.1788926512563; 
 Tue, 08 Sep 2026 21:01:52 -0700 (PDT)
X-Received: by 2002:a05:6820:168f:b0:6b1:a11a:eef4 with SMTP id
 006d021491bc7-6b6fbad3850mr18715403eaf.14.1788926512132; 
 Tue, 08 Sep 2026 21:01:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-336c2571039sm20407002eec.25.2026.09.08.21.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 21:01:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: marco.liebel@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 7/9] target/hexagon: widen v81 CPU masks
Date: Tue,  8 Sep 2026 21:01:35 -0700
Message-Id: <20260909040137.3414132-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909040137.3414132-1-brian.cain@oss.qualcomm.com>
References: <20260909040137.3414132-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=cpirVV4i c=1 sm=1 tr=0 ts=6aa0da31 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=CMZ8Hq6IklO77c4-sLsA:9 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-GUID: l6N9C-nK5y5y2wGTdmGHO1wmxz93Q4OD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA0MyBTYWx0ZWRfX7DYDJfZ6hlZl
 EZRZlel8WapAkVtx9cx9bvO1msckDceKGWGlo0qjD/755CAtPo8CmLldI8dlo9BngVXwDdlCRXb
 b14Zp0EXML8yne/+YZsWfHxaBjrMuaS5BgRuNBWyQ6PQSLA2wiTYDgJn4Z1HUg7QlyTqj8aAIgr
 ALT10N5LyUFE8H1GwL1Gb+s8EhH0QzhUKwHKBv7aWGUZ2RZNx7tIXgW8ovYbjP4DcOAhUFQaYtD
 D0BUBfEoRV8QGgNbR4nzqGXcKdH1x2PQODInEpVgElhYNP9+VPK17W8mu/Qyzr5crzYQaG5kCkr
 AI0Yn2wj/ZkfMyaK14QjHqntwWPRhvETKzVanxYXaOhZ/4OOlHypzyeKc04uvddMZ8r031YVNO3
 6+30jOWV4vkiqSTqPIYYUGAvSI0t+DtR7vUz47YEHbyJ+2vNUyWhoO+RS5wuLQe7uaBvS638xyY
 qivUXNK15j9LgAJ/tYw==
X-Proofpoint-ORIG-GUID: l6N9C-nK5y5y2wGTdmGHO1wmxz93Q4OD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA0MyBTYWx0ZWRfX19XP7/uMwwop
 h1dlktUWoh6IrPyuTn/aB4vCxQa80cz7Io51nc7EWT/FdPZiBaPSsdGnUZhAMm1AqV4l6TuAKEA
 eg9a7kPqc9rVPT+WCscvsgQL7UT3rwc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090043
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jIHwgOSArKysrLS0tLS0KIHRh
cmdldC9oZXhhZ29uL2dlbnB0ci5jICAgICAgICAgICAgIHwgOCArKysrKystLQogMiBmaWxlcyBj
aGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jIGIvdGFyZ2V0L2hleGFnb24vcmVnX2Zp
ZWxkc19kZWYuaC5pbmMKaW5kZXggMjk0OTdmYmNjNGQuLmE2YjE3MDExZDgyIDEwMDY0NAotLS0g
YS90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYworKysgYi90YXJnZXQvaGV4YWdv
bi9yZWdfZmllbGRzX2RlZi5oLmluYwpAQCAtNDQsNyArNDQsNyBAQCBERUZfUkVHX0ZJRUxEKElQ
RU5EQURfSUFELCAxNiwgMTYpCiBERUZfUkVHX0ZJRUxEKElQRU5EQURfSVBFTkQsIDAsIDE2KQog
CiBERUZfUkVHX0ZJRUxEKFNDSEVEQ0ZHX0VOLCA4LCAxKQotREVGX1JFR19GSUVMRChTQ0hFRENG
R19JTlROTywgMCwgNCkKK0RFRl9SRUdfRklFTEQoU0NIRURDRkdfSU5UTk8sIDAsIDUpCiBERUZf
UkVHX0ZJRUxEKEJFU1RXQUlUX1BSSU8sIDAsIDkpCiAKIApAQCAtMTA5LDE0ICsxMDksMTMgQEAg
REVGX1JFR19GSUVMRChTU1JfU1MsIDMwLCAxKQogREVGX1JFR19GSUVMRChTU1JfWEUsIDMxLCAx
KQogCiAvKiBtaXNjIHJlZ2lzdGVycyAqLwotREVGX1JFR19GSUVMRChJTUFTS19NQVNLLCAwLCAx
NikKK0RFRl9SRUdfRklFTEQoSU1BU0tfTUFTSywgMCwgMzIpCiAKIERFRl9SRUdfRklFTEQoU1RJ
RF9QUklPLCAxNiwgOCkKIERFRl9SRUdfRklFTEQoU1RJRF9TVElELCAwLCA4KQogCi0vKiBNT0RF
Q1RMIGZpZWxkcyAqLwotREVGX1JFR19GSUVMRChNT0RFQ1RMX0UsIDAsIDgpCi1ERUZfUkVHX0ZJ
RUxEKE1PREVDVExfVywgMTYsIDgpCitERUZfUkVHX0ZJRUxEKE1PREVDVExfRSwgMCwgMTYpCitE
RUZfUkVHX0ZJRUxEKE1PREVDVExfVywgMTYsIDE2KQogCiBERUZfUkVHX0ZJRUxEKENDUl9MMUlD
UCwgMCwgMikKIERFRl9SRUdfRklFTEQoQ0NSX0wxRENQLCAzLCAyKQpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vZ2VucHRyLmMgYi90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYwppbmRleCA5ZjUz
ZmNiNmI5NS4uNGU5YTk2NzBkNTQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5j
CisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jCkBAIC0yNjksMTQgKzI2OSwxOCBAQCBzdGF0
aWMgY29uc3QgdWludDMyX3Qgc3JlZ19pbW11dF9tYXNrc1tOVU1fU1JFR1NdID0gewogICAgIFtI
RVhfU1JFR19TU1JdID0gMHgwMDAwODAwMCwKICAgICBbSEVYX1NSRUdfQ0NSXSA9IDB4MTBlMGZm
MjQsCiAgICAgW0hFWF9TUkVHX0hUSURdID0gSU1NVVRBQkxFLAotICAgIFtIRVhfU1JFR19JTUFT
S10gPSAweGZmZmYwMDAwLAogICAgIFtIRVhfU1JFR19HRVZCXSA9IDB4MDAwMDAwZmYsCiB9Owog
CiBHX0dOVUNfVU5VU0VECiBzdGF0aWMgdm9pZCBnZW5fbG9nX3NyZWdfd3JpdGUoRGlzYXNDb250
ZXh0ICpjdHgsIGludCBybnVtLCBUQ0d2X2kzMiB2YWwpCiB7Ci0gICAgY29uc3QgdWludDMyX3Qg
cmVnX21hc2sgPSBzcmVnX2ltbXV0X21hc2tzW3JudW1dOworICAgIHVpbnQzMl90IHJlZ19tYXNr
ID0gc3JlZ19pbW11dF9tYXNrc1tybnVtXTsKKworICAgIGlmIChybnVtID09IEhFWF9TUkVHX0lN
QVNLICYmCisgICAgICAgIGN0eC0+aGV4X2RlZi0+aGV4X3ZlcnNpb24gPCBIRVhfVkVSX1Y4MSkg
eworICAgICAgICByZWdfbWFzayA9IDB4ZmZmZjAwMDA7CisgICAgfQogCiAgICAgaWYgKHJlZ19t
YXNrICE9IElNTVVUQUJMRSkgewogICAgICAgICBpZiAocm51bSA8IEhFWF9TUkVHX0dMQl9TVEFS
VCkgewotLSAKMi4zNC4xCgo=

