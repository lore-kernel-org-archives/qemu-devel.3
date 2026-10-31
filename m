Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F70F606A322
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eQxL66fC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eD+qkadM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMxwb-0006Gs-Bk; Fri, 30 Oct 2026 21:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxvI-0004Yg-2H
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxvG-00033X-82
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:19 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69V1CJZ21314056
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Gp2udMjInRuN4fjJoTPe/z1esLcuAtByyULdfWoV610=; b=eQxL66fChnKBF4Es
 LO/5sETanyXUGHsQvGqgPN4MEf+cGeE+XR+JUfApwgK/vuSTFcOz9W2++onmQU7L
 H/zvKl3pzIkVxpet8AXmGuT+aO/YUyK1bTMxc55tNrp6r2VBWzzuj8c3MnI2JozH
 QPm9L/qn5GYE1ez0RGH86SCCAo+ujACdzjY5Atw85V8QNIKKGCyjtIwHZ/dEJ9wE
 ATLdlso7pzQVooyD96WGSUG2/lxcchIvhW2VNxAHVYjpeS2618JPxHKQIPKpzq7F
 t1gYsu3fZNfEMf2svBFd0lTmu2jAianXVZmHFw46WO/4Nb0L4Lc1ENS/1a1qCBk+
 Rln5LA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x10qsk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:16 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3552883bd19so5290167eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793410216; x=1794015016; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Gp2udMjInRuN4fjJoTPe/z1esLcuAtByyULdfWoV610=;
 b=eD+qkadMq6xGC7E2hph9LsGRAzfsP3f7IfgmFHi+e6CimycHLsE2s2ksZyCZQlLCUX
 PxNAti4j9HG6XYmfpR+qLbBCbHzZdWJy6wKwq0/hxhmpw4aGcS8uPiw2BX/S+D4daOQz
 sidA8hQU4i3G/cyN5cExrY7wj6EN1npjqepp6LN2PXfLYTJtoJd4WT82LMGkY/RZTrut
 Y0q6ryrFK6N8SBN4vaDGDLnGvpkrR6pMwg1d86808ZZTKOepbxHGCU0rib3DQo5fXiLk
 5Ivzj1KNtgLa5fepp+3FNWs4w8mIP5zHMmN+j6d4eiDkRMh5j8VpMUayl2tBMlqaP214
 hEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793410216; x=1794015016;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gp2udMjInRuN4fjJoTPe/z1esLcuAtByyULdfWoV610=;
 b=tXQeRrif4UV1hZUM1cYKCPkFtH590PxlbiiVe4C73NrS0edhoo/jcuQXh9RMyBvL40
 nb4/y5bRHG9aigLLXg5Juzv7UZJlnI1iEk168Kav4Zt8xAhM6J5bOibL+FWCmoFvEd6S
 18UegMVqlzWwNTnPcOL/RJ5ezf3ZuGLkw9RwTIQT3VcbTbmSBzReJNNaxAY6Lp2x3ESR
 RXgJhLQHoalUfJxo/TKfJ9j8ZHvR+ph4gakXTdZybE0qiHegmZa+zHpb44W9HFUHJJ66
 xXgJe3oVpXDaPO7cziWFU35ePrHBnPkR0+kttvkVQOSrtQkZi7pRvinwK3iZ88zbVFDP
 cZ3A==
X-Gm-Message-State: AFq9FYKjSLvWoKuCej9gnDaSHnHgrGs7WwD0BEAMuNWcR0Cx9ajYOP+F
 YEfUngZkDsX65uNXeTAeol4b8o+PUUF9HJJqpdqe1CVYpC5TctvDcRQzcURkKwagrpsMJ9ITP/D
 jmu/s49XBe/6u4iXUX3crJPF/ER9xKy8L1OBMVx3e4CL7NFRHBokaz3OFmNgfdZLpkw==
X-Gm-Gg: AYBFou3e5yl2tTqqD2dCAhm1Vb+x1K3D8MeQGpv7o7MMMrmcDLdASoONqw1xq//Wh8X
 zusO1Vmdr2OTARMl2zqvdn65NgyXa1wvQlkJap6t4Ny3Mv+TzTqg+t8MjxPuJnN4o+i+F12ZHAJ
 X9Pm/i1tHjMTNyb4wN3gfDwYV1TtarwCg6XXXnUeEbIXYdLc4PqVuESMFi0J1dYRKBzzcJqRJ2s
 bnjVTZh4ZkP60bfoY95f3EsCXM7H8vRCStTqQ2RY/dYzuD9VJ2totnfNUKc2HpdPcBjCLse/D7f
 RWzS91izyBCt0QBY9yJ8FRad/Ai+1H/keloKyjiXEzAOp9ugpkg+Wi2nDDF6wVp/cjao4TK8n9w
 2l9xByRXADfS4n5EiMfj50k7BsefZenySN2v69asZCtR6SNIt77jrXVUtSsBoI2irC3FZpJzpeF
 pWo+HUTplrOlGird5Q4U1R/g==
X-Received: by 2002:a05:693c:42c6:b0:369:d793:328d with SMTP id
 5a478bee46e88-36a4242f5cemr6374513eec.31.1793410215331; 
 Fri, 30 Oct 2026 18:30:15 -0700 (PDT)
X-Received: by 2002:a05:693c:42c6:b0:369:d793:328d with SMTP id
 5a478bee46e88-36a4242f5cemr6374475eec.31.1793410214612; 
 Fri, 30 Oct 2026 18:30:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm12170472eec.20.2026.10.30.18.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 18:30:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 11/40] target/hexagon: let a lock owner service interrupts
