Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F9FCA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnqW-0007Zx-SW; Mon, 05 Oct 2026 14:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqJ-0007PK-73
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqG-0005i2-F3
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:18 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLwE32207551
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XGDP9JVYQqNgYiG5tPw7d5YJmd/2PKQhAeA4dW7IJNs=; b=BdL9Tediy//fdia7
 J8pXSB5wittppJpDda2fPr8qydB25cmViLwgIYri/OpfC7mEzqpEbdA9ePScOODi
 sisFPc9RlVWHDx4VMVhf7Yok6qT6iqVUlVSSWFRQyYXntzzW4kTgHtxHdVfIi2I3
 BBv5+73zsxmQJwpQkhS3qdEn5Gh1q0gDMun+2uAJZ08mObuR65J8fFFDh3Pv4195
 T2tPrkxv2rjshTjrC4swKXytGydtkxlzCd3O1fueU87sydD93fKDN+hzxB5KB2jg
 RnF06zVVnQHytGBOQCcSFIr9a9wLM0UI7r45iv3IMqO0ij2vo3IOO1MqwiPW9H7r
 z9hjBw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4a7dswvg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:15 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1438fef603cso4712829c88.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226514; x=1791831314; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XGDP9JVYQqNgYiG5tPw7d5YJmd/2PKQhAeA4dW7IJNs=;
 b=am+84Q58nx84agZwqmMflmrmoVfSPrqSxYREROu5Zaw89Q12WwWl6YLYwkO1S7P4vC
 xHHcku00cpWU5EXEkAOAbBZB1zex1DcuhfuHHkfsIdrsh6DxXG3w5lhm4+gbmWMuiz2F
 zvkjtH4gJ4I5z+sz3BqXedNyj1S6YpuKSwgfKIz1vaHi5Y1wzD3Fmt8Lv5FWGUX7j9/p
 BdwE4W/86IUMAyitScNAQkubq0USrRSNxKbgkK5KyagQhlVfyKxvo/IPBiuW8TSQ2s8L
 d5r9MEvMfYUpwaI12t128Ssjls2UiOxKBjm7pDLOoKrJxJ7t2DgkpIKj2avDfMvPpGST
 2Zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226514; x=1791831314;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XGDP9JVYQqNgYiG5tPw7d5YJmd/2PKQhAeA4dW7IJNs=;
 b=zWqTv42UJ+8vE3M7gIqOIxWSKmvNkgZU7Hlfw9JGiVOs2gEwr+QnvyO9Jx7JHYktv6
 G/7XaaCRPn83CDCp2yFN1T1S5KnlDMhp3BEb4QskOOS/WGGYV+xqDKXR4LZtBOctWKf7
 9yhdZju+OwkoJz7deiidGuuhRG+FYu3aFUs/uF58JhsQxlxUG2x+f/p4ni5dR5kpwfGp
 WnmP7BVPfxMePFQISFszboLdutLwlmKOcPRpz09b7WWiTgiFzmmECMNGx5RN1QXKDLH9
 nQihIyEogapWQMezMqzRSJXj2w9jn6WtBYEAy8SONjyx8UCoqODTjju66BB28Bol5cK0
 OjCQ==
X-Gm-Message-State: AFuF++mLxsF4q1nZKS8UQMLwTiemLe17eVeMVC/0Md4vRXLzTUJdXiDb
 fRFM4Lw+ORLlyo63+KLOHLAtjKPoO3h7/gUsHhZe7jsB/tkHmL7DPGlrXJXJxM15Pwyw8SB2PO6
 l2bPWj4cOUKSRPjRc0+HPlvJyrDjBq/Ng+TUzAsExZ/VxJhIj89ByCW6WZuP9kAL+nQ==
