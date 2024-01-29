Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0F8C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 10:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUP6T-0006Ir-OI; Mon, 29 Jan 2024 05:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUP6Q-00068K-85
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:42:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUP6N-0006Hk-Vw
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706524974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pgzS9bU17lbNxvB9ESVquzlxf1k4SIquYvMMtxs74aY=;
 b=gG0bBKqLN55gVtfkSJ0AID/YzzfcyP8Gspm/Zz/2SJw7pjojjUZY5L04E7KmHn7L3YvVOo
 PJ3ctBrsONv+IeV+ind36g4sONDNrsN0DaGz6rV+AJ2dJ75bwPPRFza0paQGdoR2Dz1DEL
 MmRKSwBrZ7aShiazJgNMIuJwZukQ4yw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-9reFVveJM1qUkcjCYh50yg-1; Mon, 29 Jan 2024 05:42:52 -0500
X-MC-Unique: 9reFVveJM1qUkcjCYh50yg-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5cfccde4a54so994454a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 02:42:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706524971; x=1707129771;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgzS9bU17lbNxvB9ESVquzlxf1k4SIquYvMMtxs74aY=;
 b=YsSy3ENyFNj1YSn0R4/b9saT/c77MNOTv40PzVmcts64OMzZu4zjy/LAtZV8oEqzeK
 juGlQPx4RENm9qDwEDAFImYnRZtqwUlpK2vJCoQQ3ydBxxNIxHlgk3KsiPbO41ECvLQf
 2v1+mW3NCPEu0zzJ3h1ZLRkDj/twe1xJ1/F5QcsgoffoC1eTwghFB6MKgUeLJcChOnDM
 h681nrQ7pwKNIiAqcid4tdxDKWXJ7gLhQlCjjf/GXePX2BViUqdCwZFELPN/x9H80hWH
 z6r7V3R8zM6tDqtsCvSndrnqFK1CBdpJZipIjnltiYdEbs+MUednuX9hokYyQUC5CLmX
 Kzow==
X-Gm-Message-State: AOJu0YwSdG+QZUPJqqg8Z4LfKi62FzvsnXSv7a5FH8ar+GSJME58ecQk
 jgTeek19V3Wlu53mlxLuAIqTACJEyOg1NDSX01/0DKBiRpJ+bhn+k5hcQ8mHUoPsbaurV1HRfbf
 QJHBl/1UJcaRr0FbuT6oy23VXE2j8C6xJ0W34OoJ70HkCQnOFCLkJQmTnRC0UUzY=
X-Received: by 2002:a17:90a:d157:b0:290:239b:8f8e with SMTP id
 t23-20020a17090ad15700b00290239b8f8emr6210546pjw.4.1706524970850; 
 Mon, 29 Jan 2024 02:42:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ3L3JtEQN49oRbatoeNN7MifzTAejPK9MdsBs+/p923n/DgVSUkzceTUgNSDBPs9yhoaGsw==
X-Received: by 2002:a17:90a:d157:b0:290:239b:8f8e with SMTP id
 t23-20020a17090ad15700b00290239b8f8emr6210535pjw.4.1706524970462; 
 Mon, 29 Jan 2024 02:42:50 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 q14-20020a17090a68ce00b00290b9694e81sm7851688pjj.1.2024.01.29.02.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 02:42:49 -0800 (PST)
Date: Mon, 29 Jan 2024 18:42:44 +0800
From: Peter Xu <peterx@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: farosas@suse.de, leobras@redhat.com, qemu-devel@nongnu.org,
 nanhai.zou@intel.com
Subject: Re: [PATCH v3 0/4] Live Migration Acceleration with IAA Compression
Message-ID: <ZbeBJEDlqX51dlBN@x1n>
References: <20240103112851.908082-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240103112851.908082-1-yuan1.liu@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 03, 2024 at 07:28:47PM +0800, Yuan Liu wrote:
> Hi,

Hi, Yuan,

I have a few comments and questions.  Many of them can be pure questions as
I don't know enough on these new technologies.

> 
> I am writing to submit a code change aimed at enhancing live migration
> acceleration by leveraging the compression capability of the Intel
> In-Memory Analytics Accelerator (IAA).
> 
> The implementation of the IAA (de)compression code is based on Intel Query
> Processing Library (QPL), an open-source software project designed for
> IAA high-level software programming. https://github.com/intel/qpl
> 
> In the last version, there was some discussion about whether to
> introduce a new compression algorithm for IAA. Because the compression
> algorithm of IAA hardware is based on deflate, and QPL already supports
> Zlib, so in this version, I implemented IAA as an accelerator for the
> Zlib compression method. However, due to some reasons, QPL is currently
> not compatible with the existing Zlib method that Zlib compressed data
> can be decompressed by QPl and vice versa.
> 
> I have some concerns about the existing Zlib compression
>   1. Will you consider supporting one channel to support multi-stream
>      compression? Of course, this may lead to a reduction in compression
>      ratio, but it will allow the hardware to process each stream 
>      concurrently. We can have each stream process multiple pages,
>      reducing the loss of compression ratio. For example, 128 pages are
>      divided into 16 streams for independent compression. I will provide
>      the a early performance data in the next version(v4).

I think Juan used to ask similar question: how much this can help if
multifd can already achieve some form of concurrency over the pages?
Couldn't the user specify more multifd channels if they want to grant more
cpu resource for comp/decomp purpose?

