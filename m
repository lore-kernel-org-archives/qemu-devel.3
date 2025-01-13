Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80CEC02183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 17:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXOIM-0006vV-Vt; Mon, 13 Jan 2025 12:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOHr-0006n0-OQ
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:31:40 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOHq-0006OS-5Y
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:31:39 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso52620315e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 09:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736789496; x=1737394296; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O0pPAsCWt0YA4J6mEfP48d7QYH1eIPWX4k5hPTqjmeE=;
 b=L96VjnazgUhoytyTHcTfHYeD7P6Etf3ngxaM5U0WLMvFm7C74WQtGu2oUQ9COyKK74
 LMUzZ07lDb1ghVz3YP1NZpjM/E3Zo4lf69zy9slA0wEM4WzCB2S23BUO8qktDipgqbk5
 OivJmBSPp7eHl61LbdjGOgeKzAcstSRKj3AEjB/IhZ8aipwwBD7LwHB7Ktw7URw5ztKO
 rwANZFGuxM1iEIzXb2sieaOHu9NjUhgnOkDljtJOdfLXJ+R5TCSy41f9zne1PruquRKE
 ymPdD162FjqDdgD6GbFnpBydQtyVCzDazEbdqZAb4esZR+UmrJ3wCK8ibWM0bxhGRbOf
 /0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736789496; x=1737394296;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O0pPAsCWt0YA4J6mEfP48d7QYH1eIPWX4k5hPTqjmeE=;
 b=qEcCjV8m9HUOhf0lazJW8GVOpTZ5f4SH4ezw5bss5d1Q8tBdIa9HxgazaHWVDqIDxz
 TzrhA2v7N7e6CebaZgNmis4UGCTxuNqpePTXNaEmZ+C2jm4+/4ad8b7PIIjVsJiLbEai
 GMEc9cv+hdxbHpf/Gs1ZSWyxhOXGM8s5ACfi9n7cWpMVAu953BtQrD+B72IExSw1zocm
 E2mg2ZTPaUZeICLwGMF7B13ecKsnnKknjZUBHllqq+YdEO+HSmw2H4HKwvgZscSShhOf
 KPavUzE8oFrNZeK3jtHj3mCrf3yIEKPvTUxQoezI0J5KRHkJzK5UTzZySbO5gMbHKS5X
 0Y8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG8I1uCP85QH6Sy8Dapix85E0D30XZJ71dCVYEKa62HKJFZ3AyezAlrNGW6wehrL0Lmse2NMzTy29v@nongnu.org
X-Gm-Message-State: AOJu0Yykf/MRhkf7arawMTJFZMQ7zIfLIQLYfyH5b11rErHWg1G2jnUp
 E/ga1D7XtXh0MC0WcWpFnJadMerOptSFbIcRMV7TU6aref1M/EoQSXAKu7Hmw6w=
X-Gm-Gg: ASbGnctzA7zFIHbif7qy4DaviLfzbmScIxj1nURMgXg0CiCnEpypq5fIcnaKsrmI4is
 G149oY7g0YBISR34jfVFvz7oKHav1749KrqijPHWa/peqlM3yYMWyTTgYkWR3TXgCwf+/pDbxku
 nZ001oemy9ncCxVNlKSbR/BocDspsL7ugh0Sp/7C/XykTqSdWHhfz0RZOYg6skOg0cB3BjLJdWk
 JG2LCRNe2n0LOPXuCy5Ah3AenIJ8pTImTwActZgbpLZ6nXIYgcW8Mmyt5VVATMpz+ICW94BLlJ0
 1pRGy7eXjZ4pj5I210ObpKWn
X-Google-Smtp-Source: AGHT+IFR8w6o6SaSqEuL8SAy2aMnGvqvhUNSl9pTvjcvpcszbMkZh4RlAKKBZU+RBw3lzmuByReiAA==
X-Received: by 2002:a7b:cc8e:0:b0:436:faeb:2a18 with SMTP id
 5b1f17b1804b1-436faeb2c2emr42873235e9.6.1736789496405; 
 Mon, 13 Jan 2025 09:31:36 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b8116sm12614356f8f.79.2025.01.13.09.31.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 09:31:35 -0800 (PST)
Message-ID: <428a5e3e-966e-4dd2-9597-4f476e5c16f3@linaro.org>
Date: Mon, 13 Jan 2025 18:31:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/11] New vmapple machine type and xhci fixes
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 marcandre.lureau@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-block@nongnu.org, qemu-arm@nongnu.org
References: <20250112210056.16658-1-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250112210056.16658-1-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 12/1/25 22:00, Phil Dennis-Jordan wrote:
> This patch set introduces a new ARM and macOS HVF specific machine type
> called "vmapple". There are also some patches for fixing XHCI spec
> compliance issues and adding a workaround to a quirk in the macOS guest's
> XHCI driver.


> Phil Dennis-Jordan (3):
>    hw/usb/hcd-xhci-pci: Use modulo to select MSI vector as per spec
>    hw/usb/hcd-xhci-pci: Use event ring 0 if mapping unsupported

Patches 1 & 2 queued.

