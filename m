Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC8EC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2UJ-0007Jk-0E; Wed, 12 Aug 2026 02:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2U4-0007Hm-3P
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2U2-0003r5-8W
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:39 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62PAn3288529
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r5gOWn0iU2Np2OD0qg7EzN8uuJ/lnbIhtPfVZ0n4xk8=; b=dV8k/SCxUn6e5BFJ
 egAdA7d9w1ZmY0V/6f7f0tq24RjDoFz7c4tbmSRQYOVdLSK5DW/hxvyl2VdOfHnQ
 F1hz8KNiSS9tURwzRpxX44jyqEcrXkvI41jOqNuYRQE9dxhdelJ06eHO4+1bixSQ
 jc9nAqdqA0Acu0D5A3dzbyisX/F4toH5ZFDg3pYopqtoxptHmNCP+YvX9lzBYQI6
 86Nv+8w5m+BH92zzeiGRaGjVvvX7KEIyyrSgq5PJEQ+aMcdkTqonqYbO3EqGHk6+
 C79Ck5kyoGInIqs+s3DF7wzr0HPhgZ1/Q9DZDfIcx0PSfU911y5XqJoVhwssH2Zo
 SdT+VA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049eusnf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:36 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e25e4b41cso898034a91.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786516235; x=1787121035; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r5gOWn0iU2Np2OD0qg7EzN8uuJ/lnbIhtPfVZ0n4xk8=;
 b=Ig8q+2pzOvNDNhgP+bRezDeYwfzpwHvdzhXZtM8hNKzBBpm5kN4frCrL5qUmlMc0P0
 x/SdVojpI55wYM+1FCL402ZB3AqSu+yDQxARAnQWT8D3X9hFqrcF3XnpiZPvTTcrtZkv
 ABQxYX0IWxQRi3rkN4dX1nA3DwXNhdLjRD2UIqs7KmyYrBRhaX5tmlOm5i30zKb9BI7j
 DD1NEmcviJJNnIEbxIZKcRntcsIcRwej8Ndz4kqJIJl5pSci+ywfrMomSVolpfE7Ghrq
 5yMAxHCeVluGmGxiJ3zvP+bAWLZHu8vT565aCJjDzvYSrPOWl7WWWD3Ndw9ULEiTNpvx
 /RiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516235; x=1787121035;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r5gOWn0iU2Np2OD0qg7EzN8uuJ/lnbIhtPfVZ0n4xk8=;
 b=tAFYecv8CV3toC6XB47XjfAeJGTzF42+fnbI+UnkYuhLiVEtW2ut2vk+9bZ91Qmme7
 wlMKGhFvGsU593Q8gO+mVdsPeJ/KO6t0vQcIy3n4kemOW7n9F8P9al97aJOkecMyZBxT
 2mwX0FpfFKysaE4B3vnMwshcsJD6MrK2THiMt8Hiig7wxZBa0I7dWh+um1Wymxl3Pxj6
 kkCeRBe/YizkpJN79wwAUERXZCo/RuP7hXaqZ0FHox5BKI/Y+l0bawn8Wi9cBH/11OFR
 CwJUufboGRmZpCHkrj6HIv7fK97lMjPJiqHtFd8GFRjjIaYZy3VfsfwcFEwzMFl34hZB
 KZuA==
X-Gm-Message-State: AOJu0YwyS0bvhR6ASOfBIbDE3FNO7PvGczCutEmmQioIYd1TQnSVHfsw
 aXlyM2PEQ3dBns+9vuOYb5uZgi/g49npu3v6ehQlMCu+kp7Z5Wb5zEVnrHUOUyot5NCcpFgU4YP
 xRUOd3L+WKVnPudfIkgJxJjzqABTfdWrDUlTVxA2WoUSCPgz5vK6xhHDYJUU5waEbqA==
