Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD6BE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 20:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLTDC-0001y8-FE; Wed, 11 Dec 2024 15:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLTD8-0001wo-SY
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 15:21:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLTD6-0004hh-Es
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 15:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733948485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QXmpF2jlAjHhWOojWhJpfNRHBGh/A6k5Uj8MiH2ewV0=;
 b=FbPdIDo1LaAgZjwNAvOnpQr1PjPqbvI0PGGrpPczPT2XNJLJ7lxapyeF5EW5VTEh3MMJmD
 zsDy2f3bMUNvcxDCFy+/c0cNH9w0EI7NSE4Yvia17qCZQ3aCNU4nghNygOACxsfd7ACW/l
 Xa6nE1hNZR2rGQPn9iTWOj1BGqVB8bI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-YRuR_-d9Oa2VYzy8yRjbfw-1; Wed, 11 Dec 2024 15:21:16 -0500
X-MC-Unique: YRuR_-d9Oa2VYzy8yRjbfw-1
X-Mimecast-MFC-AGG-ID: YRuR_-d9Oa2VYzy8yRjbfw
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d8f14fc179so81365876d6.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 12:21:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733948475; x=1734553275;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXmpF2jlAjHhWOojWhJpfNRHBGh/A6k5Uj8MiH2ewV0=;
 b=MH0Lu4yKltUzvpRfpJTAXI+U21UBYb1H7HLgroFh7oXEr0yU9zKfVIM6cZRpnFQ4P9
 /bIOetDWm8vrGE0eFXmaNSSe7VO+5DiBrfr1D+jHdGS+fKl8A48blLASbNJNF4eJBacN
 aGBm0xDxtyQ5Iro9BG91hblQfgUFv3BEyLsLIiNiBVX/ezZcWET07lemnmqy2TYBS4iz
 5vd5NXE+FYjUvXwX4sYusY2wvCR4ZJaHLdooVi9sKT0MViQUpaDX+0EUTPi1Ul5BzL9J
 1wiv9U7HsEaBnqtfYSy/5LEW8NAK3vNHsdbqbavEkfIW86IJAi2op9ohLt07J0KEWChQ
 nxfQ==
X-Gm-Message-State: AOJu0YySV/YjDT2JvRIwPhe66xjbxEQoni1I04giPCf0eC4sFEhtlIU6
 4ADIQVomDeKFXGZpYnVFE0BYAp28dD0IzRjS2OLGi/SxwDKmFRj61enHH7VnBSg8vZSUPwII2NK
 oAYR+682PPyFRnHN34earsgZi/2+miEEsAk/LiqBigvn+xAQYVboF5e9+yLNCUhv8Uh/O0Mr46E
 rIUwmLrFpC/ecShyLyuPWSaNBh3AFkiPkkQQ==
X-Gm-Gg: ASbGncuQWI/BCcniNeOrG2QLA94jS/feRrikCpZ2hHpG8LNrOnAoYIgCMOlE+l+PoyS
 JtALNxVRkhL83j1LBM0k4Wybqzf5Ee10XekLbOa2pUH1gQ8/9d+nZHAOytVdYpPJV80kHH69tCa
 4t0E7K8soWFcSia+BFGlm+rLXgjmBz41Upm2YADBm52oLTD/FrTRfRD7tVmIe8SR1I8DFtfguu/
 MENGN9NVQAKJxGR5hCXpFDpogfDIUHRTziLyvj+hGGfnV/cKSnB/cCiwk49+An6dNFJCQyIICH0
 l+My54HmNmePxXI=
X-Received: by 2002:a05:620a:808b:b0:7b6:cae1:a3cc with SMTP id
 af79cd13be357-7b6f2542d8bmr114567085a.19.1733948475706; 
 Wed, 11 Dec 2024 12:21:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPQe7d5AZLhDUScjMCSpininXujCJzGs5ce3JxVJYaGmWakLfFrI448vO56gpo8qbuR55zDA==
X-Received: by 2002:a05:620a:808b:b0:7b6:cae1:a3cc with SMTP id
 af79cd13be357-7b6f2542d8bmr114562985a.19.1733948475330; 
 Wed, 11 Dec 2024 12:21:15 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d91626e4bfsm31320996d6.130.2024.12.11.12.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 12:21:14 -0800 (PST)
Date: Wed, 11 Dec 2024 15:21:12 -0500
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 3/3] scripts/qemu-gdb: Support coroutine dumps in coredumps
Message-ID: <Z1n0OHYbaTW34m3y@x1n>
References: <20241211201739.1380222-1-peterx@redhat.com>
 <20241211201739.1380222-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211201739.1380222-4-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Wed, Dec 11, 2024 at 03:17:39PM -0500, Peter Xu wrote:
> Dumping coroutines don't yet work with coredumps.  Let's make it work.
> 
> We still kept most of the old code because they can be either more
> flexible, or prettier.  Only add the fallbacks when they stop working.
> 
> Currently the raw unwind is pretty ugly, but it works, like this:
> 
> (gdb) qemu bt
> Coroutine at 0x7fc474728748:

