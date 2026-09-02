Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C680AC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1cop-0000Kz-6I; Wed, 02 Sep 2026 00:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1con-0000K2-2a
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1col-0000Mv-Cx
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:24 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTGRY2468846
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kYrgAC0z2GRpON4Nk4P3dMDIJH7F2ulKL/BFNIuNltY=; b=ciHvri5/rijGDkBs
 75jeVtMPHdhf3r5n9zyw6hc5juGANcc2jGypJ12zlYOcmIapopD/UHYBSL0NvMK7
 MXrPLotHShx/VcoFVB3yUt6D6Dxvpol2XRCIi2yUcP8uJ2PLNJgUgB7yWifY9+RI
 afIsQQP45JOy9vma1U0VTjuvIkORVxGq0jnaFI1BmI0llT0zIty8pKQF0s274kuO
 vyqvk+MA3UQ7oiTgIOO/GHGyZd72Ezj46BWcM+yHozTBJ1XmtGI2LqbnJqQgozFk
 n7VhuBQgWVHA9Er1bbmrvzGtRrEM+BIBKixkaqXNcxqHNxzlJ7vM9+RRfgsgk7o4
 f2Z2CA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge39cj397-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:43:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-381250979d5so808860a91.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324191; x=1788928991; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kYrgAC0z2GRpON4Nk4P3dMDIJH7F2ulKL/BFNIuNltY=;
 b=Fgv5CvttETxU2yy5Ce4CUogXp+upf12LNIzUA6RY+V/6PqJpRs/Z0aSe5BrXNpeDcq
 GDKKQ9dt2QKKUGK7a6Kf3i96yr3XDgn80NYG8ABkeNj5g5yivq7YbsvQpEg6jJ3XUSNB
 eagRHbdjEmgdh0xFY75OMOik6NXm203MiaHRt0FECgeARRXFl/QopYofyw+ysAYQywHI
 LGKysMGF8epxNuJB9nnxOq2sgmp50x3ooz5lFrrThq2z+qDb0ibK6ZPWf82C2vcN5mFi
 2YUBJFDhsUHEoIv9Go81c4LpX6NN7bl6o90sKsANIQofv66z/S5OS0RfsQTHwPCPrgcd
 V1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324191; x=1788928991;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kYrgAC0z2GRpON4Nk4P3dMDIJH7F2ulKL/BFNIuNltY=;
 b=siatoDw3ghs/E52vKwQ5ePfZsc+3ndQoebRXCBwXFn5BoJX+aHrmA7YF17L5tx4QRE
 ehluR8e7udyzhkDG9AB1bo4wjuyR3bq92Sk1dV0JGO4lzqCvDIcShA5YBohNHc0tbs3T
 38f2c0omXXwG0WPTUF+MCsVgV3zK2GR4cJkQYP9tQauT9hOXi7z4AD8PauRzkwVil6H4
 Tv4tAdmm2xTQ/awlTYXd2ArBWCVCSH9qk1XfsJFPejsPhe3IkwtV1TiCEhpDeZ+WwlXP
 uvVc0rVnTmwZNN65pma0F/BNn9GKelD8qPJhd5yl8miZT2xUuqSPzYvoO1qG2gkiIAkO
 Jetw==
X-Gm-Message-State: AFuF++k3h2M9trC9yM/ANxPQ1BVOEKy2hlr9k7TxGkf+sr6dZd6l7aQ7
 kaBqDzgvaceHCxUWs50Su+hBBT/t4WwV2Sqs/+wCfy285qqCruayZRXNAtxjSWmyKe+LHUMRhSD
 w6p+zRhrvLKK2fJNzyWq8+9JYC36RPS29ketlI7j1ic9Lru1wlgRquq/8BE86ILm2uw==
