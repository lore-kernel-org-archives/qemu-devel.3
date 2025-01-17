Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9F8C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 11:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYkJX-0002qQ-2v; Fri, 17 Jan 2025 06:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYkJT-0002q8-Ep
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:14:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYkJR-0002Kc-PY
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737112490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P1lENVaVHq5DBFoFS4KQgpJPSAY3s3TaB6R40bHpXlc=;
 b=gxxHzmCQv9iltvEigIxbueo7xDkhGmIs4CnwAu7lFxPf9HTV9wrAW3ShEEZk9F6jekebci
 nCwXAuYxW3Amoru/8NjSUjhVpv13fzc+RvqzsAQ0lxUiAU0NcnbCmJUNwTMw+AOr89QKQM
 29ikyCGXx+GF4g6kjtREEba3DfvOmNU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-LBpsvvSjPTSivwNQiIh5mw-1; Fri, 17 Jan 2025 06:14:49 -0500
X-MC-Unique: LBpsvvSjPTSivwNQiIh5mw-1
X-Mimecast-MFC-AGG-ID: LBpsvvSjPTSivwNQiIh5mw
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-467b0b0aed4so43730421cf.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 03:14:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737112488; x=1737717288;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1lENVaVHq5DBFoFS4KQgpJPSAY3s3TaB6R40bHpXlc=;
 b=ZaFabZ88BLpekLj80Tc5+D5hdnz534vjXsLLIS0oSmmRE/wG+Dhp9tf3wrshWHcc4L
 dKsSbv8dj8Eh2rQR9blm5JnwKQ8eFw5H+SZOHwWwCL8J3t6VXUSMY4nfPzYAwZst4AIj
 XRmnEFtlPfeVxXhxOrOA6MhNrAjKNM3VGfkBgxmTUPaZgWOq7QMCsLM3kRjfC34wysB5
 JW06/7VLgpprVXzV4F/eB0v28nTr9gvnCJ/aSEJETKVC9oqD/dZvDyav8crm2HY7owAD
 /VJsFf4RgcdJcp7bFuhKgqeZTk1oiCj3l/krvBJ2K6+iExetdG68gIghG+vyeHgNIdsl
 vOyw==
X-Gm-Message-State: AOJu0YwFsQGUBUzGyZbU4L0uKPF8tgmAtHdZfL1iOZdCxVTvPMEzKUYy
 X2zy06IbY+4UEeVfGzQWfag15PxkXShaRKlfQ6Hgy6NH/K6dzDZN+azmUWfpOObG+K0D1h8a3rT
 XWqR2rWcTP7go9Lj1xggMWRJRnaFmc71UHgj7vOCXkRap4DF8iOmC
X-Gm-Gg: ASbGncsCDjid7oEe7jkK8xrvB/e9AeGTudPoxfDmtrFnBMD+hzGpgK6x2tyT3W4756b
 sWENjhk++VaxdrjEw3bqodETWHMO3Wv/aCznJcazCrgckfzMj4JWGaLm4FX9dLCFtZ2xTxSBQZz
 sEssBlmfmeBEXXAzWOl4odC90wbJJdtH7tRm/jtMv/WZrW7b43EVU8opEcRuGctgzkKvCOBqN2J
 WiQLKIIcjc5CmsXT5tqAqRQa2j8EERLcBFBUxCJ7UpX/FANS0m7KPiqkU41KhNrZ8G3EuEEXfKJ
 NncktlD20GSz
X-Received: by 2002:a05:622a:28c:b0:467:6c95:19e5 with SMTP id
 d75a77b69052e-46e12a0c21fmr30653501cf.8.1737112488730; 
 Fri, 17 Jan 2025 03:14:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVM5AvhW8p1frx6VhwSgfV7h5hHuOcTGX0uK1gJYYfi66gKwvdFVdnljbGH7xlqRboqw/DRA==
X-Received: by 2002:a05:622a:28c:b0:467:6c95:19e5 with SMTP id
 d75a77b69052e-46e12a0c21fmr30653191cf.8.1737112488379; 
 Fri, 17 Jan 2025 03:14:48 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-119.web.vodafone.de.
 [109.42.51.119]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e102ec2d9sm10202731cf.12.2025.01.17.03.14.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 03:14:48 -0800 (PST)
Message-ID: <9e64e7cf-eca9-4b9c-ba30-1ce1441e81f7@redhat.com>
Date: Fri, 17 Jan 2025 12:14:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Remove deprecated machines pc-i440fx-2.4 up to
 pc-i440fx-2.12
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, devel@lists.libvirt.org,
 Kashyap Chamarthy <kchamart@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250117102738.59714-1-thuth@redhat.com>
 <Z4o55sRqJJtMd-zI@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z4o55sRqJJtMd-zI@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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

On 17/01/2025 12.07, Daniel P. Berrangé wrote:
> On Fri, Jan 17, 2025 at 11:27:35AM +0100, Thomas Huth wrote:
>> While our new auto-disablement of old machine types will only kick
>> in with the next (v10.1) release, the pc-i440fx-2.* machine types
>> have been explicitly marked as deprecated via our old deprecation
>> policy mechanism before (two releases ago), so it should be fine to
>> remove them now already.
> 
> These were marked deprecated manually in 9.1.0 with:
> 
>    commit 792b4fdd4eb8197bd6eb9e80a1dfaf0cb3b54aeb
>    Author: Philippe Mathieu-Daudé <philmd@linaro.org>
>    Date:   Wed Feb 28 10:34:35 2024 +0100
> 
>      hw/i386/pc: Deprecate 2.4 to 2.12 pc-i440fx machines
>      
>      Similarly to the commit c7437f0ddb "docs/about: Mark the
>      old pc-i440fx-2.0 - 2.3 machine types as deprecated",
>      deprecate the 2.4 to 2.12 machines.
> 
> but that commit was reverted a couple of weeks later in 9.1.0 dev

No, we did not revert that commit, the text is still there, so I think it 
still applies.

> when I added the automatic deprecation/deletion logic
> 
>    commit 37193b7b43b6a973e56fa115098c5895ebdc7145
>    Author: Daniel P. Berrangé <berrange@redhat.com>
>    Date:   Thu Jun 20 17:57:41 2024 +0100
> 
>      hw/i386: remove obsolete manual deprecation reason string of i440fx machines
> 
> IOW, in terms of releases, these deprecations were introduced under
> the new policy rather than the old policy.

Why should your generic policy override an explicit statement for those 
machines?

>> Note that we can not do much additional clean ups on top yet since
>> the corresponding q35 machines (which share the same compatibility knobs)
>> are still around and only will be removed for the 10.1 release instead.
>> So the bigger clean-up can only be done for 10.1, but removing the i440fx
>> machine types now will still have at least a small benefit of accelerating
>> our CI a little bit (since we don't have to run tests for these old machine
>> types anymore).
> 
> FYI Philippe had a series removing i440fx 2.4 & 2.5 which includes alot of
> the extra cleanups:

Sure, I saw it, but since you question whether we can already start removing 
the q35 machines for 10.0, we cannot do the extra clean-ups yet. But in my 
opinion, we could at least start removing the i440fx machines that have an 
explicit deprecation statement.

  Thomas


