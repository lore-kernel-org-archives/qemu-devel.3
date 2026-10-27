Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF570606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UtTeFW9P;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y4G8nnw1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXuA-0004w0-84; Mon, 26 Oct 2026 23:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXte-0003tp-1a
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtc-0000B8-Az
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:45 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2F2gf322084
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5m2V4Cw2pbARPt8giz1x4Tv7QgjGl/JECvE7V/EJubY=; b=UtTeFW9PgHwNWhtJ
 4grtN8ldxpJYutEDobCtxdvtQ++WSBl3x03/RVoiae5Z76DMzsdqq/qLlhykUdx3
 Z/nqN3kc8J/+yAbkDdQrDLhe7s3eFkjxny+0iuhhC6YTb+hTlFTHdNVnVsqP++22
 ashC75ls/Gvr72MdyyQ3n8ToY7QhBJmwhstmjg1Hpp4higthjC47pogEd8/yp73b
 gN4gvtlODIToPEUEqg21WIjiqQIoz3DieiQ53E04u5/ehPngF8Uc+PwSITI7muE3
 1lH704yRWRFPPBbJqgTkX5QocNEKlnTjj7rRNlSNubvJLYqnHLFUUG8c8Ufjijfu
 /5n/Uw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmm9pgt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:42 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-16bc6f3fdb1so3861445c88.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071842; x=1793676642; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5m2V4Cw2pbARPt8giz1x4Tv7QgjGl/JECvE7V/EJubY=;
 b=Y4G8nnw1BG/2LSrhAkGs1YnHVKX+UilZhnUDFtmOcnCoR6Eva6cfAa7FgfAngrtFMC
 4mgZSbxZaeWrjVSubuf+AbTYC9CQHEWkzUvsYnHHkuvJTl0XCXVpIuINzDv3gRYnT3jE
 y9yblMMRJrpu7TAOYFkCf0L5Bh/e1R7sJi/M9s5P8jLD6eOLecBqTh93294O0S52KoXs
 UkFPJyS4PDDrB82rJWDgQCQjZj+dZY5U6pT8mMy9x4BYoII1/BkGbz8o304VW7rx8EXp
 wLbRpqvamX9d+x9TX7+ekxRh+AJ/pW0Mg4UZD5V3gBDKyVQCMPOSxoVi8z64sv0MlN4I
 ARmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071842; x=1793676642;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5m2V4Cw2pbARPt8giz1x4Tv7QgjGl/JECvE7V/EJubY=;
 b=ZlUoHQmpeVCmUekzBQ+I8UfcXkrNRWkEb5jw0AhOeU9XGlZEbRyCEJE9SnX5PiNAjX
 RVwIMxkvKVyxKYsor0f0lMQpjNxjk4CuzdxCI6DGBTD72+kFYCJV92zFNYZ9mnFJslfh
 8l9TF35eEi46moBo/n7GIFJj/rjGntMFvCkkrkfmanEqkZUo2s/eJ94BaffDN2mI3EI5
 56QHMUgcc7zWehCNtjMmfMKe/i5FCo8EtCtwWxXNQp5Zsci8zTTRx8I+UdmsyvNuDNG8
 kOQhD2Op+Ixl8/YstIai1PmZfuQEq00byvSrGAwhRpdf3oJF5ALHIecG9kqiHo5zZOHy
 6HQA==
X-Gm-Message-State: AFq9FYIFLa4kxzJ8l0+vpb95rKgt5A5el3EEN8VO2PkhoIjd2ZU6cW31
 y7TwEvrgpoi6x8ZiJbdH7ZlNghy9nlLl+/U04py9Csc3c5N/vFhjYLafOv/gAE3++YZvJdKLKds
 HOrJATTu4P2qRrkc1MkihRY0Eet3eURjNvnY5Vzqb4+ZJ4nc5hGnxGlC/ELSRJYbMaQ==
X-Gm-Gg: AYBFou3zNFRo3NUT430bCDF8wOS+BKNgBBhfBposH4znUxbZ9tSPWjEpCUmYTndgC8c
 MrKm8bhgjsjDnElIaWKWTqNklsgK073/p2LDwe4jVSbuKNG/sTwKENjM/de8jmfcVZMzbzA3Jnq
 t1Le7n8YVewwMIGVwYPaSx+XjIoQfp71T1uXBn6yxR6Uh13P+Xg34aIjDzBrDXxoLEOyUoInflV
 DXG2I8MO8JK+axekhLgp8Rjy1otNFuEtsiC1K66J+uXofvOj7T4q64vxTXUHlckcA8ZE5QjV4eY
 IxF/fBlhnIQDexwW3eDt7x52aGm0aHwUxTk71xukKqVbts0LfUCgH+fkqEVyrhLKgrB23W8/2D+
 58YGKFua3azPtJHuHVmVA1CGyevNQbSigTmhg/IQfbXpc5uI=
