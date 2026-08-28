Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4C7C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Xb-00005y-Dc; Fri, 28 Aug 2026 18:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05XZ-0008WS-5O
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05XX-0005ih-EU
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:16 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTCat3775865
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WlFiMYFEE09
 F5aggqhN9tmxQdu2D107CVwPhrwas+90=; b=CZk30qIb+6tuvvtUQbif+NTYpmA
 uHrF4y/0RLlRBnHBcZpg4jFowuJ0sykidbAzRMK1QyXHiEefXnVaoDghfTFxgxeU
 fK22KewEAG5VeIdevam4But2xXmbnBH+cUQ1VqyMDi9DxRFLchpKtJa9S6lOO+rU
 LSZZ8IwD45n7vrOMaUYfEeDFKUSCZQ/mfags4A8rKT/1Ti4jwr3/8nRSadU+HnHx
 INxEOj/tIDH74MR2ji7SWH2n8cXbmVPPLrp54A3O78o2/zp6Eg3vtxBddQEy3PNk
 ylrx1T2oZZYuKg54uYonLdsjGkzi6lXmeqcho2pSe9OWlagU1zaYq4zZotQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbj3er82v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:13 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3968bb86fb7so2207937a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957953; x=1788562753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WlFiMYFEE09F5aggqhN9tmxQdu2D107CVwPhrwas+90=;
 b=cw8XVzsBNmLcGoHlFjNm++OBMV1z+Ai8b+TsnCAMayTEcdOfRMuzbfzxyrqlK7TiVm
 zuNkJmfcEs1KSP5Z5qRuuE1/+8S6mr/5AeFQ/2K6ri1wkkhe/Jo7V0uf50HK7LxWEg4W
 Wy1MyiFYC+7LigBaOKCl8JTbLk0DLyHJRzlnQPw/x9mW7c2qRIUnNLyRXTQywJTO/coF
 rHV03A4XU5I6/SSoicE3Cr7l97J1qTfcRZUeJmsZaC3juPv62mZLA6CS2wvXpnWymw/4
 vRmkfViMNI0bxfI+/6gJSi5ynZdSd1AcSxZ6Zr3OkmbqppL2TsrUGPDzrEKBU62Fa0Fi
 46iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957953; x=1788562753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WlFiMYFEE09F5aggqhN9tmxQdu2D107CVwPhrwas+90=;
 b=kdqB1KnY1Nz2O5pso2Vksry+ZUVCNRHRMW/6TLxMi48kWxZbAg7rhv9rgisZ+JLlOX
 yOFdIYmucY8bb0mct2TBXZcW3nrULhQnSGa/KIF79gq8Rij8rTvm41Q3Igpb7TvzDHPT
 VheSu8+v/0fSo1zbJVFkElXlixK33nVBYj2/BkfK2X9T75MX0be+3r9H7KwBg4mHXxJ1
 rXl0/2lkJgSPB/PG6vJ9HyqQp9kXooICecR68Y4X+RuFSj6jOs+MVZfxX9/BpcvvtQxe
 gX7RBRxCK190+gY+P2HSMYmjnoZhYjXSfF0Cw+NQi/cpFiY1auShRkJGF+RuiN1tO0j5
 POhg==
X-Gm-Message-State: AFuF++m5n/KxCizH4gftpBDZkKNTB7+laek7z8HPp9t+ChIcd1nKH8XR
 TBndq1Rmww4hbvcVIhKOR+QnHp5hQYRrHmInrDvBkuV0Hm+7NO8lbx6hSOoIeHUE9bnB68mfRJ/
 Mz4D1UYnsV5afqpw5Wdu2uwjyrryWMBG2CdbU8c9HTDWU85hetLFtNP3Orfm5Z1J1VQ==
