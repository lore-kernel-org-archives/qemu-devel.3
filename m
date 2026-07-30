Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48D6C53200
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpFZp-0005j8-CF; Wed, 29 Jul 2026 21:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFZo-0005iu-PN
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:28:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFZn-0005bj-DC
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:28:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U1FdfK3396436
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WlYwLmXhxTTRa9JsiNHuhC5FeaNc/fhNT3n5nZwsxj8=; b=TbXyiHiuUXcT/0aZ
 BiPfjQ7asPjpPDWjIv15ILqrXkrwvso5N9fX1jILeApKEXM/8acmsMeDPQ3mBplI
 jlGQx+kc/1WtY61RYLKp/jlyHIg7CJa5UJA3aurXeTwqRXWEJ9u/P7mTXnLXiIMv
 Amiv37/17w3LrvW7bwsIkj8bEryBL4/xyBMdgYEXhVtQGAsjv61oghPjGuMUYYKz
 FI1pxrvb6/35lLWH/g4ouLnKTaIgXkuEMAp48UHRdrutoFa5IunF4KMe9qMLVQl4
 QL7L9fc/4BhCYuQEI+VUQ6pmyi1xzxdEhi7rlNu+tSDmZT/CMA2aUF6rwcuAhKAd
 YhQpbA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqvsrg14d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:46 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so1275079a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 18:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785374925; x=1785979725; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WlYwLmXhxTTRa9JsiNHuhC5FeaNc/fhNT3n5nZwsxj8=;
 b=VLgXd0PJ8bJQ3zhkcHtZqPlWVbP+p6U7hj0e29nq532RlK62WtjyNL1jo14D3L7Yq+
 CulcRS4Cw+kj8320q4y7KgKx80cIPjTjZLC8UiIeOdafhY3cb63V7Fthq/M1OZRkK196
 OMXxUL3vUuHfhltYWI+ShaJa4m7UzxhTnSHEEb3erbZo/zZDIpxKvWQRvcdkZAiXi3fe
 1+gfMLp9zAoejzfRCCD52nZjrF3MyvHn+LMMvBCeH+PYE9+L0v18JhVZsUt3DokmNR3c
 y+V+7F69zp6vjaQZo3uylDmisNMu2lpcgm5DtpOefZJL5+5ZIVVBkAcNZkVCBvMbjmzo
 FyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785374925; x=1785979725;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WlYwLmXhxTTRa9JsiNHuhC5FeaNc/fhNT3n5nZwsxj8=;
 b=dlUldRJ+fsMTzBrnWSuNOK7k6o7zhHyOQuMdD7FoEVAJvmOoGaGpXP1WonHd4NvDRn
 0AQmsW4dgcIK+1BGOIuGO2/pYnkXp0bJjJKpZu3Q2TSKkymUEDjyv6eSFiEy7ISg+s+2
 dU9uywe7OI3aOQJihQiw1yXNpe5zNg35tJYfqPzST7+yaCjH8bnU8rnCtPIA1LlrUS2l
 VsV0WV4FnbR1cBEDXbjdWaGOgvHNiPYuF63RQgfyqNmEaKl77cAgp+BsWSehmBOG/q1A
 sAo1X4RNEjq7GbKqIUd6Kz1IXcNE9074HHI6KL9LY08LBybXNY43VtWxvYivqy4fPkNO
 5yoQ==
X-Gm-Message-State: AOJu0Yxqneg8K079Yo9fABQvxq1w+76GRErecd91JRG+5o9+6ML8DB1H
 LnFtxsEOJrvQbFtoXJrhGk8vZ2UOLygX20s0KiBfEw1bU3BQfY5piUPHjZpgYwm23YCgSAgF7QJ
 m6Uhm1wSfQCvQ7gIWkX/VWKRqWNGWi7KLyokW2xc9M8142HJaoE5FpqtJDCVtN+WCjA==
X-Gm-Gg: AR+sD106aWFvHhtb/PH2fsxZrfWtVEDViZKXB7lJW4qbpITvE1JQpaM2oPHmDOYFEUS
 mEJs/8d8+CQDtkdPbp4VG0sxG8vB9jTCfcjJ2p2Ef9vMn3d9xUGf5x1MdtovtZi8PUxIV0GjYua
 itGBsWUQh0MzIGhIAP+ubi4iqJg6MVpw0IcWrhL0NPX4YYpyAlka2VMbRBF3MsrhLEmGqVEorJy
 VfMCYAMDwm85FyJY7a23Jp+Y6D5R222Mh4xPo0+kLVtjQUDYoeXN76aONfFpHzcJEqTi8nd0CTt
 z6TxaCf0msRK225r/cy7U+6MjGUzSfbCD8yg6NXFAy5f4cNKJk6zXLZKylJfSQPsBNldS9+aBsX
 sr0BkFAKykmLiGOT1o11uJuEF/vv05pFdg6EkSNfW18R8sqnk
