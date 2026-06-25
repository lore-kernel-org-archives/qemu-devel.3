Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D68CCDE00F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wckst-0006ce-Tq; Thu, 25 Jun 2026 10:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcksr-0006bI-49
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:16:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wckso-0008PQ-JM
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:16:48 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9ju6B1753859
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=GLP31WMp9ya2aQSzhpJX7UU63XGBhoUjedxw7x1beJQ=; b=pv
 hyPhXuDjBZD+Z4MW8em3r6zmdK+wVz6GtOtaA21G0p+mjxxIuD/LO2ydw7di8rip
 hvmzpHrCpgb9BCsi8Q2dZkMnhi2dGqbifBLlPxt8mWE+3DOOYgpWPx0FXaIHe7/H
 ZP+PJOCS2S3csez7w78nQoKcam5Lk/8eaELlmmVz68Zs8FxO3jUlZ03LgxNFwTfe
 5tbkcp76aFML/7MC6XRQaNpgPPOSne4lTKVwbaMdzuBoFHDnIXKixI2BmZ81aZvi
 b5kzy4fUbfCIoGSdMaM89a50DiE2odEvwUm4vc9D6YQ8We5nhNBmu4N0Hpp4A/At
 5LdIqMJrq99Iwukes+Cg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0w0q26s8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:16:44 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c42d96713so1711412eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397003; x=1783001803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLP31WMp9ya2aQSzhpJX7UU63XGBhoUjedxw7x1beJQ=;
 b=ItZOTnF6ng3qyjqNCg/YY45d4t9I2jFtMcgYUXbTmHSKyxUcNKA1Sxxuc2zQEx2o3n
 FUM1zKarl+3Pj9cCDJXy1IV/3ogWPwnzbJMYy76jTAB7m34fuxmTb9dhGcFdsFaWLsI5
 DQtKRIPorgXAG1CRgmC4X9fec3acUVUmAhi4J1WR8auWwcHNnS0iekykobM8jpsRjKYe
 zh4Il4SD8X6NEVWAoz0arMFuNROtiYwoq/dsVFvN1Og8SVBnAs/80XeqWHZcI04zNKCG
 uo/PLAOMyJMjC3KVBpNJllKOgd5Lj3pXKZaDZ4HyG0a3vDIbCayh/6ILK179/r0AZgUs
 1e6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397003; x=1783001803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GLP31WMp9ya2aQSzhpJX7UU63XGBhoUjedxw7x1beJQ=;
 b=eaWuPYtLgeMpfpn4nLO+X/iL2MBuv9x/DEfk7ei1IJjb8XFqEvpc+8Od+T1JREmqyN
 1Bt+ooXteuIbHh6XUrZIB5uVP7e5+TDL1a8644kyF8geL5boJQ0So44XLLfSm50QrUBG
 XfqGNhkT8vesvbElLb4Q9IpDng+nUTfls1CJkEai4dcelTCZ4Iyc8N6lrOo4N2JazWV/
 TFXsqQl1f1uPHgDV0WU7ekwNMyO9EWji8rhe0IgnCL1ycfCoz6YaYOsjziFIlakgrM0v
 76+o8WWeI1GmEBW4pZS7+MlPudWSbUJRnIrY7KbEOSUvbygIv7YAhjNIBMOw4lukZF59
 284g==
X-Gm-Message-State: AOJu0YzPKTKgEKOXjVUodIpdUxyKSdEXp1GVUq5zTIvyfyW7sXuFLckc
 ZgYuDFjjA95HN2UuPb1jMhUn6F6B2GF9b8d/iNFpxvYstwHGJ+XfGDgrGYe9sgqskfj3EhsS0kP
 GYLEzuLQ1WAcEUAZry/Itsw8zM/FXa18S/sex+JQWFr/dY6E/0CF35fidehcPSpiN1w==
