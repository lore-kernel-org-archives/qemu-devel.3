Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56162C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3vzE-0004cl-UU; Tue, 08 Sep 2026 09:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3vzA-0004WH-GJ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:35:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3vyo-0006Ca-JC
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:35:40 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688CkkAh2343365
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 13:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=yIiGJORAbJsfb1RzRB3FA+
 pa0VagKqtsKXzqmza2O6w=; b=FTaFzRGTBKsqEbKsbKMf/VKLzDtOG1zsAE3csq
 jawTOSV1bDA2MlUgl1AHyqkTAdxd6uLYeizwl5bbbl9sGDSXI3untQjAHZu+WuN2
 HMtOW4ROV6As4TktMlwsYOfakWLy8onqlUrtgVprAKT+wCyJK464zz9b90DraoAs
 +IHEWUHqbN+mlvZemIdOXHrTrs2g0s3nyARagKkH++DT887kyfYtaVkJms2DZApl
 q2yrIYncW9tq5rZ/WxL4mnTqepCjUIW+XknR46AXdIBPqbKemPNqcvv1T69YtkAX
 /r2FbB1ygJKp6koyG1qtl94OxJstgbNnbvHZwYCbT0QgRy4g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjatjj7u0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 13:35:15 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbedbd182f5so3716098a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 06:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788874514; x=1789479314; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yIiGJORAbJsfb1RzRB3FA+pa0VagKqtsKXzqmza2O6w=;
 b=ZZ8DL95fnsXQudBzyIjwqUSeRWN8LdMa6QFDuHs7OXEZEEzl2nCLj52i6jJcLTN+gE
 zK26EygMq0r/NsVcXQ2T1IwrzLt+yp+sAZf0TxCH2uc1U/T9Ult6wX6vljankqil56oO
 nkXO5g3nd1vCCEe3ZGPzhMRMOdd2xxz4IJJrDurGRrx/uNyXEBa1dtTaLq6UPiNwCmiq
 fUGMSAuPk2PBxFkvS7Hov2glPP+9mUn8GLOngOjWmfKe/R0yDoTa/Cl/z9u86757fP2f
 N0RJKJ8d4/MriAkorKSGWubmdAGwXyMcrIvmgdFzRHn453DqJCHBqU7Ty6vvFhT+48Iw
 Pecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788874514; x=1789479314;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yIiGJORAbJsfb1RzRB3FA+pa0VagKqtsKXzqmza2O6w=;
 b=XFKqBW3ZlesiKrlJl9Wfu8u8ewa0eqht7fi53q2mA1IrNhyfJOdMJm7vIpUZVo9gmJ
 qh/AIDbKenWxXdCoBvSCYOnR44ZJbaDjZDeLvO8eBLLB+IwVawKwgamNmjgRkt+TBv5q
 2MT93nRTs46ptO/QPUmhBZ9U7BfMBf52pNhok39WJ7JbWbVKjAq6cSWvFswSz6UtcAGa
 6PX/8Z1K0D7kwR3ckb5vH6HQvm6lfXoXiuHiaVLXZM+x9e0x+zk8RG79dEcSQ2wqc5th
 VQLqeeP2JWit1kgQnwTxlpl1cfTqpDmjLUjOmQFnFCDfZC78e6mUwTA7MjA6+jD9FK6C
 6GNA==
X-Gm-Message-State: AFuF++n6jiy9s/Ys4/bbjWoloz1o1hpa49xYazMmyGf2tIq0Yzo370w1
 WYcJu77WlJVf0lG7QlWLJqT1efzKjf2sG8/7dj1X11wfCR7s6lN/Wiso9kRaX9ewvx9U7rJA6u3
 WWj23b7ZOvxdnGKW3blfKw2USTUP0y1DhKCq+4QIcabRE9M8FrMCxXz49aVw3FN7Ywg==
