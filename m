Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6ABCCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 20:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRfz-0003Wb-N6; Thu, 15 Oct 2026 16:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHRfw-0003Pg-0J
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:03:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHRfu-0003FC-9n
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:03:39 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFDtqt2678119
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 20:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3XSaT0IebdrV9pFi417K7itqeQXP6nNeTiSDYDl96oU=; b=HkIguV9KENPPKQxo
 +Sk2izw1tQfs3MhtbTDO8TBAmB8BkJvzI7a2tO3zdlq/cOVpngA0A73YmkWRygJF
 ffSX+37YZSfWg1RdNnC+7Ovh7sdLX4yPimAUM1pvqw+X+SjHxYFrxNBO6VSbOXEW
 tmhCCEdzZw0odEeWqHNxQPJpZsiuPKyahr7MvJIn8TNkwjDDv/A42Ff/6wzdJOSw
 JKHG+1HA+sdU3tFjbT/+mvdI0UmRtC/z1dcH2sbldCw3OGlKE8RY+33h8+izr76n
 7KEGMknj4Ie274UokvmAULVsiEo6JLOOC6+/uakiGTp0T3gxX2gxCqRAVCVV/O65
 UChWYg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19t94mf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 20:03:37 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1665200f4c2so7865940c88.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792094616; x=1792699416; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3XSaT0IebdrV9pFi417K7itqeQXP6nNeTiSDYDl96oU=;
 b=D3YNiErfFYj+g27CIF0jyjof//NW4d7RvVj1T8sT3os97mZFV+IK/lnjuOPEQCruU8
 0PQQ1Be6H4klMP+9UG20bibwYr4uQp83ZcjarihWdGUvFgoIAp2DXKJbN7xUUnKQMTP5
 +NnsTR6Br8tCtnPqncoNg61WIYXCTACOdCfSFmMnr+BFklW06QLhoEqGmb1u17gc6Rvi
 2kTKqaQ5Xy8T1nln39CdcZdAutPAn97rRl+EBG/D4R4r6DBzziiZdRYytcaGQEHHeT1B
 ihdbvNKKaJ095jYyrECEllyt6JhPplC6nBFoOCy7yKU0RWz1YKsRW2iKFLsspETK1WFe
 rYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792094616; x=1792699416;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3XSaT0IebdrV9pFi417K7itqeQXP6nNeTiSDYDl96oU=;
 b=uOzfcGw2yLuctUjQpCyinNXTpD3cISCeIBptPr/tLk141tjoxPYFYDkqu7QUsdvwrz
 l+YR2VqR3nmRlZ+bbguqeGM7TAg87yQLclwR8mKCzUqWAuEQt6hIPD3ZbWZ1qb/Ghx5X
 TqCGnbnMlHBScmmFb388sM5d0JxOSu33UOF0EsGJ2TUUDt7I7b6vOlC3U7ugwHXwNacW
 k60I1BBsWFZ48aub1aAIDFHco4C0toDVglIV0e/GWe8ZOq85p+blZAgTTAE4lkjKOVtT
 W7hCofhd7Gg+9WXD1HXtdRwIPwFhWxSgTXzcdmqJWZUzv9RIBEK2Q07dXbd+63sDjJiQ
 bD7A==
X-Gm-Message-State: AFq9FYLODrelXIYfcDZynix2RxIh1zWf73DbwUItcl0fLCU2Zo/dviYd
 cv89zMUsZDFbmFoQnMgtKM+wZW/hOdmK5VVRv71akW+uqFITH271BC+nTeyrFX7JjmAcWExwPQb
 Wmtx2/YOf73c2fBTy7TE/zaJfU+xnnzKHU1rD2wW4w+px4WoPJRK5J8sqakVAV9o9jw==
X-Gm-Gg: AYBFou0Lessuu7iZ7CKSKHSeWSG4a2ubeL9snrB13nVHSq86mdu5GKyoVjk4XVSm1t2
 fBdOCgEV1EYuJjG9sBGF2ECZ8jp/YX1HcU4cti6OsE0Iyh7xCi+g9Z3EgwScmxQ87mYbQBFCT27
 aF5Ccjw85DioBFu/pk4RtS7Ayi4L4mXWRqSriIqmJlUSZmsZsJfj86Dz3HLqqixnfou0NpPSMVF
 X4juvh9P6X7qGNpwTBrmWSczmZjvBGjWzfVCwjEKzd14dYqeH2EqnRvfBTnoi8GMKyhjiZQ57tj
 vDt36YB7cY4xscCqe4ZS+CukaI/VjOTfb989vaiUEZer2PutS00IZVCzO18jOUMJfIVlOxTJqtX
 TvNgig9Xrb+wFIMGUKN/noqZEVPtOFlL+pN3ZcHRnuRpgjxY=
X-Received: by 2002:a05:7022:7e83:b0:14a:d8fe:3390 with SMTP id
 a92af1059eb24-182e0bf4913mr317208c88.32.1792094616154; 
 Thu, 15 Oct 2026 13:03:36 -0700 (PDT)
