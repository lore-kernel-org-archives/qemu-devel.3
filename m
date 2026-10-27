Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E58606A335
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gBr0gOGY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fIEdNFeE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiKc-00016W-9H; Tue, 27 Oct 2026 10:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiKK-0008O2-1N
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:39:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiKI-0006Bk-1Z
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:38:59 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoOJI2397342
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RDd+3W7W0y2S1eg7UzvigTldH4Gn2gC+LnwBE714ODw=; b=gBr0gOGYGKV5OWAB
 1UZJnfIkMwfxbK09WnLOapCdfbFCV9oEprMd/mJQGqs84RJwx2F8SCN1Ts/vKmS6
 3xyCka1duJ/QRlg+VS/hPKXREHjyQDjI45QT5gIqEwkq5aJFue0MiHP990tUvgL8
 7QDAhM5WQRrBB3ElTXD++blxtM3sU8HdoHcb9s2F5RqRP2u3y2peV+Qi07D2mzGI
 l1qAbUp9SwHuV6V3geaLrNG1vwrf+kvx9J2QF3KHXv2f5QXEruZ0hbv/5tkL3Kda
 g46MGXyXBNUfyAMQoqzi7Heb+7u+ieBc3HVG4rRtAxDG3HaStJU7y2UmBR61+zXD
 VDxOSQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjst1h3b0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:38:55 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cdac8b7169eso896508a12.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111935; x=1793716735; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RDd+3W7W0y2S1eg7UzvigTldH4Gn2gC+LnwBE714ODw=;
 b=fIEdNFeE8ScETx5TI94UV3Scd6ll5SFd/MgwimqJ5+SaE+oe55VommkJSHjBSUWgE4
 er9aAWBIFGJ0D6L37RKjbr0vmmhFu4KPh3fvwKgY2JKMFnhPZiNl684UDjUPqEgx8Oj/
 9sXOLtUjzGCgOZ4H/VrunuM1Suq9+5bC5D8NMxb0RjZpXDBX+48qjLf3ArF9JS6Upaea
 blnTy48lkjqhd6cznnIswEXjnvAeeh7vxX5z6LIKjztCwDRSB4emiJtyHgr+zPwNLXrF
 zOpLpm0Dj1ToeXGfK6iVb6yGUXeL+xAjYIBgSwODTo+RUrrIZXxAGAcRTFzmvGT7OWu7
 nEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111935; x=1793716735;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RDd+3W7W0y2S1eg7UzvigTldH4Gn2gC+LnwBE714ODw=;
 b=ziogPhEw0TTB7sBOVS04CGPxZ1VNLZ9ZOhEnInQMwWimyut60H4NtI+jXV+JLdxMk9
 PC8TQiYV40uEgNB1LwahGrqRcdfZBSJeIdkDUTQewt2ksHmU5Z8kgKGais2pKTzT9DZX
 Q9E9CiiYu9coawzd4zp5vzqVZhG94QIVSwc/8Ayj0P8lVv/lMbvmW1Dd6x+/XsgUrEgr
 cF66vkJW+uyWOsVEXnjeWncISZRPtxe8w78Scm1vLr37UJ9UysipAbkbgbYof+7+aVkD
 LhH6Qyrp0v4Zypfh96sw2wtbWVw/oarjD3R3tWQI6uNwpuLM7s3AxjVX2riYg5tQD3+Q
 xOAg==
X-Gm-Message-State: AFq9FYJZFV/17Fh2P041dIS0xv/eqYFeTBCL3dwqeShfnYOq6KMPz463
 izhlJ1JkptmItiYjbTnNlhLxPzofPpJXT01QeEYFGZzQ5mqs/PD34txY15pvt8PMzeSzQD6JoBa
 J6sY+kUsE7YMzkf1ZdvzbS2T3FXTtEKAU7w1bo5Tsbtq+x/JXRVBUMCwj8veoxA3/MA==
X-Gm-Gg: AYBFou2p1o6h1/KBmdSz/NJS0EPdIfUJjsR+u8V1Z3nd8FT4tl9tLzlbFWHB3DatevD
 Qwyyv9vp/Fz6IAMWUhdaaQylLwI1wrI3TTgnw6xExm8DMOHAbhYXGdUTBCIITObGotedB49EI5v
 qGfNDDX5GAGZOWWo5lHliliQLxPrp8+3RYSUX2rxpEVkP15Ci0sRCCh4NJ11Iolvvj68GGwoqs/
 jjmVJC7amxDmPIlJ5TJUGDQqwnMA+WRyLtlQATkI8YVuTSgzJuA2rH/gt8xfrXdohB/xHbU02Tv
 ZJ6JBJeU8m2uj+447ILftF54u5IM44pMtOUGNlPj6WCANs9VGfCddviaDRe7dEI/uqws2bZSklI
 dBHNSHoM7X1HApJUV0B+Rhj3LNULryezFGuCH43tEfVzQThI=
X-Received: by 2002:a17:90b:1f8f:b0:3ac:929e:691 with SMTP id
 98e67ed59e1d1-3adea895303mr7387499a91.17.1793111934700; 
 Tue, 27 Oct 2026 07:38:54 -0700 (PDT)