X-Gm-Gg: AfdE7cmplYAmjsnIExFCARfzHHfhond7vN8BuFM7YJg8UjEpoPe28DyPK3K6K1Z4G46
 z/hGt6+zsNKlg5j0MRLkNONdP7k8OpPDB+0xOr2uGhhJqXK+bBleRIdFNsgayjiKRcx1Isvhei1
 Z3a0+oo2Arrm6G1rYDbksSS5T3W1wWX6+lXOICZBqASzmEK6AlhQhl3tHH9Z0SIChhUlPyRYIHG
 w/wqgesdCAxsXFQfyb21sWDmqPtSefltf/hJMXo5mb7ViSY1EpertYeXx0arhel+SViVf0SnSP/
 4fE67RfrZv5TWnfPALB8G2Gqz9LxVk2yrBF4bxQKvKS9F6YERQGwLW14VyOVHXByOhcheAtnr4b
 fYAnClPgvaY8MsUimWa7bOMZCc5LTEiY/kdhJ6rzH5BwczxIQm5IdDsWKrHI=
X-Received: by 2002:a05:7301:6a05:b0:30c:5254:788b with SMTP id
 5a478bee46e88-30c84db2886mr3037959eec.10.1782397003125; 
 Thu, 25 Jun 2026 07:16:43 -0700 (PDT)
X-Received: by 2002:a05:7301:6a05:b0:30c:5254:788b with SMTP id
 5a478bee46e88-30c84db2886mr3037887eec.10.1782397002217; 
 Thu, 25 Jun 2026 07:16:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:16:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 02/76] target/hexagon: use cmd_array() instead of get_id()
Date: Thu, 25 Jun 2026 07:15:19 -0700
Message-Id: <20260625141633.449487-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: XvJQqN-igBfx_t3ho2oIg9eEDAWEFQKs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX3k0lQ+m5wRM2
 QdtWcP9KJllMNIMiGkwpizlcUjAsIaYB06YxQBLZgbdEteaAmUnRN0dZhEL0EfP4j21K7v1/WV6
 h2GQ/ljEjCY2lLX4d5hZEAnbg/rKZgs=
X-Proofpoint-GUID: XvJQqN-igBfx_t3ho2oIg9eEDAWEFQKs
X-Authority-Analysis: v=2.4 cv=R6Ez39RX c=1 sm=1 tr=0 ts=6a3d384c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=SrZkeIdwbWuKvdoqoQQA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX9+plnJhqRf0+
 T5cRp3ITt2PrbA0z606Yh+Rx4wNUhivqQaCfBiNCFDJx6AbJXHFKE7uwaODudLT2ZunyqW3M/n7
 VGzWeG25mJJejSYz37YqVQTZI32Sjwea2oWK5v06AHXv5us3F2mCXjGlSCI1XWi6AXxj8NIiNvp
 AQE9Qbzh1N2QtRvydu29tL63Sv8+EU8G/6yx5DX2cnsqYlq8WvUJalvyZml11uyRkUogUOrZZ08
 B6s5QgI9yTr+U9V/ZYCTEFK2gkhTsdwh+nkwMKRWGk0DCPyvYhT6gZLEnChV77Mo3LjXfHEjdZR
 u6Sx9/83jdOkcmQENmpQKbP9g0fMRHnwt4yNtg1+EMQ2IdzAjJnmNob4w8OnqNrqciJCPgkXEBK
 H8PBFGYv50QIdtGOlWwhkS7GPVN2RGRBfeHzDS8V1fG1QSfj9B4Q1MGxkPGdu1GRadMkPzPaMgH
 MFBxIJJpe+fwX0du+EQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250122
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

