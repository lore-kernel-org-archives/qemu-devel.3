Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410EAC36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 19:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1s8A-0001k9-PL; Mon, 07 Apr 2025 15:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1s7q-0001gU-KC
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 15:27:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1s7p-0002k2-3D
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 15:27:18 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537ITSLc017471
 for <qemu-devel@nongnu.org>; Mon, 7 Apr 2025 19:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UXS2kKh202fdZ0f/nl2ZPKDjzS86kYapgLyIhkg2tmc=; b=T44IRUXTy9uY3PF7
 tvQO9RiaszJnYC8Iy9bCVSfDwxRims66aa8kH4AAWtgeF3aOVhgb/z2k0B5qCcp5
 zjRNdc4DTDNzkAik2bB78utG5qRBv6GbJP6JGkiV3T5yS/HLgFIZldjZp9GtQQPn
 AGkduYvuKoY8gfDemuUO7jz/FXv60Zi/PO6TCmSo493Wv59V6G0ZFsbv4cOdnUSx
 YdT8NRGHtLy7A76H/dnFd4gWaNaQ64Hsivec2/8QjufilLnRK203ZTjFgz+IHggV
 NT1wsiUYpenJdCvy4mpyQCENm4ZsTGdsQ3sTGe/ZzQx1zASguYjry+5W23bXMpIx
 DV9YXA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twg3d9w6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 19:27:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2264e5b2b7cso39511885ad.2
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 12:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744054033; x=1744658833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UXS2kKh202fdZ0f/nl2ZPKDjzS86kYapgLyIhkg2tmc=;
 b=A1sqF71NH73LMHcoK1lfQ1yD+LueTbMPYUcGWBMGJgPAx4o3NBcDc1N3yZkgkGlfA8
 xGfOSjn86K7/QT69Hp2ZavKrjNBgbzwpEWx7Xp9qb6SVqtl24UeuwfDvk4P5SrUkpErk
 uzZBrNgx57Jl1u2fNm1R6zqzPvCDJ2LGw0sNsN53SuH98Bnb+QJzn/brCXWP4l9RbWLr
 ZxU0gCirZXDEp7nOnWn4Lo06epxLsPJ56zNPdoQkCGxq2iPy1RnT7EvyBtupA07xNSDY
 KGBvZIWyD3HINSa3MtYGyQyTl+NDu0rTQZSA46utiQKtDjKrFLhhzn/KKKDzHA6ZHRN7
 JzRQ==
X-Gm-Message-State: AOJu0YyWJylOA5/A4TcB1Y4dkhVcXajpp8vPAnUa3bm0x68se1M4E1rR
 WW1XLCX4DLdGA46vV2YxCMxSPMxV01Ahly7nILcJZ58Hgs4gloUkZMk0uTQNWk1Zd1Biw/U9nEx
 HoMoOeWUxJ8v/TdxPW8uuTJ9PIpNcnCrS1mDN93UPATCtbv3VLQabSvfxoF9Zyg==
X-Gm-Gg: ASbGncuWUotnS+wSLOkPIFW8hHBAQWpA2F1Z2ouerM4NkT9TJgF+CQCCySSpSIOh1gc
 J/QX/cIMNaxCrdzyHeCmqqme6bu1hLzCV4QQ3LMJ4/DZuQ39Af+hOO6XwwFD93j9GE0qIUnvJDc
 ej3pJPLKVud1UT2n6aCRLrPGVqTQALNZ0qAKNXQvS/xz45aH+yGKaC+MLq/buZwYQ3qhHyKUJuX
 JdFmdVs8pTCRJs7VbXn6TVC4YwzYGRZuW2lfNzhX52dvJ9jWpdXKPyVDGq+r7oQWKhDvUKw/hBX
 9D4bemZc5/O2XmUotsBBv1rcVtZfB3KKRNjgWT70nfpiEDFG9k6MZZP+HN6KmwTw
X-Received: by 2002:a17:902:d4c9:b0:223:432b:593d with SMTP id
 d9443c01a7336-22a8a8e3c86mr175491415ad.42.1744054033013; 
 Mon, 07 Apr 2025 12:27:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGni8P96NHOk/y1JWk6+W81IAXjBlgU3vE+7iLHKu2/OEdworF4FsSpVP9ZkOzCUbsASmDGZw==
X-Received: by 2002:a17:902:d4c9:b0:223:432b:593d with SMTP id
 d9443c01a7336-22a8a8e3c86mr175491215ad.42.1744054032680; 
 Mon, 07 Apr 2025 12:27:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee619sm9206559b3a.52.2025.04.07.12.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 12:27:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com
