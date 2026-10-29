Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDFE606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KVKjb21o;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YE/Qicp7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVPC-0000UW-H3; Thu, 29 Oct 2026 15:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMVOJ-0000IZ-Kb
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:02:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMVOH-0003zX-Bg
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:02:22 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDHX8227441
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IripPpyxh+a/k2kHers8WTVdR97jkV5MUf9UJAJPPcQ=; b=KVKjb21o4T882zM1
 QjGuF+bYW+2TKMGva1H1Rqg+BSk+SQYAc8tun4BzQccWI2XXMK4N/hL5JzG2qU44
 OKJY99VbrsxkDREubLZIgufOtUuI5bZuBpbttD8vwjiQGsiP4jx1JvycwJPx6sVT
 mr15K4PuB8U9QYc1btG0NgYp4JCCb3QEq45krxHoKkD11hMPKtDmXQC5cCwkxnuU
 fYzzC5sVSGAmFywXL9FUa/hav59mhijeWpfMdRi8u+is+UBD0CMQai0r+7dkY+pK
 x85/gwrGZNzoGf2v48dL5sqLZ63LwtlyCx36glWZ8HfUgCMdzEu8Vuf0i2/Bsm47
 P9Gxkw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm42fkcds-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:02:20 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso5027945eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793300539; x=1793905339; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IripPpyxh+a/k2kHers8WTVdR97jkV5MUf9UJAJPPcQ=;
 b=YE/Qicp7Jjbt8z7PCcXWEoHZ/rwGquIIHQ+uNgrzSAoaxC67d7tvW3c+5iRvIGSUV0
 tirrhbqPal7oH6eMvwVoqKdLb1J65QP7qMhIh3xCN2RfTwbNCmlanJr0xDY/4jzQ4+1c
 kDmgZ5T42EVC8Z3tIbj9nznZN2HsO5rUbtPi3ZZFmbsta/WkH5wdIYZUZIduFDHI7w+g
 UiAAhS2S/KFwTDb/a1R4qwomte6BINJP1l3YcwgUv/LOI2pQx971wbRgx4N0isAVLBRO
 6PeOZIWqsZq9Qcu/w7tguDQgqXl4owjN6oVDfLvFREjQRekTQt3rZngYbLd/UFhtRv/d
 A4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793300539; x=1793905339;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IripPpyxh+a/k2kHers8WTVdR97jkV5MUf9UJAJPPcQ=;
 b=s7b9Xqbtaa8SBTfELgC5ujbubqvUibWUL4V69sjKFYfDk/EyvNR0b2BIgOhz2x1AJu
 /LeM+4BZtlR4buoWRx0PuxJXyyAVn0f9LF2nIFZHXpUpzxcxIxkOLdbHC8j2k9mpKeAX
 x4YsTnRPWNU+M5Un3R7WxxDqvRmtn1qCOBZtOka0b7BHwXqTK0HnGYyHDuNNLQ1BRysD
 /rRJTMrYi4oZpQRJS3xEqB7xmBFoqiT8t5mDVOU1GkTGL+NLyRiKXVLbWhl2faZTcpv8
 Ui4u3IgI62vrdce9L0yLI+7SKvfMY2jc8LOa4mJAGEje4UOEIv8a09ySkYJIwlTj7PXj
 D47Q==
X-Gm-Message-State: AFq9FYLOKQFNTcj+EYoZlEDbCHeDL64H5MvXcIdhlEu5oQkT2aknZeVx
 IclpkG8HJAfWWviO4Mtp0mKmTKdxYLWRinlXiHKDwUyf1U8wOdOXs9oIG70ZGkq+3PlpqrfWQBj
 fTnnSFF5+TiZXJnFL91DkmK2S/5pO9vvhviCF6by8cwn96Cw/qukgtOGvUzMyGmfoHg==
X-Gm-Gg: AYBFou3LNC+2le6BfjOWlohLp9PuYyrBbVlUuntgGqNRgz8e9Wmi/nSmUgoiNWF4k6h
 eySlFcuIyJY9sTSV0p2wAzb/gVpF2Y/yfweTu0iLNwK67eXP2RnrcRNXvyGUSR8L1wWVfbSgpm4
 9qhlZO2OsNc9/YuMl1AmnnQ4XVcBiukAFdpStWxCGMfy+yfxoEPWy4nTqMOL0WDfXxz6wXiNSIZ
 zgmCmzsdxiJebllm7iOk63runHm9M0ikU5KIm6/WayvKjAPHEVoPvMivWsSeARi9tqs1+iyvTeV
 bbnIaRFUH+ZE+IikZ88po530Rw7fpr9DdUfBJx+s6RkWkmlfM66U9UcnKRTCOEbspQT38b62o1R
 PPEpGPeyOViJBg3waU9A/BfcT8G1Eda+TvHOalnfjPN4pOedsRC87t36APtzVudveqxsZBfXItZ
 Psz6QM8NvgzOhP9f1No/lOhg==
X-Received: by 2002:a05:7301:648d:b0:36a:1b95:fc75 with SMTP id
 5a478bee46e88-36a425dd9d9mr332737eec.35.1793300539230; 
 Thu, 29 Oct 2026 12:02:19 -0700 (PDT)
X-Received: by 2002:a05:7301:648d:b0:36a:1b95:fc75 with SMTP id
 5a478bee46e88-36a425dd9d9mr332713eec.35.1793300538710; 
 Thu, 29 Oct 2026 12:02:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a98f65sm480598eec.28.2026.10.29.12.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:02:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 5/6] target/hexagon: let a lock owner service interrupts
