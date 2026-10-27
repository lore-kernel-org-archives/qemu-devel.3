Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA3E606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pMqcdx6t;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PSm65YSD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiIy-0006qm-Cd; Tue, 27 Oct 2026 10:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiIw-0006nJ-7i
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:37:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiIu-0005yp-FV
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:37:33 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoC982358396
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tLSeGqwEqa8SPtaWdHqwM6yl/1+LAR8zd04FtV9ZoZo=; b=pMqcdx6tnuqXzG8C
 VSJkETYcXPpUyJAszjGVmYcvLLxZLSF8pm3SBq5JKv92mqdZjV9gMMFtiPPUrIEv
 14GreuKeq2DEQd2qLr7slQVbc7m3TLUEZfEJ6dlbLAcH3QsyJtz+Y9JIcJCGgLnD
 ub9lkc2cip5k2suamq8sONZCrQP6AOch5vGEtzxOc0ZnaSAakSFhgm9VG7Xydbu5
 eMghghMy/kPAt0CAOMBM2Cvggw1KyWu/UbsSZZu8m6dVeACjYQeJCNcrFXxxSBT2
 H2P/kYGyjYAGr7RKrW7yjhPxSByKFouE0RNmRthtzcQZ2vGiBRDz9avUlMhaDklS
 HYwJKA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjfavucg5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:37:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ad704d4760so3875656a91.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111850; x=1793716650; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tLSeGqwEqa8SPtaWdHqwM6yl/1+LAR8zd04FtV9ZoZo=;
 b=PSm65YSDaTc4GmRzN5OObYEzrbTrwyPoiSfhqBm1ug98dDXT8Lx5Iu035z5F1SgUiG
 LolcRKCn+3UWJGEoqip7NdNTyZJNIylngJign9DGhZHEPxu1iabUn0Kh9vo1URYzKgLq
 YtODzNMDdtCYStlYgT7w6zJHIYB5wnvSKNvVQvG2kSzpxJltdCr22H8aSuJMY43DWH//
 RHz6S3RrtebjDFEJN+V4ZNNvZK3zTCAKbs1P8Tpav4K6avDej5K+d79/KViwLyrFCm9J
 +fVCXNaS8LlypjvttwPN+bQt2vr4aV673XYYBsTWZuXtlPtimIi2nJgEYFx1ux/ppTf5
 Iv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111850; x=1793716650;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tLSeGqwEqa8SPtaWdHqwM6yl/1+LAR8zd04FtV9ZoZo=;
 b=QkK0YvJ2EOqDquEqf23+5xbaFEpKFabwq24NhO+qTLASq8SW0Bp/JpfwrTQVQunn0b
 Qjp/IyAR7isM+dMF2nhVtq7u96wAOOT2B3wt90haYbuQZ/r1NLa7nWxRUKo6fH4hUmqU
 /3WTpy9y5iA4lIqCJqry0zQaJ9Zm7OxndsHDmAocMv9xiV5vO0y3ooCIQ2QrJtHw9Iwe
 aoHdFyMWokukFXDsuyecbwKUI26JeJDbmDSijpuUDJsAjTge53GM7DSwrh3ogoHdiap/
 j9W+Wud+XYidfhhrcO5ee+PybKxB2KUD3jr4ZZpRG81qjfQvpIRplbQ0PhatIppX68Mp
 9CBw==
X-Gm-Message-State: AFq9FYJ0nTsaQlSfH+AV/2bivJLwa2gnE1UVg6JJxCRQrZk8jlWWiuop
 +rKP8j1/Y1ZNOIGNG/IrA4m0VAv9WftjImr9+GrX8z0oVBh6DsLDD1lkL0KaeAOta3vask19anI
 JcOfszIfc1IWfmByuc2DoIIqAya/gvqCP2CRiXgJdNTKmFuUV5UzFkJfdQZleslAK3g==
X-Gm-Gg: AYBFou3xDh5Mo2NBmQt/ZgEXtkaAGm+QqvWKpk7sTdoAB3LwPyt3i3/D9f8JegWFKqK
 v2ou9Jcha/8Xz0Y1yjRcqLfqFE5HTvPFe40AAWwzaBvH0PmD3aB4IW3xWTwU+Cqoo7NOzZ68rcP
 yBoyCF5fx5TmKvR4IzfJoqFgsTgTgEJg7g0dpyWnIGE0SgVuU/88Mk/EEsfRnVLZQT9EIerMFFv
 cos3xNxOdJj+6UQOZUTuoApnFr/QT9MHv8e+twdNxAycdAd7lEL7bwlYKpAQRr1PxeODIaPE5rv
 c7ukfSUcqTSO2jWp6zCraPxP4d9Hk/yzY9uquXxnXYXWPj6uSdtvy12H9UpWHIP1mm5SIVvC0rn
 fLV81jgXi34pj5UM4ndh5XUqaGKa+ROsfNpiQcNEzxiEeSrI=
X-Received: by 2002:a17:90b:4a4f:b0:3a8:13d6:f740 with SMTP id
 98e67ed59e1d1-3adeaae6f7emr8863109a91.22.1793111849983; 
 Tue, 27 Oct 2026 07:37:29 -0700 (PDT)
X-Received: by 2002:a17:90b:4a4f:b0:3a8:13d6:f740 with SMTP id
 98e67ed59e1d1-3adeaae6f7emr8863075a91.22.1793111849363; 
 Tue, 27 Oct 2026 07:37:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404dde70sm4056102a91.1.2026.10.27.07.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:37:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 02/42] target/hexagon: fix allocframe FRAMEKEY scrambling
Date: Tue, 27 Oct 2026 07:36:41 -0700
Message-Id: <20261027143721.4125584-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: T9j7uBxJCtH1KCIr27JsKPX0Gh4oIDd9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfXz5oYicM2Fuz7
 6KpPyEFjQoK0ZoHz8O1oa4VgFG+kfzCasoMKJdvsVV4ZBf2ALFruVbP0FV2PCz4jtxmxbutEfws
 usn1BIq9wRt40fF715jkfNI0j2EnZms=
X-Authority-Analysis: v=2.4 cv=EIeTQFZC c=1 sm=1 tr=0 ts=6ae0b72b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=aMyhTJ8ZNNJ-BQydHqwA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: T9j7uBxJCtH1KCIr27JsKPX0Gh4oIDd9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfXzYYfkiTIUM8K
 IfQou9oH4qbLMJmIIW0vhtZPJHJbzMj00N8aPxvb0VhgTbaMKwsEpncJRLXniZZMbAYKE85tuDw
 7vwzMK7F571Fxp10oLMyuFNVd5TL9yol9oeObMS8tHfBJlo+rvQrCMZSfZo+ZOrhwRAWBcOPAus
 IwFV3LuiQB+7o2jHYYmqpcnRVeh09JKBdTxQlqlvCW0YFokaeo8ZgbyNnKb1xKMvJ70o3QduIDp
 G6tdJ3C1hKJXQQ80259KNSbtmpwxZBqtk2wu2gs2/OWUi5+w0pJfo8KSDoBIKQrjae/4o8/92vS
 1o+mwTCwxeN7z+9Jqhk8n829R9XH2Zk59vyUfJL7A7FV2/35TkVL0pn+vcTc0th2KJkFBY48q5b
 xWexgfW5i0iQ3jI9roAmCBp4m0Obge7oVYXMA0UV7Z5FPqH1hVquKwaaT4FQCfwI8gw6fMhrKGd
 o+2/xr+tC7sVZ+LiVZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

