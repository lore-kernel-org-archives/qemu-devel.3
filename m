Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39636C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIA-0003wU-Ci; Mon, 29 Jun 2026 09:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHD-0003ap-7L
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:43:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHA-0006CH-Tt
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:43:54 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASweS2641481
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i/UBxztk9FzNckObXXg5AeElk2tIk+IMNK3xdbJ6LSM=; b=htYjLs0WYLtxdrQ/
 NSNvIqhdlZuktzPkRmhRlMIHhahzADaylSZ/FbidLEj3ClhOG+77Hzc++OwKoKig
 HHZsX90Jm21B0x3djWkmZHAXwqHjOm4MBwqK1a6ABre7IaoLNJcqRv5Y/UU+hTi2
 wvIYEev3zbnKy96HIuKEJ0qjbBEmBzjmXPdlnWh+95/x5GmCxdnI/MWNkEzzhzhK
 sks7iL2d4/Y8flLDNHP47C9ZCmQJ36EKIGnPH0RVZpJUjfkprsAFCRnZqYMUx2o8
 baawtw/cJrHHQi/9/3Tqpo+18x0rRVXlZE7XRve0IDj2PzDrHcPeu595W+ZsGMjY
 38lx2w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3npes2sa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:43:51 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c8018f11fbso27065055ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740631; x=1783345431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/UBxztk9FzNckObXXg5AeElk2tIk+IMNK3xdbJ6LSM=;
 b=CxYwZWxZCd0f9iDKJrNdKvvbLvEUfGS1c+dfB3rVMektZxrFgjyjG03Yzn7y9Ua8PV
 meHcorIR5i5YAct70DzFRC+6DbMutS4YlAmHfH4UUfygRBp4R/wsX/Jizd91FWyc7xAf
 FeOefXPbuxlqe5BwFvsZuehmhUr+OrqVfT/wkXqFXy/kr6fWPtws5uwz6XmIby73HLbb
 jdtc3Ho5lZ6uosL0F2D654kwYBTvCUiaYSUNfQRne8RAg6x+x7DxUAVXp5sEoKxz/g57
 a3CTwakmaWU3Voi84ZP1pxDXJorUXO2jw0plDFHD/gaLjxSxsLRPtKduB0RJ7O2xStOx
 7IuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740631; x=1783345431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i/UBxztk9FzNckObXXg5AeElk2tIk+IMNK3xdbJ6LSM=;
 b=ql3YFjIwWJM0RqAAGRRENNQtQEY8s14y70P1ar2Xd8C2MtOhKMCTXcWUS750vp2rhs
 +TmT/rpTtdMqPyh5uVI6QNFxt+QTnEo5ab7RWZXRP4djQVsd+txSIhdFKKZ3tOGog3uR
 pd3z2h5P0D8TSa+gE2WCYgURMXjwV3MTejQNuH1Kfmb3UW89B7fVJQn+IbpHX3BAAwIO
 smkQlBYQcN6K2L1gWp3KYEo50ejtiP8MvYxhv3YbY/A1MC5ttObd1xMYhgu8BVeBa3yd
 YWMu3fs1AGDyh3G/zrjuz2qzVPti63I/GFwbLmuLITVrylR7b1pzK/PJV/JWxlTlLrD1
 ig1w==
X-Gm-Message-State: AOJu0YwmgJiDfY0Q8i++lr2DVOf33ZgHV7HMzejQBnVMCaQqioNbguRu
 Pzvse1c+ZDyC0DnsZWC1p4CuWsJX+O+ju9N4xsn7Le6QgagLwUPrJIzAQcQSLcZ5KyM0QeIhcWl
 XI9/8MOYgpM6fHZ7BR9yETmQt4sselwvN7eYpuOc0SwFpK0Kem1hIMBWUASaNS6Soqw==
X-Gm-Gg: AfdE7clAIodhoQTontYmWmpmsiofm79AVSuUYLZbUQnTKk+LEQrdnJUK9c+DCX51xAt
 9r9cAiJfpZzVptNWQEsDM1ZXgfN1s7Q05xdOPUeWQikezZnrjRT49701t9I9eFZcEboU3LD62DO
 3EhF0sJ37cPPRAgT1W/mpLPdpoC7PxSbpL1ifSVDqBDLe8/PEFpsUD8Y9yZLsRcWZjyAi1M9ifQ
 ku3ZyRiQ4UZ3vSqwJOuVQyJfypxamMJ8T+J4X+19QlMW1HpJmp+trN6FXxGmF/j85e1IIwTmRoM
 2FFcCZ5gNj0/gZ2PrDXn2ECsv6tKeS/BwAQfA2La0xA+MPLHhxKk6Cdo9gRB2VfiKMeTu61UGK5
 5pPzrNEnSmBPW4E/w8ZaeJC3Utf5vQaiwDjcjFsD2zGK1EYa+5Fk2iiUAQ8E=
X-Received: by 2002:a17:902:d488:b0:2bf:27b2:4b80 with SMTP id
 d9443c01a7336-2c7fc89fe24mr154939505ad.14.1782740630676; 
 Mon, 29 Jun 2026 06:43:50 -0700 (PDT)
X-Received: by 2002:a17:902:d488:b0:2bf:27b2:4b80 with SMTP id
 d9443c01a7336-2c7fc89fe24mr154939375ad.14.1782740630118; 
 Mon, 29 Jun 2026 06:43:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:43:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 44/77] target/hexagon: Implement {g,s}etimask helpers
