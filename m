Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA5606BA6A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X0OHrLRr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LWkzhwK9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiLk-000415-BT; Tue, 27 Oct 2026 10:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiKS-0008VR-1d
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:39:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiKP-0006Cn-3t
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:39:07 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoYTP1850875
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zm3dpnzDADNcCsVjVrMQsrVvOqUWcCoCXQJKLSRJrAQ=; b=X0OHrLRrkUT3y8ly
 NaU1BNgRiqRXut0kQ6ywydbLLaY16AlFIgzvkqKghvxhe1EfSYIyWna9WbriD1EE
 jOb1rvFdA83DFg0eyuppAaa+G6KQcw0Uu9epFZodUcT+8tk2fuCoW7sdmzDCfVle
 eWPWhHP631TeIYWZWAGXjWIOpT6YixiGNTg/Egqr96y5rR7nM4W5dqe06vuiK5P+
 HGhf3NcvyP5jQzjwGFtbphPRzgc03Nbs6KPT8OUzCDpBpGB2kqZ6O+h44Q1azLj2
 zXGXzDPZgUYREllK7Xc4SZeIehtO57e6c65xPhdA9jUgvhreywrLEtp7cfrtKm3c
 4luOXQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmc4hd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:39:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ad704d4760so3876583a91.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111942; x=1793716742; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zm3dpnzDADNcCsVjVrMQsrVvOqUWcCoCXQJKLSRJrAQ=;
 b=LWkzhwK9gHt/rx40yP+xKYhJ9gj81fEgUiUew49pTsv2cOCTrFjuQ4mys6FeKtRwiY
 F3kOS9+OtP0h1wMZNL6gBN5MTfcLpk+Qyabn2xVEGJBsZAZRcCuqSwVW4bvJ7EbHgbcY
 jPgwG33n7qVCVYeaqsxhJPAOHwrNe2u6VZi0sRQbhDkYAhepRkD+6GuBEjWiU8kx0QX9
 0YFCXkAvgFQDgAZmJdR6Sxm+pgluuOWKzR1K3BJy+m06EBJzgqQCcBopfv+Ifnxn2Vmj
 x6wr8+WR2lfyjTAJ3xdl1W7zxX06GmajCMFWUb229DyJivb9jNtHiyuGchrPD324jbVK
 EX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111942; x=1793716742;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zm3dpnzDADNcCsVjVrMQsrVvOqUWcCoCXQJKLSRJrAQ=;
 b=BNAsiqf0EdKEVQKUnKBLUM8x3J88Ta8xCQ6nT2yDHqMN6fALYPoyHwSOgdJtl+ew2Y
 MKYnaPzU5S84Pfga6WRUnUQRV7P60m2Yca0UiiA/AsSraqKKzl5cFdZuaQF/8Vnr1cur
 psmdrx9sXVPyqpZlI8GH3/GetXgLSXT4ih0xUA3z9s7bRHdtr3tFgqenBiavneqUsYJW
 dzIED/xNZqDnKJyB8Lky0uyOCmtL6UmdkSPBM8yrl1UnvHvHsYoB3/dLLehv45q+McK9
 REcoeg6O85CpOZXvUU5lLny/i4YhPJp8j70htB+NV9NsluEb0tRwyyKxZ7NNEp5cVfLz
 qNIA==
X-Gm-Message-State: AFq9FYKlZlE8RumIlWXQ3WItNKVHwIUaC97Ebpc+jTD89BjDPkj+RNbo
 N4chzN6Y7Fyhq3KnqfvwRiy2uMXIh1jidynoBaf7Xw9MHGwy2aGywow0ExwkeuPT5ocJdynWJji
 G5cMZZ8eL1uu/6xMA9tbc5YxPrAVZlNYMle3pUW9MfMlSNjULUW8wi9htz/Eq4U+rcw==
X-Gm-Gg: AYBFou2079uU+rk/IR4PY80jZaSnhi39oJYohdNlOZSZ/vLzycoUGCvSUthSb0PHvrw
 /ZOb3IyNa3GWrMI0n8USuTKM+KPY9UWPBsdBBvxGY+mxVN6JN4f5PO5cS8QGM3yCZkBV6lssjYm
 kUmip5J/JWYSoO8zZmwbCtiLw4/9xjzUp8zWY6JZ5xNb04TTqmjw8k5own+XY3X1dCtju1WT0Q5
 SJxpbYkOgl2ELu0z9EUYq1LinqAfB5Jdm06ZlW9iBFglv4TGd3rbzrS9YoY1LXT6uHxm8JFAlp+
 AlG7KHcWyWPK572sbeeMiYdq8P0sQhDov4quq4Q9PvkSuVZEQ5a+eN+IUYV7hF8mO64tNgna/bx
 nD+FFQTny68mjgAC40InzAqwdyWivtB3kpF7pDCAW94c3J4g=
