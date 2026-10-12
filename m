Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E68CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7U6-0001wC-Kp; Mon, 12 Oct 2026 00:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7Tu-0001ul-Cd
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:17:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7Tr-00018t-2u
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:17:46 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lIE8915977
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SW8nhTNJVPbJYwsftXD+NCmIRsW44vNyR0OwIj7NR3U=; b=FQURt3mMllrxtXk5
 zaSuf7jXxAFbO/P7EnTsk9hm+rBIqm5zm0lC1Gl0zLalStgGxtZtCoiU8+W8c/9y
 Uv1q40GCppwVJrGPaW/qfrpTSNW0Pt/WeRLgH05FIUwe7TvTOeeemUiASkiyHwCI
 d0MbLyLzN1rxTchFWbmITSaLOOHSwOWRZq/nTS9LN+id2cdl7u0tP5+Z5B6naPzD
 s/TnCP8bXpFbwSTXL9MO71MiOZ8KA18lTOcwoyjPLBCcS40u2q0g3n89nlRj7eIw
 Oupbd0Kur9mnUsi80cb1s+Wg1OltWY0EBIKt2UTieWJ4BxJpB6oMdC7falBYuXPF
 EGzpfA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7dk24ncc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:17:41 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso2756952eec.0
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791778660; x=1792383460; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SW8nhTNJVPbJYwsftXD+NCmIRsW44vNyR0OwIj7NR3U=;
 b=arhxblq6WQ0CFmKgm9/zxnP3AGyfigAaI3dgvuTysnVcYUTGz2eZEXa7tdQiNsHUXc
 NkIDJEYQEaFcXfwUBxLqyN6V2ibgJewCD0aGIVZNwOLx/3DxRK/z10rsUex/FrGo26W/
 AwY8zVeBZY2b4bF1571T8auWxaUVwtuzd/LzQ50QGxlI06OWEdK60txMe87071aeBOYy
 PWMKTK0XT35N7xTSUTZVvxg3E0MWeuoJn75c+XcKeqGXTpGoTCQRtqmI4TH++QJydVrA
 SHKelHQtgE7hX5TkM+ZgDri2/02odqMHTV0zOkbxMjnbh8y4DIxrtLz8TPtXQjL8tpz4
 BiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791778660; x=1792383460;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SW8nhTNJVPbJYwsftXD+NCmIRsW44vNyR0OwIj7NR3U=;
 b=j7hhtlygqpHrEf67wAnVFJnFOToVeoJAJwQ5VWZfsfWZ0Rxvpr7KVqKgZzqGKblR95
 8fNpm9Jgl0ay1mm2Ic61CHyRwYcRgRN+aEyCNrtR1PQOjzvpDe1SuQtql8LP83a0La3O
 iISFgE4w2rj8taMsqN3Cn7GxHc4jQx+ylsY9JreBGIKTdRoeSD5c7fO7ei6+72Fcdevm
 7NrSD1BRpCPhsg7nlV+l+qwOvZuLVGK881Akq9y6B60Y+uSB/i729X7Ae5WH2mf+WjZZ
 bmJtoitoNky1vf3F2Lr9FL+oAO1Q0kLzw24bu/wFSFKpjV7hfuTSvGzDoU0wImnWSy92
 88/Q==
X-Gm-Message-State: AFq9FYKGWbLBwr/mJEdxBEBBwTcZOKgD3aWVHkakl6VuF6Kq/UnQsCXb
 +Uvm2uzf+aRd6YmWpT+7suzEkD679g73Ray90aEPMuBjD1ap20FEj5r8/dSuvsFNydBTwBUQDD+
 CscUTN042qbce+ZiJCiDRmumz5S6ZrlwhsgsVd0/dVO6AeqPYwfyY3ZYNyXiiPYscjg==
