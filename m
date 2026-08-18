Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC8EC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQSc-0006Ew-Lb; Tue, 18 Aug 2026 16:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwQSa-0006Ea-JY
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:31:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwQSY-0003ob-Re
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:31:00 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJZa0P1816671
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 20:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=1pZAZayj+s4
 dYb1o86I+DYMowJ9AIb3YEITJW7ZsofY=; b=efMYaqqrisUZY1fMBymp8EQ5U7D
 ltj5RuFGDbSMk0KxjNpHCaIbxnuHuiISbibZmCagxGdBh+Cl9S/0IFlwJxDbgyXC
 zE7hfUpNd3XCV2tC/q4+1CztFy6kYgSQv0tfpClki9gypYYTJ56XRXB32lfce6aA
 msosIjeHJ/8o+SWj3A7y0M9ygXMMvA/99svIM5LD5zp3pVAY++1d4rViaPnXapE1
 7gfnKSBVuW9SVPktsvDu4R4zonwP9ydlUiAf+aeKlzCXJAKlIKoneYLJsWnOKMik
 RGsjthjJAOc9hPyb2Xu73PfRe5B0hAKMMbgitp4iRqkjNsI8amIO5fahJew==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4uab0xcp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 20:30:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38fa7b09921so502031a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787085050; x=1787689850; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1pZAZayj+s4dYb1o86I+DYMowJ9AIb3YEITJW7ZsofY=;
 b=BGbG511O6czR/WS5paoDzDFYGveevOcIci2CjTzAal+P8a3fdsCsvsW13loujqRhtt
 qpwrajWS8//9C6CgzhBGAQ0FNG8rQkBVWxxetXBWd9Ane3c/whWyfW92LlViZzen4xo4
 BQGqyZ6rTOdW05ruBbMx2EaUYuEQKLDpyX95pLmv/TpnpdDhAzlDtsQrFPgdwfOPYCiN
 rhDoVsv/il5Qdc8KSZO5VqcNgpehBqZEzI9qewc/wsAzXKz5u3rXc9EUtpOBM84VEce9
 ikS4oXio5Ne8T3R89vq4WcEicdprNkN1RIiglokVAolvfc8uzIwFvCxzplX+kNPSIBzp
 RDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787085050; x=1787689850;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1pZAZayj+s4dYb1o86I+DYMowJ9AIb3YEITJW7ZsofY=;
 b=ql16+lZ2ocdT2RtG/PVs7Hr9tqhQP6MqJI7BS3UQcBGJvJIw6ZXsdjfQhKsmfPb5E5
 WhrMTZQ1jPcIwaLN+YHMJSt6IqC01OMrI/Uh4HgocaR68o68NxUzAFzRsMyBEI4fdqtJ
 +gl7r7jLtxbp9fCbAn9FVYdj37EBgQHcA9sNvj8/cZ7OVO5oRp/nEgIcDC4u+NIVth62
 BTXFhjPM3ELQDHw1hO+Zync2zAV8k+/ad90kjyvqVyA7eB9fzHRObPgzT/paFwbDIMx1
 Rigbg4FNMjpTUWNt9I57GT7AeQplFlS5WQh+P2C7M6MoOfHswoU2k6nXl6aYmtNNnkJB
 978w==
X-Gm-Message-State: AOJu0Yx1wArK3UvwFf/jV67tAjhEiFICtMCNrnr33xAjrbMi3li7bzLL
 vPGHSZ/HMF+BQJFEtnGkmoyO2WN9oaEB5Zei5bX4zxXPq61N+Z3JuyM8i+l74GXwTmTFehlGAQn
 Bf5ICBinkootVLCNzu/qgmyE0ojs7axCqKDROmEK6BDdrUtCd0n4nm5rAxajvD+cCxg==
