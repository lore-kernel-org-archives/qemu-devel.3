Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E973FC44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh6Hy-0003ef-K6; Tue, 07 Jul 2026 09:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh6Hx-0003eT-4p
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:56:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh6Hv-00009b-DM
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:56:40 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8etr3616557
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6Cul7p3G9iEU/UgFnqgWcT1iEConpD0eXZ6L1n3JD9c=; b=Kx2jO+/G9gFnfral
 i+y/iOvAsOkQGJkguLvkCh08PltF3hbdKj5fVu7nWIX+KIgIgocshExYfgzOpZ0t
 cYGxjurNybB16/cPyxAubl3cqhY1pY7gkqo2JLbMla1elKva3GM4MGCxJpd17S37
 jIHuyU26CLc93RtUYkFWs83rKRD1EzejXtMECJOcrX0AjeKQKH7yCAd9QNzaEjeL
 ydRe9f+gzgdPfXm9MZEvxQ0Gfcmn5cQ32AY5J6VUxGcuZ9Q4BeFhQghvVQnbmdlq
 sfuJiq1MH1V6Ljab5omPSjfj6Jt9nyKLVDF3plXx9aByvcoS+4OTh0BS/Hjiw1BY
 lvyYvA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vun1k2x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:56:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0ab07320so38594771cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783432597; x=1784037397; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6Cul7p3G9iEU/UgFnqgWcT1iEConpD0eXZ6L1n3JD9c=;
 b=Fa6RFU9t0jV/P0iLpTSqXA1EdywjEikSLsnF9GA3AsvgGMD2CBY5/sdfHMzt6UrdWj
 aebYzdK8dRI3X053sMiSrfYf97n9TS0HjVgFtwjHxM3i/YCTK+O1PBQVPMOdZ0MpBcOK
 OjuuDHl1pI9dty8jhSOsYM5586Av0bfobyAIljx+WS1oh8Qo50U+XX9VeZrv+gaxsD2e
 OXizrf6mNyDZjgIzIqYANGEvrCarra60S+ZHEIViO4C6xJEBt4i6pkext9eahLPhPi90
 Hmd0T2aMLZI/UCp9qmDw7kS4jEXNSR3IFDT8zT0fYg1r5rH4RRDINl+JDaFo1zLTtNkd
 /fJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783432597; x=1784037397;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Cul7p3G9iEU/UgFnqgWcT1iEConpD0eXZ6L1n3JD9c=;
 b=W+m91eZeyPuJUkrAnP7cuRWQprhUto5w5lqhVP43SDA8BONtrSknPUgmhjqJAJkxGu
 SxzT1Kq1FwjaymMdSSA/rSxF7o7oE5Y9bx/z2jGM3DFNpf0NM3V4soSWcLVSVRenvYG1
 NjVze+SkzydPeW8PY9kj/FHsOlUmOomLDteuWF4AvWUGqWfOUbPfzhvhnX2jRdmiOQsK
 D+LsfvMW5kRBA/hbMgGHbZ04DljMT8j/oeKUHBcK0iBRealnWiSZ36Ca+AprYKkEWKkU
 zq/w1j0czgiAimuCGMPAI2sxiFdxivILqYGhR0oYFUc3m323v9IWt8ykNPAbz45XTKLH
 qbCA==
X-Gm-Message-State: AOJu0YwqsPJqFU8h6Kh5kXkVdzOqzTbIe5cUM2kdGMaSpk2ok9mfSmFh
 8pMD6LQkqfWxQXTJq9PPCEDuT32BdZhXFqmrwwaWuLvq8Hf2FRiZsznWCqDSjXmuFvMMhWqGZxK
 1cJuHHcim15znIkqOxqjjgbGLSgihIbKdXUf8Z3zGUtDJsmANMm8nBVoOMK1hE8IgEw==