Date: Fri, 30 Oct 2026 18:29:12 -0700
Message-Id: <20261031012941.339141-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
References: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX66lozXvEatCp
 S0bpiwOM2DMr0RJA9996vqVzdzw96xJSsba1Kjw1NiZTrUflcwgQzZL243/PO+io7AphZrgoS3v
 k7oNuOMtDkcf4ECWIhce5EFTwQPuc2uCNFrREREb7GhynVxQZCi+GcRbEo5XqhG3I7cgOb6Aq8s
 VtsHdxQknssL1sKYh4DDVxWfthnDqbCcAm1p0T+P5VK1GJkrEachNaTj+ZEuaRlVWcpm/3NtJd5
 HCBkpUdrrJ+jy9iT8nSZTG0V1ob1BrIIakOAXAYal59faLadFpMtgDYnQkPDaZp3enHNEm9c6pk
 I8WWB/HkLKmY9DxkjYIkjg5Gxx2HIJN5LIwcruzdb/YKorTUQB16HC9q2RM3BgYOXF73DapX4Z7
 cRGDs1F7a33KdjJG6YTJuVDD7S643v2eplpT5GI1o6ek6X+fS/XRgBu9oEJBvNhj2W0/ChIkjmI
 IcfBnk120cb99ERrRww==
X-Authority-Analysis: v=2.4 cv=CLG/zhrD c=1 sm=1 tr=0 ts=6ae544a8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=9w6wkQ63e6kGElowvuEA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX8bH/08ZXqlTY
 KT5sqNgTuxFZoU7Jq1G1WTZdlc15Syf/7Xn1EIqxEY6Zc7osoN74Zumu1YOph2KCNmJ8mpR3G06
 C0NLXgx716Km9elYHhtafbfONePWTc8=
X-Proofpoint-GUID: iT9rgYVjJAoSasj5EV_7HFtd6Uh7duUx
X-Proofpoint-ORIG-GUID: iT9rgYVjJAoSasj5EV_7HFtd6Uh7duUx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310005
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

aGV4X2lzX3F1YWxpZmllZF9mb3JfaW50KCkgdHJlYXRlZCBldmVyeSB0aHJlYWQgd2hvc2UgazAg
b3IgVExCIGxvY2sgc3RhdGUKd2FzIG5vdCBVTkxPQ0tFRCBhcyB1bmFibGUgdG8gdGFrZSBhbiBp
bnRlcnJ1cHQuCgpCbG9jayBpbnRlcnJ1cHRzIG9ubHkgaW4gV0FJVElORyBhbmQgUVVFVUVELiAg
UHJldmlvdXNseSBhbiBpbnRlcnJ1cHQKdGFyZ2V0ZWQgYXQgdGhlIG93bmVyIG9mIGEgY29udGVu
ZGVkIGxvY2sgd2FzIG5ldmVyIGRlbGl2ZXJlZCwgc28gYSBndWVzdAp3YWl0aW5nIGZvciBpdCBo
dW5nLgoKRml4ZXM6IGM5ZjNmMGU5NTQyNyAoInRhcmdldC9oZXhhZ29uOiB3YWtlIEswIGFuZCBU
TEIgbG9jayB3YWl0ZXJzIikKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNr
LmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJp
YW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1
cHRzLmMgfCA2ICsrKystLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfaW50ZXJydXB0cy5jIGIv
dGFyZ2V0L2hleGFnb24vaGV4X2ludGVycnVwdHMuYwppbmRleCAyNmE1NzRmNzZmMi4uNTRhMWVl
MGZiNTggMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMKKysrIGIv
dGFyZ2V0L2hleGFnb24vaGV4X2ludGVycnVwdHMuYwpAQCAtMjQxLDggKzI0MSwxMCBAQCBzdGF0
aWMgYm9vbCBoZXhfaXNfcXVhbGlmaWVkX2Zvcl9pbnQoQ1BVSGV4YWdvblN0YXRlICplbnYsIGlu
dCBpbnRfbnVtKQogICAgIGJvb2wgc3NyX2llID0gZ2V0X3Nzcl9pZShlbnYpOwogICAgIGJvb2wg
c3NyX2V4ID0gZ2V0X3Nzcl9leChlbnYpOwogICAgIGJvb2wgaW1hc2sgPSBnZXRfaW1hc2tfYml0
KGVudiwgaW50X251bSk7Ci0gICAgYm9vbCBsb2NrX3BlbmRpbmcgPSBlbnYtPmswX2xvY2tfc3Rh
dGUgIT0gSEVYX0xPQ0tfVU5MT0NLRUQgfHwKLSAgICAgICAgICAgICAgICAgICAgICAgIGVudi0+
dGxiX2xvY2tfc3RhdGUgIT0gSEVYX0xPQ0tfVU5MT0NLRUQ7CisgICAgYm9vbCBsb2NrX3BlbmRp
bmcgPSBlbnYtPmswX2xvY2tfc3RhdGUgPT0gSEVYX0xPQ0tfV0FJVElORyB8fAorICAgICAgICAg
ICAgICAgICAgICAgICAgZW52LT5rMF9sb2NrX3N0YXRlID09IEhFWF9MT0NLX1FVRVVFRCB8fAor
ICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50bGJfbG9ja19zdGF0ZSA9PSBIRVhfTE9DS19X
QUlUSU5HIHx8CisgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRsYl9sb2NrX3N0YXRlID09
IEhFWF9MT0NLX1FVRVVFRDsKIAogICAgIHJldHVybiBzeXNjZmdfZ2llICYmICFpYWQgJiYgc3Ny
X2llICYmICFzc3JfZXggJiYgIWltYXNrICYmICFsb2NrX3BlbmRpbmc7CiB9Ci0tIAoyLjM0LjEK
Cg==

