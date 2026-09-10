Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3D9C79FB7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 00:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4SrQ-0004HS-Jo; Wed, 09 Sep 2026 20:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x4SrO-0004Gg-Gt
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 20:41:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x4SrM-0003zX-Bz
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 20:41:50 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689M9d9k3261423
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 00:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yOv7bTp0OggmP+e1OEJv53iax3yHoe8chbEo9Zg3AwU=; b=AaGINywOMj2b6WPF
 9HSohJCIoBSrnm/IIsMHChKvq5lB8Z6gD7MVvOVoplUNgKvxYh0kgw7sgqzZ72yL
 B6LvcOO2MrXk78RwtCBr7FrgrYj1yrfMSp5kRiZ8vWlOR6Zp1KqnVEuquj9rjGPU
 VKsMIwEcqhBi0PQP/WNJc4nAU57nybgLu/AzVKe9zKjkzOihzI2V3HtIMyvG1aEg
 3jKW2tAkPVaSVQ8Yn+Lhc1ubUemIN0kYO8hCZNVWKAlJvoS8u9wFNLmWRY2BhiMj
 NzeoCSs2mU48ZXKN/UW+UGGWgIUs+lu1zj7XJKtsfCXcBn8tUGjZeuEI79cHex/a
 /rMZ0A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcygs88h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 00:41:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38f283baf1fso7901849a91.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 17:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789000905; x=1789605705; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yOv7bTp0OggmP+e1OEJv53iax3yHoe8chbEo9Zg3AwU=;
 b=fDSxgcUGDfRybUaq0kr5BsiSMPadWvdU72jY7CAcNkzYS7WgYPrulp5KIfJDyY1rCZ
 3Y1RyVLBl8a73Fe1yBE+NRQaEKqPFy5r6bkMGHOwafXXnJWMsj+9vCpFkBNgaqNtCCT4
 7LuBweZ1k0pEJY4rhEn2Z14LyhOjlOt9fTHMtfifMUu7BuM9iFKX86WVbaYsxCdKd4AQ
 7xvgRSrUh9nW9fsjbSqRK9BAp/cxjzbmRtBiTojbbx68+MSKf9hGCPjCDq0DDpDfCs6Y
 pk+koVYH/B3t7DHYaL2YTdqA+yU1Vs8sQ9p4FscUHEBd2xSL9dlqu5QfaKI+Mu8nyVjm
 1bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789000905; x=1789605705;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yOv7bTp0OggmP+e1OEJv53iax3yHoe8chbEo9Zg3AwU=;
 b=T8PkjWcFbNJmEHIUhCTS8sAOPhpbHbmO1VRU5DqqS0zV97jkG04R/JIL/cDykBTs4p
 hXIzYfCdTLiXj20kuJOF+1XsgpFStvIdW50VMX3jhpdj9MxVdUMtiHq89spIH0vg8VFn
 HhnCJg1amQGPxPS6NofE2kUf/dgXnf2iOcfpS8Rogup2NK3q3kVxRKE1fjC0k1CdAE9h
 WhLfYaW7WlNTX8w2C2RxX0t3Hd4CnX64V57qXIMZqR5E39jxa9EA+6b5E16mTkCX73Yk
 8tC3vXXMKGGC0MnOztt+XCWwkwNW7k9k8m0OVvfHKk2s7h6vqpOx/Rj17xLim/EVsFV2
 70LA==
X-Gm-Message-State: AFuF++kL4vYoSb2N06gk/2sj692A/24GezvxCUlRR5Ami9ZVywjlskRb
 l5OxcCwBcWL/6CJCL0JE2rECNF524c/bqVB1hTpnhjmn3hRDfcH5Ic0wvmkSxXU8qcsPrOR/xi4
 JuuMf1AK2Fzq36R0sBbsx/jm8sJskOBvXJfRYBoB/xmNciQM8kCaXpVql8/isCrFJFw==
X-Gm-Gg: AYBFou2l4+ymf+TMpFgERDkeucr81NDvgO0v/UOqfe5AC2BdDXpPwsthidMbzUHO0I8
 oNkpZmbytOR6iKr9Mf3mnPo560P6tCpgnvbEzJ0ocQlTesZP1yK17ZfDw9t2VnpnbsdlxrA3abA
 OZB2Dofu0Lqg9iG5Cb0Jul1Ijr/tT4wGZ0A7SxZO3HhK98V28VhzLph8hQUlMhqmFLitXkaxX9q
 KkWIzkYbvxb/XhGn81EVDI4Ps2CUrmxExldfd1+6tDTLUDG0qgYPtTXFZLtOTzV7FD9ZI/iuQwT
 enrxqzElOPXE3IzIY8MhRZUR8yP7kjeNSebmrWS2LMYYbfi593Oyis/+ds4+xQuptOhRkYJnF+C
 A2VAlGUhD4CfA4w07IVYZvXOQZyHwtSz9SiIP1b9/q1vGrjNZ