X-Gm-Gg: AfdE7cmnIlYU13sQ+vpbf3cfhUMYSBIktMN7xh0ZXIMVZJUAXVHuRcOYXszZeZeU8wy
 8rflRZ/1CT0a6hXvEwxeu17VLUvF511LrObF09uYAiLvkUYHWERygiqMoj6oZHbtxKfx8nAxi2d
 KcFS/VmyRbi4dKJPRLPlM9tzORsGdYNK4MeEi8Grgz2kn7wsfvP47NiBwDgLoGntFGHq2Xja9E3
 UqcuzSg7btGNkvYJ/9S45gUNE/no7ELmj/U4MSC7jo+VOEezVm3UucE92MQQrQVwrqjbXCOsX5h
 rkBfza52psAqOthAgCA7/WPZ3LmzSbAhDAOx97IWZAx1KKRanuhtZhD5a0WlovLmRKgwfm5F2W7
 6vRkFLqNQFqq3FFVOHspANcxBHMGRun46WNbrzb5e5Jz3owVl1MYwXwloqnCnWvJV31cl
X-Received: by 2002:a05:622a:14ca:b0:51a:8aec:9bbd with SMTP id
 d75a77b69052e-51c7479ed31mr57932191cf.19.1783432597009; 
 Tue, 07 Jul 2026 06:56:37 -0700 (PDT)
X-Received: by 2002:a05:622a:14ca:b0:51a:8aec:9bbd with SMTP id
 d75a77b69052e-51c7479ed31mr57931891cf.19.1783432596533; 
 Tue, 07 Jul 2026 06:56:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f4e3afsm65615505e9.7.2026.07.07.06.56.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:56:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 2/4] hw/arm: Allow using Virt on a WHPX-only binary
Date: Tue,  7 Jul 2026 15:56:16 +0200
Message-ID: <20260707135618.53561-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707135618.53561-1-philmd@oss.qualcomm.com>
References: <20260707135618.53561-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEzNiBTYWx0ZWRfXyaAHkImimakK
 GzPUkZOJB1xozuKX6uA0FLqvEC/Dl26lWpSjxihmuQaUWCBXUX/eEMWqOAOur9g/8kFZUu5Naoj
 hFTbhm24aCIYlQoJ3GuyqHuu1TsQyBI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEzNiBTYWx0ZWRfX4Y8LjyS55Esw
 l/g3uk6zhETetaF8sryY9F2Mfyh8Y7wTYFL6orJEJeXm2QZa6WTwaIN7bgFseIVcUhHoGv9/NZg
 dMZwuhlBVqs4ltTSIbmcXpBKjQI2bLqGAHNOSrWUDVwh5olzyqIhEyBm/Q1+GfFBTvjFBbblzi/
 ZJ9CQQwovwuCW6CA2/hGCTzrIimq5Ga8JS6RUNKdSBu8B05BKnv2wYGjvmFJOdQK1/eL6QaGiCz
 G4uWdVkx7GhGSMuqah4bAft9Pf07g9OZMz3xSUig88I9TKxKVWz2Iu3ztAzX57nwcafSQDoYofD
 L5iJ1v8GBPy6QioU2NlFSHmvq2Oag0kKRWc5NamCEJkZZ48wXBIc8LykF46pcBDNNgAgrdLy49O
 J2nOuL8HY/n/EUX8sCUqMIJxnLa13JIM1bcr2vv7dG9GNxfA2oHb1sImlOaSQgPBvOq33fA12Eq
 /xwjwbCPWsYOGw4xDHw==
X-Proofpoint-GUID: 5iQIVBEWF3liXlrkORO8soXoPtd1MSfW
X-Authority-Analysis: v=2.4 cv=N+IZ0W9B c=1 sm=1 tr=0 ts=6a4d0596 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=y2RoIUyPlwi2Edkf8gIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 5iQIVBEWF3liXlrkORO8soXoPtd1MSfW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070136
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When restricting Virt machine to Xen in commit 8c4648f5a20
("hw/arm: Do not expose the virt machine on Xen-only binary")
we missed this machine works fine on WHPX. Restore that.

Fixes: 8c4648f5a20 ("hw/arm: Do not expose the virt machine on Xen")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f9a225c19bc..d0f08c0c07d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -2,7 +2,7 @@ config ARM_VIRT
     bool
     default y
     depends on ARM
-    depends on TCG || KVM || HVF
+    depends on TCG || KVM || HVF || WHPX
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply TPM_TIS_SYSBUS
-- 
2.53.0


