Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77855CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclO9-0003JW-Pi; Thu, 25 Jun 2026 10:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclO1-0002sV-7k
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:49:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNx-0000BL-Sy
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:49:00 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9k0fE1920626
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1ECOxl3Fg5yOtnmQVv6BfaD55uXykPkSbZivFHhIDWY=; b=VPmvcvONjRr/u1zm
 TN88AhDHbE1zI82losrCgnETbFjL3Ylh5jgynb/FnNSI/NDvwTKsNrvxpbkE/nYf
 YLUZbj9yPiwzcBMSosIjz6hJzqA1YSnuoKOZBvIkXAh0KdOnEgEVv/rSjYVy7yu1
 p4Ax25dHI9wOVmqC0In1kYUkq0t6E3caurrmuzWAOGKDAWUCmwdtvUubeUMiLMAZ
 9qdmLR9mLQxs/o8GmXPSR86iZ/OSCqMCjRnhVJ0TEgczxuA/yResF3WwiD+DpANt
 kSdr0zwTm+oTp21PRoJ4oT5nNlRpC5y0S1AB1idFSMPWDerMtMKqsSz2XR83h03E
 SHTEqw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ueuaqnd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c17bc96afso5088932eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398926; x=1783003726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ECOxl3Fg5yOtnmQVv6BfaD55uXykPkSbZivFHhIDWY=;
 b=BvYfhjMD6RyvRSidSBqHFEu/G+OmaGx6D9caBBetOgCDtFrsdEo4i9WElH/HgZ+RYq
 j7dGIuL4E5d0MFxBqmQwAQbX9oWc+QMrI9uAArW5/FyKVwE3BrdE3seZEl9B4N6ozWnK
 zc3dJvnxHhyYFhsmRwTqbMTUXGHLHFGuKg4WDNYDFBgtXWwckEAtGcKw6Lyxt/ON749y
 3q5IIXjGReFIpFXSdkT5kbDYlPXCxqIY9rvEOQz66u1tG/KhG5mJ/luHkQfg1Ir3n2VO
 yIiiWgMRfpYDliYe8KhAcgMCBVGDM7v5ojJHUi165ynXto8O2iEemd4WQpDAEEI9bxzu
 1mBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398926; x=1783003726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ECOxl3Fg5yOtnmQVv6BfaD55uXykPkSbZivFHhIDWY=;
 b=Aa7KRHh99qfwiI8tIXrUbkm2CoFOD9FruHfTQuivdxdNsogibxpuLKdrRKoE62T3/B
 g7PXkQRpwKyjWAdAIUmZonqrOeJvwqdiigTNTd6i8NJtGh4iP7R5pq8FptK1ftoCTDEr
 8WE461uH5fTv1O6dKyRUa51C2mmjZDwfvU1ig03YekOBIQvbsC78/7DfZvEvPetWwPZ0
 bq2Y16faitCGDxZIPu3cjcKB8D3vEEC2G1Mn8cLJdo505d1l5PjV6KPRRIWAp3PFLLWa
 AHXRr/oTHd3K5rZRGWDtaKQzfCaDSuB/M2BOqOggxq39BfMh6Ng/ojWyOZXCPaPiZbjS
 81Eg==
X-Gm-Message-State: AOJu0Ywg90HUf8fsQU6q/MyuEThzQEaEUUdWQMK0eApjYx7Foqjqi1cA
 y1opWp/Rzz03VEukFB6Z7M5NFJSveQSew75ytHiEFZfpW5WrjAMXdbyXEb60tobmJpavJTeKq1c
 HPyvEPLBJzn5dhyWRB6XISRSVqy22q65gFWBam4KizlkNQpmonw8MZ/SxwJl0vjZHWQ==
X-Gm-Gg: AfdE7cl3bkZoZGGjqU5i0ccOePGSU0NoqCQzmNF9bEOOGmuzsJRjRwwrM3svs3vxz9Z
 08eBhZGbCHZuVYlggAe5blf9+fCmXvPE3uBU6e33YFovANXHtNBKt36D49os9WXtJ7j3jtZiNPO
 43uw8XuJz05/igPjCps4tkYWS+lhg9MpTKd4gunCpATZInF2Ex5/ma1Tjc/ebxJMgITUJ51aNjO
 B6ek07t2jbu9O03tMr7k7gFsFxMR+F+jqCey3k+KjvsaOd7Zxpy4ZntRcgioaVxBW1gKCxLyq/K
 yuzqQDGTeJs/SXgIy1LczH4wZmkryfSam+3rhu6p+974fnMfbp7C8/8DYfcqH3QOA+kHiWuCO0G
 EvdF7wknPdwB2eZAfkwnXowmUtyHEbEGw+Y95XJxpZ1OKr0gO/ixwHbk1V9k=
