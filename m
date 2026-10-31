Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB872606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LdRPzoR9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZBleEYBb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMxvq-0004j8-2B; Fri, 30 Oct 2026 21:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxv2-0004UD-PZ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxv1-0002rG-37
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:04 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69V1C3Ot748615
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yLmuUlEcL3prJbZs+XFuxuv7jTVBZioIhma4GM+1auQ=; b=LdRPzoR9n+OSBIXO
 cy5g2vo/BvdQdWxCMGgjllsOMRbfh0Wld6OzVpmzEuvzptUZnPX3ULnFqR5t0ITd
 N4eRrPF8rWqHXYfOgigMNNz3huG43kSodBWaL7Dv0ywyGnVJ7QZFfBk0VrUuirXx
 rBmqTfhMsTEixgKv4+5w0bIdp5GD0BLZFNYjVSpz8aWokkNQBT4QIMtXyzi7C70D
 O+pfM07UT7n9CjPaw5mEKUJVh2nbZuvLieFKVcFDJNdGtAh1V26plQly48RsOHhs
 AqqN79VTNZInZLKkI9h9qc5FPQzmdYVoTkXNqByHU461jmxYWY30Z8GrQMX8cBG1
 4J3CTw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x00mrq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36a3451ea93so2050476eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793410201; x=1794015001; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yLmuUlEcL3prJbZs+XFuxuv7jTVBZioIhma4GM+1auQ=;
 b=ZBleEYBbT3QDJ2TG4K1m1NZZ9T9twKZGycSclnqzfz8QxpF0Hv1XKultv49wH1pa9O
 FoI4OOH5LfPXJEb/EYpyEX6JdMtezyeKmDjRm9nSshILKoiwIE7qEbVPiJkrAoXPSsUn
 /S5WS7Bna1Z5/0rN9tfDXjSZfXMj29O5gVzsr763lrc8mG9vnSmbiZFeqixySFflFGH2
 qp7UYEWtCSRfSJQp2uyqBWh11BMZVehITkjh9v5CSk2kjqfxR2cVDu0HCLhHs4XgtJ3G
 WppuOFV7OD3LLoRwtMmuzTKcHbaoypeHkrFBrJ6VF2Jx724PsfNdYefDd/GgD+8Y6ASs
 7rWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793410201; x=1794015001;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yLmuUlEcL3prJbZs+XFuxuv7jTVBZioIhma4GM+1auQ=;
 b=xgP0DugyK44X+Uyr6uBhhr/IG2OISC6B/ygeaXMrSDYkeCwPNsv6L6Alm5yVP1toKh
 4n4ZLPkqbdkS+vvA8QCOV2wCQI64mFcOcrbn9Q0nHxbeNQXH+Ra4jD30wadT0CSSgv9D
 DmYENQo42VL7VGLslcUnxaLaRSPtHzWqwe84Dv4QOkeve/YI9/7rlxwT41H6PN4Ng9IG
 iXKsYDJD7NC0pRLkf6e6GDWnsBVE2fbGCsLRIhdHV97qs4x/THeEMaeu0UII6r+D7JeK
 A3tjOR27WQY8i88RWvEhz6E0YTxcJmZ7bfaAcU4dwGytyGoC1JnDj+NP4Sh3cs6L5yye
 KnkA==
X-Gm-Message-State: AFq9FYIVxiu6wQMxMPm3H6eVk6NSZASbNRaRdLP+A2R/fpbaLVUcKFI9
 JEmofJInxC9sP94TF+eCLdKWiijJJer/0ujQWfRhFiKDqJ9eRa1P67NEZ/XZlqTvhQVEElbDArg
 qf3gcJpNY66myFySoQUNlRfKjR8C/S7nGjlsDHL7Rt1Zl2aIpEb8k+WE+rEAApr1wdA==
X-Gm-Gg: AYBFou3pyEe025d+5PLucmfbuCa2kseJAwrVtKc3lFdD+7p77NAXUT/2UmL9zRx2Jpc
 WmfJcThk1Y7xfSQVZrtbQR49lojvvQ+hxJqS1rKKnejS8wnfCjOC78PVLX/HEQt8JWMCqoBNlgP
 oJ3vBrHKBvafhn+JljModzLABNsl1omLTpb0/KeB1lDBbVgPTZEr+RXNj3T1/wTHF/kXVEwiRi6
 gFhNKoo9Ab5IT8aln0X3pacfVIKqBHl8wPycO6ym/WYqUpJSMUmoNKqhGT2amxlKelygG1pF0j0
 wh7CpaWdo07PjswHwr/Ew8AtFk+rNA3uycKP6PX4+KktX3SqfvbUfbj31MI5+9ckLv+H/Cvlqk5
 cIn7jGQVoic5c732D8b2AMKGB3WyskAMf+L046iVkbNXbXHY0f9DF626OLRv8c5Aw4kEtvjr8P7
 xQwE9zzAvOmMUCPhldrIFTbw==
X-Received: by 2002:a05:7301:715:b0:369:f41e:d2dd with SMTP id
 5a478bee46e88-36a4241b18amr5489929eec.31.1793410200941; 
 Fri, 30 Oct 2026 18:30:00 -0700 (PDT)
