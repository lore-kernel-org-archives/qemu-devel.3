Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40760C6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 19:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnO98-0007OG-0s; Thu, 21 Mar 2024 15:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1rnO96-0007Nx-Ls
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 15:32:12 -0400
Received: from esa9.hc2706-39.iphmx.com ([216.71.140.197])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1rnO94-0007g6-A3
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 15:32:12 -0400
X-CSE-ConnectionGUID: dyxg6QkzT860AStGqM59uw==
X-CSE-MsgGUID: skwT6XVGRFGEEUo9ojTP9A==
X-IronPort-RemoteIP: 209.85.214.200
X-IronPort-MID: 353180860
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:O6QsZKt3Mzy61cu/vN9tFoKb4ufnVOhcMUV32f8akzHdYApBsoF/q
 tZmKW2CP/uNMWOjf4t+bNvioRlQv57dztY1SwM4/Cw0FS1B9ZOVVN+UEBzMMnLJJKUvbq7GA
 +byyDXkBJppJpMJjk71atANlVEliOfQAOO6ULWcUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8teTb93uDgNyo4GlE5gdkPKgR1LPjvyJ94Kw3dPnZw0TQH9E88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IPM0SQqkEqSh8ai87XAMEhhXJ/0F1lqTzQJ
 OJl7vRcQS9xVkHFdX90vxNwSkmSNoUfkFPLzOTWXWV+ACQqflO1q8iCAn3aMqUU6/Z4X1hN5
 8BIdmgkVQysnsfrka+kH7wEasQLdKEHPasas3BkiCndVLMoG8ibBarN4tBc0XE7gcUm8fT2P
 ZJIL2oyKk6ZP1sVYg9/5JEWxY9EglH2dy1epEi9r7dx7mTOpOB0+OOwa4OFIozUHa25mG6Dp
 X36oVTHLSs0G/Gy9D3U9XCQvr7myHaTtIU6UefQGuRRqESew3FWBBAIWF+Tp/6/hUijHdVFJ
 CQpFjEGqKEz8AmzSoC4UUfg+DiLuRkTX9cWGOo/gO2Q9pfpD8+iLjBsZlZ8hBYO7qfamRRCO
 oe1ou7U
IronPort-HdrOrdr: A9a23:2qzZfKkMxvQeFU+3UMfRf4b/PmzpDfL43DAbv31ZSRFFG/Fw8P
 rDoB1773DJYVMqM03I9urvBEDtexLhHOdOkO4s1O6ZLWzbUQmTXeJfBPrZowEIcheWnoQx6U
 4KSdkdNDSfNykDse/KpCW+DtY80J2m3cmT9Jzj5kYodglxY+Vb4wB1Bh3eMkB7QxRHCpo0D/
 Onl656TuObCBIqhxKAdwA4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3ANSlMnGjxIMWILzy6OdVoRIV6QzJufmzNwynpIF2?=
 =?us-ascii?q?EWTgxYYaJZka1pfJ5jJ87?=
