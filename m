Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F4D606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yda/PteC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bx5x87lR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4Sp-0005id-Hy; Thu, 22 Oct 2026 21:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4RM-0001l3-62
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4RK-0006KZ-9t
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:27 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1ErvY2376056
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1tvJx4Gi2s99eA+sQCfV1Wz9PB560tGbzaE1xKyRfpU=; b=Yda/PteCkeBVeWix
 Bih75hnusaR78IOZyv3Ww/qhPBex29N04MAoE6bMgHUYxaYQP9+53yC/J9N3IS1m
 Q1G41TCpn8URzy1XgfO2Dyzvm6P/Yxawl4X3SgaNduupEdaa3zLw453J8FARyH9K
 h/AXN/T1dwiZyTQWaV2TMTPoNgxol6C2i34ECFZEWAI/6topCzDh5aR2DX2mZJjB
 imdW5gbnUKOAMNyapv+qzBbdr8HRmHCaYt/jXNBvOy11NnPSqByckKmoBQVonwPu
 3G4vKzU0fcdtjWe3YXMyc8/I060O/nYYUmFvvFOlF4KksWwEeKATikpVgqnFltlF
 QN7vtg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmr9btf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:14 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so549796eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720274; x=1793325074; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1tvJx4Gi2s99eA+sQCfV1Wz9PB560tGbzaE1xKyRfpU=;
 b=bx5x87lRS6n8wbeopS3/tC42Wi6Q3QigM+k8XNGAnbP/TJeGwhc3WMP3YLglAAcVVG
 G2xpdpgsqwM4bAjuNS5vvUWf+d52RbMBTRKgckyuS9IT44ubdWtZ3TXwN5QYOlKeWWuu
 //+zcJnHVkCTq1Eov/NT6zpQ2hdAf1glK6Iui+L5yzr7wSblIxxkLgqBxuJHldi0R2BT
 ZnR6QfVWR3YofNfNl6U42sNGW57BBH2yc/0boe9fuXOzMHLgX/vlG8gR3D2VnwDninYy
 sjDGKTLo/iBY1ud2UpxuEAxCDQSzM3kylUT1NuIpNgTAtJC8tSk1k3iMkHUhYXymn8P1
 mmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720274; x=1793325074;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1tvJx4Gi2s99eA+sQCfV1Wz9PB560tGbzaE1xKyRfpU=;
 b=V0cKbRgUqYRI+Gjjek0cRCymOn2lYgPOXWnoiISKeTMNCP079IdzVm/pXDeBom+USm
 n38Q2Q97rA0xPCaPMdn2OwYHFtG085kNN/LbZJG0Ztmm1Hr3hP1SuXefQByawqvamFEp
 6ZappKeZzZypLUrx9Uke1PMar75Xv6dMooUOH3+YqDS1Ez1s8gSCpCY7Jk8s73Rec28G
 BhjDho5b0FOSVPD6eIJ+/z4+Id3vN0SVliYzIXDAQMlMti3Y7LI4+D/ZdVWSqON4u17P
 xh+ti6nwOnRQVGYR8vJjaGdcOdDhLyiKcAoIomEQSf62iPSEdYBPyk+8cUWTVKfmd6Ns
 dimA==
X-Gm-Message-State: AFq9FYIzSmZqd7Hoq3JymHkMqBxjv2yK45UomTqj36I5s+OzhKWGlo7b
 GwjPb6jeXO5L5oHbT2uHfpP74PF+Tmmt2StwXrlGDWLxJC6Q0YP11QAvEzsvS8FCnz2lZpr3kl4
 uMMRFf4MqgWVVxqnDYJxuBc1s7H2qCMx75IZtPWePWVcmYPcrRBn/GgpnG4mCnD4LkA==
