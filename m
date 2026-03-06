Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950FAF01832
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 12:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUYo-0004QL-Dd; Fri, 06 Mar 2026 07:45:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vyUYh-0004OK-Um
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:45:35 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vyUYg-0004JX-6W
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:45:35 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-480706554beso100051965e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 04:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772801132; x=1773405932; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GQ3XNZQylUo1kVBj7P8D+o3KMu1tKKdNQcK3fCWx5QY=;
 b=zxP61rO8gQxAzgzA8duaRF0HRuGBaGZM+YeVWZuDgBEmSOHWb6kGTP2xWYTlKcK1jI
 H4bIG5Ho9I8YZuboOQRYuEMNYkg1S88E6k/eoFwRf6X4wsba8j9ojb+s+rqCe2Nz8V4a
 kWewZQv1N00LMh/soxUXjWuIphmd+fDxqvKdSdQwyefNxixu0zHtb4tAqOgmHkadYI0t
 eNOI7Vb5/+sP41Bfmvw1oCoP6e9iGw5KA19AoY+2tEJmiJK+oqbMIGA6gyWddFh2ETkP
 w4lIpBJZROhZrx5MXFFiorwq0bFFrBI1UGzg0LjjLAOdupKs555aC8cQ52OfRqj0Nguw
 6y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772801132; x=1773405932;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQ3XNZQylUo1kVBj7P8D+o3KMu1tKKdNQcK3fCWx5QY=;
 b=QLot54LR3OLKzyfXHjGno8CCe3sknloAtQaEmKxWfaPPoZQAW+QAyHYjqVmcCdvZHW
 tyuD/WpALLuqHX8a4AGpNW39DYnhwOecdFio2Jezjc7eix+X3eQRxUZITK2NVVmhViEd
 rF/PiJ19Yy5PX2AhrpBhG9Bv3Gwgm/75oNXJMc3SN5eAl97yjtCfuuM3fDz5RVOre7eN
 kQk1xG63Znzfin9X0INcNRQFG0DJF75klDnDVMaRMyLzzbqHc8cNe0EsCUd1x3PN1jWX
 geqEaRqe1QASwVFdV3I0ErhkBrGK5+5ThhgbvNRPwF4XRZaCmC79Ri5iY/u7/HLniXbU
 D6sw==
X-Gm-Message-State: AOJu0YyJEPKR03JnmbaqEaUQkr/JKMX/dDG03cHYNE00QzBxxk3dDDep
 n+GBBHfkyh3DJNWD8mla0cvdYbF7uRDY9U6cg7mdFJgnNii/4zl4B1FOXFad6bKPt+0=
X-Gm-Gg: ATEYQzwJjjYPFIR6gK2TPM+x/PfkcLvPofYyfy6sDoNvyuq4f7uNqU+N6I88GWcx5Xj
 7JNcaj+U8CyWdw7UETAXEdn45JVpFWZ12N1OajRpbbdXtWIhl8vRKR17hIM+Hx9HXGqGtuQMTr0
 CyWV520RHO5oWYW2fVIsQ9YqKK8GPBX1CVFGC3P2ThRuMpk6rMOEzGYCg4ZfZ7y6vhmKYthOE9d
 8H3MczhBcaXiEK56D7i8y2yLXHAS/ucIGssVk5mR9qcJ8nO3VlTIrjWmIEz/3SYYHZCo2wbnVVy
 h4UWGFl20c9F9PZy2h+D3x7wm+Bud0SzpXkNrkw8ss89OlPC87spqBQmHSXlTNJzkXhSw7VmYyT
 EWjI7pN/gzgdKcp/Q5euS6a4fDxBodX9zENH8LC1UTf7s/FYNAxvyq4Vuz/eve6O6zzxwmZvgJB
 h8aLoEDRM6ri41TD262D2BsWiD/VjCzJpDrcRWKp6w+jFWeImsQQnmuPpIcq4ZppXV+KGTwD1OR
 BSxcLhTwID50F1ZIQoaRw0dDhoT11RpTaGjbYA=
X-Received: by 2002:a05:600c:1913:b0:47d:3ead:7440 with SMTP id
 5b1f17b1804b1-485269795ecmr27648295e9.32.1772801132165; 
 Fri, 06 Mar 2026 04:45:32 -0800 (PST)
