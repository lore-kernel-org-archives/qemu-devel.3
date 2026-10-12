Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D200ACA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7Ut-0002mA-O1; Mon, 12 Oct 2026 00:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7UL-0001yv-Uh
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:18:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7UK-0001BQ-Aj
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:18:13 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lHnj052538
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bNGiNareYZOosENIsqHDCIWM67DHPYhQB2MBRNJdxmg=; b=Qa+C5qhP5coqHI60
 PybqoYWMDeld/aumvMeG/c34oRxK1hfEWxI4OInHOKzjNGQetuvau72RTLZnXAmR
 0JHn2ITrUMc9T9bnxCtz0TsdY5/8Hp5fh4+8q/cCNbn+QiuJGJKig9j41UBTTJjS
 E0IBLRSEbo/0hFhkyxKBLyWLFNzN8NK6Q87XoH7MIrb3T6jmq1ZizU8kYu4R/Xsh
 /Rpj2hbmzzk6h1UzbkAatSfxRiqQH1g1GJ571EhEJ0Jg8XYwok1Rr+rjip+rndSU
 JRxB620T1cIgM7d3i/kGb8KF/nVAmO79n/GUi2PKTbuHlp4+FEbi/2KZvaSDevjZ
 3cj7sQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7en9vg3g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:18:00 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso2757293eec.0
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791778679; x=1792383479; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bNGiNareYZOosENIsqHDCIWM67DHPYhQB2MBRNJdxmg=;
 b=dGu61Z7zRyhRBb1C6OhxtAr/x1xjC+wBMCrnw6iU2URhs4MpjlVciGI7iXPjGB79LS
 0cD0siiSg1jufrHWY6D6qTtdavsLUqSLagL2ax+gkdmqOfSgK6KZUVEfDBWaGF8rZhsn
 U+Y9uZC24FCIVtxsG4/85a0dBA04wSjUeOL4yF/Ve9lWWdVMWe5jFgP4xnfuls+4piwj
 YEzB0plFxM+p9yNZquWEps7+1G3kgdOtZL+mW5ROd71kGlMtwLnCD7AXVuat5Uq1tQ02
 ShTT3EIlKRAQ8t//4XMb/ugibtKmEaFq6oKLmN5Hq1fuK1cUXmvOJclIl1a4tK0najDy
 IaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791778679; x=1792383479;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bNGiNareYZOosENIsqHDCIWM67DHPYhQB2MBRNJdxmg=;
 b=DA/7JD76jH3i2LiCYeEHjIeDub7IjWLtcpgInUwjGiGlAv87ZIkjRg3Sksd8UgNXIG
 +odtCPuvvP8ChBiK8usuyIUK2BIXBONsfrS1A9ekxByR0fd5n2gJrSWcf66YWXDQA0LZ
 qROO1DozCPAhFgve0mtTJVvKZpsRZ3p+sMlmT3YTLhoh9aDD19LhuPijfEm2xUQ9oDCW
 232XBa42KZ0LavWfSLVLSqE7511TDhhA2aV01Hl8C42Pqay3zUmyYyn3uhCODTHYyt90
 4e3z9hhRG9AEm8aO4qANZz3l2oj8vRCsBz0oW8ePV6BoaoLgSfNrQH0UCnmVcZJ4xcrK
 iZQQ==
X-Gm-Message-State: AFq9FYKIJTMELCHrchDrRVscdGE5JHDLgyDQWeNk+l58uRzrrLThZxaO
 igyTcXRMoF3fg9QakDx0Auu/FSIgfhi+eKyrP9pOh7GsYhtbX5BM3zdPK+PKMnXy+aziB9e8vJS
 yusRAOcS9so4U6aZ+WWUjEGPC+xdnRnxVDfLJYMRxM2XGksIDcOu38rSEl8FphjOSVA==
X-Gm-Gg: AYBFou0P+DgaYv1vbKJ3Ea1OuXI+xGdDgZa2eBoQYcEHZDESjpVbMrfvl+xJg3OutJJ
 QcgjUtO2jQETJqySgHG9E8Thhsm6d3+Fs7C44lGnVQ9kZPf1Tr+zRtMSM45D4glNYO/QeGgeJkR
 pXEJ47pTQNiKbjMHzu2FSyJm675GbBG5jNByl9rBNGVk8M7/mhirY+vSmQrGWPF0Ds9fQ0+kGYw
 astJkGmKkFN66EDmYvAoA/q/YlFoRzo72dbIsAYZhOFhR00oWdNqi6NKZmZtFpjxYcY5rgHBNWi
 l13pbDqy3ejICNS1TTLVQfZYW2d+6qTjyXZu5xS3ioyHlf+55Rg38i1zkMR5lLTdGDR5uB+rW6B
 yyw8sDSqJ/IeDaibVedb91hGqXecaM6uguVeiwJj1t6XkCfc=
X-Received: by 2002:a05:7300:538e:b0:34d:2c1a:987f with SMTP id
 5a478bee46e88-3537e033581mr17692926eec.35.1791778679303; 
 Sun, 11 Oct 2026 21:17:59 -0700 (PDT)
X-Received: by 2002:a05:7300:538e:b0:34d:2c1a:987f with SMTP id
 5a478bee46e88-3537e033581mr17692750eec.35.1791778676663; 
 Sun, 11 Oct 2026 21:17:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm32369096eec.3.2026.10.11.21.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 21:17:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 19/25] target/hexagon: emit explicit TCG memory barriers
