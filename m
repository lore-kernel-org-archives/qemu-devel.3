Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38DAC52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 00:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se2GI-0003Aa-FB; Tue, 13 Aug 2024 20:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se2GH-00039b-1G
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 20:53:13 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se2GF-0003qO-E1
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 20:53:12 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-201d6ac1426so3052745ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 17:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723596790; x=1724201590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rkc0DscZwkUZCovRI4nWM5TfUQCvSSTd+6RVErRLvkc=;
 b=dQt4YTxddsJI2whhwo+X7OK+taa1vwhE6zJOxZIi/q2Ds0g3GpEf4h2Y7ucltyPRS3
 +AXvuuRqarWulisJdykrwb5BJvexAcI0JnkH5m4pWwlXwE47zZPEBgqfQzyNMNAhu6jq
 roUClvesbwJiWNtOAebcFXNcxVkYZoARsrc5Pk9wIgs03iYa4yR3tRLkoXGgX8WX9EST
 gC7Fx3hpoRj45jIXHfu4zW5UTjgJi97H8KrHWIQpm3Nu7geG2GtFLwA0xDCBy+Rvc3RW
 xCEZpG0WFlu6M1cmkfwvKanN2rzrWXs3bvcxaHFrQfcfJCHX5720bPh/q9nTpMrOAqBr
 g0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723596790; x=1724201590;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rkc0DscZwkUZCovRI4nWM5TfUQCvSSTd+6RVErRLvkc=;
 b=ghj7KPBSZRdLls4V78nVH+TibxSvFda2sTdmVv4Stz2bZRG5lKCqxgPYBKjRaX8SiT
 Z5WEAnERwicl47NRGbv2S33K7/R04F14oviIu8zv0qvhHcsmuWnGd4rwbuYbfL8U6R2t
 1XA0rDZSk7LXNBbn4mmq4A5J/mbb+GIke8RvHvJIz/jMoKaAAVqV5V5wG9ptSG5Doij+
 v5nS20sJGPsrQgD6/bAAFf2uw4tInVjp26qy7Qxzgo4SScXY6c7Cxttjlx9ydH8XE126
 nzzxol3u70Jg+v3VzZwm2jYaxKNt2qiNR4W66Wju6+GkqW+FosmGPWJ6uPSbMBUdmQCc
 yD+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQxmbgi1U7+dM9M+vIWme85Sy1QBOdImaSQxbyXjATEm4MCtgg3lD8Rtb4goVmZQ3hkf0AGNIIoBggmmyKMUAk5320Ttk=
X-Gm-Message-State: AOJu0YxUb2RWZ3noqz1WPXK7ZPssFLI2oXTdvd4AMRWctnQkFmTb5bzA
 4aI0olDG5IUJBz783e6Xkv4HSNlUHIIcEUHxSv5LyXSDbmZn3gv2JM+XaNk/IFI=
X-Google-Smtp-Source: AGHT+IFANifIEo+FKDb2uY/E870fAVIw7oWkKy1Z7GNg+oiyFHZC4v84j3/rZqTvTI9gB2gNuBqCvA==
X-Received: by 2002:a17:902:e850:b0:1fa:1dd8:947a with SMTP id
 d9443c01a7336-201d648ce5bmr13475725ad.46.1723596789440; 
 Tue, 13 Aug 2024 17:53:09 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1b82bfsm19257545ad.210.2024.08.13.17.53.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 17:53:09 -0700 (PDT)
Message-ID: <d86ab67c-90cf-422f-aefc-1025a7e5a77b@linaro.org>
Date: Wed, 14 Aug 2024 10:53:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 10/10] hw: Remove device_phases_reset()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-11-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813165250.2717650-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 8/14/24 02:52, Peter Maydell wrote:
> Currently we have transitional machinery between legacy reset
> and three phase reset that works in two directions:
>   * if you invoke three phase reset on a device which has set
>     theDeviceClass::legacy_reset method, we detect this in
>     device_get_transitional_reset() and arrange that we call
>     the legacy_reset method during the hold phase of reset
>   * if you invoke legacy reset on a device which implements
>     three phase reset, the default legacy_reset method is
>     device_phases_reset(), which does a three-phase reset
>     of the device
> 
> However, we have now eliminated all the places which could invoke
> legacy reset on a device, which means that the function
> device_phases_reset() is never called -- it serves only as the value
> ofDeviceClass::legacy_reset that indicates that the subclass never
> overrode the legacy reset method.  So we can delete it, and instead
> check for legacy_reset != NULL.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/core/qdev.c | 51 ++++++++++++--------------------------------------
>   1 file changed, 12 insertions(+), 39 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


Is the reason we prioritize resettable_get_tr_func over rc->phases to allow for a legacy 
device to be attached to a resettable bus?

I wonder if device_class_set_legacy_reset can simplify that, with

static void do_legacy_reset(...)
{
     dc->legacy_reset(...);
}

void device_class_set_legacy_reset(DeviceClass *dc, DeviceReset dev_reset)
{
     dc->legacy_reset = dev_reset;

     /* Parent enter/exit are not invoked with a legacy child. */
     dc->resettable.enter = NULL;
     dc->resettable.exit = NULL;
     dc->resettable.hold = do_legacy_reset;
}

Which would eliminate resettable_get_tr_func and the supporting layers completely.


r~

