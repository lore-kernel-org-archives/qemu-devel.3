Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F85FD530D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 08:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvtef-00021f-Bs; Fri, 27 Feb 2026 03:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvteZ-000202-Hy
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:56:55 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvteV-0001rz-Gt
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:56:54 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso14456815e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 00:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772182610; x=1772787410; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ll6MbUEU9ceSy6Gv4nD9PY2pPUk0mRVny3TD/tPpSQo=;
 b=mB/Zn75jE2s3dNKC3uhV/oJk7+3n1m4YBWZGQY0L4scP2SB2WkTET9UnYP+bx5RBOm
 KoE/9LjNqkfeJv5aF3i5fK1Aex+wrCOu5KlCnCYpKgQwnKehQwMlVPTdsDKRzvsCqmRz
 T04Iob8DNPkeCZ/66kWJ8sCH10+nw98MhW6Sb1l9hTuuO7VGSLVoqpZehG/hydOKesv9
 INmZp3CPFV64v3Z7fB1+r04GAdWW7y06b18ClGOZGRDTQNFDuK4/mXmdaLWraN+h/JG9
 dN4R9ZlZhoX+lp4ZNKHQnQqsbLuTEiPCTU/2UziMau5cPv7vKW7uEBdpGqtZPH97ve7V
 RvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772182610; x=1772787410;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ll6MbUEU9ceSy6Gv4nD9PY2pPUk0mRVny3TD/tPpSQo=;
 b=X5bFyRlSpU5imFTu27aLDFCKjM/fmjTbpedsJbhqY0ZimGoJk3la6Fffrsq9FYYF6m
 U8Ce1sjBfiJUVckaQqHISezGDlLQvKAzrQDPhrFcaktQ9l+gZtdXvQQHA5AmKnq0Hh8f
 AFh7IzXObJ+svloUC84Cposzk96wD56ql6YAbjMHlrvhj9bRwuk8IxCioB5WThULiM+8
 vVi0ZBKUwc5eYoV0F95Q4hc5NTZZQ13mKz3p2twxl4+inIlCw8CDnN7+IHw9NEKDHYKe
 rD7J9ry7VzR+u8OwJI7IMcCiv4Q1k0R1RhAE/j/wHgDw58MMM+7LnF7APr9nb7tfL2vs
 BAXA==
X-Gm-Message-State: AOJu0YwdE2uuzaxHBBWamFCIdGp5eWGaqRVCk13lbZeKfzGJfOWR3if5
 BkDCOOnOGgkdpRni4Hib7Rq57lI7n1f6fVTect27ImGaDbwFmETsJvqa4ZeaGCDtzfc=
X-Gm-Gg: ATEYQzzo0B8OdTpv2Gnc6Jf2YdnI8lrMJsfgYb8jD/nJmZM/qaENifZOLgmzdoUzttA
 irjm2S91IWeP4UYCmKhK29AsO/jPZ8aVFor76nwUM/Xl+G5XyeEwuPhS4FJaG0efNIS7DK5eqRp
 29aqZl4ML1OK9gJSP1/33eUnb//IRf6l/MeP+4r4reYg6DpEalZPqTFwtAEg0svC7mKUXeHCBCX
 tFMJZG+SWNDhnjnqLtqZ/s6UedbNL3sIlfvAzyzXwPLavhBgMI5jyX9cA3znkPNvMED0m6p/CA6
 bco/5735oJ4vE/lNEbRfwH3LGgcgD0sodXm8fIIuWMzfbsy9juxgRHwIOOJTqKTJ8DamGCdm9f4
 dMvfMoL+/OebTRlN2AUQFDZxYVHqdgFsBIihfUCxon+d/MpRXNTZSIhpB/3u3N7oTfDVdz5qnvi
 /JIFpZauCxx6dT6PM6/qYsZ4HWrjFcFO1AlnSG0cyPC9DkM0zgCSmj+0ULye8xI2jOrTU66i5Vy
 qvm3ODzTPKRdUtlPM3SFtchtgpMkcJM/WkO9uc=
X-Received: by 2002:a05:600c:4eca:b0:480:1e9e:f9b with SMTP id
 5b1f17b1804b1-483c9beac6cmr28494825e9.16.1772182609743; 
 Fri, 27 Feb 2026 00:56:49 -0800 (PST)
