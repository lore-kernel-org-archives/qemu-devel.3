Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BF8CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclNX-0002ct-8t; Thu, 25 Jun 2026 10:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNP-0002b5-BJ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNL-00005h-3Z
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:21 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9juuM2046412
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=; b=SJqcNTPfEcRHM0Qk
 AsvNHQs6jK0H9BGozCxbKVBAKXtVC/6g3BY1kPAQvztJ5pVfFuVP+cA+OnzFWeVQ
 T6ktJC/WKy0PrVQssMZvGyy0W9b8QUVhBGWBO/bPy2loeLVubRi2y6UUHbQAzwKH
 fC/Qe3Xqd0CGYxhtkpBjQd46qMPF1SIwwextEunyqf4LGPR/EsjirPv64vApHLMt
 kZMtRLAtcqd6gJuWOgj+kh8CR1ph5pwMIZft6aquPJFLK9z9UsUUyoxPTHQ1JnDh
 EITRpqAsXD54Gmnt2H8CI2YG5GH8FhEKqjgP/0B6exTLYh38vXjkVAPyHJV5H2gv
 6WbGOw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uyqjky0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:17 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c95b0e22aso75412eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398897; x=1783003697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=;
 b=EvWVUK7nis4kebQMCBj4ZwNfhPgjQjfYhtVSIQ+bPM35uVK+AVlKKPjP9N6DW91cAX
 503jNUs5eKCHQmwMBu19ooPt0X6mcNm037H3jJXWghsBNWcOcuHs9b7WnopNVxVvu01n
 vvGh4puOWMMOWsXIqytDNm06GLNObRVGPOIT2+nbH/Fzkuc08c92hHqvT66De4nzuU5X
 R52p1co5vmo/aGYLxnMYpRX/AD4wbDUTx22ToCWCZmXpLQI6Orwo6+uW2n8p/4EctYfs
 gxiId1DGLdYI5XndBrrtoa4RzHXzcFYojIa2PgeYzbUeFjHseX6Y8V8LBhFNMhOb6IWa
 pJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398897; x=1783003697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=;
 b=qWzLrzzqRRywLAm08K+CVtabQLeg32Ly/Jy+qWrCSMHL8JBkmYUM2s3eoQZ0x/JQcE
 BsYYrUWI4UQd+p49Wzp388tsJSIG1xsg2nutUK5OOa4DlZgN1CpR+jb07K3JVCSCsdxh
 7i/yOJ2mI81LfR00e/IZ+u2DpbIGNY0u2HIsJYvhgQo45vUKoY02nZ+nVZ8tBxdlzrpS
 TsIsGY6zv3oyWlREEii95eWEMJJH9xL2kNSZjO4w8nm/1noOAueJJL8v97xehgoJhwLT
 tTb3YxSy0aedBSVB7xe04aA4isMqZOdxoN7ffe4IPEiGpBn4p4LmX+f+P4V7HMG7YMlG
 TZiQ==
X-Gm-Message-State: AOJu0Yz7lEmXgj9NtX5/VC55oyPZulxazpsIiTmNM4iRKcPWw/eU0CmL
 Q2AzUfpwc2Nqdatc2Lt6/HR6aZv+f1QnM3JIdQlD4C6kNAjuoPyzN/nm7YxpFQxdHRcHsN9aHi9
 ENFdHcvs3VdGUOBUtF0whd4RAA/2B6/BmGbWZtOIZXaFq6O0THlWeqM3suoC7JlvhKA==
X-Gm-Gg: AfdE7cnr3yjzEmMap3WcCGMSs/GAyZNRlmP31rYKel6bFd2dHKNHJgalwS60ASGRZT1
 h0e8ViDLOWM08zbK4J3LsuK/M3Khxfy+SKaRAVCoW3O4mfNBQP06qxxk9KpujvgLTT4Kha4yMRu
 xu/DnN0lU8rB8IEMQTRG33KO5/ePwcM0G0TYisjlFloTDf0AxwqIyT1s/ZWWkDiAF19S2i8wdiq
 uVIJKYbkMItm+YraRIwezFBX0G/h+fvr6S4A05m1q41/mWhg6oARsoxXyLH5CZ2RR3qkoL8otR7
 IVFaUrbsrf95N2lLpSQSIjTrg0nWY6tnR0nq0ZAq7IKYA3vLWiscQ5YR6krtCKlbE1mVfqbBQ5n
 16XS2oWuLu9b3K4436u54km/ATwE/C6FMOk1ADM71iCdhVC2KfDmxc/k9P3Y=
