Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE78FCDB466
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiBH-0001Yu-3d; Fri, 19 Jun 2026 18:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBF-0001Yi-UR
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBE-0001U1-6G
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:21 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYQ3w1337250
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jvNSC8poP+qwYtz1xZbovXiJMkmoZCU6yMIg796FAUw=; b=kh1wpF3WWhCoHCHg
 Rr0AGLpQvTob3NFn6Y3supUJVTOoqAGz4vSf12XWGY/iCBRSaqYgXhub6rQBf2ia
 5RHiBauHUYRdrG2bsPZ9amqalRzywr2jFGyaskxCc4czD2tUXoaeRpWhRXp7exmv
 1uHTTbhHOsEpZ2sxDui1r8YU5JqXM4ljNgl2qxxZi4DBkA5g7/oazK5pci7U70xO
 cGGVa8ujL3GwQP7XtsiVpgFNiXZHdrS9yRc9ef4VV3AyfGPUUB1ItkLfg6maoOCW
 hBGI+SZn9V9bokpVgcFQc7JSKSD9PL4SzRoS15x1Uvgz3SjXNruZn51JbxSAuPWG
 8eL5nQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp67554g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c04cfaaf2so5435490eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 15:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781909958; x=1782514758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvNSC8poP+qwYtz1xZbovXiJMkmoZCU6yMIg796FAUw=;
 b=FwXnDqzCJPBpZYBjXH+TNaf/rALDZPLuR22o7PqQUc777RNmjg6j1UdODPLkA+40jL
 vyv0527IiFdb6CrSTigeto6tPfk++GU1WtCsx8AHPS4bQrSMzBLz8mfh/SUk4Hc96q4k
 LOvCGmWYvibuu42MZ96MGA0ul+xzRJMRljoCAwzTJQASaPfTXT57acVaAZ6mDuOtBgYY
 yfjNARxeZyxLmbbhDbHPSUsaBjETm5tPkp+/r53567aVPUYy9t8A+0Y8HmsE6vSpH19n
 ZZuqpLCh3nKCThYgrp7ngHr/ZPYDvHRj3OGXwIE7eDB622r2ATG+RqioVUJ6MB9fps0h
 j2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781909958; x=1782514758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jvNSC8poP+qwYtz1xZbovXiJMkmoZCU6yMIg796FAUw=;
 b=m6x/KD4kBJvGtyASqrE22XIRoRJ/y8va4oBiCOI4iZNywZcQIgcU5ztdNx7wUFkrfz
 ZRVmiQPaLMdGvfoaDGWNR7N46lqGDjdwh2ttwGWu6qBelsx9TP77G9kZ5k8wIM5bb5f5
 yvrHePAu8ocMTDLHlriUCjMLC3HtesLTU19JZBKd9Cg9P2lSSZ22qJu6+7qhl4HqeM+7
 yWBGKMNEuciWEJ8d4GQIJ9zTN2PtGj6wrL9S2sxCpwqTXrNRqHWnadsirM8G+zG1ASYL
 scvJ/K98tr8Aen7Xh8WMdZbg1ols0UNM6gwFxqOsIUJHfGTNrGo10Bh56Y3ossbFe00I
 JEaA==
X-Gm-Message-State: AOJu0Yx/d14V4uArqc1fIo1oPVfvVgZ35vh8WQNQHzGlr8RvnW28Pm6I
 6YsRSpxSMO1iGpXBZmk8wcNWnvi/XLjTtxNjqdrX1cBVGBveciy0R1d7wh8s7narLVLP75qsUbZ
 2DY1N/o5aIEZuWzVKgw0KBiW/FsB7ylKHpMsGqIsfOJuzKzGX++CTb9Nys+JDhGL/4w==
X-Gm-Gg: AfdE7ckDkAkNBR4QQRibSX0SYucH4zQofm1KmlZUGtxyMA0kTx6QLVWCyX/8vKG51MW
 ng7MdaCBcz9I14G5Fy1AW2Y4ZMBVMUltngAzdKumO4WLyfSFEMqGChpQ9zI/lUah/OS7xRsvQce
 Q1zQKkC+EkH+pXd5LeSBJRRnL7+Nx8jm0y/khGKydvhYKHerG4j1wcsyxthkOow5z7n2sgKHXKp
 o5C6zZ1omLmJB4ZWvuJBoZjVrOQ5zAH/ufC7Qy4HisOfZ77kJQMn9d37MMJA6Urgowuxu52F9u2
 E6R208PftyulEhSE9IsAS1N/4dpfQ9rR1sSDz7Qg4XGtMdBN3bCoerFQLsNMGcCAAYgFmCPDTey
 u7W7MYswWV8qcke2M1gzkrT9js6PaI0gIH11lee0G9MHbxdX5z3b4GqTKDRw=
X-Received: by 2002:a05:7301:38a4:b0:2f1:496c:94bf with SMTP id
 5a478bee46e88-30c0711f426mr3491802eec.16.1781909958133; 
 Fri, 19 Jun 2026 15:59:18 -0700 (PDT)
