Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EA1C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1coe-0000Em-EO; Wed, 02 Sep 2026 00:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coc-0000EU-Oe
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coa-0000Ll-QQ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTLDL2468908
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=PQ16nUwPIDbGgXKH6tg88QaIBf0q5nzzNEMoDUMS1DI=; b=Co
 ADXd0yMX9x5cCOSYWZQtAe5KdUD5LVOpfMxNmqnWRGEVKgJLujlYVRxiSBXKdOsA
 5nALE9EfH8M/Mnt6/y0jTQ5eHDts9Q0OwkjVHsmw5DwkvrSn+IYofIGTaQJ0VovR
 1NwhWBlZNGYdLS8pb/OVPWv+1ymLVOB/Rubmby6sMYw+hag6bQLnQdvD46Z7BWR4
 92MMM+7ebJnnm54moKbT6bz4SHcZWJPreZEPR3r4nDhtLzL/3h84fAJ+Rz4sQjvD
 oSmzfbJ9Mfb2fEaZmrWfv05X1RfdygcgcrhW08ac46sNrwVs0G5ouPnV3aJe9+Ya
 +ywpMg1kCmu2oB/6jGvQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge39cj388-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:43:01 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbedb8673ceso616056a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324181; x=1788928981; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PQ16nUwPIDbGgXKH6tg88QaIBf0q5nzzNEMoDUMS1DI=;
 b=bgDM+wGZBhl72H6fl5xLUFHE5kraRcoYNWCCK97PXx4Tg8i0v3PY5+mX5oBPqq0ZOh
 e4ZJn4vKl3JQYsQcZ8xn2pWL+uKXJa1qHxyllHVyK44gsfOSZsQTmFLVIiT4AlI/Rnju
 YaHCq8tX/gN8TUxiClfvinx10CR3BbHa/yT7XcG+1Qd2fBLkM9TJ3/xSAy9dxzSdal4S
 Qp2szRu5ZXWvjknN+vKPdvjOQaLFR4YvtUe3BLMrjq7BrCuPvvUqeoyavRUpf8tovvZ6
 TGZZbo/QLcxPjaVTGOX56WMmKReFLGwiwX3Wy7pcKbZtLDGnheblIsWqdzGQqFMOCDL+
 CR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324181; x=1788928981;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PQ16nUwPIDbGgXKH6tg88QaIBf0q5nzzNEMoDUMS1DI=;
 b=ez2dmee6Y3GbN6dtORYK7H+gGhYttyAdNQ4+iVE3R+VxRCiCQi0Fz09r68zYJcS6lm
 XsXLxP/hRoTzOoliuI7IA1IUuHQUOeaxH9d2yXgNmsZuGoWkXDMVE5PFgfnNoN4JzoeO
 7AfIkfCPVVncx/hENE/M/4wrgRLEaMCfLZGlWQcLrZf50KRgKlLhKWsdt3NTqeMT3Bco
 P2DFu+2saY3+BpRU2N9dGnVDPn/fz3OGgQXEoL+BQQqYqxvW7eoETlSrGTUJ63+NAMwt
 ULxeOVf28eS29yEuFQmgVMnfffCaHD69FSI9/RtcpPLYsaQ6bi0vSNvPaq5oG2EzyJUi
 nVXw==
X-Gm-Message-State: AFuF++nAqzXMvh8bBuTdXm1bxPYxxqnTshPmQap/JF7DZSXGP3swG+FV
 MFH2rh5vqagb1cjvKUZ8WXDzp4Mdr4rBJbThdi0L+NBpvmHVLUbYspyNKpEJxXV463CGwLDa08G
 B97yUx+TGSTYO1YcDk1JGaBuIXV0YybVa7PLndT13alVu+36sbLrPPCWh5iTkgwKBbA==
X-Gm-Gg: AR+sD12IpbWPMus499HErIm73Ncpg1nk4kO1Sx0dKavy8dmp4qQZKpMVCXuTxtEH+m+
 dq9UzZwQmueKHlU27XjrAJXcFUgXzX6nu+e6f0NYqzDmYBUNaBL96CIu2EQwrjfBpUFBZrSvYV6
 uqg1ckG4IdqIkhm3n4AIjr7LgR258a1NJprVSBBlUhRcJqj3XhIGQ7MB5OuNdmhZb9QQcdkL0Ig
 i0MdXzYZTP23xOlpkIqt2QrNqGaahwbidPeJIF8F7scE60Vsxk1OUQ2KBcUmSJyqeC3EuGsMiPr
 VlJ4i+MDJ1C/cWtx7kFGvLvSiyIZhKH8sOlMFnmTVwfrZUf0eHRNKnOlD1UjnUTW+paR6FUZPiw
 ef+Us2myE+3A1VuAzoVzR1kY7SncOfTXzdE3MnySWeL5B/ulm