IOW, how many concurrent channels QPL can provide?  What is the suggested
concurrency channels there?

> 
>   2. Will you consider using QPL/IAA as an independent compression
>      algorithm instead of an accelerator? In this way, we can better
>      utilize hardware performance and some features, such as IAA's
>      canned mode, which can be dynamically generated by some statistics
>      of data. A huffman table to improve the compression ratio.

Maybe one more knob will work?  If it's not compatible with the deflate
algo maybe it should never be the default.  IOW, the accelerators may be
extended into this (based on what you already proposed):

  - auto ("qpl" first, "none" second; never "qpl-optimized")
  - none (old zlib)
  - qpl (qpl compatible)
  - qpl-optimized (qpl uncompatible)

Then "auto"/"none"/"qpl" will always be compatible, only the last doesn't,
user can select it explicit, but only on both sides of QEMU.

> 
> Test condition:
>   1. Host CPUs are based on Sapphire Rapids, and frequency locked to 3.4G
>   2. VM type, 16 vCPU and 64G memory
>   3. The Idle workload means no workload is running in the VM 
>   4. The Redis workload means YCSB workloadb + Redis Server are running
>      in the VM, about 20G or more memory will be used.
>   5. Source side migartion configuration commands
>      a. migrate_set_capability multifd on
>      b. migrate_set_parameter multifd-channels 2/4/8
>      c. migrate_set_parameter downtime-limit 300
>      d. migrate_set_parameter multifd-compression zlib
>      e. migrate_set_parameter multifd-compression-accel none/qpl
>      f. migrate_set_parameter max-bandwidth 100G
>   6. Desitination side migration configuration commands
>      a. migrate_set_capability multifd on
>      b. migrate_set_parameter multifd-channels 2/4/8
>      c. migrate_set_parameter multifd-compression zlib
>      d. migrate_set_parameter multifd-compression-accel none/qpl
>      e. migrate_set_parameter max-bandwidth 100G

How is zlib-level setup?  Default (1)?

Btw, it seems both zlib/zstd levels are not even working right now to be
configured.. probably overlooked in migrate_params_apply().

> 
> Early migration result, each result is the average of three tests
>  +--------+-------------+--------+--------+---------+----+-----+
>  |        | The number  |total   |downtime|network  |pages per |
>  |        | of channels |time(ms)|(ms)    |bandwidth|second    |
>  |        | and mode    |        |        |(mbps)   |          |
>  |        +-------------+-----------------+---------+----------+
>  |        | 2 chl, Zlib | 20647  | 22     | 195     | 137767   |
>  |        +-------------+--------+--------+---------+----------+
>  | Idle   | 2 chl, IAA  | 17022  | 36     | 286     | 460289   |
>  |workload+-------------+--------+--------+---------+----------+
>  |        | 4 chl, Zlib | 18835  | 29     | 241     | 299028   |
>  |        +-------------+--------+--------+---------+----------+
>  |        | 4 chl, IAA  | 16280  | 32     | 298     | 652456   |
>  |        +-------------+--------+--------+---------+----------+
>  |        | 8 chl, Zlib | 17379  | 32     | 275     | 470591   |
>  |        +-------------+--------+--------+---------+----------+
>  |        | 8 chl, IAA  | 15551  | 46     | 313     | 1315784  |

The number is slightly confusing to me.  If IAA can send 3x times more
pages per-second, shouldn't the total migration time 1/3 of the other if
the guest is idle?  But the total times seem to be pretty close no matter N
of channels. Maybe I missed something?

>  +--------+-------------+--------+--------+---------+----------+
> 
>  +--------+-------------+--------+--------+---------+----+-----+
>  |        | The number  |total   |downtime|network  |pages per |
>  |        | of channels |time(ms)|(ms)    |bandwidth|second    |
>  |        | and mode    |        |        |(mbps)   |          |
>  |        +-------------+-----------------+---------+----------+
>  |        | 2 chl, Zlib | 100% failure, timeout is 120s        |
>  |        +-------------+--------+--------+---------+----------+
>  | Redis  | 2 chl, IAA  | 62737  | 115    | 4547    | 387911   |
>  |workload+-------------+--------+--------+---------+----------+
>  |        | 4 chl, Zlib | 30% failure, timeout is 120s         |
>  |        +-------------+--------+--------+---------+----------+
>  |        | 4 chl, IAA  | 54645  | 177    | 5382    | 656865   |
>  |        +-------------+--------+--------+---------+----------+
>  |        | 8 chl, Zlib | 93488  | 74     | 1264    | 129486   |
>  |        +-------------+--------+--------+---------+----------+
>  |        | 8 chl, IAA  | 24367  | 303    | 6901    | 964380   |
>  +--------+-------------+--------+--------+---------+----------+

The redis results look much more preferred on using IAA comparing to the
idle tests.  Does it mean that IAA works less good with zero pages in
general (assuming that'll be the majority in idle test)?

From the manual, I see that IAA also supports encryption/decryption.  Would
it be able to accelerate TLS?

How should one consider IAA over QAT?  What is the major difference?  I see
that IAA requires IOMMU scalable mode, why?  Is it because the IAA HW is
something attached to the pcie bus (assume QAT the same)?

Thanks,

-- 
Peter Xu


