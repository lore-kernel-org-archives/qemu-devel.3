Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3918EC5DF8E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 21:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxAfd-0003HR-Qb; Thu, 20 Aug 2026 17:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wxAfc-0003Gt-0I
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 17:51:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wxAfa-0004PQ-4A
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 17:51:31 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7pl03941376
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VRaZktLH6FSYAnvGOw4//fv/Pl+ly6gy7uH+narcn0w=; b=Biw64PIFd0H9m5hB
 O7LlZJBlKtbCe+WnC1GucGvTrLIwRzAmpL3Vx+4iMCNFH8JtF7NhyOF9b8VkYV/E
 rrtTTercKTzMrjQuVABGf+bqoWW+dzxUG6R7oRgi3Kab+kOY8dj+C+F5nWt9ss6C
 tsVT7tJZ1/ShxFyy5uClI0011JqDJMW2TX/q6BjzjejHP/D0N06gGxdphaqH4nmR
 7wPMvqrBdvoRkCVvyRQ2mhJmvco29UXPC7yXyVhBBPLXHfBtwZa4TMFqFFjn96nV
 //zM3k5WZ5I2iaGvXEQu76l/q8NSS8Ol9LKuStcG7EOGlKohOp/ytGflK3430N8d
 bZaStQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7uv3g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:51:28 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc15155cde2so294806a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 14:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787262688; x=1787867488; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VRaZktLH6FSYAnvGOw4//fv/Pl+ly6gy7uH+narcn0w=;
 b=KEuFHxJzM4y2IO/WIJfDy1e77zZphl7OqP1S474C3TO06WjFi3k85dUzj1EIAvdFzG
 kHu16VrtOYF4XRpAYXhLvGxy+A0g3HI0wAxjmJ/ve904Nb1xlQ6Iq1C7Eio2lysxLr2x
 mKr9Jcz18rvyie5zy8MEWcEJBRc8NJQQMHFzVaL48ibfxaS661RdPk5uZiAIEBYXGbLw
 swQbrbK7lGKUFa4LQzyA6FQbEccC5W8J71KJ9QgO2tjHM/KV36NiTl7WPPo7+jH9gUU5
 tEWKgo8CJVLOzHPhjhMul9d+nSIED0HQe6aYP3W6gkdE4n819e84Q2qBCzFetL2GHNUC
 KIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787262688; x=1787867488;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VRaZktLH6FSYAnvGOw4//fv/Pl+ly6gy7uH+narcn0w=;
 b=LLyB9lxISBgg0vYbcXELvd4oXrj0n1P6Abxb0rW54KP9WY56EreSp0T1oyvYs1+O9t
 2g7YsAPfK0O/1dkBBORNruMWRPOBjxdT7FcKv2T5dyVTbUtOogV3vQQSDDGBIp8jxyHw
 ltBnYqr8ulLqe6WRmKPtiuV/MvDveRGrmidUoScdZ8gAczmABwSvhvnOVMAiLVOnyFlr
 MtWqK+YsL+DC4Hy8O66RpH/vBmXjVMP0mGGoDOkc29VZZsEaN7Hbhc54Mq4lIJUyo7FV
 jGlNncEAn7sPtGMpLxwXWQJRek/ogUaG/4Gx4usrFSJeq8/uHXx4lM8KpqhtUz5K1bPL
 ZLNg==
X-Gm-Message-State: AOJu0Yy5KVmIwxTrbhGBxEdS0VP3DLH++tfEnRPD9VWplt3sPCJsDN7m
 em7G13896OwOy8jcHFqA1M3aQFVPKmKCxznCHvq3jkBjlWVW/vja08l78AiasU1XoS2bcbm6suH
 xlJ16GdwTyy/9kOTPP424dxZxB8g6ame3GpecRl4ch8ZFy/YI0W9lKgvmZsQg1PSR/g==
