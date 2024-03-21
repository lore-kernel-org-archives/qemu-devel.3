Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F149C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnJyy-0004Jj-Eq; Thu, 21 Mar 2024 11:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1rnJyt-0004I7-3U
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:05:25 -0400
Received: from esa6.hc2706-39.iphmx.com ([216.71.137.79])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1rnJyp-0002cp-3p
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:05:21 -0400
X-CSE-ConnectionGUID: N7fkN0/iQWuyBgj+vUKOxA==
X-CSE-MsgGUID: pX4sx4W8ROqem9G9/IxxWA==
X-IronPort-RemoteIP: 209.85.210.70
X-IronPort-MID: 355351128
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:+JA1E6/5Y3sLp9wiW8I+DrUDPnyTJUtcMsCJ2f8bNWPcYEJGY0x3z
 GIaWWvXb/mJYWb3fYska9i2oxlS6peGm9JiSgs9+XoxFiIbosf7XuiUfxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG86yE6jOfQHeKU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCkaGt
 MiaT/f3YTdJ4BYqdDpLg06/gEk35qiq42lB5gZWic1j5zcyqVFEVPrzGonsdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVHmZkh+AsBOsTAbzsAG6ZvXAdJHAathZ5RlqPgqo
 DlFncTYpQ7EpcQgksxEO/VTO3gW0aGrZNYriJVw2CCe5xSuTpfi/xlhJGdpM44+oqF2OF5T5
 NYXKnMTUzOkl8vjldpXSsE07igiBMziPYdavW05iD+GVbApRpfMR6iM7thdtNsyrpoWTLCOO
 oxDMGIpM0yojx5nYz/7DLo3mPeuimPXeSAepV6IzUYyyzOOkVcsieG3YLI5fPSSdZlOjhqn9
 ljh5mn8Uz5Lc/2P2QWspyfEaujn2HmTtJgpPKS18+MvjFCNy2g7DhoQWl2m5/6jhSaDt8l3L
 kUV/m8psfF3+hPzCNb6WBK8rTiPuRt0t8dsLtDWITqlksL8izt1zEBdFGIbADD6nKfanQAX6
 2I=
IronPort-HdrOrdr: A9a23:dUxx3qBe2LVQZcXlHeld55DYdb4zR+YMi2TDGXoBLyC9Vvbo6/
 xG/c5rqCMc7Qx6ZJhOo6HkBEDtewK5yXcx2/hvAV7AZnidhILLFvAb0WKK+VSJcFydygce79
 YaT0EXMqySMbEQt7eC3ODXKadG/PC3tIqFv6Px9UtMcC1dQ51czm5Ce3imO3wzaw9cG5IjGZ
 aQouZBrSGxYGkaY62AakXtnNKtmzQIrv/biNI9ZiLPITPh7Q+V1A==
X-Talos-CUID: =?us-ascii?q?9a23=3AYMpYX2sYJLI/fMEAm8VBLcgw6IsDLXPe6i+XIna?=
 =?us-ascii?q?HFHdDR7/WV2Kz37NNxp8=3D?=
X-Talos-MUID: 9a23:9nX+cgp9m58ZIAKMgaAezylSaNx4v5v+MmcUnJBXlJjDFDxgBB7I2Q==
Received: from mail-ot1-f70.google.com ([209.85.210.70])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 21 Mar 2024 11:01:28 -0400
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6e6abcf283cso982366a34.3
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1711033287; x=1711638087; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CPfgDV7CmoJBIZdFSiycTcJgIoOfqzjWVfk/q03I8rU=;
 b=Q7g46hQ14lELNmcMUy7AYnOddEtcv5H9gIL//B6dPR3HCJhIpx3FzCErbHQxZkVAU3
 p/v/7av8RZn+jOw1u73nft00PfQuTtLTu1xf2ekkJX0/4B++4pkNT0wb/D8IQOIR7ACr
 5InSGFSbxb+6+C1TrXuXl/bI92HFJiKBsjV/WqKX76L9Fr2/haWgGIqpnq/GaX/p9mvF
 R7XovwR33M4ao2mfoFKzFxf4K4AWsZtcU3/6DZinpv2XM+nJ02qn2cUGT3rDHHsbBZMM
 UmtGST9TrE7wIX2XIvHOZnnGknzC5EIce4QK1BW07ol3FyIqgkrSCCWUxaufho97nFql
 2yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711033287; x=1711638087;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CPfgDV7CmoJBIZdFSiycTcJgIoOfqzjWVfk/q03I8rU=;
 b=Z6BBH8rMUI3SodFI/U31dO+epq2P5PgeWhLOVZAG71wzzJyJEIkaHkMI6Q63OFbQCw
 NsdS/amgn6pbeCYirHjlcW2pofLjQAajKhjx6KHkgyzXu5MR6ZWeIWmyvaIYlRo73MM2
 cHhmN4BoTTZ7DqAvNUHlZoR49l2JQZCynNnqBDC113lWf5UTdxOTXjcN7bVpkpgCn2xh
 Ks3ehcFwHLbZuyKm9jpaTw1c/JFDY6OF++42QbxjKtz8Oo2lDM7d0o1Yf4NJ8F2hRk2V
 28OCAtUJqu57bfWyzq2oNreTtdoXivRfPPMH1/HUP/7GSlG+IaVNfbe0bE47oEW4vMG/
 WI2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTq6lfetGKFpWO3rypYpS4KlptHPCvBv0+DSjPNYCuHIckwGpdC+0tf7R/tBMYlR/RIm4BMkPaHAhcH4XghuW9nZFdD5o=
