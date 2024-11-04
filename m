Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029F2D111BC
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 08:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7sBX-0001vO-Pt; Mon, 04 Nov 2024 03:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t7sBW-0001uZ-Ie
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 03:11:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t7sBU-0002YH-TF
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 03:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730707896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zlHyZuIhnhSXju1pnqOfdI6mKCFgXRaGgzCPA/D/r38=;
 b=cG+X3LB9e+eN1j7JaQIyEFFK6PW5uiUNMtItMQf3Z37gvMzXN0bDHWkCVAYLz6eS5h9Cke
 Q18WtC03aguSkuGXM8f4JITqd4TmvxXcXisbVqfpWy7N2sp3mQXLq16HgJOVHQnBiksf+K
 aGb0IOM0SwGIlSwBZTGI/MlaqGm+tZA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-mgIazDoxNDO8fujgldxFyQ-1; Mon, 04 Nov 2024 03:11:34 -0500
X-MC-Unique: mgIazDoxNDO8fujgldxFyQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-53a246ecb7bso1988566e87.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 00:11:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730707893; x=1731312693;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zlHyZuIhnhSXju1pnqOfdI6mKCFgXRaGgzCPA/D/r38=;
 b=Er7aOd2dHYkAhbXaoRKstHC4amWTyyu0VRVvOxCu+TVjmgEHA8Taem4dvFvqXHOvxC
 k6F90DbobUU7g5GF81g7n3Itvai+g9ybNlzT9PmzbxevaYhN0TS/L1FBBAPfZBGLoDV5
 1Etjhn3ZhaAQT12CsLhjrA67rtW46GcpWQojuk/a7xuxtK8Z9Pn2K/sRPb7JYPWtN0lS
 iz5Oc62wRxXRF+ZnO9h8eFHYwdJNJozoIbn9epoz4VuNB2fxqrbsiWKHCrTMsZW14wGU
 lvlDyoze9lIv1dPplCth7z9A9W4gUX+WPe7zw3RQV5Z+liG5jbdbT5y0s6rm8dlnUz6t
 wR0A==
X-Gm-Message-State: AOJu0YyX1xuIO/WFjSfLZaQCUW4oQiZn06BRAbSzGcKEXtaB1L4XdHRT
 Wm4si8nU0HBnHpDBGc9edJVR0A4Th4gXNNam3hoogApBtp0Rba5a3QmC+bsXq7BA2RlttkB8GyD
 6fezpbMG7Y8uQeYBfVKJuaJHO13gMVNgg+mdbo/3BUcNuFzVjsTR2mO03Hhw8
X-Received: by 2002:a05:6512:130e:b0:539:fbd4:9c9a with SMTP id
 2adb3069b0e04-53c79e61084mr7077564e87.35.1730707892971; 
 Mon, 04 Nov 2024 00:11:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0oi8dIBmzAahQkcawmQgo03spFxy3E5X6mink7ILXVZbameTWB7Nvpoy1Q4TYSX/150TDZw==
X-Received: by 2002:a05:6512:130e:b0:539:fbd4:9c9a with SMTP id
 2adb3069b0e04-53c79e61084mr7077544e87.35.1730707892489; 
 Mon, 04 Nov 2024 00:11:32 -0800 (PST)
Received: from [10.33.192.239] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7d20sm12618482f8f.7.2024.11.04.00.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 00:11:32 -0800 (PST)
Message-ID: <0022198f-abfa-4367-9b40-57f413861dc6@redhat.com>
Date: Mon, 4 Nov 2024 09:11:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/14] tests/functional: Convert BananaPi tests to the
 functional framework
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241031174832.6574-1-thuth@redhat.com>
 <20241031174832.6574-13-thuth@redhat.com>
 <CAFEAcA8eQdD133X66a=0qxsNaOiVYpmi3PfGXK-CkOENXLWXaw@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA8eQdD133X66a=0qxsNaOiVYpmi3PfGXK-CkOENXLWXaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 01/11/2024 20.07, Peter Maydell wrote:
> On Thu, 31 Oct 2024 at 17:49, Thomas Huth <thuth@redhat.com> wrote:
>>
>> Move the BananaPi tests from tests/avocado/boot_linux_console.py into
>> a new file dedicated for Banana Pi tests in the functional framework.
>> Update the hash sums of the assets to sha256 along the way and fix the
>> broken link for the buildroot image from storage.kernelci.org.
>>
>> (Note: The test_arm_bpim2u_openwrt_22_03_3 test is currently broken
>> due to a regression in commit 4c2c047469 ("target/arm: Fix usage of MMU
>> indexes when EL3 is AArch32") - it works if that commit gets reverted)
> 
> I think that the patchset
> https://patchew.org/QEMU/20241101142845.1712482-1-peter.maydell@linaro.org/
> should fix that regression.

Yes, that fixes the problem, thanks!

  Thomas


