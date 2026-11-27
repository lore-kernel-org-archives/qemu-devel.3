Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A9B606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JsgIITFG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VMqqCite
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzLl-00073E-6v; Fri, 27 Nov 2026 12:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzJM-0006DU-6h
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:00:44 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzJF-00026c-32
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:00:34 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARFpFdH925910
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iJ/m9kqJqR0
 g6z7dcXNQvSzuAJSXZjfn1DxxsqoJ/H4=; b=JsgIITFGkCRFh2PIpyqg6ovfE+r
 tDPnHxvZ5wNXGI8MW9ndRHQAUbtHbfI2yyNli0u5YPhCbEsUSP7qTHox1nFMPOIq
 wxt6IBviKDPm9wfbQIVJk/CLhY6M0YH7PXifrUFBNVtVYPV1GhKV1bXGH3OW6GZk
 TcUzeyeYlJEvbhvWAORA+xtjnwkn9/KGhUcXoh68w5vF5VifB8bArozBZjslff3S
 0Aq6WFuBjf+t8Y+ugFVnrYCZh1Ki1x+f9Xx+fSygKVTA3eSBc6O70xkFRk4DasDT
 zInO6Dc4JQ0KeT5SjuluM/f/huB4jR9DX7W1D2yh/zjwHqs4J1ZjUMvR50w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u49bwnh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:00:20 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8b691cf0eeaso9378662b3a.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795798820; x=1796403620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iJ/m9kqJqR0g6z7dcXNQvSzuAJSXZjfn1DxxsqoJ/H4=;
 b=VMqqCiteo98KtLOL43bf490LAJabdPpQEaEcHuN1dlMvO0C/dAIGo5KudAgBBZ4zTA
 xHZZj/p11JSZpeg4zLazKr/y1fc/9x5bADqJ9dXI6vf1GfEPVHPIyv6cy0VMVmMh6ZU3
 qZ6XQJ5G+ZYMjn/njYm6cZ4j8se9zzuJCjBrfKixI/di4QVFnRP0t0MXwNfzhr5ZZO+r
 hg1NiXGiiAm3yxJQINykwtCX8mEQLJPsglDKWE+nYKQ5EroTgUXUJI8iE79mPZ/8mpM7
 WxmlSc71tPOIDU+4B0a9i80skzVSifIaLPIR8jEVodTnYtFkAgrNaWi88QINbboWxMO4
 uyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795798820; x=1796403620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iJ/m9kqJqR0g6z7dcXNQvSzuAJSXZjfn1DxxsqoJ/H4=;
 b=pzxGcPEfwcHqu97S9knmL6lzZhKJFDtJJzv1HWZy3t5kRGo3R3Vn/T3oiQpmlG6WSX
 qb4xPsoWtiP/mTXAH5pztxL+uC/y9CPKNINn4qH0eED5/8A3yA1klC1gtIlSY2tz1E/u
 8sNiuSIA9ie19gbS5x4aIR3m4MTrLVOEIPX+T/2dTh9yldZvG4i2qdzYoR653fGudKKa
 gF0VW/FOrEDPcFZeCP8i8/rWlHfFHLcvuf9kpblExXo3harI2dPfi8t+gKhVQCMeGJpQ
 WNj/sv6hSgXLDoCv3axriTBk2b/QlcdlGafSZGYf7Gc1bXYKFJYy1CmdnQ7VtBqeY/o9
 r5pg==
X-Gm-Message-State: APuU4Z8F79Zr4jAvF2vQSD95j9E4F9EFAIvpzAql7Rgf1+xRqNJf9GdG
 EIN1GT1ZWxM92Wr7mmycUUjioI96HKkGVSotDu2BMDjRu5Ybtt7SKAFIcbzQdIQhZQQ+ljo/S4I
 A9MRoxHl1p1QQEHPOo50n5h0xm7mjw61a7EK1kikmGUdy2DjIAUVmdjNyLbKpeY7DtQ==
