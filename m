Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5343FC5903
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 07:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvVl8-0004n2-Gk; Thu, 26 Feb 2026 02:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvVl7-0004mY-I8
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:26:05 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvVl5-0000dz-5x
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:26:05 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-483bd7354efso6987895e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 23:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772090762; x=1772695562; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n5aSOb9QU1vE+0xs3ibhz8LJlWT7HmBUS5ljH2xHPk8=;
 b=f75BqBC8fMg2N79a8CELYASHeqqh/Fh9doNrSSsW/T5VZALe2mGnHKrDsWI8nt5h7l
 gdQzL0NPTiMokkwtY4J7lI0gx1xicVxL4ZjuIqjdsVnXP5sbUmIWliVVQ3gIu8jZAi5/
 apzCcNDe4M51ZEkJLdIT5OTOQPrjmdvz4MHVWVphC5rTZLLg/h0CS5KJwDArDipVvPqE
 a5JiqByVlDK0gNqdBdDg9OriZ/mPh8Y5RVP/xhxkVbgwhDDmHvjWhCTgBh+OzTcRPeTO
 DmxdzTrH4FQPsSoj6mDVRKu3G+cfWjLKfBrDYB+tOChBk/J8j/y5Hvc1ivuRK2Rk61wT
 XZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772090762; x=1772695562;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5aSOb9QU1vE+0xs3ibhz8LJlWT7HmBUS5ljH2xHPk8=;
 b=hoJZQol2CyvTB1W2xVZUxnapEq5AcTQyDXWU5OQTdoy8AO2XHTpUz+WtrGCLsWB40u
 HAvTbA+24V5v4jFhXd/Qc7xJgACX+2joH+QI6RaGecMvNKSGh/+7M6c6HJ/1M9aFbtqL
 w4W12XbviJRK9x3WQkUG7oXLo6JW+ifdDk+B4tH9iA1OTPnGMq22NZ5NPXry8uK+/63Y
 2hNgAdQhKuHRaWXql6v6puHI2lewSEvfDc64GapTIeipFtQs315UB+Z06LB/qZQeYZK8
 JDL7OZmnj+/AO//wR8e/gRYa/df1nFaq0MSt9WKog/kVpM60OU5wrzxB69qZS36giJTg
 iGDA==
X-Gm-Message-State: AOJu0YwZLH8Db9iuZzYDJyueYw77I6x0+X29IYoX/m3hkxFA5r3GfbxO
 G/EOi7DDmNEIk5ke9a4c6z1pDAUGkaRo5Iyp3CDCxO6itkCgzeocg3o2fkX2MZydP/8=
X-Gm-Gg: ATEYQzzArIpdoPaSg0IamPpckXruD1NbhNVHZ9ijX1iuF9E6Cz7p1u43NUFRpdYL2NB
 4T2wDb1chdsbn42RrBQbcOq9ceoO9vea2Lf4hhvV1QAiCqkRrWrHY3w57GBXDDw5LhDqnfuup78
 2EUoSMC1bZ6bMrOBDGof+ZRdMU9XYou7PnLGH+EdC0EtXeMa8b7vX4RrmGnF+VyrP9aOOJjypBP
 YGJOFMqEFqEdNIn405TcjU6owOjfLVSOLQxAsKpbJXJf30QUqJafqCtNwvY84FWeBIOQYDofSEf
 GaFBvmg8rLsNxGeNtd7aQCPbyl4f7DsRoemOav3GyuzRbCZb0yHlKS1+aHAegCKa6dvSlUiZyFV
 mcuGUrGgKYFn8XkcGGmD0mmotoCp+qioMrtKQPpKjuBDtBiIz2NSO6+9ZlN7IZJMS0da+UTnzDY
 wINor2k7cvhuhtc72arcSm5ZE/mVzJgkpTumidZwH7R3OGUuVt5NCNJgYmOyF/GCsQPrtpXFgv4
 c4GJicd3TB95u699Chd7owBtj6N6wWb0cOuB1A=
X-Received: by 2002:a05:600c:6815:b0:47e:e946:3a72 with SMTP id
 5b1f17b1804b1-483c21a10c5mr52288095e9.27.1772090761647; 
 Wed, 25 Feb 2026 23:26:01 -0800 (PST)
