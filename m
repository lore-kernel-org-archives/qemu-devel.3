Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1644BCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 03:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDZ1X-0000kX-8O; Sun, 04 Oct 2026 23:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDZ1S-0000js-Uc
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 23:05:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDZ1P-0007tg-7t
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 23:05:50 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69510HDx4061317
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 03:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R3QFNitgaeqnytPkPxznMj55KhvEIwRdFm3cfN9IhC8=; b=YtNNWVTt3kcGy0VM
 FKVTMo232JeNtiKs3HARLEeXUhrsok/IWBxmlHZ+uz3PQaPn7SU9LnxAGWLuW9Kc
 lePPzLLE0BfyaDOqhtTB9LIB5liY1UMHc1on1nWLNgOofxW+2ZActs6KU/+SW6dl
 f5gE1ShTMdOSewRvZBu0kRVwxQDCcXsCeFD6441P9xVNl/QrpJbHbDHN1DvDtnQ7
 JSm685y3ltfio0EzbvvjY+2oDTeDWRXVdD5Kp1WXxc0Msb6yqKWQevsryjdoKR7f
 g5d+ghpe0GIXZ9axG1ep7xPeKbs2GnEu8H5DZZps5qkT/VLujdqN2gN5dZHd8jYT
 Jme93g==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h41gn87sf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:05:45 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-149e8e8ad71so182747c88.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 20:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791169545; x=1791774345; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R3QFNitgaeqnytPkPxznMj55KhvEIwRdFm3cfN9IhC8=;
 b=LDsDUwZIQRRXv55wbFd7rc5RMK/XCGssd6d0GGbHkaDNiokNsbmFPhhFYDPEEwEujS
 iqSQ9vlq4OqB9UERtoTEvgmvUeNoau6EmIARbNSGotxglGbnfjNltzg8C/7TBFA9UdLK
 GevhEgo8wVQdFURp6mRgvl22mZ2KVqvvnsJBoWwEehU8gIx2l1+8TZlZhHpiytKBA5n1
 6jJbnXG3jt9W3+wdpikJWDsVHBNJauTmzdhyFJdtTvbjOzrvcgLxde+eXY7EZFVBsrVU
 gApbgywSqFCzbWwuCaptWN7aRD4Tjk6Ub2xireR/tRMgELE7LBIwrAMrRk/HVVgDmZl8
 tS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791169545; x=1791774345;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R3QFNitgaeqnytPkPxznMj55KhvEIwRdFm3cfN9IhC8=;
 b=M3kwOT1+hypbOMMP458F21V+7PmDjW31xwJRGxTGT94Fif9vXlHY8rTwP5S/sB7F44
 8opFbRKsXTMIvscgZm00Hm/nsluorXdXXHK1lHYZOjuOxyVt5zFKZynXv9w0zJtS5iji
 viM5EJKFwKLY0E6r8XT3Z0NiMswGGrls+nAbFjiPTktd22tWx7YCGdOU7P2C6Z/usoRE
 eRovSqmPZ0vkqZTcPD9Aykhm5PkqSH+cfhhkjyfpv0p8PNVSAXQmptugBuw/ZgxUEakE
 qbpJP9Brp67IqU6Ed0DG+DhruB+sGzGZmJl3FH1aybONG24JZSnZB8+T69hNaGqmMPgO
 CoJg==
X-Gm-Message-State: AFuF++kg0hHR5//P0JLraBppM+qhFl849rA8PCQm4SYdsvX918CUNGD6
 6pA8nzUC1HmptOcwhsUuFHrsXSD6eDSNbm496ZH8XlhFSbDnzg+/cQvxMYD47YF4bfdRpPrzz84
 sIDtgjt9j0narQm6k76yvc1oFGtZgs4qNVGcpn055qjO7NfJ/P07+bnSFc0cC+vGR6w==
