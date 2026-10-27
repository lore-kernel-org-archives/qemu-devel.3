Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B04606A33E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XoDdBQp6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Di/M1tOR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiKt-0002Mw-D6; Tue, 27 Oct 2026 10:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiJj-0007t7-Q4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:38:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiJh-000664-By
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:38:22 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDo0cD2344178
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BK+jQjz97tQKBdQJfiukJbaZPpzX5V5vzLGZhYgwhaI=; b=XoDdBQp63S6k7sCf
 OUfyHAYg4a81HR45ECfsIcgU3mn8pfTk8frdKs70AswuKdmhVdufsaiZGaN9RZRN
 DDI8d8CyI/ed6A3NlapfThTVoxwYIDfghZCHDBZedeE6jQtyKMAkFwcmZyLhOq25
 9SGrHIm5Tm1I1y9fXJLODRqxLCGHsbVRjyBur2HqF3ooSxumfzF+Np7kkjX2d/Qq
 1CO/fngC3LQ6PXKnvb71P2quVwj+8HfXCdg4nvF+kBKBT1pgPZdx9M94CXfqRHq1
 AxRPWa7l7xpP2qMFLOmo8yrWLx/XnildKjZ/+6mOYfGNmSYhPNPp4bPxIyyK7ZQt
 gBEqSQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq69d4g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:38:10 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3adad90c894so4516266a91.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111889; x=1793716689; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BK+jQjz97tQKBdQJfiukJbaZPpzX5V5vzLGZhYgwhaI=;
 b=Di/M1tOR3WX9xawJbNJyDHVl3odbM4Egpb88bb+63RcZ9MGgSlg1KZEmFTuOs0VJYq
 ZjI20iQ3YnyPLrzqtl2sM4g9OJGEus9rf6Hba92bmsMfRj6M1PkHUB+z3IMm15NESMYC
 KosDAOFuR23b4WHcujTgbekTQ+UpH7ays3hfFpDWaFmkh/JG+CQO0x5SmZNhKMwAW/C8
 BQfCBPRFRAsE9MvBK/z1QUI+rNpM0g4+YjdLanscJbo4ErfM9aF2NYd2C74PzgJcKedt
 ZtzXduOnutX3IdFjB/TMj+22D0FXah83V2AdoFpHzsw7rSJVoO27dgi6epDa4xYuQQ0h
 4hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111889; x=1793716689;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BK+jQjz97tQKBdQJfiukJbaZPpzX5V5vzLGZhYgwhaI=;
 b=zKDNGgGu45nnXC6ViW91oEbwqMhDhhItoVvtykMJQxAeW9hgfPrWOMCRhv7P31ikYD
 hjlIkIBcXcF0Qp7uluCQdWJw3A1W+92HDypwvlXF0NWPK5u8fneeqfpUmZqp3xB5GXZj
 CQcBjdBZGZ4KCFDvzPVKM4BLPGNY+9Z9WU+qcS7dNLSX2DdW8Es5SJ+ZMBX4iSAsWOS3
 QxNgpcrFFHfjElgLJYUtosL/XvgUeQaQiqgB9x3N2w2B1yrsCeDXvuA9SXRC/TK8Rp86
 2T0SLrx3UYE2CNbP9LvYPQBqUVNYxqcdO66Aqm/PBuJh3oV+seTXVrpOYwdpIcVSKcMI
 Yr/g==
X-Gm-Message-State: AFq9FYIgQG2aW2TLaaCX+By0pywHRxCJzXVmiVTcYuLO/YjMR92lv/tA
 xgWk48oFYuVLNG4TSfqL/7WKdz7b6BHc1bp8nwI4M2QhkZRBAavjdl4kMOgneGsLgr27tdB+RNx
 ReeyfEmReQN5I+msLVx6/6FCbl1DnoFG/iKCq/FE68ep+LSONZ+FTJb933jm3c5cp5Q==
