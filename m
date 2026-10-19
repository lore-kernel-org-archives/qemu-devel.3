Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1196CCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 06:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIgYm-0004el-0k; Mon, 19 Oct 2026 02:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgYi-0004ds-S0
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 02:09:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgYh-0002jn-A2
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 02:09:20 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J4jEoe864802
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 06:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CjDatffSrqT0R/tBzjuHatkIgdBQ0da6kr602wks+nM=; b=j25BL9L86TkT8Nni
 cVlnUpsoUf1YTN92pQ4LeiXDN20PWNe+GIubABGJ3EbzrVQZtg0igJ9FYOblP3+a
 XwSH/qIlo84ZxJbKEW4acIBK7RDaxgFhD/RnbfOYNaPflPQFU5UahsnJMIHUt7zC
 u8+UqeHjHaOIxyf8Byj/W2dmklvaZH73NubqJjaOV1d0978/lcYJsTArGVwV3441
 ydwY/W6Iu9uuPHyqzVbGQXnf9GVepRj2orTunoWy8J8s7i1j31yXGlQFg++7MGAn
 o4oU/oZJiCHQjHdAGYKSOEml4Nty7B/Fy0rlDY2OM9r8T3J1ABHhJPno8S8GVAUP
 9Usqvw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc2a9my1m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 06:09:17 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35fb6be0f9fso4974856eec.0
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 23:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792390157; x=1792994957; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CjDatffSrqT0R/tBzjuHatkIgdBQ0da6kr602wks+nM=;
 b=MyMbR8Nn4CSgIZl9XuuOKtcALe0L3MaEDmKGOaSf7TNnaIy3SX9I1cAFS+uddVRvif
 iKgwuLp1Q66fl9B1ztSui+tlhmPV6pSvBNf99Du5tS2zzBsU9BMrH7dM0nmW/Pf0pzoj
 T125D5LL8JZTozC6+gxyu4eFewmNl2aJu8ci/tmEO/JDGQKRbQTNNIlfq/jRExfb4i3l
 vfMCd7qmJGdhWVEdcQaNFx6dIseuDMuUX8Qd6UIjqXFJ3fmpzQAjmKo92WBx/aycq4TJ
 58Og0lP54AJPE30ruERXSHG/dsLsQmYlAov93KLQJdEaLjHZCan0vayLUYJmSSQgK4ZV
 zwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792390157; x=1792994957;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CjDatffSrqT0R/tBzjuHatkIgdBQ0da6kr602wks+nM=;
 b=pDyqzprZaMAPvC0uxgR922F67L7bPBY+6/oxnvewEa+FWDPn9+I3pLCOLnZ2fEd+1u
 jTNpSGm2z0r4y9P0dUtnsIs6QuFLASUjdA+2YCwDxJ/biNq5bRMAgW7x/7auksMkRGmM
 kajHDnAbsfG0vIOtdrzW5qoMOyl5KiRrc/yLqsTxjLrhe3A55WUhBGWo+L8BmP8eM994
 UuGjRFhU5c7egSmOcmXJmufcJ74BdSCBhQD0b1nZrwLlEtBULjxQn/LxxasVilLAujM8
 Z42HQxXkc8F/hNR4KVEJIBXHik0qsFKtIesovgj4iZmNP58fAknEtwwsAjrSFVC4GbHW
 SrDw==
X-Gm-Message-State: AFq9FYLcgSqfEXUhA0hhczUMKB+QTCXfJ1Fdex84aqCoX5/KsFZEcW+9
 5Zzl4NvhO3OADW745bUUKS/IwRhPyKaPNVUxUExytIBaejDANqXmi60QNSD5dDBRiMt1/+WqAyB
 633COayqUXTochIxvB6vaFLtOPpeZR6n+lHEvYkVcDXQa2lU/JiIA21DxFp223ddLzw==
X-Gm-Gg: AYBFou1gyY1h2Vy7gEhzwX2kfyDaixAuAmMN6YDa3bHTF8n7Rna8O6PG+8fgFufD0OE
 WQUFrxVrwdXEB9xC6qUwM72pkgd0TwAPxLvtTdgXmG7jmqm+JETbxW5pgFBiRl0GcNBtDEARuEg
 1J0BEg2HOkr0DxNc/DEzDWg6U3TKMHjNWPs4fsGUtNtAlNLzQsQuM+3HRZP0c9wib7LvmsFIWgW
 jgJHdY8gSZgc29AqC13Xcky5d7icYLMJmQuYvjI6leWE9IaKauQxRCnpDc/NIyFz9kMra+L00Q1
 fPRABELc6ZLRuV5MlnJEaT4buip2+KWHlFUg6ClCqKzuTekwuDTR4wRUBfMBOqZepwsv0E0f8Cj
 0b/fZsaty/BJuYjvwYenVcqk34EmRAGI8uvfSe1oBELdkW5U=
X-Received: by 2002:a05:693c:638d:10b0:359:8492:20ff with SMTP id
 5a478bee46e88-361a1270c4cmr9238147eec.12.1792390156622; 
 Sun, 18 Oct 2026 23:09:16 -0700 (PDT)
