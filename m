Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A68606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KkAw8CWQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PZvL4oxU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIzc9-0005Pb-GI; Mon, 19 Oct 2026 22:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIzc6-0005Jp-KQ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 22:30:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIzc5-0005fM-0R
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 22:30:06 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tA6G3485726
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pUPA7FzxBrf+kkS8APq26zJpSBX9Nls4izAgcrsbWi8=; b=KkAw8CWQaeQVNtrU
 01tx3qh9gZHaIZp9nI4dIi63s+j20ihZzDw9BW1V/U7e2ORRO3o/xyIXxTogI8Y/
 rHdtF+HRYVlmekgqZE40AouHTQFognaPAna7Ppig2wYgxKXhpjw36n1icnaY9Y/6
 FlnUC5qs/UxAVnlXG4sbN178ngonSJc1GKngSIZT60C7BvRc00hR2+DwQ5XKIY1k
 b8u3ZNcVzFLiiuTyx7JPVcmdhTncib9zPIZgN7icBufpkCr9eYxLZV1mc8w2ZCOL
 ZQj7Wgx9dE1LaCSO2y6qmk4RuWwrXCq6c70wE9kFewBz6nx1sjEUMqOgkEjiDQi+
 KR+mEw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n0f44-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:30:03 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-16bc6f3fdb1so1792234c88.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 19:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792463402; x=1793068202; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pUPA7FzxBrf+kkS8APq26zJpSBX9Nls4izAgcrsbWi8=;
 b=PZvL4oxUdDmWNTwWXfmRjT1njYACJZVaF42DwUOAjp46eaYNPJMpq9i4lfqXZlBKeL
 OGOfB3w1xMFEcZog18FCEVaUaSUxzregr/J1T6Wq9MpGw6/A1u8E1rGSq1B/4Odh6Z/B
 Ky9WKok+HGjIbXk0KX3V4gDkZx6kLgHtIMvC/h7ZnGqTDME0du67VEnt4Yov8Ks/XBIg
 Asx/ep1GBQpbHg0E7ehq5VrRcV9CXWvQkNlpY6+aHbHYFF1FXZ+Mh8MV32J0mIRAhg2n
 BR0cgNmRpw+/BROaPrJomWX0xk2r6dMLuAxPTXxUfA+7Xje0Vr9lr+Ciu4T36q/gZaba
 YeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792463402; x=1793068202;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pUPA7FzxBrf+kkS8APq26zJpSBX9Nls4izAgcrsbWi8=;
 b=f+5OD74hKIjTdNyv8rztKF2t/RluIkRiHrd/YoeDojdkXUH0a9sQ1+morJVtZE5jwn
 pwuX5bEeBfwD9TQdwp58UOqi6LVu4bHEgGjyJb/FErV25lytI3E/15wBZu9+6BjfM20W
 1V3Jq5z1CoJ2cYIjlvaLlxPYZ4tOD+nDvryoYiVI8hx9L2ZOJUG6SnDeBRXAvaE5HjcK
 uue5wllVMfjhyDY5etYmEhWvWP4P67Wn+Dx4QdDLYBQeQAK73eZYLXjGk35tXf2wHcdf
 Bp1zZlE1Crxqh4jRotxd8Ik5YWkg7tcdrcxayie4OZnCZriVXnpK03zyYnWXy1gqPT9r
 ADYg==
X-Gm-Message-State: AFq9FYIu1B8Lj4cG2dGxgRvbBaQJKBQbyn0DyRZ63peGckMHWop1LoS0
 xEbq2Rkdcp6eopR+SVq4CosVgxc5+N/cWRpUvk8PTKNvzubL/adR6tikk/rBp7QW/I5MDe+gKyx
 CrZHZrbBA1/qwOh5hKQ2OURXT9bFazTmk/cJCiTD4PrzHI17Ct4zLbuszejEOIbnzwA==