X-Gm-Gg: AZFdTZeHWer0HCoFFzM7jcnojyaNbqHGjMehpSWj2QrdtqZJY4K7Jp/9RKO7Ry4I/zl
 zo7TuXcsNkHJrR5tG+qPxctGhuMLHCSXsCq98YqiDjplz0Gn+sWTYGpwj1uAe65nPlaD34iK2H9
 6Hy4iCh16Fgji2m6g5P7b36iTjUA9vjuYc0EOEZ2DBuoB269wwI37L55o/OPLGVOCOsRgm8KhsH
 U/y+vH/cDb0YFtZFrpYwIhck3W0DDqzwqNz+tE2ZARy/7Iu3sXzoVDf4VM64qIvK5SiD7W+8fJL
 nsxNwjT03D0Thm5p6Tw7y40sEoDzALh0fbKBAhdB4HvEOgPiHVTLw9Ls92DgDDcB8Ie4c+63L6d
 ltI4qauKYAPAKQxKKAeF00ovGI/B+cTMtjOpXDYhat9yUFhmw+1FUk3unBbT8ObhOH5TjZtlDjA
 Vbbl4JB6veSnsVgJEimXx1MPeR9pMS2btIig60
X-Received: by 2002:a05:6a20:748e:b0:3d3:aec2:4dcd with SMTP id
 adf61e73a8af0-4014c251613mr28385822637.25.1795798819646; 
 Fri, 27 Nov 2026 09:00:19 -0800 (PST)
X-Received: by 2002:a05:6a20:748e:b0:3d3:aec2:4dcd with SMTP id
 adf61e73a8af0-4014c251613mr28385787637.25.1795798819231; 
 Fri, 27 Nov 2026 09:00:19 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87077a058sm13014650b3a.8.2026.11.27.09.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 09:00:18 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/3] contrib/plugins/uftrace_symbols.py: ignore warning
 reported by llvm-addr2line
Date: Fri, 27 Nov 2026 16:59:52 +0000
Message-ID: <20261127165953.51257-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127165953.51257-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261127165953.51257-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AD4kdRXHnSxtPEwjBtjZ_VQEkEjTNYsk
X-Proofpoint-ORIG-GUID: AD4kdRXHnSxtPEwjBtjZ_VQEkEjTNYsk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2NyBTYWx0ZWRfX1GA3OMuB4Grt
 PDJDyHsrYdqzQqSXhz5CN3GTU35dmNirZdw1K5IScZG2uYAvH6bMOeODOvpsJlHum256qWDpBNt
 Ribml42h2lAlWpz1nIKN1SI8ZwZb/Io=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2NyBTYWx0ZWRfX+9nxo0wbnlT7
 sTPllEDsKubZq1aeKx2Li61j5mPDOvl6ktxqOsvcce3fRwkpbMU8rtEKhoWAh0a3LRWbejZIHRU
 aE8oXLrYEVEE0jNb7WWfzoBE4sDlqmKBjPhDUxEHFZAMehyRqVJKjBzmcMaSZNDM6vbFdOML55d
 g6vQr84usUk5KNt5Wu0p7/q2iiUYTLGCwqSAYV8wgLnqnxjjMGozybDqMMuBBSD0zAnbbMZr3ME
 mU1jJpoiOPq2N0aNeLyywpQydmE2GsBUgmWVDLSObiw1TG1M+CDKC3O9TQYhUQEX9su0YoYgB59
 vQvHRet/pKV+v6myDP4yfL/M1tkdQRaQGlhZLD/rzlyZ27xqNnz3n5vMjAgy3uzj7G75SLC2T8/
 bF6WHaKdoVW857Wr5PxQRXeeqXRDLAJSkxaFVfA1pM4cmUrqsoROACh/qiET8TPIO0kj8PqMOG+
 mdLuJD/vinDfYsEgD3Q==
X-Authority-Analysis: v=2.4 cv=A875rKWG c=1 sm=1 tr=0 ts=6b09b724 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=4uSdFgqm0Hs0aUViYFAA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270067
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

When trying to trace a riscv64 stack, addr2line reported warning on
stdout when symbolizing addresses:
warning: address range table at offset 0x8a0 has a premature terminator entry at offset 0x9c0
warning: address range table at offset 0x1700 has a premature terminator entry at offset 0x1750

Ignore any warning, similar to the error we ignored previously.

Link: https://lore.kernel.org/qemu-devel/20261118021020.1253822-1-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/uftrace_symbols.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
index 9f0095e73b9..2b931c49a83 100755
--- a/contrib/plugins/uftrace_symbols.py
+++ b/contrib/plugins/uftrace_symbols.py
@@ -63,7 +63,8 @@ def find_symbols_locations(elf_file, symbols):
     out = out.strip().split('\n')
     # filter out some addr2line error messages
     skip_err='addr2line: DWARF error: mangled line number section (bad file number)'
-    out = [src for src in out if src != skip_err]
+    out = [src for src in out
+           if src != skip_err and not src.startswith('warning:')]
     assert len(out) == len(symbols)
     for i in range(len(symbols)):
         s = symbols[i]
-- 
2.43.0


