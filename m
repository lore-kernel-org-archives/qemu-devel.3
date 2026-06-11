Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF6FCD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXzD-0007nW-HG; Thu, 11 Jun 2026 01:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXz9-0007mM-Sw
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXz8-0000r5-9G
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:47 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GIb33791680
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=; b=pdIvw8Tppd0szibQ
 s9Z7FFOcXWZqa8Z9EvEH1XVOFxtH53PvFDhZlcPDAmbcJZ7zHvyQEAfw/Lt64x3j
 ZqWWxedR5/4mFGS9YKaeNjsw/FDnuSwAVt/o1kzYRB+/lmlbv/SrORylVyQJ+usX
 mVwpPYS3AspPSTMaepYAMJu9VA186IwwoMGBXi2XacpWUzytC3Y3rfWZfljobVFe
 0E5l8Ns8kTBH+7NCu4NIhLjbq69cFsZphhlnBtWHE4FHM2Bm/jIlG+aC065wGyIX
 ESl0UsIuwdBTRi9FBuTfCFAQVnjvgOcTWwoe0/mAeVoDhvXnRtonZweNXlt+P/yu
 pw1D5A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe701s2j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:34 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3074d4102a9so6623303eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155774; x=1781760574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=;
 b=TM0doJGikwsmY8H5s6U3A0xJ43hJ4J2mYtmbgvWRF1pXteJtWOF+a+8ZONakjg0+De
 iyMuereIbNh161otMUrc8yHep7JExY6huq/BHb7RFB2LsxqMVUe2uXnF5W5C2SUYc4gU
 EGehrsGrA+Ag5yQ+dDE1Am1ZtgARszzashAYSus5xUXC2RYTDPrVUyIWxnl7fx/jlyEV
 q6nR4Fv6P0GfKDmnVr0/t61rCz5QWOO+hK8S1PjEo+oyCUS7CPzPq/9EcurkuCCwVsIz
 p2YuCmq1SIQyNyjMRW5Mls41bTjHULRlu1m790kwl/2l7DYSlETEpyoxm9pWmch63Vz/
 Re1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155774; x=1781760574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=;
 b=pEI6+7KinwOw1HdigEFmjIfEWk7WXwxHWD6Wb5wLcCntL/fOgddOgiN6fREZtHXOXN
 5OUSnS05YkbkkfiTjznhv6vPEV7OmACrhnW/UE6MZ+PlwH/f7f/OQi3CEmX8u+E/n6/9
 lK+aVkjCGcL5DmXax2bI96EVgTttA7rQnL/4HamV0W4q7j9GYt5CNaYy83rKc47Jh2+h
 jAT2iTZJSluUix3qUA7VB47BHkSAIxxu4PfQt/MxRR08y0GJPELHOUX0ZYQ+FCM36YrD
 9PybocZZ/q4uReR+LIeI4be7rWa/g6rJ2ibZySqmlGpHRxB1zaLgGPj4nc7EVRgCUUg9
 Xkag==
X-Gm-Message-State: AOJu0YyUbb/QppQZYIDxLZuoqMkDFx9FITlt1MbPnHJryziX9IFrvhXb
 ddqPzwzh1uin9hCcg7DBrIVEbeQtlWQBBP7mAuT9irXQUZV6Jwa/xSOfgkwbGGIlGcUuPupVhu5
 k9cgFqrROH80DnsMzMkRLODevqxicje3VFoUhWQ5MmQJxH/3dxa4U20YJoa8WiYRcAw==
X-Gm-Gg: Acq92OGEVeSBGEaGUi8WYdTmBzDW+ugN9QvOiPdVO4S7SRhdgiEQLUok1lhTJfhPzTe
 GYjDZYXAejwY1Bv6/+9h8W4e31pghA4rL2BV4satcNhKK6Txy2VxvFvYSuie4eLnMFyTlFDCh5E
 hFYcGzF9gNkrKq83adM1/6385epFJvlTcpMs4wKIrWc+Q9G7cujMLZiZs3kDuYMoPKSwzs4CUWG
 CG6L4/O+p0npqkzIsHt1yLaZgBZlVC93IqOOGiSBd8DVw/tAivxnPOQCXzIG4reGzSKHHZo2MDz
 pDV+gBhj5CpReYrtjYj+ASZo+GjqsS8vqt83ivK09OoU3CT+5uHGzSEbHy16sovgm323OohGM37
 8FYk77t2zUd4ToZzZ1HixzBgoYOfwIMJyKbjzsrhjEju9p0bCSvHjTzOcFsusEqO5iFLj8oMad5
 GeMDyU