Date: Thu, 29 Oct 2026 12:02:07 -0700
Message-Id: <20261029190208.1169519-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029190208.1169519-1-brian.cain@oss.qualcomm.com>
References: <20261029190208.1169519-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3NCBTYWx0ZWRfXypQ2K3efgg5Q
 4ReaPpV2Z5M3j+LoQNbYYkGTPagfPrJ6j8EfOy3/KPl7dXd+7uXlFgjUYQ7d2vYhQ73K/9iJf0b
 dEZss6opazkIo0Zy3ZHSbpzt3f/pZvrrnDhWxAqmjUTfE8Bh1odPBuNJGn1wwP+1I98jdcDx44C
 mYUpNepQ5VYwOTFYPfWC67M9Qgs9sYl7ko4a9XiEvYLGLlt9YrTUm/sLSv6yWaarw1VwW6elYTL
 F6F7yn3dQjpTHtDS9Av4EKayIpVULpBoJQl5tt9RBC9ZbJY0E9L9W6oQZuXZsSWLd+fOw6/CaLS
 wxBLdJf22GE26F1qXSvjOoqSpXm2ubDeZoCMu6JpllvLtXni5/o3AicfJ50sjYkhKMnesQP65t8
 Ir464epRNZX2+wZYmB/VDFhbb2n3xg==
X-Proofpoint-GUID: o-fqtmjT56fZ-x4FlLiwrCZmScxivWGL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3NCBTYWx0ZWRfXx44ZwDIwnFRD
 fD/i2O4S4is/61SzB02MjUwTItpQdACZFqvJjJgaYpKPZ2Xbkrf2II0n0ituwriFFHJQ9VychfC
 SceXD3AKrhA14x2kE0PKMXVEJuM/BSE=
X-Authority-Analysis: v=2.4 cv=UN9Ijyfy c=1 sm=1 tr=0 ts=6ae3983c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=9w6wkQ63e6kGElowvuEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: o-fqtmjT56fZ-x4FlLiwrCZmScxivWGL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290074
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

aGV4X2lzX3F1YWxpZmllZF9mb3JfaW50KCkgdHJlYXRlZCBldmVyeSB0aHJlYWQgd2hvc2UgazAg
b3IgVExCIGxvY2sgc3RhdGUKd2FzIG5vdCBVTkxPQ0tFRCBhcyB1bmFibGUgdG8gdGFrZSBhbiBp
bnRlcnJ1cHQuCgpCbG9jayBpbnRlcnJ1cHRzIG9ubHkgaW4gV0FJVElORyBhbmQgUVVFVUVELiAg
UHJldmlvdXNseSBhbiBpbnRlcnJ1cHQKdGFyZ2V0ZWQgYXQgdGhlIG93bmVyIG9mIGEgY29udGVu
ZGVkIGxvY2sgd2FzIG5ldmVyIGRlbGl2ZXJlZCwgc28gYSBndWVzdAp3YWl0aW5nIGZvciBpdCBo
dW5nLgoKRml4ZXM6IGM5ZjNmMGU5NTQyNyAoInRhcmdldC9oZXhhZ29uOiB3YWtlIEswIGFuZCBU
TEIgbG9jayB3YWl0ZXJzIikKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBv
c3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMgfCA2
ICsrKystLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfaW50ZXJydXB0cy5jIGIvdGFyZ2V0L2hl
eGFnb24vaGV4X2ludGVycnVwdHMuYwppbmRleCAyNmE1NzRmNzZmMi4uNTRhMWVlMGZiNTggMTAw
NjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMKKysrIGIvdGFyZ2V0L2hl
eGFnb24vaGV4X2ludGVycnVwdHMuYwpAQCAtMjQxLDggKzI0MSwxMCBAQCBzdGF0aWMgYm9vbCBo
ZXhfaXNfcXVhbGlmaWVkX2Zvcl9pbnQoQ1BVSGV4YWdvblN0YXRlICplbnYsIGludCBpbnRfbnVt
KQogICAgIGJvb2wgc3NyX2llID0gZ2V0X3Nzcl9pZShlbnYpOwogICAgIGJvb2wgc3NyX2V4ID0g
Z2V0X3Nzcl9leChlbnYpOwogICAgIGJvb2wgaW1hc2sgPSBnZXRfaW1hc2tfYml0KGVudiwgaW50
X251bSk7Ci0gICAgYm9vbCBsb2NrX3BlbmRpbmcgPSBlbnYtPmswX2xvY2tfc3RhdGUgIT0gSEVY
X0xPQ0tfVU5MT0NLRUQgfHwKLSAgICAgICAgICAgICAgICAgICAgICAgIGVudi0+dGxiX2xvY2tf
c3RhdGUgIT0gSEVYX0xPQ0tfVU5MT0NLRUQ7CisgICAgYm9vbCBsb2NrX3BlbmRpbmcgPSBlbnYt
PmswX2xvY2tfc3RhdGUgPT0gSEVYX0xPQ0tfV0FJVElORyB8fAorICAgICAgICAgICAgICAgICAg
ICAgICAgZW52LT5rMF9sb2NrX3N0YXRlID09IEhFWF9MT0NLX1FVRVVFRCB8fAorICAgICAgICAg
ICAgICAgICAgICAgICAgZW52LT50bGJfbG9ja19zdGF0ZSA9PSBIRVhfTE9DS19XQUlUSU5HIHx8
CisgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRsYl9sb2NrX3N0YXRlID09IEhFWF9MT0NL
X1FVRVVFRDsKIAogICAgIHJldHVybiBzeXNjZmdfZ2llICYmICFpYWQgJiYgc3NyX2llICYmICFz
c3JfZXggJiYgIWltYXNrICYmICFsb2NrX3BlbmRpbmc7CiB9Ci0tIAoyLjM0LjEKCg==

