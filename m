Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D41C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpkhZ-0000jq-3r; Wed, 05 Mar 2025 04:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpkhX-0000ia-A5
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:06:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpkhV-0006yi-Jj
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741165560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Fw2Tb9JWr/sxvSObFQ7ucVSMvme05rEetn/E3ajU6vs=;
 b=bvaXu1uRoX5Wtp38dQmbuNEcpcbpoYIT7QjOsMzLOf5bkr3NTRU9R7NBQVeGjwHW3qm+nV
 U3XVLAHdMIFeV6v2Kb1fT2idsBH0I0tvupqgADc9YYTkr2+8YEq5kGDp7sV5H8AQHY96OZ
 DZ2MU/3MEfEEJwOL2B2Ag90RuIF423Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530--vJB0hIIPW-LHe1tfbbapA-1; Wed, 05 Mar 2025 04:05:57 -0500
X-MC-Unique: -vJB0hIIPW-LHe1tfbbapA-1
X-Mimecast-MFC-AGG-ID: -vJB0hIIPW-LHe1tfbbapA_1741165557
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-390df5962e1so277553f8f.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 01:05:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741165556; x=1741770356;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fw2Tb9JWr/sxvSObFQ7ucVSMvme05rEetn/E3ajU6vs=;
 b=XAKl3NLcK/MGszDIJLnh8vM4yVSxizqNqjlpdjLpAuR12dmmORImfM1faGtZ0xzhDi
 oTw7H3uqVx2v4/xZOpixClpSO+qTOuNsun8SVGrFvV9fZwAEj9EjApnz3QrzR1loee6Q
 3pW2/5r8yElFmy6CCam/ETA3Uf6aOguFEuOZk4G9WVNNSyDCwnKzsYufaAChXMZnC7m5
 PIlAAEeggROCcA2e5Nmc5yTzoPR5riIGwhWxqFZlXIslPpxgzpxiEw1RAqAaMGJcI81U
 8eTnk/85ZFRQ0Rby7FnAo8kDAf9yjhPApsrOB28IwN04U4qzBvqMon35eED5q8NHbMGB
 7EEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1tUNd8ku4UofZ/dorzI5PYgnTpZGFAP4u+JF+xgjOkd5uEMuquU4XZRK6PuMWQ5tnS7N9YwmIHUcq@nongnu.org
X-Gm-Message-State: AOJu0YyP7NUUtE4bDE6d4PFe6mUsXaurJib/TFqFx9vZo0sTrIWpcy+y
 nB7SUIgkthD5jftweedjX0kb1I29FEA4+tpFW7vJAtUscgXu5BtaPyYh7W3/dblBSiDbSFR5r77
 wTDgvlTqZgElpnSFCqMIAt7sf3KwF0h3tWzW9CDKO5EXauxGvQKc5
X-Gm-Gg: ASbGncvaUS8qQXDxy3NQg+1JSl7AucCRQJkqWUROcM/+YoFQfXUGYTpNnuuDUlTxc8M
 VWB9bIFRXCPxbZQ6vEfAZ4US0H6Z7V6pN7C2e76v4H/vzJ/iyObtsZip4s49mMh49tBt9fMQmUU
 53T8TpidsdZ7DcSh1+BBUQriA1dQHYH2uyapFk/BE04ijFKiX9O/ODS3z8yhn/eRV4a5Or145s1
 nwJY5+SJwIBu+lUlb9gdnOo4+ZXtiVioyXBWz5t3PamkYzG3D2e4Um7ftovSGn8cWY4NtF7nZVs
 UoVlNf5/rESeO0PaY/wR6WnRqAN56/XQt68pNDL+fxL/cl4=
X-Received: by 2002:adf:e183:0:b0:391:22e2:ccd2 with SMTP id
 ffacd0b85a97d-39122e2d080mr850805f8f.3.1741165556614; 
 Wed, 05 Mar 2025 01:05:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3JL6dEwafitRYdnv7uBAzmeV1GhZosDKbcPRzV/hcRRSbAJDK0tHXsOmCuzm1ajZGDEaXkA==
X-Received: by 2002:adf:e183:0:b0:391:22e2:ccd2 with SMTP id
 ffacd0b85a97d-39122e2d080mr850772f8f.3.1741165556291; 
 Wed, 05 Mar 2025 01:05:56 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c5b33sm11406335e9.22.2025.03.05.01.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 01:05:55 -0800 (PST)
Message-ID: <a65bc513-5e13-4e63-96f8-5486a51ab377@redhat.com>
Date: Wed, 5 Mar 2025 10:05:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] tests/functional: stop output from zstd command
 when uncompressing
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org
References: <20250228102738.3064045-1-berrange@redhat.com>
 <20250228102738.3064045-8-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250228102738.3064045-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 28/02/2025 11.27, Daniel P. Berrangé wrote:
> The zstd command will print incremental decompression progress to stderr
> when running. Fortunately it is not on stdout as that would confuse the
> TAP parsing, but we should still not have this printed. By switching
> from 'check_call' to 'run' with the check=True and capture_output=True
> we'll get the desired silence on success, and on failure the raised
> exception will automatically include stdout/stderr data for diagnosis
> purposes.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/uncompress.py | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/uncompress.py b/tests/functional/qemu_test/uncompress.py
> index 76dcf22385..ce79da1b68 100644
> --- a/tests/functional/qemu_test/uncompress.py
> +++ b/tests/functional/qemu_test/uncompress.py
> @@ -13,7 +13,7 @@
>   import stat
>   import shutil
>   from urllib.parse import urlparse
> -from subprocess import check_call, CalledProcessError
> +from subprocess import run, CalledProcessError, DEVNULL
>   
>   from .asset import Asset
>   
> @@ -46,8 +46,8 @@ def zstd_uncompress(zstd_path, output_path):
>           return
>   
>       try:
> -        check_call(['zstd', "-f", "-d", zstd_path,
> -                    "-o", output_path])
> +        run(['zstd', "-f", "-d", zstd_path,
> +             "-o", output_path], capture_output=True, check=True)
>       except CalledProcessError as e:
>           os.remove(output_path)
>           raise Exception(

Reviewed-by: Thomas Huth <thuth@redhat.com>


