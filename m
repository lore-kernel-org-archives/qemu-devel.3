Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F13C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3vzM-0004kf-Oy; Tue, 08 Sep 2026 09:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3vzK-0004jp-Mp
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:35:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3vyw-0006GP-TN
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:35:50 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688Ckwbs3844402
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 13:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wXn2aDfpqQZbmVw2AYnPiH3g2Ka7TkFx+BaIm80wyoY=; b=KvLwu9oChBmRn23X
 I37tNrFzbwMHPyogKmhI8bgPdxxF69hOG/ajjCtVsGsivg0/QJZobFhDz4vb6y4G
 2DJiYOhVbzRDlNAR48ibxA78m29UUUA/P4WhmS9tXkdf+EbDuBSN1g75x+knxjF9
 fHb+zYD05P4rMJeL6h7gmSvrqqCcDMDGH2iN+JvookpVFw082rg3dAYgIvTAxOwg
 90QUGtfHPODe0GvMIk3cSe1xSBcMNLtJs2N2Sf4LHgiXd9G1bY/YOyZmMf1P3/51
 5dMu2eUih35zdtBoPMPsxb2Y/LhMGRutDGlz0W9qj+4oTTSjiBcdRQgE7ZhZucRL
 xHjacg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjg8xrsx7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 13:35:23 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d001671a54so82386325ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788874523; x=1789479323; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wXn2aDfpqQZbmVw2AYnPiH3g2Ka7TkFx+BaIm80wyoY=;
 b=E0kuHIUUUt7HivtHSHEN6uIgtHYaJt7TB4jPIkQzjaWXzvdpuxA/mCikZPFOEPSFud
 BIMeacpJzL7h8tLrchq58tfGrDO0fgSd9xbAg+OnLoj3fuP41ddgW2WXAJReI6BntUyx
 46RexdhNTtkHMiSblZfuorXHgVIDB3W0kNzdkPbI5YfFqV/o62otjZ8bLLbUwC3oo4Fd
 xxQ1S6jXZW9O6dKf0JT8i3PBmTJuRdzXVUYzQgdbE1EoY9afM7X/08fUUTUFxuVT8bOU
 qJB40JhG6+n/stxbuHZOw5LyQlofGX3rc+O+KELhn32mc0zZoLGABbxoWUyTJqhiD+Ga
 SutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788874523; x=1789479323;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wXn2aDfpqQZbmVw2AYnPiH3g2Ka7TkFx+BaIm80wyoY=;
 b=asmiCkG9TMIIciF/u48THGjdgl+RfBcl+SLJowQAuhID9fx+9gNE+683T5NbcDgs8F
 u+gygXR8DMfWteB6qqZiKwHqeK0+BA5o/EESkANnzcpvyTemx9uqp6dyS+DyHyEihuFE
 BJjL7dL12qQ3VZrFvlguy9Y1iuSGXYlYCxoP4QOZ93tyUvjQaLMfg65XeapCrXdQmGHp
 8z9TJKE6kZk0M7S541vPccw8GTZ0BLI0ZU6DKZ5yGBvZkYS74uORxpnZW/c6ou/sCUtq
 1c7BMmgiKfDhTh5gtC/bQ+BJzlMloXOSUflTXi8y+W7Nf7RxCCMAa4vFCbDMgfSTpN5H
 A9ow==
X-Gm-Message-State: AFuF++kWP8HG8Su/8vB+gVWktNKGYEhA0pcgMCimGanku+puAie91pjE
 VX9awnpJiXweSUhqGHmTOgDJvq9cMvngVSTI8ySNqea+mah9SSeQ0ECrvU8HZ14ucLaARWwD3/a
 HHM4xvPKiZcbMW7TdSCpUyVouJCQA9Fy/Fov+W4g/xLE6aAehcfBwWuXPLxWN/SqqJQ==