X-Gm-Gg: AYBFou3ikqXQSmAWtAat9gE8FTLyeeZB9zmzqGzKuh6IVVDu+/+XHCIvEVBNsdq+Ug/
 KcOxJPvNxPYuEornXZ3kV7TKZFClKLANLWBZQg9iYSuO13FZn2fIGeuZ/W93ynaCm/eta2PnzwB
 ar4KapEOzW+QfGLrM2UHTpO8nNutvTup6vjeK2wyypzrvOFjVJzyYRLzsbwL3+EHtrUw/Uh69ox
 vTguXC2I9CPVrl9gnaejVxrs7EcvZTLHbjyEYDtAiipFSYlGZNp4bWN27eVg4/9OcRyhhW1bog8
 6T8Pziy1vRqZc23ryjqZzOszMAUTEnw3i20xd/jtEWxQ/fflyU0OU6jSM5Vk4Vr0Yxl5Ve9TNVS
 P0N4PRRGzVX0X1P7S5vz9Pg1XPePz9eW36PTLHxjsM8esvZc=
X-Received: by 2002:a05:7300:6825:b0:353:8103:ecae with SMTP id
 5a478bee46e88-35381040302mr11700884eec.23.1791778660248; 
 Sun, 11 Oct 2026 21:17:40 -0700 (PDT)
X-Received: by 2002:a05:7300:6825:b0:353:8103:ecae with SMTP id
 5a478bee46e88-35381040302mr11700858eec.23.1791778659622; 
 Sun, 11 Oct 2026 21:17:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm32369096eec.3.2026.10.11.21.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 21:17:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 09/25] tests/tcg/hexagon: Cover HVX vector write conflicts
Date: Sun, 11 Oct 2026 21:17:06 -0700
Message-Id: <20261012041722.1159355-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
References: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: PJktB4i5y9CNVtctUCftUd2uyj7F-Mi9
X-Proofpoint-GUID: PJktB4i5y9CNVtctUCftUd2uyj7F-Mi9
X-Authority-Analysis: v=2.4 cv=E6hYNqdl c=1 sm=1 tr=0 ts=6acc5f65 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LU5tE7T4vROUmwdGADEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX5OiBFsZY7kFm
 +i0EO9sSumQNYPlr0SGOJx2GrLUTc/t+EdMzxYwC+2liKFiCg6qXMDfzIu+D4cjV4XHpv1WfdLJ
 CLq0+GRPNlaCwDKPl3UD0OOVGRfzRVG0Fhexq+DNIXgYCGOmNZYIV4xIj9deW7A6tswcGwjLah6
 qV0txpYIN+S4GN+lvCDXB0h5S+6eKkUSTCqSVBBr/ObIuuiTow4PoVDXKPqNZxXSu9GwVFEigWs
 eoD6UM55aCPWQe05zjuyuMLjVUNzmCo/dBwCOd7PYZ5spY+Lhrz5hg4DZWkxhkzW3IWb3Est9c0
 j74rdiM0ArFN4c0Vh3wOlWWjgh7rvo5ZOxzTTlfydvymOtAYqcZ/sM7hEqdeiYL5GBpJS2KAdUo
 E6wG4PMqAW611uu6/ZvQg6n7x5v58ETET+luVeUCUYc+TmZOdHeMFqPIxrLLLVYdf90ia3C5Buy
 M7UgRy2/42iZdFQT3LQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX2xwUY+4CCiiX
 te8VRSDHDxSqnk666jFUkbIjGkGJKUUDyJPirKp9yT2VaU6tMUwWgvqIS8NkZaHc9wu3p2mTM86
 NYKCY81Mf6CdxiB+BuKIhLROvb6xsvA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120016
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