Subject: [PATCH v3 1/5] target/hexagon: handle .new values
Date: Mon,  7 Apr 2025 12:27:01 -0700
Message-Id: <20250407192705.2605614-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407192705.2605614-1-brian.cain@oss.qualcomm.com>
References: <20250407192705.2605614-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: N3ozXeg9rCbOURDSDNhXkC3aI0gV_0nT
X-Proofpoint-ORIG-GUID: N3ozXeg9rCbOURDSDNhXkC3aI0gV_0nT
X-Authority-Analysis: v=2.4 cv=I/9lRMgg c=1 sm=1 tr=0 ts=67f42713 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=G8g7tdY8SUdx2gpfVe8A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_05,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=393 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070136
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgfCAyMiArKysrKysrKysrKysrKysrKy0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IGIvdGFyZ2V0L2hleGFnb24v
aGV4X2NvbW1vbi5weQppbmRleCA3NThlNWZkMTJkLi42ODAzOTA4NzE4IDEwMDc1NQotLS0gYS90
YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9jb21t
b24ucHkKQEAgLTM1MCw2ICszNTAsNyBAQCBkZWYgaGVscGVyX2FyZyhzZWxmKToKICAgICAgICAg
ICAgIGYie3NlbGYuaGVscGVyX2FyZ190eXBlKCl9IHtzZWxmLmhlbHBlcl9hcmdfbmFtZSgpfSIK
ICAgICAgICAgKQogCisKICMKICMgRXZlcnkgcmVnaXN0ZXIgaXMgZWl0aGVyIFNpbmdsZSBvciBQ
YWlyIG9yIEh2eAogIwpAQCAtMTA3MCwxMSArMTA3MSwyMiBAQCBkZWYgaW5pdF9yZWdpc3RlcnMo
KToKICAgICBmb3IgcmVnIGluIG5ld19yZWdzOgogICAgICAgICBuZXdfcmVnaXN0ZXJzW2Yie3Jl
Zy5yZWd0eXBlfXtyZWcucmVnaWR9Il0gPSByZWcKIAotZGVmIGdldF9yZWdpc3Rlcih0YWcsIHJl
Z3R5cGUsIHJlZ2lkKToKLSAgICBpZiBmIntyZWd0eXBlfXtyZWdpZH1WIiBpbiBzZW1kaWN0W3Rh
Z106Ci0gICAgICAgIHJldHVybiByZWdpc3RlcnNbZiJ7cmVndHlwZX17cmVnaWR9Il0KLSAgICBl
bHNlOgotICAgICAgICByZXR1cm4gbmV3X3JlZ2lzdGVyc1tmIntyZWd0eXBlfXtyZWdpZH0iXQor
ZGVmIGlzX25ld19yZWcodGFnLCByZWdpZCk6CisgICAgaWYgcmVnaWRbMF0gaW4gIk5PIjoKKyAg
ICAgICAgcmV0dXJuIFRydWUKKyAgICByZXR1cm4gcmVnaWRbMF0gPT0gIlAiIGFuZCBcCisgICAg
ICAgICAgIGYie3JlZ2lkfU4iIGluIHNlbWRpY3RbdGFnXSBhbmQgXAorICAgICAgICAgICBmInty
ZWdpZH1WIiBub3QgaW4gc2VtZGljdFt0YWddCisKK2RlZiBnZXRfcmVnaXN0ZXIodGFnLCByZWd0
eXBlLCByZWdpZCwgc3VidHlwZT0iIik6CisgICAgcmVnaWQgPSBmIntyZWd0eXBlfXtyZWdpZH0i
CisgICAgaXNfbmV3ID0gaXNfbmV3X3JlZyh0YWcsIHJlZ2lkKQorICAgIHRyeToKKyAgICAgICAg
cmVnID0gbmV3X3JlZ2lzdGVyc1tyZWdpZF0gaWYgaXNfbmV3IGVsc2UgcmVnaXN0ZXJzW3JlZ2lk
XQorICAgIGV4Y2VwdCBLZXlFcnJvcjoKKyAgICAgICAgcmFpc2UgRXhjZXB0aW9uKGYiVW5rbm93
biB7J25ldyAnIGlmIGlzX25ldyBlbHNlICcnfXJlZ2lzdGVyIHtyZWdpZH0iICtcCisgICAgICAg
ICAgICAgICAgICAgICAgICBmImZyb20gJ3t0YWd9JyB3aXRoIHN5bnRheCAne3NlbWRpY3RbdGFn
XX0nIikgZnJvbSBOb25lCisgICAgcmV0dXJuIHJlZwogCiBkZWYgaGVscGVyX3JldF90eXBlKHRh
ZywgcmVncyk6CiAgICAgIyMgSWYgdGhlcmUgaXMgYSBzY2FsYXIgcmVzdWx0LCBpdCBpcyB0aGUg
cmV0dXJuIHR5cGUKLS0gCjIuMzQuMQoK

