Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732EA606A33E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pnSVjRfE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JgCFb7Bx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIr8A-0001NF-Fa; Mon, 19 Oct 2026 13:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIr89-0001N3-Bn
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 13:26:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIr87-0000QJ-LM
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 13:26:37 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFP6Sj2091675
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 17:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=; b=pnSVjRfEGNb9S/2x
 pux5Ty0SyTEa9lo21aVeJmID9v96TaFimRRH+QZtM21WKDBnRL/B7KvuOf23D7DS
 qcPQTWO/z2snP7rKYNRkQD97a8S/b6SPhm7l//r9C0bVoLqGhTdJkgQDhfyYWtY4
 k9CBRXhE563Fn5PIHtv2/THEE410FOnYapBqrBxslx44WW+1OIBbfveA1zIF5fG3
 48YeBR0WikVMqkVB+uB9BRmNAp8uslty+aiQBQBsLabd4DuCfKIS6EnFqDRgxEzY
 A5SD6CRujLfSjGSj15pyiIDT+LPVNCAAJzweaZ9YItFfPfID9Eoc4LtR1KE4u9iR
 ByJAqA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf5cadnh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 17:26:33 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35fb6be0f9fso6143042eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 10:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792430793; x=1793035593; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=;
 b=JgCFb7BxcrnhT9eezyaeIFJmv1cfR30HkQ8TVal7P0cNhY/LbhGLi2/9G8cBt4MoGd
 aBQmARZleQKA0Dir26vPsTZJ/AVKfHX54FbK7UQSWOp4R7UjdnMvmch/Wknc8GKUe1QZ
 Dfe2G19eyDDAoITzrK1nq5NmjE27WW366pADsC4yUDRPN0wKBHSKvGhxzgxxunU8sO0a
 cwMTFxHtbhH199+4NKQPoYeb5G32EGN1JLqCG6XeYWmct0fnJikDmBpJ61IdBuZYPUwF
 kc50+Fup96vc1NX7vSzyD7UU+gReF59iLv5RLa3VtE2PBQjkcA8FZmFyCKA2tz2RarPx
 DDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792430793; x=1793035593;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=;
 b=BIfQ8NxUrjFVhYAuMB5x0n3Abffun1Fn0u4AHtAIpF9hjOFM4vo/DVIvUK7cZhYF8B
 CRAtCXl6Fp09rS6hy/zfR6rzmibrGSSDoKkwJVA6xo28J+oRkNM+j3Q0bhTAkstLpFh1
 9O+f19aW52/MmYViEFK8bhlCNYCTqPL/Wa337JrBvQs014E9JsDpecpjE12Jx1Dscvo+
 8I0oaXubcLsMPG/AeNkLyTsa05rr6rTSCKR3qYYSya8mZwO1Zqa/AsaIxcoruJOUXYpY
 Sz9FqPYv3P+wH/NId+5IYN77d/4FBpZ9jFizsLph5Nh+fGfxtK+ZXVAJKBTJqpmn5eAT
 ycRg==
X-Gm-Message-State: AFq9FYJB+yWh2Z5Wyc2ru+9e5E9T9PiF7O9883QJylapkXeFqvlkL6qs
 V1VVKr3c0fJbPHUVBtGXE3ag8SxaZZZSgTRU5Uaaqq29xd5mTVtIkPSpT+EH44qYD+4h34BncS6
 w+p+FDdx98cMlqlO7gqcHyRFfySRFgm75aOhjzGnUc7bnOQbiOGyf7mdBq8KhYzomZA==
X-Gm-Gg: AYBFou1Xal8Ax8o5+ks5RFbinlcXG4/LedXwggrKrYarwuTo0zPTnk2aNT3wotiKx5o
 zt5ADh0pW3Th9vHbsRx4/AupY1TgAPn2c330fUYlr26VjosovwpR7DpjVZqwPuDXo2jZRFjlYRf
 XxIxy3OrMHXlGyTEA816XLxBmpbozBKafXx16kJ6TeFpvPuh8lRep6x+BuinQJZxLMAJrShQYND
 WUeRIHhWV0yRyS8ACvgozHPHPlvNG4Eel/6RUOPU8tBKclBE8DMV7WIorrga6m+I7EmTvEMHhpp
 lPCfDhuqwMjWs1JDpaa5FMxJIFQi/8AoKYMkO8RiV5uXMYYN+aga6uWBCImJlDLSEDPYOB/Kp85
 9g0bWzAH5XFe8kdTGHO64hYp1qAPxOYG0WERltiLYvHy8ves=
X-Received: by 2002:a05:693c:6311:b0:361:308f:55eb with SMTP id
 5a478bee46e88-361a264b569mr11679816eec.30.1792430792813; 
 Mon, 19 Oct 2026 10:26:32 -0700 (PDT)
X-Received: by 2002:a05:693c:6311:b0:361:308f:55eb with SMTP id
 5a478bee46e88-361a264b569mr11679789eec.30.1792430792342; 
 Mon, 19 Oct 2026 10:26:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360813b6791sm38243061eec.6.2026.10.19.10.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 10:26:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 04/11] linux-user/hexagon: report ISA HWCAP through v85
