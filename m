Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C481C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 08:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjbHj-000272-3u; Mon, 11 Mar 2024 04:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjbHf-000266-Nt
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:45:23 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjbHT-0004Rr-En
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:45:16 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33e76d653b5so2760046f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 01:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710146708; x=1710751508; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YqRWKpf3wPnvG+NAnIxIBlxW5VBhFD7P+Nga7DrY8YA=;
 b=gdR1NXLSux7z2F5/AMwsoSn+nKgsKhkLxcyBFJj2AmSvIY4gwtaZVkUvqYkMnH1qur
 7lJDvY7XWbSib6Fav0Kdpr28pg3zV/Y3+kBvaYPfs6xzrfGMby5PtUz0NYaNMOV7Yk+7
 adtzaOcjrsFTkoPxYoBhGfcyHqqiMKnlz0F1Y4FZaZEGIvA9RQpwVVSBWrUZ3dJ2fRk4
 CVmI3/NCWU2QbpxEixRUICSGjwqsWVCcZdjfWK1y+b63X+MdKfWdzvqU58h9A78zbIZ1
 ztcLWR9i4hDpxTw7Yk9NgPG9RWc9sRoF8UgJRaq1gQU/cREQk1qyf2QXZlQWpHihjX5M
 4rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710146708; x=1710751508;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YqRWKpf3wPnvG+NAnIxIBlxW5VBhFD7P+Nga7DrY8YA=;
 b=wb8ZOVLeRwZFalPaQ2fNVsHnIG4TNNSwEibTmm4lYZcNGBYX/rGekKFpNZ6FD6xCQa
 0RRZvLDPHB5LzzXS3L38j9Md2pCJItYIX+4d4QfKKQ0rhqsjxFyvkBeCFuHnBuVIPH7g
 lWk6hGii7Lx3Ul+A9H3rr0lr+WxkzNQtsdjLYsl1zgethUh+1cHMIHM+S4UhGcrxNm3g
 4sbN0dymomSBRsGQMh3SHkTSnF6HUKT5Qqzn7lgY+fKCQVafPXtmidx5Si9XqyARGYFO
 CA8YqEIonEo7cEDQfP2soYAlbOL0mE8uL8eKbzwK4L8DO3Xr6dtfAvGz9a6A9RBi/Ol9
 lGLA==
X-Gm-Message-State: AOJu0Ywbc/GTN5KKDZyWyntrO5/S6sDixGpi1Sg/NCta7rvcAD8+V4kb
 VqyGQbsAX+ZKxxIkyhVhsuP6WegO5HoWwbsVLrJ76h5S+6HHYhVDW4H5fVnF/Hg=
X-Google-Smtp-Source: AGHT+IEKs+DjALX4KGl0DGL8Bi8hXjX13yhvp7/JNSoECmL3gRx8OVwSpSJ9oP8aPtTlfw7FiPNkqQ==
X-Received: by 2002:adf:ea45:0:b0:33e:7f5c:a75c with SMTP id
 j5-20020adfea45000000b0033e7f5ca75cmr4088311wrn.47.1710146708114; 
 Mon, 11 Mar 2024 01:45:08 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a5d424c000000b0033e48db23bdsm5831823wrr.100.2024.03.11.01.45.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 01:45:07 -0700 (PDT)
Message-ID: <ea0d3e8d-1b96-46eb-a33f-0cca1c11a50e@linaro.org>
Date: Mon, 11 Mar 2024 09:45:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ide/ahci: Rename ahci_internal.h to ahci-internal.h
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow
 <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org
References: <20240227131310.C24EB4E6005@zero.eik.bme.hu>
 <00a87926-49bf-4945-94fd-99f5c3a73bb0@linaro.org>
 <a1a9cdfd-8c54-dc8c-6512-9c59b63cdcdf@eik.bme.hu>
 <87zfv5uu28.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87zfv5uu28.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 11/3/24 08:05, Markus Armbruster wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
> 
>> On Tue, 27 Feb 2024, Philippe Mathieu-Daudé wrote:
>>> On 27/2/24 14:13, BALATON Zoltan wrote:
>>>> Other headers now use dash instead of underscore. Rename
>>>> ahci_internal.h accordingly for consistency.
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>>    hw/ide/{ahci_internal.h => ahci-internal.h} | 0
>>>>    hw/ide/ahci.c                               | 2 +-
>>>>    hw/ide/ich.c                                | 2 +-
>>>>    3 files changed, 2 insertions(+), 2 deletions(-)
>>>>    rename hw/ide/{ahci_internal.h => ahci-internal.h} (100%)
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> Was this also queued somewhere? I haven't seen it merged neither with the trivial nor the misc-hw pull requests.
> 
> I figure John (our IDE odd fixer) wouldn't mind this going via
> qemu-trivial.  Cc'ed!

I'll take it, thanks.


