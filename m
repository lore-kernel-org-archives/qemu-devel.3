Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A10606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IlNe+JFx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KOaoJ4eF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMxwD-0005Tn-9s; Fri, 30 Oct 2026 21:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxwA-0005N2-MA
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:31:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxw7-00039C-JN
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:31:14 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69V1BsIx1726304
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DlHQFm8JES1Uk+DfZYaxc9Xapcig4tw27lfDRp5tofY=; b=IlNe+JFxJ0nlImMl
 z2Os6S8kLCUO/7cWt/7NPPjsruDflwe+lXn90rBdcz8wr0aEsEaZualDLL2Zfct3
 1iIIcgt4leGgANsLUe+Rw2YjBhbXt/PQaDLtEe+8tVLpMq17j3xnxG/ZBiRNYrBs
 76jCx2veLF8lRaH4mOTOk4+Ixo2GTHk84B4b4ds4zi+QWMv+omo6bASbu9HHa3ED
 8e62jwfSK9dttLk9TpfZ3x9w7XsmdC72MbtzMtcEhhC6PTEuP3gFDdQZgGvU68T3
 Z+SJE0n/ePOMgLiXA127ndahU0dgtrh0Khq194YClouejrUEa5BHfwKHn21xMes1
 Q1l2jw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn61fr2kg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:31:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so1684099eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793410269; x=1794015069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DlHQFm8JES1Uk+DfZYaxc9Xapcig4tw27lfDRp5tofY=;
 b=KOaoJ4eFr2RVi2JqO+lX0ZY5FIi26/HpbCcMw8i5qxCpkCLLMuoHj9R6tgxYe7X3xs
 lvLs6HXC/WLmbc/ZaD28gjTif7B1mkFubN7rNT+0MNNJM4788KJ0ehelepYL9T79biYA
 ivCWijsg3WqBNnAaiy6cIm6NDzrpxsVBFz6JO19qjbaT8iyATqtuArKK+18nTFvV4Krs
 aG2FUASPTu21qgDW6z3edcBQClGHoX629ce32oI/dj+gzznJkj0EGY1ziuXiZIqtzZJK
 dkhJP+ypUNDaCs3tyycDZFV/+wKwEeUq4t4R8h0KJS57844SnyculULkoSwV7bkXBlf0
 cHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793410269; x=1794015069;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DlHQFm8JES1Uk+DfZYaxc9Xapcig4tw27lfDRp5tofY=;
 b=ySqYsttWsjHns8kRPfsQUsOalR691h/X/lbiaaHlauEMa1W0luax5MiO62K1aDK3S1
 9GQ0wRSg3WNxvW59njnmiBvIdc7NE+yrbqKIXB2+6uFXLeGU8lVbm7S8ZaqqCv+HCNsA
 +IPdAmKZBt7Zre1yhbxblMoAMm8p4sMECVNzyfHRYL5bD690w0pv7PPEhhYUJ+02pbyq
 rQRolvLDJAyNhxXFe+ckQUm/0pSOHqsK32piv+cbOwsdbFeZm8OZQlBHXqPWIpGVf7Wv
 DbfeRXRiI8zt4eozJoQ7UoZuoESYUVww8Is0Pcnak0RAmIaBwsf8OHGRs1qGxQ9hiOVx
 jbmw==
X-Gm-Message-State: AFq9FYJRAnqB6dD5LoPwM5aBUtYHYfGMuEVtN9Nv14AyuI9B43ywGPbH
 sW/c4uamDC/scgaxxFQrybykYLFlmMwLVkJub9jNj4rz/1kJ++eVRs7lo5TWh9ZDo30/MbAh68z
 RIcILekZE7hoUkPB19lTSNmTARSQj2vTM6NAJuIRy+40OG8BvTuUbm3rtxKNshE8KTQ==
X-Gm-Gg: AYBFou1OvdW8cgsQPorWxHKkK7adyPKEaYbval3AHRW5wESy3oz0z6kZdLUrbKJlDJf
 LQT6q1YOXTip6mgy/QUQM5Kgi+itxf03LArhg1meH0rUieVlwpR/o10/gDM1vwfQPegcenyy6Xk
 G1oS4AGOy+g2pkPqcY3l+n5TiGwYJHRYoKclkNklsK/rGhqvgsg8aPpyKmmd/uJt7aUQp8zWM3x
 yLwfFi9FCY1XiooVdYTSQol0hRyA4fcyIhUE0qMcUHM+YgSas94o1yyOtiSyzOUApkQ/9VNcDL8
 BSQZB4lfMxL1iqGtcLvnDJCt0agJfkoJDUlzJHoxQuXSsDfnu3+l0SyWwUW1UxX/C1KHqdyz8Xn
 t4uKa6uXjOeiNcDTw2w9cxzp55CwL1m+CzJFQ3r4tU9HUMrcc6Db07VovCXCDtnbtzl8dPLGsnk
 gh8XS1+0+oP9jJDiP8KiLUIg==
