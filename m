Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D083D33985
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5QJl-0001S9-2l; Mon, 28 Oct 2024 10:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t5QJj-0001Rs-As
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:01:59 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t5QJf-0007df-4Y
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:01:58 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-210e5369b7dso3739785ad.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730124113; x=1730728913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3Zy+M6Hf3zCvNPPDUVCSzn9HnlmOC2qbaLHJoZPyQCs=;
 b=LlWa4BqUiaUyv2vn0vH2DxJlx5O5Ln9P81li8hWnd7nxE6cOsouTQ1MeOL4U8nkQ1f
 XHjuEVUQG1/xAVCRIGYyDjq3pLKdOwMwbPeZJO/XmedkhAJUV6wKVeC8Xx/927h+BMfi
 mRmcpusliUhzwyQaGuvmQNvVjb5lEDo8SCgc/qgZ35o9f+RTFo6n3gaOW+sDDdUMnuHn
 Ee66VdDLArovDLzX90ZWnIMkIfPiAhWIiL8u0q40m88ZD/+3xvDmURZEzcof4V5C9Boo
 FqbbKOymArGILPjfxXMDpJK0TiNYeek4qZtuUofXfTqNpSKDvAZmKLi8cFMxfm1t16pj
 CdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730124113; x=1730728913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Zy+M6Hf3zCvNPPDUVCSzn9HnlmOC2qbaLHJoZPyQCs=;
 b=AxWBEPUomUx0PZHO6p4dU3vbE1g+st+D2euiv1/I95c8JMYLrusjl4p/k+x0M9GAtz
 ayg/gU4PQq0XQjCK9P/8JK4ra6LsYW3B2PI3sWNwzu+nBmltxXQCccWl77SzzrPiF5OE
 gePSyROUpnEjThK7r06YG5yeHt81NBgYEiaftkyikHB/gt3ec319657Q7hzk3BW1Pyly
 b3FpuYWvlgAIlplio8Pgqjnxg9i59vn/AXF7NCOmuloQoBBuOH8lSV3iRZX1rIcwy/rh
 LUY6aJI6rDdL3y6Xz5ngpkGtnTP07i1UqOMyjlhCppQZn9MK5EUmvWO1IpWFsqSTt9sg
 FYPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWRCeR0wvEvkndJfXnhndaW7ytxGauooPhYusQgGBIT5ev9OVPZIjOen0ltL8vh8ewE6QbMw6JqTwk@nongnu.org
X-Gm-Message-State: AOJu0YzxsguUD26A4hYOoo6hBHQ3LCArzG0hgWOt2p/5r8HSO5cDIUNr
 cPaj0F4wQl47BCy0diQSq1jipPROgUzhjvT4E3I6zOHalXFUL8qoBgPfefzx9RU=
X-Google-Smtp-Source: AGHT+IGVxL/IoaNXY1p8JR/Umz//Zo83XjKibFKKxYPSYBYfOqWnvlVQQkBiWcmRqEUGFng1WFaoJA==
X-Received: by 2002:a17:902:f686:b0:20c:e2ff:4a2e with SMTP id
 d9443c01a7336-210c6cc1623mr108935815ad.53.1730124113296; 
 Mon, 28 Oct 2024 07:01:53 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bbf87c1esm50879095ad.116.2024.10.28.07.01.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 07:01:52 -0700 (PDT)
Message-ID: <9fdeee78-d393-4505-a2dd-624d7fd3f5d5@linaro.org>
Date: Mon, 28 Oct 2024 11:01:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove myself as reviewer
To: David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20241028095109.1611019-1-david@gibson.dropbear.id.au>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241028095109.1611019-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x635.google.com
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

On 28/10/24 06:51, David Gibson wrote:
> I've now well and truly moved on from ppc and qemu maintenance.  I'm
> occupied with other things and am pretty much just ignoring mails on these
> topics I'm CCed on.  Time to remove myself.
> 
> I'm still listed as a reviewer for Device Tree, I'll keep this for now,
> since I do have some interest and it's lower volume.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>   MAINTAINERS | 2 --
>   1 file changed, 2 deletions(-)

Thanks for all David :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