Date: Sun, 11 Oct 2026 21:17:16 -0700
Message-Id: <20261012041722.1159355-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
References: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Woe+otfv c=1 sm=1 tr=0 ts=6acc5f78 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=4KcYvu_XbJg6GINjK8oA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: u8EimSo4qirY968_X7DAu6LcJ3Rin1fJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfXzpkLPS0Dn9Vt
 /1AjTYfFd1qcZWnUCxRUbjGdHgohwYNDjISXte0WOmP600Wz56PjOIqEH3mMAZ59KYQtNavWhw0
 KKTfd8KYUw+x0RyhxXc7dszSckUONnts1XWkEZEYckZojrKVOvkJIyoKwyQ/Oe0DPYSloJfPQHT
 xwdJU4UbPEyDFOxuj5vgPMpfgP6iaNg4TJW48IRiY7DD518x/FNuKJ6KMAVUhzdEMgvGLG7Bmk4
 qQUfOicx8Xis5MqtZxqFS1Aww/IPmxRHscAfvj/9XT/w/SVPQn0uZ/VmxhZEFOz3T+/63wkUqNf
 YOB9dMiOh3ChFK5XThz8zf2rnCkmLOsfeWpxsG5YYlRxWUKoE38QWIt4eOB6uvxBm9r8cd87kBJ
 RVOZqFfpDaDr3sHFjcOwI135a0u4Q25ixJaKP4diDNeYIE7wOQ/spDlZ0uUntR6Umbz7U8J1DeJ
 wvCPqLXF37s3DoPuPfw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfXx71kSqM6d1pR
 TBI9TyR/YjuvmNNqv9Tvcx15x56FUcXVkXc60z5Wrzu0Xd8bOQAB9A3sM9rl0HZ+2sPITrkUC60
 wLJRMpS/6RyeMO4h92+IGmUHE7uWyjM=
X-Proofpoint-ORIG-GUID: u8EimSo4qirY968_X7DAu6LcJ3Rin1fJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120016
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

R2VuZXJhdGUgcmVsZWFzZSBiYXJyaWVycyBiZWZvcmUgcmVsZWFzZSBhbmQgSFZYIHNjYXR0ZXIt
cmVsZWFzZQpvcGVyYXRpb25zLCBhY3F1aXJlIGJhcnJpZXJzIGFmdGVyIGFjcXVpcmUgbG9hZHMs
IGFuZCBmdWxsIGJhcnJpZXJzCmZvciBiYXJyaWVyLCBzeW5jaHQsIGlzeW5jLCBhbmQgZG1zeW5j
aHQuCgpSZXZpZXdlZC1ieTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21t
LmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0u
Y29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgMTUgKysrKysrKysrKysrKysr
CiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXggNjcx
NTc1OGJmYTAuLmNkMWFiZGYxNDYxIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtODM2LDEyICs4MzYsMjcg
QEAgc3RhdGljIHZvaWQgbWFya19zdG9yZV93aWR0aChEaXNhc0NvbnRleHQgKmN0eCkKIAogc3Rh
dGljIHZvaWQgZ2VuX2luc24oRGlzYXNDb250ZXh0ICpjdHgpCiB7CisgICAgdWludDE2X3Qgb3Bj
b2RlID0gY3R4LT5pbnNuLT5vcGNvZGU7CisKKyAgICBpZiAoR0VUX0FUVFJJQihvcGNvZGUsIEFf
UkVMRUFTRSkgfHwKKyAgICAgICAgR0VUX0FUVFJJQihvcGNvZGUsIEFfQ1ZJX1NDQVRURVJfUkVM
RUFTRSkpIHsKKyAgICAgICAgdGNnX2dlbl9tYihUQ0dfTU9fQUxMIHwgVENHX0JBUl9TVFJMKTsK
KyAgICB9CisKICAgICBpZiAoY3R4LT5pbnNuLT5nZW5lcmF0ZSkgewogICAgICAgICBjdHgtPmlu
c24tPmdlbmVyYXRlKGN0eCk7CiAgICAgICAgIG1hcmtfc3RvcmVfd2lkdGgoY3R4KTsKICAgICB9
IGVsc2UgewogICAgICAgICBoZXhfZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoY3R4LCBIRVhfQ0FVU0Vf
SU5WQUxJRF9PUENPREUpOwogICAgIH0KKworICAgIGlmIChHRVRfQVRUUklCKG9wY29kZSwgQV9B
Q1FVSVJFKSkgeworICAgICAgICB0Y2dfZ2VuX21iKFRDR19NT19BTEwgfCBUQ0dfQkFSX0xEQVEp
OworICAgIH0KKyAgICBpZiAob3Bjb2RlID09IFkyX2JhcnJpZXIgfHwgb3Bjb2RlID09IFkyX3N5
bmNodCB8fAorICAgICAgICBvcGNvZGUgPT0gWTJfaXN5bmMgfHwgb3Bjb2RlID09IFk2X2Rtc3lu
Y2h0KSB7CisgICAgICAgIHRjZ19nZW5fbWIoVENHX01PX0FMTCB8IFRDR19CQVJfU0MpOworICAg
IH0KIH0KIAogLyoKLS0gCjIuMzQuMQoK

