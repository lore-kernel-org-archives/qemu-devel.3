Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31A6606A320
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a3X/qgC9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KZE7m0A7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIr7r-0001K9-Dd; Mon, 19 Oct 2026 13:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIr7p-0001Jk-Tp
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 13:26:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIr7l-0000Om-J8
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 13:26:17 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFPG9Z2589845
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 17:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=9mdpFgYAmrQVrCDVERbSa3
 LI+Gfcbihj3F0oYMsjMP8=; b=a3X/qgC9eimiT4VihIh4I+j2cW4uhCc8fvx3rx
 nEAVn0K9SGw2W1DLd5Q2MMD+Nfpzf0WNqcJWYFYL+RZ2+aoiST2YSvoCOKD0gG8b
 Ix3PBD4HcZbR9j5dtC6tNB71SVRZO3uGdqHEZpWtWtgq6MVJTYw2Yh1eSnz2OvzQ
 HiURjxyM3tq7fwK3ivUQMe+tur/hNKxjJ73G6hR/ndZ6oi5EJglZwnyAADWFc4u8
 35UHoz5IocQNwP7CjuIOMZkNwGh3Ib3LxX1MkWyXpLLQVRdRYsVZiLDUYsFa0AXc
 HV4M35dS68uMfC9w2G4CN3TMQA2KMzonIiaFbhpHL5S2dd0g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3n2ejk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 17:26:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so7022050eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 10:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792430770; x=1793035570; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9mdpFgYAmrQVrCDVERbSa3LI+Gfcbihj3F0oYMsjMP8=;
 b=KZE7m0A7YIKRQU4rpovJAbgCkQYw3C8p54ezPzm31ULqvS4PrWPtWbQJnhSQCvlg0n
 pQHnlgOCqUb4ihNhMvIvTuRoFSgrvzqD2kDK1AOGB+7g/5iN2n53intfXM7UGUFRZPfN
 QpOS1Lo7rhPwRgGOs/RLSvi0UdFu7VKAO1CvCavLViQFoqfZy9F52m/t7mJ2GgOIAXli
 uu8KGrgWNyXJ3sia+bFZecCKp/BnV5uykkXDG5N1cfdIBtIqJkjEdcIGw1ToJfm4biJ1
 LTFydUPn1nIDFAsC7hpJGWym1qzniBjWfPB5QFR7sJnbldTTAEO0mXVUJMeNY6UIErCp
 RbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792430770; x=1793035570;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9mdpFgYAmrQVrCDVERbSa3LI+Gfcbihj3F0oYMsjMP8=;
 b=GHAou9gPuBUkrQVI6Yk2lTYK0wY1aNapTIx+KJz1Rhd2cdXdm2ZmOsH7BpTtjHDurL
 tYSgPSLISj9CvQpjfa5EOM1krTlX0ThMUVf7qGaRb7VfPGMWhKehXe5zmE5dPFvPIg+H
 IipLXoU8UMJbUIF5lpTYPP/jBd3y0Cg4bJK1axPDjZ2LIRK+UKx+Kmlo5FL2VA7rN81y
 W15dLPvuo657KkBZBMYO5cXFfsPEGjNTAxerPGnOvhyRHyOamyJvmoFntQAPBs+K0/2M
 EmbTq1YmHzpLK8bdjipz8L21fIkw5fHGApY44Yp2izw/THe2fzqRTPqqaPePzxUsjl3T
 0lAQ==
X-Gm-Message-State: AFq9FYKPSCLtjkdI1M0H72V2N2HBn05d7ywVSPbHU2FYjdn4VfEd0xCL
 1PPUYqbo9w7pEGqvHG84fm5uDwZCJurq/6svgh5xEPNqnARCbicGBIFBTP/i12n8FY5w+TZZ/sL
 S+I6JO1wjHVaPsRtu0Xf+8qBqBoHhyblu42ugr5kdFOyYwmEBWgwJxjHDEEbnyhtiqw==