X-Gm-Gg: AYBFou1RH5ChRs1OYJCAFmVHSmuaOOne+zM02h/Pfc6UVLAF9wr/SwYpdFTGvNC4sNn
 vEWac8Wl9hBlMxzjC49hkKU4tRmPQnld/8cUEIOOW96tDVbRzl3LJkcSI1XahWlqwWYgnKtc1DW
 nblV5RIrm35GyXnOpayb+ys1NUwAxi28JpIB3Ci/ZpOg1AySRVjg0cczjFfpePQ4QOZLCa41I81
 2vREXepVeDR6+y9Tmdg+sAdWoBqvTBSk9sjBTDm9XAcvV8GDAt5yTiAtkDGQGD0N7/WDwQ0yGNK
 nYc+j+JHDsWEMwt/O1l1YU6pWvQcqDwOKyiOMc/6lJ96zKgctUQ4YhNndnm5389XZhXA8qq8bAa
 vVnG8bpG7b2vCCgc1gQ2FJDDacT2i90r4qjI9/lJ+uulyMIps
X-Received: by 2002:a17:90b:3c42:b0:38e:fea2:df53 with SMTP id
 98e67ed59e1d1-39b260d2977mr43727324a91.4.1788874523177; 
 Tue, 08 Sep 2026 06:35:23 -0700 (PDT)
X-Received: by 2002:a17:90b:3c42:b0:38e:fea2:df53 with SMTP id
 98e67ed59e1d1-39b260d2977mr43727257a91.4.1788874522679; 
 Tue, 08 Sep 2026 06:35:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-334fbd5e6f6sm29029079eec.23.2026.09.08.06.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 06:35:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com
Subject: [PATCH 4/5] target/hexagon: add Y2_tlbpp as unimplemented
Date: Tue,  8 Sep 2026 06:35:10 -0700
Message-Id: <20260908133512.2353957-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908133512.2353957-1-brian.cain@oss.qualcomm.com>
References: <20260908133512.2353957-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=J7GaKgnS c=1 sm=1 tr=0 ts=6aa00f1b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=lfClExg8J67ehGbBbBgA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: l65oQ2I8eXaYg7Y6hQzvevICGBoj67Dg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE0NSBTYWx0ZWRfXxk7LzhCtgrs4
 8Ne6G5MAVQQp3tRhvIVkynQMXcBLr69U45nW3c2mA7NbpkUkag01C3eSfFxEcvTtRa5DuOKrPWE
 KeDfhHpgaS3SmnyZq1Lf/B1gliYJCkjb8RFHIooLhNmO6+zuKqjDOffF0c6LSveOe0jVdG4jXfp
 oySf6GsXpoeyjorphiN/GATIp3m37uInU0IQjMUsvrPRbsI4PMPAkQMsDlvfj18rr9obUglhuSW
 LDg599kfWY3CexvJsYnACEH0Tp9j+pFSew/qiTei+MxpFR+j/e13IADGCkoxQ5d1QaAk3d5xRIE
 K5Ka+OC300PEpKtOtiarESQmPTSED45nK8pi5hm7KShr3EHt310ZcpAumbq6gBfLJvmnsPFLj39
 nPpJQyQj+gkkR11UpYm7dd9WxpLn7vE4NmXVZ+BYp+g2la+7ktg6YJQc7o3wKUZoWj8zSpXpknU
 ljQ85qSZYEe4EQPZQjQ==
X-Proofpoint-GUID: l65oQ2I8eXaYg7Y6hQzvevICGBoj67Dg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE0NSBTYWx0ZWRfXzfgdzOxMSl76
 +IK5xAO8jiT4/4+pVYfEmKEUTdhvjpHbB6dj5tk0Ui7RzYkU8mJpdJh8FDevIhp5a9WguIGhuYO
 JtbLRETKqJbgw8CDNI26aIwsIqItjAQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080145
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