Received: from [127.0.1.1] (ppp-2-86-215-248.home.otenet.gr. [2.86.215.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b7713csm83859605e9.11.2026.02.27.00.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 00:56:49 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 0/2] arm/hvf: Add SME2 support
Date: Fri, 27 Feb 2026 10:56:45 +0200
Message-Id: <20260227-sme2-hvf-v5-0-1c60a92910c8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE1coWkC/23OwQrCMAwG4FeRnq0s6dpunnwP8dCt0RV0k1aKM
 vbuRi9WFHL5Q76fzCJRDJTEdjWLSDmkMI0c9Hol+sGNJ5LBcxZYoakAapkuhHLIRwmVtsZC02o
 EwefXSMdwf1ftD5yHkG5TfLybM7y2f0oyyEr21OqWx1hlducwujhtpngSr5aMpdSFRJZIvasb6
 Lwl+pHqIxFNIRVLcvy98h11Dn9kXUpbyJql8o4UOGis8V9yWZYnY9h75k8BAAA=
X-Change-ID: 20260114-sme2-hvf-105767189521
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1902;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=gDmCMRM+l6C+0NikVzYiWEK4NOKMmUlRRFHbDCwmpls=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnBvVnhRYnNzWTZ1RWlaczNaSmhHaVdhM2FLUisxCmdNUEFYSVVCYms1NzI5cXZw
 aVdKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWFGY1VBQUt
 DUkIzS2Nkd2YzNEowSXVtRC80Z09qNUVrVWp0dWFSL096SXB0M2luM2RkaG5MdnFlYURHRGQzNg
 pmWmRSR3V3Rkp6TVRkTzU0Q3JSendONHROM2JMR25DVEtRVlU2MnNzNCtTbk5Yb2sxM2tuaEk1Z
 UxKSjVYQ0xiCkZRNTRHWXBwQ3dQVnRmZlgrM2hRQWFzWDJUcjY3by9lbmE5dlZoREphRXcxckQ4
 VUk2UlNpKzR1N0VQQzR4bUgKaERrajcxdG1wNGU4QWdjWGVjZkxSNWVRbWExRGhCNWQ2OGdOdUs
 waEYycHVrRDlBWTErVGNkUm5Cc3lrY29uNQpuSXJObGRSMzM3Y3FKYy9Vci9yemFaR1RxT1hLay
 twQXBta1kwbWlQYmJDMmptc2pPWXZ0N1Q4Sy91N2p3SXhzCjNnWnNjSVhUREdUKzVLS3FzQ0RiW
 VNGSWhzNjhuQUVLb05NSitLSG5jbUFoYmhxZDQzc2s2MHpNK2I4emdDYXUKSnZlTXVsdXBsd1JM
 RkROZmREQmVjeXdtR3daeDRDcGY5dTE5N2pqRmZnTDdubUZ4akVubzIweEg0azlzUUJwcwpsVFR
 Hb2dpTXVBZENjNGJkQUQ1a1E2OENHTmVqaFR4SEVnM1ZYZjgyckVRNVZGaVBkRklzVmYrZXcxL0
 85OGxICkQ2d2FPMjd4dmxqVnpWTmxVNTh3blpMN2VRL0dGWlo5QzFHSTFrSzNPb1JlZ0VRRERYN
 VZocDl2aGhocVhUaTEKV0ZzdXhwQTFwdklINTB3RnhPS0wrRFpqNjl6bDVNKzZNM20wbGltYURi
 REk5RVFJVlV4cUdsbGVXa3hGUTY2bgpxdmRadFhlUlpzeVkwSGg1OVI3cEtkVFRINkorUHh1RXM
 3TndJOGpzQk9VeFpkUWdtZXQzMEtYWDZPaW9FZVNvCjhyNzNvQT09Cj1reVZLCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_TRY_3LD=1.999 autolearn=no autolearn_force=no
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

M4/M5 Macs support SME2, and HVF exposes this functionality in its
public API.

Add support for it in QEMU.

This was tested by running an SME2 benchmark from Arm [0]. savevm and
loadvm during the benchmark's run were used to verify migration works.

[0]:
https://learn.arm.com/learning-paths/cross-platform/multiplying-matrices-with-sme2/1-get-started/

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Changes in v5:
- Fix NEON registers getting zeroed when loading vmstate by setting SVCR first
- Link to v4: https://lore.kernel.org/qemu-devel/20260227-sme2-hvf-v4-0-3dae31a1876d@linaro.org

Changes in v4:
- Set cpu->sme_vq.supported in hvf_arm_set_cpu_features_from_host (thanks Richard)
- Removed two rogue lines that were smuggled in by git-rebase (thanks Mohamed)
- Link to v3: https://lore.kernel.org/qemu-devel/20260226-sme2-hvf-v3-0-ea5763dbeba2@linaro.org

Changes in v3:
- Rebased against master now that it supports SME-without-SVE setups for
  gdbstub
- Link to v2: https://lore.kernel.org/qemu-devel/20260115-sme2-hvf-v2-0-2eca481bd7ee@linaro.org

Changes in v2:
- Added stubs if hvf 15.2 headers are not available (suggested by agraf)
- Link to v1: https://lore.kernel.org/qemu-devel/20260114-sme2-hvf-v1-0-ce9599596736@linaro.org

---
Manos Pitsidianakis (2):
      hvf/arm: handle FEAT_SME2 migration
      hvf/arm: expose FEAT_SME2 to guest if available

 target/arm/hvf/hvf.c           | 323 +++++++++++++++++++++++++++++++++++++++--
 target/arm/hvf/hvf_sme_stubs.h | 158 ++++++++++++++++++++
 target/arm/hvf/sysreg.c.inc    |   8 +
 target/arm/hvf_arm.h           |  41 ++++++
 target/arm/machine.c           |   2 +-
 5 files changed, 517 insertions(+), 15 deletions(-)
---
base-commit: d8a9d97317d03190b34498741f98f22e2a9afe3e
change-id: 20260114-sme2-hvf-105767189521

--
γαῖα πυρί μιχθήτω


