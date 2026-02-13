Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5716EF48C2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 02:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqjLj-0006GG-4H; Thu, 12 Feb 2026 21:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqjLc-0006DC-Kl
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 21:56:00 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqjLb-0005EX-5L
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 21:56:00 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CIlNss455058
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 02:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ibV6fOnqSKgyOpsaYe0KplZLjceXIU2EkevCzp1E/VI=; b=RZAlo35FKpW88OEr
 nqYKSbGIWOJhkdrwsmsTSYY6LITKHUZiRqXgvjsjkyra+9UP+r4w7/owU5k37xjj
 qvyLscFOF2bcBbX9v9WSeIpfrjuJ8QpZBw0B6Ov7yRW2wnsQN9UaONjV+MIeZIu2
 Aapy+js6GLZvB/uvWKY0mpDv9uRTCqsxANBRH3tdzGT3Ac18xb6H+dyNSynf4rOO
 hRn/r/IZeRw2UQ+RAw5uxXEK7S6TuPk8gPBC3PrSbBv1WuGuV0HOdDtBrJLSj25k
 JbZcq0q+1MamG2Zl3y1kcR0XJDm5rC18QPAjO0g5kebjWB0oaRSVSoIsvNp0G6hs
 3K9X9A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9mev1g2x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 02:55:58 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ba7e98178fso566189eec.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 18:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770951357; x=1771556157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibV6fOnqSKgyOpsaYe0KplZLjceXIU2EkevCzp1E/VI=;
 b=g7OqUVmcD/d/NRMPR0/dcTCGUgJo5J32cEwkS8r+AaeGfM3mkEOuO6TaCplO539Nk+
 TeCtoVNszCOBEui7/CEAAvZYIgx7SO1fXJi18h8A3CjE7Ng1fZvZGABo8SvXTQ+FTB2L
 TRl4ekZIwReCz/A9vVwsN+K+fDm6BJyE3tfnIpAbH+7aBuUS6aDL2853XLtkvxPRPbxR
 VaO3lj8G8rSt3rowjhZD5PY78nkzyiwVLd2LEdCyRTM+OJDA5kwwyrThgCDknifFJjGs
 xBs9ADcuWfpAmhBjCIjlfhNIuT0DwKyNJKaDoDPar2uMOUVBQOCUrkzHmOq0zrtYbVsF
 oYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770951357; x=1771556157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ibV6fOnqSKgyOpsaYe0KplZLjceXIU2EkevCzp1E/VI=;
 b=kyZfC4r1cNWHQzKhpoJ7QE8Xxkuk5FpLh9vsbciGPuvm0XJpGO7/ed2TionhMStbtn
 lNNsdjXaBhnzzaMLBXPsa67yAosza/GjD21eaZ5ISAToC6dG/H8gF5fab+5N+6ta5QPn
 Rxyq287Z+gq/cQlEPoX4M1US2Plaa63Zn7fjTXBu7EaUTy93TEU/Cqendfxh59co89H7
 rtHKafFBgXIEba0THZggurzpjgJvMbPaO7orJctv1ku8PdcC7alMTNuiv4ts335IKqQV
 TWNZOtHZqmFRFZXQIzm9i0J822UGrlG8wMFMoCK7Wswg6bwzHxJBy6p4qHmDaOYNcGWE
 7xOA==
X-Gm-Message-State: AOJu0YyYsQ6qguj5KsUQUfBVTJHSGiQUZZNW9AWLVSLg4jW9qxmDzmuP
 uYcPKmrXxbnKsnS1zLHGWD7IWC+JPeV6GU65pLsMOdJXQKz23UfjfivcpUaiFlRqB+C5u7YXsV9
 w9dy54R4Qy07ZvK2QuYRdtf8CROZeRxVrOqe8SjY8hue8pU4Zf5/fyqc5iR/kEkkoZw==
X-Gm-Gg: AZuq6aIsWi41GN3Ter7OWBd0VcRUr7FvztrKO6mEB+XyceMcNp5Dv5rnX5AccioNRZc
 CDx6sPGR0l8/7skO5I3YfJuU55CXcEhbUWllYj0vLv9PKl0a30ROYD1Yrl3OxFNq5BZIpksY5Sp
 rTNou6rW9eGmtXgG8yx6munlI/hma0PMsnajmN+e+wxsKDHWDXtIfsmu6i+CEVM9s7wWUicpzcF
 425pg74THDEA2j55O/LHSiO061/4cQQXp3Ck7S+0rA9s8L1cSlDsxEyqNH/6PLxxr3x0U3gvBrf
 wOBB6EgtvPE9pqwru9208orH3LwKElDPVMPxWW9GEK4f4/WF3VbM7uVpyQLEtXIy4jY7Iv+YXvf
 OVzx/kSnTunj7pbSIGSxsnrrqIVzBiSxLM1s9ceI4PBZ7qIfGdA93BnlrRGd11+raxk6K/A==
