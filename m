Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0910C606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Og2mdqkH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TqK1G99o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXtQ-00034Q-PU; Mon, 26 Oct 2026 23:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtK-0002j4-HI
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtI-00006i-PM
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:26 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2ExPu3986657
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r3WOvdRk6q9uOwIyLgCWCr89tN5UwlkzfMPmHZ8doEE=; b=Og2mdqkH3gaSOg1k
 UosOKX5CqvzWQx1YF4jp+60w5STayCmAfap3E2LzzW+aE1WUZ4IutbmjwcRmFH+G
 DNmk7fO1oVXf+0WARV3CRwfJ0bOrUlc+i9XOLlSOVoScJ536Dlx/WRL9FBLmGKgq
 0XXtzhtJxlkmb65heCMUvH+ZuUNA3SWwPHty4kAh2y2bpTXCIvdHSSh511NDktjU
 WiTxqwNfWgtF3d47Ro56vsmwlJidW+VJJpjYAr3xq/PGs8yJkax/EGNO0MARkSQr
 y0seiSU+vG16SlxsnNqIwluivxiy8udqXmkw9stORcr1oneBdXPlJAJchmFIDc6v
 AKRqEA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj8smtj3x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:13 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-147be78cd56so1722557c88.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071813; x=1793676613; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r3WOvdRk6q9uOwIyLgCWCr89tN5UwlkzfMPmHZ8doEE=;
 b=TqK1G99o491S1MNg7Y5OmTYFv1Mczf4SzN3NdqhvIpLtFGp9E7Lqe/M1DscDWZUb40
 +FqN8aOnDflYY0WinCGxcJWBXtZYmLl/GLZA4iVTmfd7/NfrqZI385+7QcFvipyFhSXT
 cMZ9jPG0D0G7fEfhK6hzTkss0PgIu2jUAnyy9GmUzCXC3FXeAl73EnWvxROUTab1sf0S
 VFshjiiXM/nU5v7x61HXcsas8GnD1khKP1VUHXMOw/ep73iybxjyXo4wL77Aa/rXLz28
 oUoeUsPc/22pNVWKhrSTRWL3f3TC6L8XitUFs+rqrpdvJktXi9wrdjlCgGx05USs2G/z
 VB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071813; x=1793676613;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r3WOvdRk6q9uOwIyLgCWCr89tN5UwlkzfMPmHZ8doEE=;
 b=TbSyg612KFh4tbwrPUNMp4h+5XyHJxkwj0qpboWLqKBvZBYOXYtirJyA5vxqbrEdnJ
 sGLvdYvhpRDuahnFB3PXEegkujuDSpd9BNJgbGlhpiTUx+W4YVpNUOyE7Gmz/XkKI26l
 n9aHZbzVV/I7o8hUeDEeCo2D4KGOGIOocGZqjdKdu13RjqOrpx04QwR/0cn6Vd55uALC
 fnnQ/KAEUpOyzH2tGXnDQHtJwrAJ6hVNQ7EptIEsa6zE5jsBXz+PZpNV2wlRpdC6+9P8
 OCEnFfQi4z0XcWBHIBZ2wN6quXz+ofOKpKZTbuzhYMo2VKYG9i5AZBry297vKnReTixo
 AHow==
X-Gm-Message-State: AFq9FYI3jHOoGHFzF2fXfmoyhYDYFYElUzvp2RO1/ehCy2+fXAzpeYWF
 2d6WiiE2HQ7TGkcX8fk2pFBmFn5VDLJzptPVDBp6uG1xfx1C1JKS6CNM2mAxvL7qlebiiKwbbL1
 YONXSJp7ozU1/sPjPgRq9F23Mfuzr7+x/TBT1r+XHjF2ODYHvdit3UM3ICzlPz2KFOA==
X-Gm-Gg: AYBFou2xnhIqIWtxwgxGv3MzcMvV4XydztXr+gzMmspexOiB/yeSqZMdzwGBCqX/H9B
 10H7tZ/W5VeS+i6C9Ss6xCoefhrAM/L+jX4NEZjyaqrQ7eGj0DvS4cOXMeILOtyQR78eYDTsNwo
 I8WPdCpxBu/yBHL8Dk2xX3K4EzaDJynobbGdCBgxjwdObQ4WhxhZHN1wIDlq5l8L6/j3v4u+lXO
 FZzphOFu1BtNYGM6Mu38yOYDENvhqpL/0Alq/TJIV29Pd03KF9u8FLdLNQCysNPpHVPLDfrnOhX
 xzDcbklKsmoNcyaWbx1JT4OFRLo/FrDxkrHG7XX/cOn29wO+ntRAikLBmYLJntaNsduSlT3efV1
 wtVMZuBTNQuRrb5yfJH2RIQKifc+Yc/3DhTEj0bVnFL4+n8o=
X-Received: by 2002:a05:701b:4783:b0:154:e9d2:d741 with SMTP id
 a92af1059eb24-19936a5e7e0mr14687238c88.8.1793071812494; 
 Mon, 26 Oct 2026 20:30:12 -0700 (PDT)
X-Received: by 2002:a05:701b:4783:b0:154:e9d2:d741 with SMTP id
 a92af1059eb24-19936a5e7e0mr14687139c88.8.1793071811614; 
 Mon, 26 Oct 2026 20:30:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:30:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 17/41] target/hexagon: fix semihosting STAT filename handling
Date: Mon, 26 Oct 2026 20:29:03 -0700
Message-Id: <20261027032927.3055166-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: q1CBQdQnteb9bjsk7xLFU1pqcfU7B_lt
X-Authority-Analysis: v=2.4 cv=Sfti5fRu c=1 sm=1 tr=0 ts=6ae01ac5 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=vW8nx58EJidmct_-KksA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: q1CBQdQnteb9bjsk7xLFU1pqcfU7B_lt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX8QwFmWSHLaxj
 wQ529LytWEgarxXUC9/ajt3EGPhhxBdv2IKYXiFYD0t892tUKzlLsQ/810MfNuZ/i3uzgGOxmJQ
 sTMv6w7bDcyy6bn3fRHvR/Sjp8T5zo4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX5NdY6mxi0jce
 u6FedLarYkG3MIY/BwIIJNK71iayKErwnqOBLgxoxiFdRVqFApY8Fsdpeqt6OaZMHsQgCfhv/17
 m8U3qp1FDuyDK6BQZxC9/QcRmRG7ahJ67jWtbMH12oDAvUK5b8r2nxaILeLaSsXRW7ywnCQBarw
 PxNG2VXAKAvFQ7X/2HOYWZ580tieh5sooDN+G+bspldDf7LPs22u4Dt5Z78mTLvMOeZ70xNsVur
 Rn0UUZCohdcL/WPkmIIkNvLVUcPnY/AwLnOu9ZuAwpul0yytO5jVrmOrrQNn6Cq6nJKvx56tRsD
 LgoEyNcRtsz/pNsMekq1TLkgKa44hmUl5SfQwc7IDTNPopqGFQGWQy8HqjApuRmA6aEvosWFVBk
 R2RssCH+nn+yMRUpfG2Rjso2C8eIT/1qllvCGcixN2k6gbfKHLlb43suCrdXOfHBJk1mRuJMIhM
 FZYwECYEkfOcfRJmAIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
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
YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyBiL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jCmluZGV4IDZl
ODNkODY3MzNhLi4yZWJhNjAyMWI0YyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4c3dp
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