X-Gm-Gg: AR+sD13/hWNd2XuCzAiOPlda1dciDtFGcnMFnNltTWpFyqolWXs/bFr3Ml/e10e3Fqq
 iCBCmxhtnmTRknmoR1P8Z35CcyDvH72qAz/w3/Yy1XGcgAVRbArkTYajH6DavCM4ptb5jz5HKj2
 gNyS8G2Z3t0t38QOtWcTvUWENhlnG16SoTMZZPVzRwnKWYy4Xn7ZVmlDZ/PO7Mq9VmszOrJ0CGM
 oN1EmRa5du/ga1gdGJFiB5FA5mqlsoS7Y0pZJbU28fUQl/DKmJWtWCcz0lyrdi2aFTdxC6JPLVJ
 InhG78z/sezRJJhDjdGfZTv/qBug2nRNWoMLT4OnOzyCOCISJQ6BTE9LM10X/nqGyI4YXJDUgo8
 TChIi6PD/Ku73FR666xhU0/70WqsE4rzrZQ1m6xytSGdOQJhx
X-Received: by 2002:a17:90b:5443:b0:37f:f4ae:5f25 with SMTP id
 98e67ed59e1d1-393014b4064mr3134507a91.20.1786516235091; 
 Tue, 11 Aug 2026 23:30:35 -0700 (PDT)
X-Received: by 2002:a17:90b:5443:b0:37f:f4ae:5f25 with SMTP id
 98e67ed59e1d1-393014b4064mr3134424a91.20.1786516234310; 
 Tue, 11 Aug 2026 23:30:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f985e9fcsm771402a91.1.2026.08.11.23.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 23:30:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 20/41] target/hexagon: add GVec overrides for HVX saturating
 add/sub
Date: Tue, 11 Aug 2026 23:29:11 -0700
Message-Id: <20260812062932.543840-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
References: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX8R4nEhJ1UUK6
 Dy81iG3lrxyTlxqkqip2v+uTmmWsrneYG148Elybrc3Xc6UA1UcpJ6cBZnPbzBbRVkZnYN7Xj1R
 DmvTxDAT1t9v+VfPgqisJWtWjO6MAAA=
X-Authority-Analysis: v=2.4 cv=DoFmPm/+ c=1 sm=1 tr=0 ts=6a7c130c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CzzcSFvl921DoLjfDckA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: wbPNTs1w6hqrAZ4KgaOugkOmTk-ZvvKQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX+nq6SC5c5LEh
 p3p0pJkEPz35A7YsbeJ9avaq83Cg5sAIH24S+Kuy+FjF+6b8JMIFsyvg/fjnT7lEzjJYkaNvp/0
 NDgmi2YYjf4g5Covx0sFcCTP3pX4rcTZOlb98PPSXYjG2RWB7vEJcnTisy3VUgeKFoPgI16v6CH
 t00AtkvnJJEbrFxn9D/rVP43aYUNUkMx7SA59/ZVfpnzuYjnwSdyKwPTzjdF+es/1gKyFOXmBxd
 jIUeZbJIq5ZkpSiM0dATB+xxbTzVjNRYqWcWVEbvqNyAMRgPcyx3FdPe38B5qCFgbczDk3gNzF9
 nRYBD+V0j6AldkUCbeBWI8fUFmUdKjuIUH7BtYZc82AI3RtU9CWflpWSGQJAjBv9mtrbby9LInG
 9uQbCGsx/eUQwbcW2QaeI6C2qvC3uCBTYrWyyLHyXMGg/vFtWg7nWbNrWcAZ5IWQkm6kRZ39n3Y
 ud1ojFKmA58D3bIgW+Q==
X-Proofpoint-GUID: wbPNTs1w6hqrAZ4KgaOugkOmTk-ZvvKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120049
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

UmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+
Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA4MDcxNTIyNDEu
MTU3NjMzNC0zLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbQpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Z2VuX3RjZ19odnguaCB8IDg3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwog
MSBmaWxlIGNoYW5nZWQsIDg3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9nZW5fdGNnX2h2eC5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaAppbmRleCAw
ZGE2NGQ0NjdlNi4uMjg5Y2U4OTk1OTggMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90
Y2dfaHZ4LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaApAQCAtMjM0LDYgKzIz
NCw5MyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYXNzZXJ0X3ZoaXN0X3RtcChEaXNhc0NvbnRleHQg
KmN0eCkKICAgICB0Y2dfZ2VuX2d2ZWNfc3ViKE1PXzMyLCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2
dlZfb2ZmLCBcCiAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoTU1WZWN0b3IpICogMiwgc2l6
ZW9mKE1NVmVjdG9yKSAqIDIpCiAKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmFkZGJzYXQoU0hPUlRD
T0RFKSBcCisgICAgdGNnX2dlbl9ndmVjX3NzYWRkKE1PXzgsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2
Vl9vZmYsIFwKKyAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9S
X1NJWkVfQllURSkKKworI2RlZmluZSBmR0VOX1RDR19WNl92YWRkaHNhdChTSE9SVENPREUpIFwK
KyAgICB0Y2dfZ2VuX2d2ZWNfc3NhZGQoTU9fMTYsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYs
IFwKKyAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVf
QllURSkKKworI2RlZmluZSBmR0VOX1RDR19WNl92YWRkd3NhdChTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX2d2ZWNfc3NhZGQoTU9fMzIsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYsIFwKKyAg
ICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllURSkK
KworI2RlZmluZSBmR0VOX1RDR19WNl92YWRkdWJzYXQoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dl
bl9ndmVjX3VzYWRkKE1PXzgsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYsIFwKKyAgICAgICAg
ICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllURSkKKworI2Rl
ZmluZSBmR0VOX1RDR19WNl92YWRkdWhzYXQoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9ndmVj
X3VzYWRkKE1PXzE2LCBWZFZfb2ZmLCBWdVZfb2ZmLCBWdlZfb2ZmLCBcCisgICAgICAgICAgICAg
ICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZVEUpCisKKyNkZWZpbmUg
ZkdFTl9UQ0dfVjZfdmFkZHV3c2F0KFNIT1JUQ09ERSkgXAorICAgIHRjZ19nZW5fZ3ZlY191c2Fk
ZChNT18zMiwgVmRWX29mZiwgVnVWX29mZiwgVnZWX29mZiwgXAorICAgICAgICAgICAgICAgICAg
ICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRFKQorCisjZGVmaW5lIGZHRU5f
VENHX1BBSVJfQUREU1VCKE9QLCBWRUNFLCBEU1QsIFNSQ19BLCBTUkNfQikgXAorICAgIHRjZ19n
ZW5fZ3ZlY18jI09QKFZFQ0UsIERTVCwgU1JDX0EsIFNSQ19CLCBcCisgICAgICAgICAgICAgICAg
ICAgICAyICogVkVDVE9SX1NJWkVfQllURSwgMiAqIFZFQ1RPUl9TSVpFX0JZVEUpCisKKyNkZWZp
bmUgZkdFTl9UQ0dfVjZfdmFkZGJzYXRfZHYoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfUEFJ
Ul9BRERTVUIoc3NhZGQsIE1PXzgsIFZkZFZfb2ZmLCBWdXVWX29mZiwgVnZ2Vl9vZmYpCisKKyNk
ZWZpbmUgZkdFTl9UQ0dfVjZfdmFkZGhzYXRfZHYoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0df
UEFJUl9BRERTVUIoc3NhZGQsIE1PXzE2LCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2dlZfb2ZmKQor
CisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZhZGR3c2F0X2R2KFNIT1JUQ09ERSkgXAorICAgIGZHRU5f
VENHX1BBSVJfQUREU1VCKHNzYWRkLCBNT18zMiwgVmRkVl9vZmYsIFZ1dVZfb2ZmLCBWdnZWX29m
ZikKKworI2RlZmluZSBmR0VOX1RDR19WNl92YWRkdWJzYXRfZHYoU0hPUlRDT0RFKSBcCisgICAg
ZkdFTl9UQ0dfUEFJUl9BRERTVUIodXNhZGQsIE1PXzgsIFZkZFZfb2ZmLCBWdXVWX29mZiwgVnZ2
Vl9vZmYpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmFkZHVoc2F0X2R2KFNIT1JUQ09ERSkgXAor
ICAgIGZHRU5fVENHX1BBSVJfQUREU1VCKHVzYWRkLCBNT18xNiwgVmRkVl9vZmYsIFZ1dVZfb2Zm
LCBWdnZWX29mZikKKworI2RlZmluZSBmR0VOX1RDR19WNl92YWRkdXdzYXRfZHYoU0hPUlRDT0RF
KSBcCisgICAgZkdFTl9UQ0dfUEFJUl9BRERTVUIodXNhZGQsIE1PXzMyLCBWZGRWX29mZiwgVnV1
Vl9vZmYsIFZ2dlZfb2ZmKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZzdWJic2F0KFNIT1JUQ09E
RSkgXAorICAgIHRjZ19nZW5fZ3ZlY19zc3N1YihNT184LCBWZFZfb2ZmLCBWdVZfb2ZmLCBWdlZf
b2ZmLCBcCisgICAgICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9T
SVpFX0JZVEUpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdnN1YmhzYXQoU0hPUlRDT0RFKSBcCisg
ICAgdGNnX2dlbl9ndmVjX3Nzc3ViKE1PXzE2LCBWZFZfb2ZmLCBWdVZfb2ZmLCBWdlZfb2ZmLCBc
CisgICAgICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZ
VEUpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdnN1YndzYXQoU0hPUlRDT0RFKSBcCisgICAgdGNn
X2dlbl9ndmVjX3Nzc3ViKE1PXzMyLCBWZFZfb2ZmLCBWdVZfb2ZmLCBWdlZfb2ZmLCBcCisgICAg
ICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZVEUpCisK
KyNkZWZpbmUgZkdFTl9UQ0dfVjZfdnN1YnVic2F0KFNIT1JUQ09ERSkgXAorICAgIHRjZ19nZW5f
Z3ZlY191c3N1YihNT184LCBWZFZfb2ZmLCBWdVZfb2ZmLCBWdlZfb2ZmLCBcCisgICAgICAgICAg
ICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZVEUpCisKKyNkZWZp
bmUgZkdFTl9UQ0dfVjZfdnN1YnVoc2F0KFNIT1JUQ09ERSkgXAorICAgIHRjZ19nZW5fZ3ZlY191
c3N1YihNT18xNiwgVmRWX29mZiwgVnVWX29mZiwgVnZWX29mZiwgXAorICAgICAgICAgICAgICAg
ICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRFKQorCisjZGVmaW5lIGZH
RU5fVENHX1Y2X3ZzdWJ1d3NhdChTSE9SVENPREUpIFwKKyAgICB0Y2dfZ2VuX2d2ZWNfdXNzdWIo
TU9fMzIsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYsIFwKKyAgICAgICAgICAgICAgICAgICAg
ICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllURSkKKworI2RlZmluZSBmR0VOX1RD
R19WNl92c3ViYnNhdF9kdihTSE9SVENPREUpIFwKKyAgICBmR0VOX1RDR19QQUlSX0FERFNVQihz
c3N1YiwgTU9fOCwgVmRkVl9vZmYsIFZ1dVZfb2ZmLCBWdnZWX29mZikKKworI2RlZmluZSBmR0VO
X1RDR19WNl92c3ViaHNhdF9kdihTSE9SVENPREUpIFwKKyAgICBmR0VOX1RDR19QQUlSX0FERFNV
Qihzc3N1YiwgTU9fMTYsIFZkZFZfb2ZmLCBWdXVWX29mZiwgVnZ2Vl9vZmYpCisKKyNkZWZpbmUg
ZkdFTl9UQ0dfVjZfdnN1YndzYXRfZHYoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfUEFJUl9B
RERTVUIoc3NzdWIsIE1PXzMyLCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2dlZfb2ZmKQorCisjZGVm
aW5lIGZHRU5fVENHX1Y2X3ZzdWJ1YnNhdF9kdihTSE9SVENPREUpIFwKKyAgICBmR0VOX1RDR19Q
QUlSX0FERFNVQih1c3N1YiwgTU9fOCwgVmRkVl9vZmYsIFZ1dVZfb2ZmLCBWdnZWX29mZikKKwor
I2RlZmluZSBmR0VOX1RDR19WNl92c3VidWhzYXRfZHYoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9U
Q0dfUEFJUl9BRERTVUIodXNzdWIsIE1PXzE2LCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2dlZfb2Zm
KQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZzdWJ1d3NhdF9kdihTSE9SVENPREUpIFwKKyAgICBm
R0VOX1RDR19QQUlSX0FERFNVQih1c3N1YiwgTU9fMzIsIFZkZFZfb2ZmLCBWdXVWX29mZiwgVnZ2
Vl9vZmYpCiAvKiBWZWN0b3Igc2hpZnQgcmlnaHQgLSB2YXJpb3VzIGZvcm1zICovCiAjZGVmaW5l
IGZHRU5fVENHX1Y2X3Zhc3JoKFNIT1JUQ09ERSkgXAogICAgIGRvIHsgXAotLSAKMi4zNC4xCgo=

