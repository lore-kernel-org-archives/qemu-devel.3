Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7BCCA601F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFGEF-0007NX-RI; Fri, 09 Oct 2026 15:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xFGEA-0007Md-0M
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 15:25:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xFGE8-0007dl-IK
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 15:25:57 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HnDJf2901095
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 19:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JBjdMmKpfNYTW3P1v1p5pggnmyc6LtgU9PJXn64XCGs=; b=TX0vygYMntS1h1UJ
 ST9whHZM/IlKpWKTqc4sHGH0JKMgDcWRxUigqLr8YmmbjT8ZfzaE3ekhy9LkUQV9
 mLeGkS8ECgxHtqu3sm+95Udid1jdwiw6H4C+/6VUjv1yWXNleMR8CKiID1AX+WDV
 GsO85uSRb9xTxn+EbQMaeeJIwqNI1j9581sanzZ30gqMhTqFt3Kd0yqoO9xIeRMH
 lxgwip2LY5xJM+egdSfkogLJg4e5WjopXVEjIKlSwJyivJ9BlCglE9gn2UG+fTch
 bMXn0iJK2DOvnz9tw8XusuWDIgCTgZgioUqxOInEYhGc993ZAqKdWixwEj/SGKbF
 cl4+Yg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t7geve-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 19:25:55 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso71319eec.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 12:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791573955; x=1792178755; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JBjdMmKpfNYTW3P1v1p5pggnmyc6LtgU9PJXn64XCGs=;
 b=Ok7YbpmMHiXytJKjXBMcEv0MY0kdBOTspMhkWuF7vJz3IK8pPI/QaL+szEK0AO/8iv
 5X2HJn6I2lnrqIYWGmC7XQNNMNyJobmvw6jlb0uT3OQheBe+hYSA4ki/gQlxva2ahzdu
 DMhb+ZqVVhdaqpl4Ce9i+POymdENBtBxxuhXBzloTrce3/zZPTfANaR4TNCHP8p9hndo
 psfLWsG3RzA/WXUMLyDsRikqKNm2PUxaHPKNFlbptOQR0iBzd7WKY8pTGxN6dnTZsb16
 LUG68XuEBVFhUXC8hiCzhr1CUZCtmvxIa35P3DHZCvXH1rGOka/a4ftFwLv3QQzzshdB
 zWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791573955; x=1792178755;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JBjdMmKpfNYTW3P1v1p5pggnmyc6LtgU9PJXn64XCGs=;
 b=r//hLrJxwSqTAuEUOlY5bgX3tTSAD8JqHKvey9Jo6DkmOiJBA6nBdXzgjmRumDylBt
 dlXIUd55X9Y/BguTDpVLie+4+m4Z1O0HiTa7uksZuo8j5rgdwkiKHsAwpo9IFL9dFrft
 Hk+TqtR240QpfrhLhzJ48Za+rQEsEAokJJBbGPlmlm2kzTNQhQddn7oXH1vEZEqAe0Om
 Tq1opcEk64Udf504VQTOeA1LYv6VcJxAjg6fWTOiPkQWeDuOr5nFJVZ//aM2QKhiTPsF
 zbx/hH/VGVL7ZjvYbGQsMv2PFJT1XufJWE/2uWqbC66NZxkK/DuDfrQekmmYQ4J++zet
 0pBw==
X-Gm-Message-State: AFq9FYK0Zi/wvMEQToC2tw6d8qJ4baU9j0SRhnKuepFD6a52YFXPy2XR
 6Vi/1MRdqujnXQ04Ply5QGYMgY6fiSbM8bctreBep6NFKg2IOZLNplMq9pELRnS/GieCDfB47nJ
 bqjCMFAw8x7YX8zMeX3H47/GUsHqSGTmeNFOMg2aXAEuje4kmEPdjkvScX9gej4x0AA==
X-Gm-Gg: AYBFou1Efxn/HD0xejC3tfjFWKXyUvuW5PZ9+rOPvTESuRoqWhHxmpTYB5j9m1dGgtq
 jdsxLIwLcuw8CrGl1JOhEBc1oSz4ZbDSbD2lemlzHyGC26aWGcGbIlHkQFOB5D3linxNEGrvOj+
 7KW0Q7vk6L7KwmuVDWuYorKDkfP76q8QVtzMWVI8UMbqoA8D7JnsNE2RbNkb0SOyO/F+PruwD2I
 dhoBRuDQD39GHAw/KZZLzE3NcxR8rFC6AQKUzh5+G/zugj8WYuPZYeAMfi/cuRZjDv/Z5AXfJuE
 qe7TZfv1P0Yj6sPnZ7BXmwjtQM9lo8zNtYdP2GUn7TOOArjXUWyoWRp0fJUdITKfx0IvJCCohnS
 IjF6TUp0Cf4FLOILaX7H1GY/9DpF3UxH93xlJh7dK+LUuBx4=
X-Received: by 2002:a05:7301:7d06:b0:351:4d03:c6a with SMTP id
 5a478bee46e88-3537df51463mr3371954eec.12.1791573954571; 
 Fri, 09 Oct 2026 12:25:54 -0700 (PDT)
X-Received: by 2002:a05:7301:7d06:b0:351:4d03:c6a with SMTP id
 5a478bee46e88-3537df51463mr3371915eec.12.1791573953908; 
 Fri, 09 Oct 2026 12:25:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d202sm7652822eec.13.2026.10.09.12.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 12:25:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 4/6] target/hexagon: halt on tlblock when the TLB lock is
 contended