X-Gm-Gg: AYBFou3heqn6wfyYjYgvsIAI1DCdABFbk7TnPllRJAfES8Ugu4PIlF1REMAvf2BLpcY
 xelHR7gC3zrvcx8rXngthj/cIhqKpt81URcZMxk0xvZD3iMNhoj0Fc+XboiJ4G/vfLoT9OAqMjp
 NrQEDypdwB5mS1/41aZM39jK58ZxeE5Srvg+4KopzaB46qo7VbOgdMqAOYGFtsQ5+z3Yl+OiqG9
 znQX9XF1n7RrJ42VEQdEB2MWalySYlt/JsD47E+qVZdPWkdh8pdWDdYw67t2MqusLKtJHoUTUko
 g1wDckJsN5yWJBRfQDwPDLAUkr3R0oRcDzEIBM4viog+LqR73uOHVEFdcg8ggrkMkfztYMuiu0f
 +bs8Wd5ae3oYctNKFmXIq5OpD6tU6ERkMoPFpsusQGxSNdKku
X-Received: by 2002:a05:7300:c00e:20b0:35e:c56b:fd73 with SMTP id
 5a478bee46e88-369d98e4cb8mr1159731eec.38.1792720274106; 
 Thu, 22 Oct 2026 18:51:14 -0700 (PDT)
X-Received: by 2002:a05:7300:c00e:20b0:35e:c56b:fd73 with SMTP id
 5a478bee46e88-369d98e4cb8mr1159706eec.38.1792720273524; 
 Thu, 22 Oct 2026 18:51:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:51:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 18/43] target/hexagon: fix semihosting STAT filename handling
Date: Thu, 22 Oct 2026 18:50:15 -0700
Message-Id: <20261023015040.2473105-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: XICdhMQAl_Bp9U7W7OOLcfxPK-AP4Mbt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX5BfBSh0agyY8
 KrkY11qnm9RDV3CCTJClD1QNmijB/2vZXOTnpw3wjhAuyzK8bAYTLFqhlgYTMqvTZQG6Av51Pll
 LszjeiQ/SRFmZoTW9hz2jZe0cyvxams=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adabd92 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=vW8nx58EJidmct_-KksA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfXyIYjML4lq/18
 HFg3pc8l1wGPJNWhjyNedOsYVt5/keia0rB+jbgaPi7Up3ek5ARemuJr/7Ldc7KA4kP0OrFfBUk
 FerNcv25hTIJRJSqQTGH1+4NxIcMesBdly8w9kltAf2nUtRP95xadxgfGxAR6KzuzU0WeZGTm/i
 prkcOthICpKzl5l/peEN714xcyEWQZyeVflYt97Lp/jca7wHhIidB3cUJcWxs5CErb+0mlNbtXd
 FgfbP3IK0Qee0DOQ33PeVTfU7Jc5a2aIKCE6Ffv6xmkBmoo7Yh/n9E47R11+AACmyQg7+ydkXTy
 f2NLOkl+OCWAPGoJyQOcgeJ26OSBT4JmPu9oNz9OTltur16A4pu/jv6pnQRxdsciBUPZJExy8eD
 N9WP/VziS94DnSBN5SHkP7eApc7M99OSnVfXtedvcS5M8lIehzXAiQTeWv4BbCSGKNNVi8DMeUC
 PFdBuqTxVNKZsb/pZ1Q==
X-Proofpoint-ORIG-GUID: XICdhMQAl_Bp9U7W7OOLcfxPK-AP4Mbt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230007
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