Date: Mon, 19 Oct 2026 10:25:56 -0700
Message-Id: <20261019172603.2625677-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
References: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2OSBTYWx0ZWRfXwu+arHIALevL
 bayd8sBFE11+YdCNDVakfsj+snNVsSoS5hvAFGyW3zRtA+ky5R0eTF1utZCDOZYMoMUyI4Hcynr
 IQy0g6YsHpXpyb8KlRuBwFpo1cMt/Ek=
X-Proofpoint-ORIG-GUID: 6sYAyIdmhDCXkzGEwe5svuxCuQ7LfSGv
X-Proofpoint-GUID: 6sYAyIdmhDCXkzGEwe5svuxCuQ7LfSGv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2OSBTYWx0ZWRfXzpa08S1g4ifn
 rYAz2kQdhLVzc332Ag3Hqu7jIs8szZFbgvdjJVQZzBDK7tLMrvOMprQn6/IAG9ITqgmwM7yGc9u
 A7djYEWLX50c3jO8nzIOd+a810hn7phjveCjliFaMtZQ0atlQiVkPraQauWSUheJVNcZSI+mUTr
 ZGS2jDTB0ZtmT9+KagI5fNGmFpcWCJc1L53f/Rq6AhHWJfys+D8TKRzI7gllVZdIrDhprGCm2FF
 xJESo/SZddhCbOAelQPv08My4OC7oSQGQo3+pcnbTBnfYWhX0Wpxbm8sbBVj0+qgVcBfMVOQXPG
 zJ0l3S7Xi5ZFCJh6+ARefTTKH6OMTX68YqwixSmKTnR14Bos88t3hFAOfgXlqQcZkGCBoixD9cO
 jKwVdZien65G65GJVAZJoAqpKZ1q8O2PaveXnDQtD/q7jg/IPH96uF6z8xCQDAeOlYn8N+39A+3
 cKpH1ZRd4xGWbRp+pcQ==
X-Authority-Analysis: v=2.4 cv=K6O3jCWI c=1 sm=1 tr=0 ts=6ad652ca cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=RcCyqxnK1iORyYYg75cA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190069
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFs
Y29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiBsaW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oIHwgMiArKwogbGlu
dXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyAgICB8IDYgKysrKysrCiAyIGZpbGVzIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvaGV4YWdvbi90YXJnZXRf
ZWxmLmggYi9saW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oCmluZGV4IDkwZTUwMzJkNWFh
Li5iMWViNWVhNTAzNyAxMDA2NDQKLS0tIGEvbGludXgtdXNlci9oZXhhZ29uL3RhcmdldF9lbGYu
aAorKysgYi9saW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oCkBAIC00Myw2ICs0Myw4IEBA
IGVudW0gewogICAgIEhXQ0FQX0hFWEFHT05fSVNBX1Y3NyAgICAgICAgICAgPSAxNiwKICAgICBI
V0NBUF9IRVhBR09OX0lTQV9WNzkgICAgICAgICAgID0gMTcsCiAgICAgSFdDQVBfSEVYQUdPTl9J
U0FfVjgxICAgICAgICAgICA9IDE4LAorICAgIEhXQ0FQX0hFWEFHT05fSVNBX1Y4MyAgICAgICAg
ICAgPSAxOSwKKyAgICBIV0NBUF9IRVhBR09OX0lTQV9WODUgICAgICAgICAgID0gMjAsCiAgICAg
SFdDQVBfSEVYQUdPTl9IVlggICAgICAgICAgICAgICA9IDEgPDwgNywKICAgICBIV0NBUF9IRVhB
R09OX0NBQkFDICAgICAgICAgICAgID0gMSA8PCA4LAogICAgIEhXQ0FQX0hFWEFHT05fSFZYX0xF
TkdUSF8xMjhCICAgPSAxIDw8IDksCmRpZmYgLS1naXQgYS9saW51eC11c2VyL2hleGFnb24vZWxm
bG9hZC5jIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwppbmRleCA5Zjk4YWQ4ZmI4Ni4u
ZGIwYmYyOTljYzAgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMKKysr
IGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpAQCAtNjIsNiArNjIsMTIgQEAgYWJpX3Vs
b25nIGdldF9lbGZfaHdjYXAoQ1BVU3RhdGUgKmNzKQogICAgIGNhc2UgSEVYX1ZFUl9WODE6CiAg
ICAgICAgIGh3Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNBX1Y4MTsKICAgICAgICAgYnJlYWs7Cisg
ICAgY2FzZSBIRVhfVkVSX1Y4MzoKKyAgICAgICAgaHdjYXBzID0gSFdDQVBfSEVYQUdPTl9JU0Ff
VjgzOworICAgICAgICBicmVhazsKKyAgICBjYXNlIEhFWF9WRVJfVjg1OgorICAgICAgICBod2Nh
cHMgPSBIV0NBUF9IRVhBR09OX0lTQV9WODU7CisgICAgICAgIGJyZWFrOwogICAgIGRlZmF1bHQ6
CiAgICAgICAgIHJldHVybiAwOwogICAgIH0KLS0gCjIuMzQuMQoK

