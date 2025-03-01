Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E9BC282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPf-0000km-4i; Sat, 01 Mar 2025 00:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPd-0000i1-Rr
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:22 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPb-0008P6-CM
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:21 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214Bom7027112
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9H2JfNRmmuuWCm2TVDdMCermZwoCDf412NpA/UH3RyQ=; b=B2EDfir2W+bdsTrO
 GxY/CBfdZZ7e9ZeWhRH2JYjO18bmgwlIZ6obi+4xCm7pFEScZXU1dCz3aNx8cLV4
 lP8z4WmyJ7OoN+mc3fRVUOpv+pPCh4vQxTdFTE0mmSHEeGRY6QhuqdR6vexEIQwx
 MztTxe80KE0Mh1oJcRuu/funIDefM6RMuGiLgjjJQT6ufVF591rPW+l/T0ocVDuo
 hjNA0GU/6mbk4fqHzrBz9B/I/T9AOAJpKwyUj1Hkg1/UBe0Km5aPHdOQezHZRXn3
 2ox1NXvzl2GS1YV9ZjRso1+YSXWALCUl1snr/hMt6o+q7cc57FZ5jXrHQcfQ63nk
 m0tkSQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453u0d037q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:08 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fec3e38b60so2178452a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806947; x=1741411747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9H2JfNRmmuuWCm2TVDdMCermZwoCDf412NpA/UH3RyQ=;
 b=lMjl9vgaBHmauIOdkVQJi4eWO9dguBsAShVcUwLMIW1y6+7mIuTBZ/Bo1Ya5J3DuG4
 /OnAnBwOFhryLbLispCOxrbKYuJp7zrbK18oSvTOVRPImAw2BL9+q9NtdEa6FnpikPw6
 /zUO51D8QMJrcyQo8prK3XRmpBLx7MLuE6QjlrVYaVxxz+FdQk6IkKDKGOR3ngyLN+Yr
 IPSPbKQfP9x6Zo39mAEd+ZWyM/4qPD49M9NmZbw2lKOMVhuCyj2Ob4CzVxpW13B9kfn+
 sDqWnrRYGW6etS8NoVtVATeWgaSjIR4aZkQhcMva0PY7+SG5Hu6y0Yfdmk8OsGK6lKdr
 fkDA==
X-Gm-Message-State: AOJu0YypthXt1QkBiV9Cm61NyusVwmpqdtAxe4iXYq2D8J5hCsxFxXxy
 HDS9neQUaAy1kJX8xVAc7eXkgJaNlup1SCPNDxANPvAN63AjEwGZ6P84XCBOS/L0fp8IB8mw4AH
 JKEuMYgKQVrf4UtUjlAV0a6s8/2LXKt/3hdF2HtUCyzpzL9hZ30iK60ZBPCU1Ow==
X-Gm-Gg: ASbGncuap8+bQ0pZfw/FqFwT0nMlE8PHqwL7aL+SzbdXNESv/+cLfo11HH3bGPsLv+I
 oChg6peZKycfk6oGZbShJY5qWrQCd3oPaFk86UiAipg+FDzboU1u6+W1uy8997tz6exI32BmR/B
 Xuetk3m6rnwJKWDVI0rRmxkx5wI6oGys19yXkXGfjKPY6632ocpS3tlY/zrrrhtUByZZiLbzgfu
 AaTKQwwsh42XhJSxhGWOAuTBebavUtIJZn6nt6yuxO8SJvuIA2syZ74xWZIggVXj7+RNTcdPzdR
 R53C/lFWIFraVqp99WQB8+qFnX9yYdob3vvxAEXq/OBmI/Cb8gVvCezlGMt7wFBK
X-Received: by 2002:a17:90b:3f50:b0:2ee:af31:a7bd with SMTP id
 98e67ed59e1d1-2febab2bdcbmr9121452a91.5.1740806947127; 
 Fri, 28 Feb 2025 21:29:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwFEpdGle6h21DnBPZTxIoFxVC7S2+nEs/vgJiVDgoMd2J4A5fIPdz1Klg92rYWsZpstT0QQ==
X-Received: by 2002:a17:90b:3f50:b0:2ee:af31:a7bd with SMTP id
 98e67ed59e1d1-2febab2bdcbmr9121432a91.5.1740806946767; 
 Fri, 28 Feb 2025 21:29:06 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:06 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 13/39] target/hexagon: Implement modify_syscfg()