X-Gm-Gg: AYBFou3gyubYmdfyqJskQk+fINpljwygI7A9P213jbRzuwAZe6cHvf1SoV/FlGDdjR5
 4JxFHRDAuZ2IqOjoV+iW7ETsFcvSO93LcM6K/kqu+K/Ljva9CMqy4UYNlVdq4iy0QkK2leANUXB
 anNoEcpXsmZvrj7ndfi0trEl8c0L1HEfY6DO2YubRXwhJw7DFL+cZAAY7PlIMOWJvPpmzG+Slsq
 cuNmNfVLb9uYpQnV4FxmKQixRLE1vTA76cckdTAqMAkl6nzV87RMES2yrccMHFtCTOFL9aKGQh7
 y3KmhGBD5jQjVM5DbEofRq1zXwtCZPl9za7p/ApMcT59WfKeTdmGaVoOtnBvsKznqHZFobH/WUq
 kJPEC9mgYErl9gkVmbIML1I+jmotdzYmWCu4jlWtfNHNCM9tof0sjGJa4gA4K
X-Received: by 2002:a05:7022:107:b0:14e:9480:e5a4 with SMTP id
 a92af1059eb24-14f5c4ef00dmr22698187c88.23.1791226514431; 
 Mon, 05 Oct 2026 11:55:14 -0700 (PDT)
X-Received: by 2002:a05:7022:107:b0:14e:9480:e5a4 with SMTP id
 a92af1059eb24-14f5c4ef00dmr22698015c88.23.1791226512385; 
 Mon, 05 Oct 2026 11:55:12 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 02/22] meson.build: subdir system before finalizing stubs
 library
Date: Mon,  5 Oct 2026 11:54:38 -0700
Message-ID: <20261005185458.405929-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX3nYZkPTXpaur
 nAb0osJ1KZSN+H3vBgCfmIKdThVZeJV3Xs7BDqAwvO1LfpVhNgTPptU7Fp5trsWXbFgLs1tekjg
 o6fEQ0pqaKLrdoH1Nhq5pQ9xz6PIqGk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX1c90KVvv9YDQ
 iHUrmi2uuZLqUcOgIyoILS7H0R3gPp7nhct7eBS+ojYsum6xOkQB3VZWnVAhVeN606bHAMSspsF
 PYwv+aCUvoKfBujuVRRcrFioohex5abK00pX4BWiADX8vSXLh0uGfrXlWvQZFgEmpJ9brTYVswv
 RNnyCaUx6Rt4e0Cyzq3nc/FIffk5tgWsMc7gsNw8EumA6KuncLGcLEnFzAsVO8pZuP7VcZ7drf0
 t3XidKWweV4s2sFXGWoaLW2l36KjX+5P6RH9EFJrV2ZpoisV7X2MspKbpHxhElgo+iblRudcd08
 t9opJKBHaxr/MjYwy0cvQMgJFCgFEQfXBVk6zyDRK0mhtfVQGHM1D+P9/bxuZgXmH/TcZRe9rNd
 rUWZYaH9QPWI+2HIQzdihTrlkmhfFj2S8t/CMEvl19rmRkNXYTSNoCbAsfWk3RHpax5im2t9iIL
 0tSvKm+j0/K+kt41ZNA==
X-Proofpoint-GUID: CnwM8ScIMW8OIv__3gEfl-2WSelFvRsB
X-Authority-Analysis: v=2.4 cv=SvwFe/O0 c=1 sm=1 tr=0 ts=6ac3f293 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=mDV3o1hIAAAA:8 a=20KFwNOVAAAA:8
 a=aH2Df2vFxuOnz0hcSDoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: CnwM8ScIMW8OIv__3gEfl-2WSelFvRsB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050074
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

This allows to use stub mechanism for system/ files.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-3-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index cae1591cd28..0eddece72bd 100644
--- a/meson.build
+++ b/meson.build
@@ -3768,6 +3768,7 @@ subdir('ebpf')
 
 if have_system
   subdir('hw')
+  subdir('system')
 else
   subdir('hw/core')
 endif
@@ -3849,8 +3850,6 @@ common_ss.add(files('cpu-common.c'))
 user_ss.add(files('cpu-target.c'))
 system_ss.add(files('cpu-target.c'))
 
-subdir('system')
-
 # Work around a gcc bug/misfeature wherein constant propagation looks
 # through an alias:
 #   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99696
-- 
2.47.3


