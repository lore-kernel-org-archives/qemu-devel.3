Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E59CDE00C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclNR-0002bs-TM; Thu, 25 Jun 2026 10:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNJ-0002aL-Cm
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNH-00005E-TC
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:17 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jvvX1723469
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i/UBxztk9FzNckObXXg5AeElk2tIk+IMNK3xdbJ6LSM=; b=Z1ZupyLYKkWyFqx8
 nh95wD3fj1S1T5iMY6mfi1Wm5JIfbdKJ96D/aVio5sr9qmCb3h4ZDxFd0mUS4qnK
 c89dQhDSmx5lBPj45iajs2Lm2STf7GEO7jvADn326SH6B9TNdY6HbwIbH+ycjuHl
 SjgLmvvAtfuxfNwJS2shOJ9CvkySudGTKUJKuD7lze17kpBILunREARJ4Q20JwkR
 5E3Yfwnmh2I6/rPz7kCvYRpSiuR0C5bDwxi5BnNjPoB7CNWX+0n6N6Zet5IxKK1Q
 hpvpiFmFVYdX0IZfVX1SBomIcapoB1dWsEWdyLemSRkZa2Wx2qDQEq8UfVBN+wl7
 SpUGTQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0j7dvtd8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:14 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c8d355dbcso1549581eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398894; x=1783003694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/UBxztk9FzNckObXXg5AeElk2tIk+IMNK3xdbJ6LSM=;
 b=hCCdWO9AxCwG/t9XcKIkcbwwSEL/qbx9HXCot5KUFkhYppWvucmloGaZYNp7liSWG3
 eIjYr92IPjRgW1GmD/3CHZpWEtIqV+VSFB5L+tKmidjC8p3L7JWs4WFQxHMgHQ+1BY6i
 KszBot5QsFfgPNobD8G3huX9VXU2ugffhdDs1RB9hvK+3pqZT/Y2trd+sba+vWjWdrzC
 +DEHBv2whqrKXqWoOLM4SBvYms58wTEXa7nALaa+jpqacPIh1XV0FJMd2rdc3cd+bhAP
 leJQZlkfO1cDnApAWka88ILiKt6lRJ1awO7DSx8IHUiVtH+z/l3DsKW3eTebXQjtTYUT
 uGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398894; x=1783003694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i/UBxztk9FzNckObXXg5AeElk2tIk+IMNK3xdbJ6LSM=;
 b=ksO3Ahuuop0BIpK4s3Ts/FeAPNcEnM/Uq6+n/wK5spbC1Dg8EcPfdj1NGQiq8pgChf
 ddnodmXQ7AiDom69v4+0/TI8wimWKgA35iDu530Y7gMsXV6my4oUNwK8c6dH3jwfnFWu
 mC7j4Nh/q7eyU8tOagZqtpg3MV73s0HoJQzpm+Cy9OtrvmlVxu8ywXTALkXqn/wmi7Bt
 oMKQg1OCBiZzsdP7GH6JmQeAOOJd6GbdhCiw0Ie6+fLcw9htVwhiZie3xk1PzQKoM2Ae
 Colt/EVZ1BDBvfQkr6annpImSSrfJJixuT6I8LGit2nyIJH+wX8uINypvFv/iyCKvjbn
 TK7A==
X-Gm-Message-State: AOJu0Ywk+H622c7zZI+tSEPUrrXLptMGEbHsn0D8MFHm+uJqomQdYIyk
 Idn6G8yzZZlMhcQtz6bfmMCu4w8KXNH18k5nih/wLjQw7MlV5fcFPUolpXj5XekaRwo5D50Sw7D
 7zsENPW8GSpjsxH/urgOQlnYXIKnQ4aGDuMBqOwP/WpsuThLLQqrg0Cvcak+MRSYsBw==
X-Gm-Gg: AfdE7ck9rm8l1YCYuWPRcuouLudj4R7XVn5wbal5SHtyXwMjdVqwmTjqTMN3x4wUhJF
 5xJ2V+zV235MAhwTlW7Zx0Lf/5LRvxF/suPihKkV4h5ccKGfDAuKo6pjrVx6y1jxetTUeKNuzZ0
 xoEtYC4jNGdEVhfF+wwgxSdSzcXxN/q1M8sz5ULHyQvu3Eg3gsi1RakYfpDhSVUd9hf5JoIFh0u
 kN9a/3R1FqJKhLNoSLHUaQsaiYlK8LgJgrwJzMsuAr3At8Qf5+rbWBaf+7gzqLojQJa7fshnYeH
 MhSfrvdt0EVBw36OTiJxqiyAuPaznJa9nR5pRxHkVwJ7GItp/wJNVJ62h8mvyfQbx9glb2j24Px
 Z787UrwwunE64W4xKICKU15xEOrhUbTKA0uQiB01h+oxBi3q7dWacvoXZgys=
X-Received: by 2002:a05:7300:6143:b0:2ef:9961:27fa with SMTP id
 5a478bee46e88-30c84d127b4mr3321854eec.18.1782398893698; 
 Thu, 25 Jun 2026 07:48:13 -0700 (PDT)
X-Received: by 2002:a05:7300:6143:b0:2ef:9961:27fa with SMTP id
 5a478bee46e88-30c84d127b4mr3321820eec.18.1782398893182; 
 Thu, 25 Jun 2026 07:48:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 43/76] target/hexagon: Implement {g,s}etimask helpers
Date: Thu, 25 Jun 2026 07:16:00 -0700
Message-Id: <20260625141633.449487-44-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: j92VwCpl6tdaNIFTgRi7SqbRxnWJJX0C
X-Authority-Analysis: v=2.4 cv=NvHhtcdJ c=1 sm=1 tr=0 ts=6a3d3fae cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=he7afFXPmx5H4pWyvLYA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNiBTYWx0ZWRfX6sdjqjAirV36
 6Ezn1BkhEqp+D9nlm5PH99JoHH9KHg3+f91HThoTB/I2omyS38SW4buftbLpMy5SJ0Hn5zK4d4n
 xTzGffjicYuCtGuuDPx+c7NwQlj5cow=
X-Proofpoint-ORIG-GUID: j92VwCpl6tdaNIFTgRi7SqbRxnWJJX0C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNiBTYWx0ZWRfX2Hv5YRJSLoiW
 /4M31+CY+BZcn6jwgh44R0HNF5e8WbnKR/ZQ6sbICV2CF0PsVXK16F1WGTLksYEIdylm44W9H32
 0B4K0VriP7SzHe9c1c4QdKC02dxQoJQxpSs7uXc7BCDuuBCxvBLiaH79jS+Tuk7Fjdf2qRxcUsp
 yPC5vkIAmIlf0Ju7wTy/Lmro48L8Gch2hK5Hq3QRgcezwDjodFd5puR+kaQGcOjZigewq5ciErL
 jWqCdY/p2tvzLdbu/I9tFZyOpiAk77YImg1GASygTM0McZoDYcg/+llUK8KErRJkr9W2KoK/SYH
 +KWCnRf7Gzzisn7KIh+3pSyQHEAJ1FweH/2hN8nSjZybzD8YD7LpgajSjXoYeX2JdKdNgyVy3Cr
 /igw8XRQYikq3yQFPkoR8nmYmt28a7+D9iMyIJse7yA+2T9UwsgVcEelsqhu2Kd+0PSPL3ZqhBm
 czspwZ/HpUHoAAw9lOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250126
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