X-Gm-Gg: AYBFou1M723sSPOrniqOwbAwOlIvDyanVVY4SYWnqdW8vaIaQf4ypNrD2s7WXk4RyfJ
 Nr8JBJmrjITGFZ+7KxazEIXohQQNJYxEpe+VspminoUq1E+5ip/mREFPXT1n1iBAXU9P6wLUVj1
 My5fnoBWiBNutV4k4ad5wjojOA8w5V+aJyaRjWtZyg4tvJYIzbV0KV/DaVleB4Wn3uKrnDYagWJ
 EUTCbuafpir/TzdK3RIYoY1ggI8bd0Pfv1/I267D4za5jqo+Knxx4CKVmCDhZ4n7W/nflbawhbn
 FA7+DUVqRdeAGzkBlncFIheu64SgJLBcNouUvo/UiIsTJA6qKmNfP+UUTa7MtkT/3qM8IEiIoMQ
 hTeuOeyxlw0GXVps1u3HHE5VosETdqMXar+hfagU5lm+fq8jq
X-Received: by 2002:a17:90b:3fd0:b0:36b:de66:92c3 with SMTP id
 98e67ed59e1d1-39b07fed101mr37427223a91.10.1788874514219; 
 Tue, 08 Sep 2026 06:35:14 -0700 (PDT)
X-Received: by 2002:a17:90b:3fd0:b0:36b:de66:92c3 with SMTP id
 98e67ed59e1d1-39b07fed101mr37427175a91.10.1788874513713; 
 Tue, 08 Sep 2026 06:35:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-334fbd5e6f6sm29029079eec.23.2026.09.08.06.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 06:35:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com
Subject: [PATCH 0/5] hexagon: Add scalar v75=>v81 support
Date: Tue,  8 Sep 2026 06:35:06 -0700
Message-Id: <20260908133512.2353957-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE0NSBTYWx0ZWRfXwLq4rw6qDq5f
 zdxs2Bwx19uW+/9TZSSDf5GsQ/jitbJG+DuzC+VHWC5g4NvzF/saCSMSIv+oQyDxylGxGL3Omy9
 PWj/Djguasb0yal2kzQrr+uorlHD9UI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE0NSBTYWx0ZWRfXxImaGTFWcTMR
 uOgw0JmttC81FQ0lHv0H/zCj1GGseN2hSfetJZBmr4dHpptds5mZWM55QwDnrb4z5aErgLKA9mu
 LC0xi9Cf7Xb8+wr5DPK3lNkdsiJf+nFpPg3uda/ncL382gKlc0eTRFgz0bWecTp5snDoCw5SY1J
 6JLA4rZETSF+h7erM8EepxYI2JXeHGp/luQGWR00+0iqcN4KDFC5mXfuCN/RcqgF+TvLloNfG1B
 1CeX87L/jOUemFl0dqJPhY/3momKmTjSe7HdDuN/lym0SKPyjBo+19KCCaGyqACiJM4OLaZWXXS
 If98U/D5cLwk/NHdjONVXieVBz2JRp7V8opqWiJBwRDBrIiZEePwDTYZtAjwoQjIkgPx6ZIX2ZB
 nmwwaUPcUYv947+shtFzXWVas9aTmffCT5XGRuJLa5fwTahX8IRPKPbf17N6JjHZyzxSmG1Ut3K
 vv+jImE+G6yHve41POA==
X-Proofpoint-ORIG-GUID: 2ILQ2QPHtp81imUf1Eb1iZi1jNiYyczf
X-Authority-Analysis: v=2.4 cv=QrduG1yd c=1 sm=1 tr=0 ts=6aa00f13 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=7jW2GvUMdn8X2Kqfr0MA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 2ILQ2QPHtp81imUf1Eb1iZi1jNiYyczf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080145
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