X-Received: by 2002:a05:7300:818c:b0:2b0:4c5f:c05c with SMTP id
 5a478bee46e88-2babc3a6588mr135231eec.4.1770951357085; 
 Thu, 12 Feb 2026 18:55:57 -0800 (PST)
X-Received: by 2002:a05:7300:818c:b0:2b0:4c5f:c05c with SMTP id
 5a478bee46e88-2babc3a6588mr135221eec.4.1770951356516; 
 Thu, 12 Feb 2026 18:55:56 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ba9dbd5d3esm4500943eec.10.2026.02.12.18.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 18:55:56 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PULL 7/7] target/hexagon: Remove unused is_finite()
Date: Thu, 12 Feb 2026 18:55:44 -0800
Message-Id: <20260213025544.2497992-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213025544.2497992-1-brian.cain@oss.qualcomm.com>
References: <20260213025544.2497992-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Zq7g6t7G c=1 sm=1 tr=0 ts=698e92be cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=3MbPwEZUIfkocZ0tF-YA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: bJ-MwoI-Mcc_d287zY-xtrVvjdi0TRCx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDAyMSBTYWx0ZWRfX5hO5aXYvaVI+
 e3lL0Dh47OxXcPIKHFfbiplaJCE8FMrHeeNSIxrwHQ5tc0Q63v0QQcteXVgXIKsVFpAk+/witjz
 acjL+x40I6mDql9q43Ry2fKH4bhSaKXKZePoia6bIc0Yr5j5CsjPI/PtXbNpFcyU/DI5+Bzwbd/
 +ll16pJ75MVFZrc1NRvc5+p0s3hDwCxTh9JBmy3149vYlj2LlA0pT8cl5r+F/Pxjt0lM3xZIlZp
 F8AVrlou0JecsyXnRvvgD10SY4gG1uM2tRmnVVzwo3J8PJh6IAWokgB/llm9A7mYED+gemiNCZ2
 ORVCnBHfrq30UoxZrcDtsdukT475dp+6QDcMCXiDI7AsFUXh9iweBuJ6Y/v8tJ3b3Eh+sRactjl
 m9qvC14aLmwk9b3RDqyGnl3XzUaZvOwdGnLTfC575NYcGP1e8lviSrmQxrJNefgcxVeO/xWZP3o
 9wu7D4LSA6UCo0wLV4g==
X-Proofpoint-GUID: bJ-MwoI-Mcc_d287zY-xtrVvjdi0TRCx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130021
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KCmlzX2Zp
bml0ZSgpIGlzIGRlZmluZWQgYnV0IG5ldmVyIGNhbGxlZCBhbnl3aGVyZSBpbiB0aGUgY29kZWJh
c2UuCgpTaWduZWQtb2ZmLWJ5OiBNYXJjbyBMaWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVhbGNv
bW0uY29tPgpSZXZpZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWls
LmNvbT4KUmV2aWV3ZWQtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29t
PgotLS0KIHRhcmdldC9oZXhhZ29uL2ZtYV9lbXUuaCB8IDUgLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2ZtYV9lbXUuaCBi
L3RhcmdldC9oZXhhZ29uL2ZtYV9lbXUuaAppbmRleCBmZWQwNTRiNjA5Li45MTA1MzBmZmY4IDEw
MDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9mbWFfZW11LmgKKysrIGIvdGFyZ2V0L2hleGFnb24v
Zm1hX2VtdS5oCkBAIC0xOCwxMSArMTgsNiBAQAogI2lmbmRlZiBIRVhBR09OX0ZNQV9FTVVfSAog
I2RlZmluZSBIRVhBR09OX0ZNQV9FTVVfSAogCi1zdGF0aWMgaW5saW5lIGJvb2wgaXNfZmluaXRl
KGZsb2F0NjQgeCkKLXsKLSAgICByZXR1cm4gIWZsb2F0NjRfaXNfYW55X25hbih4KSAmJiAhZmxv
YXQ2NF9pc19pbmZpbml0eSh4KTsKLX0KLQogaW50MzJfdCBmbG9hdDY0X2dldGV4cChmbG9hdDY0
IGY2NCk7CiBzdGF0aWMgaW5saW5lIHVpbnQzMl90IGZsb2F0MzJfZ2V0ZXhwX3JhdyhmbG9hdDMy
IGYzMikKIHsKLS0gCjIuMzQuMQoK