X-Gm-Gg: AR+sD10ga7nqv6/ttvAS+njv5Jic9+MkFxc9bA7JXfkWgKGQExt3y+8+yFgjWoh9vQf
 nxzvhF5q4A3sCDtNZiCZbTf5PSxjbn7Y4CaEJsaNaLEBjdi0NmQ7lDKIoX9NDMO5iw/NxtG8+sI
 zm9LLtyR0a9lLTzsYrfdKmb2KCT6ZXqPDh1uB01DFjZtzJlPNbBVVciQ1TEwRn5YCl0emm5eco2
 WBNN2wzyKIxXP0hSwa3WOjI3+MdKazqPq5d/akGZnCwOHr238bOFlafH22uPXvFWuFKv/DiHV7V
 Vws9wo6eckROGtiWBMroRCKsiR3DGaEvAGUtyR+C9eWn1tAJNHK1PWJYSjynOQiqrmk12UJeQ9l
 d3alS0XpMbqZH3+7nyUnkbb/MPnsfRwPmYxgWYapptKuRzrT/
X-Received: by 2002:a17:90b:3b8a:b0:38f:2168:b9cb with SMTP id
 98e67ed59e1d1-3957b0a67b1mr761111a91.9.1787085050112; 
 Tue, 18 Aug 2026 13:30:50 -0700 (PDT)
X-Received: by 2002:a17:90b:3b8a:b0:38f:2168:b9cb with SMTP id
 98e67ed59e1d1-3957b0a67b1mr761027a91.9.1787085049554; 
 Tue, 18 Aug 2026 13:30:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326793ca665sm21648507eec.8.2026.08.18.13.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 13:30:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, marcandre.lureau@redhat.com, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2] target/hexagon: Add HMP info tlb command
Date: Tue, 18 Aug 2026 13:30:47 -0700
Message-Id: <20260818203047.2933487-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX7+rz4nEti8U+
 rKBBefgrw7zcQH4lRnF2v7OUrDLpjX0pvn7SpvajHlbSkLYj24xPPRjf9/M2j5kJu/5IRSvtNd6
 UY4QBvWnJHnEBpH1UhR3GrScY0uOqq/9ZU3knmDA8ycoKBNhmw+V6SrZ1Zs+V1jFHXf035P7CE5
 eqswFO59gu9lJDhQYfjMT+q1y5ZM9Q/hvy5S7tREKL2bdRCnTrYN09GEVbxayDJeMKui1RUJu6T
 sxKn27KY7QnXQ6HcK/A+ty4lk+W8LoylsgQox/daL1JShw19etlwTAvKBn2O1eyjNYjdFqvbdRi
 k/5uGKs0j3xn3rSgJruLGVj4iCVd4WaXrqJpdTgqMAi57bbTStn0gZtD9TdHq9PrxYJb+27STR1
 es/rPfMNOACrAb1uFuCbX8L7ttNmeUr5oWVaE2mr/NjhD5khIxnD2k9L1HEw/Z1GhLJ/capLvX4
 +oWEPAHHvyXJXmb7ryw==
X-Authority-Analysis: v=2.4 cv=BvitB4X5 c=1 sm=1 tr=0 ts=6a84c0fb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=zLB2xiUhYuC1DvRIj0MA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: FhVIT4EKRVACNPtdAltgH-qnNexroDBe
X-Proofpoint-GUID: FhVIT4EKRVACNPtdAltgH-qnNexroDBe
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX4EEvv9Txv4pg
 +fJ7r48vdAfoiEqbPRwrrd1FjnpuoyYZaVMnLvkI95eJapIq3Sk7zka00gVgWESY05vAKEN8Puv
 WRQJo/W2dqWucOFkOl85S7YdRl9gPAk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180150
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

