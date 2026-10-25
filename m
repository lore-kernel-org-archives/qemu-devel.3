Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD62E606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZsOx9DKw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DlYa/wBT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKoqJ-0007iZ-73; Sat, 24 Oct 2026 23:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoqG-0007hy-B1
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoqE-0001TT-Np
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:16 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P16Jsh2776127
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EXMlL0CQEUWxaU5cW50xDxNN5MRk9w89xRLd3/Rde3M=; b=ZsOx9DKwbkLyHRJl
 zcKJy14wR9u9rLIlTAsEi247D4RWRm8fVZspUmEGppBsX4TrlS/0QzwAlzFyyVTw
 ykfkbDszTH8715m+KuTt9EWhb5yaX5F2XWjd9UhlPN4CA3zOkRVV8GuXapr7rTjj
 MLzKdlvO7cv7m5yNcVRF4UKyu2mIHvdnKTh79dmgQN/75rBh4+SjSw11l8bZH9Dc
 zIhhGBHVMPDrQCVihB6x04PDbw28USeOi43s6nS3B6s7Y5suf4GvJWgiUKv62i5I
 KpwFXBR8IR2Z+b6Uag/uuTUQxrTlzj0gS3hUQDgxyBib4XAUN6sDN+NkesblfsW1
 AGLk8A==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm0gje06-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:13 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-186c1aae818so7068634c88.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898653; x=1793503453; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EXMlL0CQEUWxaU5cW50xDxNN5MRk9w89xRLd3/Rde3M=;
 b=DlYa/wBTM8hbKC8IMQ5Rl+dgrGjHYAXy5KVEhY2CrvfcSlsR5SY+pEvJZXVvq169js
 XyMHopRjJXk1bgobkDMD6MBFSgqvIt1FCrO6LD0v5c6yvUGNN6en4/EGRIM6RN40whPm
 uIMTwumj26pJiy8hB/AQvi6eWKpKUvihhge5wrgIB/ejafvsFEYXkV9nt3Fma0K4I4Pt
 vqtESFvRxSAKVIpO3kC1ftxBk2nFm5d7XXuXc6tDxQ3zsbwTiBuowXWq8vHchxC9kj9k
 A7kSnCc0At/8witbt0ssNFRL3ZeTVhFtI1F1dRov4ktdtWTdYgowbCx190xBjlnh+GJw
 O9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898653; x=1793503453;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EXMlL0CQEUWxaU5cW50xDxNN5MRk9w89xRLd3/Rde3M=;
 b=lblpvtS4i4F9PF2fZ8M+Du3o7Y8ccuJn9q+zhvesmrk87sJj5bhF88zMI70EiXPkAR
 WN81j0yuG9895abkXo9yWfvPTUdmshLESXrfLuyAc31Mvu+D/wNK5+sRYb8Ai83FBs1Z
 mGwZ/OI0b8nYgDX7+EI30ojX8WWEdfpBx+NMNpvWOg7wl9UiVpqjMNYIhc4qIoXnEei7
 aq+v+0MUt4p+qjwEAOjDuPWx402EbnENssZTBPysH92c/t7YzvQpsrVz7+0QmkF9cyix
 41ZxFsra4L/SKVXxbppG+BLXu1xprb4+dYXY5WDwyvA1SNhFUBwjpR9i94w4Lu5zQ5+T
 lbDA==
X-Gm-Message-State: AFq9FYLQ1uG8VfHodzUeULEw0bC46kDE2F1RHKYaHuov/Hwnyy4HvIB2
 yWIZrGMz7cIgHOsfYj12aP08VzRgjemqqf7j+hiOiHlzUJJGiqO8ZM4GY0rmdNNvIqLcc+SY4G/
 gdfuAO/Y9xYaFpgh8yyyhMVlqn1fIpoY+MKidl1d8Ei1P5qMZCa27mkN7yf2LLy9s8g==
X-Gm-Gg: AYBFou20+PL5Q5I3MakU+o6GbqpKazO1Xa4Wa0/hC1pfEUhum5tf03y4Q//7k6EJJ1n
 DIDpCQstfrMgFrl256PK8HGsWDJbShICCe2MYUgVThmzCy67wcgrSfZAxsUHAn2kLe8JITXlf+s
 etP2prSMF74Grmn3knU/0hQO4qsn4AHTTfOK6u3Z93rg8hMNsE65JeULFKYY17K8Ew8xuolNchp
 W94PP/uSmk57P1w/m0+Ehlh/hsaOEf0L9HboE4FGUYArJB4DWEO/iKbFIDuLpTswtJksELHHxJI
 TXe1dGopl3dwM8YlKGsk9G9NSYJi/1/0pkDY2md1C9oUa5iZhrEcgATyyVY11slIbKuSKmFHB9n
 SqLjr0r53B1woVWcW0hOqw6wxVoLBrTXPBZ5I9CFqqNDr6wE=
X-Received: by 2002:a05:7022:f514:b0:196:e2d0:129 with SMTP id
 a92af1059eb24-19929f6dab3mr3897243c88.2.1792898652796; 
 Sat, 24 Oct 2026 20:24:12 -0700 (PDT)
X-Received: by 2002:a05:7022:f514:b0:196:e2d0:129 with SMTP id
 a92af1059eb24-19929f6dab3mr3897215c88.2.1792898652207; 
 Sat, 24 Oct 2026 20:24:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:24:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PULL v2 11/40] target/hexagon: preserve callr target when Rs is LR
Date: Sat, 24 Oct 2026 20:23:17 -0700
Message-Id: <20261025032346.2917451-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: EGXvr5ml617J46ATgKRB1B2YXFKpMV4-
X-Authority-Analysis: v=2.4 cv=UfTE26SN c=1 sm=1 tr=0 ts=6add765d cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Ml5uk3Oo-jtE3ATjI50A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: EGXvr5ml617J46ATgKRB1B2YXFKpMV4-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX4G76Ls2Hf0Km
 E2tWY9A4moVMF02et5TJULuqn47Nfw1PU1HJFl0ubzS4YONlCHPW5MVGlf88OVcRwFJpUzs8qFV
 bvaz62VIGafpwwqFgkUjvVbFZ8hxF3x/dRKVlLeRRd2t8VW/qOFvdZON8uCkKkYC6znsQjXG0yA
 4U5mUWKu9dwRHa+LdviWN2CfHw8K4v5iyDgKA7OCZMeC2uqn6S7POUCuQdlMUCfOI7icaPc/nKH
 87F/eDlpBKnk3aV/yVedlO7BaIFqvh/8s1BarUs+znS+/MN5UtMbBwZtprtVjKsorzZJXYNzPh/
 NfQYs4gnXpS1+Owi8cqAsiAs3HPbHjYo/7sPHiqpEDEWskkMKNVj0VEkk62jueoTrWY8KjuVTxl
 2tiCEjC981Nrdc+er8wHuYX5saRLEz+78+bWSlge+G3Y0Rhc68Jn+nsVGur2vI71tRbvoQjeRDd
 TtHZm0H+IOatzi19JLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX8Jt4vRmkjwMU
 56WQTPV4W8WI4C+HWl+FO3+xklT09uQHaCQBQ/5w28XX9q+psldFlo8kjTTBOqu4W6N0ijHk9el
 MQ3d5OvwqzZmXohgE8zB6rS1BOQonyk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610250012
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

