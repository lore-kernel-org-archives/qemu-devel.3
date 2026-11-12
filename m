Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29510606DF08
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pjC3Q5Ux;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A6mxWurT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRYlS-00081Z-Pf; Thu, 12 Nov 2026 12:39:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xRYlQ-0007z8-Pm
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:39:08 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xRYlP-0008BY-49
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:39:08 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFZZin656979
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 17:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=MwNga2zOrEx6+Gjtgg+0h8
 7xqxhsdgaBclXJDDgOlIo=; b=pjC3Q5Uxte9Qqpfcy7EBGOJzFp9QT7VcwNwq6M
 dbpEr+iUG6KrroGYbo/zN4/U6qhW4CMF747a2JGhGm+BPmSUZnG6hl1McjhcLQwv
 YxdjCpy/uYWy9SlQYyynMLrV0oaV3qENBRcnXLLycPnras0Xz5M0mo5zkemcYkRX
 Fsv95vETz6GOLOPipAbq4GUaa0pWuZeifJep5VJ42YXtuuksIySq1+0BAWiTAGHy
 rFFI1CKOfcDKh9FP2+wWae84JG/xRXI0gLUP6/5j5qRbjyCDu0pYa+8Iwx/J9JRv
 +WTtkY2SfOJVKRR79s9CBzjE0bQlzAhs7qaxgY2I4pB6DVng==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6yujrms-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 17:39:04 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1383723dfddso6341744c88.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 09:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794505144; x=1795109944; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MwNga2zOrEx6+Gjtgg+0h87xqxhsdgaBclXJDDgOlIo=;
 b=A6mxWurTPc/Gp92UXghfGREkkfazUy2AjkrZnxs3pX2RCEwNRMX68f3AHX3pRrFmDL
 JpTTdDaueg2xYsxk3QjTe8ZHtP8A87I9r6TnZctSb3Wq9QZT20EIhhnsYuv3iYV4rC0h
 +EBFJJ/8+6suoQAHn3ur7YTlu6H4UlRVvVKhGBA1a1JpWshi2egZNs2Hc8gqRrxYo3XB
 zGhVHQ8JnN8v3oyKziR8yQvIQ8XW3Ahjvnjc6laTOE7hqA99/XOZbihqCqVzCmNF5sOB
 opJj/VVJrUKSY22CnTmYBUrEIreq/SaJ7v/4oKI0NYdqBLWqFC3V8peeKZwmw8ewnKtK
 S/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505144; x=1795109944;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MwNga2zOrEx6+Gjtgg+0h87xqxhsdgaBclXJDDgOlIo=;
 b=PAjIXx7Zs+2Tm3cdVX7uu6HT2FWUZk7ZdwpDAj+ieQZfulFLHdRAjpJvOKcWet/2XW
 DZreYiXl3FUcBoHsGC9+NtjDpTkja2X2JnxYhycvE09L0tTV8C+VtoHM3/aQvaeYFhrR
 +bLQBqKs9bua1DOfoFSB4yKeu+1v9ykA0DQhHJdeB6y8VBVRGZKT+dHy3ORgX2u2AsYJ
 RbTpTE6x6qlzQ+XXIYdPqssev56ZsTNKN3EguDF+PRpm+7/ceHnM/QoNlfZ3ZaLdaO4Q
 N/neJVGBbhbT0t84Ojk9R+O1dWVlRaghPJp9T7HDOdYym2yMLUX1vSQ7k7OL/+gmQ8cL
 XWqg==
X-Gm-Message-State: APuU4Z8w8mYLRNQDaOz8HedKcrbQH+54o3DVHJ4z7WBiDrFo5EZnvg05
 YvlQB20eGNFof7sozPL2PPWAZ7WqkHrbDuLBFAzv7B1RxjjH5Be0u9ms3M/SxUZ3IYskhxGuOid
 kRxSGUUV1cPQUSD4/Uv08C2JRlTBOn3EzAMpYjMZFiRcqscxJ3HC2KB6a4NjgOd245Q==
X-Gm-Gg: AYBFou0BbiD3h3meAWpZf1bgcmF0lDLqICY2ThlY8kqVbNOVR1uaOHEz7cKVcDhexPT
 njKdZ5sHj2WxvmQRwDmFrbC+theqS4BeeWvSmUex3nSMhugZoqKFqmeAt37vTPnBKUmkV78rr66
 xBu8Eny2mdmz8k7+SeJDRC93PL4ee+Hfzilhk0sFRUJq/FHWjzMjsMSzBiXfbkSamopvK31gG18
 bRTLoVJaQHHi9M7PSR6zD2ZgR3oTFkWTpUCtA5T7YqYhcqttY93A8zyXsUyDZvvFtKyI4PmJAPo
 vF1kggsSyhPiOFOvJX7g1L62uJwYCIrL3HjYtGa2EVeBTDTzxe7JLij2TD4F9nX19OnwIYtFi9K
 Glb0vXjtcRuB6Ql8uLTrkY5YAUGE5updeGWnuIIaUD2+VUW2vXMO8K0IpScX//Ny3cnQsoul52l
 YoCeq/br4Uzl/EdndX1pL7
X-Received: by 2002:a05:7022:3a03:b0:1b3:755a:ec49 with SMTP id
 a92af1059eb24-1b503157e74mr201099c88.40.1794505143953; 
 Thu, 12 Nov 2026 09:39:03 -0800 (PST)
X-Received: by 2002:a05:7022:3a03:b0:1b3:755a:ec49 with SMTP id
 a92af1059eb24-1b503157e74mr201078c88.40.1794505143193; 
 Thu, 12 Nov 2026 09:39:03 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031918c7sm693020c88.9.2026.11.12.09.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:39:02 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 0/2] roms: omit the git reference to h2
