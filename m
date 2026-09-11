Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ED6C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x53kM-0003ZX-KI; Fri, 11 Sep 2026 12:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x53jW-0003MQ-8N
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:04:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x53jC-0007Sn-CW
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:04:09 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BF8h0O170537
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 16:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s7toQDmajxiHq8JTLpDGxEfXm8l+e/1PqYqmdBCz+yg=; b=Q+ub4HgT8NXtS++p
 8ohOq/jyR+NQ7dr36eHMseFzqcTkdWsHE2GEmw3dxgraPMwU2d4tZ/i9QlGsyC1b
 DyZ1Cb9rvv4NfT1peJP/rafU2AhLHZmsKBi+cUvephm1ngyW+IR1d9tkPzzHqJes
 M+zXUMS120m3hlJGOHx2S4mnxMa81IfF8ZAJBG9Uy7Ly+RMWWo6P946p3eMoQmKL
 RsADD9cZba2tcPahyrbviRLxRwJ1UPOHFFETsQGtztG+BI0jzS2MhNQFDdcXeXBn
 l43aX3mL3FgGoX7pzoXQKfWr6LeOaa4geU6BQrbkJm3MPHbOt/icEoVXIUYf6EQC
 92+jqg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmm1e87ch-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 16:03:49 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4b597558c4cso1343528b6e.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789142629; x=1789747429; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s7toQDmajxiHq8JTLpDGxEfXm8l+e/1PqYqmdBCz+yg=;
 b=ZAJdDh4Q41yR2DMNVwtdlFhiKn6CJRFvMJn3QyjdiZceek3s7/7Ye3+vYivCU989YE
 s1Vf3NOAuDqsfhS9VrTpFrK5waLnY3GMznYPQsWBAkCeGM/g8meK9LYssps+tI38sxYd
 viEtbHW5FMZltERA623T71qWiFvYVdemmvrM55mVcxeuhdis/8vc2xgRJKSa4FzoyGwj
 SfaKd3R9qep2f0922090n6XhQO8bB+Up4OSCL4K2anZhv9usyjjaOhXfCL8JJFvlJ7SY
 7cWioxyoabhfMSC9XAT9LaV32czTm4R20M7fslARy1F90Xxzh02rrFMAa1JQl7tNaswq
 HoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789142629; x=1789747429;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s7toQDmajxiHq8JTLpDGxEfXm8l+e/1PqYqmdBCz+yg=;
 b=nn+0VS0D44/GgqBHSWhz1qJ0mezFRnTGQ5pwbhOVzW4tyWiXJ2/n5mp/S51LOez61/
 SWWiuUks+Hh3eD73pfUp4PNj0F7sp5kYN5nzcUqqvxLLIxrg0GYWm20icAhEdRlsa+qE
 3c0LOvcDlSKhZ8k4S76DypoApc2394ik7avev0E5U4qntVzaEv/hYri5eXR2BnVsjwEC
 hbwfvyV4QfHsJjdxZwg7LMBg+L+WoDACu2ATZ0yod+s67F6cdj+PQMccjYpr5a0iVcYT
 iAo6JRgUhPUm8ny1mQVh6cyEHM9l3UvgxMEajy72/mm/foG8FkOet8Ez3yyZcYsa3msC
 bwzA==
X-Gm-Message-State: AFuF++mkEOa2r4yitREHvZkSlvaG8dYpNEJHOhL90JtSRLvbKQZIK1oG
 LavGbxpThdVbt3WAiw3JWkZJCDfFc2ETblKcWlw3e+y2oP/ry/MIWa5T2rkiUJSKpyqVn8sCKRJ
 NgYGmhHkm6snMfO2EMLubT+hSjeSX+gm057KqsEA55vcwqiHw99Qq19leiF8Hah0lXQ==
X-Gm-Gg: AYBFou2xlJD5EkmGQYheMo2efMpueYxloQC284TkwfkFnl8G5RqslJIjPH/z9mdg1me
 k2S80WrX3lmdHv7U5qwp2u1y4ot980g/8ej5QK5g5n9ZMTHUxahzOvBoQyt74flGRGG9468MNds
 lfk9yPmSfsPDndAMVDHpPInjdV8yewwR5zQvBjsMlNDZHJbzKlk53MXWONqptunTmInrllwJe6U
 iwWBwZi7ReCY+P3qjr3TybF80rlCZ/sO/WMv9dT+9/AHvsYMiFf4ZDthNJR9E26pEy4WD8nIWMG
 Xh/Fs80eOfecioUZASWuQHpXRPNBVcN04Um99iTyImerLYtsSglpPJD2zBNtX1vNXJqRjCCPQSU
 f5UdvT0KuVIGeNUCEWaY96oDNqFap/rQfLVaFk7OVbZSL1LWM
