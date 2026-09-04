Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66529C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 01:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Idj-0007AU-6X; Thu, 03 Sep 2026 21:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Idg-00079M-N3
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 21:22:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Ide-0005JN-W8
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 21:22:44 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683Nbl6U2193162
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 01:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=a+CBXDO4Pm2yaldDRatlLKjTbgDEs6+OwEBymI4oKm8=; b=Jy
 H3JXDTVzrZoptV9Xaw+vjEc9diVx7XE1ItWpXHeHaPFXd+TUL4HcpKq7v2dvzlMm
 AVu3PbZFXWiIHEeYoN/RlCJI5N3Dv/wzcGs96/JxVgZ2XsW8/xK1s5r5AhR86D06
 DxNM28uLsuf+Bldm8LU+oXT8J4YVTjbvRYaE98u0nHPPWfX0PNsmy9U5HBQKdFak
 7QDaUc4nnFfuPSW0fBNYnUwgtiTajRAfgHYXZyBC4IPp5PlPWw+DDlY4rvzu1Mnv
 FwU1OsgUlx/oYoWx+xeUKaxZjoIfH+fYMNATSc9WBtu4NOI0tZgYqVkze2Ek4a3Q
 BFOvCv1VoqJYVAfZGdvg==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6p73tqt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 01:22:41 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-6b1281dd14aso450435eaf.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788484961; x=1789089761; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=a+CBXDO4Pm2yaldDRatlLKjTbgDEs6+OwEBymI4oKm8=;
 b=IUgW24DQmyUlNBxXS5DbeVSxkzfU/ZqLM1RnD+3XzdowaNK4jxHwTTGy/8vRf0Emuv
 nLL3JvvSMsGUVYxpYZLJQTO/hmuHRXZ4TUdOqrCmyNQvgfaTU+xhQpGKW05eNiYP+/yA
 SESV2UWQ2RRgtYXMmCanKarhCALp0yfwlY90sZGCro1piUqMsabdzu48hyW1vtEQwa2E
 6xDUTgK90BgLJXZJIUhuoYFfIgXvPaHaxo4RmAQXuEVMF7XyZPDSGVyoz2Z7XHbkSdYu
 /j0eivpK6iYHno7iXn+xGwmS+3Lwqd9QWTnRZQFlNdUFZHIpunXa3vrN9LxnY60Iqh9o
 rXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788484961; x=1789089761;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a+CBXDO4Pm2yaldDRatlLKjTbgDEs6+OwEBymI4oKm8=;
 b=ddevtR33VnsLyvCGRK/fFcN0VMJKcMtcdbTmSq17+XoXAQGDyHKgb7lc3wKwtyyZiO
 QDyHro26cEbrORzwS/Y2qEWmg12RYsY5lvlLZkdqPFEPFwFzyiqoT9JY0wuLWJyVb3gh
 E2k51weech/JWirl8R8tWiiok2g4LwdgFWvo+SEKulwS5DBADmCSPQmUcyW25i79Nd3X
 tOHRN+F7AFombwgIMeVjyw69ZScfaHOKuZFPdvFQj4+TLBs2bmLKQDGh6zFiBf/PKOje
 U7tODokHuYVndzYsea2ufLM6AtpMSIfGSDwEqzCa5uEdZE6amngTLKK2S43ogS6QvSo6
 YW+A==
X-Gm-Message-State: AFuF++lneuJbojM/k7zm9PUyvSbZwGmMbQBdF5AL6y33IcGmpYbMK2/Y
 v8YeWKuaWWpqwdUIQEHk/13LRYMaBw+ZYeeBDuSYretgg6CiqA4RUzrEhTYx/8XOTokcY4VrDvU
 6fuY8xEPwHWymYWoj4VmNnNCA8FeIYrm/VcntKXcyPreEFv7uzA3y4s3xfvmH8HIUXQ==