X-Received: by 2002:a05:701b:204e:20b0:183:bebb:e93b with SMTP id
 a92af1059eb24-199292f43eamr11899039c88.6.1793071841914; 
 Mon, 26 Oct 2026 20:30:41 -0700 (PDT)
X-Received: by 2002:a05:701b:204e:20b0:183:bebb:e93b with SMTP id
 a92af1059eb24-199292f43eamr11899001c88.6.1793071841233; 
 Mon, 26 Oct 2026 20:30:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:30:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 33/41] target/hexagon: check exception_index in has_work
Date: Mon, 26 Oct 2026 20:29:19 -0700
Message-Id: <20261027032927.3055166-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfXyEx7/l5Vi9Vi
 OKR2LKrGpaq55EvvXKry8TlZ1UOvPDV6dLRWDnqfUk1oyRf8p/kjLJOxcdgSvB+uX86ANK7k+uv
 9s1rwy3lkH1t1yYgnHmkX/GxYPiLzb0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX3iUxz0opkIyp
 k7SexGId8K806LMbpkbtqQWuYvtbZFEAvE7+GangXGuoL24NJLHxS0aCD4u3DS2FNx9FKwSE22d
 Z4CC+VQb13J+j1V8ZhsUpxtMUNzFV9MkdtFCTzgEfI1MGkfnnu3ybh0pcoFjHl713a/+XTJcZYW
 USofqds3x/KJO9fm5g3DOGBGvh3mXNIZZtuREbLLhHIackTKcw+PnWGrlc/B8iA7abJqOBDsbaH
 9d0+DK9W36OgLrwbWYaBGvzc6tCSVuS6LVelX7B5EEt/NK3CrOr41zs+QcME8zP6w7lIf50GvZz
 G4S6gI75b9M6frgSg+EkPhua+LFIDqhW6fxiYdadDOT6aPv0Eqx0lo0lDGSskZjHY2ElexebTzc
 JRwcujL4GlhDLegFQq+Z6p0JwuPgKU7JXU+DYez9OT2BFSO7HQ+AuAjyMRU59n2YafFJLf7tt/x
 TlK4XwPHdrKMA2IVXuQ==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae01ae2 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=2Qhxk_BCo_5fC3_CN1YA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: ajJ-3dqVWg6guxXm9XjjWNu7ig8fwx7U
X-Proofpoint-GUID: ajJ-3dqVWg6guxXm9XjjWNu7ig8fwx7U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270013
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

V2l0aG91dCB0aGlzIGNoZWNrLCBhIGhhbHRlZCB0aHJlYWQgdGhhdCBnZXRzIGFuIE5NSSB3aGls
ZQppdHMgbW9kZWN0bCBFLWJpdCBpcyBzdGlsbCBzZXQgd29uJ3Qgd2FrZSBpZiBubyBpbnRlcnJ1
cHRfcmVxdWVzdCBiaXRzCmhhcHBlbiB0byBiZSBwZW5kaW5nLgoKUmV2aWV3ZWQtYnk6IFBpZXJy
aWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9m
Zi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdl
dC9oZXhhZ29uL2NwdS5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5j
CmluZGV4IDYzMmVlM2Q2MGJkLi4yODFkMjAxMjUwYiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTQzMCw2ICs0MzAsOSBAQCBz
dGF0aWMgYm9vbCBoZXhhZ29uX2NwdV9oYXNfd29yayhDUFVTdGF0ZSAqY3MpCiB7CiAgICAgQ1BV
SGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKIAorICAgIGlmIChxYXRvbWljX3JlYWQo
JmNzLT5leGNlcHRpb25faW5kZXgpICE9IEhFWF9FVkVOVF9OT05FKSB7CisgICAgICAgIHJldHVy
biB0cnVlOworICAgIH0KICAgICByZXR1cm4gaGV4YWdvbl90aHJlYWRfaXNfZW5hYmxlZChlbnYp
ICYmCiAgICAgICAgIChjcy0+aW50ZXJydXB0X3JlcXVlc3QgJiAoQ1BVX0lOVEVSUlVQVF9IQVJE
IHwgQ1BVX0lOVEVSUlVQVF9TV0kKICAgICAgICAgICAgIHwgQ1BVX0lOVEVSUlVQVF9LMF9VTkxP
Q0sgfCBDUFVfSU5URVJSVVBUX1RMQl9VTkxPQ0sKLS0gCjIuMzQuMQoK

