Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1588606A938
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dZu73PnS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XqwP+stq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJxc6-00079c-JZ; Thu, 22 Oct 2026 14:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJxaD-0006CB-Rf
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 14:32:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJxaB-0002es-FA
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 14:32:08 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHM0M3741970
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EXMlL0CQEUWxaU5cW50xDxNN5MRk9w89xRLd3/Rde3M=; b=dZu73PnSigpG8Gn5
 lghrKRmZawthZ8AhCzlZQCIEx2lip+Ix8q8LEaYcbTW4p3Pg9ZRsnm5BHskx/L1H
 vlZfkiBlL4mSBBTrqkI3Ku/LCDUdjbhDEzRSmq2vcIyIeEoY/XDlCQ5fhO2GP9gm
 FE5Obn6FhntTzmhRqY8RKbLWdwUzb8loJEAC3jdOG95thkmWyWGMyE+76SpghmMH
 +NtXziZ9dPXzVUQCebLxu6SQcovBtb7AFcHei8ZB2bz3lCj4JjXcxADvPdK69h25
 /ZGRo9uowP6bruQ9KTqifkFXsUTiYfMFUi6n/2VVstypn8ahJaWR4SDDByYDGLs4
 LQ25mQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms01vd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:32:05 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510d0baf63so228140eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 11:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792693925; x=1793298725; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EXMlL0CQEUWxaU5cW50xDxNN5MRk9w89xRLd3/Rde3M=;
 b=XqwP+stqQdKrvqSgq4NQnx/LKgHtw8z8ULdJnXCEijskBIcOwkwpc6keHJ1ZKvP+sN
 nLipzDe24FxAr4xFGKlEaCxzdNXRsTto3imjZnip6ecVOuV9vJSb0dCvb1YoyvTmkkS0
 rr4rxhn3RdLX1WFo3/NJBQQKK0UCGwQsLyvpwre9rwA284wDVYJhya4pPpXAyFESXNKv
 T5271yS2OIayBSRigOrEN4PKSK23D5nxjtTQWjpCbGLclkeRFyOssu0Zn2r/C5iF7UvD
 SrngDVCT4WCwiNzEj/6CAhUmOjVVwHQLRnyGH0li4PdG3Yyb08wBE1LPsQVFMIxJRE80
 ++Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792693925; x=1793298725;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EXMlL0CQEUWxaU5cW50xDxNN5MRk9w89xRLd3/Rde3M=;
 b=Rg9aTGhi2kv5SmhomLgAPe9AOPgufE89mnlFCceLFjZQ3/OvG/DTi9MjCFVHiAAEAZ
 CwtfiieIXegQU3eLJKhrOeF6REqFGsY/IDyCy7x6pHW/Br7lVSkE1v3Jc4ZNPkMQZa8Y
 xxhZ0YpwRSXMz+iKmd6SqHscTv5nlRgkAt/qis/l/eTUpeKKr10qRGqVVhC6P+ytsFlu
 tVI/BsaSQu60Fu+HdW8YhhXgUWN6iTmkhEbnbEljnxq15RNtbR6sRrH8ZybJpquHr33R
 kGYlsFeTpwQYUOcRVDap//qUonvaV0wo+rCkPQv309aVT94d57kPQHIl9NAkbS65WC3Z
 Jp4Q==
X-Gm-Message-State: AFq9FYJjIL2IVFI9qHO9n3/F+9qRvnNB0qjuWIvnufv/GKO3mRrQibHA
 EZImacUugzX57j2WPCfzIgMZka01wxhAN26UJxDgln38WBYeOHtHvynTAy9pvZK4APvFoFtmVSz
 jkvljz/osAkIw8a8GyAQZnnzN83bZ0k839gSwaZ30au6DDjVMcNF0H5c80KSmA5+5Iw==
X-Gm-Gg: AYBFou2RnVlBP6SITv2JTi82CFS0MxDvBqjioMPQQZ/Qp6me5uSjaASDEL+E2OdSXCr
 uoONeZdYNXeyR5Zj4gxiIWl9EWDdjM6F4r6ijyXcnxwFhoyChGagGPg2APARWEjqZAH6fclrHQh
 ypirjkpUWl+7FUUiAor16mnmvRY3vRz8+aLFIbNP6LAOBAjkr2EL+L/rqGl04164K4lMJyIxwO7
 ww7VYQSb7Kp/LjiFYZDYXZ0rfTOBO6nga1vmcequGoRZ5nv5VOyKqC3SYbv07ZJD4oPBQkkrQv+
 Esdh3IdiulK4xNICJ4GOWXEFlCc2lCNq/SUZFEvQfJmWJG1dtcwJUFtmW4DqoQ4LLSUUJBFg8xm
 pCeqITKXQUPoFZN4D/JEELMz/wrUEMwBdpd80s1DbJokgsEDG
X-Received: by 2002:a05:7300:ce89:b0:369:987f:d15e with SMTP id
 5a478bee46e88-369d916df6cmr357eec.2.1792693924965; 
 Thu, 22 Oct 2026 11:32:04 -0700 (PDT)
X-Received: by 2002:a05:7300:ce89:b0:369:987f:d15e with SMTP id
 5a478bee46e88-369d916df6cmr330eec.2.1792693924314; 
 Thu, 22 Oct 2026 11:32:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d8f8eaf9sm44962eec.16.2026.10.22.11.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 11:32:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v4 08/11] target/hexagon: preserve callr target when Rs is LR
Date: Thu, 22 Oct 2026 11:31:44 -0700
Message-Id: <20261022183147.1535585-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022183147.1535585-1-brian.cain@oss.qualcomm.com>
References: <20261022183147.1535585-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3MyBTYWx0ZWRfXzHP00JBXJ5qw
 pWIFmr0+UMimGVvQWZE2jtrSC6OfJVVNuBqttaW1sumQO9yM9smlNNvVscUz4mhHuJHqYWcAUz3
 HeYPA1R7H0njAo8Qm/1d/uqZ9x2bnVqJYPvgiNwQplkB7TS0Zzmw7Nd/SXNGKv/98TYV1TuYZ7I
 kxR5rWNu0I0OZYM3PbCw9zh1omu932JnhTkHa+lyhdOtRxJ2EoeVFf40c58YFm7hoqvzHGoYpOK
 ih2kAmG5IImCxM7xbSL2z1FWE4KWUxXuNIDreHTl81xPbdZMfFPPiTYkYbojj/Qp5r7ciT1Pj4O
 tU+jyjvKojenWmMoa8rVLG9zgIv8iA1K5GfXK3q6dDMqCh8j6sXH1Xkjf3cLbbQccHBgCnmAZTq
 qKvTKPFJxsQPCua9gj16+VE5g3RUUpfY6wdhRMF54E9Hs4S7V9MkgdiQo9R0heoKa3IJ1DdqXh0
 gKDxnEWRFACeyWZp57A==
X-Proofpoint-GUID: kxrVWmJ1hfWOvAJepg6Wt2n7zadvtr-I
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3MyBTYWx0ZWRfX4BYqCM/QRAbu
 2JqYMP9/0eChuAw0X0YX/+CeBIdj/6xeSytMs47S4ihuZXvY5X9phvDI1vw0uqK+Cwa+msNcgCw
 ptQXAM3Yifv2gwiGG4xrCbhfqSLtH5I=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada56a5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Ml5uk3Oo-jtE3ATjI50A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: kxrVWmJ1hfWOvAJepg6Wt2n7zadvtr-I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220073
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