X-Gm-Gg: AYBFou2Fzhu991Pm5R8dFVLJRg07me+VwY3kn47xz8E48+D1Ocr+WODG4FFiUm3D8EV
 conf/Z/FFelWAxPRSVEh5eClwPSs7NUsywuq8JyCj9bWNbYc+4qmzrMw7c/axDhRRHW/YsxAMR9
 prX4vHVpUHigGnWvsKUqy1kcWB3u8M+GbR7KkySPEVw1++a6VwTwtpaCngCa2Qt2sWcGoJSjhxg
 BPAkF4KBnS9MOt2vJDMdbErbKWrkNk2/6WhXFsP9t2G/LIGZxuGjwDia5Gix+b1JAIb0TkR1zbA
 vj8x8Gh55JLheA/WW8JsaLh11oZJqcqcdeKWM9aUu/KxlBgSDGfWBxWkEzbUdHgIq/4mvM3LS59
 whesas6yeq7O8qrN2RVPub4mCPKPqTm1KmQBBjh0u2MOCCZ6XfPODyAHvkFY=
X-Received: by 2002:a17:90b:4ac4:b0:37f:e1b6:4c7d with SMTP id
 98e67ed59e1d1-396d0e20f0bmr16295742a91.6.1787957953254; 
 Fri, 28 Aug 2026 15:59:13 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac4:b0:37f:e1b6:4c7d with SMTP id
 98e67ed59e1d1-396d0e20f0bmr16295684a91.6.1787957952797; 
 Fri, 28 Aug 2026 15:59:12 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 07/47] hw/remote/machine: remove unsupported arm target
Date: Fri, 28 Aug 2026 22:58:21 +0000
Message-ID: <20260828225901.367438-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BIts8LLW71ZUBSPHhkQAZMWVrEddM0Aa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX1W3GGvPPs4dN
 CJbSbqxVDzzJ5WGPJLA7amtgkmRh8aEMQTazNwdXTL5/kj+2VzUAp2RVQOvo6+onm0q0icv/FT3
 Q4pny8D9r6VGshyrGje8VcPFgldksFkEW3LUjYjkL/+WgE2a4wc8fUt2aXj+2517WfoNUZ66AiP
 8FnKYHpDayXsUJIerQQurVdXaE7pzmnZiVA2Rv/kHcI5uyFx2ycbYJaKCs+rS5sws7ayDd3B/hb
 aorXi/GggqkqOAUtjaToyffaOjZCXO5B1kOjohIhy0gByII4TmIxM4/eYeQeEZp9rN7QoefApdg
 kUNeBh2A+fQFeaW7uFBJZEfY5acv7lVSp04fqFWeOJRn6csore9QY7FDOjGLeHd5qI4MwvkRE40
 HWnyRi7yD76Zq+2iU0pfXAcXljwVeq8XqmiVNlFLzBvMXQpOcYGv2Ued5KMhscab5ja/qAK9oBp
 pwtoE3NM9jkM4dbus/Q==
X-Authority-Analysis: v=2.4 cv=QLVYgALL c=1 sm=1 tr=0 ts=6a9212c1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=ybQNsqCpf-b0oqEQsKEA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: BIts8LLW71ZUBSPHhkQAZMWVrEddM0Aa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXzh3CfE8y5yKP
 k0ICxRJvumQE43bOSnflVKbT72JBLopGb6N57UaLdnJCavHX8+abK+ERFVQiKSiknAhEiNVi/ER
 S/jWwkPG1vio8mUHsRU7ub/Wis1Ov24=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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

With recent target machine changes, this machine was made available for
AArch32. However, it depends on CONFIG_KVM (see Kconfig), and since we
don't support 32 bit anymore, we don't support it. See main
meson.build and 'kvm_targets' for more details.

Fixes: 4e8ac6857faab2 "hw/remote/machine.c: Mark x-remote machine as OK for AArch64 and AArch32"
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/remote/machine.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index df08f640199..88d38b75d52 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -150,7 +150,6 @@ static const TypeInfo remote_machine = {
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { TYPE_TARGET_AARCH64_MACHINE },
-        { TYPE_TARGET_ARM_MACHINE },
         { }
     }
 };
-- 
2.43.0


