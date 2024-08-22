Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF383C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 04:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgzEg-0000ZB-Cp; Thu, 22 Aug 2024 00:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sgzEe-0000XP-Ko
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 00:15:44 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sgzEc-0001K4-KZ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 00:15:44 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7c3d9a5e050so267512a12.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 21:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724300140; x=1724904940;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cLPIMAtNJsErtAYDPZGhNQ9X5w0MHlA6ecqtaKbpwPE=;
 b=XIjt1ixVZ6Cz/8InxVNJqbim2A9LBtZx8t5XuBRAZqgfDghrhCFOcb4TbPrgW6jmiz
 6gaGPmQG55FFqmYJ31BPyQtZvWWEc/2xxvEPQ6tq5X7keAimgQAsbQbIzV8BUhfcjftO
 RNORiQvenKIXOx957G4DyukUEG1C/HpMXQ4AVLGtk3EWj0VPRMkDGolFiGNmyCeah40B
 sdmLJ0GHB7wR+FhGvfqmrfkTJkR6Gl5180wafvQ4f+TlshdZhGEpcByaADMBj1X+xgN0
 O/RzjDJDCQ3+4u24EL7xqmksIOxeb2LFZTDYE6QYTYbxtAjyywU4klO50jO0h9p28Hp2
 U9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724300140; x=1724904940;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cLPIMAtNJsErtAYDPZGhNQ9X5w0MHlA6ecqtaKbpwPE=;
 b=dtA1fv1M+sknRLyZTveNmbq+VDG3XkJBZ9hODiB6018Wen7z46nkLpBMsibcGmFF1a
 ffAJ6IqzeP330lBoaPzUs3+OfIqiJTT5lxtQVsGEKBJmsIW6ACPYGnWO9WBWzkD80aou
 IEkVuWxHVyNolUDMWnbhitV8nMetcZRK+5g/vU+vnkh6FkrL9VS3yP/zYXQh9hEEf9dN
 ZqK7YQMW5vSstBmPnakT438qMyAX2Nqe443ft2UN+1WnSLV9STUMDvITryk+0BMpu3YI
 UAdUePxkQLPynwiCvi0N02bq4bbHAxyrGN/uEAzSNOztJPpa3T4v23zHOv8IYaBlWYbf
 0nww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEbCaWVzq9qR5QHLMRaeDNVOOw4GneQZAwniGL7Mhw0WmUGhkhWMAkDsCcw92ucEVPfZ23OKypksH0@nongnu.org
X-Gm-Message-State: AOJu0YxTMZT6EwMal/io4DOwvpNlfAxpC78An3An6Q1TEDmwIDqHk9j4
 HbBOSLHpuuZ/fV/lOZfHW5shgEPQmv72UpLwENAmMnuyslHk58llimDL54l8VXc=
X-Google-Smtp-Source: AGHT+IEihNqr99kHAmEgEhP/qpzrsvPNyY6COlMxUqti3kvEvASZ1oGXhPqTBJ4MiAuycQ1XFf9GHg==
X-Received: by 2002:a05:6a21:e96:b0:1c4:c337:e24e with SMTP id
 adf61e73a8af0-1cada063fecmr4641970637.17.1724300139897; 
 Wed, 21 Aug 2024 21:15:39 -0700 (PDT)
Received: from [133.11.54.73] (shio03.csg.ci.i.u-tokyo.ac.jp. [133.11.54.73])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d5c0f78e51sm3491637a91.0.2024.08.21.21.15.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 21:15:39 -0700 (PDT)
Message-ID: <0b5b1773-f090-4733-96d2-f23ac101498e@daynix.com>
Date: Thu, 22 Aug 2024 13:15:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vnc: fix crash when no console attached
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240820131112.1267954-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240820131112.1267954-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/08/20 22:11, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Since commit e99441a3793b5 ("ui/curses: Do not use console_select()")
> qemu_text_console_put_keysym() no longer checks for NULL console
> argument, which leads to a later crash:
> 
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> 0x00005555559ee186 in qemu_text_console_handle_keysym (s=0x0, keysym=31) at ../ui/console-vc.c:332
> 332	        } else if (s->echo && (keysym == '\r' || keysym == '\n')) {
> (gdb) bt
>   #0  0x00005555559ee186 in qemu_text_console_handle_keysym (s=0x0, keysym=31) at ../ui/console-vc.c:332
>   #1  0x00005555559e18e5 in qemu_text_console_put_keysym (s=<optimized out>, keysym=<optimized out>) at ../ui/console.c:303
>   #2  0x00005555559f2e88 in do_key_event (vs=vs@entry=0x5555579045c0, down=down@entry=1, keycode=keycode@entry=60, sym=sym@entry=65471) at ../ui/vnc.c:2034
>   #3  0x00005555559f845c in ext_key_event (vs=0x5555579045c0, down=1, sym=65471, keycode=<optimized out>) at ../ui/vnc.c:2070
>   #4  protocol_client_msg (vs=0x5555579045c0, data=<optimized out>, len=<optimized out>) at ../ui/vnc.c:2514
>   #5  0x00005555559f515c in vnc_client_read (vs=0x5555579045c0) at ../ui/vnc.c:1607
> 
> Fixes: e99441a3793b5 ("ui/curses: Do not use console_select()")
> Fixes: https://issues.redhat.com/browse/RHEL-50529
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

