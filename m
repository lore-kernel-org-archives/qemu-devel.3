Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194FE606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g9bjWp45;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JpVdoXOw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMpw-0006eG-I4; Tue, 20 Oct 2026 23:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJMoJ-0004Ic-GX
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:16:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJMoG-0002p3-IS
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:16:14 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2F17H2562962
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hs2evQwzXNJOL4NHRCgvuV/B70cbfFuQvsuaEtX79IU=; b=g9bjWp45aauktW7L
 4rkA5ZZD3gt/2vYT0BBmiUPEU7rSr4hBcN0lsuqUCGI7tdy/696F+RJ0Rde7AdRB
 qE+LsZhvKLhxtKO2Ts5cr9o8WsWUbHhOhl3M6IxWhLjcqjxTNUoMu5CvnP43G9dG
 JC23OHbxHw5V50JxIkXGQZ1EIb7gaYy2y7uCAKhj78vRr+HVC9FCOTcKolJZUYZH
 w4iWPZvxvpOdWOBHtpdYPup3eP4HJw9dOCqigzepUd0qAnfXWyrGT4OSFW2KSdyj
 OVuQ2TSQHYQtImleokIarKY8O/oFs7d4I9P8khDC9+drnKQoF5QOgdfrgOL1cWnN
 gecTpQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hebyd23s1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:16:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-366c279b454so510934eec.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552561; x=1793157361; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hs2evQwzXNJOL4NHRCgvuV/B70cbfFuQvsuaEtX79IU=;
 b=JpVdoXOwOH3u5aK1w/AYbJeGi+SWZcdYvK2c0iNtYPx5nkfkHF/tGBjhabTUBkAOmN
 4CPGMZDmpN8XyEeWtAn36Tkny7AFnMkr4uFGZ3WEmeh/EhKdBd8hD2oQE0cAFSOnYp11
 mV09CjQFG3PKOemffOzmku1Zekahn2x3kZuTSUrOcHov9OnfYlB0hYid41p+iF0+RUBR
 EkJ+OL6AhLkMluZrcBpIbvTVtHyLsXNkAaqH6zel8pJTAKkmC0M3XBa4KL1YHOmuk3CC
 JL1LQbrw51ynPn55muq3tGWaI/wwCv8aKXQHuQH7aXrmxFcktT1vYV2exGqUaJMapEcq
 Oh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552561; x=1793157361;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hs2evQwzXNJOL4NHRCgvuV/B70cbfFuQvsuaEtX79IU=;
 b=J7AaKD2OQE+3Lt04K49DOF5+WaS21jQIJRYKv5cGYPLjwyftKrmTmWspaegfK47wB4
 JynZ7HXDCueUrvZH5f5qMI/jihTVaHUs47DKvgjDl1fdVaoCjSJetMWHJeH+CrKUn0ls
 RRotTUnIeH4cLkXE1W389pjxzdrH8uP7FGoXBm7492ku1vpUQrDOcJ4ZpvBNkUhiTRGE
 mZBIwLNL+Fm/9Dbxy8WbnaFWfc10iVu9vVjvXWK9guEK+lZsaqugNCT8NSFES6CoeUCF
 rDX3RQtoOZeXJCg8AcCHnuA7q4ZG8/7L18rq9mZ2FcaUP9ez8sY/28Y1C6e3W18GPNSQ
 uOcw==
X-Gm-Message-State: AFq9FYJLalQAAIeQFhoTOkfuCnjVoPrDZ/QGBZvFrGPvFDvcDURlnR2b
 WvfdX/on4d9RVAAIyMDbFNEALBXgZha48EI4MmSdDv//ctfyW9gKY0SPfjGX4UKAPfaMDAL99Zj
 6U0mhGXqb5tuGKexilshx7qqELZHy6o6Pt0whYHBQq6MtsbTmvGwIEfTf5v3pPcPpLA==
