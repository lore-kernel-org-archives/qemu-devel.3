Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B747BCA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 19:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDocp-00024K-Gw; Mon, 05 Oct 2026 15:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDoco-00023p-77
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 15:45:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDocm-0001wF-Oa
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 15:45:25 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HuO782484439
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 19:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=T9/kXDnTdBLE6v2UbNc2b8
 Fu81AxeMsnVKO5fwgRPMA=; b=EBC+vLAA+e9pkB0goajkwoTn86/weNlOmCOrcx
 5lnU/hSLTGyfq8DgyW8GxXpPHJ1HspO1NZN5gI6yvtzJwZ3mQbjkyUKlHxnukOUd
 6peMeT4PRUZwrzA/4JXSnxYgvkmyF/5E9CDfSiOcqhYlUgqcUBACh18Hu7ePBD6+
 ZpcH/c2prIxisNTHyo2jHXFdVNcfV3ziatpdoktrS0wHc5RnDdz0J9S6iNj03ju8
 e1vxsU3iiDBhzxolUy6QVMahlHJRBOi2PNsZ64SPhSTsXfkj8S9rv251inUpApOP
 ZmZOJfZIhxdpFnkwsfgxQrL7AKwiTSCQpGwYgXyFiThbMlOA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr08d2w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 19:45:22 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34bbf2e3c5cso6351466eec.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791229522; x=1791834322; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=T9/kXDnTdBLE6v2UbNc2b8Fu81AxeMsnVKO5fwgRPMA=;
 b=JSi66AMhMw23lU5Z9YeL+Mfxl7dl/RBZQJrZq8Ys6HanVY/eF/+wxz8i+jvaCp/qFF
 wrgaQvEx2jinZnGrIBMRMTboC9Kwio1s7OS6g4DVf1a0Ijm3ESSVbvynJIQWB9BeUpFL
 PMIvGQWH5YMajF2TAunlKDQ+5QbfsbzSgvqGOlN8NHP/HaMzHUxlikl30pv1MKmRexYy
 KIglk9RuHAmppfmU9qoTtH5F664GtIlFrwjDdVo8dFvsdg87JwoBcr7D7P2gC9DgIbqu
 mhNcTcVbc+3+QDQxyPUyxaFqNgnpEPbC+C72HRyFGWWzpg4sENt/LdfkBgUwF+OyCFoz
 +BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791229522; x=1791834322;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T9/kXDnTdBLE6v2UbNc2b8Fu81AxeMsnVKO5fwgRPMA=;
 b=VXizY/kgwBU4/qBXnQgZSvgxbax5cufjFmWE0fJ/0SvewuaJS7X8gYcnZha0XcRITc
 SdpfPyXvzUV/jlI5G3U2pgkcup6xm1G/LCQAwGQACT1twcZcLiOEdPuQh23E+A4RwXtj
 zLWankKIJ/RBfqVGz7L3SdTzeZrCaG9fqKpL9fyraAGgp+CeydIKHC2E2aA9weqiq4T7
 mTRh2R8UW+EFs2/Uf2vDUa0SPN4aN4PcmU2INlAO64Xi4YTObOUubugVlK47nXyh0FZZ
 BEJCNZzSR1fIMmaPMZOBN3uN7O5y+CmlkupEsK1UvRq4U5PKDtScB2fN5uEI2TJwhoVl
 yqeA==
X-Gm-Message-State: AFuF++nzsIP14iXpVIdtL80BXPy8dyL7epxLIDUPE0XnMezVQLQyTCrl
 r5E6KmusQKZDL0QkoqQQ3/t74YkjxxPG+azV4z6Ltv9jIPcyOKQl1qCAeKEkifiG85/JS1aDJG+
 J/06pzP+MiQBQk10PbnzsUsTxtzsQS/iVoN2wmXll87rDrVoa3eoIqydjDc8FgK5QLg==
X-Gm-Gg: AYBFou1L7JDP4lfFKmh7uF945P4bBAsFgiA5CqtV3gbsAKE5NL/a3Ul4EW0/v1SW08N
 4VRBKLcWFWK1zp7lunv96MigpMlOHKHxICDOADEpUnrodVdKLjWGAcwr712pGs0Z05oeE2UYojh
 mFZSIXO1HoAj5g2eSCLtgtJNAwIg2mmnpLFURhobgTjDu2IRtzlmS5mupCgk///1SmCZewpXl3/
 Eq9sAU/8U5zclcBKBD6+31M0kPqWqWTXRGbFmL+a7G0/+y8U3tEobH9Z4xOsUtM3f/CB5Ox7qCN
 ZhwQJNWgxIgBVXhVZ5qDvqUVoAwY5/TTvCiXfmLAdCHTZS6yw/uGNihzH8475EkwkIi247NFGNq
 An3EEXDc2eBf54cCaCdlMHTy/nkkuUzKT7VrbweclkiGGhIU=
