Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF2AC9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9Z-00055u-JJ; Thu, 24 Sep 2026 21:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9S-0004zM-5M
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9P-0005tr-Vh
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:01 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1kpRG155525
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mSFZtLAuVFymlxGuE/xeSBNBNcWYKAtnUcskIIJlCHU=; b=QWrqPAy+9j7mdmpm
 Fj4JTtrS4W7KcQwzgJKg+t8/mQ+IGogCvrd6fvmHxm16STolOI564JHE9Y1XXIs3
 PIDhhAZjPcg54qwbc/fhGxpRXM5J5LYBV9nOkzVoHg5QkM4upPHwfWY5Po+PKImI
 277YSdGQnOdvG6xhpGeDZjG1qcicIMempNCIxHXLSyCnMYbgMpzPjdxLBZxefm6L
 Sf5TccEFgmOZ03VWjoNGpFfbGRzEUJBs8BEjWiqS0A46DAp4uHrMPKUnhGF+en+b
 DmhWeNNRR3xPx8QN0Bfg0fNugkkpWZA/ORbbc1pp3K4KvY5T4OmUtuiG9lhn22CU
 C6U2yw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1tjkd7v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:58 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33310847fcaso651484eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301298; x=1790906098; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mSFZtLAuVFymlxGuE/xeSBNBNcWYKAtnUcskIIJlCHU=;
 b=IqE3jvYkaQtGM3T2wihnw8ve656EiIEXiJlVT+vVOGaymtNjT1Ad+BK4aiJXmU0ptY
 rqGFg9jlzNd+SOkXeGnlzMrQ+r49puc+qYYHFpTeGPrW3frpd8cDPDebqKwiGy7lvUS0
 WqMCwiBGQ9fizCBnuSON/VTwE2H53L5nH8jP1gZub7dnrxI5P6U57kNtnfw7sA9CR8xH
 q1PAujhqBQQZXNFTlJ++Yhl31iaNsS1I1k94n765dR1w9Smnlri6mQQoXVK7hxu283wH
 fdkv5EuEhfPC72+Z70bVpWrfq2XMbd87iu50fuywDdWJ/arZLR50MwFLHyDQa5UPPXNF
 wcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301298; x=1790906098;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mSFZtLAuVFymlxGuE/xeSBNBNcWYKAtnUcskIIJlCHU=;
 b=Hd00dV4tfpHkFg9FOxN/0wQs6j6N4PSVw1l+RmoExTqJdPQREvXgbcH97bH40q3++B
 WOWPQK7AWx1H/jtrGK1r5O6gDDrfNX1PZwOx6hbNlkAYed0aCxyT24AGQmGERhOqTY6W
 2hMeDCbjes+RuX/LGadgM9pabGhHwNkJTuqdC9JJRFrQ3PQNywqJ4vabTFFOhxqhFRI7
 pBLXZDQtLS9Q3nsWqwCu2okjMSpfKUV3xXmLpYZRNyfjgwrZTV37hLXWuSdUHOKMgwWe
 PXDboK6AJgRc7VpHVhQeadEbZgjbbxXFGNiwJtHWy6nNDmlnEES8fl5nDMD2SVewdaeA
 Tmjg==
X-Gm-Message-State: AFuF++n2dl/GpDbPAdF1SLeZnkvjpQ8MHrfvFAnfAbu8aIj89LQbecDg
 JlkUSrLHRHUkrr7LmJ8WaRxcSBji3Ggy3z1eQwglQLc+vmVms0UZn1ac2Up0ZNHutdKhEAefnLJ
 DDFN31+EN7I02OrfP38n1XZYSYCxDKBs18L+nc2CnmHcOUjOm87rEwpCSZOBk+OttMw==
