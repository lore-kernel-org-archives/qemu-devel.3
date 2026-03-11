Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBE5FD88F5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsM-0000u4-Al; Wed, 11 Mar 2026 00:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arx-0000m7-TW
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arw-0008Tw-A7
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:25 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AInftQ3417140
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=; b=ev28D6UyAHUBixza
 /4PapG/3SITcIRW4gAC1ONFqQTqec10PQJVbjfIZhI8IyXmOOPs5p6snzOaR0Ng2
 arwwz5TmUNiXg0mfvIHOg27GO1zH8Tx1yCdKBH4XMTrWnQ09rn7B/ERvksKMfhpd
 hBXVim2hGSRuga7keo1bhNFWL+ZX7Ke86QpwS71n6BPMDENsK3JVz4S+dp/0CiIt
 jfOtA/KgJ/LAZ9K5d5txZt7rKBqlrWdffiTfanBN4rdnmrDVZHz7W5ztW4eCtdC9
 rCCxZngRwrBuqCWXyVlYOEFIymbjMDi1O3VqyElr4VY868gyUWYrC3n1WSw/reMC
 fULTkw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctja2ba6m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:20 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7d74cd7b1e3so11141742a34.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202100; x=1773806900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=;
 b=MuqTtoa6n8HqTZv2XD0s8uQRSOWRVTqQkshW4rWukV++7YN/DDt1PjrAo1zQNKIWZ3
 u+8yF8vMgv57hB3Jv6U7syjrIP6fdx+C4/af8uJX9f8iJfHUpCcnR3UL/+ykM4uJJRuu
 H3+SSGpIAUw9PdGyIqHxnvOFssGkmRfULpRVtmu4viydEy2XGP9qNeEghG8bodTeCO5L
 YARUWBz8QvWpcKeswAr1mN4s1UWEhwc67OFCGFG+lzoGG1TXCWyWFROjTH62FIp6Y8GF
 x3Du1Mbw/lY/EMSuq0XkxGMwzjh9X5ywrzcI1FKD0pCJQtP+dTfm19JirrzWFW89+sVj
 EUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202100; x=1773806900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=;
 b=Hg5KKh9cq+/DZONGuXJth5WtKiCsWQdSHBau1Xp8nKvv8gxopwZwGSe5IIJL0S/5uJ
 y9o9HrXemPXAHl2Oyg6SHA7mWhZOyrtIQbk8WkQbcm3b4F/PFOPCwCwpZ1K/c9OBm5sl
 7s1E3OOUtGZMywgcIK55jOhJwuhYmZ3D9zp81c0/c2kvZX5aylYtqu9plW3x/aWCAhgn
 Nc355F0HzmNtiRoS7j6Boptv9E0HvuQKc+KAp/pBcLTyI+s9cWx0IEXlTR15/u56XU/s
 QV/rLx1Y1REnPryZjsV62l7IVhR+ucWoEWzDTiee9C3bji2if2htkZbtTrZdLGKBQiua
 2I0g==
X-Gm-Message-State: AOJu0YxNeKLZKie/vuUXUbZtppCNtw38gHny7fYYsm5YxGnJw6KEnL7T
 6+EZePuTSshjIo/YLF2lNaOC6SxV4o0p9HkJqh5xEUsPkchocA8/kSe0mFOK720tFLezEq/BhMz
 zl1B7qKc9UYiR57FwKowFDovdGTaa/rUwbA6PtUXcvL7OLZL75YOZ1nfE8JNlaNgU1w==
X-Gm-Gg: ATEYQzym5QCYReGTSOI2VOv1sNkBJw8XVs53UV8dyT6jFIfCot9A1XjAbJcXOEQen1h
 DKUd0xb7X7j1d4xJP/lGOx72gzSh0APfIXeEluiCDybUreeOxkSEa+vROCbRsJZI/ajWDJukbxX
 qsBMbIDzRaNdRc/e3WYJTcCLzkdd7nAi9gFqBHlBrPFFXNn+xGQw0AUl8QKBGl06+vue9sruV1o
 wmdRoh3mV2sKEI5vujXGIYp9e4KNcC+7DQWQZl3FS+Zzaqx0NbZfD236MI7C41u1fvQruBuIubC
 oYu/o4WCqmKT+GHj064+ckcu9ynZD1LzAET6RZ6BLgVrXhoxSZ5qSd1uNnHPTbTUackdZvpd4a+
 5JAF8pzOEejqfnSjx4FZsE5EcEojHJHSTiTLnfC6rayYmzEcbEv9HlwmOBfpaRhPtk1/8ZQ==
