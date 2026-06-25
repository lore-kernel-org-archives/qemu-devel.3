Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6E5CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclNb-0002eU-6J; Thu, 25 Jun 2026 10:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNY-0002dE-DY
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNS-00006t-K5
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:29 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9juoE1753949
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X05v3GkLKVJ5oepV5+STkOz6Fp+VxO6RAfpTWbT6B70=; b=NSn5cgYSmQuuYueh
 0Lj1bF1teF5ctuJQD799Dwh8wWw/AyadjA79iur9YMm7sSR7ofDLuCNQeBai9Cgs
 mLcH4mERveut8LL0Z6LT1n4CTY1ZuwpLQa3/xitShgUgAENTtmXnaRxj8Ne+rXd9
 EMFm+xd+LoSEm//HdQdrIk7ADdPLYqFYJKO1/uDjZK9aI+XENwGUeHSCHnTz4Gcy
 SHIcUdNdFS+9nmEXmEuSISyExHtCoaNjk6qlKZ3gMLFGE/ocA7IBSE0lsyrW6ADs
 1Tp/0ZgRHMAkhEGaxFAe/LdK0ij+7BgNqIjFWnYkVFAaV8k5Zon1oAvN3tWjbpUR
 kzj+tw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0w0q2bys-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:25 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c95b0e22aso75876eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398904; x=1783003704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X05v3GkLKVJ5oepV5+STkOz6Fp+VxO6RAfpTWbT6B70=;
 b=hi4M+FhRMxUB30DcfAD4ccyfHrlZwfdvfRz2azsGAtcwcFplvvl4aeP+6UpFH00FMf
 iGmEPpYQHt0JtFHmM2Wx+hsahcEADh6hO7aTf15rff1Lhd6Wx0eTjJ84B78pWVsxawWm
 nxzT25oL7OxHC6ylELSrYfk04UVXTFUnEJyhsToOav6hyWjUFA0HDENFwoKmPP6Vcs/v
 KTu7pyFegoLTJQbBBj4ZvhPhL9RRDTQymelEf5D1OhJ3Wr+03Pm8roG1gDIjsKcicnax
 gMOYc/K6z5dxkgoCUIlGR4f+XCWhAQYekZryhrnI+JZMgkF+EbowXdg5GGuAWhqAxuph
 bhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398904; x=1783003704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X05v3GkLKVJ5oepV5+STkOz6Fp+VxO6RAfpTWbT6B70=;
 b=HIgwwqqsN5bcde+qGRkLbQO8HPJbxwEMiwrJ90NhR9nUMVYNIk8cGmwK87DdiAgr07
 dIOcKTy4Kc1KjvN81H84j9cv3gSlCLztbOOV24qjeOv2UjO5ct+xOU8R/uTm0+Bx8AJm
 dVMFV5ClvLIKT4oCBM1O2BPJZu3xWpr957YQH03zvUzZm+XiFEyl9yDJpnYVUQ+HfhDZ
 3Qd/AA6BqXmu6A8Pn3au/2a/Zv+RUFVDRkALQ0hM7F3EjcmK4PoggAsY7TUl4T/lRj+6
 jV8+WS9TDsoyz82BSCamc3WM+Vf8faDWoDmVqSd6Tm3CV4/qFNnpUmRpKvCwoI5ejotZ
 jcCg==
X-Gm-Message-State: AOJu0Yz2oH+lkZ+NdnBrQRdVIlgzPlP1OBSMMOt7j+WLv9FkViLCIb7L
 PT+4QdJomNdXGAC3E/afnsOWszlqDnhSpirp5oqOl/s3yLx20yYL9noterUm4dKoiqN1jthncvq
 N7Z8w55PoRK1Gcnvw3lbjVQKFcKOCHGMDbUs6ANrUHmmNL9oJa74zuGIHVSVd8cfQ9w==
X-Gm-Gg: AfdE7ckHRzL/PgPFM+tweacsXQP1hO1FHQEiDyhYNxtzwIWAv6xSWNOCJsX82ESe5MO
 angezuvilIW7VP/2NTRBtBGk+Q57Wot5Eda4eQKyeVon03z50klCNQ/f964SCXtpPqjbv7Qkqyo
 K8qJZejz5hB5LwnVVbbWdIVCzm1MUf3mRJiPYiIj/aG8yfaEGyQftkH6NNFZ5jtxMA2q1JIzPOj
 OD33VCb5anxZvCEGF3zkxjlkfCr7qM8YjKzi+808yOHlcUqURdY6GdqQveSAkjoq1BqRTwAphbV
 MBjToFbEondlGX/3LCk+20GOe2yyCpSTCOWp6LcUKk9clerLxHZ9xaMF43Rfqv0N28SV+Ju02b1
 Wkm/X2AJb4xG+ren3WSk3pUGSIzj96eOvJvQ98ZhKgDMeC525PurDVFdHSUY=
