Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286B9CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbndK-00034r-JL; Mon, 22 Jun 2026 19:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndH-00030L-1J
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndF-0002Xy-Fm
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:46 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZjF63222592
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1ECOxl3Fg5yOtnmQVv6BfaD55uXykPkSbZivFHhIDWY=; b=iWkOfIxG7XvYMjix
 etFwrOtWZYQMkjMMSRQNcU/k6ZRgu8fVGMAL3WSpoN0ZlIv7nz6Lk0hoGW/Xs5QT
 VSw9dZneOTMOWxshHlswPkDSYIENzsQrvrKxjHX1uBncmEC8NLhjaQiZ1QQjsWtP
 Rd1auM+jGMB0uNEdGKuVNNhii1diN2Ot3/iEClz74SBRhpWRF4WFboVf6W81LBlH
 CkBNQys6D6bSS4duL2BhgdAQVi0y5Yd4ZaKNOLBqY6k+NQTiu8Ll7IIJuM6Ti8KI
 yEPUeKxOxyJ7Q+DSpOldtEuvNlJejDpQO2y7FcmI71HWDaQyHS0YY6GiLg2Rzi8A
 10OsJQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5sn20gp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:44 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c17bc96afso2933471eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169243; x=1782774043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ECOxl3Fg5yOtnmQVv6BfaD55uXykPkSbZivFHhIDWY=;
 b=ZJERXrb5uNgXfrgpJ/kjtcFISZQHstFKWiJZwV87H1d+ei3PNBKuC2By+Z6GgykIFE
 ByAFeLPOCxSgv54P0Ec0Lwq8q+gO6P2yEETMDj8FBPxwZCUKFTUJ+wMEeNj9EJZVEzlq
 EdnsQAcNWxQNTHNaDRfJutp7oLkMqYK7abgJnchEUehWRwynckp9ymFnGRwWWJRJg9UG
 pto3yA7K197NSkI8Yix/yMmkuvS2t5AH/xK/UepNGNMz83uk/BSxL3jJNCCT5BR4CiRq
 SSO1ntjEMdF6A1+PMBMeHlsjrgsGZlT6fi2r/j5wB/YFCBeeLeJw/Z63d++EsQX0VIpM
 hymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169243; x=1782774043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ECOxl3Fg5yOtnmQVv6BfaD55uXykPkSbZivFHhIDWY=;
 b=o5vqyvqDWDRWF19gUcHJUtEWCR2B9i+WL9N4WZU+1II9FUF0cIpdNh3FDVSQGm/WrW
 zi8OsqBpiYNyvL4Tyfr1qOnZJM1MVti/eAn/Hl8ZmwqplNJ9OhbrH52HYzZIPUhgpTNd
 vFsgzgZy4VgZdbVPzQr1TWL5q9Z7mEas69gxU4eF3SJuXEh6jXX2i6XmOnZwe0fPCRUf
 mK/YqQZb7ZuILpfJ9Bw8IgXGWSY3lmNDyYinPuhAltBbUwFqNHdo3Bep9RHOhmkf49N3
 fEtArCqxILT94uY2i+AMRjgBjRrbd85W8Z+G7pK0/S+8XCsaLZP9V6B0DdADFxl/n1Cd
 Q97g==
X-Gm-Message-State: AOJu0YxPHcFK2a5cOhowItisflbvGO97HfX7CvZmylOLfhzUyzf6UbYI
 yidqNh5Eaj3OHCaqF4+87FnRHT21Jq5lxBzr36nhACld/9n1UfKo7/84X5IHEP3/tFKxipZEu4r
 Ia3y0XjwOHGynsBmezO+Si3wxuSuwjrj/KG7FHW7OuTqyDgDUipDyoPU7OgU/YLMCVA==
X-Gm-Gg: AfdE7cluHJI2T2d8LDsDyeARfT2zXiHiHxUZIHOd/fbkGOdIpU40VN0UP0hb+PKtkEz
 V/MyWJ4+quqO4OhYC95xLLYsI2oXjKye3J9mQNi11++j7Cd0pgZDGv66LnbtJED70ugPUdHo0oj
 eJcpoYljXfKmLQ/zzYJ0K8aoj0SdiiSaKArvswMaM0g6WO9l83PYrm5BjDloNrpCHrGmczqqnYQ
 p0JKTNrYZTUG9m1Pw0F3BAD6Opc4eVdULOiyPE9jE18zb3Xbc4Cut59sLEQ2PsKK8HbGzvFXCOb
 nKIUgP/KcPO/mfgGGf47p/9navlL1VZxqK771rOGcm7DUP0NpGivdL+2Xs2CoQLAQVMJZ/pthWE
 px2mBCLKQ6dnPfCK37kESOAEVHWDGLCL41zkFkZJASPzni4G6hbTTPXPaI6I=
