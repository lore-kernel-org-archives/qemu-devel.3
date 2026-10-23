Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EAD606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K4P8/d7z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OEmnOefo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4Rm-0002GR-Br; Thu, 22 Oct 2026 21:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4RB-0001MZ-49
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4R9-0006JD-G3
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:16 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1EvwS2376093
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EXMlL0CQEUWxaU5cW50xDxNN5MRk9w89xRLd3/Rde3M=; b=K4P8/d7zXkGjJ+D8
 wvAZo3MW9qMNlLoQporezLn2DosDN/bCm+bkhWJidsqlSwQ/BqXLslVVC6gw8kSo
 aPmuVXLLqWqjJ3hYvKLfqwSCv6sI+NhxvbULM/B7QcztM6Mr1vJijOeQXBYrf8kK
 zidhO0shIhyMhLALrLK9EUObp55fG6trhThSA998SQGCNpeUm9SKdI9dxGKDwnNJ
 35KgH6xTQXTaDZfoVgtI36iy1Onq6g4WSOufRNVnSq0dcnzH2g6Rc08uXudyDVYe
 74cdPDkwptaRAsWLfhNENUSj6NlQCmJ5ClC5tMZwH7jTbYaS1GfFfh1LavsUC3B5
 vJqDbA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmr9bsw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:04 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35c3c370b17so679331eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720263; x=1793325063; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EXMlL0CQEUWxaU5cW50xDxNN5MRk9w89xRLd3/Rde3M=;
 b=OEmnOefoZUNA4iDEvBbeN0a8dtTPRFD4oHJWPu75v+lNDn6x3kGELDxrO4DccHMm5s
 wqJ9qZlsYIQUqVCuhAZuJGnI0UpEtrQasN/DMCD38Zvhywjg7zUCEgMjRFI5A0peHyhS
 JPQRuW6Mv5pXpjm2CBIz2d9CN0R4J7rrYGU5df7XLUB6L5q5O6p5dfLxwDURyn1uxJUk
 bH0rGdlsowrohUUT/S3G9Wsjwbextfx58SUDtx45xwlK5WJradCuZszimEPbJ+/Rmw8A
 j9KD29c5o06PXNlssLAY6pE0mPpv2nIPF0CK6wGjghnnH9uz3adrvVFeXNAx0seWk39N
 8uWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720263; x=1793325063;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EXMlL0CQEUWxaU5cW50xDxNN5MRk9w89xRLd3/Rde3M=;
 b=WcfwkKhwevr+yw3XN+6vJc7kip2wsj+VYQHgr3pSOzxbKNfoUmhDXPjf2vnrfDos+P
 BK4FjkKalQIjHnYEXFExfS4iHA3vRzy7zM7JTYbIlcktUesjsGGensTj01ZJdFcUigT/
 voFtV7/FqCyQqW7ZLKFNezMDLpPAu9eu7wtR9M3se4fMNZKyXM7sw7ba1BEzEBJgzAoi
 HT9Uq+jEAHdMouLuwgMC/Ea/JJQK6NU2rrg+jTCjuJyCs2kzFzKE870+AdEbDmo6SvGY
 cAgSn3Dqn0nIrs84thDU/yypmGw6B5rqNpoq6l0wRCQSDJVLCyq+sCiZzGPZFEjD1SgC
 t1gw==
X-Gm-Message-State: AFq9FYJvN4PR+sHx+2Xvd70LR1e8++tkMJ5sgpG6D0iahYngFupipJH4
 G3XgcPijQJto0BYe8ek1yZSywpvV1TLyFXc3iLgxcsqTIk3haMIgvYRhLXpfox37AsBeH014QLS
 eBeG/Xst86HYvVK9Riwm4RE/oT7Do0BpyEdIY79l86I4oj8OfAUcKU42+9p9orWee1Q==
X-Gm-Gg: AYBFou0Mo/xmszOospIJbZughBaKY7L6LO9x4CxKr+nHfkb8CNf3t+GxdbNUu4EGU8J
 CMJqX6uab8mylv2qRb+ZB4XZNI5NOieEPgLuI/KncHyA8BTQmuTEmJ72xI4ISpCaIpgMfGcIqOC
 KzsbAhDHyd9fa0xDQhWA9WTxRgKxCffjxCXAXfNmHRQIbe7RrYYEfBjyG1eJ3RxXT+nZ1GzOB5W
 NYi9Fi/rM5AcE1Xvlbw3woo/VjJ8ySMp4fghVzUSiAnwwvGfHPsCS6O3czr6QZ5MQ319I+cKRbQ
 q10X+YYuGiSPn5kWuK7uKLrW08vj2zjmfGVEAt3v5dzD6fmBfnP6lGnT4FufyUiJkxePrPxjSpZ
 Hs1gk5zVvfGF6ltROPDFHzWXpzEevm88mapH8L9fjaQlvGX0z