WTJfdGxicHAgaXMgbW9zdGx5IGFzc29jaWF0ZWQgd2l0aCB0aGUgbm90LXlldC1pbXBsZW1lbnRl
ZCBETUEKZW5naW5lLiAgTGV0J3MgZGVjb2RlIGl0IGFzIHVuaW1wbCBmb3Igbm93LgoKU2lnbmVk
LW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRh
cmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaCAgICAgICAgICAgfCAzICsrKwogdGFyZ2V0L2hleGFn
b24vYXR0cmlic19kZWYuaC5pbmMgICAgICB8IDEgKwogdGFyZ2V0L2hleGFnb24vdGFnX3Jldl9p
bmZvLmMuaW5jICAgICB8IDIgKysKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2VuY29kZV9wcC5k
ZWYgfCAxICsKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL3N5c3RlbS5pZGVmICAgfCAyICsrCiA1
IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL3N5c19tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaAppbmRleCBhNDlj
NzI3MTVkYy4uMmUxM2JhMDBjOGEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3N5c19tYWNy
b3MuaAorKysgYi90YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmgKQEAgLTE3Nyw2ICsxNzcsOSBA
QAogICAgICAgICAgICAgICAgICAgICAgZlRMQl9OT05QT1cyV1JBUChmVExCX0lEWE1BU0soSU5E
RVgpKSkKICNkZWZpbmUgZlRMQlAoVExCSEkpIFwKICAgICBoZXhfdGxiX2xvb2t1cChlbnYsICgo
VExCSEkpID4+IDEyKSwgKChUTEJISSkgPDwgMTIpKQorI2RlZmluZSBmVExCUFAoVExCSEkpICh7
IFwKKyAgICBxZW11X2xvZ19tYXNrKExPR19VTklNUCwgInRsYnBwIGlzIG5vdCBpbXBsZW1lbnRl
ZFxuIik7IFwKKyAgICAwOyB9KQogI2RlZmluZSBpaWNfZmx1c2hfY2FjaGUocCkKIAogI2RlZmlu
ZSBmSU5fREVCVUdfTU9ERShUTlVNKSAoeyBcCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9h
dHRyaWJzX2RlZi5oLmluYyBiL3RhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jCmluZGV4
IDhiNGViMjdkNjgyLi41YTk4ZWEzMzEzOSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vYXR0
cmlic19kZWYuaC5pbmMKKysrIGIvdGFyZ2V0L2hleGFnb24vYXR0cmlic19kZWYuaC5pbmMKQEAg
LTI1LDYgKzI1LDcgQEAgREVGX0FUVFJJQihOQV9OVCwgIk5vbi1BbGxvY2F0aW5nIE5vbi1UZW1w
b3JhbCBpbnN0cnVjdGlvbiIsICIiLCAiIikKIAogREVGX0FUVFJJQihQUklWLCAiTm90IGF2YWls
YWJsZSBpbiB1c2VyIG9yIGd1ZXN0IG1vZGUiLCAiIiwgIiIpCiBERUZfQVRUUklCKEdVRVNULCAi
Tm90IGF2YWlsYWJsZSBpbiB1c2VyIG1vZGUiLCAiIiwgIiIpCitERUZfQVRUUklCKFRMQlBQX0lO
U04sICJFeHRlbmRlZCAoNjQtYml0IFZBKSBUTEIgcHJvYmUgaW5zdHJ1Y3Rpb24iLCAiIiwgIiIp
CiAKIERFRl9BVFRSSUIoRlBPUCwgIkZsb2F0aW5nIFBvaW50IE9wZXJhdGlvbiIsICIiLCAiIikK
IApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdGFnX3Jldl9pbmZvLmMuaW5jIGIvdGFyZ2V0
L2hleGFnb24vdGFnX3Jldl9pbmZvLmMuaW5jCmluZGV4IDQ4YmRjNTJiZmRiLi42OGJlOGNiYWZi
MiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdGFnX3Jldl9pbmZvLmMuaW5jCisrKyBiL3Rh
cmdldC9oZXhhZ29uL3RhZ19yZXZfaW5mby5jLmluYwpAQCAtNjQyLDYgKzY0Miw4IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgdGFnX3Jldl9pbmZvIHRhZ19yZXZfaW5mb1tYWF9MQVNUX09QQ09ERV0g
PSB7CiAgICAgW1MyX3N0b3JlcmlfcGlfbnRdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5
LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAogICAgIFtZMl9kY2ZldGNoYm9fbnRdID0geyAu
aW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAogICAg
IFtZMl9kY3plcm9hX250XSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y3OSwgLnJlbW92ZWQg
PSBIRVhfVkVSX05PTkUgfSwKKworICAgIFtZMl90bGJwcF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVY
X1ZFUl9WODEsIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCiB9OwogCiAjZW5kaWYgLyogSEVY
QUdPTl9UQUdfQVJDSF9UQUJMRV9IICovCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9pbXBv
cnRlZC9lbmNvZGVfcHAuZGVmIGIvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvZW5jb2RlX3BwLmRl
ZgppbmRleCBmY2E4ZjhhZWIxYS4uNGIzMDdiOTdiMzAgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL2ltcG9ydGVkL2VuY29kZV9wcC5kZWYKKysrIGIvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQv
ZW5jb2RlX3BwLmRlZgpAQCAtODkwLDYgKzg5MCw3IEBAIERFRl9FTkMzMihZMl90bGJ1bmxvY2ss
SUNMQVNTX0NSIiAxMTAwIDAwMS0tLS0tIFBQLS0tLS0tIDAxMC0tLS0tIikKIERFRl9FTkMzMihZ
Ml9rMGxvY2ssICAgSUNMQVNTX0NSIiAxMTAwIDAwMS0tLS0tIFBQLS0tLS0tIDAxMS0tLS0tIikK
IERFRl9FTkMzMihZMl9rMHVubG9jaywgSUNMQVNTX0NSIiAxMTAwIDAwMS0tLS0tIFBQLS0tLS0t
IDEwMC0tLS0tIikKIERFRl9FTkMzMihZMl90bGJwLCAgICAgSUNMQVNTX0NSIiAxMTAwIDEwMHNz
c3NzIFBQLS0tLS0tIC0tLWRkZGRkIikKK0RFRl9FTkMzMihZMl90bGJwcCwiMDExMDExMDAwMTFz
c3Nzc1BQLS0tLS0tLS0tZGRkZGQiKQogREVGX0VOQzMyKFk1X3RsYm9jLCAgICBJQ0xBU1NfQ1Ii
IDExMDAgMTExc3Nzc3MgUFAtLS0tLS0gLS0tZGRkZGQiKQogREVGX0VOQzMyKFk1X3RsYmFzaWRp
LCBJQ0xBU1NfQ1IiIDExMDAgMTAxc3Nzc3MgUFAtLS0tLS0gLS0tLS0tLS0iKQogREVGX0VOQzMy
KFkyX3RsYnIsICAgICBJQ0xBU1NfQ1IiIDExMDAgMDEwc3Nzc3MgUFAtLS0tLS0gLS0tZGRkZGQi
KQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvc3lzdGVtLmlkZWYgYi90YXJn
ZXQvaGV4YWdvbi9pbXBvcnRlZC9zeXN0ZW0uaWRlZgppbmRleCA2MTg3YWRhNWFiYi4uYTU4ZGE4
ZjgyNjkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL3N5c3RlbS5pZGVmCisr
KyBiL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL3N5c3RlbS5pZGVmCkBAIC0xMTgsNiArMTE4LDgg
QEAgUTZJTlNOKFkyX3RsYnIsIlJkZDMyPXRsYnIoUnMzMikiLCBBVFRSSUJTKEFfUFJJVixBX05P
VEVfUFJJVixBX05PVEVfTk9QQUNLRVQsQV8KIAogUTZJTlNOKFkyX3RsYnAsIlJkMzI9dGxicChS
czMyKSIsIEFUVFJJQlMoQV9QUklWLEFfTk9URV9QUklWLEFfTk9URV9OT1BBQ0tFVCxBX1JFU1RS
SUNUX05PUEFDS0VUKSwgIlByb2JlIFRMQiIsIHtSZFY9ZlRMQlAoUnNWKTt9KQogCitRNklOU04o
WTJfdGxicHAsIlJkMzI9dGxicChSc3MzMikiLCBBVFRSSUJTKEFfUFJJVixBX05PVEVfUFJJVixB
X05PVEVfTk9QQUNLRVQsQV9SRVNUUklDVF9OT1BBQ0tFVCxBX1RMQlBQX0lOU04pLCAiUHJvYmUg
VExCNjQiLCB7UmRWPWZUTEJQUChSc3NWKTt9KQorCiBRNklOU04oWTVfdGxiYXNpZGksInRsYmlu
dmFzaWQoUnMzMikiLEFUVFJJQlMoQV9QUklWLEFfTk9URV9QUklWLEFfTk9URV9OT1BBQ0tFVCxB
X1JFU1RSSUNUX05PUEFDS0VUKSwgIkludmFsaWRhdGUgQVNJRCIsCiB7CiAJZkhJREUoaW50IGk7
KQotLSAKMi4zNC4xCgo=

