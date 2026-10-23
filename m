Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB660606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IcFOUrPl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZtBXYJju
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4TA-0007Ns-E9; Thu, 22 Oct 2026 21:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4RN-0001oE-A2
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4RL-0006Kp-9M
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:28 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1F3iH2376527
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fesP+RyrsGgXntCrui1awvCENUGOY6DXhSodnnO06Ug=; b=IcFOUrPluxpwuhyE
 8rw4d9CiS/XWrNayFKp1Twzqn6YF1bPHszGX/wh97BRwhr9lwj4CRXj5YjMye7+j
 paN1st2Un60I4OzqXwhnO6gJdRrAIg7f84BO13Z4dLwcTKZ3tP18YJFceiBY+mMw
 lZixLGJxUApY15KPa99qeWCbsAdeAobJ2I/BQS5d1ZWySd3kUj8X24AUHyRpsdeq
 IuhfjiDof50pJWB3e+oevtWA4tCog9lmUAYlFPawg5y5irPbJhmxoMHJnAvC8qz0
 mzfrx7AyRG57b2j48T3cLY0eNxEXv6XKOVaP8IXfe/NPDRQHSyv4zSGTxE66o9Zt
 iEjveQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmr9btg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510d0baf63so1020746eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720275; x=1793325075; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fesP+RyrsGgXntCrui1awvCENUGOY6DXhSodnnO06Ug=;
 b=ZtBXYJjuda50mBqWsBH6P3F3Z6e30W64K/x3OPH0qi9yEIPiRn2fwTktmtQNyRmNq4
 l0Z57wEYs7GB0Qa8eiIkxRSsy+Hhs4ivpqmFcROgsKHCsgzyXCxAB86aOxJ5oID908tO
 qIwRpmq+2242zp1JZg5hZwxyCZx4M70zNq1Naoj+xz1CvdMeCHhxhFVubkewKrXIx0F7
 5n9lk0KJSLCoqPY73JeDUcKuev0g3PRRA5KsZHXE2HTBKzcyr8IdKrQTwN54Ff1ji8T5
 r6DCbIABjd9do4k8kRujVi8pMIilr+QnDcco4Rjsts6uedCy+DsYYRuCUjeB+l2E/Tlw
 3RyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720275; x=1793325075;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fesP+RyrsGgXntCrui1awvCENUGOY6DXhSodnnO06Ug=;
 b=mjjnNwfRNosaM0p/i/0A8NymnPu09K9+WsJpuLlbNYc5BPZJ7uL4eTwR1M2dGywCRV
 n0qO6dGkJrQ6gJmla70rP7LkudsNL/LhQG+VywFmzJdvYJ/VjczFBdTzi1bUgAllQihi
 5OPxw3BeZ9bmL3Lgy4yA3d1Ko8VHRFMkn1EVcpqY08wHWGoyte3mnihOfdQMkSFhF2dy
 2CI1Kvd1WrmfoQp8MbD/ZJ2Qh+uXFwIXVguGrcFpa2gIk0fPCfoS47Ma6jYn8KkvMFw6
 5S4IMtdEclUx8qx2mV6wrrPTjWlNjTeVDlnFp0UD65P6YAVwrfT5C3nnImMwpiPSOliF
 8ohg==
X-Gm-Message-State: AFq9FYIc/UWlwOZD2T7B73GwBi+icicxG32LntmmaFoSZWtKM+BsnHO1
 BjV6u9hJ/Mkvg8cHo03w51l5eJ9OJrl0ucNdAkwlgPP3ZCDv8NIwegzKtRuFe9WBsOzTOOJlL+Z
 TbvvWYTBbUb3U3bzuvibSPAYP2x7MtuGX5Be0dKV/5zKutMWrfapEtCD7oUrwpaV+7Q==
X-Gm-Gg: AYBFou37fd/BmxOzAc/GBxmFDtyZdE7h/9p30KTID5dAL+B1kN0zbX6WRLMNpquSdvG
 IGOJ4edCwKzmgvDnFjiHEnsqLJqNh1dZE0OG9oz0ez3UfTgnS/q3fsY8+MjJMMbcwm2BTpw0giI
 uX68kBvfq/fVD7qd+2Upm4Y6MlPkxyZETB5jxxS36PlqDSy1mYBfcvAHKJrkQJvCtolB/GYUTz7
 vBR/4e1NOjxj0vsE/OxDdbHAEM8MCA5Bos4xbHI2nOdAZXL6Cy8vO0q8Ve+KN5Qd/6c7JxEPqdR
 zcPuorau9xoJ3vAUK7R+ApLIzPdhSyRqtACLdUMc4fwjSJUmE/h+dj0LeRLtqcfd4ZhZOMNTt45
 nckkRb7YSjdG8+EMSnOjOjixZsv5DrywAtlv8/UfN3R9kkrRS
X-Received: by 2002:a05:693c:894e:20b0:367:3d68:8480 with SMTP id
 5a478bee46e88-369d8fab1b2mr991166eec.0.1792720275236; 
 Thu, 22 Oct 2026 18:51:15 -0700 (PDT)
X-Received: by 2002:a05:693c:894e:20b0:367:3d68:8480 with SMTP id
 5a478bee46e88-369d8fab1b2mr991146eec.0.1792720274674; 
 Thu, 22 Oct 2026 18:51:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:51:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 19/43] target/hexagon: fix semihosting ACCESS filename handling
Date: Thu, 22 Oct 2026 18:50:16 -0700
Message-Id: <20261023015040.2473105-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: e8-vMtsps7G4dzm-xqHWAVZhCMyuwE3b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX/FBopI77UJx7
 obKNmSVUYhI0akpljtAdEnT0fsS5BsAarwhPjaPlVUzyjN2/sptRzQonRbqN+78z9CWrBii7mCW
 OfcnN4G5WBBZTr0+POJ+sFrs8jFz8os=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adabd93 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pS50CBgNNeok3lFgILkA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfXwq7oJQS2BHhp
 P4RWkbfBEQukCT1sA+2Ismn/NKJ/RJ05m6HsrseJFZQrD8kYrscBmEh1mEX0gx4/GlFqujaPkDQ
 J+PEYLaqXp5m4rrk5yinseRqnTlmWg66FGXEtRanKJjibODFSOwxGZpIVQtbOzR+OYnr3rlDA4U
 v7zEUL73GDkjTiCdXFdhcSOhFRdWrq8FMxb/Sn8wSpZTYF69p7V+Xbbi0a+AHGpkSMLwlxrG5mo
 0KR4ts1bhdV3jsiavegXqFIFB0DFkNRi30MgFYK5fD45V3fqX628RvrH7mMq7YQNZtNn7Fw+rmm
 CJsuEJda2Xfvg33WlU8BMhepnfww8fFwBH4CJPWiSRjEnKFRTgRuZXHA+UsoX4hSjFOp6tnK0p+
 n88kScTu1hElYq1ZJlLS8qNVkXMdeg7rlP4i5l74LIsOMnm1wLynIkmYY0B7uBW3RZKjXvAtc+7
 bOQVoacxWHOfrCkY2cg==
X-Proofpoint-ORIG-GUID: e8-vMtsps7G4dzm-xqHWAVZhCMyuwE3b
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
aS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKaW5kZXggZWE1NTJhMWYxZGYuLmJiMTNlZjVl
NTIzIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYworKysgYi90YXJnZXQvaGV4
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