X-Received: by 2002:a05:6830:67fe:b0:7d7:5e62:4f0f with SMTP id
 46e09a7af769-7d76a81749bmr917255a34.34.1773202100361; 
 Tue, 10 Mar 2026 21:08:20 -0700 (PDT)
X-Received: by 2002:a05:6830:67fe:b0:7d7:5e62:4f0f with SMTP id
 46e09a7af769-7d76a81749bmr917234a34.34.1773202100053; 
 Tue, 10 Mar 2026 21:08:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:19 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 10/32] target/hexagon: Implement hex_tlb_entry_get_perm()
Date: Tue, 10 Mar 2026 21:07:36 -0700
Message-Id: <20260311040758.1068731-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=c9WmgB9l c=1 sm=1 tr=0 ts=69b0eab4 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=RKVJoAg1yBLoogzcrgwA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: DTd5JGFZSSHvTCa7q2rOhiIjYluZdhol
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX6VA0KpikpoYu
 A6m/BonVPc2RpGidUcFeWaM3OIV9Ai122ubTIDSwfbBu71fUbM4CWKdGRBNAZGQ/LsWk3A22OPM
 aRSOiMHWBHFSuUuRb4GIo1S/2AfWGq/h5xykpX0XlE+N05BTAQh4HWSRO9G2L1wNK/F+Z4D6als
 iwKVato7a/4ug8CMexxjUQst7FtMBVXxYCl9HooyRis1CE6IsdX4Mly5rn34jK8R6T8EpKIkngc
 VyOoJ1IanuXRVsN6Lrx1y/PNTtGASDng3xiq4z8snflCB+4/a5P1kJBk4KxA2S34zKdU0Rw4il0
 r70ehuGZKzzn2BhiFuhicvyq6hliMJjKZLDccU2dx5k2XEJxaNFSf4/8GhZGTLdh8B0npAq/7GS
 tBNUGvWfUAqY0B8hle3rSLVtSjO4Mcj7d5mYmgT7y6CACo125RZDIJmOFKhnEuW8Fha4B3ICjww
 oTDsG5BVSQAybEcKmjQ==
X-Proofpoint-GUID: DTd5JGFZSSHvTCa7q2rOhiIjYluZdhol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=no autolearn_force=no
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGxpbnV4LXVzZXIvaGV4YWdv
bi9jcHVfbG9vcC5jIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMgYi9saW51eC11c2Vy
L2hleGFnb24vY3B1X2xvb3AuYwppbmRleCA5ZjU0YzdiM2Y5Ni4uMDk1OGM1MWZiYjMgMTAwNjQ0
Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5jCisrKyBiL2xpbnV4LXVzZXIvaGV4
YWdvbi9jcHVfbG9vcC5jCkBAIC02Myw2ICs2MywxMyBAQCB2b2lkIGNwdV9sb29wKENQVUhleGFn
b25TdGF0ZSAqZW52KQogICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgIGNhc2UgSEVYX0VWRU5U
X1BSRUNJU0U6CiAgICAgICAgICAgICBzd2l0Y2ggKGVudi0+Y2F1c2VfY29kZSkgeworICAgICAg
ICAgICAgY2FzZSBIRVhfQ0FVU0VfRkVUQ0hfTk9fVVBBR0U6CisgICAgICAgICAgICBjYXNlIEhF
WF9DQVVTRV9QUklWX05PX1VSRUFEOgorICAgICAgICAgICAgY2FzZSBIRVhfQ0FVU0VfUFJJVl9O
T19VV1JJVEU6CisgICAgICAgICAgICBmb3JjZV9zaWdfZmF1bHQoVEFSR0VUX1NJR1NFR1YsIFRB
UkdFVF9TRUdWX01BUEVSUiwKKyAgICAgICAgICAgICAgICAgICAgZW52LT5ncHJbSEVYX1JFR19Q
Q10pOworCisgICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX1BS
SVZfVVNFUl9OT19HSU5TTjoKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX1BSSVZfVVNFUl9O
T19TSU5TTjoKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX0lOVkFMSURfUEFDS0VUOgotLSAK
Mi4zNC4xCgo=

