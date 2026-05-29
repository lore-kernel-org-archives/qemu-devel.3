Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A24CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5BX-0003Cd-RZ; Fri, 29 May 2026 17:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5BU-0003BQ-W8
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5BT-0000KQ-0X
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:04 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2M002998061
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jvNSC8poP+qwYtz1xZbovXiJMkmoZCU6yMIg796FAUw=; b=J7oScxrMcLuRPM5D
 7dUCQ7kq7WDzlcsW5hPN9Hwhwgv0pURLzHwsHaDr7flUVBnj3/kdlwpuYn3WpKVv
 JKY7tZVSXLQYSrT/7R3B8t/FHW1HuVsr6VLiTbqaiA2ngSy6IqpHXqyyTLdSS9Hb
 iI5f6WVG+P+QbaQ3yvBdQhLzF0aEe1xkC0hBYNn8vD0VvM3XdfdU889XTh4tLUOM
 nHneB/dqcbfCn9ueO1KzbEwZ5/c5/yho7Q7fn4msYEAkB16UlvHMGCtuSqUph8p0
 TpMq5f/NQwlhQHVvy53ktJji8JLJcr8RUh7Zg6xBD1SdqBhHFO6AqL0I0fqwVsap
 Kb8V8w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj4ejg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304ee7d1368so934889eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091761; x=1780696561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvNSC8poP+qwYtz1xZbovXiJMkmoZCU6yMIg796FAUw=;
 b=kM0C5DqOaGOm3RwCWsJ4OyqWTBGWKFJOSz8UxbpMm+9bAE66VjMl+y0k7GdjSWPLm+
 Wsi6GTVHz4KnguE0Fp5GkwPxvofFfI0k2GMlB+YCfO6ZEMy5C2d1XqvKFYYkCEeVmhKw
 pZWwuFr2izUxH9om6mZgIpIzCkHI0G6pejO8wDAVKwtPkWHzeVlOm7bLQh4egOw4jJ4x
 Hss6RvXzo6M57o3YLw3v5Him71EITorqERi7U0ApzStL51qt6Bg8wUJjVBd57GEX42TT
 Kh5LYYoSxaSUluAQaGOxbEHI8PszDjkL81ymXbW2YwkwnudsNrBn6hVpxWgp2bAlI732
 xnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091761; x=1780696561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jvNSC8poP+qwYtz1xZbovXiJMkmoZCU6yMIg796FAUw=;
 b=iVXseHwd3HGr0BBOTLuE7yP1WhiRUKwzq5X1s6pBae+jXkg4YGL7a9c+KyRJIi8Di8
 DJw1Ts83wpTwrGL9l0dKWUZkmcTwq2rggI0jKwRsHos73v5zd+kyahkzU6qERL3RXPsS
 vhK06IkLAlKpMMHSRML8cxXnT+qG9YtDmahyePAIlO+K7nbK20uYd4E61xSYP3FbsYAY
 GRXoKFDFQR61NYs5YeKIi5iJD8075/bjr4e/hFCT8FDSVmF+2lMF68EDFMpEBYTxPkTl
 qJdUFrVTnzFcLoEZN6zJPnzXMx8LVdP+kP/IyYu9E5PXBdnW8WBjsbBaSqcWVjjSlGxG
 A8vQ==
X-Gm-Message-State: AOJu0Yym0Dsl2o01JhYwfBwFk5U3ki+0AijApQUHY6wUqqxh43PowgOS
 WnhL1zliF34Xygq3npoEYAJgEWoZIm5PUfDFvVDhdEUJUNa/3z17JwItR3nOT/YrDVHNAJjKbSK
 0dr2bg8SeuyKvYa9tJtnzudYPXlQ9xvakarj/fbmneMh5hXgqx1Kad2dc1Ig2ZZbPsg==
X-Gm-Gg: Acq92OEh2xApo3WWDsHbViHkA+hoGZUdggZJ2zk6HT1S2QIaSSt2dpmfaizLngojwAV
 OkEFJjcGNuCq1mGr8ns3PqCiZN9bhAlgz3CW7lz1AVtZ7lhrM9S2GE7vhG0xpp77yJV/+TIAgLR
 M0Zl46asKzPuJCtrhhj3pSVxa/lg+PgSB5/hgwTmINR/gD+BvgLE+uXnSFEYjBNTk/Gg+UJlMcF
 q8oQQbTc20KvPdYkfPNpOpJ4Mnk4FxKpbjvioKYpkE9RNaQMT4zKs+Y5kuNrbTN3R8qt6A6lXl+
 45pu2lGINN3jgFjFlU5+7gXpKg9B1/C3M9WIUdrcDTRa7ghwEF4chyF843XMIefBh3JJgwitMmj
 u19NxsBOJlz2jASyJ362x1IhROpul7rF/wYjpRtsOhSjfBYV8feUVjrAraitX8CCJ/GvFLhPNs3
 rd3gqC
X-Received: by 2002:a05:693c:3006:b0:304:d388:c33e with SMTP id
 5a478bee46e88-304fa4a7fd1mr1174783eec.1.1780091761046; 
 Fri, 29 May 2026 14:56:01 -0700 (PDT)
X-Received: by 2002:a05:693c:3006:b0:304:d388:c33e with SMTP id
 5a478bee46e88-304fa4a7fd1mr1174768eec.1.1780091760505; 
 Fri, 29 May 2026 14:56:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:55:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 02/38] docs/system: Add hexagon CPU emulation
Date: Fri, 29 May 2026 14:55:18 -0700
Message-Id: <20260529215554.606133-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOCBTYWx0ZWRfXylKktDxNdm7Z
 G9QefiynIAWkuoJZsN7DbiaKD4SGzg5pylL94p6U2FLS/Ym2JNXr/YXY/U09/IMqfHocJXG0Eg9
 4XfGa6RRjUo2Jkerzce5vTj+QGAntoMwKCxpMduKBL8sV8qagSZVxmlcTwhZK79LA/S857T2uAm
 yLVKUEBGskNU1sFUKbCLzqFVltfPHLpHWRm8Sk6UPF6Lk+LZ+1qCfHwH7Wdzt/R56KqKaH7wDRg
 I0rQvcTuL5lkJJYFm0eEUMKBWP8QxebPouoIhl+LUOTMlZJFRbgcri7LcjXQpn1fPJUSsN9YuSK
 U9Q1VL9stNJgLfb+L7PjHtMXLwRZ/fpdQ+tb3Ibgyu0RCK0MoJ1FVo1cBEWoyJlORgvYYd0wH02
 qgmWV46DWlqBK2eOWPdPmEOPVhhJxR7eQW5KHCooXucrq6xk7anAlweOrXNeZ0ZD5d/Nf9RI0ke
 xV+Pc/+CcE2dReopmnQ==
X-Proofpoint-ORIG-GUID: jCc-oVf4vD8zAwOyOyOWfCI89H1BJZO4
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a1a0b72 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=2pVdXvZyqgCw3DkElpQA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: jCc-oVf4vD8zAwOyOyOWfCI89H1BJZO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290218
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

