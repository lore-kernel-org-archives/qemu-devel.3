Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22CFC46CD2
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 02:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSpPZ-0007EG-Au; Wed, 24 Jan 2024 21:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpPU-0007DR-KF
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:24:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpPS-0000v9-HW
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706149445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xBlUJJKBjRQwIANZliBvEHpvGwj2JRdLrwpq1MUBFKM=;
 b=AYW0R+GBWi+giLfUrRZTm2nR1poCC7UPqBKGE71fMCiZfN3lw9emETKYOGTZm30BJ7Vsn+
 3VIsj/rIP4+hkQ16yTSCBit1zUW8+S43WlCV8iXx5MmO/Vcuozs2JmtIyxxg6vuVEdbCs/
 OR5JPyXSefX00vKiP8Ut6IbjE+3e7g4=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-aIpW57yjNFuyz_nZv8eFrQ-1; Wed, 24 Jan 2024 21:24:03 -0500
X-MC-Unique: aIpW57yjNFuyz_nZv8eFrQ-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-598a658276cso8178695eaf.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 18:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706149443; x=1706754243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xBlUJJKBjRQwIANZliBvEHpvGwj2JRdLrwpq1MUBFKM=;
 b=Z4Zlrp1LJGATfkgqUyY6CZ2snUw4cs3LARep2RwCZkvoNs3P0LiNSGiLTQxdq3tPyU
 LoX7FBpbyRaoo+GYwTm5B8WotQFMXjknJFjTmY4Ep2BGATjawUVFGOd3qgg411e4QejF
 MRoX4MCF+lxY/Nm/A7Rvi2HC9p17qRJU70JBlypm8CssOPcl2NfPs4AYlIoZmdgSbWg9
 mfof9+w5aseDrFnRuBaz7Q7nzljgTYXlCNxHMWLWUf7vf60aNWuH1Y9qvFmQqpTgfrb3
 qwrQiSeo0wrR0n63g8BDuy3/KVARgWJ48CYenv8/kWczbTdtZOs7dV34jw2eyALF0AVc
 aKTg==
X-Gm-Message-State: AOJu0YyRdTCLfx7og3zZrKDTBJKpF+3kIlO5PADeaoLoBseI00GvIxU1
 rRaR+vA7+8ZKjGvTl8SgVYZdCqFilYVdTcXC0lP9ksIJBsNEUsUWOlNcCRpf8233YePMWc+bFwi
 aYCZPkkIBE9+V4/el82oDnTGhim0lFn2poa/zuuDg8d0qCQ/HwG7L
X-Received: by 2002:a05:6871:2318:b0:214:2725:4d7a with SMTP id
 sf24-20020a056871231800b0021427254d7amr295995oab.37.1706149442994; 
 Wed, 24 Jan 2024 18:24:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7yDTYks5N2vQlDIuHI64nV97t1Jztk0lC/3jyR7ZfI1gxm4ygIUBH5aACm9r1J9fNXkU3UQ==
X-Received: by 2002:a05:6871:2318:b0:214:2725:4d7a with SMTP id
 sf24-20020a056871231800b0021427254d7amr295987oab.37.1706149442776; 
 Wed, 24 Jan 2024 18:24:02 -0800 (PST)
Received: from [10.72.112.202] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 p64-20020a634243000000b005cf6e5feeb4sm12589874pga.38.2024.01.24.18.23.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 18:24:02 -0800 (PST)
Message-ID: <e11a1e2f-eb6d-4ad9-ba5c-f72fbaac12a3@redhat.com>
Date: Thu, 25 Jan 2024 12:23:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] hw/arm/aspeed: Set default CPU count using
 aspeed_soc_num_cpus()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240123224842.18485-1-philmd@linaro.org>
 <20240123224842.18485-3-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240123224842.18485-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/24/24 08:48, Philippe Mathieu-Daudé wrote:
> Since commit b7f1a0cb76 ("arm/aspeed: Compute the number
> of CPUs from the SoC definition") Aspeed machines use the
> aspeed_soc_num_cpus() helper to set the number of CPUs.
> 
> Use it for the ast1030-evb (commit 356b230ed1 "aspeed/soc:
> Add AST1030 support") and supermicrox11-bmc (commit 40a38df55e
> "hw/arm/aspeed: Add board model for Supermicro X11 BMC") machines.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/aspeed.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


