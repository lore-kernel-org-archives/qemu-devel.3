Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB90C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBo8-0005sL-Lj; Mon, 29 Jun 2026 09:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBo7-0005nJ-7D
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBo5-0003HF-Hu
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:50 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATJmC2656106
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RwPVW3CwUQS2/lnObn+K7hYU+7Hhy6ohC8oxC7MFC5M=; b=IIK56j/VSIjv9JhM
 SjW329RVBnsTX8JBQ9g3w4kJG0PNlpjtoA7nHPOzBCfBFojxNI6isf3mmVheAUxt
 C8lcZlF15ER1PTlsaSoCa9T45fpmXI9yJTClySqvsiyW3O5ISmFcFNyV5hoNrRdK
 JA0kIT9y19skUfIuB8GuGp2eUEfWbRso9i1ZA5ngj6wXYF0tqizWJsVjZivSyUyI
 x/hanx/SscaI37WU5aSx276EiGBoG1XjaQhsLoKGGcIfQrdGMo+oqpUm3EIM4v1P
 XiYrfoftB399HqDHUsA76dtHTRo4/6G9sG3Y1pT4pqwTqSnJOkDz5iwH//ok48Uz
 M358jw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3np7gxvc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:38 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139f5f5eae7so7537244c88.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738818; x=1783343618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwPVW3CwUQS2/lnObn+K7hYU+7Hhy6ohC8oxC7MFC5M=;
 b=TCz2XCQ1DnT0tzoxk1BdPHBkcx/hayzur3wUWGZ/IMXgMIXAejOP7c12HHjnxK5lN8
 6wtLRKJnuq2nXpPOwvXz2MwW7ykOrQozLUrwAL9+qNPKvkEOoT2eDLKw32TLi7qXVMpo
 1smi79bBBC9iI/IE22mSzmXhqojhVu1/t7DOk37tgmtgrVLa1szXVqrrqQUlaDeHOT6o
 CxIiKOw6hc5ExJlpT5MEVUa9gFlqBLwhHace70Kwjc13MG8S+oGDQ7faW0I5PPXQIaCJ
 xQTvJv/dfFMqW8aoaKzGMit9VI7jARRKkR3ScdYnKK0tSGgYGaC7MOcLd+e4uxIP96QZ
 V/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738818; x=1783343618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RwPVW3CwUQS2/lnObn+K7hYU+7Hhy6ohC8oxC7MFC5M=;
 b=eIaFQcBQuhJ6kjD2njVZWQ6T1xmIwcwDyaH0Pm8wlwkqKqp1wIn6HBz85f4AzWs48W
 f5+iUDnaps8LYNUaAFATpbyD0smq+LQHM02dxAOKrrujQkh6gG1QQXXiz+3iH7XSDe94
 fJBsKUCz7v2F3Ko3svU2SMeNxdB0Vm4rCCDDaP9eBjrhBgvKY2mi84rd8J2pj0AlpTX9
 +TPA6/rxaQRxiqkjIDup8+g5k/NqHFdVM8e5HFqI+HGL3kpEyBRVNDcpxvweuV9Nfllw
 k5caM6+1O6nzobp3oP/EALgcFRsQlrSSAJHf03yPK/X1t96jbNl7lLXQj8juJPz0gJdu
 g96w==
X-Gm-Message-State: AOJu0Yw0JlQ8rnhhHUoKuKc2GOGeuHw7r08dGTe/V1rtSSa0uIxLisew
 iDPP2XM9FAwH8robrbnnByOL4Vzj/fNZWSHk9qOAhO3h5NUap3IbnFibTmGN8RFroCbHdvb3vA0
 S9p6Q4QwE6c9Dv4K5LvdhW8IatC6IDvA7caIm/oaHE0+OY8Yy0tp2skE4nLfPSdbddQ==
X-Gm-Gg: AfdE7cmKTSodivZQQ3k7IMl6OPZGh1reiTdiKLImuqw9CgxMy2c6W/eWBN/zk4KEaee
 UT+l9NC8O1k6K17Y5CJJ431vQ1JqqwTiPEOEYm9aZca0CcTeVXKgQJ4Z77uKe5epHrMsr0xwBcm
 5IpciIjOy21GX8IIcJ+hhFY7GtTlxxpbMx3bfr+RQgSHc8ONcqksSmHJXvD0uZWx3rstMF8AS5d
 xBlUtdazCcEfjebd/PxG5Vwwf8fXnDC1KVYOvBikN/CFcoSDvzOC/uVIvAfVWU7el8GDnf3fZ7z
 gRvh5x1zkJl57gSwP1csd+R4/AEIaX+bXw+6lj1Hv1hP3PKYVxC8L9PfJYNzXLFw9kjA8sj0q4i
 lvEnrT0rBTMWrZr/b2stdy/g3vZOiMvKENkYsSpbqPZrI6mz243KjgvlPu8c=