SEVYX1NZU19TVEFUIGNvdWxkIHBhc3MgYW4gdW50ZXJtaW5hdGVkIGxvY2FsIGZpbGVuYW1lIGJ1
ZmZlciB0byBzdGF0KCkKd2hlbiB0aGUgZ3Vlc3Qgc3RyaW5nIGZpbGxlZCBpdC4gVXNlIGxvY2tf
dXNlcl9zdHJpbmcoKSB0byBtYXAgdGhlIGd1ZXN0CnN0cmluZyBzYWZlbHkuCgpGaXhlczogNzcx
MWZkYmE4OGIgKCJ0YXJnZXQvaGV4YWdvbjogYWRkIG1haW4gYXJjaC1zcGVjaWZpYyBzZW1paG9z
dGluZyBvcGVyYXRpb25zIikKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBRkVB
Y0E5TU9zNlZmSGYyVUhaOHo0Y2R2YUIrN0RZNmhKYjJlbVlaMmFMU2UtdDZpd0BtYWlsLmdtYWls
LmNvbS8KU3VnZ2VzdGVkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmc+ClJldmlld2VkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyB8IDE1ICsrKysrKystLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyBiL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jCmluZGV4IDBi
ZTFjMTMwMWU3Li5lYTU1MmExZjFkZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4c3dp
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKQEAgLTU2OCw3ICs1NjgsNyBAQCBzdGF0
aWMgdm9pZCBzaW1faGFuZGxlX3RyYXAwKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgICAgICBz
dHJ1Y3Qgc3RhdCBzdF9idWY7CiAgICAgICAgIHVpbnQ4X3QgKnN0X2J1ZnB0ciA9ICh1aW50OF90
ICopJnN5c19zdGF0OwogICAgICAgICBpbnQgcmMsIGVyciA9IDA7Ci0gICAgICAgIGNoYXIgZmls
ZW5hbWVbQlVGU0laXTsKKyAgICAgICAgY2hhciAqZmlsZW5hbWU7CiAgICAgICAgIHRhcmdldF91
bG9uZyBwaHlzaWNhbF9maWxlbmFtZV9hZGRyOwogICAgICAgICB0YXJnZXRfdWxvbmcgc3RhdEJ1
ZmZlckFkZHI7CiAgICAgICAgIGlmIChnZXRfdXNlcl91MzIocGh5c2ljYWxfZmlsZW5hbWVfYWRk
ciwgc3dpX2luZm8pIHx8CkBAIC01NzcsMTUgKzU3NywxNCBAQCBzdGF0aWMgdm9pZCBzaW1faGFu
ZGxlX3RyYXAwKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgICAgICB9CiAKICAgICAgICAgaWYg
KHdoYXRfc3dpID09IEhFWF9TWVNfU1RBVCkgewotICAgICAgICAgICAgaW50IGkgPSAwOwotICAg
ICAgICAgICAgZG8gewotICAgICAgICAgICAgICAgIGlmIChnZXRfdXNlcl91OChmaWxlbmFtZVtp
XSwgcGh5c2ljYWxfZmlsZW5hbWVfYWRkciArIGkpKSB7Ci0gICAgICAgICAgICAgICAgICAgIGdv
dG8gZG9fZmF1bHQ7Ci0gICAgICAgICAgICAgICAgfQotICAgICAgICAgICAgICAgIGkrKzsKLSAg
ICAgICAgICAgIH0gd2hpbGUgKChpIDwgQlVGU0laKSAmJiBmaWxlbmFtZVtpIC0gMV0pOworICAg
ICAgICAgICAgZmlsZW5hbWUgPSBsb2NrX3VzZXJfc3RyaW5nKHBoeXNpY2FsX2ZpbGVuYW1lX2Fk
ZHIpOworICAgICAgICAgICAgaWYgKCFmaWxlbmFtZSkgeworICAgICAgICAgICAgICAgIHNlbWlf
Y2IoY3MsIC0xLCBFRkFVTFQpOworICAgICAgICAgICAgICAgIGJyZWFrOworICAgICAgICAgICAg
fQogICAgICAgICAgICAgcmMgPSBzdGF0KGZpbGVuYW1lLCAmc3RfYnVmKTsKICAgICAgICAgICAg
IGVyciA9IGVycm5vOworICAgICAgICAgICAgdW5sb2NrX3VzZXIoZmlsZW5hbWUsIHBoeXNpY2Fs
X2ZpbGVuYW1lX2FkZHIsIDApOwogICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgaW50IGZk
ID0gcGh5c2ljYWxfZmlsZW5hbWVfYWRkcjsKICAgICAgICAgICAgIEd1ZXN0RkQgKmdmID0gZ2V0
X2d1ZXN0ZmQoZmQpOwotLSAKMi4zNC4xCgo=