X-Gm-Gg: AYBFou3WkuXpjfPh+38t2AdpmkZibJpnRhYv0WTdyKRFfCe0t5nr++rBSyd/wzDtKDn
 zSaRtHyiXtyhONK4b+T3O308gD/dEDyJoIenEBuUeqt8AwtK3BfeZ6Lgqp3xFuw2ZHIt+VRy0n5
 X5E6uQDNvxC0zZR6atceIk8VIvL0Q985VnVBLtMKNpXotDquMsmPP9c2d6LVMq5fTJLZerAqwFd
 2s7kqVkhAPiWHO75h6WxzUxakA9nYxSne/SrUS3fJoa8tBBASr+Mz6VXMd5a5UhLwU35VdDxJZq
 mITAiD0AXIbBNH3vshA3wvTtIAawhA9VNu29fDKyW5ggXPTZ23wWsSKBLn4f5ZN6rZtRo85NlQX
 2bcmTt9GAIH4aTFOrzg1j4RJkiLJEe+Qe6TBc94vVKC7pjeA=
X-Received: by 2002:a05:7300:e60b:b0:351:13b4:9c59 with SMTP id
 5a478bee46e88-3619f1fd1e3mr14614723eec.2.1792430770258; 
 Mon, 19 Oct 2026 10:26:10 -0700 (PDT)
X-Received: by 2002:a05:7300:e60b:b0:351:13b4:9c59 with SMTP id
 5a478bee46e88-3619f1fd1e3mr14614669eec.2.1792430769453; 
 Mon, 19 Oct 2026 10:26:09 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360813b6791sm38243061eec.6.2026.10.19.10.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 10:26:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 00/11] Hexagon: Add support for v83, v85
Date: Mon, 19 Oct 2026 10:25:52 -0700
Message-Id: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2OSBTYWx0ZWRfX5SiHSVi4rCPo
 l25j3guisHR7VSo+J2OCm5Mk7q2q+++xcxCSYgA4See1OSyQj1Mwn++hd6vxkXJwxtagGEffEJp
 g7XbgkwWZY5/Pt7BOHDc09Xxa0NdKi0=
X-Proofpoint-ORIG-GUID: NJLO493Lj5xB9P6LxXlDGUymUCA6tOU3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2OSBTYWx0ZWRfX/B4LrUfH+hiJ
 uiJHfvZ2d7/9MKx0/X96Z0EQYT9yLTuj3C+ilKsq78lsRiZ/xnfcFx7PiXwPNmUtqdkyGusOwUg
 3qqKKYvsw7N9McL5jJwvYLj3gO6RAZXr7NasXbsYvWpzWESbv1j7xKasaCFdVrmQqGd/OpWCmPu
 pjmqw8xfca6jqax07NI8hCZqOKI/BBTUPjbpIiVfhsVDqlRay01a21gQ28vLNh6+lqga5kH26MV
 YyGg9H5uSTZlBwbpI65+VtY9g+2vqPpQ3AGi+ITFzoYeFiSU+9y5+NffIZELERy1PMJPnR6pLbO
 HqeWFZB3SNNG3SiphnLEiwv9DJYAaOwIOf3GxQwig2dW25P37C3IUE/Fz9t3r4l+TvXQiQYR+NE
 sYTjGSNUyKk8o5UNF8sC5fAt636UuNL+LJSYv+tvBdcMFfq4N5K+xhXIxPLKgkV2nOTEERW3v8z
 yJUwJ+ccX3XpQ9gyBfw==
X-Proofpoint-GUID: NJLO493Lj5xB9P6LxXlDGUymUCA6tOU3
X-Authority-Analysis: v=2.4 cv=Zf2IpcVA c=1 sm=1 tr=0 ts=6ad652b3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=K9QOZ6TE3rTeoe2LA58A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190069
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