X-Gm-Gg: AR+sD10LulYB64M9ADHH/FaZjSxDEetQhq8uU4jVKhQgIIyec+Q3NA8t7/zPHdjIbls
 wfB7XmjH71SzfrOdgqsKudQ/zEuClcko5ij02atKhoCFtEAgKTEfPatO/UV+WBlhiV22RyaaDSe
 aWCh9rzC6uxr0iKDq5CViNwADjDAOUz8V/wJIdukOXjW23xZviym/s7FwGTKdvpuGIJ3QsX09Ch
 UiNRaS9sFpcyXYu3LkHcXAhAZJEpBju6CUBGNNGOjHiJgR3YhT6RlpQMqJl+GFNdedVPa7Z6L8q
 LcfRZOIhZelqKCG6mYhRKHulbdqCNZ3vIv9WeOzd6OTqvWEHLL0PUfQHT4RZjfcySQ6pSXO1nxF
 BZ3nuqRp8dGfFJCVvlNIoe+NI0NOt0CmW6choRaSgkI7gW6MQ
X-Received: by 2002:a05:6a21:6001:b0:3cc:fb7d:a9ab with SMTP id
 adf61e73a8af0-3cd2fd8e99emr3094125637.2.1787262688165; 
 Thu, 20 Aug 2026 14:51:28 -0700 (PDT)
X-Received: by 2002:a05:6a21:6001:b0:3cc:fb7d:a9ab with SMTP id
 adf61e73a8af0-3cd2fd8e99emr3094064637.2.1787262687755; 
 Thu, 20 Aug 2026 14:51:27 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327d6168e5bsm9226899eec.1.2026.08.20.14.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 14:51:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 5/5] tests/tcg/hexagon: check the two HVX predicate build
 paths agree
Date: Thu, 20 Aug 2026 14:51:17 -0700
Message-Id: <20260820215117.1788954-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820215117.1788954-1-brian.cain@oss.qualcomm.com>
References: <20260820215117.1788954-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MyBTYWx0ZWRfX86wavVP2X6s1
 4Rt+eXxRyHor3JKI5cIId8OufzSCC+EqgsBAQZdPDv+EmFZ5mA/969e89qg+XpAg5iMOhfmbcKE
 WnGqWa1ZhKCm/PxkKA7CmVnipoulUCCi6RdR/y+xQUwXdedFr7qTk8bw7wDmmX7DVMhnRyu6gcw
 0KetVGBU2vd9G55oO8aUW+K51KiRqtjFCOnMfoj2FfC3cCkQ+42J5DZ8HjYMlWBSNZNSkjI0Rm+
 Xh4RJYBENMIvfbDHKACjJiumiupMTclBttIWq+D7e8pFpZGXVzy0wJ99LZVi0kTnfYwAbgbCVqy
 k6NPQdpVTKM3bZSWHue2WlNGOEzXjv9lari+O2vkZa4cIFEFYBSp3d1pfAoPXb+3T3YiNzSrFNF
 AdSM5+/qZ5x2ACrVV5ywXvw15Im2PuWibTblEE8rcDpDynu1kpGXe4TL1iNiS5bUeUfvco9W0X+
 jdS+/BLIwT+cCcLXmUA==
X-Proofpoint-ORIG-GUID: WtdSgLPJNYUQTxvXI0MmItbPLTyFZxHK
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a8776e0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=jjHI2IJ3bfbFesgfRcwA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MyBTYWx0ZWRfX2yzsP85L8bbo
 lbdgroFMVWgqnkPs4XzfU3jiTHovN9MHwY65DKKmGYGj6vgvE0n3hQx1f2g/aLYPIszq6zHLDQW
 VLK89R7Nq7NnkRa0L6KvwsmNSOORFSU=
X-Proofpoint-GUID: WtdSgLPJNYUQTxvXI0MmItbPLTyFZxHK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200163
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

