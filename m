Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD729C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 05:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGuQi-00015Z-4c; Tue, 11 Jun 2024 01:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGuQg-000154-OI
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 01:52:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGuQc-0007NT-Fg
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 01:52:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42121d27861so45360505e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 22:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718085136; x=1718689936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xyRlHJ3aPTAJjHLz/EmrfOG+BBPconf5HkEzZvfc93Y=;
 b=MyUOkRko600QzTq4mWfKCxXqZ239P8sxZQW3le1aZsrmDYhTa2AX6a9fFd+fcsc8Q0
 xrrESgccQfrWcNHbgD6xGxNwOfUbN8CUcIYl58ZUCW7zOCUe9bl316OMVcDlp1IwDxTz
 klZ/3OC72sH7FuXFYhdKdP/GoWJN8Ep7gFdDwCLrA13q6qBGckO/4JQLNujrwRNOMU88
 FV3NRmlEnPpdoEVWgpNVwG6YPUlB7Knx+FvtJjlIDQVtyLSXJy1/C/oHPSjUwtVXENPA
 b1uLgshRMEwrghFZp+8VvRnkYBbMa+beiQ4abD8tu/fNAQTaapfnSigVxPO7XlKGaPw1
 MF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718085136; x=1718689936;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xyRlHJ3aPTAJjHLz/EmrfOG+BBPconf5HkEzZvfc93Y=;
 b=ZaHBra45dnFdecIYApaB1ro+7tYzDTvCjgtGPfV3dS37Qh+mqdmLSrkqGTEOnQ+JAI
 UkGCo9o/yPWVRCJjvtfx1JgWZZQQxOTXgx8JOVXCYgFb1c2wjOQsZhfx0OLNapcrEqsX
 vf3Pzs3VeI5uaLT84z+68Ud6e7/xqDHjYEnjasIAL0Bi4ssQ7Hdc1qyAdeHpi5AfkGlA
 Vn0AvcA4yhaQKZ3uAITGq7O8ibj2gbvFF3HQlNQ3gIVau5NvgAztTcFpgYhFz7hGM4j9
 PbpKVZVQGU7VpEhMBQw7dbGw/vf6vtxys9R4QW3mKBHjwAV1zh2/h16ha1Fx/QY2mSRD
 WDVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDNtszf8jGa016sLv9p7K30Y7qgFkPbENiJpbReZhzQsyGlKi2/yM9IJjMFRgtCvP1NWh/tr5qJNCuwlwsX0UGUO70jAU=
X-Gm-Message-State: AOJu0YyS/QPbv8M2F370UwOFY/UrIuu0zQYpioN7pvL2skFHAXLVxXbq
 G1FhmqNKujSFquj4fCgfUt2tLXhuGDy6fKjpHiz9hPJUGDqw622SdpyzVEWisS8=
X-Google-Smtp-Source: AGHT+IEPxG6n8EgHO8hORp4GSTsKV/E18OWLPAboMynNRY9SVPDtDILa4ur6zohLsCN1qzuIqSCyqw==
X-Received: by 2002:a05:600c:3b08:b0:421:bb51:d605 with SMTP id
 5b1f17b1804b1-421bb51d71dmr44856645e9.6.1718085136471; 
 Mon, 10 Jun 2024 22:52:16 -0700 (PDT)
Received: from meli-email.org (adsl-33.37.6.162.tellas.gr. [37.6.162.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4225b0923ebsm6157735e9.1.2024.06.10.22.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 22:52:16 -0700 (PDT)
Date: Tue, 11 Jun 2024 08:47:11 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn =?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr =?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud =?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
User-Agent: meli 0.8.6
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <d910708f-ed55-4eee-8f66-8703cb45081c@linaro.org>
 <evt7n.ggoypj31l14q@linaro.org>
 <6e7a14a1-8727-4ce5-ae67-797323704464@linaro.org>
In-Reply-To: <6e7a14a1-8727-4ce5-ae67-797323704464@linaro.org>
Message-ID: <ewiz1.q2hs3ao1amn@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x335.google.com
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

On Tue, 11 Jun 2024 00:38, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>>> Maybe it could be better if build.rs file was *not* needed for new 
>>> devices/folders, and could be abstracted as a detail of the python 
>>> wrapper script instead of something that should be committed.
>>
>> That'd mean you cannot work on the rust files with a LanguageServer, 
>> you cannot run cargo build or cargo check or cargo clippy, etc. 
>> That's why I left the alternative choice of including a manually 
>> generated bindings file (generated.rs.inc)
>
>Maybe I missed something, but it seems like it just checks/copies the 
>generated.rs file where it's expected. Definitely something that could 
>be done as part of the rust build.
>
>Having to run the build before getting completion does not seem to be a 
>huge compromise.

It only checks if it's called from meson, hence it should update the 
should choose meson's generated.rs file. Otherwise it falls back to any 
manual bindings you have put there that are not checked into git. So 
essentially it does what you suggest, I think :)


>>
>> Yes, vendor-the-world is a different topic than vendor e.g. two 
>> crates such as the dependencies I'm using here.
>>
>
>If there must be a discussion about dependencies, it's probably better 
>to consider the "worse" case to take a decison about vendoring this or not.
>

Agreed. To re-cap, my opinion is that vendoring 1-2 small crates is 
fine, but any more than that needs rethinking.

