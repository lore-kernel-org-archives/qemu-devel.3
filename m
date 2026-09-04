Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B249AC624D4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 01:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Idf-00078p-Q4; Thu, 03 Sep 2026 21:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Ide-00078T-Dy
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 21:22:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Idc-0005Iy-IH
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 21:22:42 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683NbXYT1948198
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 01:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=0T5kALNIKTo
 KxxVo8gurLq0bStyWlyXOqHMw7h1UfqU=; b=Td/zN20uF51Tlcxs15GeyCHqi4t
 /WSfmW0pU4W/XdHatGTdLD8Tx6uLBMjWQ+DpINvBFEj1BwMT3JerzR16eJbmMWO1
 uWS+So2e3w6PBJZDXpkst0CfkQiIl3hwvfzn97dE0bOxT0braL9wts7OCb9ERvcx
 SRsXTj7cxwKFoDaBgrPDLLlG9v1Ai7WWydzfv2Q9OO5nNE3ekpWaBsUZ0xrxOPb6
 aFHzcPuGwAGwMA+0Pc00pIEVj4Joj1SJt+UlIf4/RhaC4kTiF/U33USnbOgGfQyf
 OsefYj53kpjb0imPkorr2NQofYWhi8VAyRd2v52dbedWXsQ59EMsUSZ02yw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfdyxhfvs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 01:22:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so816162a91.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788484956; x=1789089756; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0T5kALNIKToKxxVo8gurLq0bStyWlyXOqHMw7h1UfqU=;
 b=QDLPcC1wa8kxO5QXLuijZlF3R2XXgZB95dnA5PZb7NTydaoyaYrXAM0BokSVMox6ml
 69HeBHUS/ShuDwhi5rZUr1XzAtZ5STw1nCesLgJNsQsKRXtR/SZCr2oco1s9kumgOu5t
 cgP6AFvPTftWy2NhjaePJVVom/FZAS6BR24MS0T29ib6fkcPf0p6e+SDPCJWqJXvTszy
 /ip56XbLywjWxWTswN1FiWOqnq+Gm3hT39AvOeqVtcy27EkSBmEUxvW3hNo7PRW5LY7y
 Nj9Ocq9fUHGA7q7HqP8n2fB/QA1yX+otItZsJW6QRDsXaGhKUNphiqxQpm5Npe1fzvvx
 Bdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788484956; x=1789089756;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0T5kALNIKToKxxVo8gurLq0bStyWlyXOqHMw7h1UfqU=;
 b=luHhK7+W9Y59zPj0W9BR4xWLmp/XcsmDdQkfjM9WxUGY/C+Vi9X8nVJVUr26PbfcJx
 jNKLhUBzXSBF6iM8N6J8UyNLBkk2Sv3js0j9I1/e8nohKI4V0ClOYjRHsKX5hlDUTtdw
 lMWtNEyesuoPeQ3wnWeSWPDgSHjbbsPv6A0YBhoNPmMDW6Jq0IdUPEJ2p0ZX1LNcBUwR
 ZHRfXA06vwb/sb1akzhS9unZBFxVdKqqIw/LKEGVrajmHnLHg1Z9A4PN/iCOIz8QRSQD
 Q3ElWQ0kWaLhi2MVQ8m+m7KvNMlqp9HWI0yB12+Q4dkJbmoBZCNSngCCjBBN/l8UxWCM
 EdBA==
X-Gm-Message-State: AFuF++kYiawga50CfMe/LBB2WPEmNBLqmd8O/RcVcIfe6+YTBr0loPVA
 U73YPvXGzxaar4qEWRQGC8yRiPKlJV/804F3YWts5+VxOIExBDhxY9mN7njyyqsNfyhRP8bPc8u
 fY4Vda+P6QTZXXSRgnw3D/Bm5bBkDktRP0htFCUAMDX6ibP6/BFUaFuqtiwqhTWEKDQ==
