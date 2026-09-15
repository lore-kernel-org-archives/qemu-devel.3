Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD62C982C3
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6UZu-0003tf-QG; Tue, 15 Sep 2026 10:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6UZs-0003tD-VS
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 10:56:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6UZr-0005rq-Fy
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 10:56:08 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FCxqWP154559
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 14:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OQ5RaKyuEciAXfaMVoDzP/XmPFNA4e6v5saZuF89tis=; b=PYd9AUMxW++JYBul
 Bwkr0o5/Pu8Kx0gQ8Hrp1OUXQp51TgcWgKWWPUE/SpZdR1jwoj4SHaShpZyEx2Iy
 iEDzKXJPTt+QDOLOSC8trsE0xM8fXzdC3zYW1dOy6CbD6+YqtXHU+W2nX+Ux8F/l
 ITq6dE2/1Ch4rdCZpzkr0qhrIa2cxAaPVdLskDlIoi9jo2T5/A/scHHjdLHeGmwj
 HI15bliI0FF6zQDBaFld5yWtj1A04cD7dsi8YhUEuUYcaFulCzgoUlDJtwO8brbR
 sZ7gxpRQtBK2WeI2bgFrpv1yVg6JSifnsYOC285BaFehk7DKXc/Pg1O0mmaZ6V7S
 fjlqMg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq0jet855-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 14:56:06 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-869b8d63e28so5627920b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789484165; x=1790088965; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OQ5RaKyuEciAXfaMVoDzP/XmPFNA4e6v5saZuF89tis=;
 b=fGWSAWeEYXRdq4IKzPTz3xEfR3ISgm4EUH9uQVsz9vywkNZunHV9u3OpXbmQW2cDSn
 0xairT2Jr9CxDo5ES82WY2GaMXcFNvDFpXVnED9cFg5M0m5BCbRhykGnpfZoG+mNwdmg
 LEf17pzSZCOcvE2V6xxzi2SPkIc3QbOxqClHNd/2paMjQSg/0hW2oYu67wMFCUj7yj69
 cphNRmG6dadVdIxhjHS84tGDzexDPxLlP7ZSG7XNRgvYiBzESTlzDMJKFxZfs6NSuBsd
 RcIWpdpy7CKOS9iwmPoM0XRcIp5FcIqEaJ5Z5OXTZCKhxydLsWaRDC2mtreqtRCH9Jf5
 BOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789484165; x=1790088965;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OQ5RaKyuEciAXfaMVoDzP/XmPFNA4e6v5saZuF89tis=;
 b=WXze3H+HVpbfenilO8A760HDlUkDPM6hz9ZqVj8XpRmjSZDkPdmiFANNOL/BedvVYh
 Icwxq4yuwTNqlf7TFPMNb3HmJJzC7X6mLrLYeQNGT3FmugsMvfiTIcZLqBAMhD0unvSd
 a0zqlSWUZI+o74Jj9MZcAvjvIFoSAawPwGRXUal0OXF9s20miw+lvmxTJthslom136Jy
 2gwGFIaVHuE3/VyMtNYjUjCMDW4IWWy0fOLkk8L0QuYYnC09bAJ+FF1zvSHfdhiL8oov
 GzuIBW6MV87B0f2f+OUT/hw5oMEMK2Uun6Rfwb3Mn03mmTPHmVJNw5qL+S6pj+c7QTBq
 Wi+A==
X-Gm-Message-State: AFuF++luqYOZNPj+4/0cUJcIxrv5YwrAcFMM2dZ603QRtJaML06mCmJs
 99sSA3QUhr/NQcE3fewKxNjT8cqVi/TrJnZndXMeIt9MBOhMEV6kohahqlqq5WxSTS6VyL+l8u/
 iKC3yL15ZEM0/HFErhJjVR/RaFzL7kjYX3xlDGq5MFF896aQd1lKrpM2nDakDqnyvHg==
X-Gm-Gg: AYBFou2CtToMStJ58tbRqSIZ+CyHfam3p8DEvJDlghpIa+M4eN4iJz4y9Tyib0pHotk
 fJfzmTvA12AZonfztcAsa4SglSm1PaMHeT+UYedtWTZeAqJmym4yFCPhya1ctKi8rkSjBtModsD
 RuVLUPvATQrrE1bPVs7z7DbYd0BfqX69jBUUkK5lRg4dOYonYzUbFus/rU6ZNEbAXhCIUHihJPE
 lt8e1ZPa0sOqmrDAgaje9UaiA11VKqqUujGf7/2UjlFQyTdC4/u0hvNvSv5lAXU//rgetkzFM1R
 WnPHo9cRP+ymErW2jBh36LcIOE6ieuenopZy+vys4rvMUyKqXmPcLWufab3/DjlvoJPPxVuqPVR
 BO77NnSA09pHiCsyoG/V8zCjT0wobjIgKxQRVUaN8D7wHQ8OP
X-Received: by 2002:a05:6a00:c2d4:10b0:870:c2db:da40 with SMTP id
 d2e1a72fcca58-870c2dbdf90mr5065512b3a.24.1789484165578; 
 Tue, 15 Sep 2026 07:56:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:c2d4:10b0:870:c2db:da40 with SMTP id
 d2e1a72fcca58-870c2dbdf90mr5065471b3a.24.1789484165059; 
 Tue, 15 Sep 2026 07:56:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b287c2775sm6310860b3a.9.2026.09.15.07.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 07:56:04 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v5 6/6] tests/functional/hexagon: add HVX tests