X-Received: by 2002:a05:693c:638d:10b0:359:8492:20ff with SMTP id
 5a478bee46e88-361a1270c4cmr9238056eec.12.1792390154590; 
 Sun, 18 Oct 2026 23:09:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360820a02b8sm31770053eec.17.2026.10.18.23.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 23:09:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 1/5] target/hexagon: acquire BQL before reading interrupt state
Date: Sun, 18 Oct 2026 23:09:07 -0700
Message-Id: <20261019060911.1479329-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019060911.1479329-1-brian.cain@oss.qualcomm.com>
References: <20261019060911.1479329-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfX023vWW1sCVWA
 Vw5PKDxpFhuuGAZwdOKu8MRC5HmwflZ9xhqr7LWdx2lnBfbo35zEBLXR7XPon0Wwbe9DKMAohjy
 UGir4qw1JYpZMUOFIib66Brg3pHuyjA=
X-Proofpoint-GUID: xM1WoiPPJYCjCSvNKIuG36AZQFDiyi4w
X-Proofpoint-ORIG-GUID: xM1WoiPPJYCjCSvNKIuG36AZQFDiyi4w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfX9cTfvwn8EUeh
 qrskWlJMR1rJ2YNQR8XGpRzTW5uSCZA2pE7baOzUcTK5brlnkQIKP0A722wjp1vf1iQcJW7oGZ8
 2NYUsSxVCsaLsY3J7Bc5GJoIAcXGb0n1mpn8EUTpat8GmWMN/ZSM2rEXm+LK8iUowIdrYAQah3Y
 m7aK/3EKOnEjb7cfAID4CtfZgKwPQZrgoj52dK4obE5EIJ+rjwqsn39RTV2WUduOwPpSbEmuO9K
 KeU/9Zd8R+mxK+njVZvCm1cs5R9PkBCb0bZxs2KxbqPGsLIJOpN2DN9URaWN7216Rnz/J/4G2eN
 A815Ty7n6bZdM8Fh0rD+BvCNg4PydF31ZgE2mZcIx7tu9aIrqUFKXswozqJFlb5r9QlqeFMSunC
 0Cp2cTEaTdiXcHt9f4+3Yi4l4Si4JykpxPxzILKLgpzoCYKXAlzCr0el2BZTEUfHYFECIu1vz4L
 D1Kn/QY1IPj83s1H/cw==
X-Authority-Analysis: v=2.4 cv=PMeaavqC c=1 sm=1 tr=0 ts=6ad5b40d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ewxjkIWJOwr-sdKVJGAA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190024
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

TW92ZSBCUUxfTE9DS19HVUFSRCgpIHRvIHRoZSB0b3Agb2YgaGV4X2NoZWNrX2ludGVycnVwdHMu
CgpUaGVyZSB3YXMgYSByYWNlIHdpdGggaGV4X2ludGVycnVwdF91cGRhdGUgb24gb3RoZXIgdkNQ
VSB0aHJlYWRzIHdoZW4KZW5hYmxpbmcgTVRUQ0cuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWlu
IDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaGV4X2lu
dGVycnVwdHMuYyB8IDggKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X2ludGVycnVw
dHMuYyBiL3RhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMKaW5kZXggMDNlMWYyOGRhOWIu
LjM0MDAwN2RkNTQ1IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfaW50ZXJydXB0cy5j
CisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMKQEAgLTM4NiwxNyArMzg2LDE5
IEBAIGJvb2wgaGV4X2NoZWNrX2ludGVycnVwdHMoQ1BVSGV4YWdvblN0YXRlICplbnYpCiB7CiAg
ICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOwogICAgIGJvb2wgaW50X2hhbmRsZWQgPSBm
YWxzZTsKLSAgICBib29sIHNzcl9leCA9IGdldF9zc3JfZXgoZW52KTsKKyAgICBib29sIHNzcl9l
eDsKICAgICBpbnQgbWF4X2ludHMgPSAzMjsKICAgICBib29sIHNjaGVkY2ZnZW47CiAKKyAgICBC
UUxfTE9DS19HVUFSRCgpOworCisgICAgc3NyX2V4ID0gZ2V0X3Nzcl9leChlbnYpOworCiAgICAg
LyogRWFybHkgZXhpdCBpZiBub3RoaW5nIHBlbmRpbmcgKi8KICAgICBpZiAoZ2V0X2lwZW5kKGVu
dikgPT0gMCkgewogICAgICAgICByZXN0b3JlX3N0YXRlKGVudiwgZmFsc2UpOwogICAgICAgICBy
ZXR1cm4gZmFsc2U7CiAgICAgfQotCi0gICAgQlFMX0xPQ0tfR1VBUkQoKTsKICAgICAvKiBPbmx5
IGNoZWNrIHByaW9yaXRpZXMgd2hlbiBzY2hlZGNmZ2VuIGlzIHNldCAqLwogICAgIHNjaGVkY2Zn
ZW4gPSBnZXRfc2NoZWRjZmdlbihlbnYpOwogICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbWF4X2lu
dHM7IGkrKykgewotLSAKMi4zNC4xCgo=