Q2M6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJldmlld2VkLWJ5
OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5
OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMvdGNn
L2hleGFnb24vbXVsdGlwbGUtd3JpdGVzLmMgfCAxMDcgKysrKysrKysrKysrKysrKysrKysrKysr
KysrLQogMSBmaWxlIGNoYW5nZWQsIDEwNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL211bHRpcGxlLXdyaXRlcy5jIGIvdGVzdHMv
dGNnL2hleGFnb24vbXVsdGlwbGUtd3JpdGVzLmMKaW5kZXggYmQyYjEzODRkZDkuLjljYTVhZGY3
NmFkIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9tdWx0aXBsZS13cml0ZXMuYworKysg
Yi90ZXN0cy90Y2cvaGV4YWdvbi9tdWx0aXBsZS13cml0ZXMuYwpAQCAtMTMsNiArMTMsNyBAQAog
CiAjaW5jbHVkZSA8YXNzZXJ0Lmg+CiAjaW5jbHVkZSA8c2lnbmFsLmg+CisjaW5jbHVkZSA8c3Rk
aW50Lmg+CiAjaW5jbHVkZSA8c3RkaW8uaD4KICNpbmNsdWRlIDxzdGRsaWIuaD4KICNpbmNsdWRl
IDxzdHJpbmcuaD4KQEAgLTIyMyw2ICsyMjQsODMgQEAgc3RhdGljIGludCB0ZXN0X3ZyZWdfbGVn
YWxfcHJlZGljYXRlZCh2b2lkKQogICAgIHJldHVybiBzaWc7CiB9CiAKKy8qCisgKiBDb21wbGVt
ZW50YXJ5IHByZWRpY2F0ZWQgd3JpdGVzIHRvIHRoZSBzYW1lIFYtcmVnaXN0ZXIgcGFpciBhcmUg
bGVnYWwuCisgKiB2MTYgYW5kIHYyMiBhcmUgc3BsYXR0ZWQgd2l0aCBkaXN0aW5jdCBwYXR0ZXJu
czsgc2luY2UgcDAgaXMgYWx3YXlzCisgKiB0cnVlLCB2MTQgbXVzdCBlbmQgdXAgaG9sZGluZyB2
MTYncyBwYXR0ZXJuLiAgRXh0cmFjdGluZyBhIHdvcmQgZnJvbQorICogdjE0IGNvbmZpcm1zIHRo
ZSBleGVjdXRlZCBicmFuY2ggYWN0dWFsbHkgcmFuLCByYXRoZXIgdGhhbiBtZXJlbHkgdGhhdAor
ICogbm8gU0lHSUxMIHdhcyByYWlzZWQuCisgKi8KK3N0YXRpYyBpbnQgdGVzdF92cmVnX3BhaXJf
bGVnYWxfcHJlZGljYXRlZCh2b2lkKQoreworICAgIGludCBzaWc7CisgICAgdWludDMyX3QgcmVz
dWx0OworCisgICAgYXNtIHZvbGF0aWxlKAorICAgICAgICAicjAgPSAjMFxuIgorICAgICAgICAi
cjEgPSAjIzFmXG4iCisgICAgICAgICJtZW13KCVbcmVzdW1lX3BjXSkgPSByMVxuIgorICAgICAg
ICAicjQgPSAjMHgxMTExMTExMVxuIgorICAgICAgICAicjUgPSAjMHgyMjIyMjIyMlxuIgorICAg
ICAgICAidjE2ID0gdnNwbGF0KHI0KVxuIgorICAgICAgICAidjIyID0gdnNwbGF0KHI1KVxuIgor
ICAgICAgICAicjQgPSAjMFxuIgorICAgICAgICAicDAgPSBjbXAuZXEocjAsIHIwKVxuIgorICAg
ICAgICAie1xuIgorICAgICAgICAiICAgIGlmIChwMCkgdjE1OjE0ID0gdmNvbWJpbmUodjIyLCB2
MTYpXG4iCisgICAgICAgICIgICAgaWYgKCFwMCkgdjE1OjE0ID0gdmNvbWJpbmUodjE2LCB2MjIp
XG4iCisgICAgICAgICJ9XG4iCisgICAgICAgICIlW3Jlc3VsdF0gPSB2ZXh0cmFjdCh2MTQsIHI0
KVxuIgorICAgICAgICAiMTpcbiIKKyAgICAgICAgIiVbc2lnXSA9IHIwXG4iCisgICAgICAgIDog
W3NpZ10gIj1yIihzaWcpLCBbcmVzdWx0XSAiPXIiKHJlc3VsdCkKKyAgICAgICAgOiBbcmVzdW1l
X3BjXSAiciIoJnJlc3VtZV9wYykKKyAgICAgICAgOiAicjAiLCAicjEiLCAicjQiLCAicjUiLCAi
cDAiLAorICAgICAgICAgICJ2MTQiLCAidjE1IiwgInYxNiIsICJ2MjIiLCAibWVtb3J5Iik7CisK
KyAgICByZXR1cm4gc2lnID09IFNJR0lMTCA/IFNJR0lMTCA6IHJlc3VsdDsKK30KKworLyoKKyAq
IEEgZnV0dXJlIHdyaXRlIG1heSBjb25zdW1lIGEgdGVtcG9yYXJ5IHZhbHVlIGZyb20gdGhlIHNh
bWUgVi1yZWdpc3Rlci4KKyAqIGJ1ZiBpcyB6ZXJvZWQgd2hpbGUgdjAgaXMgaW5pdGlhbGl6ZWQg
bm9uLXplcm8sIHNvIHYwLnRtcCBsb2FkcyBhbGwtemVybworICogYW5kIHYwLncgPSB2YWRkKHYw
LnRtcC53LCAxKSBtdXN0IGVuZCB1cCBhcyAxIGluIGV2ZXJ5IHdvcmQuICBFeHRyYWN0aW5nCisg
KiBhIHdvcmQgZnJvbSB0aGUgcmVzdWx0CisgKiBjb25maXJtcyB0aGUgYWRkIGFjdHVhbGx5IHVz
ZWQgdGhlIGxvYWRlZCAudG1wIHZhbHVlLCByYXRoZXIgdGhhbgorICogbWVyZWx5IHRoYXQgbm8g
U0lHSUxMIHdhcyByYWlzZWQuCisgKi8KK3N0YXRpYyBpbnQgdGVzdF92cmVnX2xlZ2FsX3RtcCh2
b2lkKQoreworICAgIGxvbmcgbG9uZyBidWZbMTZdIF9fYXR0cmlidXRlX18oKGFsaWduZWQoMTI4
KSkpOworICAgIGludCBzaWc7CisgICAgdWludDMyX3QgcmVzdWx0OworCisgICAgbWVtc2V0KGJ1
ZiwgMCwgc2l6ZW9mKGJ1ZikpOworCisgICAgYXNtIHZvbGF0aWxlKAorICAgICAgICAicjAgPSAj
MFxuIgorICAgICAgICAicjEgPSAjIzFmXG4iCisgICAgICAgICJtZW13KCVbcmVzdW1lX3BjXSkg
PSByMVxuIgorICAgICAgICAicjIgPSAlW2J1Zl1cbiIKKyAgICAgICAgInIzID0gIzFcbiIKKyAg
ICAgICAgInI0ID0gIzBcbiIKKyAgICAgICAgInI1ID0gIzJcbiIKKyAgICAgICAgInYwID0gdnNw
bGF0KHI1KVxuIgorICAgICAgICAidjEgPSB2c3BsYXQocjMpXG4iCisgICAgICAgICJ7XG4iCisg
ICAgICAgICIgICAgdjAudG1wID0gdm1lbShyMiArICMwKVxuIgorICAgICAgICAiICAgIHYwLncg
PSB2YWRkKHYwLncsIHYxLncpXG4iCisgICAgICAgICJ9XG4iCisgICAgICAgICIlW3Jlc3VsdF0g
PSB2ZXh0cmFjdCh2MCwgcjQpXG4iCisgICAgICAgICIxOlxuIgorICAgICAgICAiJVtzaWddID0g
cjBcbiIKKyAgICAgICAgOiBbc2lnXSAiPXIiKHNpZyksIFtyZXN1bHRdICI9ciIocmVzdWx0KQor
ICAgICAgICA6IFtyZXN1bWVfcGNdICJyIigmcmVzdW1lX3BjKSwgW2J1Zl0gInIiKGJ1ZikKKyAg
ICAgICAgOiAicjAiLCAicjEiLCAicjIiLCAicjMiLCAicjQiLCAicjUiLCAidjAiLCAidjEiLCAi
bWVtb3J5Iik7CisKKyAgICByZXR1cm4gc2lnID09IFNJR0lMTCA/IFNJR0lMTCA6IHJlc3VsdDsK
K30KKwogc3RhdGljIGludCB0ZXN0X3ZyZWdfaWxsZWdhbF9taXhlZCh2b2lkKQogewogICAgIGlu
dCBzaWc7CkBAIC0yNDIsNiArMzIwLDI2IEBAIHN0YXRpYyBpbnQgdGVzdF92cmVnX2lsbGVnYWxf
bWl4ZWQodm9pZCkKICAgICByZXR1cm4gc2lnOwogfQogCisvKiBBIHBhaXIgd3JpdGUgYW5kIGEg
c2luZ2xlIHdyaXRlIHRvIGVpdGhlciBwYWlyIG1lbWJlciBhcmUgaWxsZWdhbC4gKi8KK3N0YXRp
YyBpbnQgdGVzdF92cmVnX2lsbGVnYWxfcGFpcl9vdmVybGFwKHZvaWQpCit7CisgICAgaW50IHNp
ZzsKKworICAgIGFzbSB2b2xhdGlsZSgKKyAgICAgICAgInIwID0gIzBcbiIKKyAgICAgICAgInIx
ID0gIyMxZlxuIgorICAgICAgICAibWVtdyglW3Jlc3VtZV9wY10pID0gcjFcbiIKKyAgICAgICAg
Ii53b3JkIDB4MWY1MDU1ZWUgICAgLyogeyB2MTU6MTQgPSB2Y29tYmluZSh2MjEsIHYxNikgKi9c
biIKKyAgICAgICAgIi53b3JkIDB4MWUwM2U1ZWUgICAgLyogICB2MTQgPSB2NSB9ICovXG4iCisg
ICAgICAgICIxOlxuIgorICAgICAgICAiJVtzaWddID0gcjBcbiIKKyAgICAgICAgOiBbc2lnXSAi
PXIiKHNpZykKKyAgICAgICAgOiBbcmVzdW1lX3BjXSAiciIoJnJlc3VtZV9wYykKKyAgICAgICAg
OiAicjAiLCAicjEiLCAibWVtb3J5Iik7CisKKyAgICByZXR1cm4gc2lnOworfQorCiBzdGF0aWMg
aW50IHRlc3RfdnJlZ19pbGxlZ2FsX3VuY29uZCh2b2lkKQogewogICAgIGludCBzaWc7CkBAIC0z
MDgsMTAgKzQwNiwxMyBAQCBpbnQgbWFpbigpCiAgICAgYXNzZXJ0KHRlc3RfcG9zdF9pbmNyZW1l
bnQzKCkgPT0gU0lHSUxMKTsKIAogICAgIGFzc2VydCh0ZXN0X3ZyZWdfbGVnYWxfcHJlZGljYXRl
ZCgpID09IDIzKTsKLSAgICBhc3NlcnQodGVzdF92cmVnX2lsbGVnYWxfbWl4ZWQoKSA9PSBTSUdJ
TEwpOwotICAgIGFzc2VydCh0ZXN0X3ZyZWdfaWxsZWdhbF91bmNvbmQoKSA9PSBTSUdJTEwpOwor
ICAgIGFzc2VydCh0ZXN0X3ZyZWdfcGFpcl9sZWdhbF9wcmVkaWNhdGVkKCkgPT0gMHgxMTExMTEx
MSk7CisgICAgYXNzZXJ0KHRlc3RfdnJlZ19sZWdhbF90bXAoKSA9PSAxKTsKKyAgICBhc3NlcnQo
dGVzdF92cmVnX2lsbGVnYWxfbWl4ZWQoKSA9PSAwKTsKKyAgICBhc3NlcnQodGVzdF92cmVnX2ls
bGVnYWxfcGFpcl9vdmVybGFwKCkgPT0gMCk7CisgICAgYXNzZXJ0KHRlc3RfdnJlZ19pbGxlZ2Fs
X3VuY29uZCgpID09IDApOwogCi0gICAgYXNzZXJ0KHRlc3RfcXJlZ19pbGxlZ2FsKCkgPT0gU0lH
SUxMKTsKKyAgICBhc3NlcnQodGVzdF9xcmVnX2lsbGVnYWwoKSA9PSAwKTsKIAogICAgIHB1dHMo
IlBBU1MiKTsKICAgICByZXR1cm4gRVhJVF9TVUNDRVNTOwotLSAKMi4zNC4xCgo=