X-Received: by 2002:a05:7301:38a4:b0:2f1:496c:94bf with SMTP id
 5a478bee46e88-30c0711f426mr3491789eec.16.1781909957666; 
 Fri, 19 Jun 2026 15:59:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 02/74] docs/system: Add hexagon CPU emulation
Date: Fri, 19 Jun 2026 15:57:59 -0700
Message-Id: <20260619225911.159473-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: zPazZBEuRrCwSGl8_hBbswDbjZN2yRhJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfXwY/juZ8PIPQS
 gVtjnJG5qj3hmKed2Q5fpCSNA9AIk9PBSwky/fCmdx/wGqKXp52XGkn1OMJTs4qi6O3SN67h3Qe
 3WbCy5WzJ3GSWEcWUIlWaUPpoQIBVnGponTaRiZ2jv1HPPrp/sx/1z3mfg7gMi0PXla7+1s4T8b
 nvNPWsl6CH/9FRGMI+5nx/y3E5zCoDKueznEBLDG41YUGR26tn4jZ0AdbuKDFvdwL6G/980Bv/i
 qMrNmHTeiFRTdYVi36WEru9d7ccPL0cBYOYsuwZW/o+rku0sI/YNsnJkC7QdRJoQjS6vjUYqX1T
 sUGXoVHNb8LBtNxaVcaTKOE+C4Juh4XrwEswlDkZZWEvPxPgGF04KdwaTuH7kIvGKA1PkIPQHCQ
 9UxscAytfacxEUV38vcCNXepnzT27pvyEk+SGA+V7fRfKU0tOmeTOgtnBoPP8A4kFJWnMzyF5Nb
 LlDar4vsv+oes2djQAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX092KZnkpKC99
 ta3RqNo4MfxtdkyIiZXPQbe7ngXLX9bMPU+Bj+o4jAnGDqng/LkHwRxsCbGfBDc2AC6ZUKES3o2
 uCgVJJw5bQWiaFd1goMy/ZhN/NizC5Q=
X-Proofpoint-GUID: zPazZBEuRrCwSGl8_hBbswDbjZN2yRhJ
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a35c9c6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=2pVdXvZyqgCw3DkElpQA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190221
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGRvY3Mvc3lzdGVtL2hleGFn
b24vZW11bGF0aW9uLnJzdCB8IDE1ICsrKysrKysrKysrKysrKwogZG9jcy9zeXN0ZW0vdGFyZ2V0
LWhleGFnb24ucnN0ICAgIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
CiBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0Cgpk
aWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0IGIvZG9jcy9zeXN0
ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAw
MDAwMDAwLi4zNmY1NGYwNThhZgotLS0gL2Rldi9udWxsCisrKyBiL2RvY3Mvc3lzdGVtL2hleGFn
b24vZW11bGF0aW9uLnJzdApAQCAtMCwwICsxLDE1IEBACisuLiBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vci1sYXRlcgorCisuLiBfSGV4YWdvbiBFbXVsYXRpb246CisKK0hleGFn
b24gQ1BVIGFyY2hpdGVjdHVyZSBzdXBwb3J0Cis9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQorCitRRU1VJ3MgVENHIGVtdWxhdGlvbiBpbmNsdWRlcyBzdXBwb3J0IGZvciB2NjUsIHY2
NiwgdjY3LCB2NjgsIHY2OSwgdjcxLCB2NzMuCitJdCBhbHNvIGhhcyBzdXBwb3J0IGZvciB0aGUg
Zm9sbG93aW5nIGFyY2hpdGVjdHVyZSBleHRlbnNpb25zOgorCistIEhWWCAoSGV4YWdvbiBWZWN0
b3IgZVh0ZW5zaW9ucykKKworRm9yIGluZm9ybWF0aW9uIG9uIHRoZSBzcGVjaWZpY3Mgb2YgdGhl
IEhWWCBleHRlbnNpb24sIHBsZWFzZSByZWZlcgordG8gdGhlIGBRdWFsY29tbSBIZXhhZ29uIFY3
MyBIVlggUHJvZ3JhbW1lcidzIFJlZmVyZW5jZSBNYW51YWwKKzxodHRwczovL2RvY3MucXVhbGNv
bW0uY29tL2J1bmRsZS9wdWJsaWNyZXNvdXJjZS84MC1OMjA0MC01My5wZGY+YF8uCmRpZmYgLS1n
aXQgYS9kb2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QgYi9kb2NzL3N5c3RlbS90YXJnZXQt
aGV4YWdvbi5yc3QKaW5kZXggNWY3MDg0YTZhMDguLjQxNmI4ZjdiZTc2IDEwMDY0NAotLS0gYS9k
b2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QKKysrIGIvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhl
eGFnb24ucnN0CkBAIC05OCw1ICs5OCw2IEBAIGlzIG5vdCB5ZXQgaW1wbGVtZW50ZWQgaW4gUUVN
VSBoZXhhZ29uLgogSGV4YWdvbiBGZWF0dXJlcwogPT09PT09PT09PT09PT09PQogLi4gdG9jdHJl
ZTo6CisgICBoZXhhZ29uL2VtdWxhdGlvbgogICAgaGV4YWdvbi9jZHNwCiAKLS0gCjIuMzQuMQoK

