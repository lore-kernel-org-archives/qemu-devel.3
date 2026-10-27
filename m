Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8193F606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HN4HMKDu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C79pbMk+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXtO-0002ve-P1; Mon, 26 Oct 2026 23:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtI-0002cU-7j
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtE-0008Mv-Ra
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:23 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2F8dd818575
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ONzaeJc5DfFv+nqFecOu/CJQwCpj8fhoj6bZCBfS1PU=; b=HN4HMKDuORXf+1a4
 dPvYqtEDMDMOwVXc8pGHhBFzUQBJhvdM95WJBNe6qpzk49Zf2VEqkq76NSQfwDfw
 YoUqBouzh/8myHxtgzFM3ejPszdQGRjgQbZmzZBtOK9RiHSWXUjDU8GIgwjKxA4l
 Azri8Ph9k81kawIEKiWKl6BcDlc0OgcIDEOTyuyqvjjkoEwQCVHv10YX+cnp0l+/
 HDLxXTugMS4fSNRuF6lrGQ3D0i8VQnHnTAQVNMw3dPnYLU3iMWqaJj+MAX/31792
 vL1CLER9oxJh+n48MlFC3Dxiha1blMvSeRR/X1hKYZKTfSScJEfr2kFVm+COzQsf
 z+GE2g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj56y3djm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:09 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso7734932eec.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071809; x=1793676609; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ONzaeJc5DfFv+nqFecOu/CJQwCpj8fhoj6bZCBfS1PU=;
 b=C79pbMk+ei7qxyrszg6LW2G/4aBEPya5+hMPIN3GcEN5mmG6kUoZwH+mcNF6SigYQB
 gCCWXzoH7EiwffXB/tHtwQC7lmT6rADYZLotOl5Y2+nbQsR/AZ89BM9D3Nais+zB5ZeP
 HctwtHn6ioOFtSCNgOlnVIGtWQCB1SjKAXqwt6Jrnc/1EcMzQjkqeQrrd6BYsGjFX9Fc
 Ka5QBxNd3UBaMBlaS3JErMQYp80JwWHaNTneE1ERyOUvnCfHpgNu2fKN5bHvjGMsQYAb
 +wHxbpvjnig3Y2kaNuzcpf57bQ/aGXHF15TXuxvlRQO9zj1vZzJBV9u61e1O3ihNEu5P
 of4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071809; x=1793676609;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ONzaeJc5DfFv+nqFecOu/CJQwCpj8fhoj6bZCBfS1PU=;
 b=Vq+kNYcjWEwgUTzobH7Xd2J/Jn8P6Wel6CDgUF2HlTh+1GBzMK4aA8bt8zzrejcE3d
 r4uK6kl+bQNbMn/Am51mcce5iy2MUBAtjAPVmwChvJQA2ZGgQ6KeAhrnN1/bMun2uYRg
 n+nkHLYDYn/ChO2XRq5/VXllcAXlAMSO86XHMlRHu6F4faGj74APSnzypYmHDXpsgU0T
 QhqtAWbSw6ZNGLAGek+qf9M/G9vaWxhbT0cz29XMCIPxdJhuJuNOdAlL3bGXJ9p99n+d
 4d2C+K+8OyK3AGEwW0KtDCDOMDaC8QWzEY3V8uqWylpMTWmPnCoGaOOYnHye6bevprrj
 R/Ng==
X-Gm-Message-State: AFq9FYLs1UTvVmLMoT8ipYLv/EDs+65JmUEQK3MWxadykOzQ451C2joO
 Gj4EyDyJ4G0vaIGRW5LPUuz21wBIJamBKAj5Hla+Doz2otDtvyHGXwjx7myWhy/XujLElooQI14
 zk14ZddJO+cyVPiuWTrjGk7gkFXzLjci7fgrUfPveyvgIEXlNBnD9mqTl8DkEu97boQ==
