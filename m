Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD819C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 08:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4cvF-0001ZX-Kl; Wed, 08 May 2024 04:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s4cv9-0001Rg-1c
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s4cv6-0006DA-SM
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715157899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bh3nWnBdheAohNiM2wJ5KVvWzNAFdXH9saS7mXjdRXA=;
 b=RVXRyzm0DoCteArIfrTREqmwGdKTDEXG8gTNpqWkwoWLboJuP8sa1hpKjz0xa6l1vvOU9a
 l/copQGRze1yqc72PHbug0A0hI4r4+fdrHh5JfYPp87tfKzAW+RhoP++6eqt4BxiuTN8HZ
 V3q+D96Viot6pMyfGyMN40UvoIy74Ys=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-tdQPr1ZuMKehbXA5ygdL8Q-1; Wed, 08 May 2024 04:44:58 -0400
X-MC-Unique: tdQPr1ZuMKehbXA5ygdL8Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41ab7cdccd2so17049125e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 01:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715157897; x=1715762697;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bh3nWnBdheAohNiM2wJ5KVvWzNAFdXH9saS7mXjdRXA=;
 b=dSUz740e5b2dacKgf/MJ1DAnJjHZAzWKXhem12kZ3f/ezys9iz8/ud2OdTDZOckjIv
 VekUcYVmyMoz9uBAnzwcCJN3jLuc5gQQcCZqxnhJsMovjru2jvnCAiHiCkVtuF83Y/aw
 JFrv8TgyAzTxLUL+m91/61UxpQUJjxBD9CoCSZnN4lP+EIbD3UyHzhxbZLDvZGvlA35N
 3Wi6NSB0O8rjOhIE2NKsDHVc8wiN0FsU+Haqag281RDwyckmfX34cm4xhM4VKPySwoEB
 EUu/9W3wWsLcWUKZ5uaWostqYKFOjz62xKbbrUHy1jedMxc5xpYzBrlv81sCV9fss3W/
 9y9g==
X-Gm-Message-State: AOJu0YwuszF5s87LvfXmIFwBJ0It3SH0NXveHPCaQHZMSRJRgDBP2YMO
 5gxpwCSoB75LYnRCD16jDTNWAO2T/UR07BPhMB/WgGsyt/ihEmJVqQ21/UrrNk6rFtsdFqcSSzd
 FFHJbS9JLIu7FTnWHGsRPFuD/44NLJExvCK8cn+uK8GiKHvMum2oe
X-Received: by 2002:a05:600c:1911:b0:41e:a90d:120e with SMTP id
 5b1f17b1804b1-41f71bca2b8mr15649515e9.20.1715157897070; 
 Wed, 08 May 2024 01:44:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqbD1SfcZPGPujVMl9seaJfBqRDlBl7qRpcraLvl5G+egWdKaQSIqNjR3BNcLfjR2UrrGeSw==
X-Received: by 2002:a05:600c:1911:b0:41e:a90d:120e with SMTP id
 5b1f17b1804b1-41f71bca2b8mr15649395e9.20.1715157896676; 
 Wed, 08 May 2024 01:44:56 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a5d694d000000b0034c926ef66csm14711672wrw.51.2024.05.08.01.44.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 01:44:56 -0700 (PDT)
Message-ID: <e70a8a3f-9c87-4b71-a1ae-bfc1d64b37c5@redhat.com>
Date: Wed, 8 May 2024 10:44:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: Cord Amfmgm <dmamfmgm@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <dcaed5da-5e94-4cb6-b5b8-0a571eac371b@tls.msk.ru>
 <CACBuX0Q_JOp1xGKZjnrBguiXVcM-ApfVrOs9UQE2B7sq=f5vLQ@mail.gmail.com>
 <CACBuX0SUvsip=hj5NbE3g5gCxSmdRKbK-k=ZQz819TDEfvtXgw@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CACBuX0SUvsip=hj5NbE3g5gCxSmdRKbK-k=ZQz819TDEfvtXgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On 07/05/2024 22.20, Cord Amfmgm wrote:
> 
> 
> On Wed, Apr 24, 2024 at 3:43 PM Cord Amfmgm <dmamfmgm@gmail.com 
> <mailto:dmamfmgm@gmail.com>> wrote:
> 
>     On Thu, Apr 18, 2024 at 10:43 AM Michael Tokarev <mjt@tls.msk.ru
>     <mailto:mjt@tls.msk.ru>> wrote:
> 
>         06.02.2024 10:13, Cord Amfmgm wrote:
>          > This changes the ohci validation to not assert if invalid
>          > data is fed to the ohci controller. The poc suggested in
>          > https://bugs.launchpad.net/qemu/+bug/1907042
>         <https://bugs.launchpad.net/qemu/+bug/1907042>
>          > and then migrated to bug #303 does the following to
>          > feed it a SETUP pid and EndPt of 1:
>          >
>          >          uint32_t MaxPacket = 64;
>          >          uint32_t TDFormat = 0;
>          >          uint32_t Skip = 0;
>          >          uint32_t Speed = 0;
>          >          uint32_t Direction = 0;  /* #define OHCI_TD_DIR_SETUP 0 */
>          >          uint32_t EndPt = 1;
>          >          uint32_t FuncAddress = 0;
>          >          ed->attr = (MaxPacket << 16) | (TDFormat << 15) | (Skip
>         << 14)
>          >                     | (Speed << 13) | (Direction << 11) | (EndPt
>         << 7)
>          >                     | FuncAddress;
>          >          ed->tailp = /*TDQTailPntr= */ 0;
>          >          ed->headp = ((/*TDQHeadPntr= */ &td[0]) & 0xfffffff0)
>          >                     | (/* ToggleCarry= */ 0 << 1);
>          >          ed->next_ed = (/* NextED= */ 0 & 0xfffffff0)
>          >
>          > qemu-fuzz also caught the same issue in #1510. They are
>          > both fixed by this patch.
>          >
>          > The if (td.cbp > td.be <http://td.be>) logic in ohci_service_td()
>         causes an
>          > ohci_die(). My understanding of the OHCI spec 4.3.1.2
>          > Table 4-2 allows td.cbp to be one byte more than td.be
>         <http://td.be> to
>          > signal the buffer has zero length. The new check in qemu
>          > appears to have been added since qemu-4.2. This patch
>          > includes both fixes since they are located very close
>          > together.
>          >
>          > Signed-off-by: David Hubbard <dmamfmgm@gmail.com
>         <mailto:dmamfmgm@gmail.com>>

Your Signed-off-by line does not match the From: line ... could you please 
fix this? (see 
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emails-must-include-a-signed-off-by-line 
, too)

>         Wonder if this got lost somehow.  Or is it not needed?
> 
>         Thanks,
> 
>         /mjt
> 
> 
>     Friendly ping! Gerd, can you chime in with how you would like to
>     approach this? I still need this patch to unblock my qemu workflow -
>     custom OS development.
> 
> 
> Can I please ask for an update on this? I'm attempting to figure out if this 
> patch has been rejected and I need to resubmit / rework it at HEAD?

Looks like it's hard to find someone who still can review OHCI patches these 
days...

Anyway, I tried to get the reproducer running that had been added to the 
original patch (installed an Ubuntu 18.04 guest and compiled and ran that 
ohci_poc program in it), but so far, I failed. Could you please provide 
detailed steps how you can still produce this issue with the latest version 
of QEMU, please?

  Thanks,
   Thomas