X-Received: by 2002:a05:701b:454d:20b0:138:11a:36f with SMTP id
 a92af1059eb24-139eb131b1cmr5674489c88.1.1782738817595; 
 Mon, 29 Jun 2026 06:13:37 -0700 (PDT)
X-Received: by 2002:a05:701b:454d:20b0:138:11a:36f with SMTP id
 a92af1059eb24-139eb131b1cmr5674470c88.1.1782738817076; 
 Mon, 29 Jun 2026 06:13:37 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:13:36 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 36/77] target/hexagon: Add cpu modes, mmu indices,
 next_PC to state
Date: Mon, 29 Jun 2026 06:11:51 -0700
Message-Id: <20260629131232.2487780-37-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX+H2zetliEDmy
 UO3rmQbNKS3pn0vRnrGHsqspRm3Rq3iiLVlqUh/6+epNmVBpWukAL1OUDDJwRipnw0ZQH7Zfo/a
 khmQW3PmemBbeoUDA8kHQJxmHhM6cwjGvGreCEDYDZlMn8U90s9slzDqUq20fmDXK4DeCdUxpbx
 p9mbr9Mf6xugQrg0XDukBuEmGJ8R5nuFEiAQ0qQ9k/hXPKaJgSP4F6luQlTqfV8PlwMD7azfZyv
 Rs0FuvZun7629XQc55mhOrse1RXcNiLVTwYnGRi0r94F03YCgJnQf5lV9/0JBKF2Qi/S33k+25H
 NVPdffZ8vhXijNda3/H4K1XvUk9mJCFQYoFR22AHKqi4lN1eZsZISQ+oF86sr20FoBFPKDPoiLD
 P5z27ojcOMH6e36QLMs3VmJBON0J2o5MTBGdVcKoM3Ty6u8Qd0c3n2dG+U+fhfwfGcE1HqO/Zp7
 Afe39+IvgsbL2umeaBg==
X-Proofpoint-GUID: 5VKS2RR4w6AzWclwBf_KspSWcD6sFope
X-Proofpoint-ORIG-GUID: 5VKS2RR4w6AzWclwBf_KspSWcD6sFope
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX45DV/gnTdwqy
 DBG612on5UflIdJoFxMsrVfGIW0mER6s3CEecCFgCCFzuj4f1UqhBWZZf4Ei7XOmOxRdeVAi3Hs
 la8sZ34gJMo+v11bbMylt/vqiBzfZQY=