X-Gm-Gg: AYBFou19roVk2UCxL8R/uGI2qaO4XHUcHsRA02fzoiVOpMoXGQK4orgzZ/kqNBPXf2M
 MKROa8kaCAiJRkEe6uuDeE9zBx6jCNfDyY961oPnssHkcSn0xDovBd6qAmXNzKa7IBJn+Rrbl2H
 TKpUFF7tVzdNzJ9FNxQ91huEmJYOq9viVkG3Nx8i3081zGkM8/XyR6hksDMbRt6P7SM/g7AfITF
 3MNSaN902qlyNf66wNZWHwte2AiN7S1SajdL8WaCb8dBV8M7Na0Ge2/YNaaxyt8PeuW1JGWhi6d
 CjOSkdv2pbg9pFq8W0HILsEW34SyEsgvP0b2G2u1Ps8MOAe8v5WpM2j2SNXxjxI0QfPIEzVlDLo
 0uWTv9anz7ouv1eeYiuJ/VvFskXK1uxHPpBqPEwcUjQJSWbg=
X-Received: by 2002:a17:90b:4b06:b0:3ad:a8bc:20cb with SMTP id
 98e67ed59e1d1-3adeb120280mr8498284a91.66.1793111889239; 
 Tue, 27 Oct 2026 07:38:09 -0700 (PDT)
X-Received: by 2002:a17:90b:4b06:b0:3ad:a8bc:20cb with SMTP id
 98e67ed59e1d1-3adeb120280mr8498266a91.66.1793111888683; 
 Tue, 27 Oct 2026 07:38:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404dde70sm4056102a91.1.2026.10.27.07.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:38:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 18/42] target/hexagon: fix semihosting ACCESS filename
 handling
Date: Tue, 27 Oct 2026 07:36:57 -0700
Message-Id: <20261027143721.4125584-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0b752 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pS50CBgNNeok3lFgILkA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: rkK0ZXAR_hAtthjRthsOkwSVido1LHKh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX+jQ0XFeDRQMO
 lMMCR+DJ47BcWA6K9Q5d77Wy3n1UELJbce+PBtX3WJXpQQxWq/RaAU9R5fb33WwLdt/jRmHgKw6
 XJCNUKXJuaQj6tZCmCpOU+RwZWyRwV0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX1nndwHDWp+cE
 H3niHUftor5QddavHr9orHg62lmgn2J48T6nbrtup19bk7WjGLBj48TDt9LF4h8QL+4SKiPETSP
 DS8tOWRLH8prlAQzBRV6TlTgMIfmgBVPCVgjdxAzkVMgxGNUEx2UsbgKMaFTzEj8JMqszZxpwm+
 19QtIENjqSukmqQyqwQGYglBu23yqkRuDyvFgS/cHJYU+uK1P0FSP76zuhoegHAMjcKxX6662tQ
 h9V7g6SorVTrSn7AwiWKprjwdeGqeeiux4xNapVLNl4rl/XYr3fim9psV+ETWZ8M718oX0vbpCk
 njw021OMpOxYG8ckLhclq69OFPs0dtgeyrBDF27lg0UpCY8WkXArYIswp4XmaUEanxWtG7n8rJt
 WvkeI8QXSVw1w5EjOSDzf66SJJxeuKH20cwmt1hZvpX8BU3ZpCq3OV5VxOsg8mIV5t9q7v1Uzxb
 P4u1pqmR+jQf7hEWhSw==
X-Proofpoint-ORIG-GUID: rkK0ZXAR_hAtthjRthsOkwSVido1LHKh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