X-Talos-MUID: 9a23:8xzFzgSVN16oyE4IRXT3hy5eavdWzJ6AJ20grJJXvMu4DX1ZbmI=
Received: from mail-pl1-f200.google.com ([209.85.214.200])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 21 Mar 2024 15:32:07 -0400
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1dddb2b6892so9313615ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 12:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1711049527; x=1711654327; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OjTtaMKRylDdvhcao1W6gr7M7LjZXc1eVRcwK4i8FRg=;
 b=MA8iZHIRN6A3JcKKwMUpP9pgyC80zn+qwF76tiUyynjyv8F1ZGnBh8BOv7XE4siopG
 MEEn3j8cmSdy2/8zE/V1rlrTUu1rb2iEzh9ubpog7mVOwyRAElXG8OGtv1mwbO9GyQxo
 gZ/n+x/V2GGafJEXvP4tpkGgW7XWA6gsK/HgSC4RTkeXWkKt/hwjftPh+wlpZzPSZxNy
 txSJ5aRKBjnIahLxhUQHX8AWyUjZDAHRyV72KZj+yPZqX9hPnsP8ZsB8mKbgakSl8cKS
 1/1uJQ7RFQOy9zromJlADJskeOXeKEdOPXqc6lLAw0TM5XIn8XyGGZ3vaB1vfS6gTWNV
 YpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711049527; x=1711654327;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjTtaMKRylDdvhcao1W6gr7M7LjZXc1eVRcwK4i8FRg=;
 b=a3nFzoNc6qByss+JYkR/bG6iSUx8WwU8JemuclUlVch2GFJDD71NgCdtAiVqsC068v
 YyZrmTxP/Q8TlsWSI02tP98InGQZxdC5nuy/XVCqnK4CFZ68YXV1f27HFT6wWa6EJ4xi
 I+72Kixz1f1J/Rkxmqrevqia3ykUzs1wzKomq7+xOlK6LGBRJP90Uf8PWBYeDWi4f94R
 j05hneZNmjBCMD9Hi4H4RYHW4b7hibI1mCJLgPCoBJxEZCpnXunrFf1pf1rDqXSMdQv8
 cbxcCXtZpmHT2af0XFciBvG1LnI/geYCQWwsqsQjx1ZySQFw4YC4G31ZKvcLDMT4pVXP
 U8xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwt/C3vMig9EYVpsGDQdp9rzNKSMRZjogft5lVlW8voNkFvcI0yo4ZHhS4L4KgOXhhRxvkwGMa1/9bviTwaucfsh+Ykk8=
X-Gm-Message-State: AOJu0YyHzhfQrGqGKl0BRxT5NyVB6jR/SoU/VZ7VwRfH/sfQtSUxqKjd
 YpMzacIQ2aJ9QARGojV/NpXYFuT3LTIxA0VNZenixMDdsUiWBkMaDoFyMM0BSQpiiX7Pw9HvDYo
 zG7b7Hf9QAiRNYj9PBO1kEKjjMGy4VpAJDlirqLwj0iSirHGLgeo73FLRdQEc5oI5jIR63nqZTc
 Zs
X-Received: by 2002:a17:902:f542:b0:1de:fbc3:8e4a with SMTP id
 h2-20020a170902f54200b001defbc38e4amr423506plf.52.1711049526931; 
 Thu, 21 Mar 2024 12:32:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTPvT3+VYz3icE+3Ly/N5f1rHrxAeYDoTP1xN4XVPpUOPhSyhGWvBUwEqllSzB4Bism1OBjA==
X-Received: by 2002:a05:6358:78b:b0:17b:f10f:8849 with SMTP id
 n11-20020a056358078b00b0017bf10f8849mr354703rwj.11.1711049047382; 
 Thu, 21 Mar 2024 12:24:07 -0700 (PDT)
Received: from mozz.bu.edu (mozz.bu.edu. [128.197.127.33])
 by smtp.gmail.com with ESMTPSA id
 o11-20020ac8698b000000b0042ee243ca95sm169936qtq.50.2024.03.21.12.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 12:24:07 -0700 (PDT)
Date: Thu, 21 Mar 2024 15:24:03 -0400
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
Message-ID: <20240321192403.gogoyfulxaki3hpa@mozz.bu.edu>
References: <25d616db-6db5-47ed-afc7-8e285d069d8a@yandex-team.ru>
 <20240321150122.jcsw6djmeq6xu2yb@mozz.bu.edu>
 <b1deba9f-566c-4d77-ade5-f6dcf7ab3ff1@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1deba9f-566c-4d77-ade5-f6dcf7ab3ff1@yandex-team.ru>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.140.197; envelope-from=alxndr@bu.edu;
 helo=esa9.hc2706-39.iphmx.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, SPF_HELO_PASS=-0.001,
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