QSBRIHJlZyBjYW4gYmUgYnVpbHQgYnkgYSB2ZWN0b3IgY29tcGFyZSBvciBieSB2YW5kKFZ1LCBS
dCksIGFuZAp0aG9zZSByZWFjaCB0aGUgcHJlZGljYXRlIHJlZ2lzdGVyIHRocm91Z2ggaW5kZXBl
bmRlbnQgY29kZSBwYXRocy4gQ2hlY2sKdGhhdCBib3RoIHNlbGVjdCB0aGUgc2FtZSBieXRlIGxh
bmVzLCBzbyBhIGJ5dGUtb3JkZXIgbWlzdGFrZSBpbiBlaXRoZXIKb25lIGlzIGNhdWdodC4KClRo
ZSBpbnB1dCBhbHRlcm5hdGVzIGV2ZXJ5IGVpZ2h0IGxhbmVzOiBhIGZsYXR0ZXIgcGF0dGVybgpz
dGF5cyB1bmNoYW5nZWQgd2hlbiBwcmVkaWNhdGUgYnl0ZXMgYXJlIHBlcm11dGVkIGFuZCBoaWRl
cyB0aGUgYnVnLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMgfCA0NSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYyBiL3Rlc3Rz
L3RjZy9oZXhhZ29uL2h2eF9taXNjLmMKaW5kZXggMzJhMzY2MWE4NmYuLjIyNTY2NjEzN2M5IDEw
MDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jCisrKyBiL3Rlc3RzL3RjZy9o
ZXhhZ29uL2h2eF9taXNjLmMKQEAgLTE4MSw2ICsxODEsNTAgQEAgc3RhdGljIHZvaWQgdGVzdF9z
dG9yZV91bmFsaWduZWQodm9pZCkKICAgICBjaGVja19vdXRwdXRfdyhfX0xJTkVfXywgMik7CiB9
CiAKKy8qCisgKiBBIFEgcmVnaXN0ZXIgY2FuIGJlIGJ1aWx0IGVpdGhlciBieSBhIHZlY3RvciBj
b21wYXJlIG9yIGJ5IHZhbmQoVnUsIFJ0KS4KKyAqIFRob3NlIGFyZSB0d28gaW5kZXBlbmRlbnQg
Y29kZSBwYXRocyBvbnRvIHRoZSBzYW1lIHByZWRpY2F0ZS1yZWdpc3RlcgorICogbGF5b3V0LCBz
byBjcm9zcy1jaGVjayB0aGF0IHRoZXkgc2VsZWN0IGV4YWN0bHkgdGhlIHNhbWUgYnl0ZSBsYW5l
cy4KKyAqIEEgYnl0ZS1vcmRlciBtaXN0YWtlIGluIGVpdGhlciBvbmUgc2hvd3MgdXAgaGVyZSBh
cyBhIG1pc21hdGNoLgorICoKKyAqIFRoZSBpbnB1dCBwYXR0ZXJuIGhhcyB0byB2YXJ5IGFjcm9z
cyA4LWxhbmUgYmxvY2tzLCBvdGhlcndpc2UgYSBwcmVkaWNhdGUKKyAqIHdob3NlIGJ5dGVzIGFy
ZSBwZXJtdXRlZCBzdGlsbCBzZWxlY3RzIHRoZSBzYW1lIGxhbmVzIGFuZCB0aGUgbWlzbWF0Y2gg
aXMKKyAqIGludmlzaWJsZS4KKyAqLworc3RhdGljIHZvaWQgdGVzdF9xcmVnX2FsaWFzKHZvaWQp
Cit7CisgICAgSFZYX1ZlY3RvciAqcGNtcCA9IChIVlhfVmVjdG9yICopJm91dHB1dFswXTsKKyAg
ICBIVlhfVmVjdG9yICpwYW5kID0gKEhWWF9WZWN0b3IgKikmb3V0cHV0WzFdOworICAgIEhWWF9W
ZWN0b3IgaW5wdXQ7CisgICAgSFZYX1ZlY3RvciBvbmVzOworICAgIEhWWF9WZWN0b3JQcmVkIHFj
bXA7CisgICAgSFZYX1ZlY3RvclByZWQgcWFuZDsKKworICAgIGZvciAoaW50IGkgPSAwOyBpIDwg
QlVGU0laRTsgaSsrKSB7CisgICAgICAgIC8qCisgICAgICAgICAqIEJ1aWxkIDAvMSBwZXIgYnl0
ZSwgYWx0ZXJuYXRpbmcgZXZlcnkgOCBsYW5lcywgc28gdGhhdCAiIT0gMCIgYW5kCisgICAgICAg
ICAqICJsb3cgYml0IHNldCIgZGVzY3JpYmUgdGhlIHNhbWUgbGFuZXMuICBUaGVuIGZvcm0gb25l
IHByZWRpY2F0ZQorICAgICAgICAgKiB3aXRoIGEgY29tcGFyZSBhbmQgdGhlIG90aGVyIHdpdGgg
dmFuZChWdSwgUnQpLCBzdG9yZSAweGZmIHRocm91Z2gKKyAgICAgICAgICogZWFjaCwgYW5kIHJl
cXVpcmUgdGhlIHR3byByZXN1bHQgdmVjdG9ycyB0byBiZSBpZGVudGljYWwuCisgICAgICAgICAq
LworICAgICAgICBmb3IgKGludCBqID0gMDsgaiA8IE1BWF9WRUNfU0laRV9CWVRFUzsgaisrKSB7
CisgICAgICAgICAgICBleHBlY3RbMF0udWJbal0gPSAoKGogPj4gMykgKyBpKSAmIDE7CisgICAg
ICAgIH0KKyAgICAgICAgbWVtY3B5KCZpbnB1dCwgJmV4cGVjdFswXSwgc2l6ZW9mKE1NVmVjdG9y
KSk7CisgICAgICAgIG1lbXNldChvdXRwdXQsIDAsIDIgKiBzaXplb2YoTU1WZWN0b3IpKTsKKwor
ICAgICAgICBvbmVzID0gUTZfVl92c3BsYXRfUigweGZmZmZmZmZmKTsKKyAgICAgICAgcWNtcCA9
IFE2X1FfdmNtcF9ndF9WdWJWdWIoaW5wdXQsIFE2X1Zfdnplcm8oKSk7CisgICAgICAgIHFhbmQg
PSBRNl9RX3ZhbmRfVlIoaW5wdXQsIDB4MDEwMTAxMDEpOworICAgICAgICBRNl92bWVtX1FSSVYo
cWNtcCwgcGNtcCwgb25lcyk7CisgICAgICAgIFE2X3ZtZW1fUVJJVihxYW5kLCBwYW5kLCBvbmVz
KTsKKworICAgICAgICBmb3IgKGludCBqID0gMDsgaiA8IE1BWF9WRUNfU0laRV9CWVRFUzsgaisr
KSB7CisgICAgICAgICAgICBjaGVjayhfX0xJTkVfXywgaSwgaiwgb3V0cHV0WzBdLnViW2pdLCBv
dXRwdXRbMV0udWJbal0pOworICAgICAgICB9CisgICAgfQorfQorCiBzdGF0aWMgdm9pZCB0ZXN0
X21hc2tlZF9zdG9yZShib29sIGludmVydCkKIHsKICAgICB2b2lkICpwMCA9IGJ1ZmZlcjA7CkBA
IC01NzksNiArNjIzLDcgQEAgaW50IG1haW4oKQogICAgIHRlc3Rfc3RvcmVfdW5hbGlnbmVkKCk7
CiAgICAgdGVzdF9tYXNrZWRfc3RvcmUoZmFsc2UpOwogICAgIHRlc3RfbWFza2VkX3N0b3JlKHRy
dWUpOworICAgIHRlc3RfcXJlZ19hbGlhcygpOwogICAgIHRlc3RfbmV3X3ZhbHVlX3N0b3JlKCk7
CiAgICAgdGVzdF9tYXhfdGVtcHMoKTsKIAotLSAKMi4zNC4xCgo=