X-Received: by 2002:a05:7301:715:b0:369:f41e:d2dd with SMTP id
 5a478bee46e88-36a4241b18amr5489886eec.31.1793410200300; 
 Fri, 30 Oct 2026 18:30:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm12170472eec.20.2026.10.30.18.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 18:29:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 03/40] target/hexagon: implement floating-point exception for
 sysemu
Date: Fri, 30 Oct 2026 18:29:04 -0700
Message-Id: <20261031012941.339141-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
References: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX5SYT5pgBNacQ
 Uv17wchiGcGA7S50xK1FLqTQdquP2z8WnB9kd+D0Oy9c0GaTWakEje7nC6iwDslz6QinM/D9v1S
 7JWpCAbJ4aFg0AFsmu3+djrKx4+Z9YUw7mX2IOV4dp1nLE7tVIDBRMsGg7Jcp/4kVVDCmM5k7qS
 BkmfMKJwsC2XXHhn+Bl3PPAWcO2XiBcMUBxnpMb0sOXKw3an6QnLENehWVg/xOfBcrBvRlaVXE0
 C9gUrt3l8YheJsY9QblBDc/8lqJ5Stxk4oRA5PmvZTIK/cQUzkp01OhwQPn3t+Ff7HJeAfpKYab
 NPe71EQa0F/Idz4dUK/YYVwDuz5aIHZETB1M3GNrFWi+A9EA1Q06b8DfpA6drxsHeFvvpF1eTRQ
 UaNI/kT2+b+wsGhAOiF2tq+PJLjS5a334dJgr7u4py0ix3FOD2kdw6gSNi+y0YG+FmvRg3q/McJ
 YyhRKzciS8MIqgYMQLw==
X-Proofpoint-GUID: refcojm-5Ra-LtZDJay4Jvp35KvKWMLX
X-Authority-Analysis: v=2.4 cv=FcSiV5+6 c=1 sm=1 tr=0 ts=6ae5449a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=x05RA5dRon49DLOVpUcA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: refcojm-5Ra-LtZDJay4Jvp35KvKWMLX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX/alwEtO2ezcv
 urmGAn4porQDZLqlpKkNmkm1xM3WVebmrL0L/QoQiGwYuJzOfVWsZsCbUFAfQDElZObFD1GSmJv
 GqsuhEoB8Eu7fbVpwn8TDIIcBgKBzLE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310005
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

RGVmaW5lIFJBSVNFX0ZQX0VYQ0VQVElPTiB3aXRoIGEgSEVYX0VWRU5UX0ZQVFJBUCBleGNlcHRp
b24uCgpSZXZpZXdlZC1ieTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KUmV2aWV3ZWQt
Ynk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4K
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL2FyY2guYyB8IDEzICsrKysrKysrKy0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vYXJjaC5jIGIvdGFyZ2V0L2hleGFnb24vYXJjaC5jCmluZGV4IDNjNDE3MzU4ZTA2
Li41ZWU4N2IzMjBiNiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vYXJjaC5jCisrKyBiL3Rh
cmdldC9oZXhhZ29uL2FyY2guYwpAQCAtMjAsNiArMjAsNyBAQAogI2luY2x1ZGUgImNwdS5oIgog
I2luY2x1ZGUgImZtYV9lbXUuaCIKICNpbmNsdWRlICJhcmNoLmgiCisjaW5jbHVkZSAiaW50ZXJu
YWwuaCIKICNpbmNsdWRlICJtYWNyb3MuaCIKIAogI2RlZmluZSBTRl9CSUFTICAgICAgICAxMjcK
QEAgLTIxMywxMCArMjE0LDE0IEBAIHZvaWQgYXJjaF9mcG9wX3N0YXJ0KENQVUhleGFnb25TdGF0
ZSAqZW52KQogICovCiAjZGVmaW5lIFJBSVNFX0ZQX0VYQ0VQVElPTiAgIGRvIHt9IHdoaWxlICgw
KQogI2Vsc2UKLSAvKgotICAqIFRvIGJlIGltcGxlbWVudGVkLgotICAqLwotI2RlZmluZSBSQUlT
RV9GUF9FWENFUFRJT04gICBkbyB7IGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7IH0gd2hpbGUgKDAp
CisjZGVmaW5lIFJBSVNFX0ZQX0VYQ0VQVElPTiBcCisgICAgZG8geyBcCisgICAgICAgIENQVVN0
YXRlICpjcyA9IGVudl9jcHUoZW52KTsgXAorICAgICAgICBjcy0+ZXhjZXB0aW9uX2luZGV4ID0g
SEVYX0VWRU5UX0ZQVFJBUDsgXAorICAgICAgICBlbnYtPmNhdXNlX2NvZGUgPSBIRVhfQ0FVU0Vf
RlBUUkFQX0NBVVNFX0JBREZMT0FUOyBcCisgICAgICAgIGRvX3JhaXNlX2V4Y2VwdGlvbihlbnYs
IGNzLT5leGNlcHRpb25faW5kZXgsIFwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudi0+
Z3ByW0hFWF9SRUdfUENdLCAwKTsgXAorICAgIH0gd2hpbGUgKDApCiAjZW5kaWYKIAogI2RlZmlu
ZSBTT0ZURkxPQVRfVEVTVF9GTEFHKEZMQUcsIE1ZRiwgTVlFKSBcCi0tIAoyLjM0LjEKCg==