Date: Fri,  9 Oct 2026 12:25:38 -0700
Message-Id: <20261009192541.4163758-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
References: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=W8atxhWk c=1 sm=1 tr=0 ts=6ac93fc3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=n7pvLpctYYjJJk5sxiwA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: L72_Lsx-ss9jCT0xjknZHv2Lo2MD1z2j
X-Proofpoint-ORIG-GUID: L72_Lsx-ss9jCT0xjknZHv2Lo2MD1z2j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3NyBTYWx0ZWRfX/nSZFc3hzCeO
 VjAZAqCYBK+Sjv4bxeRG8GvCEyRbuu7mlO3CWiaUfYgYQkyOOVCkhvpyp/OuUcZsup0kvwfgJ2D
 1pJJHejjAiKdKFEP8+PsiKDuhklcnPk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3NyBTYWx0ZWRfX1mpGkkqWoLil
 6dXZIz9NMLvGZTryHh76RvSAm+WFBj53iOg0qKHCKM1SmbRt8qzQtVA1yXPGPVUzKSbMFsO7cW4
 uW+NROeaXt5AI43YS2qPUdkFTei941IPME1AuuJjvjLMy6ZQI9FV9wKrE5pvg0NmjODBMxFmqmx
 2CBSOXKNcuuOa74Zk1XV/ljxaLpT8LZv3mKXnpoz9gxEKCVwe/Ec61tQgwUSHpWtcCtAejA7tZO
 Ngty/wz7SsBrQS3IV3XDf4gv1TSkCyIHNZQDCW7EWm5ggs9al3+oROx60vTyycm6HAXmIBrtIbj
 xjdhFADsbEQI3YqSGQHtSkVv6aJX03ciDxRzUUNpiEzGsjdstPfogqqiYcKE/6uSsUmP6LWtwzG
 X5nw3IdO35UDs9dWWId1lQ05lyWUi9b+VitA2uzpbCZZDG+mb0t3exW7MIe9DoSIOHAPHKzmElA
 XpGhskpsqxHUfWG6hpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090077
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

U2V0IFBDIHRvIHRoZSB0bGJsb2NrIGluc3RydWN0aW9uIGFuZCBsZWF2ZSB0aGUgQ1BVIGxvb3Ag
d2hlbiB0aGUgbG9jayBpcwpjb250ZW5kZWQuIFRoaXMgcmV0cmllcyB0bGJsb2NrIGFmdGVyIG93
bmVyc2hpcCBpcyBwYXNzZWQgYW5kIHByZXZlbnRzCmV4ZWN1dGlvbiB3aXRob3V0IHRoZSBsb2Nr
LgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29t
PgotLS0KIHRhcmdldC9oZXhhZ29uL2hleF9tbXUuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYyBi
L3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYwppbmRleCBiZGNmYTA1N2MyMS4uYjlmYWI5NDlkMGYg
MTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYworKysgYi90YXJnZXQvaGV4YWdv
bi9oZXhfbW11LmMKQEAgLTEyLDYgKzEyLDcgQEAKICNpbmNsdWRlICJzeXN0ZW0vY3B1cy5oIgog
I2luY2x1ZGUgImludGVybmFsLmgiCiAjaW5jbHVkZSAiZXhlYy9jcHUtaW50ZXJydXB0LmgiCisj
aW5jbHVkZSAiYWNjZWwvdGNnL2NwdS1sb29wLmgiCiAjaW5jbHVkZSAiY3B1X2hlbHBlci5oIgog
I2luY2x1ZGUgImV4ZWMvY3B1dGxiLmgiCiAjaW5jbHVkZSAiaGV4X21tdS5oIgpAQCAtMTg1LDEx
ICsxODYsMTQgQEAgdm9pZCBoZXhfdGxiX2xvY2soQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAg
ICAgICAgICBlbnYtPm5leHRfUEMgKz0gNDsKICAgICAgICAgICAgIENQVVN0YXRlICpjcyA9IGVu
dl9jcHUoZW52KTsKICAgICAgICAgICAgIGNwdV9pbnRlcnJ1cHQoY3MsIENQVV9JTlRFUlJVUFRf
SEFMVCk7CisgICAgICAgICAgICBjcHVfbG9vcF9leGl0KGNzKTsKICAgICAgICAgICAgIHJldHVy
bjsKICAgICAgICAgfQogICAgICAgICBlbnYtPnRsYl9sb2NrX3N0YXRlID0gSEVYX0xPQ0tfV0FJ
VElORzsKKyAgICAgICAgZW52LT5ncHJbSEVYX1JFR19QQ10gPSBlbnYtPm5leHRfUEMgLSA0Owog
ICAgICAgICBDUFVTdGF0ZSAqY3MgPSBlbnZfY3B1KGVudik7CiAgICAgICAgIGNwdV9pbnRlcnJ1
cHQoY3MsIENQVV9JTlRFUlJVUFRfSEFMVCk7CisgICAgICAgIGNwdV9sb29wX2V4aXQoY3MpOwog
ICAgIH0gZWxzZSB7CiAgICAgICAgIGVudi0+bmV4dF9QQyArPSA0OwogICAgICAgICBlbnYtPnRs
Yl9sb2NrX2NvdW50Kys7Ci0tIAoyLjM0LjEKCg==

