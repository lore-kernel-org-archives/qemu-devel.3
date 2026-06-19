Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F9ACD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiBg-0001jt-9o; Fri, 19 Jun 2026 18:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBf-0001jk-Gk
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBd-0001Yz-Vf
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLY5gT1336362
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=AWqgRF4Ibw8S5E/4OIgHvd5Hhd9R0yIZ8RFAsz/XZEg=; b=DE
 LAbBcUm+Jf3T4rtslWXArs2YadIUCr8FXRNkx/uscNIPKGsK/wmle0Gu7nyn+ptk
 Arcq225jeVMDC2xzpkIBDlmLIs5DSpccK6PRv+fmjlaPkOA3NtxabjcHsF0wwu4c
 HwJtV0R9f9EBW3HRyepw3WiGvAdRFWZ2/9gdyJP4iLMCpY2gWjGH1kRN+KBD4eYR
 /m0UzsKVDWgB+nBlJtD1kgBHsqa7pTmjC0RxMXeMtSvA3iDckVmRDYDmqBbnlUVi
 AYavLhV5+rL21BaWwhIa0wf1jX8Ac/lmHCtjMw17+pICu1P+gfAVPCeKN42LBk98
 wTuEZbFQYcwg3mEyTb6A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp675557-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:34 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c108c19d4so1091062eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 15:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781909974; x=1782514774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWqgRF4Ibw8S5E/4OIgHvd5Hhd9R0yIZ8RFAsz/XZEg=;
 b=eZ/62IN/gSS4VmhDPuHTeS+cE2dB5KZ9uWox/UklpAANhyrfzz4UrFDIfebId3vKl0
 i7SpED25oA3Y8JDz8tq1Q8xR8MpOQ2JnjtPyC05TlNFDdzshMLf0xDgexSfhkm9wBoNK
 2i438MVZoNJytk6nBFL+gCXPssk5YrmhxIhkSwESZVKfrwLQAny1vHK8Bto3KOTmB86p
 gCFqHQLBCEfACIRpZOEOQJS4ZHsvD2zs740LfayNUSNGNQCyCTzRSYglUIL0vthL39IZ
 fAq8HryO8a2dxN4kfeIyu3QJgSCSyxv+AMuU+JmwLspP1lkxGu1xg3yduhRYu0XzrWNq
 Zd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781909974; x=1782514774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AWqgRF4Ibw8S5E/4OIgHvd5Hhd9R0yIZ8RFAsz/XZEg=;
 b=ADlD2p5f12yYv+KpBz5SWpQ9CHSwfFaQ8BrSdke/5jKxhGs0wX39pieezzT22YnGbq
 phSniC36DwcaIWBS43IVRl1ewf7Ca2GMoIB4OspViceuJX4e8Tqa2gc2GSvrRb/Qcpue
 DKQpzPlnDRwUMoxWUY4a0HvZtnOKq1B7dq26AaaVrFGYkDu/1vZiQdvv2RYIvseHO31r
 3HTB2kStnlT1TOSh4kRE+M/MXwBocmkjPATNnN0oS9n1723EeKldiVs0QhydQPH4c7An
 ZtWb94km9MItLcbBy8pGFrFz7TBub3C89CB4PriENuD66P3iX10mlTbgDrYcEKEJkHbr
 y9Xg==
X-Gm-Message-State: AOJu0YxbgQ/zI95XY16twrf/wLTs24NWlHNNTzobbLlKf+LTT7e5g0An
 pPIJNi7JZD7s2MA4UXaYX7ndOy472Wt9KrL4LTrYCzrXzhgAloaDlqz6x+aHMxxb9kfa7vwINRP
 joXgw6knoaqcupYz+53tejCDJh3tsv85FgUfRkinGG6eCgwd9XPCGTowL8/OREsmTsw==
X-Gm-Gg: AfdE7cmyoS4wHljIRgLERGAve4MfqSYLhdVyNeNjhN2I2l5TGaOLY3bCcqYqWwgUm9O
 npiiQci4qMap5TxTZqql+jxkku1okPGCi9snliyOUL1tb2S78JLswk15oLputmaAqObJf7z9yi9
 Ht/6ZBjZ+B6Zz+dF5BviZ809lk33XWj4SWCkJUZe3ThNq2W2jS+VV8cwa+6v5xlGAdo2/rsdwv8
 bC4ONDFU+5DkY0DdxoSjLZjXilV6PxqZHGoNptKdJAFizn3RNPInzNhvr4ztF104GomOx+JPX1N
 7gjDEcHCR46QoqW0oMF/QswfP4PnOkphEkQkA2tep/68Rj7LQA2ICDWlxETO+X4j4CulEibGm68
 hKv/A3qRlIyc7v0aCJJYTNUC+BUlHsyb1nVjtF0ddmdT3U0M31V7HK1swUbw=
X-Received: by 2002:a05:7300:3c14:b0:304:d75b:f5df with SMTP id
 5a478bee46e88-30c070018bemr3415456eec.19.1781909973961; 
 Fri, 19 Jun 2026 15:59:33 -0700 (PDT)
X-Received: by 2002:a05:7300:3c14:b0:304:d75b:f5df with SMTP id
 5a478bee46e88-30c070018bemr3415449eec.19.1781909973498; 
 Fri, 19 Jun 2026 15:59:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:32 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 12/74] target/hexagon: Add TCG values for sreg, greg
