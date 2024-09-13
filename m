Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6E4FC6169
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 17:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp9j0-0006kj-CS; Fri, 13 Sep 2024 13:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sp9iy-0006jz-LU
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:04:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sp9iw-0003Vh-Mi
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:04:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so15574665e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726247084; x=1726851884; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nf77AkmrcAbEnkvfBcK6xlbbU0n+IgL/oSDI45kKL30=;
 b=iqY6JMWfFshTo6CenaE5k4h9UPxFNKqERWXKxvN5l70TSd2WjLHxBjwNw+GXT8yqsJ
 IhJKgiuZnm73RwWBarEy/MdzDPEWRPPc9aJXOa1SWeSuIXgcn7UOoPFkKk3yMj6tEowB
 BmPC3nA34X82WiBKpSxReSAzty0huPm9uxEh51p/ATw7oM+VkZvry71zyTQjFjBrYiXG
 ZpcofxA3ldOEORlRt6UB+AKgDQ0Cn+MVPwXdG9oO4r74Sp3a04xOcpvhQxIl13VtM8Qf
 JaVTNzHKk1gT9wW+PiT3E7MTZrgdt7VOE0c1jo/lFIiklI1SP1uk+uG9XgRPgBqtcPUl
 PM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726247084; x=1726851884;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nf77AkmrcAbEnkvfBcK6xlbbU0n+IgL/oSDI45kKL30=;
 b=Dr306I9sVrqTZYdemhHtXVEcyd5+Txu3kSygpAZ+5Hwzod+2powmq9YpJeQjjiqtPc
 Ez2XLcNWU+Rq1vfoicicpkj08TbMyBQQFa8bEc96QQZdE+OCy9ewAPQxHjV+8beMyzwx
 ZUShAZQ51xtJDl53LdYekUYuuqzrOjdyMwTvyk8eTDEjdQqfnjRFgsvKwXQZnuiLKogR
 soJJYWy+X2qOlFp5B6H67MUeq1sO800vD5wPp9I4Co11y8l24oL7jRIzB9URZN4BOFac
 E1YQd+p0pDWo5MeGkCvyY0JeCNjJ/uTOynlssCCKif2L+2AHY1jZh7ryaDPjWZ8REAJ3
 SoIQ==
X-Gm-Message-State: AOJu0YywC/wpkiwbM3ExsnAxw0VId5C6vf8dc9a9UrsFzDer2bhkua8c
 CApa5Y8gYFl3MdbUYwBd2SiKxpS84HLqe8cN1q7lZj/9XlwOovXj43fV9voYRcJfP5CFm95Sk61
 0
X-Google-Smtp-Source: AGHT+IEFCoPz0NjLiyxm36h7aI6lAXYbKTxNU2V/yNeW43wFq27uzDfW27jh12kQ6uFZhwSDMpULTA==
X-Received: by 2002:a05:600c:1c9a:b0:42c:b187:bdd5 with SMTP id
 5b1f17b1804b1-42d964d6625mr37165355e9.22.1726247083838; 
 Fri, 13 Sep 2024 10:04:43 -0700 (PDT)
