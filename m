Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA508E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 04:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLx8s-0006bw-0d; Thu, 12 Dec 2024 23:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tLx8o-0006aH-Lm
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 23:19:02 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tLx8m-000833-Dw
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 23:19:02 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCGPf92002087
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 04:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DHoweVfTbzrWQRyHIi4LJxPyZAf+eqY3mL/Bb9OrBJw=; b=kYwZPMD6YvGR0/8S
 qL8xuXOSZaTSckwEOg2EC/38dN4iwfTGgSAGpOZTpvM0eGvrv1QOPG5oH/wOdXoA
 4Nnn0F53Y6Bwjx3ExBuciwfesQgKCqIMJVEEVitnzOKo05jbuA6qXh+sowHUFU7o
 qfl9r16j/CzEO+uyy6D7XhrR3jCMP0S4opTExE/mVp5dMoIcQLMsH+Tnr7KtoWCb
 /Ycg0EHZjPRA0menXZfOPKMmnaNc1q1TXqy7B1m6dzRe0LhNZ5y8QEN1sQ2Yccow
 +n9mLtsAjgs8jXz+GTKA7UjDLffC57pr2i+CvFJRc6nxwJO9ReItvAWzwwvqTLdT
 Lv2GLw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f0r9yfkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 04:18:59 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-725e87a142dso1814325b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 20:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734063538; x=1734668338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DHoweVfTbzrWQRyHIi4LJxPyZAf+eqY3mL/Bb9OrBJw=;
 b=oY2LpflJ2rm8e/8TZdjN4LnoXL1UZVvHy2GczjuojJzlIYfcIMpA9frw39kbc7u5Iu
 TfJImJUjf36quIj9wXzJL/83nhGhTUTKjsHCAxm3ZU37LOW0twc3C5tY+3RkSxP3lACx
 wrH2xVpkRhERCJGV3B/v/ahTu8/OVPIfWaYmc0LzZHRyYRCKvNC+ZpViJ9VKGwR3tikn
 IeXYlt1ZsoNpgHCDX63JGlQVCAT2pJ1PEZz3EvY2MwclmgOkHNZbFU+lTxTA2HYvThrW
 ayy8ZlhEZK8E/EXOGCF3xbiqOF+zhbp8Po5xKho8Wc6M6ogGP3xxE72dbq72wxdouUdY
 izCA==
X-Gm-Message-State: AOJu0YyzXzMQnRh7CQbyGRcopImo+l6f8axsOLIWT8e6PSQ1sCBRTDN9
 gEZGm/8HPVSkoQgdzsIO9SZGF0LaSEIkT3WYRz8tSrsxxzh7EurH9kpsWSw0foWxr5me/g4mP2v
 jmbB0VhzsHNTdBbFxfUvJsIOWDm29ocSqh1bv4VOlw93JG+lYtYJePit1+w47yA==
X-Gm-Gg: ASbGncvIlID7PSJ8//WsbayAHpl2jx0KGPjFubwR5zvBVdr+IIqiHSr6kIiccV8PBXZ
 9cPQffdTzbsXsMzZmwuNbMyRiqyP/lqsqbRo1vgv5DwOEQwqCkdT8XPBbGWeVWUzN0l68QSddSr
 W/EhdESM2PosZSrVQUR7pJoSvwOWd/weI+PvBNEylUB9hOO/YeGHOgpkgruw/ES4V8Ur868Wd77
 w9p7oHz6Z6YEirx+n9D9oOHdKoKQ/UfoOT1TQ0ABGkDB+A7dwX+dTUeCSWSBkOeA4LQNMMsIkN8
 kB/CbwSkErnSbCfbGhq+NdAOtSPCKg==
X-Received: by 2002:a05:6a21:3a93:b0:1e1:dbfd:1fde with SMTP id
 adf61e73a8af0-1e1dfda98bfmr1476680637.27.1734063537922; 
 Thu, 12 Dec 2024 20:18:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IET2cxMqIL6T7hLkKsBFWDnlZWQk6mchyirh1L13fUxxjnihQhsrwxlFmBQGXOm/sokXZCAog==
