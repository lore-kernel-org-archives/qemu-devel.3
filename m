Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBA0606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eTkKVcQG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h6wlGHBJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKoq4-0007dO-35; Sat, 24 Oct 2026 23:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoq1-0007cg-TQ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKopz-0001Ru-9V
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:01 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P16qF93665361
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tLSeGqwEqa8SPtaWdHqwM6yl/1+LAR8zd04FtV9ZoZo=; b=eTkKVcQGruNhblA/
 jdwaZNYZz1Hca9G6jDmZ2hMMfpAu0gi4Ut0l0Oxuc2lJszJ4WGUqTSiXN1tA500P
 g0wx6hmRrjXs6gvIITM7KJ5X4WHF/Ooof/Vos+UceJ+ID5106CeNuR6tbTj5a2FG
 JxT0AUOcTF7v7cXHytzv5qcjuquhgzGDkD3sWHWHnbVyC5bf6xl6v1dYksgj/ANH
 aG/dnYz55Oti5ZSuEnmWeFuN0zgVdxNwAw+iykKryN3wb2B0g8qyrqZaWmemvubE
 W7xHWE2VVAieBLheYPuPn3FI6Gb77HSkZPeJU3xCyRmEfUBsncLTDIdmnDQwwLg1
 BTAhag==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xjctv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:23:58 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-18b5ee75447so8482910c88.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898637; x=1793503437; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tLSeGqwEqa8SPtaWdHqwM6yl/1+LAR8zd04FtV9ZoZo=;
 b=h6wlGHBJio76U9DkP3qWPfMwSPPO2/DS/9FslR3YWgXNLnxduih5GRb0p/EfaOjQzw
 95ICksiZxY5Tbl4+9QSawQUwVIdqaS+ypAMLDL7zbGk0NyVjms3HwnjwecUM6KMcgybv
 LgkQJCmy2hHXOGR0aMi1ja8MmOffJwG7pundxDp4aPCgjQGHqx5YzR/YRTwTI6aIg2KL
 rwPJnjsZirJpjo5qgSXhyJ+rjYPMKKcS7saPD5gj+RBt57rDXXe8OMT8zy97dG4qzQaW
 EZ1BV4+dKmFtSHhetyRKvTFQvoxpCUF4j2KbLs95Zz0+e0apLWnlAdq5rUUG/Rr8HKGY
 0x5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898637; x=1793503437;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tLSeGqwEqa8SPtaWdHqwM6yl/1+LAR8zd04FtV9ZoZo=;
 b=vsXZBa50TmHrhV5HjEE/7+s9HTKg2snqSTDjGHMVQenJELZSlNjIvzuLwoLTM3SS/P
 wq58nPXKO6hOp/y/o4ksm5+zWzGNMnycsCHivSKr/lNJZ4juub2BQXb/ZIUOcJgr39xA
 pHaXNcuBMHPBcAPW8fGohjIdkzvrqUpByg1ASUMo+jBdMmya5q07NnnjKULeUhOTW4xv
 QcmNG5uyEAsCtlD/2SMaFULrZ+qHxjUrGPPJoVi5Dj8r9yhTqrCSMnhJH/8AJT/X3Q+K
 0O5hR/iYfQk+Ms5jGU6wifveDIg7JsKui1YcP8KSx3jl+gqSZAexnvyDVqGZyzRYbrDg
 Z1+Q==
X-Gm-Message-State: AFq9FYL1egeU/QMGjLewK0g2Tie047u33068KicbaCQ5iquxm1F2sAFt
 pNloaqelbK4n+FfiePPZzQ2X3ep5SLXA+BhWFOjugVr2qifXUF0g/nKJtZsmQVFnL9ouCIV1nz8
 Dz2eHq4xlOZk7bxp9Zx7SL4viYIpC+OwF7MZeo7/yEw0qwwGKBr44TIxKBm1Zaql5xw==
X-Gm-Gg: AYBFou3c1q4CYiAzHGQK2TsXt/znLvjTJ92mejQ/J2dI3bhuEfcAPZgMUKmLFUd6fxe
 Bm4wWtWbGgdoyZrGb6VVlnhgSe69tHrvAmNdb+inyiaBontV0eKXaBF2UdTy8d9XFt7XmkRTgZM
 83TwpdtVGugM6TESK84USHE43ROYlDj9vfoRdlR81aJegBrp1fv7+OCcJZjMb9rcbPJ1u1N8QJi
 LjykXlEhZW4QwXf+al1PCr060OpXSIw0Hsvm3LpbDMtyu3fIpY0P+tg1cr/bs9gfWV7Gvzjy4ge
 THaCG3MeLI/kY1mDyhNyNy8jwngzy1GHSUXoXBUeh5kEtH2J3XXBxE87pT71d0OCh1+jfNzgr/9
 bRV6CVjHkf2U4hsRWTEtB/wndV4qFWhzGLJOFJP/TbiEfRu8=
