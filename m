Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A857DC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 08:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfy6j-00016H-At; Fri, 01 Mar 2024 03:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfy6i-000167-97
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:19:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfy6g-000061-LQ
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709281141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=24ZXx3xtEZcNh4Xv08GtABkBmPyt4HsnZ4bmsakX/tU=;
 b=gFV/Jgil9/1UIq70xepzUjAakcQOPY4uGTM0IK6SCo4rNGyTJMurFdFWrYfLLrDH4S6geZ
 PddHOfNmeNg17+oCtNHOq0F0FFl2DFySBVMGZNojMDevsgrHvy3M3JyQ/Spiiimr32guxi
 uoFhYgE5YKQeFvIffAVA2zl5xH1vp8A=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-Iz-PGMxuOUGn5cO79qJ5aA-1; Fri, 01 Mar 2024 03:18:59 -0500
X-MC-Unique: Iz-PGMxuOUGn5cO79qJ5aA-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1dc435b3e87so18839605ad.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 00:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709281139; x=1709885939;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=24ZXx3xtEZcNh4Xv08GtABkBmPyt4HsnZ4bmsakX/tU=;
 b=AVhZr9BFP9ZiOMjt8Q85SVhueiUyFP+Cos7VoLy9n0EGQidUkgTy9KhUnb/WdezyCk
 KP3axOrAH2Xlg8dVywEchVlA9tlNRuo95QCcYgPqf9MQZvkLPEzcOIiaIXkdJnh9fabc
 FFzXxqJCSMa1TzewBlw56ZUD0MuysLosUKkC8BwmYY9LXENmd0CBNSD0FZvsIY6Ez1W/
 ngaaKFlnkwRzE6V6gMxFM6kRFHo4YHdsI9KxaxqcSr8yvMXzdq+WPH0rTbT9H95Plphy
 z5gbl5ooW951NSsNG32QimMLiW3v4WdGi6PX96zAF5bKE4ye2pomhliB8dAMvAg62Wqj
 wapg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ/lfeEgxJFXYmKh9djOgYjm3Tt6WD0ME2iebj6R2ZLOtQ339kb1rdFBrJ7FDOsM+fzxz+7HSdkrGOdT4HLXE+yxKz+oI=
X-Gm-Message-State: AOJu0YwB6+OUgTQae1S1T9dOLNuPwtnTczNjogDQZgIN3nC8BdXtxGcc
 K5HL1IYketJJ4wpl4hMDNOk/4OivJ3ky/9UyqEX9TbJgsiw8hDuxw7omGow7xtBlO+fzIRZaJj9
 M5dkYyqOVqwFJffamJ7ZkcqB9/JGb/Wod/xLtPHIA9fwrhHSc+FIH
X-Received: by 2002:a17:902:6b4c:b0:1db:cb13:10f1 with SMTP id
 g12-20020a1709026b4c00b001dbcb1310f1mr836765plt.19.1709281139018; 
 Fri, 01 Mar 2024 00:18:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI5k4DYcQZYvoKhzaFmr8qGBvoAXQ0lrN16m9zxfgeCMHKx0bkm1xg8nWMrRa131dpIXZw2g==
X-Received: by 2002:a17:902:6b4c:b0:1db:cb13:10f1 with SMTP id
 g12-20020a1709026b4c00b001dbcb1310f1mr836753plt.19.1709281138652; 
 Fri, 01 Mar 2024 00:18:58 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-133.web.vodafone.de.
 [109.43.178.133]) by smtp.gmail.com with ESMTPSA id
 f4-20020a170902684400b001db337d53ddsm2860783pln.56.2024.03.01.00.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 00:18:58 -0800 (PST)
Message-ID: <56e58fe0-476c-4daf-b61c-3fc24d7623a5@redhat.com>
Date: Fri, 1 Mar 2024 09:18:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/us/bus.c PCAP adding 0xA in Windows version
Content-Language: en-US
To: benlunt@fysnet.net, qemu-devel@nongnu.org
References: <000101da6823$ce1bbf80$6a533e80$@fysnet.net>
From: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <000101da6823$ce1bbf80$6a533e80$@fysnet.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 25/02/2024 20.49, benlunt@fysnet.net wrote:
> Since Windows text files use CRLFs for all \n, the Windows version of QEMU
> inserts a CR in the PCAP stream when a LF is encountered when using USB PCAP
> files. This is due to the fact that the PCAP file is opened as TEXT instead
> of BINARY.
> 
> To show an example, when using a very common protocol to USB disks, the BBB
> protocol uses a 10-byte command packet. For example, the READ_CAPACITY(10)
> command will have a command block length of 10 (0xA). When this 10-byte
> command (part of the 31-byte CBW) is placed into the PCAP file, the Windows
> file manager inserts a 0xD before the 0xA, turning the 31-byte CBW into a
> 32-byte CBW.
> 
> Actual CBW:
>    0040 55 53 42 43 01 00 00 00 08 00 00 00 80 00 0a 25 USBC...........%
>    0050 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00       ...............
> 
> PCAP CBW
>    0040 55 53 42 43 01 00 00 00 08 00 00 00 80 00 0d 0a USBC............
>    0050 25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 %..............
> 
> I believe simply opening the PCAP file as BINARY instead of TEXT will fix
> this issue.
> 
> Resolves: https://bugs.launchpad.net/qemu/+bug/2054889
> Signed-off-by: Benjamin David Lunt <benlunt@fysnet.net>
> ---
>   hw/usb/bus.c | 2 +-
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -u a/hw/usb/bus.c b/hw/usb/bus.c
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -273,13 +273,13 @@
>       }
>   
>       if (dev->pcap_filename) {
> -        int fd = qemu_open_old(dev->pcap_filename, O_CREAT | O_WRONLY |
> O_TRUNC, 0666);
> +        int fd = qemu_open_old(dev->pcap_filename, O_CREAT | O_WRONLY |
> O_TRUNC | O_BINARY, 0666);

  Hi Benjamin!

Thanks for the patch! Since it's rather a trivial patch and our USB 
maintainer Gerd is pretty much busy with other stuff right now, I went ahead 
and put it in my current pull request.

Two things to notice: First, something along the way (likely your mail 
program) added a line break after the "O_WRONLY |" in the above two lines, 
so I had to undo that change manually before I was able to apply the patch 
... please try to use "git send-email" for sending patches, then such things 
don't happen.
And second, please use the scripts/checkpatch.pl script to check your 
patches - it was complaining about a line getting too long here, so I went 
ahead and fixed that, too (i.e. no need to resend, just a FYI for future 
patches).

  Thanks,
   Thomas

>           if (fd < 0) {
>               error_setg(errp, "open %s failed", dev->pcap_filename);
>               usb_qdev_unrealize(qdev);
>               return;
>           }
> -        dev->pcap = fdopen(fd, "w");
> +        dev->pcap = fdopen(fd, "wb");
>           usb_pcap_init(dev->pcap);
>       }
>   }
> 
> 
> 


