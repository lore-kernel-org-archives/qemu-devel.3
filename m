Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A384FCD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 11:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rshPr-0001y1-Cn; Fri, 05 Apr 2024 07:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rshPp-0001wo-0e
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 07:07:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rshPl-0000jM-N2
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 07:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712315239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3vpTABOiQekJjZGDNyS5+ssrrES5qWgA2pa2bMcvFII=;
 b=bENBXIJf90cbWf2o25pwzh8JS7m7CDF4rmKLHNuKFW0cDqhp7meYfh8NEwLslrgMOM5dU8
 rzAxdkv5Ikd5dtoNrE8Vps4C5vPEuAZMMB8nlHEjFLqCg/xjDFNyH0mNakOyIh3+Fr1Vdj
 KwLD28Wg/veF0HjM4qNQn8tvIJ/EhSU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-HvFs3drfOGuKzESDRCUfyQ-1; Fri, 05 Apr 2024 07:07:17 -0400
X-MC-Unique: HvFs3drfOGuKzESDRCUfyQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4140225e68aso9800705e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 04:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712315237; x=1712920037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vpTABOiQekJjZGDNyS5+ssrrES5qWgA2pa2bMcvFII=;
 b=M4ZLB7Jfkl6RpnKwndYVYH8JeYD2tfzWb03OtipkvrA8D/ETUqo1AfySFxTlX7VUi+
 /XGHS5YhtFczEeiToUmzCcxO2nEEsRdwwWJ+xmHrf7s/BENWbTXq0qfW8tMGrtT6ECd4
 LxQ2VepACyQCRvDQ90C+wk0Cq+p4LPNzt85JnRvH7PYy/STThTxiGXKhidVfDhALlQ2L
 Rpb4nOtWt4CdExiY2R+iGJ3LnwefzX2LoIZMnRTXluBODyxyFd1NE67wKeRrlzeC02O1
 CLqbHIAkrnFXXtd6BeVAeLhhBwMwsnDoDLK35bcky8XRCg8XT0AENsLXKLxyaH/xyAcl
 9H3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqRvEFK1YDqJ3qyT5ToKDqBpwN07RgMFhaPqhXP06+QuJdLiJa1iKgrqawvNYUoRCvhl9CUSaVzLjoe50t/zvyNRBac+E=
X-Gm-Message-State: AOJu0Yw3IBvQitFulQDiy+kD2qGY/mSHluXB16jxHlyuwcNxPfH5uC6l
 ZzNqujf9yupXp4TEHaeq7xtwHse86qVTxjxwggUJKnitlL2+7wviqMHOfNgUKnC4kvyNLCKK5Y3
 95OKZ+NaUuPtYIr8rVsx2Uge1gKhwflB8wklAqFwxK0ykRh2slW9u
X-Received: by 2002:a05:600c:b8c:b0:416:1e4d:4fce with SMTP id
 fl12-20020a05600c0b8c00b004161e4d4fcemr987350wmb.38.1712315236653; 
 Fri, 05 Apr 2024 04:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNlb4WcR4QoaC/GvVGsvQJ3cljDQNJZVfJSg2l+GwbYnwV4WDmPXaqv38y6+8ZXWzNIfrb9g==
X-Received: by 2002:a05:600c:b8c:b0:416:1e4d:4fce with SMTP id
 fl12-20020a05600c0b8c00b004161e4d4fcemr987331wmb.38.1712315236104; 
 Fri, 05 Apr 2024 04:07:16 -0700 (PDT)
Received: from redhat.com ([2.52.137.173]) by smtp.gmail.com with ESMTPSA id
 fc9-20020a05600c524900b004162d0676cdsm2531970wmb.29.2024.04.05.04.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 04:07:15 -0700 (PDT)
Date: Fri, 5 Apr 2024 07:07:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Zheyu Ma <zheyuma97@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 0/1] virtio-snd: fix invalid tx/rx message handling
 logic
Message-ID: <20240405070632-mutt-send-email-mst@kernel.org>
References: <cover.virtio-snd-rewrite-invalid-tx-rx-message-handling-v1.manos.pitsidianakis@linaro.org>
 <bgucz.0f0amac25xfr@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bgucz.0f0amac25xfr@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Apr 05, 2024 at 01:54:46PM +0300, Manos Pitsidianakis wrote:
> ping

confused at this point.
Do you mind sending a patchset with everything in the correct order?
Tag it PATCH repost so people know nothing changed.
Thanks!

-- 
MST