X-Gm-Gg: AYBFou2Ih2FEoTGlo/pN8bUoF/Xa/h3LJF1H28MdNbyDZPzVuPLINzQ0S4dmWlSHmaD
 5o8UYrOEJaoCEDuFam2jHS3NEdUofonIOdmpFIWcUQV8J7fU/MUsu5W7/JigFRfLOkYdJ8EvaYw
 mUg9YUfCPfFU5ArzuAAA/JXuMpQpy+rq5vk8YHY1Ts2Wyhgl4eFxg3t3I2aXUseROG8fGcxynPk
 gZ2uvVphtCnsPddyMPNTgu3g+X/oQzhzS26k2Uyiu798OFOOyn1Ir+Fha5lxc9v2l5ZxCz1lGxO
 O69jFb3wyrfRjrBeCFVTb0XMh6e+SdtihcuvvpBn7pUpEjdz47RO58EEBqZc/X9RAqTsMxeYsrU
 rODwxTIiJ5eXpSl4tCzcgSbM7lQJj/6z2DvIGWTIOmiCWm+E=
X-Received: by 2002:a05:701b:4582:20b0:184:19ee:1fdd with SMTP id
 a92af1059eb24-1850d370592mr13227814c88.5.1792463402352; 
 Mon, 19 Oct 2026 19:30:02 -0700 (PDT)
X-Received: by 2002:a05:701b:4582:20b0:184:19ee:1fdd with SMTP id
 a92af1059eb24-1850d370592mr13227788c88.5.1792463401686; 
 Mon, 19 Oct 2026 19:30:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1830f213ba7sm37895921c88.0.2026.10.19.19.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 19:29:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 3/3] hw/intc/hex-l2vic: find the next pending irq a word at a
 time
Date: Mon, 19 Oct 2026 19:29:55 -0700
Message-Id: <20261020022955.3662627-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020022955.3662627-1-brian.cain@oss.qualcomm.com>
References: <20261020022955.3662627-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=aIplOr9m c=1 sm=1 tr=0 ts=6ad6d22b cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=8fQjqy5ARp1ca2tc:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=XWoxCBOuUWUKfCXQB-IA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAwOSBTYWx0ZWRfX93XtQWbjeeIt
 s8UmLwVTTFP67WAtn8zDWpY4SA67r3DiOu1m2UPE4WXBCjkMgPENmjRjq6e/vxarlB7LoBYCUU+
 TRgWlgFBKTWTMdF/vebpOX9ZQJi3c34=
X-Proofpoint-GUID: gXKKXT4xHizQeRAKjwRdqlWe8sGckU3o
X-Proofpoint-ORIG-GUID: gXKKXT4xHizQeRAKjwRdqlWe8sGckU3o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAwOSBTYWx0ZWRfXyHyJ0g0Nbh0A
 BrM+SrqElt9T9Y5JGmAEvFcpDcZTFO0Rc/CPR3WcgkZMnYZXGFL+tocAyjz2JkJOoDtaKYt3Kp7
 9KLD2T9EeXan6XCk3IW0TLruDdmi2skasnGCL/XjGNfOTUpBCrld6rD5Fc7CMsAnpV2uHgkismN
 DIayVG2hjVG+wX+9btGgeSVMB+rhKcZJxRLmZ8Hak8qk9RzO2eUfMRWvDzicn3TTuhR7FDPYXt8
 waqNE20YZxedaNOFiQ4CIQpAU2cMQCJPo7A0FvJrc1hsnZDl44kb/fQgYWPwtojTvHsI9Ebqcda
 QiAvR1oQpp05ly9YbXVlyMiSF3UC01xT28QejW3BHD/RzTsOJwmlumHeZDVhvAdEJIuif8m3ByB
 cfghpFMMeLz26TH7Jm/0gcvEKGaWNnPNaXrczRCtp6wEM+QA9wQnwH/WB2wPC3W+Y4MzIImZinl
 TaDjoXt9jF7VvyJl3vw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200009
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