SEVYX1NZU19BQ0NFU1Mgd3JvdGUgYSBOVUwgYnl0ZSBwYXN0IGl0cyBmaXhlZC1zaXplIGZpbGVu
YW1lIGJ1ZmZlciB3aGVuCnRoZSBndWVzdCBzdHJpbmcgZmlsbGVkIGl0LiBVc2UgbG9ja191c2Vy
X3N0cmluZygpIHRvIGF2b2lkIHRoZSBvdXQtb2YtYm91bmRzCndyaXRlLgoKRml4ZXM6IDc3MTFm
ZGJhODhiICgidGFyZ2V0L2hleGFnb246IGFkZCBtYWluIGFyY2gtc3BlY2lmaWMgc2VtaWhvc3Rp
bmcgb3BlcmF0aW9ucyIpClJlc29sdmVzOiBDb3Zlcml0eSBDSUQgMTY4NTk0MgpMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FGRUFjQTlNT3M2VmZIZjJVSFo4ejRjZHZhQis3RFk2
aEpiMmVtWVoyYUxTZS10Nml3QG1haWwuZ21haWwuY29tLwpTdWdnZXN0ZWQtYnk6IFBldGVyIE1h
eWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFBldGVyIE1heWRl
bGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8
YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleHN3aS5j
IHwgMjIgKysrKysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleHN3
aS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKaW5kZXggMmViYTYwMjFiNGMuLmZiNDZjMDUz
NjBjIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYworKysgYi90YXJnZXQvaGV4
YWdvbi9oZXhzd2kuYwpAQCAtNjMwLDI2ICs2MzAsMjQgQEAgc3RhdGljIHZvaWQgc2ltX2hhbmRs
ZV90cmFwMChDUFVIZXhhZ29uU3RhdGUgKmVudikKIAogICAgIGNhc2UgSEVYX1NZU19BQ0NFU1M6
CiAgICAgewotICAgICAgICBjaGFyIGZpbGVuYW1lW0JVRlNJWl07CisgICAgICAgIGNoYXIgKmZp
bGVuYW1lOwogICAgICAgICB1aW50MzJfdCBGaWxlTmFtZUFkZHI7CiAgICAgICAgIHVpbnQzMl90
IEJ1ZmZlck1vZGU7Ci0gICAgICAgIGludCByYzsKLQotICAgICAgICBpbnQgaSA9IDA7CisgICAg
ICAgIGludCByYywgZXJyOwogCiAgICAgICAgIGlmIChnZXRfdXNlcl91MzIoRmlsZU5hbWVBZGRy
LCBzd2lfaW5mbykgfHwKICAgICAgICAgICAgIGdldF91c2VyX3UzMihCdWZmZXJNb2RlLCBzd2lf
aW5mbyArIDQpKSB7CiAgICAgICAgICAgICBnb3RvIGRvX2ZhdWx0OwogICAgICAgICB9Ci0gICAg
ICAgIGRvIHsKLSAgICAgICAgICAgIGlmIChnZXRfdXNlcl91OChmaWxlbmFtZVtpXSwgRmlsZU5h
bWVBZGRyICsgaSkpIHsKLSAgICAgICAgICAgICAgICBnb3RvIGRvX2ZhdWx0OwotICAgICAgICAg
ICAgfQotICAgICAgICAgICAgaSsrOwotICAgICAgICB9IHdoaWxlICgoaSA8IEJVRlNJWikgJiYg
KGZpbGVuYW1lW2kgLSAxXSkpOwotICAgICAgICBmaWxlbmFtZVtpXSA9IDA7CisgICAgICAgIGZp
bGVuYW1lID0gbG9ja191c2VyX3N0cmluZyhGaWxlTmFtZUFkZHIpOworICAgICAgICBpZiAoIWZp
bGVuYW1lKSB7CisgICAgICAgICAgICBzZW1pX2NiKGNzLCAtMSwgRUZBVUxUKTsKKyAgICAgICAg
ICAgIGJyZWFrOworICAgICAgICB9CiAgICAgICAgIHJjID0gYWNjZXNzKGZpbGVuYW1lLCBCdWZm
ZXJNb2RlKTsKLSAgICAgICAgc2VtaV9jYihjcywgcmMsICByYyA9PSAwID8gMCA6IGVycm5vKTsK
KyAgICAgICAgZXJyID0gZXJybm87CisgICAgICAgIHVubG9ja191c2VyKGZpbGVuYW1lLCBGaWxl
TmFtZUFkZHIsIDApOworICAgICAgICBzZW1pX2NiKGNzLCByYywgIHJjID09IDAgPyAwIDogZXJy
KTsKICAgICB9CiAgICAgYnJlYWs7CiAKLS0gCjIuMzQuMQoK