X-Received: by 2002:a05:6a21:a512:b0:3d7:dfbf:7435 with SMTP id
 adf61e73a8af0-3d9b0a3a1ecmr3156088637.25.1788324180528; 
 Tue, 01 Sep 2026 21:43:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:a512:b0:3d7:dfbf:7435 with SMTP id
 adf61e73a8af0-3d9b0a3a1ecmr3155890637.25.1788324178774; 
 Tue, 01 Sep 2026 21:42:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:42:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PULL 12/28] python/machine: support routing semihosting output to
 the test console
Date: Tue,  1 Sep 2026 21:42:15 -0700
Message-Id: <20260902044231.843004-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=T968ifKQ c=1 sm=1 tr=0 ts=6a97a955 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Z4HElfRGeH4uGo3IGfcA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: k1zFXdLeaReUpnJ8By1_PUvw_mtV9ZS8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfXy7D8omLHHUlO
 N2MQF0t+rv+ikT2zaUBoaCu4NVzzPyD42FzMnItzGBodY/CPNGdQOe+5YofzsbBQ3TjrEpMMccT
 d9A29a01Irkb2jFDs9125IA6IR3KSQI=
X-Proofpoint-GUID: k1zFXdLeaReUpnJ8By1_PUvw_mtV9ZS8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX/r04MP6vepjL
 1/xxU4M2FQ4MMKY1XpnjMX1VSzAF/tNY0Xoyn4YxKgZsDa0MBvJ8jfPokp37DteJlcc7BAf+g3a
 zbxpu3CDQDQnqi14bgv1g4qcQ2kfTFdm3ioGX412zFPFH2CABt75XOenw1o0K/d0V/2B5qmPGYi
 3Za1g5r+3UWp2wX/+cGg7p31ibOKmeKlJ2tZUeeRRzbcKpcbktXTySatss2i54HxEvGMpKAZ0hm
 u6rkaQz5sgxqsFbjCSjXWiT/Slvp4/D/be488inZHjrDdtJOu+EsCYlE9dnWVLgD0v871bsxuuR
 q14CUj1zRuvHw5qCu7GpUgyrGZ2kz5jPRazrLuAgBqJ3asQqNQGjL/XC++lIYMVqseEnH3yWej9
 HnN6C+Y3YR09uck+Hk5LFwX13M3CigEYT/vxkYeO0Xopk+geMd/bODffQW0Hb5W35zjgTT4sTBo
 /rpO2Bpsoh3hP6f68cw==
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