X-Gm-Gg: AYBFou3DhWvlmfCuLwULryuiDX+2FAq97djc2n+YI2AE6IwZ4Qlmy4fRSsmKSiInGvg
 Gf2Kst7n1nWNcIx71TmrnPSDtcoUWuHp2zPQB9tQEzxz91vVptuVOvPBm6Tv3ciN2Afd64y4Ju4
 EmSInOFhclD14DkA/yWdgWirv1hX4tQ98fPAE74J//JJGI7Qo1AcflJgF27T1cRvz0O8W6SXWmO
 ONE/k3aWPpb9/lqqn/Url4D5PzeZWBqSQpTc32PQQ84GgKYCVvkdc9tKcH0jhT69Lpnzt+Ee1lG
 LxcVZcLgYStR3ZMk8sy5qXYQ6/24pC49rYsrKteUUKCceVY10oIVFlbzcdRGjnfT2WfERo1qM6U
 L5Nfcr+OKzLnuGYNS8QYgFH0NnBHqdxYrAz5pv0Otm5VPOL12
X-Received: by 2002:a17:90b:3b46:b0:398:dcfe:967a with SMTP id
 98e67ed59e1d1-39b2620a2ecmr3563780a91.17.1788484955959; 
 Thu, 03 Sep 2026 18:22:35 -0700 (PDT)
X-Received: by 2002:a17:90b:3b46:b0:398:dcfe:967a with SMTP id
 98e67ed59e1d1-39b2620a2ecmr3563723a91.17.1788484955464; 
 Thu, 03 Sep 2026 18:22:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339885ca07sm2573234eec.1.2026.09.03.18.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 18:22:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 0/5] hexagon: fix HVX scatter gather, BE host
Date: Thu,  3 Sep 2026 18:22:28 -0700
Message-Id: <20260904012233.3607547-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: ZA0Wi9_RxESLSb5t5MRs2mOZsyY9oNiR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDAxMCBTYWx0ZWRfX6k/WSswQhhjL
 A8uNJbTPwLqu3UE2yDwAI3TNTgRe70oeEbzimKYhKS+RaHJtE7YskLw/yqUs0mlpuE2r6+3qiAY
 QGd4oVQ6Eq9d9YiIp9y5dWR77slwS20=
X-Proofpoint-GUID: ZA0Wi9_RxESLSb5t5MRs2mOZsyY9oNiR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDAxMCBTYWx0ZWRfX/36zOLs2XmQh
 9seFlJuqWc5A3GdYJk9DIDMs3MiwYrw4UAwSSNeqQanYKcTMsHWhKJvhp3u9FFLe23cdWiIWS6U
 3jo3mxNURZA4888KGak7GB6s/2vY00V8XmEaCHhbSWRii7E2wxtukos8UdeL70FQ2O4cF971WJI
 osas1GPhFN5WslLTiK1fIG7+KZF5TfGctTozXwZwvZ6D//bfygZgjVYXYk2YcsO0fWnXtZjWQYx
 D8Tisr5MmmzdCo9t3tpKYWW2Iozkt+boHFHcefKgMcnm0oy5pAfwfYJoiv2zhOHpXLVF44vistI
 GGp1hTo83uLaO0N4jfEkHuBW7WUPcb8ipLOMjXl7WlMHDLp7ZmKfekHRlryA+diqJxqMRgG72Mc
 j8tlxZoAqnlzhl9VO/nOrPQhAo4Qd6actOYJxBINAIW9cM1Mwoglr4HFNcA8slhK5o8h8OU4V3D
 OBRpVYA4LApTqF6tScw==
X-Authority-Analysis: v=2.4 cv=X9Zi7mTe c=1 sm=1 tr=0 ts=6a9a1d5c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=mpKzKNm-yqMzirWl5scA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_07,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040010
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