QWRkIHN1cHBvcnQgZm9yIHRoZSBzY2FsYXIgb3Bjb2RlcyBmcm9tIHY3NSB0aHJvdWdoIHY4MSwg
YW5kCnY4MSBtYWNoaW5lcyB0byBnbyBhbG9uZyB3aXRoIHRob3NlLgoKQnJpYW4gQ2FpbiAoNSk6
CiAgdGFyZ2V0L2hleGFnb246IGFkZCB0aGUgdjc1LCB2NzkgYW5kIHY4MSBDUFUgbW9kZWxzCiAg
dGFyZ2V0L2hleGFnb246IGFkZCB0aGUgdjczIEoyX3VucGF1c2Ugc2NhbGFyIGluc3RydWN0aW9u
CiAgdGFyZ2V0L2hleGFnb246IGFkZCB0aGUgdjc5IGluc3RydWN0aW9ucwogIHRhcmdldC9oZXhh
Z29uOiBhZGQgWTJfdGxicHAgYXMgdW5pbXBsZW1lbnRlZAogIGh3L2hleGFnb246IGFkZCB0aGUg
VjgxREdCXzEgYW5kIFY4MVFBXzEgbWFjaGluZXMKCiBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdv
bi5oICAgICAgICAgIHwgIDExICsrCiB0YXJnZXQvaGV4YWdvbi9jcHUtcW9tLmggICAgICAgICAg
ICAgIHwgICA2ICsKIHRhcmdldC9oZXhhZ29uL2NwdS5oICAgICAgICAgICAgICAgICAgfCAgIDIg
Ky0KIHRhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaCAgICAgICAgICAgfCAgIDMgKwogaHcvaGV4
YWdvbi9tYWNoaW5lX2NmZ192ODFkZ2JfMS5oLmluYyB8ICA3MyArKysrKysrKysrKysKIGh3L2hl
eGFnb24vbWFjaGluZV9jZmdfdjgxcWFfMS5oLmluYyAgfCAgNzMgKysrKysrKysrKysrCiB0YXJn
ZXQvaGV4YWdvbi9hdHRyaWJzX2RlZi5oLmluYyAgICAgIHwgICAzICsKIGh3L2hleGFnb24vaGV4
YWdvbl9kc3AuYyAgICAgICAgICAgICAgfCAgNDYgKysrKysrKysKIGxpbnV4LXVzZXIvaGV4YWdv
bi9lbGZsb2FkLmMgICAgICAgICAgfCAgIDYgKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAg
ICAgICAgICAgICB8ICAgMyArCiB0ZXN0cy90Y2cvaGV4YWdvbi9jaGVja19yZXZfZ2F0aW5nLmMg
IHwgIDMyICsrKysrLQogdGVzdHMvdGNnL2hleGFnb24vdjczX3NjYWxhci5jICAgICAgICB8ICAg
NyArKwogdGVzdHMvdGNnL2hleGFnb24vdjc5X3NjYWxhci5jICAgICAgICB8IDE1NyArKysrKysr
KysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vdGFnX3Jldl9pbmZvLmMuaW5jICAg
ICB8ICAzMCArKysrLQogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvZW5jb2RlX3BwLmRlZiB8ICAy
MSArKysrCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9sZHN0LmlkZWYgICAgIHwgIDIxICsrKysK
IHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL3N5c3RlbS5pZGVmICAgfCAgIDcgKysKIHRlc3RzL3Rj
Zy9oZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICAgfCAgIDEgKwogMTggZmlsZXMgY2hhbmdlZCwg
NDk2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcv
aGV4YWdvbi9tYWNoaW5lX2NmZ192ODFkZ2JfMS5oLmluYwogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3
L2hleGFnb24vbWFjaGluZV9jZmdfdjgxcWFfMS5oLmluYwogY3JlYXRlIG1vZGUgMTAwNjQ0IHRl
c3RzL3RjZy9oZXhhZ29uL3Y3OV9zY2FsYXIuYwoKLS0gCjIuMzQuMQoK

