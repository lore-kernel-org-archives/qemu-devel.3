Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1BEC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 15:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdAMK-0008Ab-N8; Thu, 22 Feb 2024 09:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdAM9-00087f-TM
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 09:47:31 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdAM8-0001nq-4G
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 09:47:25 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33d32f74833so1310642f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 06:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708613242; x=1709218042; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ig1zQ5yAhvNeIG9dSEvmApyUP139yhXRSsTZspye650=;
 b=D1PDvOb84K3aSx9v/A6FYEl69vmlqofiDN6Bm0d3nX4C/FCZGBlO+fdRVUSyl3QMOk
 cwFsAf2c6SBsH0pVdVYtwJ85NQzUXngrD2mvCIZxaXkTqLL6IuJ/kwtNXgb48YXoTd1b
 4uQRbtrVNAyqxCCKpq2y6WR0b9eGMLz8h09LC5ODBFQ2GtX8BGb/cjZ8rec9XbRcTy+l
 s+APEUhqANYhRyOPn69HYsig8bjYjjiYt3otYGj86HC7GQAHpT07eoaW/VRQZT7uk0oE
 AmVikWcQJ7VsBNYmN7N+3rxIOeDN9L7eeNX/SuiqDCk9DweaqFm0xSeIDH1z6Ul3rbhO
 IqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708613242; x=1709218042;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ig1zQ5yAhvNeIG9dSEvmApyUP139yhXRSsTZspye650=;
 b=uDxzP68X61UuDo2X3RJr+bSWGdSbdYltoY0LPxr6AX7TRVYcWPysYe8Ifym8/bpwCw
 qPf9fuDpyCgT7ZtiVzOtIYeOYmo/w7gyuBhH/lIeaFeCBh8RiebRE01RNogAlcFbdj5e
 N11xlX6rCWYdJG3ydt/WiDbqIroSf4APYTT6uDGFOyoKGAn36pX0o8CQqAM7/rNaFIRS
 zTSHabBSxA2t4I4m5Y+Bw5mwmmqmCaoE57Aej8RwQVRdZVlIIfiPzsdyXHkmMJ3FYZwx
 CVk49X+Lzpq4Wvx8ykcgOLzB2Q7pt774JPW78tumvPvSedewDMbqcUz/AKIe2MwO4tuB
 y9lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV11gipGEINTrEIM3qtoc9cixXLrZOyN1Jg3QWMj9lw1Fl8Qt9ubl3aG505yeqMns3SfMazR38TQGbWtnU/yqFNyem9Aqs=
X-Gm-Message-State: AOJu0Yy8+F8TScNeyss+fbXhfEsWk3+S7yaoBPXW2R1Mxk6SdmiMxAkm
 e3MoFyi3w22Euki9NbaNP11e661LlQoPFng2A6q5GppQbuPAvfbkzYGep4SRwBE=
X-Google-Smtp-Source: AGHT+IHzO4C/HHgUmxAV4JJFLSC92PSbv6ZbYvSpW0d4vhsFfUbovstJ0ayKa/dCf+4Ie2xlWvvXMA==
X-Received: by 2002:adf:f60d:0:b0:33d:27cf:6208 with SMTP id
 t13-20020adff60d000000b0033d27cf6208mr10477182wrp.7.1708613242063; 
 Thu, 22 Feb 2024 06:47:22 -0800 (PST)
Received: from [192.168.69.100] (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 df2-20020a5d5b82000000b0033d6c928a95sm8796319wrb.63.2024.02.22.06.47.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 06:47:21 -0800 (PST)
Message-ID: <aedde374-0a7a-4a38-9149-7002c627b743@linaro.org>
Date: Thu, 22 Feb 2024 15:47:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] hw/i2c: smbus: Reset fixes
Content-Language: en-US
To: minyard@acm.org, Joe Komlodi <komlodi@google.com>
Cc: venture@google.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
References: <20240220211123.2664977-1-komlodi@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240220211123.2664977-1-komlodi@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Hi Joe,

On 20/2/24 22:11, Joe Komlodi wrote:
> Changelog:

> This series adds some resets for SMBus and for the I2C core. Along with
> it, we make SMBus slave error printing a little more helpful.
> 
> These reset issues were very infrequent, they would maybe occur in 1 out
> of hundreds of resets in our testing, but the way they happen is pretty
> straightforward.
> 
> Basically as long as a reset happens in the middle of a transaction, the
> state of the old transaction would still partially be there after the
> reset. Once a new transaction comes in, the partial stale state can
> cause the new transaction to incorrectly fail.

Sorry for jumping late, at v4. I'm a bit confused by this series.

- AFAICT there is no in-band or RESET line with I2C, but
   the AN10216 document mentions:

   I2C Bus recovery

   • Typical case is when masters fails when doing a read
     operation in a slave
   • SDA line is then non usable anymore because of the
     “Slave-Transmitter” mode.
   • Methods to recover the SDA line are:
     – Reset the slave device (assuming the device has a
       Reset pin)
     – Use a bus recovery sequence to leave the “Slave-
       Transmitter” mode
   • Bus recovery sequence is done as following:
     1 - Send 9 clock pulses on SCL line
     2 - Ask the master to keep SDA High until the “Slave-
         Transmitter” releases the SDA line to perform the
         ACK operation
     3 - Keeping SDA High during the ACK means that the
         “Master-Receiver” does not acknowledge the previous
         byte receive
     4 - The “Slave-Transmitter” then goes in an idle state
     5 - The master then sends a STOP command initializing
         completely the bus

- For SMBus Specification Version 2.0:

   3.1.4.2 Power-on reset

   SMBus devices detect a power-on event in one of three ways:
   • By detecting that power is being applied to the device,
   • By an external reset signal that is being asserted or
   • For self-powered or always powered devices, by detecting
     that the SMBus is active (clock and data lines have gone
     high after being low for more than 2 1/2 seconds).

Questions:

- Is the first patch "hw/i2c: core: Add reset" really for
   I2C? Otherwise we could expand smbus form i2cbus, and have
   this reset only for smbus.

- Should we model the "I2C bus recovery sequence" before
   triggering reset?

- Shouldn't we model the smbus 2.5s timeout before triggering
   the reset?

Thanks,

Phil.

