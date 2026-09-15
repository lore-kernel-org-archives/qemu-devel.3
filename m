Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCD0C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6H1O-00067f-51; Mon, 14 Sep 2026 20:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6H1N-000672-0y
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:27:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6H1K-00013a-Ru
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:27:36 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN0HtR2134405
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hzaNOhabZ8B
 Kj6Ev4vasHf3UJYzRDcChR8QgiswdWd4=; b=fHH6LocLUgamNRPSi1ODdHDtA7u
 x0PNqZ29FGIxM/vCHB2u5eiSJQfwHcbtz3QVOkn3UwRLPLrmWyDZfJZkR/9kR9/J
 XlnmXAYoW1DnN9BQNVgiA1mzzgv85JtVIk56gwmKibPSiHHeQ9imrS0VWvMT9D9G
 sX6dQmr/+ot7UkENR19EICv+/IJziBMqlWMBYrs5Nz+0ZmQZ+oEdNyM9aL2aldz0
 +p0pj3m48DqNNtt00wWLvzE9qvakM5qEpg/MPOZi1qZuUkXiXj9Hrp/woIIlra1c
 YlgnMZAWsnXPIemPIiKi7whcc4ydqScAowQSkfqK75PpdHbfKd1xUbnCsKg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpmx9se6q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:27:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-398dcfabbf8so9601009a91.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789432043; x=1790036843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hzaNOhabZ8BKj6Ev4vasHf3UJYzRDcChR8QgiswdWd4=;
 b=d2I+DcOk4b5lbw6+RKaalJDcOjd+nujXi8wOpgYUaslcVOeegsgkOpupH/wQb+lVUb
 xsuzcwV2Gz4rc1CYVbgyz8IB/mNlqk3egmMOeiEn+Y525RYAPF9r63ZSv8Pflmf2tMBQ
 AbeTWs88ZBTNoHL5IY7lTnfFVD/D8YG+hmrhNmciTzKGbjRKzCvNUxmPOi9p4yFUSE0I
 5bDxHCLB68lHzKig/Aok3g/DMkO4fOzlZrViWuCqOWB48SQFTei4GvH55FBMJVaniMNQ
 hF4gEL/GCJZtlvUA2BQ+nr4BdDpPCu4s+efHzS48WP/s5vRmTsO18W+3c2qLu+Mf8gSh
 9ESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789432043; x=1790036843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hzaNOhabZ8BKj6Ev4vasHf3UJYzRDcChR8QgiswdWd4=;
 b=RPwSRvJ5EiCOCGZiUiriXII8SEPvlW3w2yYJ98CTBkguZ1HtwlVEeGJfoHp5o84eDX
 DKf/E9nOUgbvFZ737yn/i9UBfoDUFnFbvJc3E8ydOEUDp/T1NuearBonF/gn6PPn+sFj
 KNd63h8X3Cd4O7F1kDz6lp+57nQ71mnHWsbBdB+vHhDsbG4NJ3E4IJHwdMRVF40S8Zvj
 otEmQNmpkGXr/GkldE1wCTwPv3bztPID50l/fx6gipwi+zx3uPsjtfmYZFiTuKp6oG7/
 oUt60pv5jB1BVbs08cbPnV3QjVRtRMMYEBI+wvaUIRUOBGcb8HcT8rZ0lsEQRRgyJED9
 djJw==
X-Gm-Message-State: AFuF++lNhofuOp8LZWFXOvK6qY6WX+cD5ImUwaseArEo8oT1b6iS4pcb
 EdRNfszrwhnZTxuvQ0oltSMOfc9NdjT5N4VcWnMsnRovoxa1rkLe3qSCiBZKmfUQwosgN+mZQv0
 qcuBR/67QjqT4+qZKEHj+/mzGUjjsF5+Yeh+pkjhzdQGRydjcN/WCGritYj6XTDxVwA==
X-Gm-Gg: AYBFou1wj2hJoqYI66/J2Rq+l93rZqzXmkASyDauKs0der9UGeYjnVVPT4b/ALRGktr
 e1HFjYckXG36ccRiVU0m85yAdPG0vUNSQPIb9t91mG8mJRBRY2ATl6hjJUqy16VQR40mHpReuLB
 7Yv97RoLHfbXBIM9WXxYqjSEX0tfBfHJ2lz5kfQwhzkW6B0c9K+9NsdBhGmKQjhsPkEufZkWHTr
 ko2+r9rxsZ/Hg/gqAcfCv0sTdT7N/Ef9fKzQlH9CZ59th/BauVFXe43nArSyAj8VtbdduYph2JG
 uXwpX6hmOmUSF++caSFzd/E5U1zJB6iTDqsR+A3xxa40lYQvONkSoPHjEWeOTGWOecD1kBBPrnO
 shJ+1I90c6aEk04OsYIuzYd//hFvASbwrVtTSCVRE0x4paaqIfBA4/kMzX9w=
