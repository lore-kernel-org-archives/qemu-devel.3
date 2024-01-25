Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9370DC46CD2
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 02:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSpNV-0006DA-B3; Wed, 24 Jan 2024 21:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpNT-00065m-0k
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:22:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpNR-0007cI-Io
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706149321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEOrxI9RFs6RU5kpgER0lGSy8A1ollOCifMGkiBWO34=;
 b=VdTOcQO5sKsu4ConuPO+im1rQ2jim+EcQWPfmJefl8v2stLDPWuMS5/65fltUpgOyoddYw
 8WU08eHurtgecvl8cneEACGbRwcb/gN46+pZbLYOZQehT9138cE1CRte5DQRgMH3PES2pi
 F4S8Vh2FMQl+vPlIfdY4eA5bokvlbOs=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-ykqrUVRZO4i8rOKG5ASmnA-1; Wed, 24 Jan 2024 21:21:59 -0500
X-MC-Unique: ykqrUVRZO4i8rOKG5ASmnA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5d63c7c4248so215701a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 18:21:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706149318; x=1706754118;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lEOrxI9RFs6RU5kpgER0lGSy8A1ollOCifMGkiBWO34=;
 b=BuNEcNyyN0jBo8fotN+CD6Aph2Vr5ikOdnNvvOcZGLSlmDX/t9HDQFS2mrJj+6V62i
 +m3tN4VDImAyfLXVL/oQ2PqimdtX5tvPTNLoKmxK/NzWoJXtDqllQzLV/VdonUjrNJrA
 H1cVCwixR6EGO2CHNzq0Y87Kit5EpbOTGLXcWYBJtWdKyIL5cIcauLHkwtBrxeH7ozgZ
 a9auo2KgJnvPcddHdasVqtBxWR6+VHOGYFtNJ5Nm0WVXfrZeZLcWmL+F6KH2LLs4ogx/
 jRqdC26DPdBi9iEby/O5G39pLP5/CmIjDl2uavUFoiOlBLXasPqh9lxzZ9oNBCciHMpl
 9Tfg==
X-Gm-Message-State: AOJu0YyIWFOsaUOcTon4XdyRYN/WL/R7L1NC2Hro2RQF9jTYBmgGzQd4
 QBs6877gunnWnhUUdJaYe3J0U7wsv+7UFbWhcXKgW9uDXQnYEa3Tet6SJSpLS4tu6QHfUbCmISZ
 H4X8BgyN7gZ5THa/A6XuJ/vzmiVukebtHOxzktZYgi3PHjvxS5dmI
X-Received: by 2002:a05:6a20:7352:b0:19a:9973:2b22 with SMTP id
 v18-20020a056a20735200b0019a99732b22mr311446pzc.40.1706149318314; 
 Wed, 24 Jan 2024 18:21:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8FakJFqPuVyvT+iE/SRGhG+iFkwQSgWLilS+pz8Ntk151uGU/Qy0RineRegxk4FHalXtScg==
X-Received: by 2002:a05:6a20:7352:b0:19a:9973:2b22 with SMTP id
 v18-20020a056a20735200b0019a99732b22mr311429pzc.40.1706149318011; 
 Wed, 24 Jan 2024 18:21:58 -0800 (PST)
Received: from [10.72.112.202] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 e25-20020aa78c59000000b006dd8300c68csm3469882pfd.186.2024.01.24.18.21.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 18:21:57 -0800 (PST)
Message-ID: <07c7838f-0a8b-4e9c-b96a-464fcb42eab7@redhat.com>
Date: Thu, 25 Jan 2024 12:21:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] hw/arm/aspeed: Remove dead code
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240123224842.18485-1-philmd@linaro.org>
 <20240123224842.18485-2-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240123224842.18485-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
> Remove copy/paste typo from commit 6c323aba40 ("hw/arm/aspeed:
> Adding new machine Tiogapass in QEMU").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/aspeed.c | 1 -
>   1 file changed, 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