X-Received: by 2002:a05:693c:83c3:20b0:33b:f5b7:f494 with SMTP id
 5a478bee46e88-34f1509e567mr16673749eec.13.1791229521725; 
 Mon, 05 Oct 2026 12:45:21 -0700 (PDT)
X-Received: by 2002:a05:693c:83c3:20b0:33b:f5b7:f494 with SMTP id
 5a478bee46e88-34f1509e567mr16673713eec.13.1791229521099; 
 Mon, 05 Oct 2026 12:45:21 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-351468b2920sm541742eec.4.2026.10.05.12.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 12:45:20 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/2] Hexagon: implement nmi, pause
Date: Mon,  5 Oct 2026 12:45:17 -0700
Message-Id: <20261005194519.2945862-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NyBTYWx0ZWRfX7XUYCR1mMhhV
 WF/tm/6Icx6A0JRwu7mWlxkvk3XVdYo5F2MniRAYik9ik02E74csOOauypcPWDjQOFZSzS0scds
 FjvDHBNp2tkU/MpNCNd/PDrh+xcHGcifhp71uHn2opCtw2pxMiKq/16orK3gVzY+SdeEV/8IfIg
 fugQZrjznnsdo15b47pJjzu5onJD+hxWAzpbpY39B6L7bnFH/3V1N0z8Tuj/4+Ue2DO8rvR8Bua
 pecRjQy1XrlZKwYZsROyN0WYpx0NFT8Du9VBXK7hQ54RqEflrKqyp/LfOqCv0dcORCCGI4Z3LEk
 AJ+cL6o9CpofC7QWXDcSrmAD1PfvNjjm5WmQALImkoNH/44iNVquxYryxZOwL6A1Cae789Hwbhb
 zr4usuHYKukcs1Oq/96LyuHkHsUbkzIDmATpNxsnSh1iq4WhUBbcVJHlU+MvAtM8OHYkOOHt0VI
 Gw+R6ev9pB1+6inPGdQ==
X-Proofpoint-GUID: PcQH7oAzKDkqyrW9nrYEluQb2TIabS_F
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NyBTYWx0ZWRfX7BLhBED/tbqd
 +8oju8MPZzmZDpk2rn4wGQ3Ec5Ep4PhPXiAqVGd31zEk+C+Qn+geWUZBLBPGnPSoDMHjS9sFfyb
 Lo92QJg+ciWjFUYWMpQHEsuhTg/unLU=
X-Proofpoint-ORIG-GUID: PcQH7oAzKDkqyrW9nrYEluQb2TIabS_F
X-Authority-Analysis: v=2.4 cv=BrQIUoX5 c=1 sm=1 tr=0 ts=6ac3fe52 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=ZqpG0P31oQEP9_s6UPQA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050077
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

bm1pIGFuZCBwYXVzZSBpbnN0cnVjdGlvbnMgd2VyZSBub3BzLiAgTm93IG5taSByYWlzZXMgaW50
ZXJydXB0cyBvbiBhbGwgb2YKdGhlIGVuYWJsZWQgQ1BVcyBhbmQgcGF1c2UgcmFpc2VzIGFuIEVY
Q1BfWUlFTEQuCgpCcmlhbiBDYWluICgyKToKICB0YXJnZXQvaGV4YWdvbjogeWllbGQgb24gc3lz
dGVtLW1vZGUgcGF1c2UKICB0YXJnZXQvaGV4YWdvbjogaW1wbGVtZW50IG5taQoKIHRhcmdldC9o
ZXhhZ29uL2NwdS5oICAgICAgICB8ICAxICsKIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaCB8
ICAxICsKIHRhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCAgICB8IDEwICsrKysrKysrKysKIHRhcmdl
dC9oZXhhZ29uL3N5c19tYWNyb3MuaCB8ICAzICstLQogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAg
ICAgIHwgMTEgKysrKysrKysrKy0KIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyB8IDE3ICsr
KysrKysrKysrKysrKysrCiA2IGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCgotLSAKMi4zNC4xCgo=