X-Gm-Gg: AYBFou1b+l2HhJ8pNILxAwi4TtBkfcs6B/ZDBZ5Jy+nlmbo3vJ3185KAhyvDNOAI7Y3
 dXKQgC/IWdYaPqF7iEBd5SdWOIRv1l/kFN2IaHuNTaW/LAH0LbLCAhZzp9UlLadHzUVZ9JuIwmJ
 GtmjjX/fxwMJ6cQAPScg8VL9Bq9e0JbCmoMchnAuGkrC40MPceUckEq4R6aqyhARqQiedyaBvkG
 k0vKJdGq1fGH8+CZPW0MBsTr8Xmb0gYnU9naDBUO3zXHQodAuumKQrOAIynhf4aB/Dnmr4lOIc1
 BE4hdtW487Phhyxy8AefQ09UMD66IwfxxAc6dDd9SnyGPgG9++k5zKHA3L+kHP9T0lPLDebpE7E
 zUe+cIt7wKS2M5AzyqY8BCKyZZGN2d3fl1pfrPe8HFpnByqGU
X-Received: by 2002:a17:90b:2552:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-39aedec7bbbmr3284797a91.5.1788324190693; 
 Tue, 01 Sep 2026 21:43:10 -0700 (PDT)
X-Received: by 2002:a17:90b:2552:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-39aedec7bbbmr3284746a91.5.1788324190169; 
 Tue, 01 Sep 2026 21:43:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:43:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 18/28] target/hexagon: take BQL when reading the system pcycle
 count
Date: Tue,  1 Sep 2026 21:42:21 -0700
Message-Id: <20260902044231.843004-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=T968ifKQ c=1 sm=1 tr=0 ts=6a97a95f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=tKA3sQWDS_42iA0j-SoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: Gku368bjyGDkiFMdphIOMC-s1IkfS2Dc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX3mvPZq2Suj+F
 lMBMAYmxoGftgDyYeyTweoXTnT/FcqI5zKGrmHqLtug6o5NZMP8av8tWMtv2nlx4oMV92buBKZz
 T3MFQVFuVk2BJZ36xsOdUCX3PbfC4vk=
X-Proofpoint-GUID: Gku368bjyGDkiFMdphIOMC-s1IkfS2Dc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX/y/zW2iTn9MV
 nH6SMIQTTC/5ILd5ITZPmrWAaBMNix44u35sEHA3X1B71Cp6t4MaNRXT9Fyk5XQ0jsuHxilsc+1
 ony6lyGTAcZ8jjw7VconckQVitLFxuDXJd5X3zj+NM/GUyEaGTXv+cpela7zYc8UZ5VOee2zj2w
 KzDslKcQGNbOHYPZs49X0io9f4z/CGEu0PI8B5xRU3MTG5UxTPFZWlgOuVgjZfs4G8qy4BEq5gr
 g3tmXCcQiMkapKWWMk7dHa2BhrHDJaAoCwIId118Z8gwsXpjKfYvR+Z44xKBLYZBjVFbMM2uBML
 Yi7RVwKKHHBN5c+BD/SYnxQ3lrnZsk3EvOMJIE5XjNnU71QqCm9AWJwF4+XcNhlypaINrBF2oS8
 NMxDZs7/b7wsvD11/sjo8u0GJ5Y0de/YEnSrXYZPe/nmr8iv2x0u79ZIHVetTSXVB8uYtYQysKa
 xlvWzSB20tTr/jcoZtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020040
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

aGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudCgpIGl0ZXJhdGVzIGFsbCBDUFVzLCBzbyB0YWtl
IHRoZSBCUUwgd2l0aApCUUxfTE9DS19HVUFSRCgpIGluc3RlYWQgb2YgYXNzZXJ0aW5nIHRoZSBj
YWxsZXIgYWxyZWFkeSBob2xkcyBpdC4KQ29udmVydCB0aGUgbWF0Y2hpbmcgc2V0dGVycyB0aGUg
c2FtZSB3YXksIHdoaWNoIGtlZXBzIHRoZSBsb2NraW5nCmNvbnRyYWN0IHN5bW1ldHJpYyBhbmQg
bWFrZXMgdGhlIHJlYWQtbW9kaWZ5LXdyaXRlIGluIHRoZSBfbG93L19oaWdoCnNldHRlcnMgYXRv
bWljLiAgQlFMX0xPQ0tfR1VBUkQoKSBpcyBhIG5vLW9wIHdoZW4gdGhlIGxvY2sgaXMgYWxyZWFk
eQpoZWxkLCBzbyB0aGUgbmVzdGVkIGd1YXJkcyBvbiB0aGUgZ3Vlc3QtcmVnaXN0ZXIgcmVhZCBw
YXRoIGNvc3Qgbm90aGluZy4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmlj
ay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJy
aWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVy
LmMgfCAxMiArKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIGIv
dGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCmluZGV4IGZhYjlhOWQ3YjEyLi4xN2Q2YjRlYjJi
NCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL2NwdV9oZWxwZXIuYwpAQCAtMTM2LDcgKzEzNiw3IEBAIHVpbnQ2NF90IGhleGFnb25f
Z2V0X3N5c19wY3ljbGVfY291bnQoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgdWludDY0X3Qg
dG90YWwgPSAwOwogICAgIENQVVN0YXRlICpjczsKIAotICAgIGdfYXNzZXJ0KGJxbF9sb2NrZWQo
KSk7CisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKICAgICBDUFVfRk9SRUFDSChjcykgewogICAgICAg
ICBDUFVIZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYgPSBjcHVfZW52KGNzKTsKICAgICAgICAgdG90
YWwgKz0gdGhyZWFkX2Vudi0+dF9jeWNsZV9jb3VudDsKQEAgLTE1NCwxMSArMTU0LDE1IEBAIHVp
bnQzMl90IGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAq
ZW52KQogICAgIHJldHVybiAodWludDMyX3QpKGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnQo
ZW52KSk7CiB9CiAKKy8qCisgKiBFdmVyeSBmdW5jdGlvbiBpbiB0aGlzIGZhbWlseSB0YWtlcyB0
aGUgQlFMIGl0c2VsZiwgc28gdGhlIGd1YXJkIGJlbG93CisgKiBob2xkcyBpdCBhY3Jvc3MgdGhl
IHJlYWQtbW9kaWZ5LXdyaXRlLiAgTmVzdGVkIGd1YXJkcyBhcmUgbm8tb3BzLgorICovCiB2b2lk
IGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnRfaGlnaChDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgdmFsKQogewogICAgIHVpbnQ2NF90IG9sZDsKIAotICAgIGdfYXNzZXJ0KGJxbF9s
b2NrZWQoKSk7CisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKICAgICBvbGQgPSBoZXhhZ29uX2dldF9z
eXNfcGN5Y2xlX2NvdW50KGVudik7CiAgICAgb2xkID0gZGVwb3NpdDY0KG9sZCwgMzIsIDMyLCB2
YWwpOwogICAgIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnQoZW52LCBvbGQpOwpAQCAtMTY4
LDcgKzE3Miw3IEBAIHZvaWQgaGV4YWdvbl9zZXRfc3lzX3BjeWNsZV9jb3VudF9sb3coQ1BVSGV4
YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHZhbCkKIHsKICAgICB1aW50NjRfdCBvbGQ7CiAKLSAg
ICBnX2Fzc2VydChicWxfbG9ja2VkKCkpOworICAgIEJRTF9MT0NLX0dVQVJEKCk7CiAgICAgb2xk
ID0gaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudChlbnYpOwogICAgIG9sZCA9IGRlcG9zaXQ2
NChvbGQsIDAsIDMyLCB2YWwpOwogICAgIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnQoZW52
LCBvbGQpOwpAQCAtMTgxLDcgKzE4NSw3IEBAIHZvaWQgaGV4YWdvbl9zZXRfc3lzX3BjeWNsZV9j
b3VudChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDY0X3QgdmFsKQogICAgIGludCBudW1fdGhy
ZWFkczsKICAgICBpbnQ2NF90IGRlbHRhLCBwZXJfdGhyZWFkLCByZW1haW5kZXI7CiAKLSAgICBn
X2Fzc2VydChicWxfbG9ja2VkKCkpOworICAgIEJRTF9MT0NLX0dVQVJEKCk7CiAgICAgdG90YWwg
PSBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50KGVudik7CiAKICAgICAvKiBDb3VudCBhY3Rp
dmUgdGhyZWFkcyAqLwotLSAKMi4zNC4xCgo=