Date: Tue, 15 Sep 2026 07:55:41 -0700
Message-Id: <20260915145541.4038637-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915145541.4038637-1-brian.cain@oss.qualcomm.com>
References: <20260915145541.4038637-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIxNyBTYWx0ZWRfX1RoIHKYC68uD
 CHVCMsSNBaoV3jAsZu4eEDMruYOWXQWmNH6I9e5UH0Fj4hIHQcMxy3S1j259tqdxwtx7Pw8my1h
 E7b+au4lYBPqNG43lyLLU3qOspGjtH0=
X-Authority-Analysis: v=2.4 cv=Kr/YSmWN c=1 sm=1 tr=0 ts=6aa95c86 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=eq6FigJt9aAjue5lDr8A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: GHfsWxTWQr9SQ4d3zBwM3L2A7l-WN8tX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIxNyBTYWx0ZWRfX3P+Iwm6AiQ6+
 Lr3Ez4/KY1EdzV/cNUr5TGYorZ1D84Szd8WYRqoFSUCW38KQtUmYnEc/UtAyt7Yx6M9f0pAvW6Y
 D3eEMkN9wEKMUx2S5p8gkXDmY5u0p77Ld8kUTY8iUKmhNArotQze69GAj8YBEDJ30m1Q+ZsMFEL
 oI19I7ZfsJt+uJlIaJjTy8hPoYFTTqpw+5Z8EAOsbj9aEgmQI37hGkWoQ7P2umD0HDQ0avqJ456
 nSmYDCUFjSOvFd35H26yccfEfvlv7MIOmwxS7ChW08T4y1mX5db9/eq2GuYm02oKGjuYqFeImmb
 Q5nlWVdYkazEUMDoBhThD12WOO8PeH7LRaD7SvSKzCfkaP1N+2wEbcPp/AowUPt8/5JPLoiGKC4
 DCg4V30jPGlfI4KVAnlBuoHY2n3VRhHZNxIPp7WYaAYJ29w4uZh9qjzTQ0Pe6OEdOK9g/1CGWkF
 /ED58ypca+hZNsd5GnQ==
X-Proofpoint-ORIG-GUID: GHfsWxTWQr9SQ4d3zBwM3L2A7l-WN8tX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150217
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

VGhlc2UgdGVzdHMgcGFzcyBub3cgdGhhdCBIVlggaXMgbW9kZWxlZCBmb3Igc3lzdGVtIGVtdWxh
dGlvbi4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9z
cy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rl
c3RzLnB5IHwgNyArKysrKysrCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0
cy5weSAgIHwgNiArKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgYi90
ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5CmluZGV4IDQwZjc2ZTI1
YWU2Li4yOGJmMmYwMmQzOSAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rl
c3RfYXJjaF90ZXN0cy5weQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNo
X3Rlc3RzLnB5CkBAIC0xMTksNiArMTE5LDEzIEBAIGRlZiB0ZXN0X3VzZXJfbW9kZShzZWxmKSAt
PiBOb25lOgogICAgICAgICAiIiIKICAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X3Vz
ZXJfbW9kZSIpCiAKKyAgICBkZWYgdGVzdF9odnhfY29udGV4dChzZWxmKSAtPiBOb25lOgorICAg
ICAgICAiIiJUZXN0cyB0aGUgSFZYIGNvcHJvY2Vzc29yIGNvbnRleHQ6IFNTUiBYQSBjb250ZXh0
IHNlbGVjdGlvbgorICAgICAgICBhbmQgaXNvbGF0aW9uLCB2c3BsYXQvc3RvcmUsIGFuZCB0aGUg
Tk9fQ09QUk9DX0VOQUJMRSBleGNlcHRpb24KKyAgICAgICAgcmFpc2VkIHdoZW4gU1NSOlhFIGlz
IGNsZWFyLgorICAgICAgICAiIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X2h2
eF9jb250ZXh0IikKKwogCiBpZiBfX25hbWVfXyA9PSAiX19tYWluX18iOgogICAgIFFlbXVTeXN0
ZW1UZXN0Lm1haW4oKQpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rf
c3lzdGVzdHMucHkgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weQpp
bmRleCAyNzc5ZWZhOTE3Mi4uYzgxMzdhNzE3MTMgMTAwNzU1Ci0tLSBhL3Rlc3RzL2Z1bmN0aW9u
YWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5CisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdv
bi90ZXN0X3N5c3Rlc3RzLnB5CkBAIC05OSw1ICs5OSwxMSBAQCBkZWYgdGVzdF9tbXVfbXVsdGlf
dGxiKHNlbGYpOgogICAgIGRlZiB0ZXN0X3RpbWVyX3JlZyhzZWxmKToKICAgICAgICAgc2VsZi5y
dW5fZXhpdF96ZXJvKCJ0aW1lcl9yZWciKQogCisgICAgZGVmIHRlc3RfaHZ4X211bHRpKHNlbGYp
OgorICAgICAgICBzZWxmLnJ1bl9leGl0X3plcm8oImh2eC1tdWx0aSIpCisKKyAgICBkZWYgdGVz
dF9zdGFuZGFsb25lX3ZlYyhzZWxmKToKKyAgICAgICAgc2VsZi5ydW5fZXhpdF96ZXJvKCJzdGFu
ZGFsb25lX3ZlYyIpCisKIGlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6CiAgICAgUWVtdVN5c3Rl
bVRlc3QubWFpbigpCi0tIAoyLjM0LjEKCg==