X-Gm-Gg: AYBFou0204qeMJN1w/Ns/zl1HadJ4BDrl+Jw6k+kBlTXodZgPQI6CuEdezjZP6n4Cjf
 T0pzcfB52/jziKw6cPmU+u9n3Ji6nGFTQawzNFgjftYONTSHOozaYvDXcbP+A6PmkLNZ3/1kMVe
 xLUvZO0I31Q5yHCjWT9f64QBpcztTslwExKLjbbiy+1KZKeJTNA2abih2cpfinOoIoqNAezvTp0
 +DEitoACkD/EB6oE4TksATUj5E183vCuVRdaBXq1nPcZB3hzVrKEJVuv8MIVu605Kx4nk5sz1iz
 W1UpkptbFKgdijNKhzCB1pwilU9cv6xp/h6wGghSFp9SElj917WYZ/oKXI+C97pJm2m4OLrNYCo
 mkt5hg627KJzMo1oFonrwALFbo/0fvArTRbeg45xCDwTW6JA=
X-Received: by 2002:a05:701b:2419:b0:163:c5eb:d42f with SMTP id
 a92af1059eb24-199291058eemr10404185c88.5.1793071808577; 
 Mon, 26 Oct 2026 20:30:08 -0700 (PDT)
X-Received: by 2002:a05:701b:2419:b0:163:c5eb:d42f with SMTP id
 a92af1059eb24-199291058eemr10404145c88.5.1793071807848; 
 Mon, 26 Oct 2026 20:30:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:30:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 16/41] target/hexagon: fix semihosting OPEN filename handling
Date: Mon, 26 Oct 2026 20:29:02 -0700
Message-Id: <20261027032927.3055166-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfXxFc9QWp13w2O
 hzgW0RWIKnvSVE52/yIHMBGQocf3JJKzAU0QEkqfY0brkA/C72w/oLe0H3uXy/sxzl7pjjDjJ3m
 hZKd29eO6ur5YU8kV2ndbvmgHNlOZV8=
X-Authority-Analysis: v=2.4 cv=eMeGH3p1 c=1 sm=1 tr=0 ts=6ae01ac1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=wfIhpZVs-6LWPqknoVUA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX91hIExzn4FGR
 ubMagPYoJYMQaoyPbdUcB+32ocRVrSUouGRUyoHLX47GRVmpyV/nNvwedD8ble8pG6KM4f909ik
 6F8+HS9+anZl1uQl9JcJocuJOMCUK2qyOzuSZ8gopAQ8M66onddsd3+4/pg9en6O7+0OKzIcZez
 gqEJyx1VN/IDEeoJi86AcBTeZFzOecLhIv027Kva+A6dpanWqOcvyZBleN1a7fFUv8fbJR7EbhG
 1Umm4TUDIcuPutBNphGe2VpA5epL3EpaasQXwtIEylOQjeMB5XSFBMhU9lqXQ3fk7bBdVkNjSbK
 3Omlsx09OEOA9XkAZdObRSg4PsLs1GxFQO02Goe4Y+wJrO1cFgDxPDC7WVuIO9RNtn54MdpwcEJ
 xiQ0u4veRT4GHIFnwOjmB+rbyupuz2VIlnlvsZpFTqet31z2Mj+I7/PjPMmj7Rw0p+2Awo30xES
 EO7baVyPcHvny4tZQkQ==
X-Proofpoint-GUID: cOvwUIypA2EGgM6c7fR3tTk5clIo8rCX
X-Proofpoint-ORIG-GUID: cOvwUIypA2EGgM6c7fR3tTk5clIo8rCX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270013
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

