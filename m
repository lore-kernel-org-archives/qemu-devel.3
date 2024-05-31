Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC29CC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 10:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCzwF-0000kp-D4; Fri, 31 May 2024 06:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCzw9-0000kI-IG
 for qemu-devel@nongnu.org; Fri, 31 May 2024 06:56:41 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCzw6-0007Qj-Nb
 for qemu-devel@nongnu.org; Fri, 31 May 2024 06:56:41 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57a033c2ec2so1953502a12.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 03:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717152996; x=1717757796; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tp0wCDPgtOUp4XCB4v5QEpIMFr9FdQc2XXblJrDYhrQ=;
 b=Kx0fvGhDByDQRUr04ybK2UtVKFgeSRXw4CfbUCq3lyrjWyVINgt4e2TkCjVYw5af6c
 cclcOSz73fFVcsF+OFfm8q7lBWtovWEDiB2mcoRsZm5kbR1KAWxUl0ZHtZTd7yQ5kibq
 hZjKBdKW5Uqct3oeJvmCdDo0KXM7qX4kqLl+f+VBynBEujrkUxeuC2aZF8WN2i6nENRJ
 P2fkibLAOyhXfAOctw0Ad7FKjsbp/d0errKsfAocSRrQz/cnVjaO+F0qJnJvXq0uAHD1
 hUSDcw+7oQxpYrfB7hotl/I083jeXfW628PvWo50JTaCVxA8lWcYoiFoCSSHYKWh1BP1
 Pz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717152996; x=1717757796;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tp0wCDPgtOUp4XCB4v5QEpIMFr9FdQc2XXblJrDYhrQ=;
 b=rqBTwNmhrBRf7jx4RbVRtaGZucRY/WiEFKtaslSrjGsdW7Dd07Wdw/hl09Pjm7RXVt
 KtpBryvtmCG6u701XekFCrSDO6LMXnRQhwxLQ0Sf+WfCKk+mldnD017ixYJnwGAE9Ifg
 uP8MN3rv3Y9/rCSy0Qz9aumFh3SLeeH8EHSw+i3ezWZVQrOi3RmD5CZ8ISuEeZk9fhS4
 e8qDUdMcvfIVJAVm7Jz8OyJGnKf88EuD5FmQyBHMejMKZa0tdkPW14FrBHMP4wPOz0Pp
 eLJWanJPaw8fNxiLmPtcAKaViSdtzhVY8CFrgkEEya8ph4UA1LXLhw5PvyT1iAXgTDnx
 c40g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuVW3kilgWy+MJKZWhueBrey17nsuj9JdCVxbf6S/znX/X2r1c+VScZufK62r0f9E1JPjsqhguPipTGqYXiNZfnNA2KQg=
X-Gm-Message-State: AOJu0YzGvv7IZgFrPInZjmbGrdferWmh4xTZadRBH/4VUkyP0lNNZcjs
 oGI7gYl+U/k4qDzTQCmeSIUMabOfOOyiwPnLSxg2e4yF7YRHrmH/765wvX59jc8=
X-Google-Smtp-Source: AGHT+IFVc4pFweDSj7GtrW0cQicv+U8Usk7CZ02NzKb1aXsOaLUiRlf3oIUQlJn5OIIPjeuEYfpFwA==
X-Received: by 2002:a50:d502:0:b0:578:5c58:9fb2 with SMTP id
 4fb4d7f45d1cf-57a363f15f3mr1143983a12.17.1717152996162; 
 Fri, 31 May 2024 03:56:36 -0700 (PDT)
Received: from [192.168.69.100] (sml13-h01-176-184-15-35.dsl.sta.abo.bbox.fr.
 [176.184.15.35]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a3173c8c3sm876220a12.0.2024.05.31.03.56.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 03:56:35 -0700 (PDT)
Message-ID: <9e6b3c9c-4962-411f-8f3c-e3614074b96c@linaro.org>
Date: Fri, 31 May 2024 12:56:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/16] aspeed/soc: Add AST2700 support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <20240527080231.1576609-13-jamin_lin@aspeedtech.com>
 <7ea55928-e61e-4112-992d-b899c65b4652@kaod.org>
 <SI2PR06MB50411ED51276574422E07948FCFC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <a2aa3c01-51dd-4517-9261-038fff11f091@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a2aa3c01-51dd-4517-9261-038fff11f091@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 31/5/24 09:46, Cédric Le Goater wrote:
> 
> Hello Jamin,
>> I refer to versal_create_apu_gic function, 
>> https://github.com/qemu/qemu/blob/master/hw/arm/xlnx-versal.c#L67
>> and updated aspeed_soc_ast2700_gic as following.
>> If you have any concerned about the new changes, please let me know.
>> Thanks-Jamin
>>
>> static bool aspeed_soc_ast2700_gic(DeviceState *dev, Error **errp)
> 
> Please rename to aspeed_soc_ast2700_gic_realize()
> 
>> {
>>      Aspeed27x0SoCState *a = ASPEED27X0_SOC(dev);
>>      AspeedSoCState *s = ASPEED_SOC(dev);
>>      AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>>      SysBusDevice *gicbusdev;
>>      DeviceState *gicdev;
>>      QList *redist_region_count;
>>      int i;
>>
>>      object_initialize_child(OBJECT(a), "ast2700-gic", &a->gic,
>>                              gicv3_class_name());
> 
> and object_initialize_child() can be called in aspeed_soc_ast2700_init().
> 
>>      gicbusdev = SYS_BUS_DEVICE(&a->gic);
>>      gicdev = DEVICE(&a->gic);
>>      qdev_prop_set_uint32(gicdev, "revision", 3);
>>      qdev_prop_set_uint32(gicdev, "num-cpu", sc->num_cpus);
>>      qdev_prop_set_uint32(gicdev, "num-irq", AST2700_MAX_IRQ);
>>
>>      redist_region_count = qlist_new();
>>      qlist_append_int(redist_region_count, sc->num_cpus);
>>      qdev_prop_set_array(gicdev, "redist-region-count", 
>> redist_region_count);
>>
>>      if (!sysbus_realize(gicbusdev, errp)) {
>>          return false;
>>      }
>>      sysbus_mmio_map(gicbusdev, 0, sc->memmap[ASPEED_GIC_DIST]);
>>      sysbus_mmio_map(gicbusdev, 1, sc->memmap[ASPEED_GIC_REDIST]);
>>
>>      for (i = 0; i < sc->num_cpus; i++) {
>>          DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
> 
> Could we avoid qemu_get_cpu() and use the cpu array of the SoC instead ?

If it is too invasive, I might take care of it later when respinning
https://lore.kernel.org/qemu-devel/20231212162935.42910-1-philmd@linaro.org

