Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECFA10F285E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Aqs-0002V8-KN; Fri, 27 Mar 2026 13:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6Aqq-0002Th-Ol
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:20:04 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6Aqp-00036V-A5
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:20:04 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b97e6e48b24so415962566b.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 10:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774632001; x=1775236801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uK+Z2QjEuZMNmcPHsRGjTiigWNvAt8u3TcTXJJ5xEM4=;
 b=FZLDDPNp6GCIPAT8HA5JMzf5TW2JROnKMKvjV+XhJys0DgfGtCLBTecB1QkRtLTzco
 EiDINeP9M2HEfeuU/5KA8plty67KOg1xkntyVMEsVQ9GhR1sSljSKVeGSvTDa34T7LrQ
 FdSBoG8V0E5TlfBDp8cfGCxtS0BaOskQOkMKuDqdyPr2r7Iu8tK0XFOvaU4y3JJknIZN
 maxAYBGiLEn7iJ0Ap38BHvAdkdpkQDBnWzoa09W6SdEbACjtBharxwFiyMXBDN4NsdPC
 FzLMH7L/ekWkVnkOiFuAWINJOd1IsF8kPKHJZGnA6hLVGH6GnH3Lu4Zf8xhw9bgD+kmh
 A3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774632001; x=1775236801;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uK+Z2QjEuZMNmcPHsRGjTiigWNvAt8u3TcTXJJ5xEM4=;
 b=a53F7gBI5e2TZVINSp5eIZoGPEkpJisw1qMA/tiyFhufnyG97Odgn5TrDCbfDnUhTU
 WVW9EUZkWDVbeSqMcP+0CHyJS4flyopDtoC5UANfId4E2i1Z7UaWwvP9mRNYllU24p5b
 IAIxiVUqacSn+Uuqyag9afKrN9htUsMVYBCRL4iOFrMK7ugCLIlvun/37j7cr2y/8lk1
 yN6rLu6gcyFzpCdtdMIprmbPRNLyLYtaydNBeAFlFa4q114/nZttH98KYW6gbIi7ZmJF
 r8KL5orzyyMo31rWJu0Hwf7hR0Pz9KnLdHuKlojLaEJ8Hyq1A3GDaxMrJwyOw8t6LXji
 Gt5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWCnKMegLSG+zcEUUI7paYqUtZLVqyUJRSgCDJQJe/QTpeAxscRuknzvXV0ofkgxUxaMLbLpThDCPE@nongnu.org
X-Gm-Message-State: AOJu0Yyem4sjLRbHvyGbvbx83obUMjgEZpjUatl/jxIuuZfnEimJjRCv
 dO6nGL+usPPJbyVW93cbDRzo1pRrnVoVO5GvOKqKyajUmNMossq98MNW+rV/7SDqj1KKsL/60cQ
 eUe+b9q0=
X-Gm-Gg: ATEYQzyj4GewOzp5fRTsb8EXRVyBVbjtPGSFa1QeqdKdah4m6iNuPfyVndEUx4KnsT7
 X1xHouayNohQ3RNzqDLyBGZmLCJtPeiOEFPpiRh0WIquz7dOvgUmRE5YqOCwtt/w9Z4c+cmPJuZ
 ZFmsc10x1hnvHi0vzWpPKF+gLlQw5VjmHIuQH3Sbkt0MrLLqNBgu3aco9pmCaj/mAjxi6+ZKv3r
 2Ix9SdygprCjJOPrTH2YKGAJE9DbN/BYS5Srdkp78rh84GnH/8W+evHbn6p7ufCBFAvFR5fdbMu
 3bsPmRpaHs1fBGnQ96csztl2oPKNVuh7HZWviH055exSe3KjRXyf1yY8ImcaWGU4CtwQJcIdZ6v
 Jy+oIJf2gg/eIlmzK0st6y3QE7M3enwhsh3t3AyeTEkviDfThpIl1qr7nwfoGTs+cJuuXqx/ORP
 GvEW2okU9WEmsB0lx6xDw1cgGHyCDy/Hf4CIOHTi5GhlTyb5/abjgIl6Ku4jRP8Q==
X-Received: by 2002:a17:907:3f87:b0:b98:2462:959d with SMTP id
 a640c23a62f3a-b9b508f61c9mr237585566b.31.1774632000545; 
 Fri, 27 Mar 2026 10:20:00 -0700 (PDT)
Received: from [10.202.147.66] (109.243.130.77.rev.sfr.net. [77.130.243.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b203ef948sm273267366b.46.2026.03.27.10.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 10:19:59 -0700 (PDT)
Message-ID: <e75807ff-fa40-4ed9-8d6a-4323feacabe1@linaro.org>
Date: Fri, 27 Mar 2026 18:19:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/cirrus_vga_isa: Disable global_vmstate by
 default for new machines
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260326154850.301609-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260326154850.301609-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 26/3/26 16:48, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> In the long run, we would like to get rid of the code that allows to
> register migration state globally, so set global_vmstate to false when
> using the isa-cirrus-vga device with new machines, and only enable it
> for older machines to avoid breaking the migration there.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/core/machine.c           | 1 +
>   hw/display/cirrus_vga_isa.c | 3 ++-
>   2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

