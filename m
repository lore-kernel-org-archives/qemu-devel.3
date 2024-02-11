Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D310C48260
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Feb 2024 00:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYxjk-0006eQ-O8; Sat, 10 Feb 2024 19:30:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYxjj-0006e3-UN
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 19:30:23 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYxji-0001jy-5Z
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 19:30:23 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5dbd519bde6so1565028a12.1
 for <qemu-devel@nongnu.org>; Sat, 10 Feb 2024 16:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707611420; x=1708216220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ei90xbefp4rK5IZOdRsSEwpiYxuT/A+b8qEYgQ4kJ6s=;
 b=y5uUKUxHFFXFadcipQZV7n32J7juy3W/RQaESo//F/ePgXhow5mrq4QI8BbcGJyFBd
 KF0Y3L2tJtug8TXe2ARPYf+kBIaFenwb6NbjAGxMIQGtf693GbZnd0wvVYve4yOZgqOw
 D0BuxKiBmoOfTRXZtxvWxfMvSsh/vVjXBX4GKfqPZAFr/9dHkRcuBiDR+2IMbqWyJSEv
 C7DjwAEik3dHyj1sOdAe90eFV7NMXH9MJGnht0ag37NoJqW3m3Wm0Ya/1AXJmW6KLVdp
 ipyMfmjlIWjISmVM98MZGkxBkRKRkkw/uuPsn+z+bFb5083TCO/xzbSlxZMSM09vPF/k
 26sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707611420; x=1708216220;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ei90xbefp4rK5IZOdRsSEwpiYxuT/A+b8qEYgQ4kJ6s=;
 b=MQQXYRbGG/MQYbQhtClt6AHykvdtc/m8e9SMzOKPBXFcBV3z1A/GSpfyjr+2M5GXok
 +8fIVjt3C/oNvvA/9PmEymMQhI5vRgwLo4XAeAv/9tUItRfHElrMMkQPbSu5SgF4et1X
 H+HDn0juR6m5GbUmjLhtvdJLloSEoLr+tHXIMobOVE7Cq8Xa2Ab5bOmiQhvjMhjqD6RU
 TJWc8G7O7EdX9U3JcnNIZsPYfJsX0XkKSZ1WccTgnqstP5dXWlhoIsTrJ4w9LV3iKYma
 G9ywB9+IZABYY1mqIj8oWB04vbhd/ytZS2eUc8Dr67FwJVQOpTkhwy8S7itfIg02HCQm
 77ZA==
X-Gm-Message-State: AOJu0YwPmQUGwbj+93Xbl37zGAlSolAjURa8skmFtdTKcDaKiTl78RP+
 9JiOTkPezvBN/vBkuif+rZgMnziXBk/MCnwh/7tH9Ug4LLdmSBgW0BDJP+iuQzo=
X-Google-Smtp-Source: AGHT+IGv0zVg/uPO9r1QqOZ7KTPRZSY23VWBpavMM+giFwamWiAjlMNyssk5m3C74Y9sOOwn9Bcnvw==
X-Received: by 2002:a05:6a20:ce47:b0:19c:93b3:c669 with SMTP id
 id7-20020a056a20ce4700b0019c93b3c669mr2544207pzb.29.1707611420636; 
 Sat, 10 Feb 2024 16:30:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW8yCi+45OFhoYUEFcn3shL3VcugNJ0PCB55bCo4UF1znMH0mKhwOzfwUR12740wCgEYKrfoEfdkKRO0mtgfOAWEXA7pMspuvOwTNL4LH8Efn7m/WT1z2EFFmB2sTUZFvslRCupHhrpCS4=
Received: from ?IPV6:2607:fb90:bde1:38:fbe0:8943:a8ed:9394?
 ([2607:fb90:bde1:38:fbe0:8943:a8ed:9394])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a170902bc4b00b001d6ee9d8957sm3502695plz.281.2024.02.10.16.30.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Feb 2024 16:30:20 -0800 (PST)
Message-ID: <3c13da7d-333d-42f8-83be-55e4404d5c82@linaro.org>
Date: Sat, 10 Feb 2024 14:30:17 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] target/hppa: Add "diag 0x101" for console output
 support
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>,
 Jason Wang <jasowang@redhat.com>
References: <20240209115633.55823-1-deller@kernel.org>
 <20240209115633.55823-3-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240209115633.55823-3-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 2/9/24 01:56, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> For debugging purposes at the early stage of the bootup process,
> the SeaBIOS-hppa firmware sometimes needs to output characters to the
> serial console. Note that the serial console is the default output
> method for parisc machines.
> 
> At this stage PCI busses and other devices haven't been initialized
> yet. So, SeaBIOS-hppa will not be able to find the correct I/O ports
> for the serial ports yet.
> 
> Instead, add an emulation for the "diag 0x101" opcode to assist here.
> Without any other dependencies, SeaBIOS-hppa can then load the character
> to be printed in register %r26 and issue the diag assembly instruction.
> 
> The qemu diag_console_output() helper function will then print
> that character to the first serial port.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   target/hppa/helper.h     |  1 +
>   target/hppa/sys_helper.c | 36 ++++++++++++++++++++++++++++++++++++
>   target/hppa/translate.c  |  6 ++++++
>   3 files changed, 43 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