djgzIGFuZCB2ODUgaW50cm9kdWNlIG5ldyBJU0EgZXh0ZW5zaW9uczoKLSBDRkkvcmVzdHJpY3Rl
ZCBicmFuY2hlcwotIHNjYWxhciBhdG9taWMgb3BlcmF0aW9ucwotIHNjYWxhciBmbG9hdCBvcGVy
YXRpb25zCi0gdHJhcDIgaW5zdHJ1Y3Rpb24KLSB2ZWN0b3Igc3RhY2ssIHVzZWQgYnkgSExYCgpU
aGUgSExYIHZlY3RvciBjb3Byb2Nlc3NvciwgYWxzbyBpbnRyb2R1Y2VkIGJ5IHRoZXNlIG5ldyBy
ZXZpc2lvbnMsIGlzCm5vdCBpbmNsdWRlZCBpbiB0aGlzIHNlcmllcy4KClRoZSBjcm9zcy10b29s
Y2hhaW4gZG9lc24ndCB5ZXQgc3VwcG9ydCB0aGVzZSBvcGNvZGVzLiAgU28gaW4gb3VyIHRlc3Rz
LAp3ZSd2ZSBtYW51YWxseSBlbmNvZGVkIHRoZSBpbnN0cnVjdGlvbnMgdXNpbmcgIi53b3JkIiBk
aXJlY3RpdmVzIGFuZCB3ZQppbnZva2UgdGhlIHRlc3RzIHdpdGggdGhlIGV4cGxpY2l0ICctY3B1
Jy4gIFRoZSBkaXJlY3RpdmVzIHdpbGwgYmUgcmVwbGFjZWQKd2l0aCB0aGUgbW5lbW9uaWNzIGFu
ZCBleHBsaWNpdCAnLWNwdScgcmVtb3ZlZCBvbmNlIHRoZSBhc3NlbWJsZXIgaGFzIHRoZQpuZWNl
c3Nhcnkgc3VwcG9ydC4gIEkgZXhwZWN0IExMVk0gMjQueCB3aWxsIGluY2x1ZGUgdGhlc2UgaW5z
dHJ1Y3Rpb25zLgoKSW4gdjI6CgotIFMyX2FsbG9jZnJhbWVfcmIgbW92ZWQgb3V0IG9mIHRoZSBh
dG9taWNzIGNvbW1pdCBpbnRvIHRoZSBDRkkgY29tbWl0LAphZnRlciBBX1JFU1RSSUNUX1RBUkdF
VCBpcyBkZWNsYXJlZC4KLSBmaXggZm9yIG5vLWlkZWY6IGZHRU5fVENHX1YyX3Z7LGRlfWFsbG9j
ZnJhbWVfKiBvdmVycmlkZXMgYXJlIGtlcHQgaW4gdGhlCnZlY3Rvci1mcmFtZSBjb21taXQuIFMy
X2FsbG9jZnJhbWVfcmIgYW5kIFNTMl9hbGxvY2ZyYW1lX3JiIG92ZXJyaWRlcyB3ZXJlIGFkZGVk
CnRvIHRoZSBDRkkgY29tbWl0LgotIFNxdWFzaGVkIHBhdGNoZXMgNiBhbmQgNwotIGZpeGVkICdp
bl9hc20nIGZvciBMNF9sb2Fkd19waHlzOiBnZW5lcmFsaXplZCB3L2FuIGVuY29kaW5nX3N1cHBv
cnRlZCgpCmNoZWNrLgotIFN3aXRjaGVkIHRvIGdlbl91bmFsaWFzX2dwcl9zcmMgaW4gZ2VuX2Nh
bGxyCi0gQWRkZWQgY29tbWVudCBvbiB0aGUgLndvcmQgZW5jb2RpbmcgdG8gZXhwbGFpbiB0aGUg
aW5zdHJ1Y3Rpb24uCi0gRHJvcHBlZCB0aGUgLU8wIGZvciBjZmlfdXNlci5jCgp2MTogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MTAxNDE5NTIyMy4zMjMzNjIzLTEtYnJp
YW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwoKQnJpYW4gQ2FpbiAoMTEpOgogIHRhcmdldC9oZXhh
Z29uOiBzb3J0IHRhZ19yZXZfaW5mbyBlbnRyaWVzIGJ5IHZlcnNpb24KICBIZXhhZ29uOiBhZGQg
djg1IENQVSBtb2RlbAogIGh3L2hleGFnb246IGFkZCB2ODUgbWFjaGluZXMKICBsaW51eC11c2Vy
L2hleGFnb246IHJlcG9ydCBJU0EgSFdDQVAgdGhyb3VnaCB2ODUKICB0YXJnZXQvaGV4YWdvbjog
YWRkIHY4NSBzY2FsYXIgYXRvbWljcwogIHRhcmdldC9oZXhhZ29uOiBhZGQgdjgzIHRyYXAyIGFu
ZCB2ZWN0b3Igc3RhY2sgaW5zdHJ1Y3Rpb25zCiAgdGFyZ2V0L2hleGFnb246IHJlamVjdCByZXNl
cnZlZCBMNF9sb2Fkd19waHlzIGVuY29kaW5nIGZyb20gdjgzCiAgdGFyZ2V0L2hleGFnb246IHBy
ZXNlcnZlIGNhbGxyIHRhcmdldCB3aGVuIFJzIGlzIExSCiAgdGFyZ2V0L2hleGFnb246IGltcGxl
bWVudCBjb250cm9sIGZsb3cgaW50ZWdyaXR5IChDRkkpCiAgdGFyZ2V0L2hleGFnb246IGFkZCB2
c2YqIGluc3RydWN0aW9ucwogIHRlc3RzL3RjZy9oZXhhZ29uOiBhZGQgdjg1IHNjYWxhciB0ZXN0
cwoKIGRvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdCAgICAgICAgICAgfCAgIDIgKy0K
IGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmggICAgICAgICAgICAgICAgfCAgIDYgKy0KIGxp
bnV4LXVzZXIvaGV4YWdvbi90YXJnZXRfZWxmLmggICAgICAgICAgICAgfCAgIDIgKwogdGFyZ2V0
L2hleGFnb24vY3B1LXFvbS5oICAgICAgICAgICAgICAgICAgICB8ICAgNCArCiB0YXJnZXQvaGV4
YWdvbi9jcHUuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgICAzICsKIHRhcmdldC9oZXhhZ29u
L2NwdV9iaXRzLmggICAgICAgICAgICAgICAgICAgfCAgIDIgKwogdGFyZ2V0L2hleGFnb24vZGVj
b2RlLmggICAgICAgICAgICAgICAgICAgICB8ICAgMiArCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNn
LmggICAgICAgICAgICAgICAgICAgIHwgMTUwICsrKysrKysrKysrKysrKysrKy0KIHRhcmdldC9o
ZXhhZ29uL2dlbl90Y2dfc3lzLmggICAgICAgICAgICAgICAgfCAgIDYgKwogdGFyZ2V0L2hleGFn
b24vZ2VucHRyLmggICAgICAgICAgICAgICAgICAgICB8ICAxMiArKwogdGFyZ2V0L2hleGFnb24v
aGVscGVyLmggICAgICAgICAgICAgICAgICAgICB8ICAgNSArCiB0YXJnZXQvaGV4YWdvbi9oZXhf
cmVncy5oICAgICAgICAgICAgICAgICAgIHwgICAyICsKIHRhcmdldC9oZXhhZ29uL2lkZWYtcGFy
c2VyL3BhcnNlci1oZWxwZXJzLmggfCAgIDEgKwogdGFyZ2V0L2hleGFnb24vbWFjcm9zLmggICAg
ICAgICAgICAgICAgICAgICB8ICAxMiArKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggICAg
ICAgICAgICAgICAgICB8ICAgNCArCiB0ZXN0cy90Y2cvaGV4YWdvbi9jZmlfdGd0cy5oICAgICAg
ICAgICAgICAgIHwgIDE2ICsrCiBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y4NW5hXzEuaC5pbmMg
ICAgICAgIHwgIDUwICsrKysrKysKIGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjg1cWFfMS5oLmlu
YyAgICAgICAgfCAgNTEgKysrKysrKwogdGFyZ2V0L2hleGFnb24vYXR0cmlic19kZWYuaC5pbmMg
ICAgICAgICAgICB8ICAgMiArCiB0YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYyAg
ICAgICAgIHwgICAxICsKIGh3L2hleGFnb24vaGV4YWdvbl9kc3AuYyAgICAgICAgICAgICAgICAg
ICAgfCAgNDggKysrKystCiBsaW51eC11c2VyL2hleGFnb24vY3B1X2xvb3AuYyAgICAgICAgICAg
ICAgIHwgIDEwICsrCiBsaW51eC11c2VyL2hleGFnb24vZWxmbG9hZC5jICAgICAgICAgICAgICAg
IHwgIDEwICsrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDEwICstCiB0YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyAgICAgICAgICAgICAgICAgICAgIHwgIDE5
ICsrKwogdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgICAgICAgICAgICAgICAgICAgICB8ICA5MSAr
KysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMgICAgICAgICAgICAg
fCAgIDMgKwogdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMgICAgICAgICAgICAgICAgICAgICB8ICAx
NiArKwogdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYyB8ICAxNCAr
KwogdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jICAgICAgICAgICAgICAgICAgICB8ICAgMyArLQog
dGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICAgICAgICAgICAgICAgICB8ICA3MyArKysrKysr
KysKIHRhcmdldC9oZXhhZ29uL3ByaW50aW5zbi5jICAgICAgICAgICAgICAgICAgfCAgIDMgKy0K
IHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgICAgICAgICAgICAgICAgfCAgNTMgKysrKysr
LQogdGVzdHMvdGNnL2hleGFnb24vYXRvbWljcy5jICAgICAgICAgICAgICAgICB8IDEwMiArKysr
KysrKysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9jZmlfdXNlci5jICAgICAgICAgICAgICAgIHwg
IDYzICsrKysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9jaGVja19yZXZfZ2F0aW5nLmMgICAgICAg
IHwgIDEwICsrCiB0ZXN0cy90Y2cvaGV4YWdvbi9pbnZhbGlkLWVuY29kaW5nLmMgICAgICAgIHwg
IDIwICsrKwogdGVzdHMvdGNnL2hleGFnb24vdHJhcDIuYyAgICAgICAgICAgICAgICAgICB8ICAz
NCArKysrKwogdGVzdHMvdGNnL2hleGFnb24vdjgzX3NjYWxhcl9mcC5jICAgICAgICAgICB8ICA5
OCArKysrKysrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL3ZhbGxvY2ZyYW1lLmMgICAgICAgICAg
ICAgfCAxMTEgKysrKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL3RhZ19yZXZfaW5mby5jLmlu
YyAgICAgICAgICAgfCAgODIgKysrKysrKystLQogdGFyZ2V0L2hleGFnb24vZ2VuX2lkZWZfcGFy
c2VyX2Z1bmNzLnB5ICAgICB8ICAgNCArLQogdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvaWRl
Zi1wYXJzZXIubGV4ICB8ICAgOCArCiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9pZGVmLXBh
cnNlci55ICAgIHwgICA5ICstCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9hbHUuaWRlZiAgICAg
ICAgICAgIHwgICAzICsKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2JyYW5jaC5pZGVmICAgICAg
ICAgfCAgMzggKysrKysKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2VuY29kZV9wcC5kZWYgICAg
ICAgfCAgNDMgKysrKystCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9lbmNvZGVfc3ViaW5zbi5k
ZWYgIHwgICAxICsKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2Zsb2F0LmlkZWYgICAgICAgICAg
fCAgNDkgKysrKysrCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9sZHN0LmlkZWYgICAgICAgICAg
IHwgIDE2ICstCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tYWNyb3MuZGVmICAgICAgICAgIHwg
IDEwICsrCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9zdWJpbnNucy5pZGVmICAgICAgIHwgICAy
ICsKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL3N5c3RlbS5pZGVmICAgICAgICAgfCAgIDkgKysK
IHRlc3RzL3RjZy9oZXhhZ29uL2NmaV90Z3RzLlMgICAgICAgICAgICAgICAgfCAxNTcgKysrKysr
KysrKysrKysrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICAgICAg
ICAgfCAgMTkgKystCiA1NSBmaWxlcyBjaGFuZ2VkLCAxNTQyIGluc2VydGlvbnMoKyksIDMyIGRl
bGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9oZXhhZ29uL2NmaV90Z3Rz
LmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y4NW5hXzEuaC5p
bmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y4NXFhXzEuaC5p
bmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvaGV4YWdvbi9jZmlfdXNlci5jCiBjcmVh
dGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL2hleGFnb24vdHJhcDIuYwogY3JlYXRlIG1vZGUgMTAw
NjQ0IHRlc3RzL3RjZy9oZXhhZ29uL3Y4M19zY2FsYXJfZnAuYwogY3JlYXRlIG1vZGUgMTAwNjQ0
IHRlc3RzL3RjZy9oZXhhZ29uL3ZhbGxvY2ZyYW1lLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0
cy90Y2cvaGV4YWdvbi9jZmlfdGd0cy5TCgotLSAKMi4zNC4xCgo=

