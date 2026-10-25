Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B44606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jRYSvzJM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PuBuF/ez
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKorm-0000dL-Lb; Sat, 24 Oct 2026 23:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoqe-0007nG-FY
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoqZ-0001UN-F8
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:38 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P16S0M3584449
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ONzaeJc5DfFv+nqFecOu/CJQwCpj8fhoj6bZCBfS1PU=; b=jRYSvzJMwN5h1YMu
 s23NRc4qJF3OnuHu8/OYRtxEAJlDrnH2Zb+uvcO1CG170jiwWyN90F9YVbEIBlAo
 M4bTRrohwcuvh5OYmTYJ9mG5yeEl2eouN14NGBWbDhQ2zQsgx02e3kv7lbQo9EEl
 755voIk7u3eTwCAxQeFWZTG1LqX2dvZz37gO10ey7vFcKWHlEw8hmLv9UmK5riMa
 Yqcfpk1nuUR+ozV/dGD67+KB4tz2iDSWSmdL9JF5Qazcxc8TSW9b8Ar7BbuJmAvW
 74BjW+xf1AGy+ikeWsyymLrA5aWdfI2eER/cjqs2k1s4QL7Q/T0gZqwcwBJUeAgR
 Vuahiw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6jeb3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:24 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-151ba226e1bso3903833c88.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898663; x=1793503463; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ONzaeJc5DfFv+nqFecOu/CJQwCpj8fhoj6bZCBfS1PU=;
 b=PuBuF/ezRTCIelF2gcjFkzFvrPMytXwYGNs5PNc/g06j02POzIwDjaFlYhWkRUpabs
 SHCDVo2dn92UlMtqto8e7j+sphSRjEtWrCKKBB5wpS33drgZtwKidPWPa41EoPAY/xj6
 aDP4miHhWbz/teS4tqTSEZRlplkkyMIWKWbL9wg+rd/GUReooQH6wouywlu4GLGPHAhj
 NP3qLEUDMboXMWhyV8dNQmXoQqci/6ItkaTOX5XD8ExcpsNtiUownepFKrjgOI59gIkM
 J/Sw6hh98tktc/0ME+CPFq7V1rXhOZXcKy8osH+5nKev2d5h3I9qT/O/5gde4TQLN3S2
 yzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898663; x=1793503463;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ONzaeJc5DfFv+nqFecOu/CJQwCpj8fhoj6bZCBfS1PU=;
 b=iMV12bZznlOc7NU4gQv3fAcpc95QRPsyP5nCuU6XjyqQIqMpnoioJwzgQryLnoAoO8
 AgDc73S7LaSfnncwtDPpFXGm7kMvt8htoLF45uEqNy24NOn2suqxQ20/uAIB0Fo09FG0
 xjxlex4FaUM6dQ+JqkErh87JRLacY7qMiJY4x1pwArsXXUA03VZaF3i2MWDqbyZidpzc
 dvB0xC6s8CygivP84wtfyqvYN84T7TgwferbpadT+ztSx/jhrwtoQwY4Nm8zP+U/G7rh
 HUiL3lav//xmkI2izqFEj/eN8vL86Yk+LOIqiXpAzv1RjnrgOH1gxPhIm/MYf4sjvnek
 qZPQ==
X-Gm-Message-State: AFq9FYLxUWSrUAqGRgQihcwrlDKhKtnOPgQHEhzRzI/uADUtcQAySuGf
 7Av3Fwq61KxSL3+/WwKdGZ18A8BZiVBb1mt1Uvgq0nTXDZjgkmiCbwW2SBMAx8Cp5gRliRqFmi4
 b91xiXZbkEw7wY6zT2/RC0CjeHZ+FH2Zt8H4ec5fuA41wHFeENCz12aRHPMoNawccFg==