X-Received: by 2002:a17:90b:1f8f:b0:3ac:929e:691 with SMTP id
 98e67ed59e1d1-3adea895303mr7387484a91.17.1793111934253; 
 Tue, 27 Oct 2026 07:38:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404dde70sm4056102a91.1.2026.10.27.07.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:38:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 32/42] target/hexagon: acquire BQL before reading interrupt
 state
Date: Tue, 27 Oct 2026 07:37:11 -0700
Message-Id: <20261027143721.4125584-33-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=HJ1WhYtv c=1 sm=1 tr=0 ts=6ae0b77f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=52E-7OzoYlKJP0MoAcQA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: OzU_f3_RVQmV5Vf6ynObyhObllWhfR8L
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfXydCyfGQR+jXa
 SzR7+7GaGwKlqDft+eqSS2Jr++77vfG3V71VNU65Vfmt9j2dbRO1ZeJleEgbKbpCwr+nxZAjale
 Bhmdy4QZf4Pk0yrFirgV2pLw117V2F4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX1OD2XZ1JUN3M
 daQRNT3S66jIX5QCFDKyPPwN5+cLOmhj3MJJvYYjTVpJNy+RDFt5T8skv02/Xx3+wXEODPCT1a2
 uq+keP5EkdYkuxxSszhaA39xEQHQRvFCpTfXj6LFnSiYxw4LMxxUEkY946Sp9q+kBEPviuHyp89
 ZQK6Rp5sCmW0doLNOkHmu9uKbY+kpWQyG071DnUt6Z4E9zAGnsCJkLGBy8reC1vDWrXmcNOnCwi
 IQtDqrYIwoXU9V/IzK8a0kfbqy8A2U0f3ENu6lszTuXrILl+IRwpbj4VLTZLSHgtp68c/+3L3/S
 t/OWIcW9VzCoLPg69lghloofD9WGarkmC4rGcbnn9r3w+0axzcHXNnMGwR3QftBojxy4QrQBLNk
 1az0oj8UNaM8cMg7UOzooT9lf1iY+Xj5QNXr1VoU3+Tf45YOKlpUQxzS5OtXdbanVfZuHhzRuni
 b6CVu4g/5MTwsb+kd9w==
X-Proofpoint-GUID: OzU_f3_RVQmV5Vf6ynObyhObllWhfR8L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

TW92ZSBCUUxfTE9DS19HVUFSRCgpIHRvIHRoZSB0b3Agb2YgaGV4X2NoZWNrX2ludGVycnVwdHMu
CgpUaGVyZSB3YXMgYSByYWNlIHdpdGggaGV4X2ludGVycnVwdF91cGRhdGUgb24gb3RoZXIgdkNQ
VSB0aHJlYWRzIHdoZW4KZW5hYmxpbmcgTVRUQ0cuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFn
b24vaGV4X2ludGVycnVwdHMuYyB8IDggKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4
X2ludGVycnVwdHMuYyBiL3RhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMKaW5kZXggODFl
N2QwMTZjM2QuLmI1YTg3MmRiOTg5IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfaW50
ZXJydXB0cy5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMKQEAgLTM4OSwx
NyArMzg5LDE5IEBAIGJvb2wgaGV4X2NoZWNrX2ludGVycnVwdHMoQ1BVSGV4YWdvblN0YXRlICpl
bnYpCiB7CiAgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOwogICAgIGJvb2wgaW50X2hh
bmRsZWQgPSBmYWxzZTsKLSAgICBib29sIHNzcl9leCA9IGdldF9zc3JfZXgoZW52KTsKKyAgICBi
b29sIHNzcl9leDsKICAgICBpbnQgbWF4X2ludHMgPSAzMjsKICAgICBib29sIHNjaGVkY2ZnZW47
CiAKKyAgICBCUUxfTE9DS19HVUFSRCgpOworCisgICAgc3NyX2V4ID0gZ2V0X3Nzcl9leChlbnYp
OworCiAgICAgLyogRWFybHkgZXhpdCBpZiBub3RoaW5nIHBlbmRpbmcgKi8KICAgICBpZiAoZ2V0
X2lwZW5kKGVudikgPT0gMCkgewogICAgICAgICByZXN0b3JlX3N0YXRlKGVudiwgZmFsc2UpOwog
ICAgICAgICByZXR1cm4gZmFsc2U7CiAgICAgfQotCi0gICAgQlFMX0xPQ0tfR1VBUkQoKTsKICAg
ICAvKiBPbmx5IGNoZWNrIHByaW9yaXRpZXMgd2hlbiBzY2hlZGNmZ2VuIGlzIHNldCAqLwogICAg
IHNjaGVkY2ZnZW4gPSBnZXRfc2NoZWRjZmdlbihlbnYpOwogICAgIGZvciAoaW50IGkgPSAwOyBp
IDwgbWF4X2ludHM7IGkrKykgewotLSAKMi4zNC4xCgo=

