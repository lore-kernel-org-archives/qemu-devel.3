Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08EDC6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 12:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqBhP-0001yf-1L; Fri, 29 Mar 2024 08:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rqBhN-0001y0-3X
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 08:51:09 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rqBhL-0002RV-Ew
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 08:51:08 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-341b9f6fb2eso1301292f8f.2
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 05:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711716666; x=1712321466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oeZVc4ilVKYZivJLQ2FA+xrAtPTjIXwTIAdm3xEQX7w=;
 b=WmUXwob2yOnXG1YkKVwDNtqeAobvEf6ROSMiyms+zINaeXMVVgsTTHV2PYtlyjDK1W
 Z89dFht6Nm2lUU3i3Wz+Zf3GNbFbORnFHD7cxrY2j43OczJg4X+3dszIix5xEFt5GFtp
 anD5Salt78YCidUcT37TZl6VK+6rGevubJqGt/wjds/d54X14r8wKAomFzIsbFW0/qGh
 E6TYxkGCrpXHKkk9BcEFAKj62BMRorwetB2blc6gWiSC4MdNgCEGrEIuLYx67T5TjH4w
 Uwtlqi/OHNMrXJArqAtpK4cQdbM91jGc/PEpLpcJRM32VAaB9ktFbEsnhGhVPwF1EJi9
 0vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711716666; x=1712321466;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oeZVc4ilVKYZivJLQ2FA+xrAtPTjIXwTIAdm3xEQX7w=;
 b=YfiFaFRNVNdawnfAfVk5kOmTAG41CPsV1Gmg+Y/jwrwBDisbMNG/w/Yz2OxnbUM33z
 md8nblXgow8AFvee0Fy/FJsFc0vw+VdJjSUU2eyWYd5v4H6CQFPawl5LX7em2lqZ57Rk
 r/5BOCUtZw6npRUbtWpJlWMmgHCyAVz0lqGzZSe6wEkX2rcgJn0siY+1WacnmeMtzmzJ
 slgesOkyics0Mk4Kd/C2DvqtLBlvtcUUueKwyPKeqQXWCsDfv4+Vx9PWtFX0+Zy3RcrZ
 cE3xZoUcGQbrifaPAfuwy8mUmJwE/JvZ9DPDRUb92SdHxc2DfxkXTGkTzUAhEeET/pHq
 5J3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK81XCzGViUHJZwAYs+xSyXXQtVgqZrmX03SLgNM/GLSIniqPOMNQdELTPBbPdzNgIFX/We79qCQLi7CFdDfBS+nm5jFs=
X-Gm-Message-State: AOJu0YxiavMHtK6lcXXg4FVEngqQxm/SzP9xOkuw/VGRDbiPCTievAJk
 gIgjpx0nzdldrl/SryA24rsnakG5QehlTnRFX4Cj/tH4E33DKSB4eTp9aZHUREY=
X-Google-Smtp-Source: AGHT+IHCMbMYd6OTc5AKBmkjOWB2Y+0d5gAT6JOC05KzoMeqVug9MMMoGSLjWamtHuuss9yMOOTNvg==
X-Received: by 2002:a05:6000:ec3:b0:33d:b2f8:28fc with SMTP id
 ea3-20020a0560000ec300b0033db2f828fcmr1548989wrb.55.1711716665939; 
 Fri, 29 Mar 2024 05:51:05 -0700 (PDT)
Received: from [192.168.69.100] (uni14-h01-176-184-39-242.dsl.sta.abo.bbox.fr.
 [176.184.39.242]) by smtp.gmail.com with ESMTPSA id
 cc13-20020a5d5c0d000000b00341b8edbe8csm1602556wrb.87.2024.03.29.05.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Mar 2024 05:51:05 -0700 (PDT)
Message-ID: <1c447820-93c3-45d6-9cab-1eff1b07483c@linaro.org>
Date: Fri, 29 Mar 2024 13:51:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1] migration: Add Error** argument to
 add_bitmaps_to_list()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20240329105627.311227-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240329105627.311227-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 29/3/24 11:56, Cédric Le Goater wrote:
> This allows to report more precise errors in the migration handler
> dirty_bitmap_save_setup().
> 
> Suggested-by Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>   To apply on top of :
>   https://lore.kernel.org/qemu-devel/20240320064911.545001-1-clg@redhat.com/
>   
>   migration/block-dirty-bitmap.c | 34 ++++++++++++++++------------------
>   1 file changed, 16 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