X-Received: by 2002:a05:7022:7f14:b0:144:c112:5f24 with SMTP id
 a92af1059eb24-19936a5e5ccmr5070105c88.25.1792898636925; 
 Sat, 24 Oct 2026 20:23:56 -0700 (PDT)
X-Received: by 2002:a05:7022:7f14:b0:144:c112:5f24 with SMTP id
 a92af1059eb24-19936a5e5ccmr5070086c88.25.1792898636372; 
 Sat, 24 Oct 2026 20:23:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:23:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 02/40] target/hexagon: fix allocframe FRAMEKEY scrambling
Date: Sat, 24 Oct 2026 20:23:08 -0700
Message-Id: <20261025032346.2917451-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: pz9XzQ5XsXp9yr_q_Pz9IZi13HQDTzmS
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6add764e cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=aMyhTJ8ZNNJ-BQydHqwA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfXxl0WHO08kFH8
 2gUWyLPBoRGJp1KzNro/9hd2G0rAXUSVx6YbjsijBtqy4F1PQe/8HchN/gFyH6anuEoD85flFey
 Jhkha56ma+sJGuWdswlxSgLUVLZyCJw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX/7kwXsALnv9Y
 gRM/OqUTZCQ7h9pYzhd5cBB/RUGkOEq0gWly8pkq9K7fY5YD+sTupc+JSZWHmfVyDnqfj4yEpa6
 LzRU5zE+QpqtDgw66Z7fH4dIA5u+D7dlOXf5soTcV+V/EhMN0TtvNjELyKO0HkCFCJkEnXU3nGQ
 ZtMN5Sh19fu6/NA8JONscWSc6bPDODt9mjEbnJuZRuXua5ohGRcX0koXwWH6n+lXV1oFI9XwCvy
 ESjmKLiELp/tP1mQp3aHLC8TupJ7iibgYtpP9fmOiq52M6PMe7s6y8SAijj/60kZOKlXaJyoBqy
 B9F0/EC0oAZz7a9/ohAO1+h3spq8JmEgUWDriVX/PuM2w/JEGlaZb8hn1OC8wBZHLBcvo/aQiLS
 Dp69RhPPVs8dGLYT6ber0LPUgr7fKaVp3eRfE17tZlQjA6NkzMgp6ROJ/0ghow5MoYBdw606Bec
 t0U8iL9ini7qLX3Nj3g==
X-Proofpoint-ORIG-GUID: pz9XzQ5XsXp9yr_q_Pz9IZi13HQDTzmS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610250012
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