X-Received: by 2002:a05:7022:7e83:b0:14a:d8fe:3390 with SMTP id
 a92af1059eb24-182e0bf4913mr317126c88.32.1792094614408; 
 Thu, 15 Oct 2026 13:03:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-182a6d6969asm1347058c88.12.2026.10.15.13.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 13:03:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 8/9] target/hexagon: set a started thread's enable bit when
 start retires
Date: Thu, 15 Oct 2026 13:03:05 -0700
Message-Id: <20261015200306.1602540-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015200306.1602540-1-brian.cain@oss.qualcomm.com>
References: <20261015200306.1602540-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 4UJrqbAkaFz88P6edj6U1G600N3Gfd4Z
X-Proofpoint-ORIG-GUID: 4UJrqbAkaFz88P6edj6U1G600N3Gfd4Z
X-Authority-Analysis: v=2.4 cv=NqZE4MdJ c=1 sm=1 tr=0 ts=6ad13199 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=u35ek3RR3RME6NZFTgcA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3OSBTYWx0ZWRfXxhoCA92SKheB
 VYV+x4wwZ7pK7aqmRDAKiNxmd6i4katfDsgc+bM1aPKd+MQF2PaEUr54ZhWEkzYeFpFRZ4Fuzci
 gDO5r9YdXyal0/WF/JP8ZRwGCHEbtnZeLtj4N2asvYEjNgfZ0Ahu2hLzvGeGwb/k4jq0h+kJIRC
 Eh/zzwPkYHReU4wU6cjqQbFYExl1Cj6St0MTNIt3j8blRla9LDwXHaNgvPRfSrQzZ3LY6J6FPOC
 xAklOsmgXEZarcMkR7ereZoRwZY0kqQYwUAWxLd61QFm3T7ikNgBD0BNG3TRE5FqZ4NLcCDRP5j
 nEjMHJKI8HiRYKMAg7oip9N2s5EzhocyejHgVBhth9M/3Qizvjys+33+GWDDkrtp55ccHTVpyXn
 shgxazIxQzqKxRBVz8WG892YC6sj4eytEs0c8wj8dss+m7ihQjvw6Um/aDw+wMsMAGf7UhsfyJ7
 HM7JC2y3PaiOm9QRe0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3OSBTYWx0ZWRfX3tU6Xa+u2jub
 fmY0NuelrRTLsWaWuu3k6orUC7T8i6o13us5S5uuFh8YBf6JKllW2Sh1/x7TkNsMw+prIDpG21t
 OjfWSc5754Dd+l3mDffvsZWdr53vUEA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150079
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

U2V0IE1PREVDVEwuRSB3aGVuIHN0YXJ0IHJldGlyZXMgcmF0aGVyIHRoYW4gd2hlbiB0aGUgdGFy
Z2V0IHRocmVhZCBydW5zLiBUaGlzCm1ha2VzIHRoZSB0aHJlYWQgc3RhdGUgdmlzaWJsZSB0byBz
b2Z0d2FyZSBpbW1lZGlhdGVseSBhZnRlciBzdGFydC4KClJldmlld2VkLWJ5OiBQaWVycmljayBC
b3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6
IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4
YWdvbi9jcHVfaGVscGVyLmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgYi90YXJnZXQvaGV4
YWdvbi9jcHVfaGVscGVyLmMKaW5kZXggNmYxNzIyNzA4NjUuLjZkYzA2NDAxYWQ1IDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1
X2hlbHBlci5jCkBAIC00MTcsNiArNDE3LDkgQEAgc3RhdGljIHZvaWQgZG9fc3RhcnRfdGhyZWFk
KENQVVN0YXRlICpjcywgcnVuX29uX2NwdV9kYXRhIHRiZCkKIHZvaWQgaGV4YWdvbl9zdGFydF90
aHJlYWRzKENQVUhleGFnb25TdGF0ZSAqY3VycmVudF9lbnYsIHVpbnQzMl90IG1hc2spCiB7CiAg
ICAgQ1BVU3RhdGUgKmNzOworCisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKwogICAgIENQVV9GT1JF
QUNIKGNzKSB7CiAgICAgICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7CiAg
ICAgICAgIGlmICghKG1hc2sgJiAoMHgxIDw8IGVudi0+dGhyZWFkSWQpKSkgewpAQCAtNDI0LDYg
KzQyNyw3IEBAIHZvaWQgaGV4YWdvbl9zdGFydF90aHJlYWRzKENQVUhleGFnb25TdGF0ZSAqY3Vy
cmVudF9lbnYsIHVpbnQzMl90IG1hc2spCiAgICAgICAgIH0KIAogICAgICAgICBpZiAoY3VycmVu
dF9lbnYtPnRocmVhZElkICE9IGVudi0+dGhyZWFkSWQpIHsKKyAgICAgICAgICAgIHNldF9lbmFi
bGVfbWFzayhlbnYpOwogICAgICAgICAgICAgYXN5bmNfc2FmZV9ydW5fb25fY3B1KGNzLCBkb19z
dGFydF90aHJlYWQsIFJVTl9PTl9DUFVfTlVMTCk7CiAgICAgICAgIH0KICAgICB9Ci0tIAoyLjM0
LjEKCg==

