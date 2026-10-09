Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A06CA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 00:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEypH-0004GP-BE; Thu, 08 Oct 2026 20:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEyor-0004D1-LY
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 20:50:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEyop-0003fX-3I
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 20:50:40 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6990Q5BE202349
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 00:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/VhXoHMcROR
 m5UhFYg1OCYkE8v5q6pNsa8RHXlAD8UA=; b=AhPsofEBs1k+H2YcFMoEL3piK/o
 ziJ/jVQOz1wETktRwScshhoK9mdNym7SGF8NAcKF3DbO/zej9L7hTWndvzMzBPvw
 JN5kvciP/1mAOa4d7UZq5tSJU6uWMWu/udNNrkRMpNNjjwZJf1Y/QxQ+lnWQ56dB
 6tmrP0Q0prIqTVQRERWoZoW9YDQ93A7cQx8QQa7CIpgd4XdEltW/WXHa98H1ZJXD
 ReTgaq10u1G+tN8dB/MMtCMSwrGhTa19Tdre8uEfm7UsuRHLBV5mJ7ZkbXyHWnVU
 o99hDSRWNpdFESPjmd5poTEGFbyVQTzeBUfEpuBW28KY7nw0wZK7hC+6okA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxk964m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 00:50:36 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-155a75f91e1so4619796c88.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 17:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791507036; x=1792111836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/VhXoHMcRORm5UhFYg1OCYkE8v5q6pNsa8RHXlAD8UA=;
 b=KNcGPkNhn/R+BmW2GjVCXzqm8+2u40vUZRoYUBajy15omPqaOPmJvew447o+nxEYLx
 OZD3AMhfG9dz9I5DCnX6SiyyW5EmTQG32zxLY7wUGOVjHgiyC8pMja4mZnMYqSoH/JPd
 RkIXYP1+ee5oeZprkryrAaU2TXBQfFXUqS0YDY3/yf+2MMR011BxhWDZM3Biew5Xmbtf
 Zk/wM5jfhfFZ7AWJGx1julNcZ98uPjDU2ehIY5pFunHYvN6CXKzTbODHHJrG6NGHJ4Ef
 FBWyM2+HaUwpyveeYRDWkyalokYYMNH80fI2OXUh8RFo3lW9cGG8H479C+gpJe5/zgdP
 pJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791507036; x=1792111836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/VhXoHMcRORm5UhFYg1OCYkE8v5q6pNsa8RHXlAD8UA=;
 b=eyPMu5FOD7ZpGj4axhZ1wI8PNr2j7ZtNzvRRjyLFB7Pq/UUQo9K2frqKjHVKOp/XSc
 GWVoN2isMfh2Ib3NFVSvEEi0Efz2C6uTlqgJBzdmrbjWp5aGLQ3dTpY3zfBApebsDoT7
 8JvQ9hg9tsaXOu1Wb7J6q3FGFe57qgNwibQMwd8g+TWR1LajtP4c/4FO/GFAzxzMOT2t
 f85eIA9nfFr9JlLCK+wu/sZ/RD1mP85WTNp7GjtU8ChbMqyy0UV16FdwbYvXdqQqm5U5
 v1II7Yt57T6kxy5wtlqjFGdCoqQABF26wMttXP5E85g18bUOh5tBKbn8vXUKElPRltUR
 jAAQ==
X-Gm-Message-State: AFuF++k3AlfUXgkLi4d8tRe5lJbhtXJGjX0rqOZTX3/erP4vlppw0ayi
 7uf8fylvE7znoVpp0p5SG9gVuAB773WAJ1iLQMRHGvs7eFqaq7Ld9IVi/EdQ6kBGCEoehp6oxlP
 ilotfw7O1DafUKO7ITPLGFpPC+dAsBT8OiGkJemVGLnfKb2VpRWOc0Qt7DZW3K3JBuQ==
X-Gm-Gg: AYBFou1+BDzdXEy6zUKm9DzoNYT+Ph6WssYhKUWKujpKVTfXF3ygPcrif9X5aGGuQyS
 eOuFboAmI6OJ/jgGF118wHHC+N/AJ0hYDHuhRokOSL3O2cEvv4HEiykjXGiQ/hnhTc0c0HorEcf
 TkgJDkV/A/1W3JvpDTf08LNZtbcOvkOtL0Vne+DZkMzFBdIvu30wBUFBVcxRlL1qJSnQtixMLnO
 StuP4f4IM2BOPxOggAtGfEcpnrHBbZWDP3cB9uo7sjloGYN9X0nGbdGNOarN1yONbURX3OYY4Ca
 Ve2YiLl6/YDSaEhYvMsctArU+uMlyBJBymkcsBhGT7on/gMwGtYuc1HVVPmccJ7jPgK57s78+wC
 u7mf4aHNZXk8O6D2gxtd1joUmV8LhmC1ATJGDdT/SWTrF+RGR26TnNLjeG6JA
