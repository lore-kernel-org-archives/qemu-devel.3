Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EA5606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZHTtDJ/A;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GfQzv9fd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLinu-0001vA-O3; Tue, 27 Oct 2026 11:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLins-0001uZ-E7
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:09:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLinq-0000iC-SJ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:09:32 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RF84OT1664132
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 15:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iPyqUuHyR5wPyphM9RNZQcBTxHIXfoyLfutvxErYejc=; b=ZHTtDJ/AS69F06xm
 qpMPKCugPgTgB2rHrf12RHiyYH+6KA3swyV2g19OB6uLOEP36CnAlJADcFvZ57e4
 79doRQwUtcZRetkD24G2o0uBSSNz/0LjOUxYpper+zg+0THCd8VeqljOh5SiFw0O
 /E3ZKoT5tOYbS2fNItgu4rdIde6jpK0wDH0EIzQ+D5yr/acscoRsPmVsxG/AYs8K
 xh1EayfQXodmLcmTH+sk7az7Jn4G1LihPAOuYKrrM+HLuo+3A66AUfSa7wmlX8OQ
 gCm1ikBeTblJySbcKkGQ51asSBC07yRYPzg/ANPz0BMEBa2dw05/EyFw8sXjtIwn
 Cci8xQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjp2ta6rw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 15:09:19 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4b597558c4cso6550334b6e.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793113758; x=1793718558; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iPyqUuHyR5wPyphM9RNZQcBTxHIXfoyLfutvxErYejc=;
 b=GfQzv9fd19r/Gr8NGl+J8chhHLhJGT9Z8ZKKWHklTTUwJu6DWtYSCPK9UESUi2zaXI
 VvO2/kploVzw58b8v7fXEbDS+7M1f/1YTzYc0FJr6yayetAUjh+3OC2mbK8mVvNr05S8
 PgjgrtOGNxDcm1qNoThaXrdbzMo+U+N2GDr7ReQHdICP4hFrZfW7dZOBM1EJ4UJV0OZj
 cB+8qWcnC5Qxl4MuvnfmuAgFh5VioHBX/UIhSbIGxfJakZY54CXye1T54X9xZ2Hdqre2
 yDIHeswSMD+iVUJpzEsB9cN75BzIlAkRtVkHaSwmgVZJ6YfIar3xSdEQbN/cwRpXae40
 fgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793113758; x=1793718558;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iPyqUuHyR5wPyphM9RNZQcBTxHIXfoyLfutvxErYejc=;
 b=v/pLywXpKrhC54y8J8iCz8bpCulp6frLm4DsmtWQmobfmA+GQTpMsTXD0roYXLUrkn
 Wu8XlXSIjk01DmGIBo98+etq88b0iRHVwRcCxpFyw3YVixqcztbdUjr+aUFy7H/2kOZG
 YZ/ZYGB8qA3fYsntWWxLmSOWAIHQlcmMOmruCQwKbPQ1CKKfddccSFVB+Q3fh3T0YebM
 +TAbf0FBqe5FT/ZiNW0lXp3UltafRj1VHc9PQOqoNE9cl/gxlbKUwoRa9bx5jv4cS5Kz
 TpFqBCe4rG2A+wBm4dhEl7VwTIq/VJLL09Azjbz3Axe8JbzMY3piMskVAzeJAeivszC5
 si4A==
X-Gm-Message-State: AFq9FYJ1q3IZFtFt7/L7h3nS7i0pzeATlMIokgHdUhn7TTwUA+MRDajh
 uynGgyOXlA/58efLLQaXxWUP5ST4pLaYTF10fNIMH6qRoL7c8TmSY57qszjNVyuDe3+/Y73dV3U
 Dfif8evAjxPqP3kA9uMTIZ16EGPe39qHKTvmvBTh57C2dV/LpL8zIihs/UfmdyoJD0Q==
X-Gm-Gg: AYBFou3POjJLRss9uj0RRfouQ2h0OSRMLrXqYidiJ3KwZvd+DFSjuBtp1TnwRSVXH5a
 ESNACXzw9AIac+Nj5CpetxZjUzWXEUsuCJfztexRSAQwwBinlNDqddiPzUYpuwR5F24N/uD7t19
 +x3RaFqayQDq8GmMXIQrz/ZwAzC8GwhcWy2wjWJQc7DAhPqTptPcRNibGb7AAgZdkdAhEoAlNOb
 0d3dET7p9V7OpLJa4ipvGWAsyunHqQ2y2KdVigc2gRHpIIccdOAxUj57zFq/7718JVBKQ89AQ3M
 kRuvPrHzFEvO7IAhyusIIsP6aJkLyEpVic3vTfuqfUy2F+yWZ3Yj36zaP9njm9Xj4yksXd2r3hk
 IoYYrpoNWynZsWrvqoEPAbsfX0knQHNz+QK7MLmVI8w5uIQI=
X-Received: by 2002:a05:6808:1b06:b0:4e7:d180:7719 with SMTP id
 5614622812f47-55c002ec926mr6077250b6e.42.1793113758538; 
 Tue, 27 Oct 2026 08:09:18 -0700 (PDT)
X-Received: by 2002:a05:6808:1b06:b0:4e7:d180:7719 with SMTP id
 5614622812f47-55c002ec926mr6077226b6e.42.1793113758028; 
 Tue, 27 Oct 2026 08:09:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c03dc3524sm7673136b6e.0.2026.10.27.08.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 08:09:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL v4 42/42] scripts/clean_functional_cache: tolerate missing
 .stamp files
