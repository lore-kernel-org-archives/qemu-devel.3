Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8BBCD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiCQ-0002ze-B3; Fri, 19 Jun 2026 19:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiCF-0002b2-D7
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiCC-0001t4-UY
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:23 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYCbA1286378
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oY8qK4LAUtINTePvitXB1Xfo61hqyHEyBFAF6Gss008=; b=KHlvzW1j63PLdwGa
 at5kSd0L0uxSHU1MVCNVOi/UKbIXTY/XA0wIW85dTrsEIxC7o0omfReKhLU1iVOZ
 iFogt8OMK0pVQPdC4J9G7tv23V/VUwYk26RuOh7bUUhfZs9GT/CyWQN9h6ebx9Tx
 Fyz9620DXhGqcmOloBeVbGStbji/g3kpTVmOMAK8Go1p4l/A7rbmW2KmDNqsu1r2
 u6YOwqc/IZaPeUxYD+oJeAov6HXD0e9BICEBVPoRr9RsXGYNzDIIOAorI3yS+J5I
 svcn6OiC4wPf5c5ORyq6Ycy1HYSOsFrxLwQQYxbNx7SOeQKFtA4QnWNCbp6Fso/G
 QasZCA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evy72k838-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:00:09 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0c489e72so971646eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781910009; x=1782514809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oY8qK4LAUtINTePvitXB1Xfo61hqyHEyBFAF6Gss008=;
 b=bYBhLj8mPl+hnvqVNEpHLzVtRsoNCNerAz4wUt/uxV68sBGK7JJ+VuHkRbkqhEFrYC
 wg6eQNjBZHNSpmsCuuKCv+JZ00BjT31Qv8O37PMwASfxp2nOoT1eiih8DD0pv7lD0wBz
 UWwop4P6AYXWGy6VPH9VLeDe22DB00KKOUyYKVUJPenvPtkNsQ2g1Oh2dBOVp1hJwQdS
 r2U5jtgjIvBWO+fwPeh4t+Q8LN6r7wZul3ZVOim8zN6N9OlxD6XhBhCfo+CGyWh76Fll
 s6QtDNg7KFlCVi+bMhrmNIwFgFmNE4t+gg2KV3LtQYwGjE06yyq7uuRo1p3inpaAc2Mg
 MBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781910009; x=1782514809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oY8qK4LAUtINTePvitXB1Xfo61hqyHEyBFAF6Gss008=;
 b=A41wQa6IW9wA4LeU2TskN5rKKtUJUmigIs6ZPC1rF3b77Q+yezQMOPDsJ2LA81f6q2
 rHoo+bO4UvnNq1zhmgjyC1uQSRMAQRmQRNsn0d39S98YxxBzD80mvyD7A1k2PPGfig7X
 GJQjczSmj1HwpSGRA9FUmTA7KpO9lDsJaexX+MG64602GMRPptzDLXskwJmwUZ8K56Nl
 G96BPhcK6ZPkxwvHcNJf8sbEGgOgaVLWp+G9qW1N/XV/eIvAV6OwBv6oXiruZg+ZhXSm
 8xy6prZowtN3hs6vluA53GtTXuVbwDHNLiD23qg1JB/BN+L0WVS03j0JHwO9D/ekleU9
 GiEQ==
X-Gm-Message-State: AOJu0YxLRfYaq5vYxuHHr1I64Az7Xf76VZNzXbmAogflIIQCSfy+BLAN
 +3pnmOJBX4/TmAujf9pL0lx7e/tF6urnL2DZS+LYY9yuKGhhdUXDUxuKQUWAkKFPbtH9DhMmnA0
 SoGZBv6AbllIfeLgzTxjU+61yqZLxGka9pCKQIk5RHgxE4+CxhAxKIJE2TdiOdpxGgw==
X-Gm-Gg: AfdE7clD/izA8UEfry4MjHedGpKqm0vhJIFGdrGavWXdrQvd/5nKZ2cM8XTi+BMsYIx
 H8c8kVn4PXVTPKjbofG1JNn7+ANEg++VTfevpRuwvWNu8i40YZW0pAczXd/2X7zAL+rYFhMsjBg
 tSVavX7RJ9SF68NJpXURVHZsvwiKlpAW/D0Ej68YCLhRDzee/IuzK1Iq/sba5whOt8yHN1JWGf9
 ZspwjR7SmnFw4Yyd/WjAplQq60LWxOop13cvePPsmLZsNLIAsrpVZNu1DF+VeQMMmELJgb3QrsW
 xs1EdDhxWvB0bIvA64VbAYjq+lTSN086eAq+sdOUZvNvbcWEdL3OV0MKMn6gcw5cGr9QtVDjWaP
 7zOMx0uBYK5pH/WPiPDinmCKe5XxyWYPXjBj4M3wM6ZU/AFvoznI0Tow4A8U=