X-Gm-Gg: AYBFou126dgMloB4/dyNcrxkIrfYeDOZseZ8yN/l4DtoqxLGiFURCHcXT52OlcEXvE7
 /m6OWUg6cLPWBvQQRMzsPFaNHoarnf7rhQT1eMyqLQajXI9llbvn3ogxH64kwsD3mmdYrthuC62
 3RBWkAlmm8o7a5Xp0tgFagMaFep5WThpLB3A2gzMg6vZl3h61WI5+MC2LKlaErAOhu93Lrpvbr5
 Utcld5q91uhy6DDYuskL8RYUzbPIbqXDbWEnmx2J6uj67mDQOZ8Ote7joKehoDr+IoSangM7L+h
 1yQP21KBPQOUC0sZDP0UQxxK49Np/Ci+seWuVrUrEZaktoG3LAW2/U1PDCA5MPF4zlORl6R0UvN
 Ze3dcMICjHdYvuUukq8nYveNKJCs91vFSM3hUaEOHnZ7V9j0=
X-Received: by 2002:a05:7022:3f0a:b0:181:5cac:8f27 with SMTP id
 a92af1059eb24-199377d50ecmr5386633c88.35.1792898663359; 
 Sat, 24 Oct 2026 20:24:23 -0700 (PDT)
X-Received: by 2002:a05:7022:3f0a:b0:181:5cac:8f27 with SMTP id
 a92af1059eb24-199377d50ecmr5386608c88.35.1792898662786; 
 Sat, 24 Oct 2026 20:24:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:24:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 16/40] target/hexagon: fix semihosting OPEN filename handling
Date: Sat, 24 Oct 2026 20:23:22 -0700
Message-Id: <20261025032346.2917451-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: xIDIoxHFUhaMCw8vOk_qQ986ko66r48t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX1R4vsXvX4Wpo
 U1ZP/ZIhMFtf1Q98lwUV3SWCHFJANaK6vsyHS8e55VrHsKisUmX2VcN+P++eQhGXhWqpgKIUtX/
 Dj/i52230TwgSSuWY+yaz/FFLmjhAcA=
X-Proofpoint-GUID: xIDIoxHFUhaMCw8vOk_qQ986ko66r48t
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6add7668 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=wfIhpZVs-6LWPqknoVUA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX/qe//y1AJ4xj
 Bk8FH67PfJ3BDzT45QOblFcSvKXKcJJNILfrzfH3+JKx6sfZOXEM9zXtOnoAdz2Mk805uOAhI8u
 G7BDU1SqLKbqEzsHzNc4fFlr3j6WyuhfThrunCgtFvdT0F3gZ+5mjtAflcXBO4DRmjcJBW/w0Ph
 ZP/uRLXj3CiLp3svhIww+INLTe1fAtz9UgJT6s85AtdBh1NGeGuRxfW5cVmG8Ylk+KEtvSYA9uy
 Rytl5+Nf2xKy+RYrIfRBD3xtS4M2Nloq7pTJvJwfxnbG59cybKVXEpz0VZ8E4timZXGwu/eZZj6
 F1VdzSHrhTljt9sWZr6aSCRl+/2ApE9Z02fHxU6HiKzI6gv0BlzIeYwAMQvvRovcwfUfasbpGkN
 6UqK3uMdXCAkADn5s2PbvtmyuTiL00inE1eIqUYqkNn86kPfHD5l23O7vnofEbc6aVOcgs4gwsi
 FGXD7P1eJRJVEhDgXeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610250012
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

