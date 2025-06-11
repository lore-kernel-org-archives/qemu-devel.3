Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAC3C71141
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 18:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPQHC-0007XF-LX; Wed, 11 Jun 2025 14:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPQDk-0001R9-4f
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPQDh-0002Pa-MB
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749666639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DeDnLPXQ8zX7KFzn3Vxboa7in3A1hzJ51PDxORcXQGA=;
 b=N0SeerZHF9usUGJVEWz3krH2V69cbRY9bsHuUpu2co8hnQacwaQLsXfu2oEtGFiBk2F1hi
 58pyxQK/L2/4n9XnU8fAFJXZgfRJeoA7Dn+JEJNCknzMRz+sJ2xzn0SO6/shYDeEJYyKDc
 g9BUHEnWXXraw7DgtN6XuDnxQUJf+m4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-7aaUw6F9PA-4GIiRrjTKBQ-1; Wed, 11 Jun 2025 14:30:36 -0400
X-MC-Unique: 7aaUw6F9PA-4GIiRrjTKBQ-1
X-Mimecast-MFC-AGG-ID: 7aaUw6F9PA-4GIiRrjTKBQ_1749666635
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-607434dbc78so164393a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 11:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749666635; x=1750271435;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DeDnLPXQ8zX7KFzn3Vxboa7in3A1hzJ51PDxORcXQGA=;
 b=BD99/sqlypBHDKSe/ea1AadJNR9qAh29bhVg7WLXPqtNTVKs/R6S1SjizjSSo2ccO4
 IARn2ESgEYErPLKwn/HDTQ3lGkSWIfXGfW2SApk4oUsJygrb4DEfijDZVcblD6n/Lz6C
 olpkXgvg6uCx8NWo3sbUFizxxDfiHZlzL4VdrELUud/7YjQdae6eR2bzJIJR482Z078o
 gukonJ0Xk9nj38a5FITPeUNLEILpOtpL2mNKo3f4FLntYBxm+jFaG7en0aqM0gPBCkBN
 jOfWe14+rHwqOCPy+5v/RUxuDQq5/lw4pdfz3CdS2mGbSfsgfeJD5rku7K7XAUUgjbvG
 V73w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWalh7zpozbobiZkwBIF0qYFhluoRnRfnhNDNFLZNz5JfjLobWFFSCjM1KtkI1DyvRbUVuHSLqy5weU@nongnu.org
X-Gm-Message-State: AOJu0YyFeNm7s2ZDSMb72ZNTPrX9Z/CRqJbhVFq/z/dyvoYew7JGoVxC
 DAke4fFLhsoBz9rLrqehmOjj7ZZIQhnVPMyu+ihG6eYmGYF1Cn6VOEbgPUNBfsPARrErwf9/jud
 uI4b8UQimwK3mRv5+ByNz3xC526re1PqraGMdq3FcySfQRwNuRxyKooaC
X-Gm-Gg: ASbGncs6qyBritZZYfSJLs4cKvLQYLWBtgTZSu6qZJ6QQnUx0fr0ttickNdY3LDZAHz
 bkAl/ILFtyk4PeEexbdFDRn4TNYXe6U0/RpI2G9lLz4Upm6txelpRbYjEXLoMt8fQPYsKUxrW/R
 n/8X+MiOU1vcwBP1eqyGfXPmQovgWbsqgktzjIiJfeJyR1vqxhNZfYeOWI+VSbpr/1DcCUrjldB
 CetcMggRKqjd1tVGFFNuPbTLbs1ZzFLRIyXK34WK3fsxZJ4fP5GjNaofTL4A4cI48d2k+JvsYOI
 6dLO8+PW0d6821wBhS84lQjD/756QFP7iXqUYRNVjK57XznZuvHl5aGNrYKTeRw=
X-Received: by 2002:a05:6402:5cd:b0:605:878:3553 with SMTP id
 4fb4d7f45d1cf-60846c4d573mr3807638a12.16.1749666635182; 
 Wed, 11 Jun 2025 11:30:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFitRRQmW5NZ4/6BLmT+MDlWQPz7/FiJUPa91R4cHucDjJe5/hbYXozA6tgbOtcA1ezMjoeJQ==
X-Received: by 2002:a05:6402:5cd:b0:605:878:3553 with SMTP id
 4fb4d7f45d1cf-60846c4d573mr3807622a12.16.1749666634808; 
 Wed, 11 Jun 2025 11:30:34 -0700 (PDT)
Received: from [192.168.0.4] (ltea-047-064-115-122.pools.arcor-ip.net.
 [47.64.115.122]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-607783e6728sm7760887a12.77.2025.06.11.11.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 11:30:34 -0700 (PDT)
Message-ID: <3bc239aa-a2ab-400c-84b5-d7de3e5193ea@redhat.com>
Date: Wed, 11 Jun 2025 20:30:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Seabios 1.17.0 20250611 patches
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250611075037.659610-1-kraxel@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250611075037.659610-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/06/2025 09.50, Gerd Hoffmann wrote:
> The following changes since commit bc98ffdc7577e55ab8373c579c28fe24d600c40f:
> 
>    Merge tag 'pull-10.1-maintainer-may-2025-070625-1' of https://gitlab.com/stsquad/qemu into staging (2025-06-07 15:08:55 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/kraxel/qemu.git tags/seabios-1.17.0-20250611-pull-request
> 
> for you to fetch changes up to cba36cf3881e907553ba2de38abd5edf7f952de1:
> 
>    seabios: update binaries to 1.17.0 (2025-06-11 09:45:00 +0200)
> 
> ----------------------------------------------------------------
> seabios: update to 1.17.0 release
> 
> ----------------------------------------------------------------
> 
> Gerd Hoffmann (2):
>    seabios: update submodule to 1.17.0
>    seabios: update binaries to 1.17.0

  Hi Gerd, hi Stefan,

I'm now getting this when doing a git pull:

Fetching submodule roms/seabios
fatal: remote error: upload-pack: not our ref 
b52ca86e094d19b58e2304417787e96b940e39c6
Errors during submodule fetch:
	roms/seabios

Looking at 
https://gitlab.com/qemu-project/seabios/-/commits/master?ref_type=HEADS 
there is a problem with the mirroring:

"This project is mirrored from https://review.coreboot.org/seabios. Pull 
mirroring failed 4 months ago.
Repository mirroring has been paused due to too many failed attempts. It can 
be resumed by a project maintainer or owner.
Last successful update 4 months ago. This branch has diverged from upstream. "

Could you please fix this?

  Thanks,
   Thomas