X-Gm-Gg: AYBFou3+9tZUKQkfdR8/kwLIL1CoHCLxO09J4x2Xb4D9qFbJWPu2L7eTtd0OKv4NN7t
 9pO5JwBXLok9yz5Fi55RPTrRHT8lXf2yRU18WfKFqvfg/vDmUZHCpVpdrtRnQyxFfPJCrrP0XH9
 MaMXtlSF7CnMaqAya8dLSCeHv4ybo8RCLQdFyISl0lWWrI6pmDljpEwJAuIE9oAOGjiycfG9hZp
 JG3YcLCYSa3xYSkxRwv7hS7HP2Er7J8kFav9V17013LvUtv1xI7fD9E08zXPcsKvf8AYgRgy034
 ztjpOs8YgDRvbDMcwvUlfW3StlxiMfzL7Y7E5nRPLD3K3VlraDTSapfUyUSy+sVCYfvtPmtB2mB
 MaSg6xEk5tYVePvErgi3CfFM5reEgZyvIBTXSkjyIzV/A1Kw=
X-Received: by 2002:a05:693c:2a18:b0:35e:ae46:d402 with SMTP id
 5a478bee46e88-3674d04ae30mr1705067eec.25.1792552560524; 
 Tue, 20 Oct 2026 20:16:00 -0700 (PDT)
X-Received: by 2002:a05:693c:2a18:b0:35e:ae46:d402 with SMTP id
 5a478bee46e88-3674d04ae30mr1705047eec.25.1792552560009; 
 Tue, 20 Oct 2026 20:16:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3674198f1cdsm3208959eec.25.2026.10.20.20.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 20:15:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 3/3] hw/intc/hex-l2vic: find the next pending irq a word at
 a time
Date: Tue, 20 Oct 2026 20:15:54 -0700
Message-Id: <20261021031554.1942011-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021031554.1942011-1-brian.cain@oss.qualcomm.com>
References: <20261021031554.1942011-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX/yJu2z9FN/is
 TWG5TB+ptQgH9m/E5M92WpLlcKK60GAxD07HDmXB1wgcR4cgEjOc9I5LGo26GRB2SIDx0GTR0kJ
 RHBXwJj+BPbBPyvaCpsPcZaNcJtJMn5EBewf/giZ8VBZL6k0109Z+L8b36C3yhGSJEuVr/raUO9
 2LYm4+vdtTpMJ9QW4fvxDsQNDqFS+ChhVfur/ax+jPVtMzvtoSJK9FoFjlAEFjH7VsmizxbuU3o
 Xjzk0zqZKEuX89RL0ExMJvNXMxm6U6q/RIYWWdTASe2wVo/ZtnIVGe/oHrdaLwWXrQQ2B0Uv1se
 1qzPFQ1lrlJ4hCaLcrxpgo77B/uwVcXFbYRjamq+jQKC+xChryLyieH7Msr1ySerWEhPnPMPGzy
 BTQptNIhJ6Ylvj06qbaaKxS0qph+5QMv9Dd77Bm8R2t1n5wHOCV4mkZxOM1grRl6cwyWa4bfVmB
 XbpxDIX+ZVC1vZnebjA==
X-Authority-Analysis: v=2.4 cv=TdsDJhQh c=1 sm=1 tr=0 ts=6ad82e71 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=8fQjqy5ARp1ca2tc:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=XWoxCBOuUWUKfCXQB-IA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: O7v7HVpuWB9KxMlIKOyfrGVO1r-56rEl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX0XK8QTaLcTvH
 IgDp6CdNs/LJuQlcRgy5McsNNGqg9NBfYhRh4uFZ46M0GR0rKvW15esgSZcMSZuAFXwNxHwFjNg
 mv/2Ga6UHz+4VL54QcqnGgSqVIMj3NI=
X-Proofpoint-GUID: O7v7HVpuWB9KxMlIKOyfrGVO1r-56rEl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210012
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