X-Gm-Gg: AYBFou3Xo1tpPWejoEDlUHbu7XlQ4VKKFQbBUc30NdRTLI4wnfpn+LBYraCmH7rKOzL
 O0DiCmNVmhW8iRakotmhreU6TzBv4iQ5+p4upwO8WHhK35cGQMugXgGGTPsknlVgFPcZ/jHG1TS
 O32frA/SBWJ6hfF/gF0+67nVQzh7cRnCw1DUc9uEnPmQAjSJ0wQsF3IbkTo2lRro4bI4tknmC9B
 B+HAtH3R77ldFs7Ir5lzuMlTsvSnZqPaq2HjmMy8ppXhgNzH2JyT669A928WnjNuC4rqhMiULYS
 cc+iOYW7VzNIEgZgPlzt21wjuuP/2+kyBapRK9H4fuffGq1Ta03nbTKjnvWSoNi72ATUgPrHEnz
 Z94WxaIs/C/la0MzyVqkgO0bSn8LVghtO3K4lqDW5QXx3n0ZO
X-Received: by 2002:a05:7022:29b:b0:156:6676:d0e2 with SMTP id
 a92af1059eb24-1566676d412mr3941823c88.10.1791169544974; 
 Sun, 04 Oct 2026 20:05:44 -0700 (PDT)
X-Received: by 2002:a05:7022:29b:b0:156:6676:d0e2 with SMTP id
 a92af1059eb24-1566676d412mr3941805c88.10.1791169544470; 
 Sun, 04 Oct 2026 20:05:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fc872e43sm17720559c88.7.2026.10.04.20.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 20:05:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 2/2] target/hexagon: gdbstub - Add sys reg support
Date: Sun,  4 Oct 2026 20:05:38 -0700
Message-Id: <20261005030538.1257295-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261005030538.1257295-1-brian.cain@oss.qualcomm.com>
References: <20261005030538.1257295-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: F6Ry03co9nLK2gHgafMmFrKMtoXR88Gm
X-Proofpoint-GUID: F6Ry03co9nLK2gHgafMmFrKMtoXR88Gm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAxMiBTYWx0ZWRfX7mjsjM9T67s6
 B6VBW3VxIYTk9nZWc1IjEiD44r1PIaqeS3syhUhJ+jMm6pcicv4CRT9+LYVTGLxBYBFucuhmWV0
 za8Xq9edK6v9hWs1mfzYwnT30KmohbCH79m9DVZp9i45JPgcJyj8l7NtoO8YodTlhX3UJ1X31DU
 ANIGMXeSIzH1P7b2f5xoGXY1FDT9LgWh1/jvULswxTE4stcXFH7ifHdIfKX/JkC/BBSGaJdARtc
 OA9Dn8nzbRtqbZguA69MrbbsL1BI79bMYVNeOzt9/nvFfbvTot8hR/0a8srtiMb5SKn6Qr0EWfI
 /SDJTloUbyIEK3h1EKL4yWD1HqbV14pinxeJnFl9GqrM2G1G/Xi7m/lphw0+HCdLiCwHLvO6tne
 GPonkZwZ60K7OMMtmO8LIlLQnKkUSxy6bR2XWY/Q9mvSu2JGN0nKa9psbCwp7tS6vm8gEkIC7pM
 PsjOcym7g0Lqt/HSg5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAxMiBTYWx0ZWRfX7ypdHeHLQORs
 mCTfiXx61GUT5s4TlWHWRclMjng2roQvVTTdiF5dqlsDNxqHVoxJo/f5iiLvm6cRd3hLg5rGjSC
 ob52z9+jFK/qkFs8JTST7OtAgZqG8JM=
X-Authority-Analysis: v=2.4 cv=P9WvFSAu c=1 sm=1 tr=0 ts=6ac31409 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=fcRPBzItccz9Tp0UfQgA:9 a=nwGC1WbVB-CFprm_:21
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050012
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

