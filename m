Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82CAC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 23:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whxpo-0001T9-NH; Thu, 09 Jul 2026 19:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1whxpl-0001Sl-Gb
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 19:07:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1whxph-0002J9-TB
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 19:07:09 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HXWml2475466
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 23:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=4SBR1lqBs8mcUCBbCJ78ET
 20G0t5qrXv3IDJ123bz/Y=; b=U+jCeYZ6U9HUFpuwVlaPXwbR8FNB6Fe3tM7Xqy
 TLkbuUs7rDHF1R18IL68V7bZDE+V3NoIHSYV0FhJczw3Ua6YK/aTrRCeACDm6Gpo
 eKfJ7rFokZUWC/eXlv4YXPmAlJC2c9yCxqKa2spGmVEXtPYBjbq2eh570SXlgG/P
 3eLFNyIT3C9pGGOGd79rQiat3/uIQMkt4H+03E4gCo4gzxscqMCf200mpOlBTAL1
 ShvSLJHcK/FzyBGiezlZgXpIcT2zyMzU0yAGLjtJEwpPVlrSm6GPK8TGzjKY+3Zi
 DKjXsfQlScWBh5HTqlOLKbRiNabW3E/aPwCEtIPzVpX8g4lA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5msgwn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:06:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3810e5c5871so674624a91.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783638407; x=1784243207; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4SBR1lqBs8mcUCBbCJ78ET20G0t5qrXv3IDJ123bz/Y=;
 b=MrRunq/MIH2p9TgKTpkIgbLqkrHM+HcH+IadwGq0iH5jsxaXkywgk2Av5gc/N3NIgw
 OKhP8HcueMoTUmdZP7WE1QxvLP+9tRxrav8Re++223txtgsUKNpbucbMuwjhQZSNZ1wD
 bYQPg11FbogMifXhw7EnvUSLKqDZ9rBS5iqGy13a8KW74xV1CO/HIp0E3a/nTSXtnxo3
 x3zQFEV0vPjKjq/MbWsP5dKfWasXNcpUXrB+13jSbc9nk7GPMBqTnUHO4X/zqlTt+l8L
 KE7dw5nQj9liB5GAoiquyVfWlpwF85bdzgYD/9FqO0Cwlj2iwFBPGlPfraZDuR0m0SMh
 wZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783638407; x=1784243207;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4SBR1lqBs8mcUCBbCJ78ET20G0t5qrXv3IDJ123bz/Y=;
 b=FmSx/6P5Yqm/D+mir6z3ify65El0xteVoe5HHDy1xTCEsVlkXggIwDsmd2LZoIzN0f
 axFt/nnGVyyMGo5L1T056peatPecXMvdrCkLEu6mabgB7Gf3Qwu2k7s9S213BQXqB0Op
 pPRg8hwXdXopwG908CGUsmhGhan8JBcnhv9PdxR9s6NqBTi6N190YnkpDlyPl7HFmAn8
 0Aj4ObxXI21WE8qS8PsxNerCApv648HMqFLiuvnzYVq8WC/kDpsZPZyc7e585r4L6P1k
 rHtO0xYqc4X9+t1Wzruo12xipY0yHKtHuwCJufgNobPY3GtcZuCPNae4DBJ07PR6uDMA
 lKjw==
X-Gm-Message-State: AOJu0Yy9Q02+PWF7eEMuIOXwOtwl2ti9P+yOjJwIPaRHX4dWWt3CyQxT
 78/sRWZ70xJk5j1/wOhdetvViGh0AhfL13j/SkEfSQ1n8KPEa7X/OsFTQOOOcSpwRp2y/Lp96fu
 IkQl6PCwlBDNTgO+5D4vDsvjQJMkTQUIV+acecunkzmZEqMh1LMQfH0YZFS9W5lUQIg==