QW50b24gcG9pbnRlZCBvdXQgdGhpcyBlbmRpYW5uZXNzIGlzc3VlIHdpdGggSFZYLAphbmQgZm91
bmQgdGhpcyByZWdpb24gbGVuZ3RoIGlzc3VlIGFsb25nIHRoZSB3YXkuCgp2MzoKKiBDaGFuZ2Vk
IHRoZSByZWdpb24tbGVuZ3RoIHRlc3QgdG8gYmUgbW9yZSBjb25zaXN0ZW50IGJldHdlZW4gc2Nh
dHRlcgphbmQgZ2F0aGVyIGFuZCBmb2N1c2luZyBvbiBqdXN0IGluc2lkZSwgb3V0c2lkZSwgYmV5
b25kIHRoZSBib3VuZGFyeS4KCkZpeGVkIGluIHYyOgoqIGJ5dGUgYWNjZXNzIGhlbHBlcnMgbm93
IGFsbCB1c2UgaGV4YWdvbl8gcHJlZml4LgoqIFByZWRpY2F0ZSBieXRlcyBhcmUgZXh0cmFjdGVk
IGZyb20gMzItYml0IHdvcmRzIHJhdGhlciB0aGFuIDY0LWJpdCB3b3JkcywKICBtYXRjaGluZyB0
aGUgaG9zdC1uYXRpdmUgcHJlZGljYXRlIGxheW91dC4KKiBHYXRoZXIgb25seSByZWFkcyBtZW1v
cnkgZm9yIGxhbmVzIHRoYXQgYXJlIGJvdGggaW4gcmFuZ2UgYW5kIHByZWRpY2F0ZQogIGVuYWJs
ZWQuICBTbyBkcm9wcGVkIGxhbmVzIGNhbm5vdCBmYXVsdCBvciBvdGhlcndpc2UgYWNjZXNzIG1l
bW9yeS4KKiBUaGUgZ2F0aGVyIHJlZ2lvbi1sZW5ndGggdGVzdCBub3cgcGxhY2VzIGFuIG91dC1v
Zi1yYW5nZSBvZmZzZXQgb24gYW4KICBpbmFjY2Vzc2libGUgcGFnZSwgdmVyaWZ5aW5nIHRoYXQg
YSBkcm9wcGVkIGxhbmUgcGVyZm9ybXMgbm8gcmVhZC4KCkFkZGVkIHYyIGNvbW1pdHM6CiogZml4
IGZvciBoaXN0b2dyYW0gcHJlZGljYXRlcyAtIHdlcmUgdXNpbmcgdGhlIHdyb25nIHNpemUKKiB0
ZXN0IHRvIGNvdmVyIHByZWRpY2F0ZSBieXRlIHBlcm11dGF0aW9uCgpCcmlhbiBDYWluICg1KToK
ICB0YXJnZXQvaGV4YWdvbjogZml4IEhWWCBiaWctZW5kaWFuIGJ5dGUgYWNjZXNzCiAgdGFyZ2V0
L2hleGFnb246IGZpeCBIVlggc2NhdHRlci9nYXRoZXIgcmVnaW9uLWxlbmd0aCBjaGVjawogIHRl
c3RzL3RjZy9oZXhhZ29uOiBhZGQgdmdhdGhlci92c2NhdHRlciByZWdpb24tbGVuZ3RoIHRlc3Rz
CiAgdGFyZ2V0L2hleGFnb246IGZpeCBIVlggcHJlZGljYXRlIHNhdmUgc2l6ZSBmb3IgaGlzdG9n
cmFtIG9wcwogIHRlc3RzL3RjZy9oZXhhZ29uOiBjaGVjayB0aGUgdHdvIEhWWCBwcmVkaWNhdGUg
YnVpbGQgcGF0aHMgYWdyZWUKCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oICAgICAgICAg
ICAgfCAgMTAgKy0KIHRhcmdldC9oZXhhZ29uL21tdmVjL21hY3Jvcy5oICAgICAgICAgICB8ICA1
MCArKysrKy0tLS0KIHRhcmdldC9oZXhhZ29uL21tdmVjL21tdmVjLmggICAgICAgICAgICB8ICAx
OCArKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgICAgICAgICAgICAgfCAgMTcgKy0t
CiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgICAgICAgICAgICAgfCAgIDMgKy0KIHRhcmdl
dC9oZXhhZ29uL21tdmVjL3N5c3RlbV9leHRfbW12ZWMuYyB8ICAgMiArLQogdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMgICAgICAgICAgICAgIHwgIDE3ICsrLQogdGVzdHMvdGNnL2hleGFnb24v
aHZ4X21pc2MuYyAgICAgICAgICAgIHwgIDQ1ICsrKysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9z
Y2F0dGVyX2dhdGhlci5jICAgICAgfCAxMzcgKysrKysrKysrKysrKysrKysrKysrKystCiA5IGZp
bGVzIGNoYW5nZWQsIDI2MCBpbnNlcnRpb25zKCspLCAzOSBkZWxldGlvbnMoLSkKCi0tIAoyLjM0
LjEKCg==