X-Received: by 2002:a17:90b:4a81:b0:3a8:a98c:ea07 with SMTP id
 98e67ed59e1d1-3adea8966e7mr7425045a91.13.1793111941746; 
 Tue, 27 Oct 2026 07:39:01 -0700 (PDT)
X-Received: by 2002:a17:90b:4a81:b0:3a8:a98c:ea07 with SMTP id
 98e67ed59e1d1-3adea8966e7mr7425014a91.13.1793111941001; 
 Tue, 27 Oct 2026 07:39:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404dde70sm4056102a91.1.2026.10.27.07.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:38:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 35/42] hw/intc: ciad should forward its mask to l2vic
Date: Tue, 27 Oct 2026 07:37:14 -0700
Message-Id: <20261027143721.4125584-36-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfXztXdgptcxlGU
 YcaFGoC91AMbPgXx7lItscrZGml26UV+PDw7ziKZdF3PKxbuSdjqmlp7jzVP6qNGyUgW/A1n0+S
 b/k5eZGJ6m7L3Lf+URKL3Vi4Jo8GUyA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX7zwP+4scQU+1
 X7RQOevTue2tiyR+AKleanwWfrPQAI37f5qeQ3hw26975R928wlGA6YgVVJJVnnhkR6T5/0bGSR
 vlukW8jxgWZXXkgX+3H94l1Uv5LMFG9d65YkQ8NqG7l0crsO4U9jDGDENcZD2ZSGv9wBM2nJUSg
 KNX3CzDSFBCtDs6ExyAHnT+MvsKfSUT3K2VUnOjWc5kZiufd431nInJBPeCVmcOA7mxRm2FXkcX
 4aVDq9SHlpMyfajM8X7oPuIli98QFmOJr+EwajSpDu8h2z23U4pqf/vLbn6PlvnSxO4kQXXbEqg
 krDuRLkjF0OMipi6SH/K2K78vfx7AsVPSK/y7dF8nZojqNmFI0moiUv91VCYLCvl109/X3CUp3n
 ciu2TiMfXmveMv9rmYjKiCj7di+kvTBwjYHcf102+3FNxK1qezUCTSXqUJN9VsW3XrV4pXfgiTe
 2N/o6f4di89gw1/3qHg==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae0b786 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=zi4VUfZ7aQnuQJZsh1MA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 9DekY_xNx0LemaGe-w8N_ZOpeoVxKw9O
X-Proofpoint-GUID: 9DekY_xNx0LemaGe-w8N_ZOpeoVxKw9O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