X-Gm-Gg: AYBFou1ndNpPTxbc05HiSLyqVHlotHicEH8TEaaf4h2RgVj2/ptxLOUqeTX7tYOx8V7
 tbWxGz36EA/Zv+OoiJ6FD9lg21ELj0XOZcD85mSaLYWSgubxDuwtJ6dxExhzbD+RSSwo4p3hfFd
 HmHtesfbGuEKz5GiyrL5VqPSpGDOZH5F2L62nZsOLcNeM1EAzIeZ/iZ2svqV/P1k+rCv8Q7YSok
 O0PG3b0W8v6ly6x/VIZBlqn0dmFsqTeAfuAWecawjGdsRikxZVFfd5zAGuAHrllS4mFi9d6TUPF
 IRlUJFyxu+AXZmidskfylp8AJlHvg/eXm+AG8ekAZcjoHZ+ijsal7FKtKh6iZ77GUb8wP8GDlMd
 97Dc51WdrmPmpMcznnJ7/RrNJE6jJFa/SvJ1KQADpCFT892I=
X-Received: by 2002:a05:7301:714:b0:33c:1f44:81c1 with SMTP id
 5a478bee46e88-3419a600f7emr370265eec.37.1790301297813; 
 Thu, 24 Sep 2026 18:54:57 -0700 (PDT)
X-Received: by 2002:a05:7301:714:b0:33c:1f44:81c1 with SMTP id
 5a478bee46e88-3419a600f7emr370249eec.37.1790301297197; 
 Thu, 24 Sep 2026 18:54:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:54:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 15/40] tests/tcg/multiarch: suppress UBSan for float-to-int
 conversions
Date: Thu, 24 Sep 2026 18:54:04 -0700
Message-Id: <20260925015429.2579174-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 7qnXhPHOLAQ1FCoPA0G3cMLWOWKs_bbK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfXxLU128bGm0my
 8TNtNB7aw0L2hGuiNZkvYTHXMOnJ7QfkQNiM9aJ2FpK4m6IRiBqtkKSB8RTyUVPPM/VSD9eQW6x
 K07MkPkanKgXn7TiAhiM4ncAwppxu/zU/KBNQY4LfRSLEHy7nAeuDZ9ghVeTeVPZcG+o7aLB8F1
 QpqwSsUI78BWn+AnV+Av6Bqp/s7EyaFjqMB6TKKNE80fRmBeaSw9exQtpiGIjGT22AKvyPBfhCw
 DTLqghkBy884hi19gG45Bw4BOiK1lfTRxafCTlGuG81jz7mwu/1TiBAu42Qu6xvoc4XQvSzXAOx
 zfdchp67ABdKUMTaGCgvTNnBYpB37wArBb0F+q+Ki/NWMlqkpNPwyUKT8Nv69t46ux2J7bJPgPs
 TVqfbpWE0UyaH3xZK16d4Aeb6ggpTofD3F1Ic6tQCIo8DHUakSZo2h4NoiJtnNhVzOO+sqNUxru
 nCuwbDatNp+OZcrt5Jw==
X-Authority-Analysis: v=2.4 cv=cK11IVeN c=1 sm=1 tr=0 ts=6ab5d472 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=mocapJ0rodF7YK2GbI0A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 7qnXhPHOLAQ1FCoPA0G3cMLWOWKs_bbK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX0coKxga28CRh
 d59sSDmexvjJk7AIz/EKm1Q9jDzk934TM3OJN8EjAxv9iL5hCd/fbT56O8s1kBlftvfaAQs3QrZ
 z9EQBiSXE9sHIjISFDYs2Ed04h+koGw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250007
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