X-Received: by 2002:a05:693c:41d2:20b0:369:f961:ccf8 with SMTP id
 5a478bee46e88-36a423a9233mr5789239eec.19.1793410269240; 
 Fri, 30 Oct 2026 18:31:09 -0700 (PDT)
X-Received: by 2002:a05:693c:41d2:20b0:369:f961:ccf8 with SMTP id
 5a478bee46e88-36a423a9233mr5789193eec.19.1793410268525; 
 Fri, 30 Oct 2026 18:31:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm12170472eec.20.2026.10.30.18.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 18:31:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 38/40] hw/hexagon: describe HMX in the device tree
Date: Fri, 30 Oct 2026 18:29:39 -0700
Message-Id: <20261031012941.339141-39-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
References: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfXzNPtEPaJ7y0l
 SIThYiN3oImLKDCAAlsDUGuw8PHRC3+Tl9EM6sUB2p3JJ+0ooCZodzivBv1dvsPWsxzRazf4OEW
 ST3gzHkeCqDgd6ZAuz0xC8MFAg6TNEM=
X-Authority-Analysis: v=2.4 cv=V/LoQuni c=1 sm=1 tr=0 ts=6ae544de cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=keNgUTRjmwFx0GAfnIsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: o4Db_PB8yO9aB7X-br-7u19A2JzI23JY
X-Proofpoint-ORIG-GUID: o4Db_PB8yO9aB7X-br-7u19A2JzI23JY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX9Z4lRyTXg/KG
 7RLUedQOj231T+CzVV3qdXngGVGqAdHpyIGlhFervEK8bWmBQ9aUmocbfFf/F5B07cNo/CgS9l6
 wn7jRs4cfcaXsX3vk6CEHh7OwQyWZknfhULuafohCYur6TURHr439EYJwtIluDK27mzExZLZpBp
 iGqZOL19pE7SJYbQ44XYrhsXYTPVRA8A7R5Z1LHujC9SXLLxFIxlOAYNmzoSspHidv18rF8CTSr
 O3XIM0qsCAKxypg3VhylgTqF5OgdjB6x66+ZxMUbZQs2eeSS1rPHb86a3DFzzQ0HTmyBxtfltlF
 iHjtMMQPgKtuq5V39dL29ovzdKyUnObUF6oJ5jn+PBFqbShUULu3n/9BUj38RVFk69fPbN8KJXq
 JLYaiFvjdtlFosg27JLvxFwZTLrp27EMBG6xmyCHLEQG9cFQ3A0WkIQ+++pUZxXvHBiGEB/GANQ
 K7rsIXPVb4r+OYdrThQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310005
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

QWRkIGEgL3NvYy9obXggbm9kZSBmb3IgSE1YIHVuaXRzLgoKUmV2aWV3ZWQtYnk6IE1hcmNvIExp
ZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFu
IENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL2hleC1i
b2FyZC5jIHwgNiArKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9ody9oZXhhZ29uL2hleC1ib2FyZC5jIGIvaHcvaGV4YWdvbi9oZXgtYm9hcmQuYwpp
bmRleCAzYmYwOWU0ZTdjNy4uZjM4YzI0NGJiMmIgMTAwNjQ0Ci0tLSBhL2h3L2hleGFnb24vaGV4
LWJvYXJkLmMKKysrIGIvaHcvaGV4YWdvbi9oZXgtYm9hcmQuYwpAQCAtMTA2LDYgKzEwNiwxMiBA
QCB2b2lkIGhleF9ib2FyZF9mZHRfYWRkX2h2eChNYWNoaW5lU3RhdGUgKm1zLAogICAgICAgICBx
ZW11X2ZkdF9zZXRwcm9wX2NlbGxzKG1zLT5mZHQsICIvc29jL2h2eCIsICJxY29tLGh2eC12bGVu
Z3RoIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0LT5odnhfdmVjX2xvZ19sZW5n
dGgpOwogICAgIH0KKworICAgIGlmIChIRVhBR09OX0NGR1RBQkxFX0hBU19ITVgodCkpIHsKKyAg
ICAgICAgcWVtdV9mZHRfYWRkX3N1Ym5vZGUobXMtPmZkdCwgIi9zb2MvaG14Iik7CisgICAgICAg
IHFlbXVfZmR0X3NldHByb3Bfc3RyaW5nKG1zLT5mZHQsICIvc29jL2hteCIsICJjb21wYXRpYmxl
IiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInFjb20saGV4YWdvbi1obXgiKTsK
KyAgICB9CiB9CiAKIHZvaWQgaGV4X2JvYXJkX2ZkdF9hZGRfY3B1cyhNYWNoaW5lU3RhdGUgKm1z
KQotLSAKMi4zNC4xCgo=

