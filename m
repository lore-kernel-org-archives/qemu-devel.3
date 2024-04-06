Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EDDCD1284
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 10:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rt3kS-0007s2-2Y; Sat, 06 Apr 2024 06:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1rt3kO-0007qv-SJ
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 06:58:08 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1rt3kN-0001jw-DC
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 06:58:08 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-344047ac7e4so306626f8f.0
 for <qemu-devel@nongnu.org>; Sat, 06 Apr 2024 03:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712401084; x=1713005884; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=YlXHqLaoVrNy3ounRRsAuneHu1Iwc/5dL8h81UCpCfQ=;
 b=NSpX7LP5wy+JXfqm3g3Ot0fJv71A1njepSVm8Br/bnIfg6u5c3Ei3XInaycHug4bZC
 3w/057m0mOhsLPn+0w+6+/a2IJLryzAEfw5MeKx1sB1p/9YQxNuHmw6QGYM4SpiUR1F5
 2zXoPqdWldkbkMulOdts4nfciP6K/GK4T9PsK2DVR7mh8xPWUZGNZmzFU2wCs/yMb0bV
 D8LTYpvzDQKVZy+2dXeYFmZczqRkN/kuNEvbVMP/6DT1/fSKwe1FKkI5n1clKC30aeje
 LI9uF1Ho9CQcssoIBZ2WIqW0C842lcsfJ8LMAEjkjWaHMSGzD1wgy/AwSmEd92frUBzD
 Wo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712401084; x=1713005884;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YlXHqLaoVrNy3ounRRsAuneHu1Iwc/5dL8h81UCpCfQ=;
 b=W7UJhkBbTyVqL9iqaH1IbiDoOtbNLxhjfRRC9BntlSIobXmwENkZphBlML3nHpfcI2
 1J6NlLx9ipo89CzK9oKcqkrHm7gBsvrz5KBp9Y6q8kRBM/CXpWsHFBiBhoE1GKjr93zD
 vDzNwTY7hxCy3nBzUWgGLgQQI33+XPavq66GchzU+olTmqdK8FnBWlA9mWNjVLk4LV7m
 J0FgpGQMLceAyeK002g0dqF2jRVJ85sKhHYbF8/nS7YyVBIkvFDu3OA06VRBfYYkJgX2
 oY0cNwpHBSbUG6xx2gACVqUFFmHUe20eLexPYm/hBImTb9avF+814QsfKdoaOKLErvkV
 0Z3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVdB1jllc5fDUPqmMsTu3dhs4qxOZWCdm3+gZmXKopyYxmKrardqNZIDuS4aapfVaG5xymOf5nHDAiVIXz0wA+RCvvu5Y=
X-Gm-Message-State: AOJu0YzyBGH0J/BIinQjrPSy7HiBMsxQcmLhz6abbA9+wIMuxlpxDKuS
 zaUgxSYUV5RumBXNfZkS8HU4f7CbjldWMMnsCWApjnN5Nt2iQZd1
X-Google-Smtp-Source: AGHT+IEeI+13HH/wqUs0OoOPW8rciLlYfdxc9/JnvD5dOjAifTJGvFuJZptctNLF+G7A+kXYe2p2MA==
X-Received: by 2002:a05:6000:ac2:b0:33e:710a:b699 with SMTP id
 di2-20020a0560000ac200b0033e710ab699mr3701156wrb.9.1712401083825; 
 Sat, 06 Apr 2024 03:58:03 -0700 (PDT)
Received: from ?IPV6:2a00:23c7:df82:3001:2982:11d0:133d:ad80?
 ([2a00:23c7:df82:3001:2982:11d0:133d:ad80])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a056000136d00b00343e3023fbasm3947358wrz.34.2024.04.06.03.58.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Apr 2024 03:58:03 -0700 (PDT)
Message-ID: <6fad8151-4bde-4a02-96fb-27b99d93757f@gmail.com>
Date: Sat, 6 Apr 2024 11:58:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen-hvm: Avoid livelock while handling buffered ioreqs
To: Ross Lagerwall <ross.lagerwall@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
References: <20240404140833.1557953-1-ross.lagerwall@citrix.com>
Content-Language: en-US
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <20240404140833.1557953-1-ross.lagerwall@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x42b.google.com
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

On 04/04/2024 15:08, Ross Lagerwall wrote:
> A malicious or buggy guest may generated buffered ioreqs faster than
> QEMU can process them in handle_buffered_iopage(). The result is a
> livelock - QEMU continuously processes ioreqs on the main thread without
> iterating through the main loop which prevents handling other events,
> processing timers, etc. Without QEMU handling other events, it often
> results in the guest becoming unsable and makes it difficult to stop the
> source of buffered ioreqs.
> 
> To avoid this, if we process a full page of buffered ioreqs, stop and
> reschedule an immediate timer to continue processing them. This lets
> QEMU go back to the main loop and catch up.
> 

Do PV backends potentially cause the same scheduling issue (if not using 
io threads)?

> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
>   hw/xen/xen-hvm-common.c | 26 +++++++++++++++++---------
>   1 file changed, 17 insertions(+), 9 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