X-Received: by 2002:a17:90b:2809:b0:396:d27b:89b9 with SMTP id
 98e67ed59e1d1-39debfa956bmr10812874a91.10.1789432042920; 
 Mon, 14 Sep 2026 17:27:22 -0700 (PDT)
X-Received: by 2002:a17:90b:2809:b0:396:d27b:89b9 with SMTP id
 98e67ed59e1d1-39debfa956bmr10812787a91.10.1789432042311; 
 Mon, 14 Sep 2026 17:27:22 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365a59b18sm26880037c88.2.2026.09.14.17.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 17:27:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 5/6] roms: move s390-ccw from pc-bios
Date: Tue, 15 Sep 2026 00:27:05 +0000
Message-ID: <20260915002706.36318-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915002706.36318-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260915002706.36318-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G+KJgNk5 c=1 sm=1 tr=0 ts=6aa890ec cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=SOqkkMlzv2K7cn8O9awA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwNCBTYWx0ZWRfX1TKKy+MSScMm
 Ujq3efuXQguL+aQhBwxKYXOz8lRxApcZNhaWcql3c8XooYRDhOhahx2iCUNs7Ec5qwxKvzJfu8B
 yGpvyToaCT1voWWmm8QuWPU4TAec614RPGUWkdwZhjFbgMOsxOX5FzbVz3WPnEHB5yAbtfsknRu
 kOUipw7M0ajVY3bzgMXN8XWBzr/I8G3MQTGZfCBVqqnZ7nNFPbm/DmQuAI1H9+Ga65aFl8+lJHI
 0ohFJOoGhScJDxlboGnggM9WX8mJnhucS7Z5Qi+a1XmxatTs6kYvR4suDUbGi0hw9auaGiUnrPR
 4C1TMYXaHX9vAATLRPB15WacgqQ7I7Rq9mGouBYBaDMkg5ovVOgVuN7/2tOVTUVQjABtG5se5wg
 sX6EXcGjg8EY18O8QWvTeqMA53eEMUQxoujr+F5r9OgUn7NEYedDi13eGkPxhQCSV+Rh0V2uO+1
 xbUK2HQxJTzYDxcdy+g==