SEVYX1NZU19PUEVOIGNvcGllZCBndWVzdCBieXRlcyBpbnRvIGEgZml4ZWQtc2l6ZSBidWZmZXIg
dW50aWwgaXQgZm91bmQgYQpOVUwuIEEgbWlzc2luZyB0ZXJtaW5hdG9yIGNvdWxkIG92ZXJydW4g
dGhhdCBidWZmZXIuIFVzZSBsb2NrX3VzZXIoKSB3aXRoCnRoZSBBQkkgZmlsZW5hbWUgbGVuZ3Ro
IGFuZCB2YWxpZGF0ZSBpdHMgdGVybWluYXRpbmcgTlVMIGJlZm9yZSBvcGVuaW5nIGl0LgoKRml4
ZXM6IDc3MTFmZGJhODhiICgidGFyZ2V0L2hleGFnb246IGFkZCBtYWluIGFyY2gtc3BlY2lmaWMg
c2VtaWhvc3Rpbmcgb3BlcmF0aW9ucyIpCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC9DQUZFQWNBOU1PczZWZkhmMlVIWjh6NGNkdmFCKzdEWTZoSmIyZW1ZWjJhTFNlLXQ2aXdAbWFp
bC5nbWFpbC5jb20vClN1Z2dlc3RlZC1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnPgpSZXZpZXdlZC1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29t
bS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMgfCAzMCArKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxNyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyBiL3RhcmdldC9o
ZXhhZ29uL2hleHN3aS5jCmluZGV4IDMwZGQzZTg5OTI0Li42ZTgzZDg2NzMzYSAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMK
QEAgLTQ3MywzNSArNDczLDI5IEBAIHN0YXRpYyB2b2lkIHNpbV9oYW5kbGVfdHJhcDAoQ1BVSGV4
YWdvblN0YXRlICplbnYpCiAKICAgICBjYXNlIEhFWF9TWVNfT1BFTjoKICAgICB7Ci0gICAgICAg
IGNoYXIgZmlsZW5hbWVbQlVGU0laXTsKKyAgICAgICAgY2hhciAqZmlsZW5hbWU7CiAgICAgICAg
IHRhcmdldF91bG9uZyBwaHlzaWNhbF9maWxlbmFtZV9hZGRyOwogICAgICAgICB1bnNpZ25lZCBp
bnQgZmlsZW1vZGU7Ci0gICAgICAgIHVpbnQzMl90IGxlbmd0aDsKKyAgICAgICAgdWludDMyX3Qg
ZmlsZW5hbWVfbGVuOworICAgICAgICBzaXplX3QgZmlsZW5hbWVfc2l6ZTsKICAgICAgICAgaW50
IHJlYWxfb3Blbm1vZGU7CiAgICAgICAgIGludCByZXQsIGVyciA9IDA7Ci0gICAgICAgIGludCBp
ID0gMDsKIAogICAgICAgICBpZiAoZ2V0X3VzZXJfdTMyKHBoeXNpY2FsX2ZpbGVuYW1lX2FkZHIs
IHN3aV9pbmZvKSB8fAogICAgICAgICAgICAgZ2V0X3VzZXJfdTMyKGZpbGVtb2RlLCBzd2lfaW5m
byArIDQpIHx8Ci0gICAgICAgICAgICBnZXRfdXNlcl91MzIobGVuZ3RoLCBzd2lfaW5mbyArIDgp
KSB7CisgICAgICAgICAgICBnZXRfdXNlcl91MzIoZmlsZW5hbWVfbGVuLCBzd2lfaW5mbyArIDgp
KSB7CiAgICAgICAgICAgICBnb3RvIGRvX2ZhdWx0OwogICAgICAgICB9CiAKLSAgICAgICAgaWYg
KGxlbmd0aCA+PSBCVUZTSVopIHsKLSAgICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNU
X0VSUk9SLAotICAgICAgICAgICAgICAgICAgICAgICAgICAiJXM6IGZpbGVuYW1lIHRvbyBsYXJn
ZSAoJSIgUFJJdTMyICIpXG4iLAotICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywg
bGVuZ3RoKTsKLSAgICAgICAgICAgIHNlbWlfY2IoY3MsIC0xLCBFTkFNRVRPT0xPTkcpOwotICAg
ICAgICAgICAgYnJlYWs7CisgICAgICAgIC8qIFRoZSBBQkkgbGVuZ3RoIGV4Y2x1ZGVzIHRoZSBm
aWxlbmFtZSdzIHRlcm1pbmF0aW5nIE5VTC4gKi8KKyAgICAgICAgZmlsZW5hbWVfc2l6ZSA9IChz
aXplX3QpZmlsZW5hbWVfbGVuICsgMTsKKyAgICAgICAgZmlsZW5hbWUgPSBsb2NrX3VzZXIoVkVS
SUZZX1JFQUQsIHBoeXNpY2FsX2ZpbGVuYW1lX2FkZHIsCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGZpbGVuYW1lX3NpemUsIHRydWUpOworICAgICAgICBpZiAoIWZpbGVuYW1lIHx8IGZp
bGVuYW1lW2ZpbGVuYW1lX2xlbl0gIT0gJ1wwJykgeworICAgICAgICAgICAgdW5sb2NrX3VzZXIo
ZmlsZW5hbWUsIHBoeXNpY2FsX2ZpbGVuYW1lX2FkZHIsIDApOworICAgICAgICAgICAgZ290byBk
b19mYXVsdDsKICAgICAgICAgfQogCi0gICAgICAgIGRvIHsKLSAgICAgICAgICAgIGlmIChnZXRf
dXNlcl91OChmaWxlbmFtZVtpXSwgcGh5c2ljYWxfZmlsZW5hbWVfYWRkciArIGkpKSB7Ci0gICAg
ICAgICAgICAgICAgZ290byBkb19mYXVsdDsKLSAgICAgICAgICAgIH0KLSAgICAgICAgICAgIGkr
KzsKLSAgICAgICAgfSB3aGlsZSAoZmlsZW5hbWVbaSAtIDFdKTsKLQogICAgICAgICAvKiBjb252
ZXJ0IEFSTSBBTkdFTCBmaWxlbW9kZSBpbnRvIGhvc3QgZmlsZW1vZGUgKi8KICAgICAgICAgaWYg
KGZpbGVtb2RlIDwgQVJSQVlfU0laRShhbmdlbF90b19ob3N0X2ZpbGVtb2RlX3RhYmxlKSkgewog
ICAgICAgICAgICAgcmVhbF9vcGVubW9kZSA9IGFuZ2VsX3RvX2hvc3RfZmlsZW1vZGVfdGFibGVb
ZmlsZW1vZGVdOwpAQCAtNTA5LDYgKzUwMyw3IEBAIHN0YXRpYyB2b2lkIHNpbV9oYW5kbGVfdHJh
cDAoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgICAgICAgICBxZW11X2xvZ19tYXNrKExPR19H
VUVTVF9FUlJPUiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIiVzOiBpbnZhbGlkIE9QRU4g
bW9kZTogJXVcbiIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBmaWxlbW9k
ZSk7CisgICAgICAgICAgICB1bmxvY2tfdXNlcihmaWxlbmFtZSwgcGh5c2ljYWxfZmlsZW5hbWVf
YWRkciwgMCk7CiAgICAgICAgICAgICBzZW1pX2NiKGNzLCAtMSwgRUlOVkFMKTsKICAgICAgICAg
ICAgIGJyZWFrOwogICAgICAgICB9CkBAIC01MjgsNiArNTIzLDcgQEAgc3RhdGljIHZvaWQgc2lt
X2hhbmRsZV90cmFwMChDUFVIZXhhZ29uU3RhdGUgKmVudikKICAgICAgICAgICAgICAgICByZXQg
PSBndWVzdGZkOwogICAgICAgICAgICAgfQogICAgICAgICB9CisgICAgICAgIHVubG9ja191c2Vy
KGZpbGVuYW1lLCBwaHlzaWNhbF9maWxlbmFtZV9hZGRyLCAwKTsKICAgICAgICAgc2VtaV9jYihj
cywgcmV0LCBlcnIpOwogICAgIH0KICAgICBicmVhazsKLS0gCjIuMzQuMQoK