X-Received: by 2002:a05:6a20:7285:b0:3bf:6c04:a813 with SMTP id
 adf61e73a8af0-3c90093bf7cmr438847637.52.1785374925523; 
 Wed, 29 Jul 2026 18:28:45 -0700 (PDT)
X-Received: by 2002:a05:6a20:7285:b0:3bf:6c04:a813 with SMTP id
 adf61e73a8af0-3c90093bf7cmr438819637.52.1785374925140; 
 Wed, 29 Jul 2026 18:28:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dab0f3sm13242162eec.27.2026.07.29.18.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 18:28:44 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com
Subject: [PATCH v4 14/18] tests/functional/hexagon: add arch_tests functional
 test
Date: Wed, 29 Jul 2026 18:28:19 -0700
Message-Id: <20260730012824.1135905-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAwNyBTYWx0ZWRfX9i8pRhvjijAm
 0PctDqF3tYwJ3mnGQ9Mo2uQB9lMt3LjQ60HH6YXHjt3KAi0Sd2BX1GFM2uH+aIokalV3Nh16s0P
 uECAgxLWvRT/gQ7eGodRA2rUVyRvThE3d6vVCaiw3Ud9EDPJ/jwU4/w53R9XnD5xdyaBcm4Pk80
 eFGlHgBptZH31DC6P2D4r/K6r2gZjZJUUY2zHbWqpyATTBOowFXI5YDBpyXN1y2MmNYxuumJGab
 XUt+vyRVeDamEOP5CsOhFKp3wDYY6a2nG1icmOsZ6n8cGoNOLOa5HR8L5a4CjPqtgR3YBKJ2m5L
 9jKqigh2+bvVQlAZbdlE/QEqyxVGdGjvEeCaMWFRxkkoEbzHa80sJoQEllUwzyK9JYkkKYp/jPs
 uw2xfNmQO9cnaDVf+DgHOFUgz0FNyblr4JqgBMNJ9PKqqcqIrzm+qfkVzbVTTh3goRpE8IbkmxQ
 QJIts5hD19CiKOtxZeQ==
X-Proofpoint-GUID: zeyu4KK1R4oBLMLSXQVM3y_m1Os7mYrv
X-Authority-Analysis: v=2.4 cv=AKfAPqRj c=1 sm=1 tr=0 ts=6a6aa8ce cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=X9gmHREV3qooIQp-wBoA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAwNyBTYWx0ZWRfXxBJbsRRU/07x
 iaN9s/i4xhrRtMHMNLJ96Uj9DUBOqpWqEd8iM6D+K1DLUNSSevkIBYFrq1Tf/XD0ctVOrIUqzTV
 vTB8K5/7xawBJmA0LvCOa00t1OoPDC4=
X-Proofpoint-ORIG-GUID: zeyu4KK1R4oBLMLSXQVM3y_m1Os7mYrv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_09,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300007
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

QWRkIHRoZSB0ZXN0X2ludF9zdGVlcmluZyBjYXNlIGZyb20gaGV4YWdvbi1hcmNoLXRlc3RzLgoK
UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkg
fCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgYi90ZXN0cy9mdW5j
dGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5CmluZGV4IDU0YTE0MTJjNTk3Li4yYmIz
NGY5YjhkYyAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90
ZXN0cy5weQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5
CkBAIC01Miw2ICs1MiwxMiBAQCBkZWYgdGVzdF9ndWVzdF9tb2RlKHNlbGYpIC0+IE5vbmU6CiAg
ICAgICAgICIiIgogICAgICAgICBzZWxmLnJ1bl91YXJ0X3Rlc3QoInRlc3RfZ3Vlc3RfbW9kZSIp
CiAKKyAgICBkZWYgdGVzdF9pbnRfc3RlZXJpbmcoc2VsZikgLT4gTm9uZToKKyAgICAgICAgIiIi
VGVzdHMgaW50ZXJydXB0IHN0ZWVyaW5nIHZpYSBwcmlvcml0eS1iYXNlZCByb3V0aW5nIHRvCisg
ICAgICAgIHNwZWNpZmljIHRocmVhZHMgdXNpbmcgU1RJRCBwcmlvcml0eSBhbmQgaWFzc2lnbncu
CisgICAgICAgICIiIgorICAgICAgICBzZWxmLnJ1bl91YXJ0X3Rlc3QoInRlc3RfaW50X3N0ZWVy
aW5nIikKKwogCiBpZiBfX25hbWVfXyA9PSAiX19tYWluX18iOgogICAgIFFlbXVTeXN0ZW1UZXN0
Lm1haW4oKQotLSAKMi4zNC4xCgo=