UmV2aWV3ZWQtYnk6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQu
Y29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5j
b20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaG1wLWNtZHMuYyAgfCAyMyArKysrKysrKysrKysrKysr
KysrKysrKwogaG1wLWNvbW1hbmRzLWluZm8uaHggICAgICAgfCAgMyArKy0KIHRhcmdldC9oZXhh
Z29uL21lc29uLmJ1aWxkIHwgIDEgKwogMyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vaG1wLWNt
ZHMuYwoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2htcC1jbWRzLmMgYi90YXJnZXQvaGV4
YWdvbi9obXAtY21kcy5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi4x
NTAwNDU3NjljYwotLS0gL2Rldi9udWxsCisrKyBiL3RhcmdldC9oZXhhZ29uL2htcC1jbWRzLmMK
QEAgLTAsMCArMSwyMyBAQAorLyoKKyAqIENvcHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9n
aWVzLCBJbmMuIGFuZC9vciBpdHMgc3Vic2lkaWFyaWVzLgorICoKKyAqIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKworI2luY2x1ZGUgInFlbXUvb3NkZXAu
aCIKKyNpbmNsdWRlICJjcHUuaCIKKyNpbmNsdWRlICJoZXhfbW11LmgiCisjaW5jbHVkZSAibW9u
aXRvci9obXAuaCIKKyNpbmNsdWRlICJtb25pdG9yL21vbml0b3IuaCIKKwordm9pZCBobXBfaW5m
b190bGIoTW9uaXRvciAqbW9uLCBjb25zdCBRRGljdCAqcWRpY3QpCit7CisgICAgQ1BVQXJjaFN0
YXRlICplbnYgPSBtb25fZ2V0X2NwdV9lbnYobW9uKTsKKworICAgIGlmICghZW52KSB7CisgICAg
ICAgIG1vbml0b3JfcHJpbnRmKG1vbiwgIk5vIENQVSBhdmFpbGFibGVcbiIpOworICAgICAgICBy
ZXR1cm47CisgICAgfQorCisgICAgZHVtcF9tbXUobW9uLCBlbnYpOworfQpkaWZmIC0tZ2l0IGEv
aG1wLWNvbW1hbmRzLWluZm8uaHggYi9obXAtY29tbWFuZHMtaW5mby5oeAppbmRleCA4MjEzNGVi
NmMyMS4uMGQzMWZiOGE4NGMgMTAwNjQ0Ci0tLSBhL2htcC1jb21tYW5kcy1pbmZvLmh4CisrKyBi
L2htcC1jb21tYW5kcy1pbmZvLmh4CkBAIC0xOTMsNyArMTkzLDggQEAgRVJTVAogICAgICAgICAu
aGVscCAgICAgICA9ICJzaG93IHZpcnR1YWwgdG8gcGh5c2ljYWwgbWVtb3J5IG1hcHBpbmdzIiwK
ICAgICAgICAgLmNtZCAgICAgICAgPSBobXBfaW5mb190bGIsCiAgICAgICAgIC5hcmNoX2JpdG1h
c2sgPSBRRU1VX0FSQ0hfSTM4NiB8IFFFTVVfQVJDSF9TSDQgfCBRRU1VX0FSQ0hfU1BBUkMgXAot
ICAgICAgICAgICAgICAgICAgICAgICAgfCBRRU1VX0FSQ0hfUFBDIHwgUUVNVV9BUkNIX1hURU5T
QSB8IFFFTVVfQVJDSF9NNjhLLAorICAgICAgICAgICAgICAgICAgICAgICAgfCBRRU1VX0FSQ0hf
UFBDIHwgUUVNVV9BUkNIX1hURU5TQSB8IFFFTVVfQVJDSF9NNjhLIFwKKyAgICAgICAgICAgICAg
ICAgICAgICAgIHwgUUVNVV9BUkNIX0hFWEFHT04sCiAgICAgfSwKIAogU1JTVApkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQgYi90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWls
ZAppbmRleCA0YzkyMWVlZTczYi4uNTNjNTAwNTIyYTggMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL21lc29uLmJ1aWxkCisrKyBiL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkCkBAIC0yNjEs
NiArMjYxLDcgQEAgaGV4YWdvbl9zb2Z0bW11X3NzLmFkZChmaWxlcygKICAgICAnaGV4X2ludGVy
cnVwdHMuYycsCiAgICAgJ2hleHN3aS5jJywKICAgICAnbWFjaGluZS5jJywKKyAgICAnaG1wLWNt
ZHMuYycsCiApKQogCiAjCi0tIAoyLjM0LjEKCg==