X-Received: by 2002:a05:693c:2297:b0:30c:4832:1ac4 with SMTP id
 5a478bee46e88-30c84d0f0c7mr3474553eec.22.1782398925556; 
 Thu, 25 Jun 2026 07:48:45 -0700 (PDT)
X-Received: by 2002:a05:693c:2297:b0:30c:4832:1ac4 with SMTP id
 5a478bee46e88-30c84d0f0c7mr3474514eec.22.1782398925053; 
 Thu, 25 Jun 2026 07:48:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:44 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 65/76] target/hexagon: Add TCG overrides for transfer insts
Date: Thu, 25 Jun 2026 07:16:22 -0700
Message-Id: <20260625141633.449487-66-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: InvW5kvySlBI6zgLz07KD_Hap8b9tZwE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX0u4qpwfSR/FN
 K/Hs6bCBXkGEfAJfJAe4Y6bPgj9SWE+7O9tWf/2ZDjQq+tcCoNqhIKbB79g9De4U7NNhm3xcaEQ
 sharVFxGALed2aFFdR2fDwaS/eOrNvk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX/NMpzOoyxyv8
 o0l4VlWt+rOgUU+En8vrBZCyluurb8kMRilX+2yZsB51hJK5L6S65Po7cfFhuLAWuuSCg33gpjG
 5LZnrmuPkISud5zte1A2KhThNX/dKoePhBuLnpE8nXe1w0lXXENEZ9bptOoOVPsXN6WYJHlylhA
 xWiOfktEcZe/kEBs4uW+Qo4zpNH6bgWdNQJ3NEzP6tNyq8uG7Z1T2rSEhGbxaYnBJ/U8JzM0e7S
 A9k92ew2njjhJtFltE06OXDlxJQxo3KgcldNa+bucgjblqNtlcbYO6yH0MC8aPoEB46UsE/8jyr
 9TNj6TonvSnCXK54RfsXohigpV1FgIuWFEAewwFr4JMISatoFQLc9xMeguWpjns/jtOs1QEdhLf
 MYkk9rF0Fsv60KpZGLmC7s2lNkg5OB3biGCIChYPI8sHjMAOusYYaPJLEYupJR6b3X0jwViWUeA
 aTIY2jjeOsV/5Z/tiNg==
X-Authority-Analysis: v=2.4 cv=b/SCJNGx c=1 sm=1 tr=0 ts=6a3d3fce cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LN73x9Sj_Gq4gUX8wwYA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: InvW5kvySlBI6zgLz07KD_Hap8b9tZwE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250127
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMjUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2df
c3lzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4IDY4YjIzODk1NDI4Li5h
ZjUwMzIyMTRjNCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC05NSw2ICs5NSwzMSBAQAogICAgICAg
ICBnZW5faGVscGVyX3N0b3AodGNnX2Vudik7IFwKICAgICB9IHdoaWxlICgwKQogCisjZGVmaW5l
IGZHRU5fVENHX1kyX3RmcnNjcnIoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfdGwoUmRW
LCBTc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfdGZyc3JjcihTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX21vdl90bChTZFYsIFJzVikKKworI2RlZmluZSBmR0VOX1RDR19ZNF90ZnJzY3BwKFNI
T1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X2k2NChSZGRWLCBTc3NWKQorCisjZGVmaW5lIGZH
RU5fVENHX1k0X3RmcnNwY3AoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfaTY0KFNkZFYs
IFJzc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfRzRfdGZyZ2NycihTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX21vdl90bChSZFYsIEdzVikKKworI2RlZmluZSBmR0VOX1RDR19HNF90ZnJncmNyKFNI
T1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X3RsKEdkViwgUnNWKQorCisjZGVmaW5lIGZHRU5f
VENHX0c0X3RmcmdjcHAoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfaTY0KFJkZFYsIEdz
c1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfRzRfdGZyZ3BjcChTSE9SVENPREUpIFwKKyAgICB0Y2df
Z2VuX21vdl9pNjQoR2RkViwgUnNzVikKKworCiAvKgogICogcnRlIChyZXR1cm4gZnJvbSBleGNl
cHRpb24pCiAgKiAgICAgQ2xlYXIgdGhlIEVYIGJpdCBpbiBTU1IKLS0gCjIuMzQuMQoK