X-Received: by 2002:a05:6808:159d:b0:4bc:3c3f:3d6 with SMTP id
 5614622812f47-4c31b6d0372mr7097923b6e.11.1789142628432; 
 Fri, 11 Sep 2026 09:03:48 -0700 (PDT)
X-Received: by 2002:a05:6808:159d:b0:4bc:3c3f:3d6 with SMTP id
 5614622812f47-4c31b6d0372mr7097679b6e.11.1789142626466; 
 Fri, 11 Sep 2026 09:03:46 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c3321ecd0asm2451876b6e.17.2026.09.11.09.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 09:03:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL 01/10] target/hexagon: add the v75, v79 and v81 CPU models
Date: Fri, 11 Sep 2026 09:02:58 -0700
Message-Id: <20260911160307.865892-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911160307.865892-1-brian.cain@oss.qualcomm.com>
References: <20260911160307.865892-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIyNCBTYWx0ZWRfX+YCc9ac+5lIH
 qB/tp3k3oTyALGKgPuW+9WqcRHef3HDken+haK06BTHSmsOt2E3+4y5GYBqzVEag48GqSB9trYS
 lZ/qvcLeXMMHwElvaUALze3LRiR4uwPuQMPjw5rFs+hC3M/8qp3AKIqgkBiP8CoYs8b4+Rxxqzi
 yzGanEg9cp3UvVF6/XaO0x6qJ0IL2n4WtqtftKZ4ajaGM6zN4OABF/yjurVBnDEg/2N951U4/jQ
 dJ70XqzQ3koEHo1+7+FQX2P8Ba32zEPNVxU0a977zAhhPZwHtJf/wyxgalL9HRlKsrzRrxW8EQX
 l/7aRBnz7FWtNWA7xN/5dkaUTAJ/DotV+znPYl8pGPdYmWL4kzSLOsATKJXc7g0GiPdka/4UPQv
 d4sdDykgvLSYktBLKtrGI2TfTXNyLcER82Ypd00mTdLhxClt4pyO47fkMWF37UBFB4ceCCmdwcT
 r9082xFoWKTEYdW619w==
X-Proofpoint-ORIG-GUID: 6EoFRLPE6ULzBueFyXD_AaStCOay4pI1
X-Proofpoint-GUID: 6EoFRLPE6ULzBueFyXD_AaStCOay4pI1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIyNCBTYWx0ZWRfX9v/tdMhCr9aj
 yK79H4M8OAvscdS5lHfduJloTrEH+InMSGNzvH8EsToMpAZ6g9v6ShRImovqaCLaGwKvk7+gqdI
 Hjo7yUo/j8P+fh/WeZwBdsMvK0kINmc=
X-Authority-Analysis: v=2.4 cv=LrwHWXdc c=1 sm=1 tr=0 ts=6aa42665 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=sGg2OeOXg0vhTN0KIsEA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110224
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

