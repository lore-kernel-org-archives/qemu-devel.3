Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17C3606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mf2iMBZA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UyUwrVWz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4RG-0001RK-8i; Thu, 22 Oct 2026 21:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Qv-0000ma-Lb
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Qt-0006IC-UL
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:01 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1Eukl1335027
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=; b=mf2iMBZA44JNWlxk
 D/0a3Bl/YNUMOrhU/68ahy4aKlGwEj6aBWyP+OOFZ480tYqIjgJkY+fuUJ1Z2gav
 JNzfQS1W3oXE72bLQ8e7K5jzV6X1660nz6RvThDDnZ0sQYckc6t1v0kjL3QbNMRx
 MpT+S1bmlWPbwMvTMa7RzGeyNAheK4nC9TCLATBn8kBtRGpiDns5MX/rWbBVrd4w
 TfkA/QXAS4noIDlCccGR1cFKtXtwQHNgLoUcUvGfVd0OzKxpr4S2HFrN/1n6LVnF
 14HllLTipHPXdxypB/XlStBVFkcewhPl99VMmjGZiozzBy+yt0cqwMN8fCmyuBvD
 SKZXuQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsyk8tgj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:50:58 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so1039224eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720258; x=1793325058; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=;
 b=UyUwrVWzv9Vxsjv68YjscBuo0RN5mz9mwnK9PqjULhWE3ejb3J9uXxm8DghkmnaY1K
 rcwU/dvgNReUbBXfVZsx86g6EE/K3+LMDY+Hq6OIoLTp2ayBlqYUEqbBz6Gn5lfIkr/2
 xNE8duN7TvPftHdeQY6+m/fAfuP5rTtOBhltlOV3IR+S/nZ0JpUpqOkTbtDHrotsW4Br
 N9eE+8bLbjj01UjclLgDf4jRdKqnUdTHLkf4Bh2CAdNpWNQa107Pt6BLeL4O/FsFryTF
 n8gGZzW1t7SapnX60AY0AiHCpC5MUYz5fP6uq90/EmJD6qEr/3EvEtuOGwpQkQ9Zt9t4
 3Atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720258; x=1793325058;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=;
 b=1vyD18ahP3aWO50UEFZ4SYI6nIp7FsRY3GkK3RDTrTEQAbmXM1/mM5WkQAnqeNlM//
 4irFdRSWZX/JLHBNicvINfYRqeegRs+X6sti08zlaYmtgYBa8azQ74IzpzRvrp7JCBBc
 oT0Av5R6IBmScTEpJg3CAEZ+GqR1U8uaIwMbnbCowY6w+T5wLyN2tpr+sSoB8LdfkbWz
 qDPa3gKkWX3cUucQ9+WZDYuVuspg7H6soPH//2M16L3Zh3FqvZzt+7xBh0uE/ra3wSgQ
 4Zsr7XwWRegLAaW7G7lfhsOJwhFq7HcRzy160+JyDmSNNADyo9/jOiAKIC9uQ+epSWjS
 Xmkg==
X-Gm-Message-State: AFq9FYICR/lqp9sVKhFzIM5nhxnyGIpNA6MJWchi7c96ryoTezfFNw76
 Fo204PFiT+Xuf9iWgl6nEtKfWQeJRWn/VVFyg5nR7sVXYa1k15Tk8wkljc4SVy32VvZPcOdLhm3
 E4okfGT7VLVbih2PcQ9E8HvpqKzIC/ezSmy6hgwG/+XJsf4OUmT+U43s3Y4yL5qqPMg==
X-Gm-Gg: AYBFou0MoYnHzLf8pqaE3ryYDdw0oj12rgLxbtWuVZGqsOEoXE9gMpjBohPWrdyKNlF
 mXQBhoDHATWHKWpYctaGc6aiWhv3HMlTmqzLQyVjiCI657GG2MP8zT+ErOOGRNli2d2sw1v6qcW
 XwmhWa+K8kTsUH+ZNbWZQrRzkhdsgid0XNGVM7GICqE0wdVVqBpl/12hDImalWFYssDRIJYfI7N
 9LQuyJYNOollDPKb4Zt1StD6KJOaNRh+LVX00V0c+Wwt92D2G0/zOCxburW1i1/yHZU5qslQclk
 npBv+1M7InfttK/mQM7FUSJOsCTLjLktFU3LIW8v1wSyOrTJVzEKYivRgr28VkA/ltsoFXvBL/C
 51P01zh3tuTRjr9upSeVU+dY5QM5EBnJznTAFg7OpxPpBQqh3
X-Received: by 2002:a05:7300:d58c:b0:366:9f06:3c4c with SMTP id
 5a478bee46e88-369d97b7839mr1139676eec.32.1792720257756; 
 Thu, 22 Oct 2026 18:50:57 -0700 (PDT)
X-Received: by 2002:a05:7300:d58c:b0:366:9f06:3c4c with SMTP id
 5a478bee46e88-369d97b7839mr1139657eec.32.1792720257201; 
 Thu, 22 Oct 2026 18:50:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:50:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL 08/43] linux-user/hexagon: report ISA HWCAP through v85
Date: Thu, 22 Oct 2026 18:50:05 -0700
Message-Id: <20261023015040.2473105-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX6jC2uAMMLjqV
 Adm3rpTp4PYU+PbL1VFS1r3hOkvl47S/cBjkWuncjSapwyGH+SsELxdlUiC+jEVn2TioSrT1JgV
 El6ZpeoRaVHYTrDWPdipDlz45LEGCDMw/v2nRcQiiu600OOCQAr5Lxf5X6Rt8fcR1wxWUpiNNi2
 pt4FT58GWSsFEYkEcKDfETY52nhIG4ei8Xmizs+NPg1NCtWfcocbStnR9DkM32Mw/IznRVg0ETN
 2i6bHsTeGVr5XnHcwC3tIYUtM0pPirebxdhO5tCPvwMl/P12ocNBpeUquxcbMgxUqX1R4WDwQin
 tbZZ19nCg0fVctucTYhwzHNknnelWEsfNF+Ln2TYkAo/qTTH8nI8AuD63Pdx78/k2zjo2hSFZZL
 ntBWL2bTEUc524W3LQcEGGXw2h/2Rlry8EWWRhoYgGrAHD5AffqjdIYVvCXc235bCkoqhapgskF
 GTv3iQ/SjFocss3TRfA==
X-Proofpoint-ORIG-GUID: HTLx46pIDRyOZcygZa6qrliubz7tmroI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX3SM0+w42tnjd
 4mFrvRlHnoVYrkMDx3Rfb9XgH1vbtXkT2FaNiU6f83OvwyXVaYITh6wO+p0qKfQRGxCLi9CLEPU
 NTOS1vV3LcOlUXBMSklqD2yh5CYcgA4=
X-Proofpoint-GUID: HTLx46pIDRyOZcygZa6qrliubz7tmroI
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adabd82 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=RcCyqxnK1iORyYYg75cA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
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

