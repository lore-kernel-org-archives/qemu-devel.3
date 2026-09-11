Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086A8C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x53lW-0004UC-S5; Fri, 11 Sep 2026 12:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x53ji-0003O8-Jo
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:04:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x53jX-0007fM-FI
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:04:20 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEm8e91090832
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 16:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xEFAh1HFV0i/H+w7ei/PWkJX8KOTiQmMzcK6J5qrQPk=; b=mDxit83eRZv4O1QP
 BtR5gUUUZvHe43n1VBJfA5set/QyCqCxiT/Sn1WgmVrTcI28rSVOyEcPshvHc+S0
 ZiURTpeySTurMNNgoGE6NOYuDiMG7NtwMAFGr1LrRpmDUO8HfwyhY+srhmzYota6
 fA36IkFD79CTFyU+L1YJTfh+8Gy5Qc27cUzx/Fy7gEpu0CIgKJHBYyG4d8JXBkTW
 SLgguGdq4y5wLvv+3gpFFJSMpSnjmXrGu0PNyqRa6K6oh2o9+bPyde4340zD1WOH
 2Oa01yg2VetOq7wYZTgmKLf8RgQrI+7GkdRSlCFTiFDn5LNOrDAGbUZNuZl6tbM2
 cLALug==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbd3anwa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 16:04:08 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4b5bfffcc2dso1073053b6e.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789142648; x=1789747448; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xEFAh1HFV0i/H+w7ei/PWkJX8KOTiQmMzcK6J5qrQPk=;
 b=Nfn0I4HPK8Isf5kslhv2NGiO0UsC6lj+boR7DSfgMu+fqecCFZ1yaYWe5Aqh3D8Fm9
 S7KUYtsKbCqwTjCSOwgussKvHY1ROmiQWRd3i8cVbBFe4zbUt+CNBUoF22dq82M/67yC
 LUerRzpIJEjY7RJP54L4wI1/22XQWMdlS41wUX4mjwSIgStvR+As85pmMd85U/dY0VQO
 3wW+yZNR1s/JJHEiBDfgLKRX+VDeSnYOy8u05gJuYbmliPXIZ3NeVupkqcBqhMy1Yk6/
 FlcuC9gROlV/OTsHy1ApQSs0N0pO3Wn+nQvv/PbNMNG5OfYCyuSIlwBMKCaHyKiBm+my
 UV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789142648; x=1789747448;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xEFAh1HFV0i/H+w7ei/PWkJX8KOTiQmMzcK6J5qrQPk=;
 b=R7cz+kvpwQqKoSo5JZ4Qaw5o7uKgZbGMaZtzVaJZbLsN54orwgm+DwGKOA3hyNs3fy
 Vx1Q6L9wcFhCBZQ46jasd2szaj7zSwWEfPimnihyxoooGWfkg/ICdrKB4K+nfqd5ml5v
 wLHAsLyi/cZ2ImE+S9XhDC8zb+uMXRgvTFQ/6LW02qGPpIAu/E9QGr7wQNGgALeE/3FI
 k/cILBCn6KNXFk/5ijYv3CdhwEOb1eHAX8BPsSqrNjWeA3mpNYChas/8J45Siib0yz/m
 5uiSIiOrDcc85P69NIoa3lwyBxo9/fPQNCDSf+kP5JAIvOheyt+N1GLy4Du0jUjj9iCo
 DRww==
X-Gm-Message-State: AFuF++nP9psxhscjpKEc1a6KGp/9IpCOVH3n5irCTJl71iryhJ53jtsm
 A9qmyrTexrBDthhV15EAcjMABUasQn5QM7gC+TvUNqtwlHkBdj4ijhgfjuWNbjYIMMtkLc7RGHT
 WJIr/QiLLscUeY6beNsZnXrlXHbsMxjR+PgkwbrQD24X5GVAQJOvVbWX5tLt4Ud1Kqg==
X-Gm-Gg: AYBFou1BPLSXd5wRTsngGJlxGKZiPy6RtkWp64i9o1JVk7SaHvS3C0g+itIJeMFBNwa
 g8zIEUW8WtYtfCyOaRyXw0GWVEt2bsy8SzTwV+Z2cv8DA3cvxTs5Fq3D9ZK++7uVap5fUJi/mf1
 VE9tjUZ6X1JN5bPxD8vuGlvp4snyFE3U7uID0g4r/r0Y47anoALzgma77T+VEIinoHmiDJsidCZ
 qDYuXHZacumNPT/1ZAT8L3NaTkRznS2oirgKXkj+ROLUkmmwwsBWGevv3pLigRJ/JhELU765n/R
 51qfIuIwBuDx4KPi1MTq2UUU+1Io5sOZMX2p8clM+5BSrrscU9QbTcwErMpT+CTjBXZrvrthouh
 sNaQmRrWcQjuOBpuegJmlX9KuzUwqx+7KlZZOgEC601c5yRt7
X-Received: by 2002:a05:6808:6508:b0:4b2:b057:934c with SMTP id
 5614622812f47-4c3058d5fd6mr2828216b6e.3.1789142648164; 
 Fri, 11 Sep 2026 09:04:08 -0700 (PDT)
X-Received: by 2002:a05:6808:6508:b0:4b2:b057:934c with SMTP id
 5614622812f47-4c3058d5fd6mr2828185b6e.3.1789142647761; 
 Fri, 11 Sep 2026 09:04:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c3321ecd0asm2451876b6e.17.2026.09.11.09.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 09:04:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 10/10] docs: Correct semihost spec URL