X-Received: by 2002:a05:7301:78c3:b0:367:363f:6fe4 with SMTP id
 5a478bee46e88-369d98b94femr1073054eec.32.1792720263522; 
 Thu, 22 Oct 2026 18:51:03 -0700 (PDT)
X-Received: by 2002:a05:7301:78c3:b0:367:363f:6fe4 with SMTP id
 5a478bee46e88-369d98b94femr1073026eec.32.1792720262998; 
 Thu, 22 Oct 2026 18:51:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:51:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PULL 12/43] target/hexagon: preserve callr target when Rs is LR
Date: Thu, 22 Oct 2026 18:50:09 -0700
Message-Id: <20261023015040.2473105-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: tKVRiSaMarxaVtPg1GtUk28IV-nk1M9q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX8eMDH8u6Zf60
 XH4HRBxkejxP6fo5q3FEMlHt+N7Qg8wvYlUzSDHoEx9RO8uWlvcAeKkDPRO4P/gktpsKXvOmV6p
 gGIImtqc6Dg5RZqqKttiYsNlJYKHvIo=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adabd88 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Ml5uk3Oo-jtE3ATjI50A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX6ip8gb/nxyLg
 ux+H2V2iyhv7mt/Z/nUNiVluUeGvY6aD5c+zRYOEGuAKDgMDzWJiNntHzydsHTfh/l687OBWZvW
 KobdYqWooABH1Ci0lYX3uT6fbd/W2vAfQ2K2R22TMHFc+g7UxLdYCpkRj+RZNtIfaSdzFQzjiSx
 kb07ZAnZ3VLT7whxLzUKQwAzSjt3IO9zF659QHMJi72zX5ZPZHHuzKTJSo8I9d3lbZYJJdQCPxJ
 yyB6W7P+00p7mQQzNA/yheziuGHX6woVCbZkqemAz8+1sQu2bVngoB/v8yFXZyW3vfIL+AYYphL
 aA5IxVQq+4Zffv+ZqFtonYvXLflLuM8PuDdhEUx86mbGzs5nyNxicr8lJ9ktEvVyf5PEWClMlXT
 csuzD932KIYVzGDr2R2u8R+6iX9I0fFa3A1EkR7EovYFAtyZWd5If9tHIj5qaWwgJh+Pd5fjQKR
 Tsivpg8bk3iEyqUfxfg==
X-Proofpoint-ORIG-GUID: tKVRiSaMarxaVtPg1GtUk28IV-nk1M9q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230007
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Z2VuX2NhbGxyIHdyb3RlIHRoZSBsaW5rIHJlZ2lzdGVyIGJlZm9yZSBjb25zdW1pbmcgdGhlIHRh
cmdldCwgc28KImNhbGxyIHIzMSIganVtcGVkIHRvIHRoZSBuZXcgcmV0dXJuIGFkZHJlc3MgaW5z
dGVhZCBvZiB0aGUgb2xkIExSCnZhbHVlLiAgQ29weSB0aGUgdGFyZ2V0IHRvIGEgdGVtcG9yYXJ5
IGZpcnN0LgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJA
b3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVs
QG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5A
b3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyB8IDIgKysKIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9nZW5wdHIuYyBiL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jCmluZGV4IGQyMzRmOTk0ZjQ2Li5m
MWQwNTI5ZDBjOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vZ2VucHRyLmMKQEAgLTEwNTksNiArMTA1OSw4IEBAIHN0YXRpYyB2b2lkIGdl
bl9jYWxsKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcGNfb2ZmKQogc3RhdGljIHZvaWQgZ2VuX2Nh
bGxyKERpc2FzQ29udGV4dCAqY3R4LCBUQ0d2IG5ld19wYykKIHsKICAgICBUQ0d2IGxyID0gZ2V0
X3Jlc3VsdF9ncHIoY3R4LCBIRVhfUkVHX0xSKTsKKworICAgIG5ld19wYyA9IGdlbl91bmFsaWFz
X2dwcl9zcmMobmV3X3BjLCBscik7CiAgICAgdGNnX2dlbl9tb3ZpX3RsKGxyLCBjdHgtPm5leHRf
UEMpOwogICAgIGdlbl93cml0ZV9uZXdfcGNfYWRkcihjdHgsIG5ld19wYywgVENHX0NPTkRfQUxX
QVlTLCBOVUxMKTsKIH0KLS0gCjIuMzQuMQoK