Received: from [127.0.1.1] (ppp-2-86-215-248.home.otenet.gr. [2.86.215.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c35910f1sm26281405e9.2.2026.02.25.23.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 23:26:01 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v3 0/2] arm/hvf: Add SME2 support
Date: Thu, 26 Feb 2026 09:25:52 +0200
Message-Id: <20260226-sme2-hvf-v3-0-ea5763dbeba2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAID1n2kC/22MQQ6CMBBFr0JmbU2n0BZceQ/jAmGASZSa1jQa0
 rtbWGFiMps3+e8tEMgzBTgVC3iKHNjNGcpDAd3UziMJ7jODkspIxEqEBykxxUGg1NZYrButEPL
 86Wng95a6XDNPHF7Of7ZyxPX7JxJRSNFRo5t8xpbmfOe59e7o/AhrJaq9qXemyqairq1qvPWW6
 MdMKX0BMZufZ9sAAAA=
X-Change-ID: 20260114-sme2-hvf-105767189521
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=hP6bj5o+Z/KQ8eTnT1l4u9D61u7CzoPCbmn8pfbbTTU=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnBuL1dJdERnQTgvTDEyamJkQzlKSjgveGRTbTR4CmFBS3lwVDJEWC81YXJWdGt0
 UGlKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYVovMWlBQUt
 DUkIzS2Nkd2YzNEowSHRqRC85ZklIYmkxWHZsdWV0aGZYVWdLMkFhWnYxRjFKYXFVM2RzUFo4dQ
 pIeXVaTkwvU25GRHFjYytSRWl4Yi9FcHJnZklBRUhGNGZOVU9BR2xNYjNBWTZHQ1RWeDFZUitpV
 3VhSVRiL1ptCjV5WXJoQlBHOTEydnZZMWZ1NE1oVWNuRXltU1Fab3ZJZVFIZmV3Rks5THVzWXdv
 aS8yYXZrWEpUOStWSTJLaCsKNHJCczRlZXdENmV6S09QQ0hzbnNCcW1sdFZTWjlXTGwzNEVGakF
 NeG1nTHpqODN6VkJnZGdKU2xtUHlUZGttTwoveitMTTFIb1JkQ2sxYzBscGhIWlZKNmIxVEVKeF
 V3YmFKRzhNUi95VUVoaFl6YnBvWHpRcTNieGtmZU8wbmtQCnBTeitJb2dFZjE4SjNKKzhHOFBjd
 k9WdkV1QlZRZVlQQXMrbEZWaFFORWJVRVVCWHZ3ZUpwalpkbndDTXJYMWMKS0NGUzUvOG9ZWVkv
 RUZUYWhTSTRPNkQzbHVnbkFsSFVmN1VwYUJDd1dyUUFpaXZ0Ull0MUltQVJFbFhmdTJocgplalJ
 mSW1vcWE1UlhsSlIrRkJkMWkrcHB3ejhIazJYcS90RzJQeU1vNWpuSUVxWTd3YnJyRzl3SHhTWH
 YwVURUClY2NHd3SnY5dmtIRkc5a1B4dy9tZnFVdCtjK1RkRlA1M0tMK0N3WHIvSExyOFMzUnY2c
 nlXVENraVF6eXVaaFkKbEJ1R1FxRldrWFd6UTJhekdqSEtzYXdSTWxKL0dDTjNUUTAxVisrQkg2
 WDhJUEJ0bnkzT2FLaW9TaHRNZmpISwpudjl4NHdGMDZzOS8rVHh5cnh5N1lzWlVrSGxJa1hJOGU
 zUWxDVWxnd0xjUldjNFluMXlXWElKdEt6ZktZSTlPClVNSzd1UT09Cj1aR25DCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
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

 target/arm/cpu64.c             |  13 +-
 target/arm/hvf/hvf.c           | 314 +++++++++++++++++++++++++++++++++++++++--
 target/arm/hvf/hvf_sme_stubs.h | 158 +++++++++++++++++++++
 target/arm/hvf/sysreg.c.inc    |   8 ++
 target/arm/hvf_arm.h           |  44 ++++++
 target/arm/machine.c           |   2 +-
 6 files changed, 523 insertions(+), 16 deletions(-)
---
base-commit: 6593154e7d65f61d8f9dbeb98224731b7137c53e
change-id: 20260114-sme2-hvf-105767189521

--
γαῖα πυρί μιχθήτω