Date: Tue, 27 Oct 2026 07:37:21 -0700
Message-Id: <20261027143721.4125584-43-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=AJjzCM5L c=1 sm=1 tr=0 ts=6ae0be9f cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=O_aXAYYkZahAwHBccVsA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: LwGlTLgBhUxZL9PSiLLGq3-puM-e4eH_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2MCBTYWx0ZWRfXyD4zkPFLcOUf
 y9+kbBb/CmYx0GhWmbYuJ0iTBaIchWrGcZo+96b9+kW59H/QSA8k5Zri3HodgQM1nCay0V5de2C
 v25LxO51SlJ0j0gzXc4ZG2uyYg9X7W4=
X-Proofpoint-ORIG-GUID: LwGlTLgBhUxZL9PSiLLGq3-puM-e4eH_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MCBTYWx0ZWRfX8oGaXI+8Vb63
 6UlOAXm2ARRsoF6/RdYxMbSzprRdMJago4QqAe5OJ27wO3taC19g1q9GM0L1sfcOnBV8Fzvrxve
 AGGd2V9QIs93woa0I338YekdkeQkvrKYTx4s3C09GxZmSxQl/aeqvXZGp8deCFWmE9vx0DX+PA8
 rS/Wf8VOBXMDE0QAWedRJNnoWzpUtzCtcBm6IoioGlDY5KKzEzsq/ye8GgbI9MW1Z8h173REVmm
 Z2f4WNdnBQPrG39rz1gldEw4Kli/PHzEMcswm93zsWDsFyZ/bHiPSntQP3jQ1Jmu33HAfYTgAH2
 cbWTIh1DP6xBI/0YVMdZFERZobhXhXNZ79ByHLO2TbmQwUlS2yose84KJm3MjdMhtStazROgRvn
 58xy7QusszwUjHtwMBxzC97Gmpo1/2dmU98jjUHYAW2LYrrCHTiVcCWi2wgIyDw41kWkrAw+SCl
 oXQgQ4h6bX3+xQ4y1hg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270060
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

QXNzZXRzIGNhY2hlZCBiZWZvcmUgdGhlIHN0YW1wIGZpbGVzIHdlcmUgaW50cm9kdWNlZCBoYXZl
IG5vCmNvcnJlc3BvbmRpbmcgLnN0YW1wIGZpbGUuICBUaGUgc2NyaXB0IGFscmVhZHkgY29wZXMg
d2l0aCB0aGF0IHdoZW4KcmVhZGluZyB0aGUgdGltZXN0YW1wLCBieSBhc3N1bWluZyB0aGUgUUVN
VSB2MTAuMSByZWxlYXNlIGRhdGUsIHdoaWNoCm1ha2VzIHN1Y2ggYXNzZXRzIGVsaWdpYmxlIGZv
ciByZW1vdmFsLgoKSG93ZXZlciwgc2luY2UgY29tbWl0IGMxYmI1OTRmZTQxLCByZW1vdmluZyB0
aGUgYXNzZXQgYWxzbwp1bmNvbmRpdGlvbmFsbHkgdW5saW5rcyBpdHMgLnN0YW1wIGZpbGUuICBG
b3IgdGhlc2Ugb2xkIGVudHJpZXMgdGhhdApmaWxlIGRvZXMgbm90IGV4aXN0LCBzbyB1bmxpbmso
KSByYWlzZXMgRmlsZU5vdEZvdW5kRXJyb3IgYW5kIHRoZQpzY3JpcHQgYWJvcnRzIGFmdGVyIGRl
bGV0aW5nIHRoZSBmaXJzdCBzdWNoIGFzc2V0LCBsZWF2aW5nIHRoZSByZXN0IG9mCnRoZSBjYWNo
ZSB1bmNsZWFuZWQgYW5kIHJldHVybmluZyBhbiBlcnJvci4KClBhc3MgbWlzc2luZ19vaz1UcnVl
IHNvIHRoYXQgYSBtaXNzaW5nIC5zdGFtcCBmaWxlIGlzIG5vdCBhbiBlcnJvci4KCkZpeGVzOiBj
MWJiNTk0ZmU0MTUgKCJzY3JpcHRzL2NsZWFuX2Z1bmN0aW9uYWxfY2FjaGU6IFJlbW92ZSBhbHNv
IC5zdGFtcCBmaWxlcyIpClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiBzY3JpcHRzL2NsZWFuX2Z1bmN0aW9uYWxfY2FjaGUucHkgfCAy
ICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9zY3JpcHRzL2NsZWFuX2Z1bmN0aW9uYWxfY2FjaGUucHkgYi9zY3JpcHRzL2NsZWFu
X2Z1bmN0aW9uYWxfY2FjaGUucHkKaW5kZXggMWZmOThjNzYwNmQuLjMwNjMzMDY5YzhmIDEwMDc1
NQotLS0gYS9zY3JpcHRzL2NsZWFuX2Z1bmN0aW9uYWxfY2FjaGUucHkKKysrIGIvc2NyaXB0cy9j
bGVhbl9mdW5jdGlvbmFsX2NhY2hlLnB5CkBAIC00NCw0ICs0NCw0IEBACiAgICAgICAgIHByaW50
KGYiUmVtb3Zpbmcge2NhY2hlX2Rpcn0ve2ZpbGUubmFtZX0uIikKICAgICAgICAgZmlsZS5jaG1v
ZChzdGF0LlNfSVdSSVRFKQogICAgICAgICBmaWxlLnVubGluaygpCi0gICAgICAgIHN0YW1wZmls
ZS51bmxpbmsoKQorICAgICAgICBzdGFtcGZpbGUudW5saW5rKG1pc3Npbmdfb2s9VHJ1ZSkKLS0g
CjIuMzQuMQoK