VGhlIGhleGFnb24gc2VtaWhvc3Rpbmcgc3lzdGVzdHMgd2lsbCB3YWl0IGZvciBvdXRwdXQgb24g
dGhlIHNlbWlob3N0aW5nCmNvbnNvbGUuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8
cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBNYXRoZXVz
IFRhdmFyZXMgQmVybmFyZGlubyA8bWF0aGV1cy5iZXJuYXJkaW5vQG9zcy5xdWFsY29tbS5jb20+
ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29t
bS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbT4KLS0tCiBweXRob24vcWVtdS9tYWNoaW5lL21hY2hpbmUucHkgfCAxMCArKysrKysrKy0t
CiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3B5dGhvbi9xZW11L21hY2hpbmUvbWFjaGluZS5weSBiL3B5dGhvbi9xZW11L21hY2hp
bmUvbWFjaGluZS5weQppbmRleCBiZmI1OWQ0YzBiZi4uMzkzNzUwNjU1NTggMTAwNjQ0Ci0tLSBh
L3B5dGhvbi9xZW11L21hY2hpbmUvbWFjaGluZS5weQorKysgYi9weXRob24vcWVtdS9tYWNoaW5l
L21hY2hpbmUucHkKQEAgLTE4Niw2ICsxODYsNyBAQCBkZWYgX19pbml0X18oc2VsZiwKICAgICAg
ICAgc2VsZi5fY29uc29sZV9pbmRleCA9IDAKICAgICAgICAgc2VsZi5fY29uc29sZV9zZXQgPSBG
YWxzZQogICAgICAgICBzZWxmLl9jb25zb2xlX2RldmljZV90eXBlOiBPcHRpb25hbFtzdHJdID0g
Tm9uZQorICAgICAgICBzZWxmLl9jb25zb2xlX3NlbWlob3N0aW5nID0gRmFsc2UKICAgICAgICAg
c2VsZi5fY29uc29sZV9zb2NrZXQ6IE9wdGlvbmFsW3NvY2tldC5zb2NrZXRdID0gTm9uZQogICAg
ICAgICBzZWxmLl9jb25zb2xlX2ZpbGU6IE9wdGlvbmFsW3NvY2tldC5Tb2NrZXRJT10gPSBOb25l
CiAgICAgICAgIHNlbGYuX3JlbW92ZV9maWxlczogTGlzdFtzdHJdID0gW10KQEAgLTMyMSw3ICsz
MjIsMTAgQEAgZGVmIF9jb25zb2xlX2FyZ3Moc2VsZiwgaW50ZXJhY3RpdmU6IGJvb2wgPSBGYWxz
ZSkgLT4gTGlzdFtzdHJdOgogICAgICAgICAgICAgZmQgPSBzZWxmLl9jb25zX3NvY2tfcGFpclsw
XS5maWxlbm8oKQogICAgICAgICAgICAgY2hhcmRldiA9IGYic29ja2V0LGlkPWNvbnNvbGUsZmQ9
e2ZkfSIKICAgICAgICAgICAgIGFyZ3MuZXh0ZW5kKFsnLWNoYXJkZXYnLCBjaGFyZGV2XSkKLSAg
ICAgICAgICAgIGlmIHNlbGYuX2NvbnNvbGVfZGV2aWNlX3R5cGUgaXMgTm9uZToKKyAgICAgICAg
ICAgIGlmIHNlbGYuX2NvbnNvbGVfc2VtaWhvc3Rpbmc6CisgICAgICAgICAgICAgICAgYXJncy5l
eHRlbmQoWyctc2VtaWhvc3RpbmctY29uZmlnJywKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgJ2VuYWJsZT1vbixjaGFyZGV2PWNvbnNvbGUnXSkKKyAgICAgICAgICAgIGVsaWYgc2VsZi5f
Y29uc29sZV9kZXZpY2VfdHlwZSBpcyBOb25lOgogICAgICAgICAgICAgICAgIGFyZ3MuZXh0ZW5k
KFsnLXNlcmlhbCcsICdjaGFyZGV2OmNvbnNvbGUnXSkKICAgICAgICAgICAgIGVsc2U6CiAgICAg
ICAgICAgICAgICAgZGV2aWNlID0gJyVzLGNoYXJkZXY9Y29uc29sZScgJSBzZWxmLl9jb25zb2xl
X2RldmljZV90eXBlCkBAIC04OTIsNyArODk2LDggQEAgZGVmIHNldF9tYWNoaW5lKHNlbGYsIG1h
Y2hpbmVfdHlwZTogc3RyKSAtPiBOb25lOgogCiAgICAgZGVmIHNldF9jb25zb2xlKHNlbGYsCiAg
ICAgICAgICAgICAgICAgICAgIGRldmljZV90eXBlOiBPcHRpb25hbFtzdHJdID0gTm9uZSwKLSAg
ICAgICAgICAgICAgICAgICAgY29uc29sZV9pbmRleDogaW50ID0gMCkgLT4gTm9uZToKKyAgICAg
ICAgICAgICAgICAgICAgY29uc29sZV9pbmRleDogaW50ID0gMCwKKyAgICAgICAgICAgICAgICAg
ICAgc2VtaWhvc3Rpbmc6IGJvb2wgPSBGYWxzZSkgLT4gTm9uZToKICAgICAgICAgIiIiCiAgICAg
ICAgIFNldHMgdGhlIGRldmljZSB0eXBlIGZvciBhIGNvbnNvbGUgZGV2aWNlCiAKQEAgLTkyMSw2
ICs5MjYsNyBAQCBkZWYgc2V0X2NvbnNvbGUoc2VsZiwKICAgICAgICAgc2VsZi5fY29uc29sZV9z
ZXQgPSBUcnVlCiAgICAgICAgIHNlbGYuX2NvbnNvbGVfZGV2aWNlX3R5cGUgPSBkZXZpY2VfdHlw
ZQogICAgICAgICBzZWxmLl9jb25zb2xlX2luZGV4ID0gY29uc29sZV9pbmRleAorICAgICAgICBz
ZWxmLl9jb25zb2xlX3NlbWlob3N0aW5nID0gc2VtaWhvc3RpbmcKIAogICAgIEBwcm9wZXJ0eQog
ICAgIGRlZiBjb25zb2xlX3NvY2tldChzZWxmKSAtPiBzb2NrZXQuc29ja2V0OgotLSAKMi4zNC4x
Cgo=

