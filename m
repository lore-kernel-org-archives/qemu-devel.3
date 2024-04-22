Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AF2C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 17:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryx52-0004iE-44; Mon, 22 Apr 2024 13:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ryx4z-0004ew-6D
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 13:03:45 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ryx4x-0004BA-6d
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 13:03:44 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34a32ba1962so3291252f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713805421; x=1714410221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K/ptvfirRXlecEvnYNl+wTBX9MNZ1X0q77WQnm5CBOU=;
 b=cb+xgOQpw4KTdD9tIn1miqmKQRMCg0txmRdF2OsgxUkW+pbtRwhd7SzsoHvdMeltWJ
 UPM/ZGhoIqEFycREsReZg+I0YztTO1l2jkUTmx1gh4TZMWC/bqbdizUswHiPzKB3H63K
 B0bf5KQ/tRUvkpW8iTpVhexLOJwl6oZD/Aol0N1mTKSOadtTKkU0tfM4anVhPukP7YAV
 WvZYQQy4xa82qo28Y57tOWG2xm6tZgHGimxZaHSrx8pc2+h6+vSQxfRjtb5nCj8Bv89b
 MPR8FBH79RqmSET01p9+w2TfkrrQN/HX+R5rBk5w+gBvJo+L9oBar1n85aZWmQx02HeH
 o1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713805421; x=1714410221;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K/ptvfirRXlecEvnYNl+wTBX9MNZ1X0q77WQnm5CBOU=;
 b=PlQwl7FHYLuDzpcHU1T9GPWf9WXFWCW3d10YwKgeqKLNppDMfYsNdP3oBm/W0MVqCh
 Ty8pOUPL2a6gCr7DE6B+ndBRWsJs/EMJAtsMhoA/0EU8XpL/PlG+KBVXgeurMbhp41en
 sZ0uVziPmwmWhWW9FN08NzSbLq+BBxgo2yAy69n8KeipemRpt6uNWqEKEe7mCDb97dem
 wcxsnzec1LqdaHuUjpUY+UQrfHMYlg4GX6LgIEQjkQZMojdY/Y7i/XpAITIbOAAW/mQw
 ZtQIfeR0/cJh6DYeOjEBG0EfxCanMncCuP2/GRtbMfWC4JC5ew5PjQFGS9+NWSVn5/yJ
 nLXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxRAwUgcNdjGdhv3pWTk8ybTF+FhSu+/IWZwTGWDEqN065v9XVQOD1M9nRM6G9vj7qD4qO/I3xsmhanVDVibI17s7q/lg=
X-Gm-Message-State: AOJu0YzxWiBQafkQnkyreXrhl3iPfq7Q8bfNvjth28Z+Ksu8d3RlZ0D2
 waAkvfVGGqa+I+TauEJMDMr3RjH17ZHyLhl2ph0+B4zSrZwQ2ZrT0priGTle67wNWRLLFbYQLnV
 +
X-Google-Smtp-Source: AGHT+IH3MxZBYtjTH+Z6CU54x4DaATw9e4Cx9TV46EvGvfx56nlf6NsXKKfl4XuP3MJPcRtfOdfNMA==
X-Received: by 2002:a5d:6b0d:0:b0:343:edfd:113d with SMTP id
 v13-20020a5d6b0d000000b00343edfd113dmr6446151wrw.71.1713805421477; 
 Mon, 22 Apr 2024 10:03:41 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 r16-20020a5d6950000000b003477d26736dsm12500716wrw.94.2024.04.22.10.03.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 10:03:41 -0700 (PDT)
Message-ID: <5acf21ec-216b-4d11-a7c1-ecf9a8ddf76f@linaro.org>
Date: Mon, 22 Apr 2024 19:03:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH intel_iommu 3/7] intel_iommu: make types match
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
 <20240422155236.129179-4-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240422155236.129179-4-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 22/4/24 17:52, CLEMENT MATHIEU--DRIF wrote:
> The 'level' field in vtd_iotlb_key is an uint8_t.
> We don't need to store level as an int in vtd_lookup_iotlb
> 
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   hw/i386/intel_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 6f1364b3fd..ba545590b1 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -333,7 +333,7 @@ static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
>   {
>       struct vtd_iotlb_key key;
>       VTDIOTLBEntry *entry;
> -    int level;
> +    uint8_t level;

Or simply 'unsigned' up to vtd_slpt_level_shift()?


