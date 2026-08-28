Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEA1C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05YN-0000rm-Hd; Fri, 28 Aug 2026 19:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YB-0000e6-4z
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Y9-0005mA-8M
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:54 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTn0J3666826
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=U5rPY8rQ2e9
 osSpbvf4I1bpIoJ6IhrwYY3j4mcamjD4=; b=mEudVmm2GU7lTDjW30xfaR41RgY
 i4BAYDSMQCG7mE4qrBfSOMPQDGXXXKijJjWALzdyhdamnNib78F7i4dIWpcxBVSA
 QfglefsDonJ3h+XwnEztsqV79RANybDpgFTD1GWKl30P5hjH9UsPWI7oWuyz6ptD
 sD7gN14Kc9YweAds9N1uERJ/2CIqhX3IqWy2BsgiTvemfjzWgmMdVQkcAyLHZzdB
 AA+x5jvNzYkgbgBwUMpIZEha9XRW0YZX4mk+Zh/VBUJntf+ikE5KM2z/aMfXiARK
 zZRGzj4EVQeHygmAENJanL3/dljgEuxl14ys4XOWJhjsPZnYYKR5XKv086A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3mubswu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:41 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc18ced1a5aso3215309a12.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957981; x=1788562781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U5rPY8rQ2e9osSpbvf4I1bpIoJ6IhrwYY3j4mcamjD4=;
 b=GwbZvJq4j8rKJ+8MFDxFdhHDlhzNHLUeaOBu6Cx2/QqFRVxe0gofHYIuy3IM3goZtM
 boe44moAh8SOXUHguMBLCiPF2eQc1Wh7SO0xX4oYhhXHFBz6blyMPu/P8oh2jXEooS1s
 +ZdSaG96fKbekjX5UZxDon0Ao31PSlUy83429YOMHvtuTCDPQACXPklfFKnTvaUGKwcF
 LHxPhnHlL3XCDChcFryCROfv3ajDYirghd1D3boHoa9XcEAoiF1WkRE36EoFha9ughYc
 X56ox6Nlp1Da5OaLjLGci4P5jOWC3JfLzC9TyK85bpuTD7yCxZtWRI/1A8KsK/nRuIX0
 Zdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957981; x=1788562781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U5rPY8rQ2e9osSpbvf4I1bpIoJ6IhrwYY3j4mcamjD4=;
 b=MlV4egv/c4zGdVnPxXuQChUmPRVSVioau0spyNiC3p8Kmn3wyFkdaC3GPCgcGdhDoH
 B6hBqWihca5CNUGFqcUQNi0vtMd75/sbaNmULS6+L5tJdDZWdwjDvcY6ngUkzzBYwhVC
 KsQVQZ62B+1mdtwzZOM2ByHeBEgCVpzyGOKJ3JtV84RjufhOjkWPmM+6uMkuihlzC54z
 Bd6QvojE57M/Zda4Wf52gWYw/c8htaNW3sFanJWSX/OyWBnU9s3xjux5lx3mWNW1EOT7
 sNMRRy5St1xqpxZbx3JmczvdCTNz4lGNr/ZgbvSAtHp2pZ+6tH72+21zqwY3BWsm5iUf
 8bdw==
X-Gm-Message-State: AFuF++mY8W35OZvCBe3KbGN7XHLkOrapf/qEBnckkLII9d/Yjumj7EgA
 Qa/v6TjaE2o0RaLf/0CdrDJn4+xdxrTkZJBUD/RB2ZWL3/R+z7+Zj0Gt8iyG/T1JduwGNxqmLdO
 6ChRBeik79irWm9v2WNEBax3oWsDTt4RzyE5k8Or12aLNgCWfoMlt1LthalvaTcSiTg==
X-Gm-Gg: AR+sD10hekJm5YRUkI7AKU15Moyd6cFGK1QX6jO0ZMD9S3WntatN513hoaYvt8pngak
 U84u4yc2khMI9Xn8Gj8UlUgXd1RmbLB6Hyg7+tuOeY1u2vqC+H+yE3SLhJVWdm3S3ZyWL5qALcV
 lCq4jiqJWA7YOhOz510tC5WKAwNcb9BljSL99oS5fDHXUzW6swu6XtduO2AtcQkQbNEntTJvF0K
 JZ3JQv7yzYPJgfZhR+jWRsDxbZjzW1ftQnhrIniS1dfkzmjzYKAg8kXrdzAPby2Qcrfum2RtKO8
 Nc8s5kudPqbVaYtwk5nzSXHfqRmE6GlIq2AJVuOxJH6DNgBqb5xVF7u9qshMx1f+Tli9bORFSx8
 uB5QRxnXw9crVAe+tRCo9EzMG0It7WOYx0RqWAEgZnvfjS6TuEA1Y4inNRs8=
X-Received: by 2002:a05:6a20:a123:b0:3d0:d0ed:f141 with SMTP id
 adf61e73a8af0-3d265329781mr20073811637.2.1787957981187; 
 Fri, 28 Aug 2026 15:59:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:a123:b0:3d0:d0ed:f141 with SMTP id
 adf61e73a8af0-3d265329781mr20073756637.2.1787957980793; 
 Fri, 28 Aug 2026 15:59:40 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 26/47] hw/nitro/machine: filter from CONFIG_NITRO
Date: Fri, 28 Aug 2026 22:58:40 +0000
Message-ID: <20260828225901.367438-27-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZbMt8MVA c=1 sm=1 tr=0 ts=6a9212dd cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=SKPTe5smvNDSqZm5GXQA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: TZooGfyhyBYoAFvSLn4K_hy5cGGgSj2Q
X-Proofpoint-GUID: TZooGfyhyBYoAFvSLn4K_hy5cGGgSj2Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX7qmMRkIjZ/8Z
 B9MSCKiN4fPQZKpp06YMOTuCaY/MDtRcvxDXWz6DKG/dewoLK/VYr4zpJx6WDoCOv6AEV0ULifC
 72+7DMBuGNCF2q+cVomkKVhDCbwWjUE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX36C41gc34Pbm
 k7gEX6btdZvtX3dG1biN7VfsFxqh0HrsLb6W7asMGPwHKOO1hBMz41DuZsAh775lyowHYi0245k
 s0rXE3y6RVk0vgxu5RpEZwUv1juduNypzQgFq8q2yghHGn9er5y7sG+KebvQQpd5QiLDa5zE/78
 cujhP0NJxd/87pR70dmupYtlnxEuVUVeLK8X3cwVmyCOdY1qn3wfFirwnSr6LjM5gsxa/+KpBzq
 8nxf6uvJZFg2t4TJEm0al1UJAwApvJZAcYwns/PWDWVBytaRtPlICf9Wf66R/tQwh++oVxlkEAn
 54Dm3HVAa6UwohfmhnuE98tbB75rGpE//JuYI1rvC/7alPJGXi6zabVl808ZBKXAkqQ08pQJ+Ar
 CB3HkltbdcNuB9EttUmVenv6Nt06OBzzManurts8N2ka0v4CErQCffTlv1ApzcrYoGHW19YDBDl
 1Yd5bpTkXZnMieGZFkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280200
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/nitro/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/nitro/machine.c b/hw/nitro/machine.c
index 88d01960a01..e3c8f097661 100644
--- a/hw/nitro/machine.c
+++ b/hw/nitro/machine.c
@@ -261,6 +261,7 @@ static const TypeInfo nitro_machine_info = {
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(NitroMachineState),
     .class_init = nitro_machine_class_init,
+    .is_available = target_config_nitro,
 };
 
 static void nitro_machine_register(void)
-- 
2.43.0