Date: Fri, 28 Feb 2025 21:28:19 -0800
Message-Id: <20250301052845.1012069-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: uj1R6gyFZCTR2gpfeZuv6rtG4ZxFKpWD
X-Proofpoint-GUID: uj1R6gyFZCTR2gpfeZuv6rtG4ZxFKpWD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 mlxlogscore=556
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMgfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQog
MSBmaWxlIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBl
ci5jCmluZGV4IDAzYmVkMTFmNmUuLjQyODA1ZDBmMWQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xNTIy
LDcgKzE1MjIsNTYgQEAgc3RhdGljIGJvb2wgaGFuZGxlX3BtdV9zcmVnX3dyaXRlKENQVUhleGFn
b25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcsCiAKIHN0YXRpYyB2b2lkIG1vZGlmeV9zeXNjZmco
Q1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHZhbCkKIHsKLSAgICBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOworICAgIGdfYXNzZXJ0KGJxbF9sb2NrZWQoKSk7CisKKyAgICB1aW50MzJfdCBv
bGQ7CisgICAgdWludDMyX3Qgc3lzY2ZnX3JlYWRfb25seV9tYXNrID0gMHg4MDAwMWMwMDsKKyAg
ICB1aW50MzJfdCBzeXNjZmcgPSBhcmNoX2dldF9zeXN0ZW1fcmVnKGVudiwgSEVYX1NSRUdfU1lT
Q0ZHKTsKKworICAgIC8qIGNsZWFyIHJlYWQtb25seSBiaXRzIGlmIHRoZXkgYXJlIHNldCBpbiB0
aGUgbmV3IHZhbHVlLiAqLworICAgIHZhbCAmPSB+c3lzY2ZnX3JlYWRfb25seV9tYXNrOworICAg
IC8qIGlmIHJlYWQtb25seSBhcmUgY3VycmVudGx5IHNldCBpbiBzeXNjZmcga2VlcCB0aGVtIHNl
dC4gKi8KKyAgICB2YWwgfD0gKHN5c2NmZyAmIHN5c2NmZ19yZWFkX29ubHlfbWFzayk7CisKKyAg
ICB1aW50MzJfdCB0bXAgPSB2YWw7CisgICAgb2xkID0gYXJjaF9nZXRfc3lzdGVtX3JlZyhlbnYs
IEhFWF9TUkVHX1NZU0NGRyk7CisgICAgYXJjaF9zZXRfc3lzdGVtX3JlZyhlbnYsIEhFWF9TUkVH
X1NZU0NGRywgdG1wKTsKKworICAgIC8qIENoZWNrIGZvciBjaGFuZ2UgaW4gTU1VIGVuYWJsZSAq
LworICAgIHRhcmdldF91bG9uZyBvbGRfbW11X2VuYWJsZSA9IEdFVF9TWVNDRkdfRklFTEQoU1lT
Q0ZHX01NVUVOLCBvbGQpOworICAgIHVpbnQ4X3Qgb2xkX2VuID0gR0VUX1NZU0NGR19GSUVMRChT
WVNDRkdfUENZQ0xFRU4sIG9sZCk7CisgICAgdWludDhfdCBvbGRfZ2llID0gR0VUX1NZU0NGR19G
SUVMRChTWVNDRkdfR0lFLCBvbGQpOworICAgIHRhcmdldF91bG9uZyBuZXdfbW11X2VuYWJsZSA9
CisgICAgICAgIEdFVF9TWVNDRkdfRklFTEQoU1lTQ0ZHX01NVUVOLCB2YWwpOworICAgIGlmIChu
ZXdfbW11X2VuYWJsZSAmJiAhb2xkX21tdV9lbmFibGUpIHsKKyAgICAgICAgaGV4X21tdV9vbihl
bnYpOworICAgIH0gZWxzZSBpZiAoIW5ld19tbXVfZW5hYmxlICYmIG9sZF9tbXVfZW5hYmxlKSB7
CisgICAgICAgIGhleF9tbXVfb2ZmKGVudik7CisgICAgfQorCisgICAgLyogQ2hhbmdpbmcgcGN5
Y2xlIGVuYWJsZSBmcm9tIDAgdG8gMSByZXNldHMgdGhlIGNvdW50ZXJzICovCisgICAgdWludDhf
dCBuZXdfZW4gPSBHRVRfU1lTQ0ZHX0ZJRUxEKFNZU0NGR19QQ1lDTEVFTiwgdmFsKTsKKyAgICBD
UFVTdGF0ZSAqY3M7CisgICAgaWYgKG9sZF9lbiA9PSAwICYmIG5ld19lbiA9PSAxKSB7CisgICAg
ICAgIENQVV9GT1JFQUNIKGNzKSB7CisgICAgICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKl9lbnYg
PSBjcHVfZW52KGNzKTsKKyAgICAgICAgICAgIF9lbnYtPnRfY3ljbGVfY291bnQgPSAwOworICAg
ICAgICB9CisgICAgfQorCisgICAgLyogU2VlIGlmIGdsb2JhbCBpbnRlcnJ1cHRzIGFyZSB0dXJu
ZWQgb24gKi8KKyAgICB1aW50OF90IG5ld19naWUgPSBHRVRfU1lTQ0ZHX0ZJRUxEKFNZU0NGR19H
SUUsIHZhbCk7CisgICAgaWYgKCFvbGRfZ2llICYmIG5ld19naWUpIHsKKyAgICAgICAgcWVtdV9s
b2dfbWFzayhDUFVfTE9HX0lOVCwgIiVzOiBnbG9iYWwgaW50ZXJydXB0cyBlbmFibGVkXG4iLCBf
X2Z1bmNfXyk7CisgICAgICAgIGhleF9pbnRlcnJ1cHRfdXBkYXRlKGVudik7CisgICAgfQorCisg
ICAgaWYgKHFlbXVfbG9nbGV2ZWxfbWFzayhMT0dfVU5JTVApKSB7CisgICAgICAgIGludCBuZXdf
djJ4ID0gR0VUX1NZU0NGR19GSUVMRChTWVNDRkdfVjJYLCB2YWwpOworICAgICAgICBpZiAoIW5l
d192MngpIHsKKyAgICAgICAgICAgIHFlbXVfbG9nKCJIVlg6IDY0IGJ5dGUgdmVjdG9yIGxlbmd0
aCBpcyB1bnN1cHBvcnRlZFxuIik7CisgICAgICAgIH0KKyAgICB9CiB9CiAKIHN0YXRpYyB1aW50
MzJfdCBoZXhhZ29uX2ZpbmRfbGFzdF9pcnEoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90
IHZpZCkKLS0gCjIuMzQuMQoK

