Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9566B606A320
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=znZGxply
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUl3I-00018P-Og; Sat, 21 Nov 2026 08:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xUhpu-0000Ox-DQ
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 04:56:46 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xUhps-0001Lv-Us
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 04:56:46 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so1015880f8f.1
 for <qemu-devel@nongnu.org>; Sat, 21 Nov 2026 01:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795255003; x=1795859803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mjaLMzSfEvQAVnmmmaDH+RrdPNS8d+XwRyrHjllT/B0=;
 b=znZGxplySLgjsTJfroUaCz+Do6D6zJKB94tl2VkrBTmqgDSMeSj/tItKFuX8yEg7M8
 R2KIFp9Ix0q7wXapMnz4gEFzkGIPlwIX1CiOmun43NkefqiWhnWOWebcnwOMiSD5lr7F
 CvKl9r8sf/xYeTYyM9mHIcGh6vXQTyOHoQK8+N5VM3FBTMKCsuXtiTVw0Z36e6ezo/Nj
 fzjA7VprXD8CgKD8/D6RfvNus5IXqJJ/nMpnJLyOhAS327sxy9U2EzZ60Gee/zP9T5WZ
 GKNEZ/CxTPYRNuMfXETw2r/WaloQ2mIztf970KD4c25pwKRExmXgIvvnWZ7xcdOk0nib
 QT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795255003; x=1795859803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mjaLMzSfEvQAVnmmmaDH+RrdPNS8d+XwRyrHjllT/B0=;
 b=S0klPoe1IlEIebTLYJBg3A70mUwRQKbvlBRoeFNMNFhHjFpasgc1CGi1cOAiK5nOME
 GS22XnTpl8FY2EtAw1KzMcgWmAJ7lwx//k0N5q+T1qu515igtCo5TdLbbGAkTAAdjSX/
 02sp2cxfLinlIQ8jBZGeIFu31zfWOhEJ3jh7EUoqm94B13irT3ll446qh7Z1mtFID1yz
 Dy05liZ+A9DZHGch3pgVdLAdR+1G7gqY/7PUuLWTtDlRMN9/t821O/bf4F+ZpRocsjDU
 0pxK42stWEKTERciB9TVywRxpexhVRiZKFxpj/sFkEseKepmMtrPfAQgL8udphRFE130
 2gfg==
X-Forwarded-Encrypted: i=1;
 AL+hErERjTqoA8kc7Gfl7fP5uxvI0sQGKPLBoWGSfnxe+7ezb+Y6b/dih6+1a8SW2Uz2WburT+JRi1pWsigl@nongnu.org
X-Gm-Message-State: APuU4Z+rVfO+udQ8zUzftX9amKJlaMDypgQGDu3XHgKf0t+gNDO9dx9K
 c90Xr1pKgzb6Q4foOMiR5pn1yWii/Pw7aZQQYPnlPxQKBDhh8M3+150p
X-Gm-Gg: AZFdTZfxzGVkHkRUB0kcYDvEItRLO8rTMyT9kSGo2zl9n9UOZGgfnLNvRtNx9Sz9nUU
 NxS2e/rhgt12muos9mZe+6gbzNkX9ZN/qIEtdEV8ljeXp35Qvu9HAu0kJmR13Klqs10CiA2ouTu
 XRNH6m5ZH61Fjv+NgwOzW5PbauNVUbAXq0IHgL6z77WKM5qOXjkV8jzkOA/FpDZL0evPXb4mnwP
 knPK35ZNcQvWuI9LWDPWaDHg4f08HTVjb3PhkdNwJ7ezINjIdcB4nULcwJ7PDO2U4RQfpIJtB2G
 EdW7OuMSu/1ftxyqDvfeYZtqbB3cfafW1k22kEIb5aoCwOPbYbO+GKEF2J3nrUTP2S5HhhOa2QI
 TfpfQ08uF7Odz4JjWIbUK1qVS1gGcJVUUU24CyS+jGElWjXfTIGc6LFRTAGirduljgKtveFvcWt
 6MVp3h8fdABan/NW0Hpm8dtmDqJMJBOR3gkxQf4zJQpXJYPhbHWD6WthAVCTQqdv9sQGPEJQJYt
 KUJU9Z2usdlHiNVXfalolzLpcQrT7sSFKhJWSsFlf49eXVHQfmpOrySK0iHEbvFLAivpIrkL76Y
 HpFTDEVKvg1DqdBAMMVI1LQtJt0YUdSo/j4Rvh9CZZeG/rrzUaIW0B67QHSvWfsmfEf0da7ja1L
 KXlmMddXfmJ+wtjVujgKZwAsk
X-Received: by 2002:adf:e010:0:20b0:492:b221:ac38 with SMTP id
 ffacd0b85a97d-4abb2ce4bb5mr8957776f8f.26.1795255002703; 
 Sat, 21 Nov 2026 01:56:42 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.59.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2e6dsm10741748f8f.6.2026.11.21.01.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 01:56:42 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <volodymyr.babchuk@epam.com>,
 Haseeb Ashraf <haseeb.ashraf@siemens.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: [PATCH 0/1] hw/arm/virt: add vhe option for nested virtualization
Date: Sat, 21 Nov 2026 14:56:35 +0500
Message-ID: <20261121095636.289814-1-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=haseebashraf091@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 21 Nov 2026 08:22:46 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

The virt board currently enables VHE whenever virtualization=on.  There
is no way to expose EL2 in nVHE mode to a type-1 guest hypervisor.

This series adds a vhe machine property, enabled by default for
compatibility.  Setting vhe=off propagates the requested mode to the
guest CPU, limits TCG's advertised VHE feature, and requests the KVM
HAS_EL2_E2H0 vCPU initialization feature.  Unsupported accelerators
and KVM hosts fail clearly instead of silently ignoring the option.

Validation was performed on an AmpereOne A192-32X (Ampere-1a) machine:

  - KVM with L0 kernels 6.18.29 and 7.2.11:
    - Linux 6.12.67 initializes KVM in nVHE mode with vhe=off and VHE
      mode with vhe=on.
    - QNX Hypervisor 8.0.5 detects the requested EL1/nVHE or EL2/VHE mode.
    - Xen dom0 boots with vhe=off.
    - Xen does not boot with vhe=on.
  - TCG:
    - QNX Hypervisor 8.0.5 boots to login with vhe=on and vhe=off.
    - Xen dom0 boots to login with vhe=off.
    - Both AArch64 KVM functional self-tests pass.
  - TCG-only, KVM-only, and aarch64-linux-user builds succeed.

Thanks,
Haseeb

Haseeb Ashraf (1):
  hw/arm/virt: add vhe option for nested virtualization