On 240321 2208, Vladimir Sementsov-Ogievskiy wrote:
> On 21.03.24 18:01, Alexander Bulekov wrote:
> > On 240320 0024, Vladimir Sementsov-Ogievskiy wrote:
> > > Hi all!
> > > 
> > >  From fuzzing I've got a fuzz-data, which produces the following crash:
> > > 
> > > qemu-fuzz-x86_64: ../hw/net/virtio-net.c:134: void flush_or_purge_queued_packets(NetClientState *): Assertion `!virtio_net_get_subqueue(nc)->async_tx.elem' failed.
> > > ==2172308== ERROR: libFuzzer: deadly signal
> > >      #0 0x5bd8c748b5a1 in __sanitizer_print_stack_trace (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x26f05a1) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
> > >      #1 0x5bd8c73fde38 in fuzzer::PrintStackTrace() (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x2662e38) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
> > >      #2 0x5bd8c73e38b3 in fuzzer::Fuzzer::CrashCallback() (/home/settlements/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x26488b3) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
> > >      #3 0x739eec84251f  (/lib/x86_64-linux-gnu/libc.so.6+0x4251f) (BuildId: c289da5071a3399de893d2af81d6a30c62646e1e)
> > >      #4 0x739eec8969fb in __pthread_kill_implementation nptl/./nptl/pthread_kill.c:43:17
> > >      #5 0x739eec8969fb in __pthread_kill_internal nptl/./nptl/pthread_kill.c:78:10
> > >      #6 0x739eec8969fb in pthread_kill nptl/./nptl/pthread_kill.c:89:10
> > >      #7 0x739eec842475 in gsignal signal/../sysdeps/posix/raise.c:26:13
> > >      #8 0x739eec8287f2 in abort stdlib/./stdlib/abort.c:79:7
> > >      #9 0x739eec82871a in __assert_fail_base assert/./assert/assert.c:92:3
> > >      #10 0x739eec839e95 in __assert_fail assert/./assert/assert.c:101:3
> > >      #11 0x5bd8c995d9e2 in flush_or_purge_queued_packets /home/vsementsov/work/src/qemu/yc7-fuzz/build/../hw/net/virtio-net.c:134:5
> > >      #12 0x5bd8c9918a5f in virtio_net_queue_reset /home/vsementsov/work/src/qemu/yc7-fuzz/build/../hw/net/virtio-net.c:563:5
> > >      #13 0x5bd8c9b724e5 in virtio_queue_reset /home/vsementsov/work/src/qemu/yc7-fuzz/build/../hw/virtio/virtio.c:2492:9
> > >      #14 0x5bd8c8bcfb7c in virtio_pci_common_write /home/vsementsov/work/src/qemu/yc7-fuzz/build/../hw/virtio/virtio-pci.c:1372:13
> > >      #15 0x5bd8c9e19cf3 in memory_region_write_accessor /home/vsementsov/work/src/qemu/yc7-fuzz/build/../softmmu/memory.c:492:5
> > >      #16 0x5bd8c9e19631 in access_with_adjusted_size /home/vsementsov/work/src/qemu/yc7-fuzz/build/../softmmu/memory.c:554:18
> > >      #17 0x5bd8c9e17f3c in memory_region_dispatch_write /home/vsementsov/work/src/qemu/yc7-fuzz/build/../softmmu/memory.c:1514:16
> > >      #18 0x5bd8c9ea3bbe in flatview_write_continue /home/vsementsov/work/src/qemu/yc7-fuzz/build/../softmmu/physmem.c:2825:23
> > >      #19 0x5bd8c9e91aab in flatview_write /home/vsementsov/work/src/qemu/yc7-fuzz/build/../softmmu/physmem.c:2867:12
> > >      #20 0x5bd8c9e91568 in address_space_write /home/vsementsov/work/src/qemu/yc7-fuzz/build/../softmmu/physmem.c:2963:18
> > >      #21 0x5bd8c74c8a90 in __wrap_qtest_writeq /home/vsementsov/work/src/qemu/yc7-fuzz/build/../tests/qtest/fuzz/qtest_wrappers.c:187:9
> > >      #22 0x5bd8c74dc4da in op_write /home/vsementsov/work/src/qemu/yc7-fuzz/build/../tests/qtest/fuzz/generic_fuzz.c:487:13
> > >      #23 0x5bd8c74d942e in generic_fuzz /home/vsementsov/work/src/qemu/yc7-fuzz/build/../tests/qtest/fuzz/generic_fuzz.c:714:17
> > >      #24 0x5bd8c74c016e in LLVMFuzzerTestOneInput /home/vsementsov/work/src/qemu/yc7-fuzz/build/../tests/qtest/fuzz/fuzz.c:152:5
> > >      #25 0x5bd8c73e4e43 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x2649e43) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
> > >      #26 0x5bd8c73cebbf in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x2633bbf) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
> > >      #27 0x5bd8c73d4916 in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x2639916) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
> > >      #28 0x5bd8c73fe732 in main (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x2663732) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
> > >      #29 0x739eec829d8f in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
> > >      #30 0x739eec829e3f in __libc_start_main csu/../csu/libc-start.c:392:3
> > >      #31 0x5bd8c73c9484 in _start (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x262e484) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
> > > 
> > > 
> > > 
> > 
> > Hello Vladimir,
> > This looks like a similar crash.
> > https://gitlab.com/qemu-project/qemu/-/issues/1451
> > 
> > That issue has a qtest reproducer that does not require a fuzzer to
> > reproduce.
> 
> Right, looks very similar, thanks! 1 year ago and still no news.. It's not encouraging.
> 
> > 
> > The fuzzer should run fine under gdb. e.g.
> > gdb ./qemu-fuzz-i386
> > r  --fuzz-target=generic-fuzz-virtio-net-pci-slirp ~/generic-fuzz-virtio-net-pci-slirp.crash-7707e14adea64d129be88faeb6ca57dab6118ec5
> > 
> 
> Yes, I tried this. But somehow when it crashes, qemu-fuzz just prints the backtrace and exists, I can't debug a crash in gdb as usual. But anyway, reproducer in gitlab is better point to start.

Ah that might be because of Address Sanitizer. It might help to set a
breakpoint on __asan::ReportGenericError per:
https://github.com/google/sanitizers/wiki/AddressSanitizerAndDebugger

-Alex

> 
> > There are instructions in docs/devel/fuzzing.rst for building
> > reproducers from fuzzer inputs in section "Building Crash Reproducers",
> > however those instructions might not always work and the input might
> > require some further tweaks to ensure that DMA activity does not extend
> > past the physical memory limits of a normal qemu system.
> > 
> > Let me know if I can provide any other info
> > -Alex
> > 
> > > How to reproduce:
> > > ./configure --target-list=x86_64-softmmu --enable-debug --disable-docs --cc=clang --cxx=clang++ --enable-fuzzing --enable-sanitizers --enable-slirp
> > > make -j20 qemu-fuzz-x86_64
> > > ./build/qemu-fuzz-x86_64 --fuzz-target=generic-fuzz-virtio-net-pci-slirp ../generic-fuzz-virtio-net-pci-slirp.crash-7707e14adea64d129be88faeb6ca57dab6118ec5
> > > 
> > > 
> > > This ...crash-7707... file is attached.
> > > 
> > > git-bisect points to 7dc6be52f4ead25e7da8fb758900bdcb527996f7 "virtio-net: support queue reset" as a first bad commit. That's a commit which introduces virtio_net_queue_reset() function.
> > > 
> > > 
> > > I'm a newbie in qemu-fuzzing, and don't know virtio-net code, so I've no idea how to debug this thing further. I even don't know, how to get a normal coredump file to open it in gdb, it's not produced from fuzzing process...
> > > 
> > > 
> > > I tried to search for "async_tx.elem" in git log, and found two commits, fixing similar crashes:
> > > 
> > >    bc5add1dadcc140fef9af4fe215167e796cd1a58 "vhost-vdpa: fix assert !virtio_net_get_subqueue(nc)->async_tx.elem in virtio_net_reset"
> > > and
> > > 
> > >    5fe19fb81839ea42b592b409f725349cf3c73551 "net: use peer when purging queue in qemu_flush_or_purge_queue_packets()"
> > > 
> > > but I failed to get helping idea from them.
> > > 
> > > 
> > > 
> > > Could someone please help with this?
> > > 
> > > 
> > > -- 
> > > Best regards,
> > > Vladimir
> > 
> > 
> 
> -- 
> Best regards,
> Vladimir
> 