X-Received: by 2002:a05:7301:3d10:b0:2f0:c8b5:3dc7 with SMTP id
 5a478bee46e88-30c84dad323mr2813124eec.22.1782398896618; 
 Thu, 25 Jun 2026 07:48:16 -0700 (PDT)
X-Received: by 2002:a05:7301:3d10:b0:2f0:c8b5:3dc7 with SMTP id
 5a478bee46e88-30c84dad323mr2813094eec.22.1782398896118; 
 Thu, 25 Jun 2026 07:48:16 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:14 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 45/76] target/hexagon: Implement get_exe_mode()
Date: Thu, 25 Jun 2026 07:16:02 -0700
Message-Id: <20260625141633.449487-46-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: SNs7e_chww5qo1Sja9YmpzgNYh2dxXQi
X-Proofpoint-ORIG-GUID: SNs7e_chww5qo1Sja9YmpzgNYh2dxXQi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX//7/l3lMzGca
 cqpwiIkGbvAWhAEVycjBDv70ridT4uupAr+YXklzMl3Jvm8/V+SQ1m9C5qaHmkUy7c/pznahzsB
 SQeqHL1RYdyq+IX6WCzPx9AfopKiJkY=
X-Authority-Analysis: v=2.4 cv=EsLiaycA c=1 sm=1 tr=0 ts=6a3d3fb1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4_WtjC8beq4VSFaiBQMA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfXwure0i69tpqy
 hdS4dLFA+Edhr+vzT92MkY9xEJ1Abhttjv9yEvNUNs7huJOo9wNHe0Wv+FRStfsjewfatRWwV7S
 6ebr/zSlhyLwthOQsEcT6fMK2lIvBBrvXXQglLORATJSUSys8pUluqnyM78sYOTsPmoqmRJDQs1
 Eah/eJkHz8WSbFvzxD58JK9ktvkhNUDoDHPhZYBuMcWv6dlsoQPSoeZwPry7Li+6c64is/1/WSQ
 9fBbZCjLwuDSgrirUMAcCW1m0r5KflzzpvHRU4T5lecwJx9957o2IPDchdclNJa27q90E0kcgVy
 Id44CZWglq9BGQ0NyGQELJ7RoFlyKWAUX/6GYveJAeaiUDb74c/nNG0PlUQWPNfZJW3zbR3i6OE
 DC3T2rFs0pcFcT1LePScRGk6XJhC/2GUSKjDsuvpBvT6k9uiC2aPjQK2kecQSpOwd4W0DyVOoIU
 OVkjEoRHrrKfhGsZuxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250127
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Jl
Z19maWVsZHNfZGVmLmguaW5jIHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYu
aC5pbmMgYi90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYwppbmRleCA5YjExMmNj
ZWM2NC4uZDJjNzA2ZDU2YjUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNf
ZGVmLmguaW5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jCkBAIC0x
MzUsMyArMTM1LDE0IEBAIERFRl9SRUdfRklFTEQoQ0NSX0dSRSwgMjcsIDEpCiBERUZfUkVHX0ZJ
RUxEKENDUl9WVjEsIDI5LCAxKQogREVGX1JFR19GSUVMRChDQ1JfVlYyLCAzMCwgMSkKIERFRl9S
RUdfRklFTEQoQ0NSX1ZWMywgMzEsIDEpCisKKy8qIElTREIgU1QgZmllbGRzICovCitERUZfUkVH
X0ZJRUxEKElTREJTVF9XQUlUUlVOLCAyNCwgOCkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX09OT0ZG
LCAxNiwgOCkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX0RFQlVHTU9ERSwgOCwgOCkKK0RFRl9SRUdf
RklFTEQoSVNEQlNUX1NUVUZGU1RBVFVTLCA1LCAxKQorREVGX1JFR19GSUVMRChJU0RCU1RfQ01E
U1RBVFVTLCA0LCAxKQorREVGX1JFR19GSUVMRChJU0RCU1RfUFJPQ01PREUsIDMsIDEpCitERUZf
UkVHX0ZJRUxEKElTREJTVF9NQlhJTlNUQVRVUywgMiwgMSkKK0RFRl9SRUdfRklFTEQoSVNEQlNU
X01CWE9VVFNUQVRVUywgMSwgMSkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX1JFQURZLCAwLCAxKQot
LSAKMi4zNC4xCgo=