It didn't get commited.. I forgot to indent.  It looks like this:

  (gdb) qemu bt
  #0  process_incoming_migration_co (opaque=0x0) at ../migration/migration.c:788
  #1  0x000055cf3894d4d9 in coroutine_trampoline (i0=1565638480, i1=21967) at ../util/coroutine-ucontext.c:175
  #2  0x00007fc481f72f40 in ??? () at /lib64/libc.so.6
  #3  0x00007ffc0c74a520 in ??? ()
  #4  0x0000000000000000 in ??? ()
  Coroutine at 0x7fc474728748:
  #0      qemu_coroutine_switch + 120
  #1      qemu_aio_coroutine_enter + 357
  #2      qemu_coroutine_enter + 35
  #3      migration_incoming_process + 44
  #4      migration_ioc_process_incoming + 491
  #5      migration_channel_process_incoming + 146
  #6      socket_accept_incoming_migration + 119
  #7      qio_net_listener_channel_func + 132
  #8      qio_channel_fd_source_dispatch + 79
  #9      g_main_context_dispatch_unlocked.lto_priv + 316
  #10     g_main_context_dispatch + 37
  #11     glib_pollfds_poll + 91
  #12     os_host_main_loop_wait + 129
  #13     main_loop_wait + 204
  #14     qemu_main_loop + 42
  #15     qemu_default_main + 20
  #16     main + 41
  #17     __libc_start_call_main + 120
  #18     __libc_start_main_impl + 139

> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  scripts/qemugdb/coroutine.py | 50 +++++++++++++++++++++++++++++++-----
>  1 file changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
> index 20f76ed37b..b29ee16205 100644
> --- a/scripts/qemugdb/coroutine.py
> +++ b/scripts/qemugdb/coroutine.py
> @@ -46,9 +46,30 @@ def get_jmpbuf_regs(jmpbuf):
>          'r15': jmpbuf[JB_R15],
>          'rip': glibc_ptr_demangle(jmpbuf[JB_PC], pointer_guard) }
>  
> -def bt_jmpbuf(jmpbuf):
> -    '''Backtrace a jmpbuf'''
> -    regs = get_jmpbuf_regs(jmpbuf)
> +def symbol_lookup(addr):
> +    # Example: "__clone3 + 44 in section .text of /lib64/libc.so.6"
> +    result = gdb.execute(f"info symbol {hex(addr)}", to_string=True).strip()
> +    return result.split(" in ")[0]
> +
> +def dump_backtrace(regs):
> +    '''
> +    Backtrace dump with raw registers, mimic GDB command 'bt'.
> +    '''
> +    # Here only rbp and rip that matter..
> +    rbp = regs['rbp']
> +    rip = regs['rip']
> +    i = 0
> +
> +    while rbp:
> +        print(f"#{i}\t{symbol_lookup(rip)}")
> +        rip = gdb.parse_and_eval(f"*(uint64_t *)(uint64_t)({hex(rbp)} + 8)")
> +        rbp = gdb.parse_and_eval(f"*(uint64_t *)(uint64_t)({hex(rbp)})")
> +        i += 1
> +
> +def dump_backtrace_live(regs):
> +    '''
> +    Backtrace dump with gdb's 'bt' command, only usable in a live session.
> +    '''
>      old = dict()
>  
>      # remember current stack frame and select the topmost
> @@ -69,6 +90,17 @@ def bt_jmpbuf(jmpbuf):
>  
>      selected_frame.select()
>  
> +def bt_jmpbuf(jmpbuf):
> +    '''Backtrace a jmpbuf'''
> +    regs = get_jmpbuf_regs(jmpbuf)
> +    try:
> +        # This reuses gdb's "bt" command, which can be slightly prettier
> +        # but only works with live sessions.
> +        dump_backtrace_live(regs)
> +    except:
> +        # If above doesn't work, fallback to poor man's unwind
> +        dump_backtrace(regs)
> +
>  def co_cast(co):
>      return co.cast(gdb.lookup_type('CoroutineUContext').pointer())
>  
> @@ -101,10 +133,14 @@ def invoke(self, arg, from_tty):
>  
>          gdb.execute("bt")
>  
> -        if gdb.parse_and_eval("qemu_in_coroutine()") == False:
> -            return
> -
> -        co_ptr = gdb.parse_and_eval("qemu_coroutine_self()")
> +        try:
> +            # This only works with a live session
> +            co_ptr = gdb.parse_and_eval("qemu_coroutine_self()")
> +            if co_ptr == False:
> +                return
> +        except:
> +            # Fallback to use hard-coded ucontext vars if it's coredump
> +            co_ptr = gdb.parse_and_eval("co_tls_current")
>  
>          while True:
>              co = co_cast(co_ptr)
> -- 
> 2.47.0
> 

-- 
Peter Xu