X-Received: by 2002:a05:7300:8190:b0:304:e2a5:689a with SMTP id
 5a478bee46e88-30c84dae80cmr3060426eec.21.1782398904447; 
 Thu, 25 Jun 2026 07:48:24 -0700 (PDT)
X-Received: by 2002:a05:7300:8190:b0:304:e2a5:689a with SMTP id
 5a478bee46e88-30c84dae80cmr3060398eec.21.1782398903918; 
 Thu, 25 Jun 2026 07:48:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 50/76] target/hexagon: add simple cpu_exec_reset and
 pointer_wrap
Date: Thu, 25 Jun 2026 07:16:07 -0700
Message-Id: <20260625141633.449487-51-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: lI-SJeGoDirF8MZdgKI98EcxngERPb1-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX7FiTcYXk1KA1
 Y4IhLVDre8vVUBmlICgcenOoz22+tOOlB3NPKRte+z1yXkZMUVl4o0pIaM3bVE6YZpZX2RqU04P
 TvoCceHLkGjBuIHdshT+huPhxCSNgyA=
X-Proofpoint-GUID: lI-SJeGoDirF8MZdgKI98EcxngERPb1-
X-Authority-Analysis: v=2.4 cv=R6Ez39RX c=1 sm=1 tr=0 ts=6a3d3fb9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=O9wV_FzQyngHLK0UYg8A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX0fuoWwSKcjQs
 A+wBOp2j5ufvXVgEIrlEgLdqCVODOj5hj06mZWbBTHUCefRJ1lGkC2klac35JCCpRcNrVQe+WOj
 egTGaagzL8mLdxkCQiNT28U01dQLBF+zIbTsST4ShXKTI+SvgleOPts2Gb7UsmoHKakP56dZgIi
 iPKhPa7krSTaxsZlsaz8ge4ZS9gBzj0IkdSWlST1kC5xq0uaoQ4pirwOZmeYUerdmBvFohi9pyA
 XLzD8HrgLfZNEHyr6QxhZn/Qm0akGQ7Vv3w0QN2BbJgIoaonev8W5foOqGq9jV/1HzVpsmTkvCA
 fNfXXQq1kt75jHMw/8fxFgKgeFOYq2GTnGitvfOsn/BnDRmzSEa8OJ1u0my2wtQTG++y5RX8owY
 UaoAYLAvUsercEECHVdZJ5ZeCY7PKPlrq3kkCtZIpMfZx4/3Xv77XLm8lf9LZjviw+XXlgdmcCV
 EGb96u95ThZPCvx/RHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKU2lnbmVkLW9mZi1ieTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8g
PG1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgOCArKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXgg
MGQ2NTUxZGQ1YjYuLmVkZGU0YjFkYjg0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUu
YworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtNDk1LDYgKzQ5NSwxMiBAQCBzdGF0aWMg
Ym9vbCBoZXhhZ29uX2NwdV9leGVjX2ludGVycnVwdChDUFVTdGF0ZSAqY3MsIGludCBpbnRlcnJ1
cHRfcmVxdWVzdCkKICAgICByZXR1cm4gZmFsc2U7CiB9CiAKK3N0YXRpYyB2YWRkciBoZXhhZ29u
X3BvaW50ZXJfd3JhcChDUFVTdGF0ZSAqY3MsIGludCBtbXVfaWR4LAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHZhZGRyIHJlc3VsdCwgdmFkZHIgYmFzZSkKK3sKKyAgICByZXR1
cm4gcmVzdWx0OworfQorCiAjZW5kaWYKIAogc3RhdGljIGNvbnN0IFRDR0NQVU9wcyBoZXhhZ29u
X3RjZ19vcHMgPSB7CkBAIC01MDksNiArNTE1LDggQEAgc3RhdGljIGNvbnN0IFRDR0NQVU9wcyBo
ZXhhZ29uX3RjZ19vcHMgPSB7CiAgICAgLm1tdV9pbmRleCA9IGhleGFnb25fY3B1X21tdV9pbmRl
eCwKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogICAgIC5jcHVfZXhlY19pbnRlcnJ1cHQgPSBo
ZXhhZ29uX2NwdV9leGVjX2ludGVycnVwdCwKKyAgICAucG9pbnRlcl93cmFwID0gaGV4YWdvbl9w
b2ludGVyX3dyYXAsCisgICAgLmNwdV9leGVjX3Jlc2V0ID0gY3B1X3Jlc2V0LAogI2VuZGlmIC8q
ICFDT05GSUdfVVNFUl9PTkxZICovCiB9OwogCi0tIAoyLjM0LjEKCg==

