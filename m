Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3C8C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 15:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9o4i-0001eT-9J; Wed, 22 May 2024 11:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1s9o4e-0001do-GN
 for qemu-devel@nongnu.org; Wed, 22 May 2024 11:40:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1s9o4c-00080y-RB
 for qemu-devel@nongnu.org; Wed, 22 May 2024 11:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716392412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hae5KNzCnGzdUoAM4VwiTi6v+RIvbbZNDLMNF17CKbg=;
 b=NxKoYRK2u4kM6boiwGLdl3X89fU2pVSw1iBlMDU73L2P+kwS+cnMt6CzyfCwwZie4u5kfG
 jPEa2qx5UXPhlGIf6H0usRZfVJNROcmWd9hkCg9WjURP7zdFAsCB+L+dHYw1E1n0+isarr
 nZYZhqCeGmSkJwO86pyY0k6tjA8bj+I=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145--qCi37lRM0maPeHpIJsqDw-1; Wed, 22 May 2024 11:38:52 -0400
X-MC-Unique: -qCi37lRM0maPeHpIJsqDw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2e1e7954970so3703341fa.2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 08:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716392331; x=1716997131;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hae5KNzCnGzdUoAM4VwiTi6v+RIvbbZNDLMNF17CKbg=;
 b=I5bmJQqnmR7bYIwRy/9Y7/D7VRLja81AhcRINZeD/qJe9XFBHm78XUXMn73qqmstR4
 TmNkiltieGZV8gL8SIEUiFo5s3RCjn88jr2ZvCavFCeASLiH63CWbS3HPzD+c0C6XD9S
 BKSMRlySPauny4zPuSZhKG1rPdIYDDFfYcGUcS99Q+WXUI7rjlDFZAH84KpI/vQUGk8U
 j89bTYF/INNblYOMaMa2cQaHIf4aSZWCtvBoPSaWctQCPjaASeiPNq5MVlsEnmiji3YM
 3Jz5Mcbi8NxvAKtMO8c0If5PYtLwegoHARHGP6VVluV3Q5tqx7rfE/I6oBlbH7tFymKE
 SyRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUweBQ/IMAZqmU+z6AnoZrPqLGxzU71e/PZWxcdffPeiWgwb7tB4y1ObDCz/9aYxDwiVZJzHi010qXV95ECNtzfeaISFf0=
X-Gm-Message-State: AOJu0Yyf/xEPBfIB3XEuplI9qU5h88uN5l6Pp7fUwVQgeddB1gf0QEpy
 CuuF9u19liC7in1MUHscuhP7jNq/LOB6vwJ+28ohkHRiOw/T4no/bjfZZWDFZtIgradv2grkTkO
 Zpl7ulDGi4c1K5fa5qTsLkrbY6D+NB14EWcrk23q9wYoIuzxU6M3M
X-Received: by 2002:a2e:8912:0:b0:2d4:5370:5e8a with SMTP id
 38308e7fff4ca-2e9494876a3mr19212321fa.22.1716392331269; 
 Wed, 22 May 2024 08:38:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8wcu+3XcVr0WVgEeYZjadkMEvS5yYWnDVexTkEfWJCJbB2Sxn4kxpsdQ45RTjDxRBacLDzw==
X-Received: by 2002:a2e:8912:0:b0:2d4:5370:5e8a with SMTP id
 38308e7fff4ca-2e9494876a3mr19212171fa.22.1716392330860; 
 Wed, 22 May 2024 08:38:50 -0700 (PDT)
Received: from [10.43.3.102] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2e4d1622740sm40174091fa.119.2024.05.22.08.38.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 08:38:50 -0700 (PDT)
Message-ID: <2935cc48-8807-47f0-acdb-19ae219c3aca@redhat.com>
Date: Wed, 22 May 2024 17:38:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qga: Add an interactive mode to guest-exec via VSOCK for
 Linux
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@gmail.com
References: <20240522150657.2378330-1-alexander.ivanov@virtuozzo.com>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
In-Reply-To: <20240522150657.2378330-1-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/22/24 17:06, Alexander Ivanov wrote:
> Add an interactive mode to the guest-exec command in the QEMU Guest Agent
> using the VSOCK communication mechanism. It enables interactive sessions
> with the executed command in the guest, allowing real-time input/output.
> 
> Introduce "interactive" mode in the GuestExecCaptureOutputMode enumeration
> and add optional "cid" and "port" fields to the guest-exec response. In
> such a way user can execute guest-exec command, get CID and port number
> from the response and connect to the guest server. After connection user
> can communicate with the started process. All the data transmitted to the
> server is redirected to stdin. Data from stdout and stderr is redirected
> to the client. All data blocks are preceded by 32-bit headers (network
> byte order): most significant bit contains a sign of stream (stdout - 0,
> stderr - 1), all the other bits contain the payload size.
> 
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>  qga/commands.c       | 272 +++++++++++++++++++++++++++++++++++++++++--
>  qga/qapi-schema.json |  11 +-
>  2 files changed, 273 insertions(+), 10 deletions(-)

FYI, libvirt recently added support for SSH over VSOCK:

https://libvirt.org/ssh-proxy.html

and it'll be released soon:

https://libvirt.org/news.html

Though, it requires (soon to be released) systemd to automatically set
up SSHD to listen on VSOCK (but it can be configured manually).

Michal


