Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768F3C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 18:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZvA-00051V-4P; Fri, 23 Feb 2024 13:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZak-0003AO-Nx
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:44:10 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZai-0004dD-MR
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:44:10 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a3f5808b0dfso152489166b.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 09:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708710247; x=1709315047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6af/0QDU+kWNVY1p8K0vhdMQDrlBcIdcr0+mt/stI2c=;
 b=OMCmJVbBJ8Iw2V/VcfkPBR5V/wmsAOYObxwBZ5+6/mu9NkTlItF44R5BsuscfXhNPR
 oHy5Nr/duq/7y0vDwfYd/W8OeKVZjH/uYtrg24dXLIQ9LFhw0pp4PYcP+oKgAVEQDDxd
 2oaxbIYJfHGApEXvkjGJfmdA+inxhoRhgXC+6fy7YOaLS2dzWl7h/zStl9UnNpfbtowe
 d2IHn2Y7IFLUkNPqJ/bswY8R8mdEn834eNBD2ejP9O19Krpsj7+0qn1r2a2UGfsTH4SB
 2Ajh14o2bc86LNfQUEN1kPSSJPfKYTpTz8DjU9m/c5N8fSI2JEjaomZd+nxB0TjDUF7x
 ugrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708710247; x=1709315047;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6af/0QDU+kWNVY1p8K0vhdMQDrlBcIdcr0+mt/stI2c=;
 b=JZ2Os9dRjM9U/vjSu8JrD1IGH8eRVKBJyIq+qYX4M2jleOoPA7c7UKTIgGEBlHDIgf
 UMkYDWLkPBjdWD7detyY7ks8AU7KO+Y2VYYqf4siOT2JWcseIA+pK1616cryf9f+6Im6
 Hy32VTiRtnOs/vZe+XFkc+xhtAeUX/sK6mdbhUgHGlKgzNHZJFn+COfqTZUcS2xb5rw2
 NpTVZrjxEbfmbxGc5Vao17e9aRO23GwbhBysEB0U1D3caetPV4f3k2HU24+7H2IFoNpF
 QllXGm1fXoYG+/pOnl3684zQJM/f+4n7GSkw0mizdWywNcGTL8XGf3SA9HUsEND8ev+L
 XHqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIGqH49QIz/1n/XLHNp0pTiAlpzQ9tved+O3ATtOzjjqQWOJPKEPXlUVWxZGXHWpup/PYFJTd+riN3JfXo0GSyYJGSwkg=
X-Gm-Message-State: AOJu0YxAiOY5r2gg+o//ojSRYrPnx24yXAVsbgAmkEeWKlLCZbFPcEzL
 01rmF5yidPjqqnLyy9iH5+2sxKj3UHKmz1P0Op3709QYT1OgIEyTI1iIiz4YY9o=
X-Google-Smtp-Source: AGHT+IGjt19ZafItpn9Wg+pZr1cpOViXcrUcE2ULc0fqgTEGua6O/Y76Slzd4Dsd74sScngBm71JxQ==
X-Received: by 2002:a17:906:260d:b0:a3e:5de6:701d with SMTP id
 h13-20020a170906260d00b00a3e5de6701dmr348222ejc.50.1708710247297; 
 Fri, 23 Feb 2024 09:44:07 -0800 (PST)
Received: from [192.168.69.100] (xbn44-h02-176-184-35-109.dsl.sta.abo.bbox.fr.
 [176.184.35.109]) by smtp.gmail.com with ESMTPSA id
 cx7-20020a170907168700b00a3f1bf036d5sm3258323ejd.16.2024.02.23.09.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 09:44:06 -0800 (PST)
Message-ID: <ca9faf4d-e5ee-479e-88f7-043f6bb8cea6@linaro.org>
Date: Fri, 23 Feb 2024 18:44:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] nubus: add nubus-virtio-mmio device
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org, elliotnunn@fastmail.com
References: <20240111102954.449462-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240111102954.449462-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 11/1/24 11:29, Mark Cave-Ayland wrote:

> Mark Cave-Ayland (3):
>    nubus-device: round Declaration ROM memory region address to
>      qemu_target_page_size()
>    nubus.h: increase maximum Declaration ROM size from 128k to 1Mb
>    nubus: add nubus-virtio-mmio device

Thanks, series queued.

