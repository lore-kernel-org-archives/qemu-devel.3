Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E7A606B7FF
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kXvjEsym;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TIez/ReK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJxbO-0006Rz-L7; Thu, 22 Oct 2026 14:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJxa6-0006Bn-Lf
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 14:32:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJxa3-0002dj-Nu
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 14:32:01 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtVuE3078081
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=; b=kXvjEsymVXXcWbYx
 Wmhp8yf59CrJ8LiVlPolCl/nqcl3FuU1rfZTfO53/98lyxVSLSYEocX4N/LTXT6m
 2KOJIVOBS0yp4JAyyeXM47Hw1RvPnue6Eju8eiqFkyzwXoeojhEVWvWf6Dsmxo2L
 euATxO36v7hyf+NzmINl153yBy8qp8uoClb9cArhUo5PBOqNTtQaDab5HPhA2L9d
 DGAWXot31DJPtdQtdChcmQDhvJaMV2tm+eEl9pmJvafexFJburXg5KyoS5B/a15E
 6mc7oJZOICF/blrA4U8IikuFUiwNRfoQS3jtQz+hACUJ6IRTAA3GoMAojKHQVarr
 Wqe6Lw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93amyy4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:31:58 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso132209eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 11:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792693917; x=1793298717; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=;
 b=TIez/ReKnxCmYF8wA69c+USTWOTy3zqggRonHEzs5xBLXApRz0z4CLuvFW+hV21xQp
 Tt1q0tmP8iioJNZl+wYS51S23POqyJaRLMgMoeG7cdSGpoaCre1YSzJdFaT/dr+FxQw5
 cdXPSY5alz96ghtkidbbVoqbXhwfdH9C+MUsR9Q5zizCFfW45H2gyv+JyDEnSbqKfUqw
 3aKSOKL25d+7HMgLK3+B+ee6mZgMLBxgEFkIuU5zZLlIdWXaBgNY54VVwkySC2UHJGP6
 fuxxcTgVqN9NR/Egc/ly7xonUHF1qWPUJDTmshzF9ozHinQ0+WfjC6v6i5Sp9513Jr/m
 vW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792693917; x=1793298717;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=;
 b=ycAnhM0Su0ishzOOMgIHg8loPsIScBKB3ZO7flzN+SdAtkIR3qjcI0DfySbmSRpJk1
 E0aoYnAXkkSs2nrQRUHeUuM2kRwntTfW6m1hIQq3mrBVogOs+2RDxxpJC9UReSQgYS4M
 ylrEO+os0md9eNGVudhFguZK9GQ5Zm9376ZCjTkSIIUjkx7JIta58+YlJ5wR313yYwFH
 qk7H7jTow42MBhX/dGl9ctEpreRJTE02yxXZgfh9XoaNNkOy9RmCTac5TDSiiuSqWYQ8
 SJA+hq13lNHDxZN7PDVZS/fHb+rjLkKH8zVXfbzMk3U6JqY/pafLsUI97/DBAAbWQMwP
 S95w==
X-Gm-Message-State: AFq9FYLvO6ZDjuVHzMYaaoQKb0GvFNUUoGOlHu9gsGSazJMAfTbF4nK5
 Gp9s0sPLZ2F5LUz5q8rw37dBJCWZ79MGqOULahf8uThiM/MkMicN0U5SSx4AD7Hk6shIpv742Wo
 N0J4eRFIKhtIqKU6Bav/9Eur0QDJkM/Kv1A7+OhzaE1Twq+iU4pNkYIjCPpMs6fDdkg==
X-Gm-Gg: AYBFou2juoqfShx4WcVPKMeKt6EklVyEP3zj3VijzdxhcCHgJpxwN1RdZk3sfJsj5Je
 I0U77UvRdYwJ7EVoQ+xvRD3/Bbl5Nhi+WG8VGWrsoJ7JOEEZ63vzMoLUAe+s4hbZub7KrpHFJ3r
 qfDD2gKgMefqwV64AA7a/1KOqDrRrNqNzWbLpeKkDGfw6C6nEmzhmiC41BsnABJgiIBXTuLTJA4
 PlG6bV/a/W45Yc/fSz6IzyiwAk3GwYo+oPmqupIXyg+N1lvYAL6axLxCsjJghC3z6wxggbq2Exp
 dEV/ZpXsOkOZwGbavayCycI8s7HaW9k1qKDVbTlMNIdXCfMPoYu6QnLCb0xwVPIa5MgOajgQVhB
 q871KKJUXtMIBYevJlDjkbcvEqYNVMasCjGSIrYcsArsLkJzU
X-Received: by 2002:a05:7301:6189:20b0:34c:d1f2:b552 with SMTP id
 5a478bee46e88-369d90e3513mr5776eec.4.1792693917489; 
 Thu, 22 Oct 2026 11:31:57 -0700 (PDT)
X-Received: by 2002:a05:7301:6189:20b0:34c:d1f2:b552 with SMTP id
 5a478bee46e88-369d90e3513mr5745eec.4.1792693916945; 
 Thu, 22 Oct 2026 11:31:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d8f8eaf9sm44962eec.16.2026.10.22.11.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 11:31:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v4 04/11] linux-user/hexagon: report ISA HWCAP through v85