bDJ2aWNfdXBkYXRlX2FsbCgpIGNhbGxlZCBsMnZpY191cGRhdGUoKSBmb3IgZWFjaCBvZiB0aGUg
MTAyNCBpcnFzLCBhbmQKZXZlcnkgY2FsbCByZXNjYW5uZWQgYWxsIG9mIGludF9zdGF0dXMgZm9y
IGFuIGFjdGl2ZSB2aWQuICBjaWFkIHJ1bnMgaXQKb24gZWFjaCBpbnRlcnJ1cHQgcmV0dXJuLCBz
byB0aGlzIHdhcyBhIGhvdCBmdW5jdGlvbiBmb3IgYW4gT1MgYm9vdC4KCkNoZWNrIG9uY2Ugd2hl
dGhlciBhIHZpZCBpcyBhY3RpdmUsIHRoZW4gZGVsaXZlciB0aGUgbG93ZXN0IGlycSB0aGF0IGlz
CmJvdGggcGVuZGluZyBhbmQgZW5hYmxlZCBieSBzY2FubmluZyBpbnRfcGVuZGluZyAmIGludF9l
bmFibGUgYSB3b3JkIGF0CmEgdGltZS4gIFRoZSBkZWxpdmVyZWQgaXJxIGlzIHVuY2hhbmdlZC4K
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiBody9pbnRjL2hleC1sMnZpYy5jIHwgMTcgKysrKysrKysrKysrKystLS0KIDEgZmlsZSBj
aGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3
L2ludGMvaGV4LWwydmljLmMgYi9ody9pbnRjL2hleC1sMnZpYy5jCmluZGV4IDczNmYxYmUzYjFk
Li5kOTJmZjVlZWMyMSAxMDA2NDQKLS0tIGEvaHcvaW50Yy9oZXgtbDJ2aWMuYworKysgYi9ody9p
bnRjL2hleC1sMnZpYy5jCkBAIC0yOTAsOSArMjkwLDIwIEBAIHN0YXRpYyBib29sIGwydmljX3Vw
ZGF0ZShIZXhMMlZJQ1N0YXRlICpzLCBpbnQgaXJxKQogCiBzdGF0aWMgdm9pZCBsMnZpY191cGRh
dGVfYWxsKEhleEwyVklDU3RhdGUgKnMpCiB7Ci0gICAgZm9yIChpbnQgaSA9IDA7IGkgPCBMMlZJ
Q19JTlRFUlJVUFRfTUFYOyBpKyspIHsKLSAgICAgICAgaWYgKGwydmljX3VwZGF0ZShzLCBpKSkg
ewotICAgICAgICAgICAgLyogb25jZSB2aWQgaXMgYWN0aXZlLCBuby1vbmUgZWxzZSBjYW4gc2V0
IGl0IHVudGlsIGNpYWQgKi8KKyAgICAvKiBvbmNlIHZpZCBpcyBhY3RpdmUsIG5vLW9uZSBlbHNl
IGNhbiBzZXQgaXQgdW50aWwgY2lhZCAqLworICAgIGlmICh2aWRfYWN0aXZlKHMpKSB7CisgICAg
ICAgIHJldHVybjsKKyAgICB9CisKKyAgICAvKgorICAgICAqIFF1aWNrbHkgZmluZCBsb3dlc3Qt
bnVtYmVyZWQgaXJxIHJlYWR5IGJ5IHNjYW5uaW5nIHRoZWlyIHN0YXR1c2VzCisgICAgICogcmFu
Z2UgYnkgcmFuZ2UgaW5zdGVhZCBvZiBvbmUgYnkgb25lLgorICAgICAqLworICAgIGZvciAoaW50
IHNsaWNlID0gMDsgc2xpY2UgPCBTTElDRV9NQVg7IHNsaWNlKyspIHsKKyAgICAgICAgdWludDMy
X3QgcmVhZHkgPSBzLT5pbnRfcGVuZGluZ1tzbGljZV0gJiBzLT5pbnRfZW5hYmxlW3NsaWNlXTsK
KworICAgICAgICBpZiAocmVhZHkpIHsKKyAgICAgICAgICAgIGwydmljX3VwZGF0ZShzLCBzbGlj
ZSAqIDMyICsgY3R6MzIocmVhZHkpKTsKICAgICAgICAgICAgIHJldHVybjsKICAgICAgICAgfQog
ICAgIH0KLS0gCjIuMzQuMQoK

