Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25ACCD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXyi-0007et-BY; Thu, 11 Jun 2026 01:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXyc-0007e9-MD
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXyZ-0000iW-Cb
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:14 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GQHn3712084
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jvNSC8poP+qwYtz1xZbovXiJMkmoZCU6yMIg796FAUw=; b=VxrmMZTPJzZIo315
 LFIKW2qsQKEvqJowYFh7tf9azyA6EgqbPPwWKATmi3hqLyv06ndGik+EI6liQV3W
 JYGEdYYWtnRufsNv3vQ8j2qXrQ8hrRAdkVZffOwOaDOJF+FhkrsXRUvzjeFP/qqG
 fT4T9AxZ/ds0nG2KNhSv1iLIkCnsszNk+MERr/QxL6zpQCnpSa0/pN1z5cPVgriO
 HvxJvFt6Mu57NvwejtOezWDFC5suPyk1yaisQyJ06Y3NwwQuvrNrl9rmuG+IpatR
 Bq/grs0XmbKpqAO6u5Wh1Y1C5UyTABQ/spZri8gt7rsE3EbU0Ij9K7PNvrywoh2G
 x/nLbw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u9rf4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:08 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30762d67a64so2872870eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155747; x=1781760547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvNSC8poP+qwYtz1xZbovXiJMkmoZCU6yMIg796FAUw=;
 b=W9PaEn2rKKCClPNvch19pUWCRWa2b69L5XagiqQ5wwS5a2akrYdkDdVKPyHb1MwUnv
 D7HRp0dmeNjZVK1+GPnELhzF3/BKfmUHfe2m4NENQ27QGK7npY02mUr8MUS83bH6un9C
 8jaFtCT8m+sCgxrhmCGnzpFOOd294vHone9Y4eZGZbCqol8RgTREkVm2t64kH0kGOJwx
 SgB/ogvAcq9E6NMfx2lXpKqOJ5MqCWe/9ZAwO+ySa75h4hvpVD5xpan6PFIL2XWYINSf
 09DTxHtIaDsd9PvBbaRntq9wL5SIWTOB6raWt597GBK0zH+lHq2VVa3RFaqxY2TGQL0S
 ezwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155747; x=1781760547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jvNSC8poP+qwYtz1xZbovXiJMkmoZCU6yMIg796FAUw=;
 b=CdFpjtMGjLwjTxZLO3LzsaOv1OUp7fw0RXVPDyrHXoGt5GJWYHKPtj7MFDfV8WtmVY
 UH8vXvb+KNbq7H9inzKsA1clIDPLn5t6VZXwS/OgS6FC2yEeRFv3dLyePulZO3O9iNYe
 +1CEO176sHYW6MMJ4a4681aiJmdj25yTbcHkiLYUMlbiaVwYoDcPIwEIajg7RBGPwvU5
 U0owsjP6AiDV9ZFbU3ufkDYdq5NveIbomgkldS1SVI41I4RCZkCyDOeld6JMRtjsQq8g
 Zt28Tdr7YbDAH6LMfcHC/eWGdUqBnbyexq8ydHyhqwVcCyZ77SKjCbZMYeLyocgBdQoU
 Eylg==
X-Gm-Message-State: AOJu0Yypj9Z+pPyMSki+F7FioAC0DE6sHL3I0IT1mZQxS3lfHaw3qgFP
 SpGVVUZrx+jeK/UVwly1daahU4ps3HTlP45X5Yo4Uq6S1xfv5LaOdP02VrDeyvRzSPwtXunjM4t
 jtflgX1Jnmbz/guLP2KBSeXmfAp0yNAlFaFRgvK8QDn3LJFrsRhRg1yRNB/BANd6N0w==
X-Gm-Gg: Acq92OHO1b6ks4x0s2QiqxG6QXnK7glufGxEu97QU83n93B417CWD3XK0WXZO2uqVaL
 DayWRISSlbB0atwvGl8xQ181NgZLu+lDg1qqNftYTh0YyPe3AqYiIc4nnYIuNJgQRZfw12NzoJ/
 ObH0Okn98iAmkH0LF+ifl4s8Z87bsqITCswaX/3SNt246Or6z0QRFz8R1MdWeKxroR3M0pUUtW6
 x6yHPzlIborq9Rz2foV2Sy3e0AcoTQgN28qAjdfo7Mnj/3thWz/qnaIptCWc1mei8jBxXa9ilkY
 9ap/2B97wyoCO6h8HRcgx6GA5BxuKGwt780Vog1crdqqPSC4bd1gOdgr8kyFQoSN82FQLPirdPs
 Ocuqin8kwdEp7fJoMYYLu8LsejaBjiwMyzMmH0zv6eLOsH1Ggwm2K5FwmdPLRaXNXDe8vQ4++jD
 wbnfHA
X-Received: by 2002:a05:7300:a583:b0:2f5:5907:3a48 with SMTP id
 5a478bee46e88-3080478ae8emr1029563eec.1.1781155747102; 
 Wed, 10 Jun 2026 22:29:07 -0700 (PDT)
X-Received: by 2002:a05:7300:a583:b0:2f5:5907:3a48 with SMTP id
 5a478bee46e88-3080478ae8emr1029542eec.1.1781155746543; 
 Wed, 10 Jun 2026 22:29:06 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v8] docs/system: Add hexagon CPU emulation
Date: Wed, 10 Jun 2026 22:28:23 -0700
Message-Id: <20260611052857.3911981-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MCBTYWx0ZWRfX5wihbQZt+NaJ
 kgHxm2hjqgqR3JwHxNfcWMyRqLKe9rJ05+ntUJDgenaWJOTthQjY1e6fL0szkntz670pldC/wnW
 6bdL/7WWvzd/9RiQ47B3R8iUk7HvfGc=
X-Authority-Analysis: v=2.4 cv=atOCzyZV c=1 sm=1 tr=0 ts=6a2a47a4 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=2pVdXvZyqgCw3DkElpQA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MCBTYWx0ZWRfX6lxF7uPvnz14
 1e+dK+sE+WWFAQBygGhTM5bfBL1daROaCvHb6SSA8IVjrnfyj2flepOiVtmVlboo8uUQDT+govS
 X9vyVNPfAVD3psiXepNH8dzGuQwEidDfEPe16UVm7JWZzZKd/Ifj+8kVgOqOnYnqAHArokKrtcN
 Tq3RW96NA98Vc6BFe9dLNEQa96Vj7KhAWGNw/Kc4rm3O+qPrzEB2RzeYtHgtf7rwLexbtT+dUiw
 yiSqA94MFSTFUewavYsdYviGxPBZCjKBnedeYrj+fAinUBx7RxMZaA9uJa8/iJe2fb49P/79knp
 763kL30A/laLdXQUJNLuukhwoDYqg9lveoNtJvIshjpErhus2eozwQcpaCI8i28VNrIOj7Td0qk
 TFWhfVqN+ESohssFyf1pXT/x2mqWkXa8GzHT1G1Db+xAD8zvAfUbVSaux0ukG617eRJ87kBHyMH
 XRHPdvNq0pLawFxWPzw==
X-Proofpoint-GUID: TrUgmhxpyoG8EyJU0MsHKKbKrPGO0JFu
X-Proofpoint-ORIG-GUID: TrUgmhxpyoG8EyJU0MsHKKbKrPGO0JFu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110050
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