Date: Thu, 22 Oct 2026 11:31:40 -0700
Message-Id: <20261022183147.1535585-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022183147.1535585-1-brian.cain@oss.qualcomm.com>
References: <20261022183147.1535585-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3MyBTYWx0ZWRfXxKa2tz63KJtR
 cJ9TP/tBw0u2r+QSjaosnj2ehiZ2jmcRQNKna5HflxTfdyz4g1m5XNOjqM/PvvgIHrlNYb4ORnX
 8JdjX3dwEHZWZeN8wGXdERwKoo8OQ/jJsETogrNCma3n+0wsu/wClt4O6pvipMcGHjyKoHpCrOL
 vLjDl+xJcV58Q58N55yaHYRuDzxjf1vVrUpNy8bAk+qDb6I79bgyF0uxouDlTtX2TpIstzgrsHa
 SoVxf+Xu9npROLmJn0oykCDEUnCvqYePi9pBJq9xJqz7zpLmaub5SRTuUNPP5wvx46YRTBVWGb4
 Ww5Agg+6AQ6MFmvGazNNiiyO9SFlOvPV95UrphDm1yeIYpg+pT04sz1Po+OfA4R90JRZhB/+799
 z2uQw5bCTQqBrEY6aCVTeYA68S0AD2stwksFtH3tZZAuFgWFcShrbMKUHkz4985M5lvp1/r1yVs
 OtsKFPUh2OihD9quuXQ==
X-Proofpoint-GUID: xYrPmADEFYGLZt67zCVV5Rz4LtduQzGW
X-Authority-Analysis: v=2.4 cv=feg4WEQF c=1 sm=1 tr=0 ts=6ada569e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=RcCyqxnK1iORyYYg75cA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: xYrPmADEFYGLZt67zCVV5Rz4LtduQzGW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3MyBTYWx0ZWRfXw/jcNYM285/Q
 CWeyn6VZQm2LHgeJMBsSTWf4O3hXo3NhI+TyB1GXjeaOrpMq9EQ02qIdoy/GcIVEnDsyKfZVT7j
 KKok4viehJMZmncyyBJMpxpgkEsmuuk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220073
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFs
Y29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiBsaW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oIHwgMiArKwogbGlu
dXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyAgICB8IDYgKysrKysrCiAyIGZpbGVzIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvaGV4YWdvbi90YXJnZXRf
ZWxmLmggYi9saW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oCmluZGV4IDkwZTUwMzJkNWFh
Li5iMWViNWVhNTAzNyAxMDA2NDQKLS0tIGEvbGludXgtdXNlci9oZXhhZ29uL3RhcmdldF9lbGYu
aAorKysgYi9saW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oCkBAIC00Myw2ICs0Myw4IEBA
IGVudW0gewogICAgIEhXQ0FQX0hFWEFHT05fSVNBX1Y3NyAgICAgICAgICAgPSAxNiwKICAgICBI
V0NBUF9IRVhBR09OX0lTQV9WNzkgICAgICAgICAgID0gMTcsCiAgICAgSFdDQVBfSEVYQUdPTl9J
U0FfVjgxICAgICAgICAgICA9IDE4LAorICAgIEhXQ0FQX0hFWEFHT05fSVNBX1Y4MyAgICAgICAg
ICAgPSAxOSwKKyAgICBIV0NBUF9IRVhBR09OX0lTQV9WODUgICAgICAgICAgID0gMjAsCiAgICAg
SFdDQVBfSEVYQUdPTl9IVlggICAgICAgICAgICAgICA9IDEgPDwgNywKICAgICBIV0NBUF9IRVhB
R09OX0NBQkFDICAgICAgICAgICAgID0gMSA8PCA4LAogICAgIEhXQ0FQX0hFWEFHT05fSFZYX0xF
TkdUSF8xMjhCICAgPSAxIDw8IDksCmRpZmYgLS1naXQgYS9saW51eC11c2VyL2hleGFnb24vZWxm
bG9hZC5jIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwppbmRleCA5Zjk4YWQ4ZmI4Ni4u
ZGIwYmYyOTljYzAgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMKKysr
IGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpAQCAtNjIsNiArNjIsMTIgQEAgYWJpX3Vs
b25nIGdldF9lbGZfaHdjYXAoQ1BVU3RhdGUgKmNzKQogICAgIGNhc2UgSEVYX1ZFUl9WODE6CiAg
ICAgICAgIGh3Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNBX1Y4MTsKICAgICAgICAgYnJlYWs7Cisg
ICAgY2FzZSBIRVhfVkVSX1Y4MzoKKyAgICAgICAgaHdjYXBzID0gSFdDQVBfSEVYQUdPTl9JU0Ff
VjgzOworICAgICAgICBicmVhazsKKyAgICBjYXNlIEhFWF9WRVJfVjg1OgorICAgICAgICBod2Nh
cHMgPSBIV0NBUF9IRVhBR09OX0lTQV9WODU7CisgICAgICAgIGJyZWFrOwogICAgIGRlZmF1bHQ6
CiAgICAgICAgIHJldHVybiAwOwogICAgIH0KLS0gCjIuMzQuMQoK