X-Gm-Gg: AYBFou2aT4u7Nf2KcmtamwSHZhFaJv+xx34ke2QK4ag0O+zWxO0jb8xfE1ohGZ4NYrz
 y8/WQ6tUg2N6UhqPN78ToHcrTsBR1to8PEAL7gVZSGmqflvEcaDHMBJ/aePtgP4Edw0en3fDze+
 PwokD0zTenX55dleg9nXjDnFWE3mSULIcbsvHvDulFxiXwwH9/ffLKzD7ml5S2DlrNI4j403ANO
 2CiayfDh7AIGA1SLMbcH5uxMFSSbRney8zz89fV+7Yyh7HNgrnkFvB2V+yGHgFbG6irjE/zlXMr
 tP1lNUsoGe+6MNAG7ewRWbYHlzmmnUD4e0L/0FmglxEcWHwgRhfdZUl2nZI/k9KdPzkEgNbgIMI
 uhXcXuha9PuC4zwniUSR6UrUZC0/pesk4yLQVjudaEQOn4OIy
X-Received: by 2002:a05:6820:1888:b0:6b7:46fc:1cb with SMTP id
 006d021491bc7-6b746fc0236mr523047eaf.42.1788484961081; 
 Thu, 03 Sep 2026 18:22:41 -0700 (PDT)
X-Received: by 2002:a05:6820:1888:b0:6b7:46fc:1cb with SMTP id
 006d021491bc7-6b746fc0236mr523026eaf.42.1788484960644; 
 Thu, 03 Sep 2026 18:22:40 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339885ca07sm2573234eec.1.2026.09.03.18.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 18:22:39 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Subject: [PATCH v3 4/5] target/hexagon: fix HVX predicate save size for
 histogram ops
Date: Thu,  3 Sep 2026 18:22:32 -0700
Message-Id: <20260904012233.3607547-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904012233.3607547-1-brian.cain@oss.qualcomm.com>
References: <20260904012233.3607547-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: mYiSfcNXzS4zOme25uDwZKJ8W34Dnfb_
X-Proofpoint-ORIG-GUID: mYiSfcNXzS4zOme25uDwZKJ8W34Dnfb_
X-Authority-Analysis: v=2.4 cv=OZyoyBTY c=1 sm=1 tr=0 ts=6a9a1d61 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=iBrAFeRkQMIbT85dZ3EA:9 a=QEXdDO2ut3YA:10
 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDAxMCBTYWx0ZWRfX77RfprUFJFui
 FY2BKTkNfmLqBGaX+Kahg4Vufdu2Kkrgs02fu9kq9tykr+1HZdbHVJkLEmwBBcC21bssz0vYdi2
 mjaP9Txuk/8ucWAp+p2QMAQDjk8RJU4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDAxMCBTYWx0ZWRfX9DGmLO9jK1o2
 M/5cpfRmfWqV2zccEl2zP6N+PsY0aKWPgSrXFMIwXI5BQkZEu3Loy4w+OP/flJdio2QragLN4I4
 7QhY7hTEOXzaT1Q6cNf48FgOKT6Cki8CZmmi6eXwyJmJ7x3x5aWkxDJX0gMpw5JLTWEEw7jVHw/
 kMEFBhbbAPkDsPjRoQtU2Oj5oFHeQtu0OuxAr9ZjZTi4OFe9psKhacIl4zF4axRJsx+3EkbImU6
 BG40x8COgCUNV3/bIefPdIimy1wAK6SK/nAMPOOvWAdShBK8naQdYGKMDr2+uOw8mZeQUCV2HSr
 r2XiR6obRI+ONRx5HL1aXFS9M2cHPrFmx2ebwiCYgx18V+LRVTXKLmgYlg7hL2JWRUJcwc8PieQ
 BEvj3vHNaBbVgTQ3xXFBHjO8tSg0m/yMQra6OWo2NQuWOg9xpnZIk3UXp83fsAm3W54Ycwd9Pij
 MBoldWFv2FvS6MC1xuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_07,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040010
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