Date: Thu, 12 Nov 2026 09:38:59 -0800
Message-Id: <20261112173901.3748880-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 6zilTV_mV_dmJ-fQoeGiZ_DObTmSjg39
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3MCBTYWx0ZWRfX5LqtUW8yXQ+U
 29NeoBMeG+iURe8SIN7FTGFWqMrRAnXsZEYP1mk9DKxhLis8QKaV/rypmx7PgyzJKx/ZvciqQpd
 LvlydevW80H8PIDqg52VVaPnLG1t79U=
X-Proofpoint-ORIG-GUID: 6zilTV_mV_dmJ-fQoeGiZ_DObTmSjg39
X-Authority-Analysis: v=2.4 cv=d49gWhjE c=1 sm=1 tr=0 ts=6af5f9b8 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=m3dqjBB6mEbZ7OjFtNUA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3MCBTYWx0ZWRfX80v7bRiq1b+s
 t+ph9qsGVkVpfs8tXqvg7aaWWVN/NJAtZcu2BIRk6deY2uuQAU9rBIuO3xuf4zrvpkN4e1Bfm+u
 POgUbobbdWxkPVre4zv1EIJC8OEt4MHSg73il/EL5NNcrAHR0pwEpprCuNvEw62ycPVsfKJ4LcX
 V0IoNU2EsjQ65QSVrKVcFJmsWn3E2jzeXIob+ct9cr00RDnFqrZxlKtDZsnNsNoHj0P3EXVHEE4
 xbnf4/F49bO6V7ripZ12mdQFBKiwbVFR5uOtsR9VlqX+8gxf+JNheEHlaOrUkfw2Du8IlQfe8c9
 fQRtW+5zpVLQqK3SbQRIx35XQ92qFQm2+OnyvM+4D2UHdr3OCg+yFdEecioQ1Ubl2FxIr8U2IYY
 E70DxuvaF+ftJLC+ynmmkDnBpl3liK54wHoqnnBIe2Da8f2NPRWODRSa7NthxwDum6izvHawlLe
 rsmL98qB3EDcjroePPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120070
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VXNpbmcgYGdpdCByZXYtcGFyc2VgIGRvZXNuJ3QgbWFrZSBhbnkgc2Vuc2UgZm9yIGEgc291cmNl
IHRhcmJhbGwKZGlzdHJpYnV0aW9uLgoKU3dpdGNoIHRvIHRoZSBwcm9jZXNzIHVzZWQgYnkgZWRr
MjogY2FwdHVyZSB0aGUgdmVyc2lvbiBpbiBhIG1ha2VmaWxlCmluc3RlYWQuCgpCcmlhbiBDYWlu
ICgyKToKICByb21zOiByZWNvcmQgdGhlIEgyIGNvbW1pdCBpbiBhIGZpbGUKICBwYy1iaW9zOiBy
ZWJ1aWxkIEgyIGZpcm13YXJlCgogTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAxICsKIHBjLWJpb3MvUkVBRE1FICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
NyArKystLS0tCiBwYy1iaW9zL2hleGFnb25fYm9vdGVyX3FjczY0OTBfY2RzcCAgICAgfCBCaW4g
Mjg1MjkyIC0+IDI4NTI5MiBieXRlcwogcGMtYmlvcy9oZXhhZ29uX2Jvb3Rlcl9zYTg3NzVwX2Nk
c3AgICAgIHwgQmluIDI4MTIyNCAtPiAyODEyMjQgYnl0ZXMKIHBjLWJpb3MvaGV4YWdvbl9ib290
ZXJfc2E4Nzk3cF9uc3AwICAgICB8IEJpbiAyODg5MDQgLT4gMjg4OTA0IGJ5dGVzCiBwYy1iaW9z
L2hleGFnb25fYm9vdGVyX3NjODQ4MHhwX25zcDAgICAgfCBCaW4gMjg4OTA4IC0+IDI4ODkwOCBi
eXRlcwogcGMtYmlvcy9oZXhhZ29uX2Jvb3Rlcl9zbTg5NzVfbnNwICAgICAgIHwgQmluIDI4ODkw
MCAtPiAyODg5MDAgYnl0ZXMKIHBjLWJpb3MvaGV4YWdvbl9sb2FkbGludXhfcWNzNjQ5MF9jZHNw
ICB8IEJpbiAyMDA0MjggLT4gMjAwNDI4IGJ5dGVzCiBwYy1iaW9zL2hleGFnb25fbG9hZGxpbnV4
X3NhODc3NXBfY2RzcCAgfCBCaW4gMjAwNDU2IC0+IDIwMDQ1NiBieXRlcwogcGMtYmlvcy9oZXhh
Z29uX2xvYWRsaW51eF9zYTg3OTdwX25zcDAgIHwgQmluIDIwODEzNiAtPiAyMDgxMzYgYnl0ZXMK
IHBjLWJpb3MvaGV4YWdvbl9sb2FkbGludXhfc2M4NDgweHBfbnNwMCB8IEJpbiAyMDgxNDAgLT4g
MjA4MTQwIGJ5dGVzCiBwYy1iaW9zL2hleGFnb25fbG9hZGxpbnV4X3NtODk3NV9uc3AgICAgfCBC
aW4gMjA4MTMyIC0+IDIwODEzMiBieXRlcwogcm9tcy9NYWtlZmlsZSAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDEzICsrKysrKysrKysrLS0KIHJvbXMvaGV4YWdvbi1oeXBlcnZpc29yLXZl
cnNpb24gICAgICAgICB8ICAgMSArCiAxNCBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHJvbXMvaGV4YWdvbi1oeXBlcnZp
c29yLXZlcnNpb24KCi0tIAoyLjM0LjEKCg==