X-Received: by 2002:a05:6a21:3a93:b0:1e1:dbfd:1fde with SMTP id
 adf61e73a8af0-1e1dfda98bfmr1476659637.27.1734063537587; 
 Thu, 12 Dec 2024 20:18:57 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725deac1daasm9451938b3a.171.2024.12.12.20.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 20:18:57 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, peter.maydell@linaro.org, 
 quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 Brian Cain <bcain@oss.qualcomm.com>
Subject: [PULL 5/5] target/hexagon: Make HVX vector args. restrict *
Date: Thu, 12 Dec 2024 20:18:36 -0800
Message-Id: <20241213041836.39986-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213041836.39986-1-brian.cain@oss.qualcomm.com>
References: <20241213041836.39986-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: x4pHjl_dtBI_dobamB7fKY68phQI-CUC
X-Proofpoint-GUID: x4pHjl_dtBI_dobamB7fKY68phQI-CUC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=702
 malwarescore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130030
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

RnJvbTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KCkFkZHMgcmVzdHJpY3QgcXVhbGlm
aWVyIHRvIEhWWCBwb2ludGVyIGFyZ3VtZW50cy4gVGhpcyB3aWxsIGFsbG93IHRoZQpjb21waWxl
ciB0byBwcm9kdWNlIGJldHRlciBvcHRpbWl6ZWQgY29kZSwgYXMgaW5wdXQgdmVjdG9ycyBhcmUg
bm93CmFzc3VtZWQgbm90IHRvIGFsaWFzLCBhbmQgbm8gcnVudGltZSBhbGlhc2luZyBjaGVja3Mg
d2lsbCBiZSByZXF1aXJlZC4KClNpZ25lZC1vZmYtYnk6IEFudG9uIEpvaGFuc3NvbiA8YW5qb0By
ZXYubmc+ClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9tYWNyb3MuaCB8IDM2ICsrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwg
MTggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vbW12ZWMvbWFjcm9z
LmggYi90YXJnZXQvaGV4YWdvbi9tbXZlYy9tYWNyb3MuaAppbmRleCAxY2ViOTQ1M2VlLi5iY2Q0
YTFlODk3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9tbXZlYy9tYWNyb3MuaAorKysgYi90
YXJnZXQvaGV4YWdvbi9tbXZlYy9tYWNyb3MuaApAQCAtMjMsMjYgKzIzLDI2IEBACiAjaW5jbHVk
ZSAibW12ZWMvc3lzdGVtX2V4dF9tbXZlYy5oIgogCiAjaWZuZGVmIFFFTVVfR0VORVJBVEUKLSNk
ZWZpbmUgVmRWICAgICAgKCooTU1WZWN0b3IgKikoVmRWX3ZvaWQpKQotI2RlZmluZSBWc1YgICAg
ICAoKihNTVZlY3RvciAqKShWc1Zfdm9pZCkpCi0jZGVmaW5lIFZ1ViAgICAgICgqKE1NVmVjdG9y
ICopKFZ1Vl92b2lkKSkKLSNkZWZpbmUgVnZWICAgICAgKCooTU1WZWN0b3IgKikoVnZWX3ZvaWQp
KQotI2RlZmluZSBWd1YgICAgICAoKihNTVZlY3RvciAqKShWd1Zfdm9pZCkpCi0jZGVmaW5lIFZ4
ViAgICAgICgqKE1NVmVjdG9yICopKFZ4Vl92b2lkKSkKLSNkZWZpbmUgVnlWICAgICAgKCooTU1W
ZWN0b3IgKikoVnlWX3ZvaWQpKQorI2RlZmluZSBWZFYgICAgICAoKihNTVZlY3RvciAqcmVzdHJp
Y3QpKFZkVl92b2lkKSkKKyNkZWZpbmUgVnNWICAgICAgKCooTU1WZWN0b3IgKnJlc3RyaWN0KShW
c1Zfdm9pZCkpCisjZGVmaW5lIFZ1ViAgICAgICgqKE1NVmVjdG9yICpyZXN0cmljdCkoVnVWX3Zv
aWQpKQorI2RlZmluZSBWdlYgICAgICAoKihNTVZlY3RvciAqcmVzdHJpY3QpKFZ2Vl92b2lkKSkK
KyNkZWZpbmUgVndWICAgICAgKCooTU1WZWN0b3IgKnJlc3RyaWN0KShWd1Zfdm9pZCkpCisjZGVm
aW5lIFZ4ViAgICAgICgqKE1NVmVjdG9yICpyZXN0cmljdCkoVnhWX3ZvaWQpKQorI2RlZmluZSBW
eVYgICAgICAoKihNTVZlY3RvciAqcmVzdHJpY3QpKFZ5Vl92b2lkKSkKIAotI2RlZmluZSBWZGRW
ICAgICAoKihNTVZlY3RvclBhaXIgKikoVmRkVl92b2lkKSkKLSNkZWZpbmUgVnV1ViAgICAgKCoo
TU1WZWN0b3JQYWlyICopKFZ1dVZfdm9pZCkpCi0jZGVmaW5lIFZ2dlYgICAgICgqKE1NVmVjdG9y
UGFpciAqKShWdnZWX3ZvaWQpKQotI2RlZmluZSBWeHhWICAgICAoKihNTVZlY3RvclBhaXIgKiko
Vnh4Vl92b2lkKSkKKyNkZWZpbmUgVmRkViAgICAgKCooTU1WZWN0b3JQYWlyICpyZXN0cmljdCko
VmRkVl92b2lkKSkKKyNkZWZpbmUgVnV1ViAgICAgKCooTU1WZWN0b3JQYWlyICpyZXN0cmljdCko
VnV1Vl92b2lkKSkKKyNkZWZpbmUgVnZ2ViAgICAgKCooTU1WZWN0b3JQYWlyICpyZXN0cmljdCko
VnZ2Vl92b2lkKSkKKyNkZWZpbmUgVnh4ViAgICAgKCooTU1WZWN0b3JQYWlyICpyZXN0cmljdCko
Vnh4Vl92b2lkKSkKIAotI2RlZmluZSBRZVYgICAgICAoKihNTVFSZWcgKikoUWVWX3ZvaWQpKQot
I2RlZmluZSBRZFYgICAgICAoKihNTVFSZWcgKikoUWRWX3ZvaWQpKQotI2RlZmluZSBRc1YgICAg
ICAoKihNTVFSZWcgKikoUXNWX3ZvaWQpKQotI2RlZmluZSBRdFYgICAgICAoKihNTVFSZWcgKiko
UXRWX3ZvaWQpKQotI2RlZmluZSBRdVYgICAgICAoKihNTVFSZWcgKikoUXVWX3ZvaWQpKQotI2Rl
ZmluZSBRdlYgICAgICAoKihNTVFSZWcgKikoUXZWX3ZvaWQpKQotI2RlZmluZSBReFYgICAgICAo
KihNTVFSZWcgKikoUXhWX3ZvaWQpKQorI2RlZmluZSBRZVYgICAgICAoKihNTVFSZWcgKnJlc3Ry
aWN0KShRZVZfdm9pZCkpCisjZGVmaW5lIFFkViAgICAgICgqKE1NUVJlZyAqcmVzdHJpY3QpKFFk
Vl92b2lkKSkKKyNkZWZpbmUgUXNWICAgICAgKCooTU1RUmVnICpyZXN0cmljdCkoUXNWX3ZvaWQp
KQorI2RlZmluZSBRdFYgICAgICAoKihNTVFSZWcgKnJlc3RyaWN0KShRdFZfdm9pZCkpCisjZGVm
aW5lIFF1ViAgICAgICgqKE1NUVJlZyAqcmVzdHJpY3QpKFF1Vl92b2lkKSkKKyNkZWZpbmUgUXZW
ICAgICAgKCooTU1RUmVnICpyZXN0cmljdCkoUXZWX3ZvaWQpKQorI2RlZmluZSBReFYgICAgICAo
KihNTVFSZWcgKnJlc3RyaWN0KShReFZfdm9pZCkpCiAjZW5kaWYKIAogI2RlZmluZSBMT0dfVlRD
TV9CWVRFKFZBLCBNQVNLLCBWQUwsIElEWCkgXAotLSAKMi4zNC4xCgo=