VGhlIG1hc2tlZCBoaXN0b2dyYW0gaW5zdHJ1Y3Rpb25zIHNhdmUgdGhlIHByZWRpY2F0ZSBvcGVy
YW5kIHRvIHRoZSBxdG1wCnRlbXBvcmFyeSB3aXRoIGEgZ3ZlYyBtb3ZlIHNpemVkIHNpemVvZihN
TVZlY3RvcikuIEJvdGggc291cmNlIGFuZApkZXN0aW5hdGlvbiBhcmUgTU1RUmVnLCB3aGljaCBp
cyBlaWdodCB0aW1lcyBzbWFsbGVyLCBzbyB0aGUgbW92ZSByZWFkCjExMiBieXRlcyBwYXN0IHRo
ZSBwcmVkaWNhdGUgcmVnaXN0ZXIgYW5kIHdyb3RlIHRoZW0gb3ZlciB0aGUgZmllbGRzCmZvbGxv
d2luZyBxdG1wIGluIENQVUhleGFnb25TdGF0ZSwgdGhhdCBpcyB2c3RvcmVbMF0uIFVzZSB0aGUg
c2l6ZSBvZgp0aGUgcmVnaXN0ZXJzIGFjdHVhbGx5IGJlaW5nIGNvcGllZC4KCkZpeGVzOiA3YmE3
NjU3YmM5MyAoIkhleGFnb24gSFZYIGhlbHBlciBvdmVycmlkZXMgZm9yIGhpc3RvZ3JhbSAgaW5z
dHJ1Y3Rpb25zIikKUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
b3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5v
IDxtYXRoZXVzLmJlcm5hcmRpbm9Ab3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJp
YW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29u
L2dlbl90Y2dfaHZ4LmggfCAxMCArKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90
Y2dfaHZ4LmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oCmluZGV4IDJhMzQyY2RlZTY5
Li5kM2YyY2M3YmM2MiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaAor
KysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oCkBAIC01MCw3ICs1MCw3IEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBhc3NlcnRfdmhpc3RfdG1wKERpc2FzQ29udGV4dCAqY3R4KQogICAgICAg
ICBpZiAoY3R4LT5wcmVfY29tbWl0KSB7IFwKICAgICAgICAgICAgIGludHB0cl90IGRzdG9mZiA9
IG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgcXRtcCk7IFwKICAgICAgICAgICAgIHRjZ19nZW5f
Z3ZlY19tb3YoTU9fNjQsIGRzdG9mZiwgUXZWX29mZiwgXAotICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzaXplb2YoTU1WZWN0b3IpLCBzaXplb2YoTU1WZWN0b3IpKTsgXAorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzaXplb2YoTU1RUmVnKSwgc2l6ZW9mKE1NUVJlZykpOyBcCiAg
ICAgICAgIH0gZWxzZSB7IFwKICAgICAgICAgICAgIGFzc2VydF92aGlzdF90bXAoY3R4KTsgXAog
ICAgICAgICAgICAgZ2VuX2hlbHBlcl92aGlzdHEodGNnX2Vudik7IFwKQEAgLTY2LDcgKzY2LDcg
QEAgc3RhdGljIGlubGluZSB2b2lkIGFzc2VydF92aGlzdF90bXAoRGlzYXNDb250ZXh0ICpjdHgp
CiAgICAgICAgIGlmIChjdHgtPnByZV9jb21taXQpIHsgXAogICAgICAgICAgICAgaW50cHRyX3Qg
ZHN0b2ZmID0gb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCBxdG1wKTsgXAogICAgICAgICAgICAg
dGNnX2dlbl9ndmVjX21vdihNT182NCwgZHN0b2ZmLCBRdlZfb2ZmLCBcCi0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHNpemVvZihNTVZlY3RvciksIHNpemVvZihNTVZlY3RvcikpOyBcCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihNTVFSZWcpLCBzaXplb2YoTU1RUmVn
KSk7IFwKICAgICAgICAgfSBlbHNlIHsgXAogICAgICAgICAgICAgYXNzZXJ0X3ZoaXN0X3RtcChj
dHgpOyBcCiAgICAgICAgICAgICBnZW5faGVscGVyX3Z3aGlzdDI1NnEodGNnX2Vudik7IFwKQEAg
LTgyLDcgKzgyLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGFzc2VydF92aGlzdF90bXAoRGlzYXND
b250ZXh0ICpjdHgpCiAgICAgICAgIGlmIChjdHgtPnByZV9jb21taXQpIHsgXAogICAgICAgICAg
ICAgaW50cHRyX3QgZHN0b2ZmID0gb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCBxdG1wKTsgXAog
ICAgICAgICAgICAgdGNnX2dlbl9ndmVjX21vdihNT182NCwgZHN0b2ZmLCBRdlZfb2ZmLCBcCi0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihNTVZlY3RvciksIHNpemVvZihNTVZl
Y3RvcikpOyBcCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihNTVFSZWcpLCBz
aXplb2YoTU1RUmVnKSk7IFwKICAgICAgICAgfSBlbHNlIHsgXAogICAgICAgICAgICAgYXNzZXJ0
X3ZoaXN0X3RtcChjdHgpOyBcCiAgICAgICAgICAgICBnZW5faGVscGVyX3Z3aGlzdDI1NnFfc2F0
KHRjZ19lbnYpOyBcCkBAIC05OCw3ICs5OCw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhc3NlcnRf
dmhpc3RfdG1wKERpc2FzQ29udGV4dCAqY3R4KQogICAgICAgICBpZiAoY3R4LT5wcmVfY29tbWl0
KSB7IFwKICAgICAgICAgICAgIGludHB0cl90IGRzdG9mZiA9IG9mZnNldG9mKENQVUhleGFnb25T
dGF0ZSwgcXRtcCk7IFwKICAgICAgICAgICAgIHRjZ19nZW5fZ3ZlY19tb3YoTU9fNjQsIGRzdG9m
ZiwgUXZWX29mZiwgXAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoTU1WZWN0
b3IpLCBzaXplb2YoTU1WZWN0b3IpKTsgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
aXplb2YoTU1RUmVnKSwgc2l6ZW9mKE1NUVJlZykpOyBcCiAgICAgICAgIH0gZWxzZSB7IFwKICAg
ICAgICAgICAgIGFzc2VydF92aGlzdF90bXAoY3R4KTsgXAogICAgICAgICAgICAgZ2VuX2hlbHBl
cl92d2hpc3QxMjhxKHRjZ19lbnYpOyBcCkBAIC0xMTUsNyArMTE1LDcgQEAgc3RhdGljIGlubGlu
ZSB2b2lkIGFzc2VydF92aGlzdF90bXAoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAgIGlmIChj
dHgtPnByZV9jb21taXQpIHsgXAogICAgICAgICAgICAgaW50cHRyX3QgZHN0b2ZmID0gb2Zmc2V0
b2YoQ1BVSGV4YWdvblN0YXRlLCBxdG1wKTsgXAogICAgICAgICAgICAgdGNnX2dlbl9ndmVjX21v
dihNT182NCwgZHN0b2ZmLCBRdlZfb2ZmLCBcCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNpemVvZihNTVZlY3RvciksIHNpemVvZihNTVZlY3RvcikpOyBcCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNpemVvZihNTVFSZWcpLCBzaXplb2YoTU1RUmVnKSk7IFwKICAgICAgICAg
fSBlbHNlIHsgXAogICAgICAgICAgICAgVENHdiB0Y2d2X3VpViA9IHRjZ19jb25zdGFudF90bCh1
aVYpOyBcCiAgICAgICAgICAgICBhc3NlcnRfdmhpc3RfdG1wKGN0eCk7IFwKLS0gCjIuMzQuMQoK