X-Proofpoint-GUID: oHzM4ykFSe_fYujYU2CaHzuhBMHVb9x7
X-Proofpoint-ORIG-GUID: oHzM4ykFSe_fYujYU2CaHzuhBMHVb9x7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwNCBTYWx0ZWRfXx5WlpXzBYTTF
 4FvWnng+RqRPuxiJT9rqCyA7eW7ovTEm4aEgtZ2luFY02Rh0bAVGYWsCHYlfpD8ttd+eKvyc0Un
 AocOszziPKxgoduo3dVElkwZxUdGAUQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150004
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Update include from tests/tcg/s390x accordingly.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 {pc-bios => roms}/s390-ccw/Makefile        | 0
 {pc-bios => roms}/s390-ccw/bootmap.c       | 0
 {pc-bios => roms}/s390-ccw/bootmap.h       | 0
 {pc-bios => roms}/s390-ccw/bswap.h         | 0
 {pc-bios => roms}/s390-ccw/cio.c           | 0
 {pc-bios => roms}/s390-ccw/cio.h           | 0
 {pc-bios => roms}/s390-ccw/clp.c           | 0
 {pc-bios => roms}/s390-ccw/clp.h           | 0
 {pc-bios => roms}/s390-ccw/dasd-ipl.c      | 0
 {pc-bios => roms}/s390-ccw/dasd-ipl.h      | 0
 {pc-bios => roms}/s390-ccw/helper.h        | 0
 {pc-bios => roms}/s390-ccw/iplb.h          | 0
 {pc-bios => roms}/s390-ccw/jump2ipl.c      | 0
 {pc-bios => roms}/s390-ccw/main.c          | 0
 {pc-bios => roms}/s390-ccw/menu.c          | 0
 {pc-bios => roms}/s390-ccw/netmain.c       | 0
 {pc-bios => roms}/s390-ccw/pci.c           | 0
 {pc-bios => roms}/s390-ccw/pci.h           | 0
 {pc-bios => roms}/s390-ccw/s390-arch.h     | 0
 {pc-bios => roms}/s390-ccw/s390-ccw.h      | 0
 {pc-bios => roms}/s390-ccw/s390-time.h     | 0
 {pc-bios => roms}/s390-ccw/sclp.c          | 0
 {pc-bios => roms}/s390-ccw/sclp.h          | 0
 {pc-bios => roms}/s390-ccw/scsi.h          | 0
 {pc-bios => roms}/s390-ccw/secure-ipl.c    | 0
 {pc-bios => roms}/s390-ccw/secure-ipl.h    | 0
 {pc-bios => roms}/s390-ccw/start.S         | 0
 {pc-bios => roms}/s390-ccw/virtio-blkdev.c | 0
 {pc-bios => roms}/s390-ccw/virtio-ccw.c    | 0
 {pc-bios => roms}/s390-ccw/virtio-ccw.h    | 0
 {pc-bios => roms}/s390-ccw/virtio-net.c    | 0
 {pc-bios => roms}/s390-ccw/virtio-pci.c    | 0
 {pc-bios => roms}/s390-ccw/virtio-pci.h    | 0
 {pc-bios => roms}/s390-ccw/virtio-scsi.c   | 0
 {pc-bios => roms}/s390-ccw/virtio-scsi.h   | 0
 {pc-bios => roms}/s390-ccw/virtio.c        | 0
 {pc-bios => roms}/s390-ccw/virtio.h        | 0
 tests/tcg/s390x/console.c                  | 4 ++--
 tests/tcg/s390x/head64.S                   | 4 ++--
 39 files changed, 4 insertions(+), 4 deletions(-)
 rename {pc-bios => roms}/s390-ccw/Makefile (100%)
 rename {pc-bios => roms}/s390-ccw/bootmap.c (100%)
 rename {pc-bios => roms}/s390-ccw/bootmap.h (100%)
 rename {pc-bios => roms}/s390-ccw/bswap.h (100%)
 rename {pc-bios => roms}/s390-ccw/cio.c (100%)
 rename {pc-bios => roms}/s390-ccw/cio.h (100%)
 rename {pc-bios => roms}/s390-ccw/clp.c (100%)
 rename {pc-bios => roms}/s390-ccw/clp.h (100%)
 rename {pc-bios => roms}/s390-ccw/dasd-ipl.c (100%)
 rename {pc-bios => roms}/s390-ccw/dasd-ipl.h (100%)
 rename {pc-bios => roms}/s390-ccw/helper.h (100%)
 rename {pc-bios => roms}/s390-ccw/iplb.h (100%)
 rename {pc-bios => roms}/s390-ccw/jump2ipl.c (100%)
 rename {pc-bios => roms}/s390-ccw/main.c (100%)
 rename {pc-bios => roms}/s390-ccw/menu.c (100%)
 rename {pc-bios => roms}/s390-ccw/netmain.c (100%)
 rename {pc-bios => roms}/s390-ccw/pci.c (100%)
 rename {pc-bios => roms}/s390-ccw/pci.h (100%)
 rename {pc-bios => roms}/s390-ccw/s390-arch.h (100%)
 rename {pc-bios => roms}/s390-ccw/s390-ccw.h (100%)
 rename {pc-bios => roms}/s390-ccw/s390-time.h (100%)
 rename {pc-bios => roms}/s390-ccw/sclp.c (100%)
 rename {pc-bios => roms}/s390-ccw/sclp.h (100%)
 rename {pc-bios => roms}/s390-ccw/scsi.h (100%)
 rename {pc-bios => roms}/s390-ccw/secure-ipl.c (100%)
 rename {pc-bios => roms}/s390-ccw/secure-ipl.h (100%)
 rename {pc-bios => roms}/s390-ccw/start.S (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-blkdev.c (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-ccw.c (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-ccw.h (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-net.c (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-pci.c (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-pci.h (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-scsi.c (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-scsi.h (100%)
 rename {pc-bios => roms}/s390-ccw/virtio.c (100%)
 rename {pc-bios => roms}/s390-ccw/virtio.h (100%)

diff --git a/pc-bios/s390-ccw/Makefile b/roms/s390-ccw/Makefile
similarity index 100%
rename from pc-bios/s390-ccw/Makefile
rename to roms/s390-ccw/Makefile
diff --git a/pc-bios/s390-ccw/bootmap.c b/roms/s390-ccw/bootmap.c
similarity index 100%
rename from pc-bios/s390-ccw/bootmap.c
rename to roms/s390-ccw/bootmap.c
diff --git a/pc-bios/s390-ccw/bootmap.h b/roms/s390-ccw/bootmap.h
similarity index 100%
rename from pc-bios/s390-ccw/bootmap.h
rename to roms/s390-ccw/bootmap.h
diff --git a/pc-bios/s390-ccw/bswap.h b/roms/s390-ccw/bswap.h
similarity index 100%
rename from pc-bios/s390-ccw/bswap.h
rename to roms/s390-ccw/bswap.h
diff --git a/pc-bios/s390-ccw/cio.c b/roms/s390-ccw/cio.c
similarity index 100%
rename from pc-bios/s390-ccw/cio.c
rename to roms/s390-ccw/cio.c
diff --git a/pc-bios/s390-ccw/cio.h b/roms/s390-ccw/cio.h
similarity index 100%
rename from pc-bios/s390-ccw/cio.h
rename to roms/s390-ccw/cio.h
diff --git a/pc-bios/s390-ccw/clp.c b/roms/s390-ccw/clp.c
similarity index 100%
rename from pc-bios/s390-ccw/clp.c
rename to roms/s390-ccw/clp.c
diff --git a/pc-bios/s390-ccw/clp.h b/roms/s390-ccw/clp.h
similarity index 100%
rename from pc-bios/s390-ccw/clp.h
rename to roms/s390-ccw/clp.h
diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/roms/s390-ccw/dasd-ipl.c
similarity index 100%
rename from pc-bios/s390-ccw/dasd-ipl.c
rename to roms/s390-ccw/dasd-ipl.c
diff --git a/pc-bios/s390-ccw/dasd-ipl.h b/roms/s390-ccw/dasd-ipl.h
similarity index 100%
rename from pc-bios/s390-ccw/dasd-ipl.h
rename to roms/s390-ccw/dasd-ipl.h
diff --git a/pc-bios/s390-ccw/helper.h b/roms/s390-ccw/helper.h
similarity index 100%
rename from pc-bios/s390-ccw/helper.h
rename to roms/s390-ccw/helper.h
diff --git a/pc-bios/s390-ccw/iplb.h b/roms/s390-ccw/iplb.h
similarity index 100%
rename from pc-bios/s390-ccw/iplb.h
rename to roms/s390-ccw/iplb.h
diff --git a/pc-bios/s390-ccw/jump2ipl.c b/roms/s390-ccw/jump2ipl.c
similarity index 100%
rename from pc-bios/s390-ccw/jump2ipl.c
rename to roms/s390-ccw/jump2ipl.c
diff --git a/pc-bios/s390-ccw/main.c b/roms/s390-ccw/main.c
similarity index 100%
rename from pc-bios/s390-ccw/main.c
rename to roms/s390-ccw/main.c
diff --git a/pc-bios/s390-ccw/menu.c b/roms/s390-ccw/menu.c
similarity index 100%
rename from pc-bios/s390-ccw/menu.c
rename to roms/s390-ccw/menu.c
diff --git a/pc-bios/s390-ccw/netmain.c b/roms/s390-ccw/netmain.c
similarity index 100%
rename from pc-bios/s390-ccw/netmain.c
rename to roms/s390-ccw/netmain.c
diff --git a/pc-bios/s390-ccw/pci.c b/roms/s390-ccw/pci.c
similarity index 100%
rename from pc-bios/s390-ccw/pci.c
rename to roms/s390-ccw/pci.c
diff --git a/pc-bios/s390-ccw/pci.h b/roms/s390-ccw/pci.h
similarity index 100%
rename from pc-bios/s390-ccw/pci.h
rename to roms/s390-ccw/pci.h
diff --git a/pc-bios/s390-ccw/s390-arch.h b/roms/s390-ccw/s390-arch.h
similarity index 100%
rename from pc-bios/s390-ccw/s390-arch.h
rename to roms/s390-ccw/s390-arch.h
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/roms/s390-ccw/s390-ccw.h
similarity index 100%
rename from pc-bios/s390-ccw/s390-ccw.h
rename to roms/s390-ccw/s390-ccw.h
diff --git a/pc-bios/s390-ccw/s390-time.h b/roms/s390-ccw/s390-time.h
similarity index 100%
rename from pc-bios/s390-ccw/s390-time.h
rename to roms/s390-ccw/s390-time.h
diff --git a/pc-bios/s390-ccw/sclp.c b/roms/s390-ccw/sclp.c
similarity index 100%
rename from pc-bios/s390-ccw/sclp.c
rename to roms/s390-ccw/sclp.c
diff --git a/pc-bios/s390-ccw/sclp.h b/roms/s390-ccw/sclp.h
similarity index 100%
rename from pc-bios/s390-ccw/sclp.h
rename to roms/s390-ccw/sclp.h
diff --git a/pc-bios/s390-ccw/scsi.h b/roms/s390-ccw/scsi.h
similarity index 100%
rename from pc-bios/s390-ccw/scsi.h
rename to roms/s390-ccw/scsi.h
diff --git a/pc-bios/s390-ccw/secure-ipl.c b/roms/s390-ccw/secure-ipl.c
similarity index 100%
rename from pc-bios/s390-ccw/secure-ipl.c
rename to roms/s390-ccw/secure-ipl.c
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/roms/s390-ccw/secure-ipl.h
similarity index 100%
rename from pc-bios/s390-ccw/secure-ipl.h
rename to roms/s390-ccw/secure-ipl.h
diff --git a/pc-bios/s390-ccw/start.S b/roms/s390-ccw/start.S
similarity index 100%
rename from pc-bios/s390-ccw/start.S
rename to roms/s390-ccw/start.S
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/roms/s390-ccw/virtio-blkdev.c
similarity index 100%
rename from pc-bios/s390-ccw/virtio-blkdev.c
rename to roms/s390-ccw/virtio-blkdev.c
diff --git a/pc-bios/s390-ccw/virtio-ccw.c b/roms/s390-ccw/virtio-ccw.c
similarity index 100%
rename from pc-bios/s390-ccw/virtio-ccw.c
rename to roms/s390-ccw/virtio-ccw.c
diff --git a/pc-bios/s390-ccw/virtio-ccw.h b/roms/s390-ccw/virtio-ccw.h
similarity index 100%
rename from pc-bios/s390-ccw/virtio-ccw.h
rename to roms/s390-ccw/virtio-ccw.h
diff --git a/pc-bios/s390-ccw/virtio-net.c b/roms/s390-ccw/virtio-net.c
similarity index 100%
rename from pc-bios/s390-ccw/virtio-net.c
rename to roms/s390-ccw/virtio-net.c
diff --git a/pc-bios/s390-ccw/virtio-pci.c b/roms/s390-ccw/virtio-pci.c
similarity index 100%
rename from pc-bios/s390-ccw/virtio-pci.c
rename to roms/s390-ccw/virtio-pci.c
diff --git a/pc-bios/s390-ccw/virtio-pci.h b/roms/s390-ccw/virtio-pci.h
similarity index 100%
rename from pc-bios/s390-ccw/virtio-pci.h
rename to roms/s390-ccw/virtio-pci.h
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/roms/s390-ccw/virtio-scsi.c
similarity index 100%
rename from pc-bios/s390-ccw/virtio-scsi.c
rename to roms/s390-ccw/virtio-scsi.c
diff --git a/pc-bios/s390-ccw/virtio-scsi.h b/roms/s390-ccw/virtio-scsi.h
similarity index 100%
rename from pc-bios/s390-ccw/virtio-scsi.h
rename to roms/s390-ccw/virtio-scsi.h
diff --git a/pc-bios/s390-ccw/virtio.c b/roms/s390-ccw/virtio.c
similarity index 100%
rename from pc-bios/s390-ccw/virtio.c
rename to roms/s390-ccw/virtio.c
diff --git a/pc-bios/s390-ccw/virtio.h b/roms/s390-ccw/virtio.h
similarity index 100%
rename from pc-bios/s390-ccw/virtio.h
rename to roms/s390-ccw/virtio.h
diff --git a/tests/tcg/s390x/console.c b/tests/tcg/s390x/console.c
index 061b9437d98..34b9c7f86ea 100644
--- a/tests/tcg/s390x/console.c
+++ b/tests/tcg/s390x/console.c
@@ -1,11 +1,11 @@
 /*
  * Console code for multiarch tests.
- * Reuses the pc-bios/s390-ccw implementation.
+ * Reuses the roms/s390-ccw implementation.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#include "../../../pc-bios/s390-ccw/sclp.c"
+#include "../../../roms/s390-ccw/sclp.c"
 #include "string.h"
 
 
diff --git a/tests/tcg/s390x/head64.S b/tests/tcg/s390x/head64.S
index 0523fcacb33..23b15ea1a72 100644
--- a/tests/tcg/s390x/head64.S
+++ b/tests/tcg/s390x/head64.S
@@ -1,11 +1,11 @@
 /*
  * Startup code for multiarch tests.
- * Reuses the pc-bios/s390-ccw implementation.
+ * Reuses the roms/s390-ccw implementation.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #define main main_pre
-#include "../../../pc-bios/s390-ccw/start.S"
+#include "../../../roms/s390-ccw/start.S"
 #undef main
 
 .text
-- 
2.43.0


