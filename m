Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251F8606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J+L3mP+1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WZ1mozYM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiJL-0007Nb-QN; Tue, 27 Oct 2026 10:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiJ8-0007AA-Ft
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:37:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiJ6-00061T-CK
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:37:45 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoJPo2948485
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=; b=J+L3mP+1Bv/xFaYY
 Fk1aRUlFRjHpYLuCiILEAczYp/9D+6cRK1u/eEl8Cfe/ct5rqRgdclHnjCP+y/tx
 /4wIT3TubUuIaiHpj+quFIXWLBx6E0JjzYdrs8z1mCgmf1LxffVN4OpJ0vgW7oFl
 emKZOHUJ1gqIYJdQETiGePt1qgYlQzClukMmPd9rXJbqZ0ecn9rttZsi4Bts26dX
 h/lU55rEctV+lVembWo+BriuSoIELgfOooUAaJM3HywXl8xzVA7IYjUhyDEJQkpS
 qDD3Rpih8XQjYQbsuT4jGjodxF8WV1OZ7TiYY7Y0z61hGk6g345SJ/h0spq0vcEM
 7aKsFQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw21kw5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:37:43 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3abb4c24125so3932503a91.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111862; x=1793716662; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=;
 b=WZ1mozYMevrV0NhjK2Cip56ASyEgYrqaSA0RAn8yAy8tgxpHyd/j3Q3oU43tGU1ZcC
 CTXpmMuZBw2bZ+B09YJVW7mECjbtH1RoVONT2CL542++r5QUsuEQvJVtiHfdnGQYw86Y
 RuoWcsOQFxOg0YK9oFFYc7m5iNNe3864pBIL++9fVLVzaWyAYmaiTqvv/x1trB6xUF6D
 D89s0u1hSwyPSst/pR6dRTahmEJrajWHgbVLXzdhYPUQgJqXnHABSOiPwlIVAri+OnhR
 +d3Je0BJkauAEMOA7CkI7JIVGWfPpa2nbqEQmP8Japklncqy9AONHuCjdoHIrBGFYwHF
 l1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111862; x=1793716662;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=;
 b=VfKxhR1AOfoPi+fuGmznNEbaNZJARbHKzKsOuc8tszHzRVIy1DKqtb/NPN+TNP36VS
 OzBDckXiFh8n9uD5KRELoZ1UZYBtNx6kf+F6kQbp4xX5yJp4dHzet21x6fpkUWw8tLbe
 kb857Q6y57x+pqPwu+rJe+zK3CS9GMJ09ta5eXmc0l/n1v1dhPGJNcil91p7vqp1OpDR
 attn5iyxIeEG4QkjMihLHMLXo0506UvmAHSFkD4snuuYlCFCJwN0z+zTwqSFs97xu/j6
 ulk885/W/txRFxs67fBY5Ay/bnW4Pe0ol/zM+2/PYMC+Hpvf8yPuPtRFswyf5u2CvkgP
 Dbdw==
X-Gm-Message-State: AFq9FYLyU3br4DVGxG3jTjMXAE/buFttWY7FIgF/AIGZEMHFIEfFo9pZ
 h7IEf3ZUxKkPZiEnka/GdgAGLZfNrbv5O+l0xaEjLGLFSY3qiLnzBliULmPkPeLiYK+lBGD7iDc
 ZPeuWzFTL+ZREWix4V65fJDhW4pj0KnfgX4UpZFnrwyLBFdeq7jO+zwwAzaKeE5N94g==
X-Gm-Gg: AYBFou0g2uIZyLKHCHggiat3ZjnXA0XD3hCC+9mlsSkktZTM4xBurkH7t00e5GA+CbR
 tcNHHJxu/uV5Bei+sr/+4bonDfty+brjcQNLmNoGIly2einw010vzbu3p2EnyGJ3u9Qer9+jT2p
 Ez7pem92qkUkIrqDSenkWgh0GQE/7aRHbsjkI026+wkFG15S9bfYgjTSGLHFrs1wVjSDgEFwDvN
 hQRieaXItpOOHfgqhe3xyy8KxDG+d0/7BmUL6eRCkSeYL1KGqQf65bXA37k1HSgSl6/hz3xuadH
 UdJVzC9D+/iH7IgnVwoM9l+inN3vCUKKV3IRkSiFLTTP4dw4llG/frVUpht9UqFIlSAtpOYEGDg
 wMszUA/QsyHdmOaMTdIbdAG1nw9vrMPud98KI4JlKyBzQ4I0=
X-Received: by 2002:a17:90a:e18c:b0:3ad:3e8:12 with SMTP id
 98e67ed59e1d1-3adeb126491mr7114729a91.48.1793111862448; 
 Tue, 27 Oct 2026 07:37:42 -0700 (PDT)
X-Received: by 2002:a17:90a:e18c:b0:3ad:3e8:12 with SMTP id
 98e67ed59e1d1-3adeb126491mr7114710a91.48.1793111861876; 
 Tue, 27 Oct 2026 07:37:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404dde70sm4056102a91.1.2026.10.27.07.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:37:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL v4 07/42] linux-user/hexagon: report ISA HWCAP through v85
Date: Tue, 27 Oct 2026 07:36:46 -0700
Message-Id: <20261027143721.4125584-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfXzhaHeFRTwJyj
 8AibIvMEh4UboLRDulOywWXsbjsv/7mNW1LFvjg7zDpsKuG4S4yEvzzkatG/Rv3EoESwPwWgVuW
 hiV932baXqVPOv5vXQO+JkWx8xEdynrXiIAf3b7+96XIh9qp2nrPuHP3uCCLv+0YPZ/LbUBGTab
 wkuK3P5l0/M1MVd+vEydCt78dERCeH6fsJRaLFDnv6b/mDUIsgf1zDzdKpwsvKK21ol6EehTjs7
 998o4XNTa+eV29qTx+Cr9m0TE68Bh7k/w/EWAEAL1L1oZ2nj+cqgGNYyrT8PZxbDijs47Uga3Qw
 9KerIltqQsEPkzM52oqXgfbwCJmLzOr48HGxJdvgxWrDrRz1e3aJkDevsPJFBSDPBeuDgS8agpx
 +9xYTZj6NjMv4P9f9V1tbTVoLAsr+6Zvvw2IL2LS+jzJ4Bjm1DVlj0VpoYLZMaruoDLBfEzS9/a
 cwkrKm43/0U+00lmwUw==
X-Proofpoint-GUID: mba4Zg74gLOAW6qMnBE7sdUJLGx7aXdf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX0J8S4mDr2wkq
 WHjklgY0rrM+ZwEb/E78SP0v1b8MInFnZiIzRDh4Pq2cTTQI8uaEFQSUKqt9CU8RCyTvF3uhsmy
 EhIpw5YHgUAmcv+KCSWlIMcvBe4M8D4=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0b737 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=RcCyqxnK1iORyYYg75cA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: mba4Zg74gLOAW6qMnBE7sdUJLGx7aXdf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

