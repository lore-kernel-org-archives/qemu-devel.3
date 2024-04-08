Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08F2CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 13:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtolx-0002f8-SV; Mon, 08 Apr 2024 09:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1rtols-0002eW-Ro
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 09:10:50 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1rtoll-0008Pd-9z
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 09:10:47 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3454fbdd88aso1839781f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 06:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712581837; x=1713186637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uCYE8xHgHv3RcgiFcSFtZmnhxxPV5TSVgjoL4tMGUrM=;
 b=JI1oRxw+KoTv9qSkbqCdh9DxSzW7TjaYXcJTEt/2h5tWUUUvfk9aGcYtekKFWDNB5H
 jSzYDNdXP6oOHvrK4gKtdTxSStjebqoeDNfELz8+3wJIzJ7TDfAqhWVEUr2IkYq786n+
 iOo250QuJZCOMa01nWn5dBNHvRfjTFqAv2mScueJ9iMR/409XgDT0mklvphPNeHGFQLx
 9+fVzZHiYtXlYSbUqux4uz0dJzw8HbLc5D4AHautm9v21Q3lhOKKbraHETk3Xxg6dTsh
 vyMYSJ+wu9GerEyS5hZ8vaaHxtuLuMyqsXom/qEb7qlRhfPvGLjgDscTz/C16uWRQd9C
 uENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712581837; x=1713186637;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uCYE8xHgHv3RcgiFcSFtZmnhxxPV5TSVgjoL4tMGUrM=;
 b=GloH8zM0p8xNuWTSXzcKgLXsTKmxgCp0+VaMpNar5m5No9szovKCeDqbZ/daSkwVXz
 AuXzQh/MQRVVgGAdSv/12YheEKEJRcAhOqasOHyoeGG+lydncZS4Iy5t3lEpd2nnXS7m
 zutaNU3JsGQ1w/gbRK7ocN91LVv3eYfCiobYwbqKiA3DzH/Ms7ofKe0pasc/1SidxEfe
 GextO549vGebdpa4k1IHrn64KBEeH1A3yT1sWBuipwLlsXrT+1PLogwqIKeYaNvLl7TM
 yNdgQpy6mk3u4Odn7gQjkEb9xmkakH/gjXRm9LEpxjUqvsJovr0m5Tbn7VtDCR1DcnmZ
 serw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH3iyYHD72kn8ba3haj/8z7YxrEBewOeFeP/Xg6NuX1FFX2rbv23yMGIUyIwn9bv9j+YTt65erT4b9mXaTnCbvaGKDgPk=
X-Gm-Message-State: AOJu0Yx/8lvrdkGL01o7ofpVNCBAS3qZ6ShVW48//u9t3IGr1T0oV7JF
 MRDsPZcVg36AjASTPflwASZhreSGbiMOxp8X+HKM5l7l4y3ehKQ1
X-Google-Smtp-Source: AGHT+IEXihybdhoq2l1gCTzovksly8MYwR0Z5sdElOesgg8KOFT8b0nCRPZjcio6D209ehLk+1Q7Tg==
X-Received: by 2002:a5d:64ec:0:b0:343:84a8:5d7 with SMTP id
 g12-20020a5d64ec000000b0034384a805d7mr8088499wri.49.1712581837256; 
 Mon, 08 Apr 2024 06:10:37 -0700 (PDT)
Received: from [10.95.144.96] (54-240-197-228.amazon.com. [54.240.197.228])
 by smtp.gmail.com with ESMTPSA id
 l10-20020adfe58a000000b003434f526cb5sm8864955wrm.95.2024.04.08.06.10.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 06:10:37 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <60c49e27-1275-411e-9cda-8405ca0ce010@xen.org>
Date: Mon, 8 Apr 2024 14:10:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen-hvm: Avoid livelock while handling buffered ioreqs
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 qemu-devel@nongnu.org
References: <20240404140833.1557953-1-ross.lagerwall@citrix.com>
 <6fad8151-4bde-4a02-96fb-27b99d93757f@gmail.com>
 <CAG7k0EqEwfS75n8FCncrr_VzPtJZk46KrLiYaMDfWfrZ6CEApg@mail.gmail.com>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <CAG7k0EqEwfS75n8FCncrr_VzPtJZk46KrLiYaMDfWfrZ6CEApg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 08/04/2024 14:00, Ross Lagerwall wrote:
> On Sat, Apr 6, 2024 at 11:58 AM Durrant, Paul <xadimgnik@gmail.com> wrote:
>>
>> On 04/04/2024 15:08, Ross Lagerwall wrote:
>>> A malicious or buggy guest may generated buffered ioreqs faster than
>>> QEMU can process them in handle_buffered_iopage(). The result is a
>>> livelock - QEMU continuously processes ioreqs on the main thread without
>>> iterating through the main loop which prevents handling other events,
>>> processing timers, etc. Without QEMU handling other events, it often
>>> results in the guest becoming unsable and makes it difficult to stop the
>>> source of buffered ioreqs.
>>>
>>> To avoid this, if we process a full page of buffered ioreqs, stop and
>>> reschedule an immediate timer to continue processing them. This lets
>>> QEMU go back to the main loop and catch up.
>>>
>>
>> Do PV backends potentially cause the same scheduling issue (if not using
>> io threads)?
>>
> 
>  From what I can tell:
> 
> xen-block: It reads req_prod / req_cons once before entering the loop
> so it should be fine, I think.
> 
> xen_console: Same as xen-block
> 
> xen_nic: It reads req_prod / req_cons once before entering the loop.
> However, once the loop ends it checks for more requests and if there
> are more requests it restarts from the beginning. It seems like this
> could be susceptible to the same issue.
> 
> (These PV backends generally aren't used by XenServer's system QEMU
> so I didn't spend too much time looking into it.)
> 
> Thanks,

Ok. Thanks for checking.

   Paul