VGhlIGFyY2hpdGVjdHVyZSBzY3JhbWJsZXMgb25seSB0aGUgTFIgd29yZCBvZiB0aGUge0ZQLCBM
Un0gZnJhbWUgdGhhdAphbGxvY2ZyYW1lIHN0b3Jlcy4gIFdpdGggdGhlIGlkZWYgcGFyc2VyIGVu
YWJsZWQsIGZGUkFNRV9TQ1JBTUJMRSBidWlsdAp0aGUgWE9SIGtleSB3aXRoIEZSQU1FS0VZIGlu
IGJvdGggaGFsdmVzIG9mIHRoZSA2NC1iaXQgdmFsdWUsIHNvIHRoZQpzdG9yZWQgRlAgd2FzIHNj
cmFtYmxlZCBhcyB3ZWxsLgoKZGVhbGxvY2ZyYW1lIGlzIGFsc28gcGFyc2VyLWdlbmVyYXRlZCBh
bmQgYXBwbGllcyB0aGUgc2FtZSBpbmNvcnJlY3QKdHJhbnNmb3JtIGEgc2Vjb25kIHRpbWUsIHdo
aWNoIG1hc2tzIHRoZSBlcnJvci4gIGRlYWxsb2NfcmV0dXJuIHVzZXMgdGhlCmhhbmQtd3JpdHRl
biBUQ0cgaW1wbGVtZW50YXRpb24gdGhhdCBjb3JyZWN0bHkgZGVzY3JhbWJsZXMgb25seSBMUiwg
c28KaXQgbGVhdmVzIEZQIGNvcnJ1cHQgd2hlbiByZXR1cm5pbmcgZnJvbSBhIGZyYW1lIGFsbG9j
YXRlZCBieSB0aGUgcGFyc2VyLgoKQWRkIGEgcmVncmVzc2lvbiB0ZXN0IHRoYXQgc2V0cyBhIG5v
bnplcm8gRlJBTUVLRVksIGFsbG9jYXRlcyBhIGZyYW1lLAphbmQgcmV0dXJucyB0aHJvdWdoIGRl
YWxsb2NfcmV0dXJuIHRvIHZhbGlkYXRlIHRoZSByZXN0b3JlZCBGUC4KClVuY292ZXJlZCBieSB0
ZXN0aW5nIHNvbWUgYm9vdCBpbWFnZXMgdXNpbmcgUXVSVC4KClJldmlld2VkLWJ5OiBNYXJjbyBM
aWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
aWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYyB8ICAyICstCiB0ZXN0cy90Y2cvaGV4YWdvbi9m
cmFtZWtleS5jICAgICAgICAgICAgICAgIHwgNTQgKysrKysrKysrKysrKysrKysrKysrCiB0ZXN0
cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgIHwgIDEgKwogMyBmaWxlcyBj
aGFuZ2VkLCA1NiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCiBjcmVhdGUgbW9kZSAxMDA2
NDQgdGVzdHMvdGNnL2hleGFnb24vZnJhbWVrZXkuYwoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmMgYi90YXJnZXQvaGV4YWdvbi9pZGVmLXBh
cnNlci9wYXJzZXItaGVscGVycy5jCmluZGV4IDQ5Y2MxMWZkZGQ4Li4xNDg0MGQ5ODczNyAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYworKysg
Yi90YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jCkBAIC0xOTg5LDcg
KzE5ODksNyBAQCBIZXhWYWx1ZSBnZW5fcnZhbHVlX2ZzY3IoQ29udGV4dCAqYywgWVlMVFlQRSAq
bG9jcCwgSGV4VmFsdWUgKnZhbHVlKQogICAgICp2YWx1ZSA9IGdlbl9ydmFsdWVfZXh0ZW5kKGMs
IGxvY3AsIHZhbHVlKTsKICAgICBPVVQoYywgbG9jcCwgImdlbl9yZWFkX3JlZygiLCAmZnJhbWVf
a2V5LCAiLCBIRVhfUkVHX0ZSQU1FS0VZKTtcbiIpOwogICAgIE9VVChjLCBsb2NwLCAidGNnX2dl
bl9jb25jYXRfaTMyX2k2NCgiLAotICAgICAgICAma2V5LCAiLCAiLCAmZnJhbWVfa2V5LCAiLCAi
LCAmZnJhbWVfa2V5LCAiKTtcbiIpOworICAgICAgICAma2V5LCAiLCB0Y2dfY29uc3RhbnRfdGwo
MCksICIsICZmcmFtZV9rZXksICIpO1xuIik7CiAgICAgT1VUKGMsIGxvY3AsICJ0Y2dfZ2VuX3hv
cl9pNjQoIiwgJnJlcywgIiwgIiwgdmFsdWUsICIsICIsICZrZXksICIpO1xuIik7CiAgICAgcmV0
dXJuIHJlczsKIH0KZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL2ZyYW1la2V5LmMgYi90
ZXN0cy90Y2cvaGV4YWdvbi9mcmFtZWtleS5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAw
MDAwMDAwMDAwLi4xNGM3ZmNiYzY1NAotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL3RjZy9oZXhh
Z29uL2ZyYW1la2V5LmMKQEAgLTAsMCArMSw1NCBAQAorLyoKKyAqICBDb3B5cmlnaHQoYykgUXVh
bGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMgc3Vic2lkaWFyaWVzLgorICoKKyAq
ICBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorICovCisKKyNpbmNs
dWRlIDxzdGRpby5oPgorI2luY2x1ZGUgPHN0ZGludC5oPgorCitpbnQgZXJyOworCisjaW5jbHVk
ZSAiaGV4X3Rlc3QuaCIKKworLyoKKyAqIGFsbG9jZnJhbWUgcHVzaGVzIHtMUiwgRlB9LCBzY3Jh
bWJsaW5nIExSIHdpdGggRlJBTUVLRVkuICBSZXR1cm4gdGhyb3VnaAorICogZGVhbGxvY19yZXR1
cm4gYW5kIHJlcG9ydCB0aGUgRlAgdGhhdCBpdCByZXN0b3Jlcy4KKyAqLworc3RhdGljIGlubGlu
ZSB1aW50MzJfdCBmcmFtZV9yb3VuZHRyaXAodWludDMyX3Qga2V5LCB1aW50MzJfdCBmcCkKK3sK
KyAgICB1aW50MzJfdCBmcF9iYWNrLCBzYXZlZF9mcCwgc2F2ZWRfbHI7CisKKyAgICBhc20gdm9s
YXRpbGUoIiVbc2F2ZWRfZnBdID0gcjMwXG5cdCIKKyAgICAgICAgICAgICAgICAgIiVbc2F2ZWRf
bHJdID0gcjMxXG5cdCIKKyAgICAgICAgICAgICAgICAgImZyYW1la2V5ID0gJVtrZXldXG5cdCIK
KyAgICAgICAgICAgICAgICAgInIzMCA9ICVbZnBdXG5cdCIKKyAgICAgICAgICAgICAgICAgInIz
MSA9ICMjMWZcblx0IgorICAgICAgICAgICAgICAgICAiYWxsb2NmcmFtZSgjMClcblx0IgorICAg
ICAgICAgICAgICAgICAicjMxID0gIzBcblx0IgorICAgICAgICAgICAgICAgICAiZGVhbGxvY19y
ZXR1cm5cblx0IgorICAgICAgICAgICAgICAgICAiMTpcblx0IgorICAgICAgICAgICAgICAgICAi
JVtmcF9iYWNrXSA9IHIzMFxuXHQiCisgICAgICAgICAgICAgICAgICJmcmFtZWtleSA9ICVbemVy
b11cblx0IgorICAgICAgICAgICAgICAgICAicjMwID0gJVtzYXZlZF9mcF1cblx0IgorICAgICAg
ICAgICAgICAgICAicjMxID0gJVtzYXZlZF9scl1cbiIKKyAgICAgICAgICAgICAgICAgOiBbZnBf
YmFja10gIj0mciIoZnBfYmFjayksCisgICAgICAgICAgICAgICAgICAgW3NhdmVkX2ZwXSAiPSZy
IihzYXZlZF9mcCksIFtzYXZlZF9scl0gIj0mciIoc2F2ZWRfbHIpCisgICAgICAgICAgICAgICAg
IDogW2tleV0gInIiKGtleSksIFtmcF0gInIiKGZwKSwgW3plcm9dICJyIigwKQorICAgICAgICAg
ICAgICAgICA6ICJtZW1vcnkiLCAiZnJhbWVrZXkiKTsKKyAgICByZXR1cm4gZnBfYmFjazsKK30K
Kworc3RhdGljIHZvaWQgY2hlY2tfZnJhbWUodWludDMyX3Qga2V5LCB1aW50MzJfdCBmcCkKK3sK
KyAgICBjaGVjazMyKGZyYW1lX3JvdW5kdHJpcChrZXksIGZwKSwgZnApOworfQorCitpbnQgbWFp
bigpCit7CisgICAgY2hlY2tfZnJhbWUoMCwgMHgxMjM0ZmZmMCk7CisgICAgY2hlY2tfZnJhbWUo
MHhmMjFmMjBhMCwgMHgxMjM0ZmZmMCk7CisKKyAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQQVNT
Iik7CisgICAgcmV0dXJuIGVycjsKK30KZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL21l
c29uLmJ1aWxkIGIvdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQKaW5kZXggYTZhY2U0Yzc3
YzIuLjBmZDYyY2U3ZTRjIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWls
ZAorKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtNjgsNiArNjgsNyBAQCB0
ZXN0cyArPSB7CiAgICdvdmVyZmxvdy5jJzogeydjZmxhZ3MnOiBjZmxhZ3MsICdleGVfbmFtZSc6
ICdoZXgtb3ZlcmZsb3cnfSwKICAgJ3ByZWdfYWxpYXMuYyc6IHsnY2ZsYWdzJzogY2ZsYWdzfSwK
ICAgJ2R1YWxfc3RvcmVzLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCisgICdmcmFtZWtleS5jJzog
eydjZmxhZ3MnOiBjZmxhZ3N9LAogICAnbXVsdGlfcmVzdWx0LmMnOiB7J2NmbGFncyc6IGNmbGFn
c30sCiAgICdtZW1fbm9zaHVmLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCiAgICdtZW1fbm9zaHVm
X2V4Y2VwdGlvbi5jJzogeydjZmxhZ3MnOiBjZmxhZ3N9LAotLSAKMi4zNC4xCgo=