SEVYX1NZU19PUEVOIGNvcGllZCBndWVzdCBieXRlcyBpbnRvIGEgZml4ZWQtc2l6ZSBidWZmZXIg
dW50aWwgaXQgZm91bmQgYQpOVUwuIEEgbWlzc2luZyB0ZXJtaW5hdG9yIGNvdWxkIG92ZXJydW4g
dGhhdCBidWZmZXIuIFVzZSBsb2NrX3VzZXIoKSB3aXRoCnRoZSBBQkkgZmlsZW5hbWUgbGVuZ3Ro
IGFuZCB2YWxpZGF0ZSBpdHMgdGVybWluYXRpbmcgTlVMIGJlZm9yZSBvcGVuaW5nIGl0LgoKRml4
ZXM6IDc3MTFmZGJhODhiICgidGFyZ2V0L2hleGFnb246IGFkZCBtYWluIGFyY2gtc3BlY2lmaWMg
c2VtaWhvc3Rpbmcgb3BlcmF0aW9ucyIpCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC9DQUZFQWNBOU1PczZWZkhmMlVIWjh6NGNkdmFCKzdEWTZoSmIyZW1ZWjJhTFNlLXQ2aXdAbWFp
bC5nbWFpbC5jb20vClN1Z2dlc3RlZC1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnPgpSZXZpZXdlZC1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29t
bS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMgfCAzMCArKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxNyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyBiL3RhcmdldC9o
ZXhhZ29uL2hleHN3aS5jCmluZGV4IDMwZGQzZTg5OTI0Li42ZTgzZDg2NzMzYSAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMK
QEAgLTQ3MywzNSArNDczLDI5IEBAIHN0YXRpYyB2b2lkIHNpbV9oYW5kbGVfdHJhcDAoQ1BVSGV4
YWdvblN0YXRlICplbnYpCiAKICAgICBjYXNlIEhFWF9TWVNfT1BFTjoKICAgICB7Ci0gICAgICAg
IGNoYXIgZmlsZW5hbWVbQlVGU0laXTsKKyAgICAgICAgY2hhciAqZmlsZW5hbWU7CiAgICAgICAg
IHRhcmdldF91bG9uZyBwaHlzaWNhbF9maWxlbmFtZV9hZGRyOwogICAgICAgICB1bnNpZ25lZCBp
bnQgZmlsZW1vZGU7Ci0gICAgICAgIHVpbnQzMl90IGxlbmd0aDsKKyAgICAgICAgdWludDMyX3Qg
ZmlsZW5hbWVfbGVuOworICAgICAgICBzaXplX3QgZmlsZW5hbWVfc2l6ZTsKICAgICAgICAgaW50
IHJlYWxfb3Blbm1vZGU7CiAgICAgICAgIGludCByZXQsIGVyciA9IDA7Ci0gICAgICAgIGludCBp
ID0gMDsKIAogICAgICAgICBpZiAoZ2V0X3VzZXJfdTMyKHBoeXNpY2FsX2ZpbGVuYW1lX2FkZHIs
IHN3aV9pbmZvKSB8fAogICAgICAgICAgICAgZ2V0X3VzZXJfdTMyKGZpbGVtb2RlLCBzd2lfaW5m
byArIDQpIHx8Ci0gICAgICAgICAgICBnZXRfdXNlcl91MzIobGVuZ3RoLCBzd2lfaW5mbyArIDgp
KSB7CisgICAgICAgICAgICBnZXRfdXNlcl91MzIoZmlsZW5hbWVfbGVuLCBzd2lfaW5mbyArIDgp
KSB7CiAgICAgICAgICAgICBnb3RvIGRvX2ZhdWx0OwogICAgICAgICB9CiAKLSAgICAgICAgaWYg
KGxlbmd0aCA+PSBCVUZTSVopIHsKLSAgICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNU
X0VSUk9SLAotICAgICAgICAgICAgICAgICAgICAgICAgICAiJXM6IGZpbGVuYW1lIHRvbyBsYXJn
ZSAoJSIgUFJJdTMyICIpXG4iLAotICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywg
bGVuZ3RoKTsKLSAgICAgICAgICAgIHNlbWlfY2IoY3MsIC0xLCBFTkFNRVRPT0xPTkcpOwotICAg
ICAgICAgICAgYnJlYWs7CisgICAgICAgIC8qIFRoZSBBQkkgbGVuZ3RoIGV4Y2x1ZGVzIHRoZSBm
aWxlbmFtZSdzIHRlcm1pbmF0aW5nIE5VTC4gKi8KKyAgICAgICAgZmlsZW5hbWVfc2l6ZSA9IChz
aXplX3QpZmlsZW5hbWVfbGVuICsgMTsKKyAgICAgICAgZmlsZW5hbWUgPSBsb2NrX3VzZXIoVkVS
SUZZX1JFQUQsIHBoeXNpY2FsX2ZpbGVuYW1lX2FkZHIsCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGZpbGVuYW1lX3NpemUsIHRydWUpOworICAgICAgICBpZiAoIWZpbGVuYW1lIHx8IGZp
bGVuYW1lW2ZpbGVuYW1lX2xlbl0gIT0gJ1wwJykgeworICAgICAgICAgICAgdW5sb2NrX3VzZXIo
ZmlsZW5hbWUsIHBoeXNpY2FsX2ZpbGVuYW1lX2FkZHIsIDApOworICAgICAgICAgICAgZ290byBk
b19mYXVsdDsKICAgICAgICAgfQogCi0gICAgICAgIGRvIHsKLSAgICAgICAgICAgIGlmIChnZXRf
dXNlcl91OChmaWxlbmFtZVtpXSwgcGh5c2ljYWxfZmlsZW5hbWVfYWRkciArIGkpKSB7Ci0gICAg
ICAgICAgICAgICAgZ290byBkb19mYXVsdDsKLSAgICAgICAgICAgIH0KLSAgICAgICAgICAgIGkr
KzsKLSAgICAgICAgfSB3aGlsZSAoZmlsZW5hbWVbaSAtIDFdKTsKLQogICAgICAgICAvKiBjb252
ZXJ0IEFSTSBBTkdFTCBmaWxlbW9kZSBpbnRvIGhvc3QgZmlsZW1vZGUgKi8KICAgICAgICAgaWYg
KGZpbGVtb2RlIDwgQVJSQVlfU0laRShhbmdlbF90b19ob3N0X2ZpbGVtb2RlX3RhYmxlKSkgewog
ICAgICAgICAgICAgcmVhbF9vcGVubW9kZSA9IGFuZ2VsX3RvX2hvc3RfZmlsZW1vZGVfdGFibGVb
ZmlsZW1vZGVdOwpAQCAtNTA5LDYgKzUwMyw3IEBAIHN0YXRpYyB2b2lkIHNpbV9oYW5kbGVfdHJh
cDAoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgICAgICAgICBxZW11X2xvZ19tYXNrKExPR19H
VUVTVF9FUlJPUiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIiVzOiBpbnZhbGlkIE9QRU4g
bW9kZTogJXVcbiIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBmaWxlbW9k
ZSk7CisgICAgICAgICAgICB1bmxvY2tfdXNlcihmaWxlbmFtZSwgcGh5c2ljYWxfZmlsZW5hbWVf
YWRkciwgMCk7CiAgICAgICAgICAgICBzZW1pX2NiKGNzLCAtMSwgRUlOVkFMKTsKICAgICAgICAg
ICAgIGJyZWFrOwogICAgICAgICB9CkBAIC01MjgsNiArNTIzLDcgQEAgc3RhdGljIHZvaWQgc2lt
X2hhbmRsZV90cmFwMChDUFVIZXhhZ29uU3RhdGUgKmVudikKICAgICAgICAgICAgICAgICByZXQg
PSBndWVzdGZkOwogICAgICAgICAgICAgfQogICAgICAgICB9CisgICAgICAgIHVubG9ja191c2Vy
KGZpbGVuYW1lLCBwaHlzaWNhbF9maWxlbmFtZV9hZGRyLCAwKTsKICAgICAgICAgc2VtaV9jYihj
cywgcmV0LCBlcnIpOwogICAgIH0KICAgICBicmVhazsKLS0gCjIuMzQuMQoK