Z2V0X2lkKCkgcmV0dXJucyB0aGUgY29tcGlsZXIncyBzaG9ydCBuYW1lIG5vdCBhIHByb2dyYW0u
ClBhc3NpbmcgaXQgZGlyZWN0bHkgYXMgdGhlIGNvbW1hbmQgZm9yIHRoZSBpZGVmLXBhcnNlciBw
cmVwcm9jZXNzaW5nCmN1c3RvbV90YXJnZXQgaGFwcGVuZWQgdG8gd29yayBmb3IgbmF0aXZlIGdj
Yy9jbGFuZyBidWlsZHMgYnV0CmJyZWFrcyB1bmRlciBjcm9zcyBjb21waWxlcnMgc3VjaCBhcyBl
bWNjIG9yIGFueSBjY2FjaGUtd3JhcHBlZCBjb21waWxlci4KCkxpbms6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3FlbXUtZGV2ZWwvQ0FKU1AwUVd6UUVnb1lNQ2daWCs5akN2clY2TzNScW5BK2Rm
MURwVDJSNk1adlZYaU5nQG1haWwuZ21haWwuY29tLwpSZXZpZXdlZC1ieTogU3RlZmFuIEhham5v
Y3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1E
YXVkw6kgPHBoaWxtZEBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFn
b24vbWVzb24uYnVpbGQgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQg
Yi90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZAppbmRleCBkMTY5Y2Y3MWIyZi4uZmYyMmI0ZTQ3
MDYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkCisrKyBiL3RhcmdldC9o
ZXhhZ29uL21lc29uLmJ1aWxkCkBAIC0yNzAsMTMgKzI3MCwxMyBAQCBpZiBpZGVmX3BhcnNlcl9l
bmFibGVkIGFuZCAnaGV4YWdvbi1saW51eC11c2VyJyBpbiB0YXJnZXRfZGlycwogICAgICAgICBj
b21tYW5kOiBbcHl0aG9uLCBmaWxlcygnZ2VuX2lkZWZfcGFyc2VyX2Z1bmNzLnB5JyksIHNlbWFu
dGljc19nZW5lcmF0ZWQsICdAT1VUUFVUQCddLAogICAgICkKIAotICAgIGNvbXBpbGVyID0gbWVz
b24uZ2V0X2NvbXBpbGVyKCdjJykuZ2V0X2lkKCkKKyAgICBjb21waWxlciA9IG1lc29uLmdldF9j
b21waWxlcignYycpLmNtZF9hcnJheSgpCiAgICAgcHJlcHJvY2Vzc2VkX2lkZWZfcGFyc2VyX2lu
cHV0X2dlbmVyYXRlZCA9IGN1c3RvbV90YXJnZXQoCiAgICAgICAgICdpZGVmX3BhcnNlcl9pbnB1
dC5wcmVwcm9jZXNzZWQuaC5pbmMnLAogICAgICAgICBvdXRwdXQ6ICdpZGVmX3BhcnNlcl9pbnB1
dC5wcmVwcm9jZXNzZWQuaC5pbmMnLAogICAgICAgICBpbnB1dDogaWRlZl9wYXJzZXJfaW5wdXRf
Z2VuZXJhdGVkLAogICAgICAgICBkZXBlbmRfZmlsZXM6IFtpZGVmX3BhcnNlcl9kaXIgLyAnbWFj
cm9zLmguaW5jJ10sCi0gICAgICAgIGNvbW1hbmQ6IFtjb21waWxlciwgJy14JywgJ2MnLCAnLUUn
LCAnLUknLCBpZGVmX3BhcnNlcl9kaXIsICctbycsICdAT1VUUFVUQCcsICdASU5QVVRAJ10sCisg
ICAgICAgIGNvbW1hbmQ6IGNvbXBpbGVyICsgWycteCcsICdjJywgJy1FJywgJy1JJywgaWRlZl9w
YXJzZXJfZGlyLCAnLW8nLCAnQE9VVFBVVEAnLCAnQElOUFVUQCddLAogICAgICkKIAogICAgIGZs
ZXggPSBnZW5lcmF0b3IoCi0tIAoyLjM0LjEKCg==