X-Gm-Message-State: AOJu0YzrFOoyrLHow/l3hqND5/bKIpg6jWKEIzUhL5OA2ODIQmQJSUV8
 56i5oyy9NHwpqlZfPmNnZplcBDX97ugFw3BPpxoiiTHhm3tZ8ggasTnrB5tvuGukLCTJ1G330he
 eP+HqKlJSMDSB7LcMVaM1mhvW6Xa+wsRMzCAv88r7WLnBwczlDGUDtUHLqTQnevfcuA==
X-Received: by 2002:a05:6830:1250:b0:6e6:b209:b24c with SMTP id
 s16-20020a056830125000b006e6b209b24cmr1830518otp.17.1711033287145; 
 Thu, 21 Mar 2024 08:01:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHonyoBxb8AsMLJI7Foo72VvogWkucHlLZGwJ7kBy92xWTaOOtrGzFqmxkuRKg9/+Rg6fjLlw==
X-Received: by 2002:a05:6830:1250:b0:6e6:b209:b24c with SMTP id
 s16-20020a056830125000b006e6b209b24cmr1830476otp.17.1711033286636; 
 Thu, 21 Mar 2024 08:01:26 -0700 (PDT)
Received: from mozz.bu.edu (mozz.bu.edu. [128.197.127.33])
 by smtp.gmail.com with ESMTPSA id
 w12-20020a05620a148c00b00789f64ec397sm4598701qkj.97.2024.03.21.08.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 08:01:25 -0700 (PDT)
Date: Thu, 21 Mar 2024 11:01:22 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: xuanzhuo@linux.alibaba.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, kangjie.xu@linux.alibaba.com,
 qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, bsd@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, darren.kenny@oracle.com,
 Qiuhao.Li@outlook.com, si-wei.liu@oracle.com, yc-core@yandex-team.ru,
 Denis Plotnikov <den-plotnikov@yandex-team.ru>
Subject: Re: qemu fuzz crash in virtio_net_queue_reset()
Message-ID: <20240321150122.jcsw6djmeq6xu2yb@mozz.bu.edu>
References: <25d616db-6db5-47ed-afc7-8e285d069d8a@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d616db-6db5-47ed-afc7-8e285d069d8a@yandex-team.ru>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.137.79; envelope-from=alxndr@bu.edu;
 helo=esa6.hc2706-39.iphmx.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 240320 0024, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> From fuzzing I've got a fuzz-data, which produces the following crash:
> 
> qemu-fuzz-x86_64: ../hw/net/virtio-net.c:134: void flush_or_purge_queued_packets(NetClientState *): Assertion `!virtio_net_get_subqueue(nc)->async_tx.elem' failed.
> ==2172308== ERROR: libFuzzer: deadly signal
>     #0 0x5bd8c748b5a1 in __sanitizer_print_stack_trace (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x26f05a1) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
>     #1 0x5bd8c73fde38 in fuzzer::PrintStackTrace() (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x2662e38) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
>     #2 0x5bd8c73e38b3 in fuzzer::Fuzzer::CrashCallback() (/home/settlements/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x26488b3) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
>     #3 0x739eec84251f  (/lib/x86_64-linux-gnu/libc.so.6+0x4251f) (BuildId: c289da5071a3399de893d2af81d6a30c62646e1e)
>     #4 0x739eec8969fb in __pthread_kill_implementation nptl/./nptl/pthread_kill.c:43:17
>     #5 0x739eec8969fb in __pthread_kill_internal nptl/./nptl/pthread_kill.c:78:10
>     #6 0x739eec8969fb in pthread_kill nptl/./nptl/pthread_kill.c:89:10
>     #7 0x739eec842475 in gsignal signal/../sysdeps/posix/raise.c:26:13
>     #8 0x739eec8287f2 in abort stdlib/./stdlib/abort.c:79:7
>     #9 0x739eec82871a in __assert_fail_base assert/./assert/assert.c:92:3
>     #10 0x739eec839e95 in __assert_fail assert/./assert/assert.c:101:3
>     #11 0x5bd8c995d9e2 in flush_or_purge_queued_packets /home/vsementsov/work/src/qemu/yc7-fuzz/build/../hw/net/virtio-net.c:134:5
>     #12 0x5bd8c9918a5f in virtio_net_queue_reset /home/vsementsov/work/src/qemu/yc7-fuzz/build/../hw/net/virtio-net.c:563:5
>     #13 0x5bd8c9b724e5 in virtio_queue_reset /home/vsementsov/work/src/qemu/yc7-fuzz/build/../hw/virtio/virtio.c:2492:9
>     #14 0x5bd8c8bcfb7c in virtio_pci_common_write /home/vsementsov/work/src/qemu/yc7-fuzz/build/../hw/virtio/virtio-pci.c:1372:13
>     #15 0x5bd8c9e19cf3 in memory_region_write_accessor /home/vsementsov/work/src/qemu/yc7-fuzz/build/../softmmu/memory.c:492:5
>     #16 0x5bd8c9e19631 in access_with_adjusted_size /home/vsementsov/work/src/qemu/yc7-fuzz/build/../softmmu/memory.c:554:18
>     #17 0x5bd8c9e17f3c in memory_region_dispatch_write /home/vsementsov/work/src/qemu/yc7-fuzz/build/../softmmu/memory.c:1514:16
>     #18 0x5bd8c9ea3bbe in flatview_write_continue /home/vsementsov/work/src/qemu/yc7-fuzz/build/../softmmu/physmem.c:2825:23
>     #19 0x5bd8c9e91aab in flatview_write /home/vsementsov/work/src/qemu/yc7-fuzz/build/../softmmu/physmem.c:2867:12
>     #20 0x5bd8c9e91568 in address_space_write /home/vsementsov/work/src/qemu/yc7-fuzz/build/../softmmu/physmem.c:2963:18
>     #21 0x5bd8c74c8a90 in __wrap_qtest_writeq /home/vsementsov/work/src/qemu/yc7-fuzz/build/../tests/qtest/fuzz/qtest_wrappers.c:187:9
>     #22 0x5bd8c74dc4da in op_write /home/vsementsov/work/src/qemu/yc7-fuzz/build/../tests/qtest/fuzz/generic_fuzz.c:487:13
>     #23 0x5bd8c74d942e in generic_fuzz /home/vsementsov/work/src/qemu/yc7-fuzz/build/../tests/qtest/fuzz/generic_fuzz.c:714:17
>     #24 0x5bd8c74c016e in LLVMFuzzerTestOneInput /home/vsementsov/work/src/qemu/yc7-fuzz/build/../tests/qtest/fuzz/fuzz.c:152:5
>     #25 0x5bd8c73e4e43 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x2649e43) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
>     #26 0x5bd8c73cebbf in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x2633bbf) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
>     #27 0x5bd8c73d4916 in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x2639916) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
>     #28 0x5bd8c73fe732 in main (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x2663732) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
>     #29 0x739eec829d8f in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #30 0x739eec829e3f in __libc_start_main csu/../csu/libc-start.c:392:3
>     #31 0x5bd8c73c9484 in _start (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x262e484) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
> 
> 
> 

Hello Vladimir,
This looks like a similar crash.
https://gitlab.com/qemu-project/qemu/-/issues/1451

That issue has a qtest reproducer that does not require a fuzzer to
reproduce.

The fuzzer should run fine under gdb. e.g.
gdb ./qemu-fuzz-i386
r  --fuzz-target=generic-fuzz-virtio-net-pci-slirp ~/generic-fuzz-virtio-net-pci-slirp.crash-7707e14adea64d129be88faeb6ca57dab6118ec5

There are instructions in docs/devel/fuzzing.rst for building
reproducers from fuzzer inputs in section "Building Crash Reproducers",
however those instructions might not always work and the input might
require some further tweaks to ensure that DMA activity does not extend
past the physical memory limits of a normal qemu system.

Let me know if I can provide any other info
-Alex

> How to reproduce:
> ./configure --target-list=x86_64-softmmu --enable-debug --disable-docs --cc=clang --cxx=clang++ --enable-fuzzing --enable-sanitizers --enable-slirp
> make -j20 qemu-fuzz-x86_64
> ./build/qemu-fuzz-x86_64 --fuzz-target=generic-fuzz-virtio-net-pci-slirp ../generic-fuzz-virtio-net-pci-slirp.crash-7707e14adea64d129be88faeb6ca57dab6118ec5
> 
> 
> This ...crash-7707... file is attached.
> 
> git-bisect points to 7dc6be52f4ead25e7da8fb758900bdcb527996f7 "virtio-net: support queue reset" as a first bad commit. That's a commit which introduces virtio_net_queue_reset() function.
> 
> 
> I'm a newbie in qemu-fuzzing, and don't know virtio-net code, so I've no idea how to debug this thing further. I even don't know, how to get a normal coredump file to open it in gdb, it's not produced from fuzzing process...
> 
> 
> I tried to search for "async_tx.elem" in git log, and found two commits, fixing similar crashes:
> 
>   bc5add1dadcc140fef9af4fe215167e796cd1a58 "vhost-vdpa: fix assert !virtio_net_get_subqueue(nc)->async_tx.elem in virtio_net_reset"
> and
> 
>   5fe19fb81839ea42b592b409f725349cf3c73551 "net: use peer when purging queue in qemu_flush_or_purge_queue_packets()"
> 
> but I failed to get helping idea from them.
> 
> 
> 
> Could someone please help with this?
> 
> 
> -- 
> Best regards,
> Vladimir



