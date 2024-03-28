Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EABEC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 11:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpnyM-0005aS-5v; Thu, 28 Mar 2024 07:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpny1-0005WQ-8T
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 07:30:47 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpnxz-0008U7-KE
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 07:30:45 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a4751063318so108145266b.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 04:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711625442; x=1712230242; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eZkEmtWbzLdpcrake2VSMzg+KXQGGP9JOCj2rDwaFAk=;
 b=IgfAo6Vfmhk/Ccwx+uR8fN1IsIdFqxdS6hjaA4HLa7VMKz0dVnRnqGCLE4Kaz/FlUc
 DtjkR3a2tle2xl0a7fvSXorjHdGOmg7YHr7UDhdgsVkvdfZcop5HZjkl/c6CoUCrSEzb
 C2VNGEhlMlW9axD1MowHpcFftvu2xh3wboGtRZXoOOVMc21Gu5R8oH746ZTD2U0w6fFT
 5fDHkV2prDsPav9O+m/d8nX2CafHFmK7l7A9HzA4pAzsoxnpuG/eYQEFTArlzeBQ9Zeh
 pQo3qjPiNqG2/pzTgQkhm6SGa4DQ1KZXntjYItOqLXANtm4r/7q7JFEeQtLz7/GW1P1N
 /eBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711625442; x=1712230242;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eZkEmtWbzLdpcrake2VSMzg+KXQGGP9JOCj2rDwaFAk=;
 b=sw+3JN6cksc0Vp0Jre9CapspKFE3fgesUjwE8e1zW/MxkvyT0FqXEvJsjmKoKZQlwk
 dxh3zTRR50sVdEtkFjN1eKUshm6taxyorLVCiEPG1PQILiN9V2tncydnt9s2cGjC2ii7
 jHVv7sbb1JXE0V7HKdiylZTKMiN8b7Elp3/0th2PtDaJ/7mOYaASP4ch13qDnMK/66Io
 vpTy8eTSI8EeW8/F7ZMhesUdDs3rERqrSJVUbAesJBjE+y4wO9vqrLl3iJHzgZm9O9RH
 iV98p+Hry5Jm/VeDs3JnGFH5Z65MBJEFcYMrv581AxMug/V/g2v4zjux+/luFILGuo99
 44ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy+H8Azv2Euytuxoc1z42JpMMlM5Ef6RWhLfiVQ1StD35U8HgYySQ17CzC9ZqhnK7ac++SfU8tmoO+3YgWpMOpotA9N8U=
X-Gm-Message-State: AOJu0Yy9CAKEh+pc/+rvSDBovwffJP4dzyXGVnKvFIeghqcenJcJED7c
 y55FdgDBYG+p/yXEas8r58OcWspRvEIn+h9sHalA32E4DExrjyi2ymD2RIyRlNo=
X-Google-Smtp-Source: AGHT+IHr7raZHuDghhevj1emtJ4oOaHBL6XrQ1YMzrei1o26mC2Z0CnAAhytdRBWDEycKvd7H4RA7w==
X-Received: by 2002:a17:906:d1c4:b0:a4e:f84:41aa with SMTP id
 bs4-20020a170906d1c400b00a4e0f8441aamr1269976ejb.67.1711625441848; 
 Thu, 28 Mar 2024 04:30:41 -0700 (PDT)
Received: from [192.168.69.100] (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 bj9-20020a17090736c900b00a4e28cacbddsm143134ejc.57.2024.03.28.04.30.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 04:30:40 -0700 (PDT)
Message-ID: <13373de8-57ba-4b6c-9a8f-bdff88283bb4@linaro.org>
Date: Thu, 28 Mar 2024 12:30:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/19] hw/sdhci: fix -Werror=maybe-uninitialized
 false-positive
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
 <20240328102052.3499331-10-marcandre.lureau@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240328102052.3499331-10-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 28/3/24 11:20, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> ../hw/sd/sdhci.c:846:16: error: ‘res’ may be used uninitialized [-Werror=maybe-uninitialized]
> 
> False-positive, because "length" is non-null.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/sd/sdhci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index c5e0bc018b..da5351d4e5 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -745,7 +745,7 @@ static void sdhci_do_adma(SDHCIState *s)
>       const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
>       const MemTxAttrs attrs = { .memory = true };
>       ADMADescr dscr = {};
> -    MemTxResult res;
> +    MemTxResult res = MEMTX_ERROR;

Something is indeed odd here. Due to the for() loop, the variable
initialization should be moved after the SDHC_ADMA_ATTR_ACT_TRAN
switch case.