Received: from [192.168.69.100] (uni14-h01-176-184-39-243.dsl.sta.abo.bbox.fr.
 [176.184.39.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b05d707sm31675795e9.14.2024.09.13.10.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 10:04:43 -0700 (PDT)
Message-ID: <d924bb8c-32a7-4f24-8799-5c33f9497988@linaro.org>
Date: Fri, 13 Sep 2024 19:04:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/61] Misc HW & UI patches for 2024-09-12
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
References: <20240912065227.67848-1-philmd@linaro.org>
 <CAFEAcA9uxg_du0PQKpFf-tmcQWWY-u54v7c685F7JNXF2vKpsA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9uxg_du0PQKpFf-tmcQWWY-u54v7c685F7JNXF2vKpsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 13/9/24 16:30, Peter Maydell wrote:
> On Thu, 12 Sept 2024 at 07:53, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> v2:
>> - Fill Pierrick's commit description suggested by Eric Blake
>> - Include TMP105 fixes from Guenter
>>
>> The following changes since commit a4eb31c678400472de0b4915b9154a7c20d8332f:
>>
>>    Merge tag 'pull-testing-gdbstub-oct-100924-1' of https://gitlab.com/stsquad/qemu into staging (2024-09-11 13:17:29 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/philmd/qemu.git tags/hw-misc-20240912
>>
>> for you to fetch changes up to bd480a2baab659abe90da878bc955670691f53a8:
>>
>>    ui: remove break after g_assert_not_reached() (2024-09-12 08:44:48 +0200)
>>
>> ----------------------------------------------------------------
>> Misc HW & UI patches
>>
>> - Remove deprecated SH4 SHIX machine TC58128 NAND EEPROM (Phil)
>> - Remove deprecated CRIS target (Phil)
>> - Remove deprecated RISC-V 'any' CPU type (Phil)
>> - Add fifo8_peek_buf() to correctly handle FIFO wraparound (Mark)
>> - Minor cleanups in Designware PCIe, PL011 and loongson IPI models (Phil)
>> - Fixes in TI TMP105 temperature (Guenter)
>> - Convert Sun ESCC and ADB mouses to QemuInputHandler (Mark)
>> - Prevent heap overflow in VIRTIO sound device (Volker)
>> - Cleanups around g_assert_not_reached() call (Pierrick)
>> - Add Clément as VT-d reviewer (Clément)
>> - Prevent stuck modifier keys and unexpected text input on Windows (Volker)
>> - Explicitly set SDL2 swap interval when OpenGL is enabled (Gert)
> 
> Fails tests on some CI configs:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/7820098438
> 
> ERROR:../tests/qtest/tmp105-test.c:103:send_and_receive: assertion
> failed (i2c_get16(i2cdev, TMP105_REG_T_LOW) == 0x1234): (0x00001230 ==
> 0x00001234)
> (test program exited with status code -6)
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/7820098228
> 
> ERROR:../tests/qtest/bcm2835-i2c-test.c:84:test_i2c_read_write:
> assertion failed (i2cdata == 0xad): (160 == 173)
> (test program exited with status code -6)

Sorry, I neglected to test the tmp105 patches on CI before posting v2.

Guenter I'll squash on patch #48 (lower 4 bits):

-- >8 --
diff --git a/tests/qtest/bcm2835-i2c-test.c b/tests/qtest/bcm2835-i2c-test.c
index 513ecce61d..1599194926 100644
--- a/tests/qtest/bcm2835-i2c-test.c
+++ b/tests/qtest/bcm2835-i2c-test.c
@@ -81,7 +81,7 @@ static void test_i2c_read_write(gconstpointer data)
      g_assert_cmpint(i2cdata, ==, 0xde);

      i2cdata = readl(base_addr + BCM2835_I2C_FIFO);
-    g_assert_cmpint(i2cdata, ==, 0xad);
+    g_assert_cmpint(i2cdata, ==, 0xa0);

      /* Clear flags */
      writel(base_addr + BCM2835_I2C_S, BCM2835_I2C_S_DONE | 
BCM2835_I2C_S_ERR |
diff --git a/tests/qtest/tmp105-test.c b/tests/qtest/tmp105-test.c
index 3678646df5..85ad4eed85 100644
--- a/tests/qtest/tmp105-test.c
+++ b/tests/qtest/tmp105-test.c
@@ -100,9 +100,9 @@ static void send_and_receive(void *obj, void *data, 
QGuestAllocator *alloc)
      g_assert_cmphex(value, ==, 0x14f0);

      i2c_set16(i2cdev, TMP105_REG_T_LOW, 0x1234);
-    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_LOW), ==, 0x1234);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_LOW), ==, 0x1230);
      i2c_set16(i2cdev, TMP105_REG_T_HIGH, 0x4231);
-    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_HIGH), ==, 0x4231);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_HIGH), ==, 0x4230);
  }

---

Regards,

Phil.

