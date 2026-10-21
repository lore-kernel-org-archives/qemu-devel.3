Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE65606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RbNiq2+D;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IAQVk5K+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJf3I-00014L-Eb; Wed, 21 Oct 2026 18:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJf34-00010J-Uy
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 18:44:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJf32-0002ZP-KO
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 18:44:41 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKeNlw1154640
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 22:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EXMlL0CQEUWxaU5cW50xDxNN5MRk9w89xRLd3/Rde3M=; b=RbNiq2+D2IopP+h2
 bzCwRCpqc8h+FDYQ3Pc7vhR2E6iLhI/H9k3Ae+cZm9hOsfO+04yN5aEDk43ZdG7D
 kX12vCvfRzG+DvjPrCJiJ55rKUFg8oSfKan3VEIKqrhXVQTN3YjLGOopFLmWgA0h
 INRnc+4U4+bvYobxO1kpvKXF9WEtcV2kEzqMQ8JwRz/DVw3/1Ff3eN209CmZv1LD
 UXCBE8Dpy/+LNVaVHCBqBvryRbVCMnSU/QyS5VzZf5E6RdDrO5Fw7Kscwz7HLjCv
 nMiqaK4pJL24UllIF/YqDZM78kRTaG5n7Uy6QHo4MRT4PytFu8LCp5iYVWvHRHKL
 PHK6zQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0cv1g16-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 22:44:39 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35cbea41088so2207073eec.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 15:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792622679; x=1793227479; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EXMlL0CQEUWxaU5cW50xDxNN5MRk9w89xRLd3/Rde3M=;
 b=IAQVk5K+wAJ+djRsILQZHmAo3Nf4l6FiQSQB5aMoVPhdh/E0aNfuAm6+3FrN0Tb6Pl
 FX2Vfrmuyj3ACVwgSXmgmKminyURHIertDK2qqA2PBGcFPGV5S+jXIeVqQV3ZW7U0YFU
 jxDKdKLNfomP3FixyRnGMQlm5C/WMFcGrTWoXRcR/MYX2R7c/ycOUiglDs1/HuSRYYpY
 kj9V75u7NULNeKAr21oRyROwIw/fVNgSJFWHSiUmMOZRuexGHN7fa7P5en3KCIVwC+ZL
 +XAG5oCgYPwOSqbRlPsSImUoB522ul20EOfXPdGVK+kYMAAItnTlRaCUTyFkA+3PG2hz
 bk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792622679; x=1793227479;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EXMlL0CQEUWxaU5cW50xDxNN5MRk9w89xRLd3/Rde3M=;
 b=lW0TSKDtVDxGhdCEuyO77DEkyOIoR4T+Dzq/Yq+TNk8l3pmz/RoKmdylEFy+rnhZSe
 NKbiQB1mO6gp+6kjH9R5bAMTEe15s+hi2ChsYDLiJiA6CFNK+CNiifqgPmRL0TPbKB3O
 MD1PiGiv2ntL/Jz0X3wY7mAkt6rv7ozfpL0noE0kWMl3KncTIGpRf8PTqK/fRODwdBqX
 EaGgZPQMPRITNHylw7xeEkkLqwKXykwKE6kz9qG/mXUqgHfmtSv0NviimYuOi24aTfpt
 2eo6rmKl2s+XyYBHP6eaEKN4Nbg7T3ZUWjLbRvBstzoGyZonKXSGYOOowkMunFvef7sj
 kzbA==
X-Gm-Message-State: AFq9FYKaeuVKAShxCGM/7GQyLO/VtVH6q/+sdvwdpw2nJOJLKQVOogE6
 OCfp8sG20LOv7J2JmlvyZ1nL78osSX0SMGBUTSMw0Vs9Eq5Tb9ggTmRRQBg1Pk0x8NbKL6WVT1r
 hJ2J54VAsw9m/Fp6eyUMo2tVbuSuhNawaYIF3/SAhKbXm3041mg1uzAprpGeT6Ypf+A==
X-Gm-Gg: AYBFou3BVeePDjkpbQDp/S3jH9I1uXozZe291JCUJpmqJpLtbwcCSJPtZ/XeWqPbPGc
 Fp86YUw8fLxH4guG1RDp6CCMP6ohBsm2iuY/x+WhR/NissYl3c4RLVNC9qdk6af8CvNNd5QFLkS
 sRpzcq7sZ+pIckvjTXOQCkFzZynUOssL/kAdDqPSc2eHzjGRuTV2sTcYHGSGtsO1aqyOMgglyGL
 0hib9Kyq3ChgFhq707/GFEbJkuzoUi0+bs8XJb/YkUu+YoPAUTSewHSRqvMjILTtWe09baY9AmE
 UcgXE4W4MRCHCE55Ueo4oPaSQ+nLFUueRxYXLcK0wleD9OPJxpbqqgduAyJNByTsjRloxogJFP6
 L6wtCfqsRB5+E/H8BDba2yYqIsUycnAQ3s6h1LHRcoJJDJLNn
