Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8D4C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9b-0005A9-2s; Thu, 24 Sep 2026 21:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9O-0004xB-3X
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9M-0005t8-Fu
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:57 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1kn573181623
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zF7wNM0uK32PaFnM0cjYMMOMVW+Srqc+PhvZl4ELL8A=; b=EAk7CqKENFOuyEw5
 lGG4DPT/Lj9zLidzW7uHwWBlsH2Fk+Th3CTFCn7rUK3DLvIAnkm6TNAjoeqscFsJ
 KTy7DraEbzdDovjPEDR9RkIUy7E1PpZJH5vYrpldBVGm2lP6oniog9TMgLgh0HPt
 c1+k8j2fEu74wukTAI3IZOUqYuozgydnl47+3Rht1q1uexA02qwKywQgH4D6mMPr
 uJhRl820j/otz/PJjPb+QJ1JC4nuJ7N9Pd8xg9ATJSB1PV7gIQlXRJhHfSoSOksZ
 TsOXrgriCG1N+rBGfGkfL79/HhQQIb7wzR3d17Tg8x41k9u6/Ztn4SWs2P18Os4U
 4JxYPg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw94k99ej-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-331b2ec616fso1392831eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301294; x=1790906094; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zF7wNM0uK32PaFnM0cjYMMOMVW+Srqc+PhvZl4ELL8A=;
 b=H38c3hwsm/B202lKtv0PDvZEFpmeD78vqP6pD/MWXhiEGqAy4u6GDg86X4EL6ucUdl
 Yc4xrqHY/68YZl1djYUcTKSkox464bsf/MTi4dlLI9zXHDbf26qa4dGsleqZ4kPiayfs
 Gqswic/W6P9LswPwKG07EcDkpY49oFkl/5TsuNzes4bB7yJ3hkDjTgRUj8y5TxiTsFZv
 fsqCGKT88swfR+otYo4Id6UOECvBM5Cj4jBpEpYFSZKJEiuYiXg4QxImLElKgE8WKKbR
 /J8yFMafNiNTQubZR+VjqEXNzAdDEqCPj+R0SSJKr7HY11yrZno9TKQT/vBlnsIvrPl9
 On4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301294; x=1790906094;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zF7wNM0uK32PaFnM0cjYMMOMVW+Srqc+PhvZl4ELL8A=;
 b=GnVrQB5t6fBKevn14QiUOBpOasfTwjASHx76L6J0TAb8YH7nWDYGPFFVPAbwz+ypMD
 qO1qkymm8p/seiIIJwIHY46BZyAh9YjRF4KjCxmI1bfRKCINV25+bRjGWBQsztH4Z7Qn
 PgkSNHc/B76O2HsxakIkcEBQiRx5eg3jahuF4SoM065uC+9hxzn9twT3yc9iDXq54Pn1
 KItjSiAvD5Gr6jVS3VLyNb3GhgkaB6uIvrncRU6uMpBXM9uNOsgZ5kwpuxRMzGWhN/K0
 4/V/ycqkO3OtrUlTHQku9jYY3rLwB+n7pEPKC4LYXRa7NEynogF+g/v9f765kcEWUzWp
 PnDQ==
X-Gm-Message-State: AFuF++mI77l9d3UewcYXONarENmCHpfJiCygpg7eNIcYzChAd7pXIspT
 tzOff+hufAmfkRiJINWczRQ4bljDHthQRPmMkmKPOcdTrFhy+UzliSGaOamaMTqGgjuZ20gEkHY
 Km70ScHtsmRQdzrccfs72RYRZe1qZT80TEphHLvpArANUGJC8H1sznDdsbCPHEalL/A==
X-Gm-Gg: AYBFou0XQT3jqBj3p5Lekz4TwEz3BfTDaa78NaT4V2erE9oFKlRCb/wBEVISSdg5ajZ
 lGqY9Wzn57t1rrYbdPBDYsRaAeahumR77QMMB1mq6MkFqI8RiTm0v9afiRYwDgvn/6gTGrxuwgv
 ht6md67iszxZpDsBlbxEIuObsd5lD+GI+h/YkiGAdxgJutTfGd5hHxIYaC6U0c/ERDZcI1YiFuW
 q69QhiLcPsB9JHxUIUWpNO0KnXavFPwRGZcTMZOa00bly2ucAODNajA57s9ihHkA73WoDfPges2
 vh2Z0Hw3SlpoYXU19ulDPVLMM64MprkHYdBqQOyz2ZPurfh2xQ1LKIp9E8jGqGeVHOthywbhUDH
 7NT41oH04CvSJcwKXKiuaIIcHnpy8Wdp0nBvZjVeRTqhMIoM=