X-Received: by 2002:a05:7300:2d2c:b0:2f5:2556:5acd with SMTP id
 5a478bee46e88-3080465762dmr1162787eec.13.1781155774190; 
 Wed, 10 Jun 2026 22:29:34 -0700 (PDT)
X-Received: by 2002:a05:7300:2d2c:b0:2f5:2556:5acd with SMTP id
 5a478bee46e88-3080465762dmr1162762eec.13.1781155773719; 
 Wed, 10 Jun 2026 22:29:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:32 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v8] target/hexagon: Make A_PRIV, "J2_trap*" insts need_env()
Date: Wed, 10 Jun 2026 22:28:40 -0700
Message-Id: <20260611052857.3911981-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MCBTYWx0ZWRfX45herNlUDeTg
 Cc2w7yXziRe3iaYnri5AVBiSKq/RPg3dxC6kUh9eM75N6kqrhIa4Zy+zpOFbruIW/2XuKJLhsyi
 qfhjtHgQaumFgA1yWtyu1+viOqTi6v2oCDfrI4nrxiy97h2HJTXihRf8dZpReaerplqfsAKKVJU
 8YAxzZpPbWFpJXBY56PDBpZqZFYMfm/gKHw0dvZzHrn/GvCV0Y1EG/2CAXfO7Pjjh1Ef6W9afdk
 Kgd/GR1lKC4D0C23VHYnn7ium870Dhu9tTGTjOcZJanReDwzudEiPccKdXpATL6KLlnVBR6+QNc
 W3xisV+oTGlDryO8QglCVoxg5y50rzb5bjlhtNmuzi6g6A3JwyyOxacXuXZ/foRZN1ns533KbiU
 dIM3ZZy6BvOjctXmPfVmtVjAy9IbL3K+m0QP5G2/tkjaMKfAkEXmgvhvqd50dVHzhqWRZyF5VsB
 7n1N4lQki2qVD1Rl15Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MCBTYWx0ZWRfXyMJSnCuZZcHU
 UsExmGRlKc+YStlldyo0MowqSS4HHrj58ICibGqFo/TtZffoxf+N0EtsXsoueIUl03YiVldjQEx
 gLcMJ2IGpA6kHfSq/un5ZS/mFC6fkm4=
X-Proofpoint-GUID: hcxUyj-DaMJB7qTNIloqu26eMJDSRvVQ
X-Proofpoint-ORIG-GUID: hcxUyj-DaMJB7qTNIloqu26eMJDSRvVQ
X-Authority-Analysis: v=2.4 cv=Z5Tc2nRA c=1 sm=1 tr=0 ts=6a2a47be cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=923NME1-z-asBZaYXDoA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110050
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IGIv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQppbmRleCBkZjhkM2JhNjU4Ni4uYjU1NWUyYjY2
M2IgMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKKysrIGIvdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weQpAQCAtMjUwLDcgKzI1MCw5IEBAIGRlZiBuZWVkX2Vudih0
YWcpOgogICAgICAgICAgICAgIkFfTE9BRCIgaW4gYXR0cmliZGljdFt0YWddIG9yCiAgICAgICAg
ICAgICAiQV9DVklfR0FUSEVSIiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKICAgICAgICAgICAgICJB
X0NWSV9TQ0FUVEVSIiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKLSAgICAgICAgICAgICJBX0lNUExJ
Q0lUX1dSSVRFU19VU1IiIGluIGF0dHJpYmRpY3RbdGFnXSkKKyAgICAgICAgICAgICJBX0lNUExJ
Q0lUX1dSSVRFU19VU1IiIGluIGF0dHJpYmRpY3RbdGFnXSBvcgorICAgICAgICAgICAgIkFfUFJJ
ViIgaW4gYXR0cmliZGljdFt0YWddIG9yCisgICAgICAgICAgICAiSjJfdHJhcCIgaW4gdGFnKQog
CiAKIGRlZiBuZWVkX3Nsb3QodGFnKToKLS0gCjIuMzQuMQoK