Date: Mon, 29 Jun 2026 06:11:59 -0700
Message-Id: <20260629131232.2487780-45-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX2vAsYRBgjYpa
 KXLQafsJcdrNd1KY5w6xv00wvzPiFB9YNoTS5HuLbeGiFgjZUcEU68Hx2NdC+YIZFkUWQdpCkQM
 xU7OC84IYlwwbv6lOxFuZDpYFbQ6fdYftmrzLEDDaxBwBtofbCCl5oEQlkvjTHqg8mUzNSl/Bzk
 o7JzF+5vn23sLND+Zzx1eIo3/w6exBmgcWTMJldD/us0h6q6P2O4YQcQGib+KxXm9LBonsn3YSk
 U/xqiGODetYU6r8H4MoH4fmNt1WnM67nYRP2fzhxv0EdDZyTitCF2CfevlDG7UfgZhBCBNFqq4X
 3p/d9lQRoaORPF3ugdk7Fvu76yO8xQK1oYLMwFfvWr5ab3Tzf6H3sVp60ZIsRJKU9kB4lpTYPOe
 4860DcO9PmQaV4KFA+5bDgL12A0ukTclPFh9E55rcTT87t59DnqakhFDf/1YtrfCmSwSRUf/jHN
 vIs0NPB7as8SNelmguA==
X-Proofpoint-ORIG-GUID: JQDKADeDcy0WTCYFsW8N2sIhyVTiW-QM
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a427697 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=he7afFXPmx5H4pWyvLYA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX4C3C0VWEpC0L
 mmBvfqM64ayhb6+U+WFd9RALFKLGm+2eqB1deL8p0KDdcmk6vlz6LBiixstcQyZd9TmI+BhojYD
 envqWVJ2nyaKQdzgVftW+F8ZC3PuMs0=
X-Proofpoint-GUID: JQDKADeDcy0WTCYFsW8N2sIhyVTiW-QM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiAxIGZp
bGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
CmluZGV4IGI5Y2YxZjE4OGJiLi4xNjgwZTMwMGVjNCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE0OTks
MTIgKzE0OTksNDQgQEAgdm9pZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIAogdWludDMyX3QgSEVMUEVSKGdldGltYXNrKShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgdGlkKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cisg
ICAgQ1BVU3RhdGUgKmNzOworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgQ1BVX0ZPUkVBQ0go
Y3MpIHsKKyAgICAgICAgSGV4YWdvbkNQVSAqZm91bmRfY3B1ID0gSEVYQUdPTl9DUFUoY3MpOwor
ICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKmZvdW5kX2VudiA9ICZmb3VuZF9jcHUtPmVudjsKKyAg
ICAgICAgaWYgKGZvdW5kX2Vudi0+dGhyZWFkSWQgPT0gdGlkKSB7CisgICAgICAgICAgICB1aW50
MzJfdCBpbWFzayA9IGZvdW5kX2Vudi0+dF9zcmVnW0hFWF9TUkVHX0lNQVNLXTsKKyAgICAgICAg
ICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQsICIlczogdGlkICIgVEFSR0VUX0ZNVF9seAor
ICAgICAgICAgICAgICAgICAgICAgICAgICAiIGltYXNrID0gMHglIiBQUkl4MzIgIlxuIiwgX19m
dW5jX18sCisgICAgICAgICAgICAgICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQsCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICh1aW50MzJfdClHRVRfRklFTEQoSU1BU0tfTUFTSywgaW1hc2sp
KTsKKyAgICAgICAgICAgIHJldHVybiBHRVRfRklFTEQoSU1BU0tfTUFTSywgaW1hc2spOworICAg
ICAgICB9CisgICAgfQorICAgIHJldHVybiAwOwogfQogCiB2b2lkIEhFTFBFUihzZXRpbWFzayko
Q1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHRpZCwgdWludDMyX3QgaW1hc2spCiB7Ci0g
ICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBDUFVTdGF0ZSAqY3M7CisKKyAgICBCUUxf
TE9DS19HVUFSRCgpOworICAgIENQVV9GT1JFQUNIKGNzKSB7CisgICAgICAgIEhleGFnb25DUFUg
KmZvdW5kX2NwdSA9IEhFWEFHT05fQ1BVKGNzKTsKKyAgICAgICAgQ1BVSGV4YWdvblN0YXRlICpm
b3VuZF9lbnYgPSAmZm91bmRfY3B1LT5lbnY7CisKKyAgICAgICAgaWYgKHRpZCA9PSBmb3VuZF9l
bnYtPnRocmVhZElkKSB7CisgICAgICAgICAgICBTRVRfU1lTVEVNX0ZJRUxEKGZvdW5kX2Vudiwg
SEVYX1NSRUdfSU1BU0ssIElNQVNLX01BU0ssIGltYXNrKTsKKyAgICAgICAgICAgIHFlbXVfbG9n
X21hc2soQ1BVX0xPR19JTlQsICIlczogdGlkICIgVEFSR0VUX0ZNVF9seAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAiIGltYXNrIDB4JSIgUFJJeDMyICJcbiIsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgIF9fZnVuY19fLCBmb3VuZF9lbnYtPnRocmVhZElkLCBpbWFzayk7CisgICAgICAg
ICAgICBoZXhfaW50ZXJydXB0X3VwZGF0ZShmb3VuZF9lbnYpOworICAgICAgICAgICAgcmV0dXJu
OworICAgICAgICB9CisgICAgfQorICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLAor
ICAgICAgICAgICAgICAgICAgInNldGltYXNrIHVzZWQgd2l0aCBhbiBpbnZhbGlkIHRpZCBuZWFy
IFBDOiAweCUiCisgICAgICAgICAgICAgICAgICBQUkl4MzIgIlxuIiwgZW52LT5uZXh0X1BDKTsK
IH0KIAogdm9pZCBIRUxQRVIoc3JlZ193cml0ZV9tYXNrZWQpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCByZWcsIHVpbnQzMl90IHZhbCkKLS0gCjIuMzQuMQoK