X-Received: by 2002:a05:693c:394a:b0:33e:3f5b:3ffe with SMTP id
 5a478bee46e88-340039b50b3mr4877980eec.27.1790301293985; 
 Thu, 24 Sep 2026 18:54:53 -0700 (PDT)
X-Received: by 2002:a05:693c:394a:b0:33e:3f5b:3ffe with SMTP id
 5a478bee46e88-340039b50b3mr4877950eec.27.1790301293427; 
 Thu, 24 Sep 2026 18:54:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:54:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Sid Manning <sid.manning@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 12/40] tests/tcg/hexagon: fix undefined signed left shift in
 brev.c
Date: Thu, 24 Sep 2026 18:54:01 -0700
Message-Id: <20260925015429.2579174-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=aaj0Dhot c=1 sm=1 tr=0 ts=6ab5d46e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=4mfA0qixJg5lnvjYkK4A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: uB0lwhJdqcRhPKE29lXUM-In3ClSvJf-
X-Proofpoint-ORIG-GUID: uB0lwhJdqcRhPKE29lXUM-In3ClSvJf-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX6kb6CsGo6PGW
 42obxg2pUHwY2SBLeYKoxfvX4nn6nPsIrCeRkbbZnxRyRs5Qm90ybN+jEUQ+7YX+dP5ADmYdsul
 xFrMS4stc1GATH33pgvKU0UCZ1Wc7yEp2AefYptZTv+CUZwhGQjJNpejbJl1wFE76PLjFTo8XaU
 Js9NVGWzMCNuuy9Fez1E3K/bgV99aKBOzwGwIBqzOm2NlL2ML+bDEyx2haLf4EfTnOH8kfHlpXc
 9VMGqv1aeJOTQ/wLlkIZK5t97UdOV3roH7OjpPxN78rKOHFK0VXQxznG1IHp8+c7wmU53Zk3G+P
 MQQ0XcRHvU4cVTV3GLX7hs3OW1TRGJf6tDHRj3TmHj2fk7Y07PMZjRkRjMIGlDkE608gjlkFQu2
 CyE5e32gzlEB9zfoiORWg7R21+hOGnkIMKl7NbISbrXgBCMM+nCdP2nbMyVDfMdvPJQxyz4m86s
 UBXKo9NHm/HVJEuaMmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfXylAxXVvHKWMc
 UKLIpdJtaHMIIW1f6K66Cjuvku4ajIyJ3jfJTFgL14bwqU8XU42TJNgHcTWrSomGAWAoS7xZVR9
 IVOzvMrQHTHoIclUakyeSZUdemVoDJ4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250007
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Q2FzdCB0byB1aW50MzJfdCBiZWZvcmUgbGVmdC1zaGlmdGluZyBpbiBzZXh0OCgpIHRvIGF2b2lk
IHVuZGVmaW5lZApiZWhhdmlvciB3aGVuIHNoaWZ0aW5nIGEgbmVnYXRpdmUgdmFsdWUuIFRoZSBz
dWJzZXF1ZW50IGFyaXRobWV0aWMKcmlnaHQgc2hpZnQgb24gdGhlIGludDMyX3QgY2FzdCBjb3Jy
ZWN0bHkgc2lnbi1leHRlbmRzIHRoZSByZXN1bHQuCkZvdW5kIHdpdGggVUJTYW4uCgpSZXZpZXdl
ZC1ieTogU2lkIE1hbm5pbmcgPHNpZC5tYW5uaW5nQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1v
ZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0
cy90Y2cvaGV4YWdvbi9icmV2LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9icmV2LmMg
Yi90ZXN0cy90Y2cvaGV4YWdvbi9icmV2LmMKaW5kZXggNmM3YjEzNDA4NDkuLjE0NzNlMzA5ZWUw
IDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9icmV2LmMKKysrIGIvdGVzdHMvdGNnL2hl
eGFnb24vYnJldi5jCkBAIC0xMDYsNyArMTA2LDcgQEAgdWludDMyX3QgYml0cmV2ZXJzZSh1aW50
MzJfdCB4KQogCiBpbnQzMl90IHNleHQ4KGludDMyX3QgeCkKIHsKLSAgICByZXR1cm4gKHggPDwg
MjQpID4+IDI0OworICAgIHJldHVybiAoaW50MzJfdCkoKHVpbnQzMl90KXggPDwgMjQpID4+IDI0
OwogfQogCiAjZGVmaW5lIFRFU1RfQlJFVl9MT0FEKFNaLCBUWVBFLCBCVUYsIFNISUZULCBFWFAp
IFwKLS0gCjIuMzQuMQoK