Y2lhZCBjbGVhcmVkIHRoZSBsYXN0IGludGVycnVwdCB0aGUgTDJWSUMgZGVsaXZlcmVkIHJlZ2Fy
ZGxlc3Mgb2YgaXRzCm1hc2suICBTbyBhIGNpYWQgZm9yIGFueSBvdGhlciBpbnRlcnJ1cHQgd291
bGQgZ2V0IGFwcGxpZWQgaW5jb3JyZWN0bHkuCgpPbmx5IGNsZWFyIHRoZSBhY3RpdmUgaW50ZXJy
dXB0IHdoZW4gdGhlIGNpYWQgYWNrbm93bGVkZ2VzIHRoZSBDUFUKaW50ZXJydXB0IHRoYXQgaXRz
IFZJRCBncm91cCBpcyBkZWxpdmVyZWQgb24sIGFuZCBvbmx5IGlmIHRoYXQgaW50ZXJydXB0Cndh
cyB0YWtlbiBvciBzZXQgd2l0aCBzaWFkLgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGluY2x1ZGUvaHcvaW50Yy9o
ZXgtbDJ2aWMuaCB8IDE0ICsrKysrKysrKystLS0tCiBody9pbnRjL2hleC1sMnZpYy5jICAgICAg
ICAgfCAxMCArKysrKysrLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgfCAxNCArKysr
KysrKystLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2ludGMvaGV4LWwydmljLmggYi9pbmNsdWRl
L2h3L2ludGMvaGV4LWwydmljLmgKaW5kZXggZWRjMjc4MjY2Y2IuLmFlMDY3ZmU5NWViIDEwMDY0
NAotLS0gYS9pbmNsdWRlL2h3L2ludGMvaGV4LWwydmljLmgKKysrIGIvaW5jbHVkZS9ody9pbnRj
L2hleC1sMnZpYy5oCkBAIC0zMSw4ICszMSwxMyBAQCB0eXBlZGVmIHN0cnVjdCBIZXhMMlZpY0lu
dGVyZmFjZUNsYXNzIHsKICAgICB2b2lkICgqdXBkYXRlX3ZpZCkoSGV4TDJWaWNJbnRlcmZhY2Ug
KmwydmljLCB1aW50MzJfdCBncm91cCwKICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90
IHZhbHVlKTsKIAotICAgIC8qIENsZWFyIGludGVycnVwdCB1c2luZyBDSUFEIGluc3RydWN0aW9u
ICovCi0gICAgdm9pZCAoKmNsZWFyX2ludGVycnVwdCkoSGV4TDJWaWNJbnRlcmZhY2UgKmwydmlj
KTsKKyAgICAvKgorICAgICAqIENsZWFyIGludGVycnVwdHMgdXNpbmcgdGhlIENJQUQgaW5zdHJ1
Y3Rpb24uCisgICAgICogQG1hc2sgdGhlIENQVSBpbnRlcnJ1cHRzIHRoYXQgdGhlIENJQUQgYWNr
bm93bGVkZ2VkLiAgVGhlIGludGVycnVwdCBpcworICAgICAqIG9ubHkgY2xlYXJlZCBpZiBAbWFz
ayBoYXMgdGhlIENQVSBpbnRlcnJ1cHQgdGhhdCBpdHMgVklEIGdyb3VwIGlzCisgICAgICogZGVs
aXZlcmVkIG9uLgorICAgICAqLworICAgIHZvaWQgKCpjbGVhcl9pbnRlcnJ1cHQpKEhleEwyVmlj
SW50ZXJmYWNlICpsMnZpYywgdWludDMyX3QgbWFzayk7CiB9IEhleEwyVmljSW50ZXJmYWNlQ2xh
c3M7CiAKIERFQ0xBUkVfT0JKX0NIRUNLRVJTKEhleEwyVmljSW50ZXJmYWNlLCBIZXhMMlZpY0lu
dGVyZmFjZUNsYXNzLApAQCAtNTIsMTAgKzU3LDExIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBsMnZp
Y191cGRhdGVfdmlkKEhleEwyVmljSW50ZXJmYWNlICpsMnZpYywgdWludDMyX3QgZ3JvdXAsCiAg
ICAgay0+dXBkYXRlX3ZpZChsMnZpYywgZ3JvdXAsIHZhbHVlKTsKIH0KIAotc3RhdGljIGlubGlu
ZSB2b2lkIGwydmljX2NsZWFyX2ludGVycnVwdChIZXhMMlZpY0ludGVyZmFjZSAqbDJ2aWMpCitz
dGF0aWMgaW5saW5lIHZvaWQgbDJ2aWNfY2xlYXJfaW50ZXJydXB0KEhleEwyVmljSW50ZXJmYWNl
ICpsMnZpYywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMy
X3QgbWFzaykKIHsKICAgICBIZXhMMlZpY0ludGVyZmFjZUNsYXNzICprID0gSEVYX0wyVklDX0lO
VEVSRkFDRV9HRVRfQ0xBU1MobDJ2aWMpOwotICAgIGstPmNsZWFyX2ludGVycnVwdChsMnZpYyk7
CisgICAgay0+Y2xlYXJfaW50ZXJydXB0KGwydmljLCBtYXNrKTsKIH0KIAogI2VuZGlmIC8qIEhX
X0lOVENfSEVYX0wyVklDX0ggKi8KZGlmZiAtLWdpdCBhL2h3L2ludGMvaGV4LWwydmljLmMgYi9o
dy9pbnRjL2hleC1sMnZpYy5jCmluZGV4IDczNmYxYmUzYjFkLi5iNzNlY2I4MjFlNCAxMDA2NDQK
LS0tIGEvaHcvaW50Yy9oZXgtbDJ2aWMuYworKysgYi9ody9pbnRjL2hleC1sMnZpYy5jCkBAIC00
NDgsMTIgKzQ0OCwxNiBAQCBzdGF0aWMgdm9pZCBsMnZpY19pbnRlcmZhY2VfdXBkYXRlX3ZpZF9p
bXBsKEhleEwyVmljSW50ZXJmYWNlICppZmFjZSwKICAgICBsMnZpY191cGRhdGVfYWxsKHMpOwog
fQogCi1zdGF0aWMgdm9pZCBsMnZpY19pbnRlcmZhY2VfY2xlYXJfaW50ZXJydXB0X2ltcGwoSGV4
TDJWaWNJbnRlcmZhY2UgKmlmYWNlKQorc3RhdGljIHZvaWQgbDJ2aWNfaW50ZXJmYWNlX2NsZWFy
X2ludGVycnVwdF9pbXBsKEhleEwyVmljSW50ZXJmYWNlICppZmFjZSwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBtYXNrKQogewogICAg
IEhleEwyVklDU3RhdGUgKnMgPSBIRVhfTDJWSUMoaWZhY2UpOworICAgIGNvbnN0IHVpbnQzMl90
IHNpemUgPSBMMlZJQ19JTlRFUlJVUFRfTUFYOworICAgIGNvbnN0IHVpbnQzMl90IGFjdGl2ZV9p
cnEgPSBmaW5kX2ZpcnN0X2JpdDMyKHMtPmludF9zdGF0dXMsIHNpemUpOwogCi0gICAgaWYgKHMt
PnZpZCA8IEwyVklDX0lOVEVSUlVQVF9NQVgpIHsKLSAgICAgICAgY2xlYXJfYml0MzIocy0+dmlk
LCBzLT5pbnRfc3RhdHVzKTsKKyAgICAvKiBWSUQgZ3JvdXAgbiBpcyBkZWxpdmVyZWQgb24gQ1BV
IGludGVycnVwdCBuICsgMiAqLworICAgIGlmIChhY3RpdmVfaXJxICE9IHNpemUgJiYgKG1hc2sg
JiBCSVQoZ2V0X3ZpZChzLCBhY3RpdmVfaXJxKSArIDIpKSkgeworICAgICAgICBjbGVhcl9iaXQz
MihhY3RpdmVfaXJxLCBzLT5pbnRfc3RhdHVzKTsKICAgICB9CiAgICAgbDJ2aWNfdXBkYXRlX2Fs
bChzKTsKIH0KZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggN2NjMzI3YmIzNmYuLjQwODkxZTVlZTFhIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYwpAQCAtMTY4NiwyNiArMTY4NiwzMCBAQCB2b2lkIEhFTFBFUihyYWlzZV9zdGFj
a19vdmVyZmxvdykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNsb3QsCiB2b2lkIEhF
TFBFUihjaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKIHsKICAgICB1
aW50MzJfdCBpYWQ7CisgICAgdWludDMyX3Qgd2FzX3NldDsKICAgICBIZXhhZ29uQ1BVICpjcHU7
CiAKICAgICBCUUxfTE9DS19HVUFSRCgpOwogICAgIGNwdSA9IGVudl9hcmNoY3B1KGVudik7CiAg
ICAgaWYgKGNwdS0+Y2ZnLmhleF9kZWYtPmhleF92ZXJzaW9uID49IEhFWF9WRVJfVjgxKSB7CiAg
ICAgICAgIGlhZCA9IGhleGFnb25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhf
U1JFR19JQUQsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJl
YWRJZCkgJiB+bWFzazsKLSAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfd3JpdGUoY3B1LT5nbG9i
YWxyZWdzLCBIRVhfU1JFR19JQUQsIGlhZCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBlbnYtPnRocmVhZElkKTsKKyAgICAgICAgd2FzX3NldCA9IGlhZCAmIG1hc2s7Cisg
ICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3dyaXRlKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdf
SUFELCBpYWQgJiB+bWFzaywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50
aHJlYWRJZCk7CiAgICAgfSBlbHNlIHsKICAgICAgICAgdWludDMyX3QgaXBlbmRhZCA9CiAgICAg
ICAgICAgICBoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdf
SVBFTkRBRCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJ
ZCk7CiAKLSAgICAgICAgZlNFVF9GSUVMRChpcGVuZGFkLCBJUEVOREFEX0lBRCwKLSAgICAgICAg
ICAgICAgICAgICBmR0VUX0ZJRUxEKGlwZW5kYWQsIElQRU5EQURfSUFEKSAmIH5tYXNrKTsKKyAg
ICAgICAgaWFkID0gZkdFVF9GSUVMRChpcGVuZGFkLCBJUEVOREFEX0lBRCk7CisgICAgICAgIHdh
c19zZXQgPSBpYWQgJiBtYXNrOworICAgICAgICBmU0VUX0ZJRUxEKGlwZW5kYWQsIElQRU5EQURf
SUFELCBpYWQgJiB+bWFzayk7CiAgICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3dyaXRlKGNwdS0+
Z2xvYmFscmVncywgSEVYX1NSRUdfSVBFTkRBRCwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaXBlbmRhZCwgZW52LT50aHJlYWRJZCk7CiAgICAgfQotICAgIGwydmljX2NsZWFyX2lu
dGVycnVwdChjcHUtPmwydmljKTsKKyAgICAvKiBPbmx5IGFuIGludGVycnVwdCB0aGF0IHdhcyB0
YWtlbiwgb3Igc2V0IHdpdGggc2lhZCwgY2FuIGJlIGNsZWFyZWQgKi8KKyAgICBsMnZpY19jbGVh
cl9pbnRlcnJ1cHQoY3B1LT5sMnZpYywgd2FzX3NldCk7CiAgICAgaGV4X2ludGVycnVwdF91cGRh
dGUoZW52KTsKIH0KIAotLSAKMi4zNC4xCgo=

