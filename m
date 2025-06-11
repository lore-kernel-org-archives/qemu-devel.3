Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1689C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 07:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPGAK-0001Ur-IU; Wed, 11 Jun 2025 03:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPGAG-0001UR-In
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPGAB-0005Q4-2M
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749627981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FVClaBkY4WD4r9T1exrrZqDb86jbxF0jQeXn9dmIqFI=;
 b=cUtdpSVD5CFz+jcetHLZAB5YkfKaWUPAsGpPv/4Ng51ayADs1Z1TeIFFEuVgWYjgTS6/nX
 s97iCsvjUhxELXc5gHqIPnQtGCMgU7b76vpEcXXq3sN3isMgl8PpSz9d+RExuX1Tt2yVNe
 MKM1Bhrnicu5CW4vcV9CBhg7qBVE0+Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-tTCYeT7MNkSV6l_OlAutVQ-1; Wed, 11 Jun 2025 03:46:18 -0400
X-MC-Unique: tTCYeT7MNkSV6l_OlAutVQ-1
X-Mimecast-MFC-AGG-ID: tTCYeT7MNkSV6l_OlAutVQ_1749627977
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f3796779so4279688f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 00:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749627977; x=1750232777;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FVClaBkY4WD4r9T1exrrZqDb86jbxF0jQeXn9dmIqFI=;
 b=lUqYpLbMtfSShEmORU8aRpX54uZuls4c5c6aWUdCEZXEw4VnWhRXmv6fFy9qmnrI9P
 5d6z4DKr0nz+rYYArgmV2AjHXNNPQcE/Fls3qRxGkCsRSqtMNNlhOiGnWE5DiGzVQQ/C
 +RWG4tdO3dyyO9tyTGQ9NbM3xDuSTFSCp43oiVqGp9dp+M+NPC9gUu38jdcYaVR2wT+A
 wpkuY735W2XJAzzpUcKQCBsUTgv7NMp7qtoJn1BZeBGfod3egpjmmqsa3aUYB1sWWIyN
 +zTuFVOVILM/NFK//n6RLtMC00GNsoEkQUQBo25Z3fvWfKvTHio3qHYKlhovZTdrggwV
 11Sg==
X-Gm-Message-State: AOJu0Yx0ZtR9gePTCkaRgYw+IUS424RbXCqIffWohCl6htopL2rLAdEE
 TfPu/PAhgaa/W+bNtuZBGYnLSda7XE3SfsLrc6LQSDByV9K+EPwE6TRuX25kf0tz2370zQ5lfLi
 JdWlS59WBLhjSvJqNZtA4slPmghTq026Jmr0F7pQYFrTFKWz5KR4uYtD6
X-Gm-Gg: ASbGncs5siFj/xIhxVBdCdD1yyFGJaCrzd33Jy3g6AC3e4mXDLxA62jMkY8mocgM/t9
 AS7j9+co2V44+MMPODviyJV78eCAeIl7UEdHXntgn2pafarx3V2Pr4WA4Y9zyp3GeXHCZOaeZ+P
 L4Y1L7lcgjlKTATUgiYkBM/5iunfSw56XTIYyw+2f3/TRK8G6UtjU5BddLFH6ZzyJBxWgbq3E59
 a//idLjihJQ9G7i6kyWB5oKDk1rbJQt0C7ZQsGjlCS4B1oE1v5lE9z4u9cTGK4BSXBR7JTUYJQZ
 b/kdRj6k1HRJIVVz1XXi7xpsN1sZ652N1BpF5QT0fIX0+d4rDqtbP0A2QgJx
X-Received: by 2002:a05:6000:400f:b0:3a4:fb33:85ce with SMTP id
 ffacd0b85a97d-3a558a31369mr1206017f8f.46.1749627977195; 
 Wed, 11 Jun 2025 00:46:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD/+VQD23kXFZZNK29zmy1sdPyiBj81ebbHW3crxKiAeoicikd5At3N8TzXQztPQslP95o8A==
X-Received: by 2002:a05:6000:400f:b0:3a4:fb33:85ce with SMTP id
 ffacd0b85a97d-3a558a31369mr1206002f8f.46.1749627976830; 
 Wed, 11 Jun 2025 00:46:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244fceasm14199466f8f.82.2025.06.11.00.46.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 00:46:16 -0700 (PDT)
Message-ID: <ab28f674-918f-46dc-8ca9-c61f84711ed2@redhat.com>
Date: Wed, 11 Jun 2025 09:46:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/23] vfio-user: add vfio-user class and container
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-7-john.levon@nutanix.com>
 <c0fd6bf3-cf0b-4843-a7ea-6ac49480e7ca@redhat.com> <aEhi5cVljVfjTvJA@lent>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aEhi5cVljVfjTvJA@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 6/10/25 18:52, John Levon wrote:
> On Tue, Jun 10, 2025 at 11:57:00AM +0200, Cédric Le Goater wrote:
> 
>>> @@ -529,6 +531,8 @@ _meson_option_parse() {
>>>        --disable-vdi) printf "%s" -Dvdi=disabled ;;
>>>        --enable-vduse-blk-export) printf "%s" -Dvduse_blk_export=enabled ;;
>>>        --disable-vduse-blk-export) printf "%s" -Dvduse_blk_export=disabled ;;
>>> +    --enable-vfio-user-client) printf "%s" -Dvfio_user_client=enabled ;;
>>> +    --disable-vfio-user-client) printf "%s" -Dvfio_user_client=disabled ;;
>>>        --enable-vfio-user-server) printf "%s" -Dvfio_user_server=enabled ;;
>>>        --disable-vfio-user-server) printf "%s" -Dvfio_user_server=disabled ;;
>>>        --enable-vhdx) printf "%s" -Dvhdx=enabled ;;
>>
>> can't we simply have a CONFIG option and select the device on platforms
>> supporting it ?
> 
> You mean always build vfio-user client rather than optionally? Why would it be
> different from other optional components?

why would it be optional ? I don't see any dependency for vfio-user-client.
vfio-user-server depends on libvfio-user [1]. Not vfio-user-client.
Should it ?

Does this mean we are abandoning libvfio-user ? Sorry I am not familiar with
this framework.

> AFAIK all platforms (at least in theory) would support it.

So what would be the reason for not compiling it ? It is not different
from VFIO AFAICT.


Thanks,

C.



[1] https://gitlab.com/qemu-project/libvfio-user