X-Gm-Gg: AfdE7cmO2B2a0pMlVfGOJ5h1Qr+AIp0uciwOHk5qbvTs7/K1PSjUBuHIHDKVpE63wVD
 RSt4d4VrnmxMjGmVYXjM7kPsjBZoJ4DZPQ64aApluy06xQRi52nWWqKznD7wHJqb8+0VbKkdQAb
 ksPUQ4Ggk8qY9YTXlub2xPMvcAvg4ZqeSQT5Tzybpby+vwjHzW263bs5uckzAghe1/55ZiOsjfW
 gkd+rdBqTUpk6cHzND05V+Ll2ETyjDWeZD4FT7uw0J+zNBjuULi7swwwTAxxF9z6K4n0H/kmQJP
 KnL5504/upp1CSrrSZQEcVQv32Q8hn2N8jQcoFY6UXlo2IS/AE3eedpxMec5O3ds/NuQt1i8FTu
 Sn6rrbDqh2NNNKVHHMY25zJWkmqPe8rHjHL5YBHUXp6xkugfarvXY1KJ4PRk=
X-Received: by 2002:a17:90b:560b:b0:381:bc6c:25b9 with SMTP id
 98e67ed59e1d1-38943463158mr8026732a91.31.1783638407528; 
 Thu, 09 Jul 2026 16:06:47 -0700 (PDT)
X-Received: by 2002:a17:90b:560b:b0:381:bc6c:25b9 with SMTP id
 98e67ed59e1d1-38943463158mr8026701a91.31.1783638407010; 
 Thu, 09 Jul 2026 16:06:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31198cb2b99sm15770348eec.26.2026.07.09.16.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 16:06:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 0/2] Fix sreg writes, PC update for system reg TBs
Date: Thu,  9 Jul 2026 16:06:43 -0700
Message-Id: <20260709230645.3033240-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 9okX2YnkS5hAsRW4qGwWdkXcc5pli16Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDIzMCBTYWx0ZWRfXzCaqiQNioZcn
 aScnhpffXpQLlQ2sXCvzpe2YYJW71yiWCj6iBuzHsalaIJEX3VHSmRRiT6JUdMg+PaX73dEGP8w
 e7d81tLJET3w2YgjTlo8xOycoWZxeWk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDIzMCBTYWx0ZWRfX95D4OOrvWcb9
 9nWH0Y9kj1NrQRznKUgC2gpvj1/BBqYKS5Iacg22ymLbXk3/Ho8gwNuHhBZj5nGCZOYyy5YYiLy
 57dt+Q8ddTf1rbnwDFQCyYsqXhugjg4UVV87yGfHL4gxc8ity5FaojiYRSaB4tq8RiCnL9NQQre
 yr+LVj39UW9WUR6OPuUVOAD94xeklAGS9Qktcjg4Le/pSqif/A0WdWKxpd6kRvGOvooXcxZYnMM
 LZpNFTycFABAlIQos3Qm17LydYcnB3PiKpJbQ6xCZdLkcN0UDZ9F5dFgBzJdCu7OFcGZ+3NpPIB
 J0yBPl+dOZJXlAHw6WAUgdiH86V/DMRS0Z9Tx1MZ+OpEVeJowd2bU2D2OIAgCeC1y4wOHlM+Zz5
 fW+q8GczH0+8MucPVNkjwEjxd0+wLOfjjd6OhOew3CoYQhOQBWTqH46M7nO1nTAqpwoIfGD2ibR
 oFphr6j35SfDAcPkrwg==
X-Proofpoint-GUID: 9okX2YnkS5hAsRW4qGwWdkXcc5pli16Q
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a502988 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pjQKGqkI82RaSgu8fYIA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090230
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

V2hpbGUgcHJlcGFyaW5nIGwydmljIGRldmljZSBpbXBsZW1lbnRhdGlvbiwgSSBmb3VuZCBhIGNv
dXBsZSBvZiBidWdzCnRoYXQgd2VyZSBwcmV2ZW50aW5nIHRob3NlIHRlc3RzIGZyb20gd29ya2lu
Zy4KCkJyaWFuIENhaW4gKDIpOgogIHRhcmdldC9oZXhhZ29uOiBpbml0aWFsaXplIGRlZmVycmVk
IHNyZWctd3JpdGUgdGVtcHMgdG8gY3VycmVudCB2YWx1ZQogIHRhcmdldC9oZXhhZ29uOiBmaXgg
UEMgbm90IGFkdmFuY2luZyBmb3Igbm9uLUNPRiBUQi1lbmRpbmcgcGFja2V0cwoKIHRhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5oIHwgIDMgKysKIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jICAgIHwg
MTQgKysrKysrKystLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCA1NiArKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNlcnRp
b25zKCspLCAyMSBkZWxldGlvbnMoLSkKCi0tIAoyLjM0LjEKCg==