QWRkIF9fYXR0cmlidXRlX18oKG5vX3Nhbml0aXplKCJ1bmRlZmluZWQiKSkpIHRvIHRoZSBmbG9h
dC9kb3VibGUKdG8gaW50ZWdlciBjb252ZXJzaW9uIGZ1bmN0aW9ucy4KCkMxNyA2LjMuMS40cDEg
b25seSBkZWZpbmVzIGZsb2F0LXRvLWludGVnZXIgY29udmVyc2lvbiBmb3IgZmluaXRlCnZhbHVl
cyB3aG9zZSBpbnRlZ3JhbCBwYXJ0IGZpdHMgaW4gdGhlIGRlc3RpbmF0aW9uIHR5cGU7IGl0IGRp
c2NhcmRzCnRoZSBmcmFjdGlvbmFsIHBhcnQgYW5kIGV4cGxpY2l0bHkgbWFrZXMgaXQgVUIgaWYg
dGhlIGludGVncmFsIHBhcnQKZG9lc24ndCBmaXQuCgpUaGVzZSB0ZXN0cyBpbnRlbnRpb25hbGx5
IGV4ZXJjaXNlIGJvdGggb2YgdGhvc2UgVUIgY2FzZXMsIHNvIHdlJ2xsIHN1cHByZXNzCml0IHRv
IGdldCBhIGNsZWFuIHVic2FuIHJ1biBvbiB0aGUgVENHIHRlc3Qgc3VpdGUuCgpSZXZpZXdlZC1i
eTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpT
aWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0t
LQogdGVzdHMvdGNnL211bHRpYXJjaC9mbG9hdF9jb252ZC5jIHwgMSArCiB0ZXN0cy90Y2cvbXVs
dGlhcmNoL2Zsb2F0X2NvbnZzLmMgfCAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL211bHRpYXJjaC9mbG9hdF9jb252ZC5jIGIvdGVz
dHMvdGNnL211bHRpYXJjaC9mbG9hdF9jb252ZC5jCmluZGV4IDU4ZDdmOGI0YzU4Li5jYjM4ODRk
Zjk3NCAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL211bHRpYXJjaC9mbG9hdF9jb252ZC5jCisrKyBi
L3Rlc3RzL3RjZy9tdWx0aWFyY2gvZmxvYXRfY29udmQuYwpAQCAtNjIsNiArNjIsNyBAQCBzdGF0
aWMgdm9pZCBjb252ZXJ0X2RvdWJsZV90b19zaW5nbGUoZG91YmxlIGlucHV0KQogI2RlZmluZSBz
dHIoYSkgI2EKIAogI2RlZmluZSBDT05WRVJUX0RPVUJMRV9UT19JTlQoVFlQRSwgRk1UKSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcCisgICAgX19hdHRyaWJ1dGVfXygobm9fc2FuaXRpemUo
InVuZGVmaW5lZCIpKSkgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICBzdGF0aWMgdm9pZCBj
b252ZXJ0X2RvdWJsZV90b18gIyMgVFlQRShkb3VibGUgaW5wdXQpICAgICAgICAgICAgXAogICAg
IHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcCiAgICAgICAgIFRZUEUgIyMgX3Qgb3V0cHV0OyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9tdWx0aWFyY2gv
ZmxvYXRfY29udnMuYyBiL3Rlc3RzL3RjZy9tdWx0aWFyY2gvZmxvYXRfY29udnMuYwppbmRleCBj
YjFmZGQ0MzllMy4uNTg0Y2U4OWFhMTcgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3RjZy9tdWx0aWFyY2gv
ZmxvYXRfY29udnMuYworKysgYi90ZXN0cy90Y2cvbXVsdGlhcmNoL2Zsb2F0X2NvbnZzLmMKQEAg
LTYyLDYgKzYyLDcgQEAgc3RhdGljIHZvaWQgY29udmVydF9zaW5nbGVfdG9fZG91YmxlKGZsb2F0
IGlucHV0KQogI2RlZmluZSBzdHIoYSkgI2EKIAogI2RlZmluZSBDT05WRVJUX1NJTkdMRV9UT19J
TlQoVFlQRSwgRk1UKSAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCisgICAgX19hdHRyaWJ1
dGVfXygobm9fc2FuaXRpemUoInVuZGVmaW5lZCIpKSkgICAgICAgICAgICAgICAgICAgICAgIFwK
ICAgICBzdGF0aWMgdm9pZCBjb252ZXJ0X3NpbmdsZV90b18gIyMgVFlQRShmbG9hdCBpbnB1dCkg
ICAgICAgICAgICAgXAogICAgIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAgICAgIFRZUEUgIyMgX3Qgb3V0cHV0OyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKLS0gCjIuMzQuMQoK