X-Received: by 2002:a05:693c:41d6:20b0:35a:5153:ab24 with SMTP id
 5a478bee46e88-3674c63d562mr4599897eec.9.1792622678369; 
 Wed, 21 Oct 2026 15:44:38 -0700 (PDT)
X-Received: by 2002:a05:693c:41d6:20b0:35a:5153:ab24 with SMTP id
 5a478bee46e88-3674c63d562mr4599868eec.9.1792622677816; 
 Wed, 21 Oct 2026 15:44:37 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ee5eesm9462858eec.8.2026.10.21.15.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 15:44:36 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alessandro Di Federico <ale@rev.ng>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v3 08/11] target/hexagon: preserve callr target when Rs is LR
Date: Wed, 21 Oct 2026 15:44:18 -0700
Message-Id: <20261021224421.3786109-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021224421.3786109-1-brian.cain@oss.qualcomm.com>
References: <20261021224421.3786109-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=NrRE4MdJ c=1 sm=1 tr=0 ts=6ad94057 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Ml5uk3Oo-jtE3ATjI50A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 6Pfny_-EJwmPyJ-VRhDsWuBi3WRXPul2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MCBTYWx0ZWRfX9QDfxtYimRJB
 XuxaUyw/NWsmk+eVw6oxOt9PM6hD6pcpBvGMPCzrG9KBIi3xePNuB0Mw3B/RG+Yf3sONn4latzV
 qeJk7frXveTD2naQBZTdIy1YoRn8XG8=
X-Proofpoint-GUID: 6Pfny_-EJwmPyJ-VRhDsWuBi3WRXPul2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MCBTYWx0ZWRfX0j9vNSONh15L
 RBRE72nBCI9qMlZ1qpWXyxwAOYtaBvcwPSU9IJMcmPN9q22uNu4H9L3rBjEmYN40W/9JE+xi1hO
 Dil1lB09GDs81tSRruzEjWB/pS/hdi+391FPBBAd7ig9nNKwfNFxibCfHcKK/ZoHAILBHARfRtw
 2c+KGWv+2rY5uf5edk2+bSDfInlNpLbZIFlBM8PX/E9tgLrR+QitWshiG6OemN5L9eRkbEYK65z
 o6DM5yIYLlo/9mOcMZwSq4KGMHbtF5hN/ineRMoXvNANrmIxT3B4bRCDqWWqST6Yhb2baWNUqr5
 2EBSUdkKiccYPmdXSMuu1D5ukF88oN2VgL9yXIRxw8R9E6ZbCCwY37VgBxG2XmlTHuw2nryfQzn
 6750+bjp/jWMo/lD+2BC16jQstcSLHu+8Fnhx+vPumB68jWg90DKaf6N8jeq4RtJ/kQG1EJH9L3
 KpnB3InpkQ9jGaHq2IA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210090
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

Z2VuX2NhbGxyIHdyb3RlIHRoZSBsaW5rIHJlZ2lzdGVyIGJlZm9yZSBjb25zdW1pbmcgdGhlIHRh
cmdldCwgc28KImNhbGxyIHIzMSIganVtcGVkIHRvIHRoZSBuZXcgcmV0dXJuIGFkZHJlc3MgaW5z
dGVhZCBvZiB0aGUgb2xkIExSCnZhbHVlLiAgQ29weSB0aGUgdGFyZ2V0IHRvIGEgdGVtcG9yYXJ5
IGZpcnN0LgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJA
b3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVs
QG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5A
b3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyB8IDIgKysKIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9nZW5wdHIuYyBiL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jCmluZGV4IGQyMzRmOTk0ZjQ2Li5m
MWQwNTI5ZDBjOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vZ2VucHRyLmMKQEAgLTEwNTksNiArMTA1OSw4IEBAIHN0YXRpYyB2b2lkIGdl
bl9jYWxsKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcGNfb2ZmKQogc3RhdGljIHZvaWQgZ2VuX2Nh
bGxyKERpc2FzQ29udGV4dCAqY3R4LCBUQ0d2IG5ld19wYykKIHsKICAgICBUQ0d2IGxyID0gZ2V0
X3Jlc3VsdF9ncHIoY3R4LCBIRVhfUkVHX0xSKTsKKworICAgIG5ld19wYyA9IGdlbl91bmFsaWFz
X2dwcl9zcmMobmV3X3BjLCBscik7CiAgICAgdGNnX2dlbl9tb3ZpX3RsKGxyLCBjdHgtPm5leHRf
UEMpOwogICAgIGdlbl93cml0ZV9uZXdfcGNfYWRkcihjdHgsIG5ld19wYywgVENHX0NPTkRfQUxX
QVlTLCBOVUxMKTsKIH0KLS0gCjIuMzQuMQoK