X-Authority-Analysis: v=2.4 cv=OcWoyBTY c=1 sm=1 tr=0 ts=6a426f82 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=StfCoqezVcLOyubjZekA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBZGQgY3B1IGV4ZWN1dGlvbiBt
b2RlICh1c2VyL3N1cGVydmlzb3IvZ3Vlc3QpLCBNTVUgaW5kZXgsIGFuZCBuZXh0X1BDCnRvIERp
c2FzQ29udGV4dCBhbmQgdHJhbnNsYXRpb24gc3RhdGUuIERlY2xhcmUgdGhlIE1NVV9JTkRFWCBi
aXQgZmllbGQKaW4gVEJfRkxBR1MgYW5kIHVzZSBpdCB0byBwcm9wYWdhdGUgdGhlIG1tdSBpbmRl
eCBpbnRvIHRyYW5zbGF0aW9ucy4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxv
cnNpbXBzb25AZ21haWwuY29tPgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJp
Y2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1LmggICAg
ICAgfCAyMiArKysrKysrKysrKysrKysrKysrKystCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAg
ICB8ICAxICsKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgIDIgKy0KIDMgZmlsZXMgY2hh
bmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IGRkZjZkYTc4YzE4
Li43YmExZDMwNDdkZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFy
Z2V0L2hleGFnb24vY3B1LmgKQEAgLTQ5LDggKzQ5LDI2IEBACiAjZGVmaW5lIFZTVE9SRVNfTUFY
IDIKIAogI2RlZmluZSBDUFVfUkVTT0xWSU5HX1RZUEUgVFlQRV9IRVhBR09OX0NQVQorI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCisjZGVmaW5lIENQVV9JTlRFUlJVUFRfU1dJICAgICAgQ1BVX0lO
VEVSUlVQVF9UR1RfSU5UXzAKKworI2RlZmluZSBIRVhfQ1BVX01PREVfVVNFUiAgICAxCisjZGVm
aW5lIEhFWF9DUFVfTU9ERV9HVUVTVCAgIDIKKyNkZWZpbmUgSEVYX0NQVV9NT0RFX01PTklUT1Ig
MworCisjZGVmaW5lIEhFWF9FWEVfTU9ERV9PRkYgICAgIDEKKyNkZWZpbmUgSEVYX0VYRV9NT0RF
X1JVTiAgICAgMgorI2RlZmluZSBIRVhfRVhFX01PREVfV0FJVCAgICAzCisjZGVmaW5lIEhFWF9F
WEVfTU9ERV9ERUJVRyAgIDQKKyNlbmRpZgorCisjZGVmaW5lIE1NVV9VU0VSX0lEWCAgICAgICAg
IDAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2RlZmluZSBNTVVfR1VFU1RfSURYICAgICAg
ICAxCisjZGVmaW5lIE1NVV9LRVJORUxfSURYICAgICAgIDIKKworI2VuZGlmCiAKLSNkZWZpbmUg
TU1VX1VTRVJfSURYIDAKIAogI2RlZmluZSBIRVhBR09OX0NQVV9JUlFfMCAwCiAjZGVmaW5lIEhF
WEFHT05fQ1BVX0lSUV8xIDEKQEAgLTExMiw2ICsxMzAsNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVB
cmNoU3RhdGUgewogICAgIHVpbnQzMl90IHRocmVhZElkOwogICAgIHVpbnQ2NF90IHRfY3ljbGVf
Y291bnQ7CiAjZW5kaWYKKyAgICB1aW50MzJfdCBuZXh0X1BDOwogICAgIHRhcmdldF91bG9uZyBu
ZXdfdmFsdWVfdXNyOwogCiAgICAgTWVtTG9nIG1lbV9sb2dfc3RvcmVzW1NUT1JFU19NQVhdOwpA
QCAtMTY0LDYgKzE4Myw3IEBAIHN0cnVjdCBBcmNoQ1BVIHsKICNpbmNsdWRlICJjcHVfYml0cy5o
IgogCiBGSUVMRChUQl9GTEFHUywgSVNfVElHSFRfTE9PUCwgMCwgMSkKK0ZJRUxEKFRCX0ZMQUdT
LCBNTVVfSU5ERVgsIDEsIDMpCiBGSUVMRChUQl9GTEFHUywgUENZQ0xFX0VOQUJMRUQsIDQsIDEp
CiAKIEdfTk9SRVRVUk4gdm9pZCBoZXhhZ29uX3JhaXNlX2V4Y2VwdGlvbl9lcnIoQ1BVSGV4YWdv
blN0YXRlICplbnYsCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCmluZGV4IDA3NzNlZjhmZTc5Li42MjYxMDBkNDNmZCAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTMwNyw2
ICszMDcsNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2Jq
LCBSZXNldFR5cGUgdHlwZSkKICAgICBtZW1zZXQoZW52LT50X3NyZWcsIDAsIHNpemVvZih1aW50
MzJfdCkgKiBOVU1fU1JFR1MpOwogICAgIG1lbXNldChlbnYtPmdyZWcsIDAsIHNpemVvZih1aW50
MzJfdCkgKiBOVU1fR1JFR1MpOwogICAgIGVudi0+d2FpdF9uZXh0X3BjID0gMDsKKyAgICBlbnYt
Pm5leHRfUEMgPSAwOwogI2VuZGlmCiAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVYX0VWRU5UX05P
TkU7CiB9CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGVkOTZkOWE2NmIzLi5jZTViYmU5MmQ1ZCAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJh
bnNsYXRlLmMKQEAgLTk4OCw3ICs5ODgsNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX3RyX2luaXRf
ZGlzYXNfY29udGV4dChEaXNhc0NvbnRleHRCYXNlICpkY2Jhc2UsCiAgICAgSGV4YWdvbkNQVSAq
aGV4X2NwdSA9IGVudl9hcmNoY3B1KGNwdV9lbnYoY3MpKTsKICAgICB1aW50MzJfdCBoZXhfZmxh
Z3MgPSBkY2Jhc2UtPnRiLT5mbGFnczsKIAotICAgIGN0eC0+bWVtX2lkeCA9IE1NVV9VU0VSX0lE
WDsKKyAgICBjdHgtPm1lbV9pZHggPSBGSUVMRF9FWDMyKGhleF9mbGFncywgVEJfRkxBR1MsIE1N
VV9JTkRFWCk7CiAgICAgY3R4LT5udW1fcGFja2V0cyA9IDA7CiAgICAgY3R4LT5udW1faW5zbnMg
PSAwOwogICAgIGN0eC0+bnVtX2h2eF9pbnNucyA9IDA7Ci0tIAoyLjM0LjEKCg==