djczIGlzIGN1cnJlbnRseSB0aGUgbmV3ZXN0IGNvcmUgdGhpcyB0YXJnZXQgaW1wbGVtZW50cy4K
CkFkZCB0aGUgdjc1LCB2NzksIHY4MSBDUFVzLiAgTmV3IGluc3RydWN0aW9ucyB0byBmb2xsb3cg
aW4gc3Vic2VxdWVudApjb21taXRzLgoKUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28u
bGllYmVsQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFu
LmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUtcW9tLmggICAg
IHwgNiArKysrKysKIGxpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMgfCA2ICsrKysrKwogdGFy
Z2V0L2hleGFnb24vY3B1LmMgICAgICAgICB8IDMgKysrCiAzIGZpbGVzIGNoYW5nZWQsIDE1IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUtcW9tLmggYi90YXJn
ZXQvaGV4YWdvbi9jcHUtcW9tLmgKaW5kZXggNmUxYmIwNDA3MDQuLjJiZmE0ZDVkMGZjIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUtcW9tLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1
LXFvbS5oCkBAIC0yNSw2ICsyNSw5IEBAIHR5cGVkZWYgZW51bSB7CiAgICAgSEVYX1ZFUl9WNjkg
PSAweDY5LAogICAgIEhFWF9WRVJfVjcxID0gMHg3MSwKICAgICBIRVhfVkVSX1Y3MyA9IDB4NzMs
CisgICAgSEVYX1ZFUl9WNzUgPSAweDc1LAorICAgIEhFWF9WRVJfVjc5ID0gMHg3OSwKKyAgICBI
RVhfVkVSX1Y4MSA9IDB4ODEsCiAgICAgSEVYX1ZFUl9BTlkgPSAweGZmLAogfSBIZXhhZ29uVmVy
c2lvbjsKIApAQCAtNDksNiArNTIsOSBAQCB0eXBlZGVmIHN0cnVjdCB7CiAjZGVmaW5lIFRZUEVf
SEVYQUdPTl9DUFVfVjY5IEhFWEFHT05fQ1BVX1RZUEVfTkFNRSgidjY5IikKICNkZWZpbmUgVFlQ
RV9IRVhBR09OX0NQVV9WNzEgSEVYQUdPTl9DUFVfVFlQRV9OQU1FKCJ2NzEiKQogI2RlZmluZSBU
WVBFX0hFWEFHT05fQ1BVX1Y3MyBIRVhBR09OX0NQVV9UWVBFX05BTUUoInY3MyIpCisjZGVmaW5l
IFRZUEVfSEVYQUdPTl9DUFVfVjc1IEhFWEFHT05fQ1BVX1RZUEVfTkFNRSgidjc1IikKKyNkZWZp
bmUgVFlQRV9IRVhBR09OX0NQVV9WNzkgSEVYQUdPTl9DUFVfVFlQRV9OQU1FKCJ2NzkiKQorI2Rl
ZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y4MSBIRVhBR09OX0NQVV9UWVBFX05BTUUoInY4MSIpCiAK
IE9CSkVDVF9ERUNMQVJFX0NQVV9UWVBFKEhleGFnb25DUFUsIEhleGFnb25DUFVDbGFzcywgSEVY
QUdPTl9DUFUpCiAKZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMgYi9s
aW51eC11c2VyL2hleGFnb24vZWxmbG9hZC5jCmluZGV4IDNkMTlhNzExZjg1Li40NDA1MzJlZTQx
MyAxMDA2NDQKLS0tIGEvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYworKysgYi9saW51eC11
c2VyL2hleGFnb24vZWxmbG9hZC5jCkBAIC05OCw2ICs5OCwxMiBAQCBjb25zdCBjaGFyICpnZXRf
ZWxmX2NwdV9tb2RlbCh1aW50MzJfdCBlZmxhZ3MpCiAgICAgICAgIHJldHVybiAidjcxIjsKICAg
ICBjYXNlIDB4NzM6CiAgICAgICAgIHJldHVybiAidjczIjsKKyAgICBjYXNlIDB4NzU6CisgICAg
ICAgIHJldHVybiAidjc1IjsKKyAgICBjYXNlIDB4Nzk6CisgICAgICAgIHJldHVybiAidjc5IjsK
KyAgICBjYXNlIDB4ODE6CisgICAgICAgIHJldHVybiAidjgxIjsKICAgICB9CiAKICAgICBlcnIg
PSBzbnByaW50ZihidWYsIHNpemVvZihidWYpLCAidW5rbm93biAoMHgleCkiLCBlZmxhZ3MpOwpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpp
bmRleCA0YTdiNzZlM2JjYy4uZmIwZTNjYWE0ODEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29u
L2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC04NzQsNiArODc0LDkgQEAgc3Rh
dGljIGNvbnN0IFR5cGVJbmZvIGhleGFnb25fY3B1X3R5cGVfaW5mb3NbXSA9IHsKICAgICBERUZJ
TkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjY5LCAgICAgICAgICAgICAgSEVYX1ZFUl9WNjkpLAog
ICAgIERFRklORV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WNzEsICAgICAgICAgICAgICBIRVhfVkVS
X1Y3MSksCiAgICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y3MywgICAgICAgICAgICAg
IEhFWF9WRVJfVjczKSwKKyAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjc1LCAgICAg
ICAgICAgICAgSEVYX1ZFUl9WNzUpLAorICAgIERFRklORV9DUFUoVFlQRV9IRVhBR09OX0NQVV9W
NzksICAgICAgICAgICAgICBIRVhfVkVSX1Y3OSksCisgICAgREVGSU5FX0NQVShUWVBFX0hFWEFH
T05fQ1BVX1Y4MSwgICAgICAgICAgICAgIEhFWF9WRVJfVjgxKSwKIH07CiAKIERFRklORV9UWVBF
UyhoZXhhZ29uX2NwdV90eXBlX2luZm9zKQotLSAKMi4zNC4xCgo=