Received: from [127.0.1.1] (ppp-2-86-215-248.home.otenet.gr. [2.86.215.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485276b7571sm32301335e9.13.2026.03.06.04.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 04:45:31 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v7 0/2] arm/hvf: Add SME2 support
Date: Fri, 06 Mar 2026 14:45:23 +0200
Message-Id: <20260306-sme2-hvf-v7-0-e72eeda41ed3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGPMqmkC/3XOz2rDMAwG8FcpPs/Dkv/vtPcoOzi22hi2ZDgjd
 JS8+9Re6pENdPmEfh+6ioVapUW8HK6i0VqXOk8c/NNB5DFNZ5K1cBao0CkAI5cPQjmuJwnKeuc
 hRIsg+Pyz0ale7lXHN85jXb7m9n1vXuG2/aNkBalkpmgjj/Pavb7XKbX5eW5ncWtZsZe2k8gSK
 ScTYCieaCf1QyK6TmqWlPh7XQYaEu6k6aXvpGGpSyINCYJ3ZSftf9KyhOxUihhB5bCT7iG10p1
 0LAfjtVdYAgb/S27b9gOKll6GwwEAAA==
X-Change-ID: 20260114-sme2-hvf-105767189521
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2254;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=yhLVkMX0/weI7TVxMrr9Z1fCHfO1x9qMnrl+5qGpYQA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnBxc3hxZFFWbTVsdXk1YXZzUjUzUk1mNjlqMHloCnZBME1kT2E4RkVrckN4S2w2
 QkdKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWFyTWFnQUt
 DUkIzS2Nkd2YzNEowQkp4RUFDUFpqTFFGdjBYMlVONElxWjNoTWEzaFlCRkxDTXpYSTlGY0lxTQ
 pRV1dWQVFxUkhTbDI0alVuT0hqNzR6cTBIdVN0aHJFdERLdEc2YlpZdDM2bU44TENVMnJZdWRud
 jA2K1FKVDdWCnRKMzBwM25yNVBSMC9WdERmM053OTlvenJ4RHh6T3dnZW1RNnRaUWFhN2NJemVt
 NExrM2xqUDgwYTNya2plQzYKOHI4bTdHNjRxZGdOblNyYXorZWJISkRtUnpJTWQ2RGZXV25RS1V
 xeU44VDMxb1lSY2lUNDVQK3RIWFlHd1dESgorNGs5cHJmNFhpWGwyam4rdUFvQmIvaHZIRFZha2
 ZJK0dqWmpnS0J5Yy9mNmdpZW5UM1V2UDI0TURNMzZYWnBsCk96cTBtN05jU2pnTTA1Z2o3dHNMd
 mhDU2hJdHcvRk83SnZkVjc3KzBpTjRLTnFoMkd2aEVmMnp3NDN1bko1cWQKVElhbGswWGgrVXpr
 cGM1NlJvZFN5QUxkNHNtS2NwVGs3ZmNQTlpjSWhYUGxpUzRrK0E0cmNvdys0MW5ITFliaApWNXV
 GZFB1bDd3TkZsb2k1R3ZOandzRGp0dGRkTHpRNi9VUXFJMGRZZXhVQTFFbm9SMjFEaHkyODFiYU
 h3NTk4CkJiMjFLa0p6U0Q3OUxZVFN0cmtLOHBCSkEzWDQwZ2F5YnFaQW1wS2JFcFlaSEM1cnBtd
 k1RbmpxeTEyY1l0MVkKakhkWWRFcVZnY2xyZjdEWWZLTWtoZkZyOHdpelk2RFZ6TzBmeEVWdFNQ
 RldCcW1EVnVIRnNFRWZSaDZ2dWRITQpJQWFReGdNNEp5UFVwYTZiWXhiMTRpdXoxdi9pNDM5RUw
 2dXIzYUlxMU1EMVczemNzM3hVUTMrc2FldkpaUjNVClRKMk5LZz09Cj1VS0FnCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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
Changes in v7:
- Set ID config registers properly
- Fix build with non-clang compilers
- Link to v6: https://lore.kernel.org/qemu-devel/20260303-sme2-hvf-v6-0-b473702d8287@linaro.org

Changes in v6:
- Remove host isar adjustment (thanks Richard)
- Link to v5: https://lore.kernel.org/qemu-devel/20260227-sme2-hvf-v5-0-1c60a92910c8@linaro.org

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

 target/arm/hvf/hvf.c           | 334 +++++++++++++++++++++++++++++++++++++++--
 target/arm/hvf/hvf_sme_stubs.h | 172 +++++++++++++++++++++
 target/arm/hvf/sysreg.c.inc    |   8 +
 target/arm/hvf_arm.h           |  41 +++++
 target/arm/machine.c           |   2 +-
 5 files changed, 541 insertions(+), 16 deletions(-)
---
base-commit: 483cb5b74cd247b1520e0994b4fae4d8fe44cb00
change-id: 20260114-sme2-hvf-105767189521

--
γαῖα πυρί μιχθήτω