X-Received: by 2002:a05:7022:438d:b0:139:8674:e45b with SMTP id
 a92af1059eb24-139c5d05ccamr355130c88.14.1782169243220; 
 Mon, 22 Jun 2026 16:00:43 -0700 (PDT)
X-Received: by 2002:a05:7022:438d:b0:139:8674:e45b with SMTP id
 a92af1059eb24-139c5d05ccamr355085c88.14.1782169242528; 
 Mon, 22 Jun 2026 16:00:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 63/75] target/hexagon: Add TCG overrides for transfer insts
Date: Mon, 22 Jun 2026 15:28:52 -0700
Message-Id: <20260622222904.607771-64-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: bfg90APf-_VfQ4x77jkxc2kNM1YxM_2v
X-Proofpoint-ORIG-GUID: bfg90APf-_VfQ4x77jkxc2kNM1YxM_2v
X-Authority-Analysis: v=2.4 cv=PuKjqQM3 c=1 sm=1 tr=0 ts=6a39be9c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LN73x9Sj_Gq4gUX8wwYA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfXxHfYnPk2yeg6
 yN99z5EO9J4BcM2o8AXwd+11j+Vy2m3ACKx3gSAzkJKY70NmZvLK/w4JBgIB5tz8LAoZFTJTGnd
 u0+5pI2HFPuG717GBrJ6k2/Nwxd1VQ4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfXxv91TE+IbOQ3
 /tRv0darLUJBasQDvA79wTfZSXj+ktkp9y3Ago6kUzxgzccUH+ftfKmjdApdA4SUtejxy0ch+gp
 jgUAJI4DortdkTBMOZWelbHIkL8FNgH2Vd9URHB4NgI22djsmgl/3BmKaQtva5QaUG4pv3ekGBl
 Gzm8WA3E1PWPZuKVIp7UstxJpg3ETh9EUsWBql0W1/Y81Y7Ky7hlc6Ap6A6kIFdzaRHHKilU0tK
 nUcMfpvjDXls7ovPN/VEeBfOb1O4xIbTDbFI+PHGvalmcNO1+09da/jR7gnAhdwU7U7xkjn7E6x
 smIwxoQ3HG39RFbZ6VXn4Pko+Opek0nYEpUL8xfpDXTAYw0OuKTgiyTAdYBj6bjHUDDxZimyX+I
 I1/lEHnc/jMImTn5JxMkUEKI0IYaVb1uL9Vml5rfeif7mrikFTgr/jy7SnZgYZ+Y/bTjBZvmGg+
 af+P4C+AfVJ6Y7+iGSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220221
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMjUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2df
c3lzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4IDY4YjIzODk1NDI4Li5h
ZjUwMzIyMTRjNCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC05NSw2ICs5NSwzMSBAQAogICAgICAg
ICBnZW5faGVscGVyX3N0b3AodGNnX2Vudik7IFwKICAgICB9IHdoaWxlICgwKQogCisjZGVmaW5l
IGZHRU5fVENHX1kyX3RmcnNjcnIoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfdGwoUmRW
LCBTc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfdGZyc3JjcihTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX21vdl90bChTZFYsIFJzVikKKworI2RlZmluZSBmR0VOX1RDR19ZNF90ZnJzY3BwKFNI
T1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X2k2NChSZGRWLCBTc3NWKQorCisjZGVmaW5lIGZH
RU5fVENHX1k0X3RmcnNwY3AoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfaTY0KFNkZFYs
IFJzc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfRzRfdGZyZ2NycihTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX21vdl90bChSZFYsIEdzVikKKworI2RlZmluZSBmR0VOX1RDR19HNF90ZnJncmNyKFNI
T1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X3RsKEdkViwgUnNWKQorCisjZGVmaW5lIGZHRU5f
VENHX0c0X3RmcmdjcHAoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfaTY0KFJkZFYsIEdz
c1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfRzRfdGZyZ3BjcChTSE9SVENPREUpIFwKKyAgICB0Y2df
Z2VuX21vdl9pNjQoR2RkViwgUnNzVikKKworCiAvKgogICogcnRlIChyZXR1cm4gZnJvbSBleGNl
cHRpb24pCiAgKiAgICAgQ2xlYXIgdGhlIEVYIGJpdCBpbiBTU1IKLS0gCjIuMzQuMQoK