Date: Fri, 11 Sep 2026 09:03:07 -0700
Message-Id: <20260911160307.865892-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911160307.865892-1-brian.cain@oss.qualcomm.com>
References: <20260911160307.865892-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Bv8IUoX5 c=1 sm=1 tr=0 ts=6aa42678 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=tSODnN1-WjF6-noYxS8A:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: rJrT_FVe9NVVQWAaqFVBZf64jI5DgFzW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIyNCBTYWx0ZWRfX0chfHa9W/1Hp
 o7bLn2oTEgWg8jSVu/OsAHQGe+V2yhgTX0FeUbtmWGaLv6s2l0ygH5hnlSvYQU/Z9p9H85vuRjT
 prvas6UbDzYDuVsk+qjJfHyfwaQIE+k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIyNCBTYWx0ZWRfX6v7CpjCmG2lz
 3NcxHfK35g7bTUJtXSZI6GeOj31gAPGQq4AhWEvWRayyzRhf1pX5+1IJD/jEegqbd1XkebcGeXl
 vR28s/JRO9LDlf21kCD8jbPJwLJsqy3+m48mGbGb+s1RTOZG21sTjc1/EZsdQeFqGR/KQvTlFKk
 D9/ussDYl79/N+y/2GwhwsQpox3h3leHyOK+SQ4IEvp+Nh+Sk8goYbx3vbUv4Th2nte/HCJfgh/
 K7NH8A5wV7ousLgvWkt3EhsBRFPaaB7rbonx3P4KC3Ep4whquiPlbdnt9yjJEx62XHHQaCAzWug
 Vo0uNzAOnspEe1byuFkyRuBAEpao97Rgcm+zltmunbsLrcS4lmmjo3uSdj+gAKhCC/Q82SmgpLn
 p2lnV+gU0apnk21RcO9wIT5vFYTl6LEedHvwnZDeOhDaKI6ufZIQmuszlYn0Qye2R2kFquo4xTM
 xI3jSvlAxH4V/1OrQ/A==
X-Proofpoint-ORIG-GUID: rJrT_FVe9NVVQWAaqFVBZf64jI5DgFzW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110224
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VGhlIHByZXZpb3VzIFVSTCB3b3JrZWQgYXQgdGhlIHRpbWUgb2Ygc3VibWlzc2lvbiBidXQgaXQg
YXBwZWFycyB0aGF0IGl0CndhcyBub3QgYSBwb3J0YWJsZSwgZHVyYWJsZSByZWZlcmVuY2UuCgpU
aGlzIG9uZSBzaG91bGQgd29yayBiZXR0ZXIuCgpSZXZpZXdlZC1ieTogTWFyY28gTGllYmVsIDxt
YXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8
YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGRvY3Mvc3lzdGVtL3RhcmdldC1oZXhh
Z29uLnJzdCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL3RhcmdldC1oZXhhZ29uLnJzdCBiL2RvY3Mv
c3lzdGVtL3RhcmdldC1oZXhhZ29uLnJzdAppbmRleCBhOWY4YzI5ODEwZS4uNWQ0OGNmNDAxYWQg
MTAwNjQ0Ci0tLSBhL2RvY3Mvc3lzdGVtL3RhcmdldC1oZXhhZ29uLnJzdAorKysgYi9kb2NzL3N5
c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QKQEAgLTkzLDcgKzkzLDcgQEAgSGV4YWdvbiBzdXBwb3J0
cyBhIHNlbWlob3N0aW5nIGludGVyZmFjZSBzaW1pbGFyIHRvIG90aGVyIGFyY2hpdGVjdHVyZXMn
LgogVGhlIGBgdHJhcDBgYCBpbnN0cnVjdGlvbiBjYW4gYWN0aXZhdGUgdGhlc2Ugc2VtaWhvc3Rp
bmcgY2FsbHMgc28gdGhhdCB0aGUKIGd1ZXN0IHNvZnR3YXJlIGNhbiBhY2Nlc3MgdGhlIGhvc3Qg
Y29uc29sZSBhbmQgZmlsZXN5c3RlbS4gUmVhZCB0aGUKIGBIZXhhZ29uIFNlbWlob3N0aW5nIFNw
ZWNpZmljYXRpb24KLTxodHRwczovL2RvY3MucXVhbGNvbW0uY29tL2RvYy84MC1OMjA0MC0xMDFf
MTAyNjQ4L3RvcGljL3NlbWlob3N0aW5nLXNwZWNpZmljYXRpb24uaHRtbD5gX18KKzxodHRwczov
L2RvY3MucXVhbGNvbW0uY29tL2RvYy84MC1OMjA0MC0xMDEvPmBfXwogZm9yIGRldGFpbHMuIFNl
bWlob3N0aW5nIGlzIGVuYWJsZWQgYnkgZGVmYXVsdCBvbiBoZXhhZ29uLXNpbS1jb21wYXRpYmxl
CiBtYWNoaW5lcy4gVGhpcyBjYW4gYmUgZnVydGhlciBjb25maWd1cmVkIHRocm91Z2ggYGAtc2Vt
aWhvc3RpbmctY29uZmlnYGAuCiAKLS0gCjIuMzQuMQoK