Date: Fri, 19 Jun 2026 15:58:09 -0700
Message-Id: <20260619225911.159473-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 9g78Ib8KgFK7qzunnWdjuvAQrZcOg01m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX1KKF+N6tRfCi
 Zccx50zCxpzBrJXzF1I6uZtI3gxoevm3WynLSAhj1O7LrV9Aw8yxF6SNWzeGXosyBHOjlLEyrtz
 yQb1xkn9PpGOqAvmrsVQeuqj1Uqj6wrUMy/I9Hfx3NGPrAE3QgKj+1KZSwdmKicWBQ045D56LWm
 1xXk7BzP18wr/fiwDXnMS6Mg+czvmMc+dryMucn5/HubyKgZl0ahGVV2I9tIYeqOiqD7fg4FOz9
 D8YXauitY9YO3WobAoIyo0W3hBXUUjgJQyNOJho8Wt0B/DcAeCX4DDYkNr6q4v0dfBzB0mLkyGw
 XwlUxDLYXf8gZQZ5F/E87+ilxXsGEjc8rIWdGXN/13Z29Xq67x+COsqI+2hFsp9g2qtzOz9nmc3
 eJJKZPLnf+tDCQ7kZ9igfaf2L9c2AT6vqkKWSIMWLnnEs+PHMMUqi1bnOoaZ/si0x2aR36HbOAo
 J3iBYP+vlmKofXE3rwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX2qOyiu/ofJ9X
 8/b/sIIq9o2e/PfxNeBmr1IdcV+OsGLo2P84ekDVn/coFoR9jm/f/CpTdn6R7THNS9dBCcIJ/UI
 vvaK/TiPjeY/NhgWEkwdQH3nogBeyOE=
X-Proofpoint-GUID: 9g78Ib8KgFK7qzunnWdjuvAQrZcOg01m
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a35c9d6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=8kp5zrIFwsha1M26KQwA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190221
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgIDUgKysrKysKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgMTYgKysr
KysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuaAppbmRleCBkODBiYzUzMmUyNC4uZDhlZWE1NjE5MWQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC0y
ODIsNiArMjgyLDExIEBAIGV4dGVybiBUQ0d2X2k2NCBoZXhfbGxzY192YWxfaTY0OwogZXh0ZXJu
IFRDR3YgaGV4X3ZzdG9yZV9hZGRyW1ZTVE9SRVNfTUFYXTsKIGV4dGVybiBUQ0d2IGhleF92c3Rv
cmVfc2l6ZVtWU1RPUkVTX01BWF07CiBleHRlcm4gVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNU
T1JFU19NQVhdOworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitleHRlcm4gVENHdl9pMzIgaGV4
X2dyZWdbTlVNX0dSRUdTXTsKK2V4dGVybiBUQ0d2X2kzMiBoZXhfdF9zcmVnW05VTV9TUkVHU107
CisjZW5kaWYKKwogCiB2b2lkIGhleF9nZW5fZXhjZXB0aW9uX2VuZF90YihEaXNhc0NvbnRleHQg
KmN0eCwgaW50IGV4Y3ApOwogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUu
YyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGQ2MTY1OGE3OThjLi45Nzg0OWFi
ODYxYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTY2LDYgKzY2LDggQEAgVENHdiBoZXhfdnN0b3JlX3Np
emVbVlNUT1JFU19NQVhdOwogVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNUT1JFU19NQVhdOwog
CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKK1RDR3ZfaTMyIGhleF9ncmVnW05VTV9HUkVHU107
CitUQ0d2X2kzMiBoZXhfdF9zcmVnW05VTV9TUkVHU107CiBUQ0d2X2kzMiBoZXhfY2F1c2VfY29k
ZTsKICNlbmRpZgogCkBAIC0xMDg0LDYgKzEwODYsMjAgQEAgdm9pZCBoZXhhZ29uX3RyYW5zbGF0
ZV9pbml0KHZvaWQpCiAKICAgICBvcGNvZGVfaW5pdCgpOwogCisjaWZuZGVmIENPTkZJR19VU0VS
X09OTFkKKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVNX0dSRUdTOyBpKyspIHsKKyAgICAgICAgICAg
IGhleF9ncmVnW2ldID0gdGNnX2dsb2JhbF9tZW1fbmV3X2kzMih0Y2dfZW52LAorICAgICAgICAg
ICAgICAgIG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgZ3JlZ1tpXSksCisgICAgICAgICAgICAg
ICAgaGV4YWdvbl9ncmVnbmFtZXNbaV0pOworICAgIH0KKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVN
X1NSRUdTOyBpKyspIHsKKyAgICAgICAgaWYgKGkgPCBIRVhfU1JFR19HTEJfU1RBUlQpIHsKKyAg
ICAgICAgICAgIGhleF90X3NyZWdbaV0gPSB0Y2dfZ2xvYmFsX21lbV9uZXdfaTMyKHRjZ19lbnYs
CisgICAgICAgICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB0X3NyZWdbaV0pLAor
ICAgICAgICAgICAgICAgIGhleGFnb25fc3JlZ25hbWVzW2ldKTsKKyAgICAgICAgfQorICAgIH0K
KyNlbmRpZgogICAgIGZvciAoaSA9IDA7IGkgPCBUT1RBTF9QRVJfVEhSRUFEX1JFR1M7IGkrKykg
ewogICAgICAgICBoZXhfZ3ByW2ldID0gdGNnX2dsb2JhbF9tZW1fbmV3KHRjZ19lbnYsCiAgICAg
ICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGdwcltpXSksCi0tIAoyLjM0LjEKCg==