X-Received: by 2002:a17:90b:5287:b0:38e:6a44:671b with SMTP id
 98e67ed59e1d1-39b25eeeef9mr60427257a91.0.1789000904637; 
 Wed, 09 Sep 2026 17:41:44 -0700 (PDT)
X-Received: by 2002:a17:90b:5287:b0:38e:6a44:671b with SMTP id
 98e67ed59e1d1-39b25eeeef9mr60427202a91.0.1789000904062; 
 Wed, 09 Sep 2026 17:41:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-143240d86c3sm42891733c88.0.2026.09.09.17.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 17:41:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, marco.liebel@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 1/1] linux-user/hexagon: Add HWCAP support
Date: Wed,  9 Sep 2026 17:41:39 -0700
Message-Id: <20260910004139.606486-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910004139.606486-1-brian.cain@oss.qualcomm.com>
References: <20260910004139.606486-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDAwNSBTYWx0ZWRfX9HRuv8gmSUg7
 YBz6PAiO5tCdnyZOhL5zd+dn/GjhGV4fDTtH8uEZO3akQP6/jhCKGBKu2A7zAvHS0YSz31QuwKr
 i6XGdIGR9yuujUdG9pnOvePgLaEQMLI2g2DIaVFUn+abXDlIDt6b3z8NDIE5lH+y5Z29vVkEZt+
 /kXdDNKkiXS8xXBihSphqlNf7lBFS7GkuJWhDIsg22RFhnmvdp4pomZcxwLXd5Eg+XPabZFaymX
 h4KbMcmMvJwGIU3769rcDOhRbr5wlDR66OQsYkq+G88iRAWM5wuDMRer8l0/OJSZHNJufxMRLBa
 pIQOJ1D9G2zpeQuuUaaoh3iCF3kURMnYPs5MMg2veWADC6trCpebpceNj/LtGNW4gwPq0+ht9YW
 DedSOG1gQqh/xFeSzrFR3Zp8/YhvzHcZD6L3ttZWl/NGabUO200fE+jIfzxlVTmWd/PEa+HOy9U
 b/41oKsad09nWjvS6RQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDAwNSBTYWx0ZWRfX8XImTfq/3//f
 +M/LLtGVRsoczRr4oH4+r9UXhkBFGDjYzjVZSdXozs2GwCW4gAfH33LQmunuaefj/Y0nqmqB4V8
 uFHOx/Ho/9bvkKzO5mpBe16fcK4eaqU=
X-Proofpoint-ORIG-GUID: uZPRc2MrDuQWGnc9YCixam0nS3D2q0j_
X-Authority-Analysis: v=2.4 cv=VONIDNPX c=1 sm=1 tr=0 ts=6aa1fcc9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=P-QqBf7Oy_EXO6S6gpoA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: uZPRc2MrDuQWGnc9YCixam0nS3D2q0j_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-09_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100005
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

TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaGV4YWdvbi8yMDI2MDkxMDAwMzM0
Ni41OTY1OTMtMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20vClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBsaW51eC11c2VyL2hl
eGFnb24vdGFyZ2V0X2VsZi5oIHwgMzAgKysrKysrKysrKysrKysrKwogbGludXgtdXNlci9oZXhh
Z29uL2VsZmxvYWQuYyAgICB8IDYxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwog
MiBmaWxlcyBjaGFuZ2VkLCA5MSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvbGludXgtdXNl
ci9oZXhhZ29uL3RhcmdldF9lbGYuaCBiL2xpbnV4LXVzZXIvaGV4YWdvbi90YXJnZXRfZWxmLmgK
aW5kZXggZjgxYWUzODk1YTYuLjkwZTUwMzJkNWFhIDEwMDY0NAotLS0gYS9saW51eC11c2VyL2hl
eGFnb24vdGFyZ2V0X2VsZi5oCisrKyBiL2xpbnV4LXVzZXIvaGV4YWdvbi90YXJnZXRfZWxmLmgK
QEAgLTIxLDQgKzIxLDM0IEBACiAjZGVmaW5lIEVMRl9DTEFTUyAgICAgICAgICAgICAgIEVMRkNM
QVNTMzIKICNkZWZpbmUgRUxGX01BQ0hJTkUgICAgICAgICAgICAgRU1fSEVYQUdPTgogCisjZGVm
aW5lIEhBVkVfRUxGX0hXQ0FQICAgICAgICAgIDEKKworZW51bSB7CisgICAgSFdDQVBfSEVYQUdP
Tl9JU0FfTUFTSyAgICAgICAgICA9IDB4N0YsCisgICAgSFdDQVBfSEVYQUdPTl9JU0FfVjIgICAg
ICAgICAgICA9IDEsCisgICAgSFdDQVBfSEVYQUdPTl9JU0FfVjMgICAgICAgICAgICA9IDIsCisg
ICAgSFdDQVBfSEVYQUdPTl9JU0FfVjQgICAgICAgICAgICA9IDMsCisgICAgSFdDQVBfSEVYQUdP
Tl9JU0FfVjUgICAgICAgICAgICA9IDQsCisgICAgSFdDQVBfSEVYQUdPTl9JU0FfVjU1ICAgICAg
ICAgICA9IDUsCisgICAgSFdDQVBfSEVYQUdPTl9JU0FfVjYwICAgICAgICAgICA9IDYsCisgICAg
SFdDQVBfSEVYQUdPTl9JU0FfVjYyICAgICAgICAgICA9IDcsCisgICAgSFdDQVBfSEVYQUdPTl9J
U0FfVjY1ICAgICAgICAgICA9IDgsCisgICAgSFdDQVBfSEVYQUdPTl9JU0FfVjY2ICAgICAgICAg
ICA9IDksCisgICAgSFdDQVBfSEVYQUdPTl9JU0FfVjY3ICAgICAgICAgICA9IDEwLAorICAgIEhX
Q0FQX0hFWEFHT05fSVNBX1Y2OCAgICAgICAgICAgPSAxMSwKKyAgICBIV0NBUF9IRVhBR09OX0lT
QV9WNjkgICAgICAgICAgID0gMTIsCisgICAgSFdDQVBfSEVYQUdPTl9JU0FfVjcxICAgICAgICAg
ICA9IDEzLAorICAgIEhXQ0FQX0hFWEFHT05fSVNBX1Y3MyAgICAgICAgICAgPSAxNCwKKyAgICBI
V0NBUF9IRVhBR09OX0lTQV9WNzUgICAgICAgICAgID0gMTUsCisgICAgSFdDQVBfSEVYQUdPTl9J
U0FfVjc3ICAgICAgICAgICA9IDE2LAorICAgIEhXQ0FQX0hFWEFHT05fSVNBX1Y3OSAgICAgICAg
ICAgPSAxNywKKyAgICBIV0NBUF9IRVhBR09OX0lTQV9WODEgICAgICAgICAgID0gMTgsCisgICAg
SFdDQVBfSEVYQUdPTl9IVlggICAgICAgICAgICAgICA9IDEgPDwgNywKKyAgICBIV0NBUF9IRVhB
R09OX0NBQkFDICAgICAgICAgICAgID0gMSA8PCA4LAorICAgIEhXQ0FQX0hFWEFHT05fSFZYX0xF
TkdUSF8xMjhCICAgPSAxIDw8IDksCisgICAgSFdDQVBfSEVYQUdPTl9IVlhfSUVFRV9GUCAgICAg
ICA9IDEgPDwgMTAsCisgICAgSFdDQVBfSEVYQUdPTl9BVURJTyAgICAgICAgICAgICA9IDEgPDwg
MTEsCisgICAgSFdDQVBfSEVYQUdPTl9ITVggICAgICAgICAgICAgICA9IDEgPDwgMTIsCit9Owor
CiAjZW5kaWYKZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMgYi9saW51
eC11c2VyL2hleGFnb24vZWxmbG9hZC5jCmluZGV4IDM5YjAyMDE4MTQ1Li4zZDE5YTcxMWY4NSAx
MDA2NDQKLS0tIGEvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYworKysgYi9saW51eC11c2Vy
L2hleGFnb24vZWxmbG9hZC5jCkBAIC0zLDggKzMsNjkgQEAKICNpbmNsdWRlICJxZW11L29zZGVw
LmgiCiAjaW5jbHVkZSAicWVtdS5oIgogI2luY2x1ZGUgImxvYWRlci5oIgorI2luY2x1ZGUgInRh
cmdldF9lbGYuaCIKKyNpbmNsdWRlICJ0YXJnZXQvaGV4YWdvbi9jcHUuaCIKIAogCithYmlfdWxv
bmcgZ2V0X2VsZl9od2NhcChDUFVTdGF0ZSAqY3MpCit7CisgICAgSGV4YWdvbkNQVUNsYXNzICpt
Y2MgPSBIRVhBR09OX0NQVV9HRVRfQ0xBU1MoY3MpOworICAgIGFiaV91bG9uZyBod2NhcHM7Cisg
ICAgdWludDMyX3QgaGV4X3ZlcjsKKworICAgIGlmICghbWNjLT5oZXhfZGVmKSB7CisgICAgICAg
IHJldHVybiAwOworICAgIH0KKworICAgIGhleF92ZXIgPSBtY2MtPmhleF9kZWYtPmhleF92ZXJz
aW9uOworICAgIHN3aXRjaCAoaGV4X3ZlcikgeworICAgIGNhc2UgSEVYX1ZFUl9WNToKKyAgICAg
ICAgaHdjYXBzID0gSFdDQVBfSEVYQUdPTl9JU0FfVjU7CisgICAgICAgIGJyZWFrOworICAgIGNh
c2UgSEVYX1ZFUl9WNTU6CisgICAgICAgIGh3Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNBX1Y1NTsK
KyAgICAgICAgYnJlYWs7CisgICAgY2FzZSBIRVhfVkVSX1Y2MDoKKyAgICBjYXNlIEhFWF9WRVJf
VjYxOgorICAgICAgICBod2NhcHMgPSBIV0NBUF9IRVhBR09OX0lTQV9WNjA7CisgICAgICAgIGJy
ZWFrOworICAgIGNhc2UgSEVYX1ZFUl9WNjI6CisgICAgICAgIGh3Y2FwcyA9IEhXQ0FQX0hFWEFH
T05fSVNBX1Y2MjsKKyAgICAgICAgYnJlYWs7CisgICAgY2FzZSBIRVhfVkVSX1Y2NToKKyAgICAg
ICAgaHdjYXBzID0gSFdDQVBfSEVYQUdPTl9JU0FfVjY1OworICAgICAgICBicmVhazsKKyAgICBj
YXNlIEhFWF9WRVJfVjY2OgorICAgICAgICBod2NhcHMgPSBIV0NBUF9IRVhBR09OX0lTQV9WNjY7
CisgICAgICAgIGJyZWFrOworICAgIGNhc2UgSEVYX1ZFUl9WNjc6CisgICAgICAgIGh3Y2FwcyA9
IEhXQ0FQX0hFWEFHT05fSVNBX1Y2NzsKKyAgICAgICAgYnJlYWs7CisgICAgY2FzZSBIRVhfVkVS
X1Y2ODoKKyAgICAgICAgaHdjYXBzID0gSFdDQVBfSEVYQUdPTl9JU0FfVjY4OworICAgICAgICBi
cmVhazsKKyAgICBjYXNlIEhFWF9WRVJfVjY5OgorICAgICAgICBod2NhcHMgPSBIV0NBUF9IRVhB
R09OX0lTQV9WNjk7CisgICAgICAgIGJyZWFrOworICAgIGNhc2UgSEVYX1ZFUl9WNzE6CisgICAg
ICAgIGh3Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNBX1Y3MTsKKyAgICAgICAgYnJlYWs7CisgICAg
Y2FzZSBIRVhfVkVSX1Y3MzoKKyAgICAgICAgaHdjYXBzID0gSFdDQVBfSEVYQUdPTl9JU0FfVjcz
OworICAgICAgICBicmVhazsKKyAgICBkZWZhdWx0OgorICAgICAgICByZXR1cm4gMDsKKyAgICB9
CisKKyAgICBod2NhcHMgfD0gSFdDQVBfSEVYQUdPTl9IVlg7CisgICAgaHdjYXBzIHw9IEhXQ0FQ
X0hFWEFHT05fSFZYX0xFTkdUSF8xMjhCOworICAgIGlmIChoZXhfdmVyID49IEhFWF9WRVJfVjY4
KSB7CisgICAgICAgIGh3Y2FwcyB8PSBIV0NBUF9IRVhBR09OX0hWWF9JRUVFX0ZQOworICAgIH0K
KworICAgIHJldHVybiBod2NhcHM7Cit9CisKIGNvbnN0IGNoYXIgKmdldF9lbGZfY3B1X21vZGVs
KHVpbnQzMl90IGVmbGFncykKIHsKICAgICBzdGF0aWMgY2hhciBidWZbMzJdOwotLSAKMi4zNC4x
Cgo=