X-Received: by 2002:a05:7301:3f09:b0:303:f26f:df30 with SMTP id
 5a478bee46e88-30c06e31061mr3278207eec.23.1781910008855; 
 Fri, 19 Jun 2026 16:00:08 -0700 (PDT)
X-Received: by 2002:a05:7301:3f09:b0:303:f26f:df30 with SMTP id
 5a478bee46e88-30c06e31061mr3278177eec.23.1781910008206; 
 Fri, 19 Jun 2026 16:00:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.16.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:00:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 37/74] target/hexagon: Implement {c,}swi helpers
Date: Fri, 19 Jun 2026 15:58:34 -0700
Message-Id: <20260619225911.159473-38-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfXxLLB4qx5TD+y
 IgaQavqCgbDfGsspvXKKYkg1Z2ndPV7fvzwhA4NF8Tmff48Zt26NBixEzO+kpTwh9LSRGpzBrvg
 KmEptpqN9uYzdvGca5rbQH36wjKJkGFRkxSAmnrqkmbOF5JP5sXhv0SNsxH5xBA53zo/X2gKHPl
 +UzujfXkTWN0ME+tf5a3dnonomTw4g2jnIWGXD/N/3oTYX6Gtmr5CnGUy+WgIAOWQKWBzm/gcxw
 rqgOz6vUmbx8IdlCeFM4PvUs88/DA5FPozkTd7w+eZewOrMOPhFMZEu5OgZyKKlG6rV0somXBSx
 ImAEMfXoVZXnKgvbNBn7rn2gQueYiDaosSLHadEZdWotBWrDJdIKYOe4XLFxb4AW7bPeqvbcFwf
 HN0+stCDtvw6WZBQXmVuh+EemD4N1BLZKdK+j82oJU5G909oIpVPZGdhv9dlnSEZK6LtxmJzLIy
 nbeZlqgdTY+vsqI1lCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX7VOac4c7EM05
 VZ0trWH4mDcSBIrPdqSBQH7zKFQFVUcFirt61rNHLD1Nv8kxxy1vnh6+OhilocgV0hkjFBjpG4p
 4px0xiKCas0SWHC0afDf7z+vu3mqlEE=
X-Authority-Analysis: v=2.4 cv=I75Vgtgg c=1 sm=1 tr=0 ts=6a35c9f9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KN34Fzpn9o_w8YhA2GgA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: fW7Ll0dQR2k_BJfDA14GiNMG15AT5bdi
X-Proofpoint-GUID: fW7Ll0dQR2k_BJfDA14GiNMG15AT5bdi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Cgp7Yyx9c3dpIGFyZSB0aGUgInNv
ZnR3YXJlIGludGVycnVwdCIvIkNhbmNlbCBwZW5kaW5nIGludGVycnVwdHMiIGluc3RydWN0aW9u
cy4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29t
PgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+
Ci0tLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCA4ICsrKysrKy0tCiAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXgg
NGRjMmI4ZTYzYTcuLjc4Mjc2OTZjNmIyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMjQsNiArMjQsNyBA
QAogI2luY2x1ZGUgImNwdS5oIgogI2luY2x1ZGUgImV4ZWMvaGVscGVyLXByb3RvLmgiCiAjaW5j
bHVkZSAiZnB1L3NvZnRmbG9hdC5oIgorI2luY2x1ZGUgImV4ZWMvY3B1LWludGVycnVwdC5oIgog
I2luY2x1ZGUgImludGVybmFsLmgiCiAjaW5jbHVkZSAibWFjcm9zLmgiCiAjaW5jbHVkZSAic3lz
X21hY3Jvcy5oIgpAQCAtMzYsNiArMzcsNyBAQAogI2luY2x1ZGUgImNwdV9oZWxwZXIuaCIKICNp
bmNsdWRlICJ0cmFuc2xhdGUuaCIKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2luY2x1ZGUg
ImhleF9pbnRlcnJ1cHRzLmgiCiAjaW5jbHVkZSAiaGV4c3dpLmgiCiAjZW5kaWYKIApAQCAtMTQw
MywxMiArMTQwNSwxNCBAQCB2b2lkIEhFTFBFUihzaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIAogdm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9M
T0NLX0dVQVJEKCk7CisgICAgaGV4X3JhaXNlX2ludGVycnVwdHMoZW52LCBtYXNrLCBDUFVfSU5U
RVJSVVBUX1NXSSk7CiB9CiAKIHZvaWQgSEVMUEVSKGNzd2kpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCBtYXNrKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgQlFM
X0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfY2xlYXJfaW50ZXJydXB0cyhlbnYsIG1hc2ssIENQVV9J
TlRFUlJVUFRfU1dJKTsKIH0KIAogdm9pZCBIRUxQRVIoaWFzc2lnbncpKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBzcmMpCi0tIAoyLjM0LjEKCg==