bDJ2aWNfdXBkYXRlX2FsbCgpIGNhbGxlZCBsMnZpY191cGRhdGUoKSBmb3IgZWFjaCBvZiB0aGUg
MTAyNCBpcnFzLCBhbmQKZXZlcnkgY2FsbCByZXNjYW5uZWQgYWxsIG9mIGludF9zdGF0dXMgZm9y
IGFuIGFjdGl2ZSB2aWQuICBjaWFkIHJ1bnMgaXQKb24gZWFjaCBpbnRlcnJ1cHQgcmV0dXJuLCBz
byB0aGlzIHdhcyBhIGhvdCBmdW5jdGlvbiBmb3IgYW4gT1MgYm9vdC4KCkNoZWNrIG9uY2Ugd2hl
dGhlciBhIHZpZCBpcyBhY3RpdmUsIHRoZW4gZGVsaXZlciB0aGUgbG93ZXN0IGlycSB0aGF0IGlz
CmJvdGggcGVuZGluZyBhbmQgZW5hYmxlZCBieSBzY2FubmluZyBpbnRfcGVuZGluZyAmIGludF9l
bmFibGUgYSB3b3JkIGF0CmEgdGltZS4gIFRoZSBkZWxpdmVyZWQgaXJxIGlzIHVuY2hhbmdlZC4K
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiBody9pbnRjL2hleC1sMnZpYy5jIHwgMTQgKysrKysrKysrKystLS0KIDEgZmlsZSBjaGFu
Z2VkLCAxMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L2lu
dGMvaGV4LWwydmljLmMgYi9ody9pbnRjL2hleC1sMnZpYy5jCmluZGV4IDczNmYxYmUzYjFkLi44
NmQyYmU2YTc0NCAxMDA2NDQKLS0tIGEvaHcvaW50Yy9oZXgtbDJ2aWMuYworKysgYi9ody9pbnRj
L2hleC1sMnZpYy5jCkBAIC0yOTAsOSArMjkwLDE3IEBAIHN0YXRpYyBib29sIGwydmljX3VwZGF0
ZShIZXhMMlZJQ1N0YXRlICpzLCBpbnQgaXJxKQogCiBzdGF0aWMgdm9pZCBsMnZpY191cGRhdGVf
YWxsKEhleEwyVklDU3RhdGUgKnMpCiB7Ci0gICAgZm9yIChpbnQgaSA9IDA7IGkgPCBMMlZJQ19J
TlRFUlJVUFRfTUFYOyBpKyspIHsKLSAgICAgICAgaWYgKGwydmljX3VwZGF0ZShzLCBpKSkgewot
ICAgICAgICAgICAgLyogb25jZSB2aWQgaXMgYWN0aXZlLCBuby1vbmUgZWxzZSBjYW4gc2V0IGl0
IHVudGlsIGNpYWQgKi8KKyAgICAvKiBvbmNlIHZpZCBpcyBhY3RpdmUsIG5vLW9uZSBlbHNlIGNh
biBzZXQgaXQgdW50aWwgY2lhZCAqLworICAgIGlmICh2aWRfYWN0aXZlKHMpKSB7CisgICAgICAg
IHJldHVybjsKKyAgICB9CisKKyAgICAvKiBEZWxpdmVyIHRoZSBsb3dlc3QtbnVtYmVyZWQgaXJx
IHRoYXQgaXMgYm90aCBwZW5kaW5nIGFuZCBlbmFibGVkLiAqLworICAgIGZvciAoaW50IHNsaWNl
ID0gMDsgc2xpY2UgPCBTTElDRV9NQVg7IHNsaWNlKyspIHsKKyAgICAgICAgdWludDMyX3QgcmVh
ZHkgPSBzLT5pbnRfcGVuZGluZ1tzbGljZV0gJiBzLT5pbnRfZW5hYmxlW3NsaWNlXTsKKworICAg
ICAgICBpZiAocmVhZHkpIHsKKyAgICAgICAgICAgIGwydmljX3VwZGF0ZShzLCBzbGljZSAqIDMy
ICsgY3R6MzIocmVhZHkpKTsKICAgICAgICAgICAgIHJldHVybjsKICAgICAgICAgfQogICAgIH0K
LS0gCjIuMzQuMQoK