X-Received: by 2002:a05:7022:7e8c:b0:143:1bb1:b3c3 with SMTP id
 a92af1059eb24-16a5ce94210mr402324c88.14.1791507035807; 
 Thu, 08 Oct 2026 17:50:35 -0700 (PDT)
X-Received: by 2002:a05:7022:7e8c:b0:143:1bb1:b3c3 with SMTP id
 a92af1059eb24-16a5ce94210mr402289c88.14.1791507035197; 
 Thu, 08 Oct 2026 17:50:35 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a4429603sm1604616c88.17.2026.10.08.17.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 17:50:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/2] tests/qtest: fix PXE test build on MinGW
Date: Fri,  9 Oct 2026 00:50:16 +0000
Message-ID: <20261009005017.61989-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009005017.61989-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261009005017.61989-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hVOjdH8RiKpXQT21XPUvDvWlviuiZTE7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwMyBTYWx0ZWRfX43s+rI87wGDD
 VCat2mSrGH9qLVvAJg4ehCRvMGQwjQlCzaH3CscnJoWnt2mNO5z/8jP+wPIcF5NJIj0hU+cWvzD
 Zxu02d76CqAElOMBRE97FjZKnQmij1g=
X-Authority-Analysis: v=2.4 cv=Cs0q4X4D c=1 sm=1 tr=0 ts=6ac83a5c cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=x-EiqSVxQfSzw-WfpNkA:9
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwMyBTYWx0ZWRfXwTqAPW2LpF0f
 63T0EIHKvM+uKuvHM4ImiHDzfBC6tFaktOBZVfR0LOlkZsTbZTHXNqsgYFN5tg+lZYGyHefcxqL
 gHaP0x2l3I6kx8nfOk9vY0LmQg3pCmkP+IkAT8/iKQr8wjD4bUSQpdGgbEq6dZNmRwlnHynVgNB
 SW5CshWpc+xm4ZtJ+8/l8RSB5FYpGPMqsVjyk/Z28OO1mcC9Z3mdAtOkE0ssCzK63/QzZ0KNWkp
 HjXxiWhpkFo++tfArmkkwNDJoYf4J0tuM3KG24o4M05Y99zJUKxtPi+BGGpK1tqhTb8rUue6sA3
 hPV8wJPkd5aJyX8PepUFwVtpvx95Eqq8THWW6m9io0iETv+cg9LGPoJWRKp7yH20TjBGu31C1ps
 TBXD7/Mwhj5UbJV17UufWTwFJ0xA80du3NDYx5C2uc3/TGEFI+TYV53IoEZi4VCJPB/EF8vgxtZ
 JdzIablkHA3mTaW4+aQ==
X-Proofpoint-ORIG-GUID: hVOjdH8RiKpXQT21XPUvDvWlviuiZTE7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090003
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

From: Yonggang Luo <luoyonggang@gmail.com>

Replace the GNU-specific memmem() call with a bounded memcmp()
search. Preserve binary BIOS scanning across embedded NUL bytes
without relying on a function unavailable on MinGW.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261008184119.142-2-luoyonggang@gmail.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/qtest/pxe-test.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
index 61c92a2df45..37d74d7ee09 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -111,10 +111,18 @@ static bool s390_bios_has_string(const char *needle)
 {
     const char *contents;
     gsize len;
-    bool found;
+    size_t needle_len = strlen(needle);
+    bool found = false;
 
     contents = s390_bios_load(&len);
-    found = memmem(contents, len, needle, strlen(needle)) != NULL;
+    if (needle_len <= len) {
+        for (gsize i = 0; i <= len - needle_len; i++) {
+            if (memcmp(contents + i, needle, needle_len) == 0) {
+                found = true;
+                break;
+            }
+        }
+    }
 
     g_test_message("\"%s\" %s in bios", needle, found ? "found" : "not found");
     return found;
-- 
2.43.0