QWRkIHN1cHBvcnQgZm9yIHRoZSBzeXN0ZW0gYW5kIGd1ZXN0IHJlZ2lzdGVycyB0byB0aGUgZ2Ri
c3R1Yi4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9z
cy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgIHwgIDEgKwogdGFy
Z2V0L2hleGFnb24vaW50ZXJuYWwuaCB8ICA0ICsrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAg
ICB8IDEzICsrKysrKy0tCiB0YXJnZXQvaGV4YWdvbi9nZGJzdHViLmMgIHwgNjMgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDc4IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1
LmggYi90YXJnZXQvaGV4YWdvbi9jcHUuaAppbmRleCBkZjRjMDE4MjI0Ny4uZWE1NGFmNjIxZDIg
MTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2Nw
dS5oCkBAIC0yNDEsNiArMjQxLDcgQEAgR19OT1JFVFVSTiB2b2lkIGhleGFnb25fcmFpc2VfZXhj
ZXB0aW9uX2VycihDUFVIZXhhZ29uU3RhdGUgKmVudiwKICAqLwogYm9vbCBoZXhhZ29uX3RocmVh
ZF9pc19lbmFibGVkKGNvbnN0IENQVUhleGFnb25TdGF0ZSAqdGhyZWFkX2Vudik7CiB1aW50MzJf
dCBoZXhhZ29uX2dyZWdfcmVhZChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnKTsK
K3ZvaWQgaGV4YWdvbl9ncmVnX3dyaXRlKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBy
ZWcsIHVpbnQzMl90IHZhbCk7CiB2b2lkIGhleGFnb25fY3B1X3NvZnRfcmVzZXQoQ1BVSGV4YWdv
blN0YXRlICplbnYpOwogI2VuZGlmCiAKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2ludGVy
bmFsLmggYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCmluZGV4IDA1ZDExMjk5MTZlLi4zZWQ4
MzkwNGViNyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaW50ZXJuYWwuaAorKysgYi90YXJn
ZXQvaGV4YWdvbi9pbnRlcm5hbC5oCkBAIC0yNCw2ICsyNCwxMCBAQCBpbnQgaGV4YWdvbl9nZGJf
cmVhZF9yZWdpc3RlcihDUFVTdGF0ZSAqY3B1LCBHQnl0ZUFycmF5ICpidWYsIGludCByZWcpOwog
aW50IGhleGFnb25fZ2RiX3dyaXRlX3JlZ2lzdGVyKENQVVN0YXRlICpjcHUsIHVpbnQ4X3QgKmJ1
ZiwgaW50IHJlZyk7CiBpbnQgaGV4YWdvbl9odnhfZ2RiX3JlYWRfcmVnaXN0ZXIoQ1BVU3RhdGUg
KmVudiwgR0J5dGVBcnJheSAqbWVtX2J1ZiwgaW50IG4pOwogaW50IGhleGFnb25faHZ4X2dkYl93
cml0ZV9yZWdpc3RlcihDUFVTdGF0ZSAqZW52LCB1aW50OF90ICptZW1fYnVmLCBpbnQgbik7Cisj
aWZuZGVmIENPTkZJR19VU0VSX09OTFkKK2ludCBoZXhhZ29uX3N5c19nZGJfcmVhZF9yZWdpc3Rl
cihDUFVTdGF0ZSAqY3MsIEdCeXRlQXJyYXkgKm1lbV9idWYsIGludCBuKTsKK2ludCBoZXhhZ29u
X3N5c19nZGJfd3JpdGVfcmVnaXN0ZXIoQ1BVU3RhdGUgKmNzLCB1aW50OF90ICptZW1fYnVmLCBp
bnQgbik7CisjZW5kaWYKIAogdm9pZCBoZXhhZ29uX2RlYnVnX3ZyZWcoQ1BVSGV4YWdvblN0YXRl
ICplbnYsIGludCByZWdudW0pOwogdm9pZCBoZXhhZ29uX2RlYnVnX3FyZWcoQ1BVSGV4YWdvblN0
YXRlICplbnYsIGludCByZWdudW0pOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCAxZjdkOGE4ZGY3MC4uZWM0Y2VkN2UzYzMgMTAw
NjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5j
CkBAIC00OTQsNiArNDk0LDEwIEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X3JlYWxpemUoRGV2
aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBnZGJfZmluZF9zdGF0aWNfZmVhdHVyZSgiaGV4YWdvbi1odngueG1sIikpOwogCiAjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkKKyAgICBnZGJfcmVnaXN0ZXJfY29wcm9jZXNzb3IoY3MsIGhleGFn
b25fc3lzX2dkYl9yZWFkX3JlZ2lzdGVyLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBo
ZXhhZ29uX3N5c19nZGJfd3JpdGVfcmVnaXN0ZXIsCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGdkYl9maW5kX3N0YXRpY19mZWF0dXJlKCJoZXhhZ29uLXN5cy54bWwiKSk7CisKICAgICBp
ZiAoIUhFWEFHT05fQ1BVKGRldiktPnRsYikgewogICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJo
ZXhhZ29uIGNwdSByZXF1aXJlcyAndGxiJyBsaW5rIHByb3BlcnR5IHRvIGJlIHNldCIpOwogICAg
ICAgICByZXR1cm47CkBAIC04NTgsMTEgKzg2MiwxNCBAQCB1aW50MzJfdCBoZXhhZ29uX2dyZWdf
cmVhZChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnKQogICAgIGNhc2UgSEVYX0dS
RUdfR1BDWUNMRUhJOgogICAgICAgICByZXR1cm4gc3NyX2NlID8gaGV4YWdvbl9nZXRfc3lzX3Bj
eWNsZV9jb3VudF9oaWdoKGVudikgOiAwOwogICAgIGRlZmF1bHQ6Ci0gICAgICAgIHFlbXVfbG9n
X21hc2soTE9HX1VOSU1QLCAicmVhZGluZyBncmVnICUiIFBSSWQzMgotICAgICAgICAgICAgICAg
ICIgbm90IHlldCBzdXBwb3J0ZWQuXG4iLCByZWcpOwotICAgICAgICByZXR1cm4gMDsKKyAgICAg
ICAgcmV0dXJuIGVudi0+Z3JlZ1tyZWddOwogICAgIH0KIH0KKwordm9pZCBoZXhhZ29uX2dyZWdf
d3JpdGUoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZywgdWludDMyX3QgdmFsKQor
eworICAgIGVudi0+Z3JlZ1tyZWddID0gdmFsOworfQogI2VuZGlmCiAKIHN0YXRpYyB2b2lkIGhl
eGFnb25fY3B1X2NsYXNzX2Jhc2VfaW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAqZGF0
YSkKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dkYnN0dWIuYyBiL3RhcmdldC9oZXhhZ29u
L2dkYnN0dWIuYwppbmRleCA3NmFiNTIzNWY2ZS4uMzBiNGQ3MTBjZGIgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL2dkYnN0dWIuYworKysgYi90YXJnZXQvaGV4YWdvbi9nZGJzdHViLmMKQEAg
LTE2LDkgKzE2LDE0IEBACiAgKi8KIAogI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNpbmNsdWRl
ICJxZW11L21haW4tbG9vcC5oIgogI2luY2x1ZGUgImdkYnN0dWIvaGVscGVycy5oIgogI2luY2x1
ZGUgImNwdS5oIgogI2luY2x1ZGUgImludGVybmFsLmgiCisjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKKyNpbmNsdWRlICJjcHVfaGVscGVyLmgiCisjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29u
X2dsb2JhbHJlZy5oIgorI2VuZGlmCiAKIGludCBoZXhhZ29uX2dkYl9yZWFkX3JlZ2lzdGVyKENQ
VVN0YXRlICpjcywgR0J5dGVBcnJheSAqbWVtX2J1ZiwgaW50IG4pCiB7CkBAIC03Niw2ICs4MSw2
NCBAQCBpbnQgaGV4YWdvbl9nZGJfd3JpdGVfcmVnaXN0ZXIoQ1BVU3RhdGUgKmNzLCB1aW50OF90
ICptZW1fYnVmLCBpbnQgbikKICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwogfQogCisjaWZu
ZGVmIENPTkZJR19VU0VSX09OTFkKK2ludCBoZXhhZ29uX3N5c19nZGJfcmVhZF9yZWdpc3RlcihD
UFVTdGF0ZSAqY3MsIEdCeXRlQXJyYXkgKm1lbV9idWYsIGludCBuKQoreworICAgIENQVUhleGFn
b25TdGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gZW52X2Fy
Y2hjcHUoZW52KTsKKyAgICBCUUxfTE9DS19HVUFSRCgpOworCisgICAgaWYgKG4gPCBOVU1fU1JF
R1MpIHsKKyAgICAgICAgdWludDMyX3QgdmFsOworICAgICAgICBpZiAobiA8IEhFWF9TUkVHX0dM
Ql9TVEFSVCkgeworICAgICAgICAgICAgdmFsID0gZW52LT50X3NyZWdbbl07CisgICAgICAgIH0g
ZWxzZSB7CisgICAgICAgICAgICB2YWwgPSBjcHUtPmdsb2JhbHJlZ3MgPworICAgICAgICAgICAg
ICAgIGhleGFnb25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBuLCBlbnYtPnRocmVh
ZElkKSA6IDA7CisgICAgICAgIH0KKyAgICAgICAgcmV0dXJuIGdkYl9nZXRfcmVnbChtZW1fYnVm
LCB2YWwpOworICAgIH0KKyAgICBuIC09IE5VTV9TUkVHUzsKKworICAgIGlmIChuIDwgTlVNX0dS
RUdTKSB7CisgICAgICAgIHJldHVybiBnZGJfZ2V0X3JlZ2wobWVtX2J1ZiwgaGV4YWdvbl9ncmVn
X3JlYWQoZW52LCBuKSk7CisgICAgfQorICAgIG4gLT0gTlVNX0dSRUdTOworCisgICAgZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKTsKK30KKworaW50IGhleGFnb25fc3lzX2dkYl93cml0ZV9yZWdpc3Rl
cihDUFVTdGF0ZSAqY3MsIHVpbnQ4X3QgKm1lbV9idWYsIGludCBuKQoreworICAgIENQVUhleGFn
b25TdGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gZW52X2Fy
Y2hjcHUoZW52KTsKKyAgICBCUUxfTE9DS19HVUFSRCgpOworCisgICAgaWYgKG4gPCBOVU1fU1JF
R1MpIHsKKyAgICAgICAgdWludDMyX3QgdmFsID0gbGRsX2xlX3AobWVtX2J1Zik7CisgICAgICAg
IGlmIChuID09IEhFWF9TUkVHX1NTUikgeworICAgICAgICAgICAgdWludDMyX3Qgb2xkID0gZW52
LT50X3NyZWdbSEVYX1NSRUdfU1NSXTsKKyAgICAgICAgICAgIGVudi0+dF9zcmVnW0hFWF9TUkVH
X1NTUl0gPSB2YWw7CisgICAgICAgICAgICBoZXhhZ29uX21vZGlmeV9zc3IoZW52LCB2YWwsIG9s
ZCk7CisgICAgICAgIH0gZWxzZSBpZiAobiA8IEhFWF9TUkVHX0dMQl9TVEFSVCkgeworICAgICAg
ICAgICAgZW52LT50X3NyZWdbbl0gPSB2YWw7CisgICAgICAgIH0gZWxzZSBpZiAoY3B1LT5nbG9i
YWxyZWdzKSB7CisgICAgICAgICAgICBoZXhhZ29uX2dsb2JhbHJlZ193cml0ZShjcHUtPmdsb2Jh
bHJlZ3MsIG4sIHZhbCwgZW52LT50aHJlYWRJZCk7CisgICAgICAgIH0KKyAgICAgICAgcmV0dXJu
IHNpemVvZih1aW50MzJfdCk7CisgICAgfQorICAgIG4gLT0gTlVNX1NSRUdTOworCisgICAgaWYg
KG4gPCBOVU1fR1JFR1MpIHsKKyAgICAgICAgaGV4YWdvbl9ncmVnX3dyaXRlKGVudiwgbiwgbGRs
X2xlX3AobWVtX2J1ZikpOworICAgICAgICByZXR1cm4gc2l6ZW9mKHVpbnQzMl90KTsKKyAgICB9
CisgICAgbiAtPSBOVU1fR1JFR1M7CisKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQor
I2VuZGlmCisKIHN0YXRpYyBpbnQgZ2RiX2dldF92cmVnKENQVUhleGFnb25TdGF0ZSAqZW52LCBH
Qnl0ZUFycmF5ICptZW1fYnVmLCBpbnQgbikKIHsKICAgICBpbnQgdG90YWwgPSAwOwotLSAKMi4z
NC4xCgo=

