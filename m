Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B62C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 19:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1tDG-0004Ue-6t; Tue, 30 Apr 2024 15:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1tDC-0004Tx-VL
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:32:22 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1tDB-0005Ae-HC
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:32:22 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-349545c3eb8so4037523f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 12:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714505540; x=1715110340; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yGS6iiivWRbQ3axYP0ZDYrAHkrg0gQglh+6brn3pJcY=;
 b=EPi8o49m1zgAiu5jFR1qBxO3MO/D0GCNuA8vCqtrzdvg3rhoIm+pC5ERCc+fupY0Fp
 9Cc4y+elpiFx29laJLNE3K7L3LcMusBSZ8A2qyrxY+qW7tuN4an8K3lkckLmLYCHRn7d
 BXfy4ATZOhE1rMkgYh7csxynMyCpfjkrK42PKif7wCPiuvDjOSb+NBD0njf71QEFnr3Z
 mBnrToEawyemasFqah9EheJs+80rSuK5Ej1oUSWeec2+Gw2l8Wmuo82zynj+ROOhFsm3
 Lh43Alb38bcEjkochsHWuQJ5T/q+1+tXyvbkl71pNOKWk1SmeSPc1QK5b+NrhkEs8mVN
 /nGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714505540; x=1715110340;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yGS6iiivWRbQ3axYP0ZDYrAHkrg0gQglh+6brn3pJcY=;
 b=KFNbcwhwJQrAYkie3wYtXt56VjCxMmN/mCTjq1IlnUoYlduf0LCOyxNp66nUzZ8nzk
 KKIDyQOZBuQUs3waLpGDyobJn+1tncKqz3fNNG0GRSKLuDjb/ZsCcHr/Z9jq8ZsTOQDs
 U4uWobbIe2/3lZiAbCp52/wRx5y+LflGE8D5KA3xw0QXVhF8CnwtBXIfd5PfxR5MO14N
 zEMWfn1RV/9XrDYHSK6dFYWk0kMhcypfIBLrI6KvDUMkmu+1BIttIEHqVj7AhiHkNRZ6
 Ie7jSBd7AA+FhMNnLH/oPNvPxGQGWYc4DUYsdyexfGK2XClPbKszEZtXLYfzkVxVTTn4
 p8uQ==
X-Gm-Message-State: AOJu0Yy0IL9Q5eIZ+XySN2T11sBCG6HosdYjDF8Sxniqr2mOTArYoaBH
 MFlPSHb5zalJYVsoRmRIVgAFRyyhi99HmL+y5IO0IlAfX567Le0lUjo5t5ECy48=
X-Google-Smtp-Source: AGHT+IF0fwnHKAU/VCb1NHTcA4TCcUv0iCj2+e3S6GbglQdPBtjZbZQAPpMT2JDstYMQSb3smjeM7w==
X-Received: by 2002:adf:ed08:0:b0:34d:a800:af22 with SMTP id
 a8-20020adfed08000000b0034da800af22mr468461wro.12.1714505539566; 
 Tue, 30 Apr 2024 12:32:19 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d628a000000b0034dbeb12515sm359092wru.41.2024.04.30.12.32.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 12:32:19 -0700 (PDT)
Message-ID: <52df5179-4281-4763-83af-78c386bd7139@linaro.org>
Date: Tue, 30 Apr 2024 21:32:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/s390x: Attach the sclpconsole to
 /machine/sclp/s390-sclp-event-facility
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20240430190843.453903-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430190843.453903-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 30/4/24 21:08, Thomas Huth wrote:
> The sclpconsole currently does not have a proper parent in the QOM
> tree, so it shows up under /machine/unattached - which is somewhat
> ugly. We should rather attach it to /machine/sclp/s390-sclp-event-facility
> where the other devices of type TYPE_SCLP_EVENT already reside.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



