Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ACE606A32C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=s8qSuy3l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTKKw-0001cU-Cm; Tue, 17 Nov 2026 09:39:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTKKr-0001cC-9Y
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:39:01 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTKKo-0007il-5P
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:39:01 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-67dae7d3f7dso3182969d50.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 06:38:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794926336; cv=none;
 d=google.com; s=arc-20260327;
 b=ia8W1HDVlJGCU4NeSyM3iuUfhcasO4yg0jcPpi4/KTzCg22BKOwkV+aa4tx4ESBFFd
 OgeDhWt/NwC4bvl+L+WR0qGs49KDR14x7k9mqvwJvLS3buy6RRv22IqvsOPKTpQj+kv5
 nWv0dwVFPC0t/oSHin/oWt+A1emneATZ4tQqZlglniMkTXiWKjnOrh1/0mtbRtdXmflX
 AZSfpf00AiS8xciktAaZT5tqtBcVMhhzmr4wKVw7OVq7+3o8wQtCMVQjLutZowLQoPGF
 dHkW3yORDdbzr1SnGYZ1xmzqd7vyHFaqQwbpNdIVB/y/vO0+VNafTFm38kuCRLSLKgqC
 eeig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nO2p7HPx1YN5dDLm50DyikiEwYxAB3wGJDZQA8K8ZkQ=;
 fh=ftn4hCiY+2SqFLFO22/pQ9gAA+3OZWjlHh+aHV1jBao=;
 b=Qh4By5gOMArhdcFFDDR/QTB2Wn8RJVuwWzJx8I9HLclZABlY1kURzeoJLiWdv1owry
 7ZKo77/IOksnfFC2Y0gopPk1w46kj9r2fjyW/2hwZxe4SKR3E5mpwnagMPbAFPqjQCjV
 cjn9IpNDP7XS5fMGBuE8hTG52MMcVTxQ+2X2GSpx6/kuAZ3FsXSfi2EXSLY2PYM7/bfP
 IJucSU18ymHJybrV1RjMzf+XOosQSBygV54ZxCjRcxVAPupnYPBXspNZ+HGIJIX+OlqZ
 ABiF/6grhT9waJ0m6V0g0WC2/JyU6MQMd3EU6GVWiKOXtsGVffhLjRX1exWxT9MbdZ51
 pUdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794926336; x=1795531136; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nO2p7HPx1YN5dDLm50DyikiEwYxAB3wGJDZQA8K8ZkQ=;
 b=s8qSuy3lsYOwbvPtuydJSXS6wpxbU6Hv3cbykGpiE9Q7UAh81txBSOaaz+HkccVss7
 y1CTbNb6yvbtB5HHdRHqxdnhGtCh1fFyCj+rxEbZVRfu9YFMjBUM31TBjxHu3kM6/ulj
 RMvpf7CuH20+Q1Am69UpzBlCTH8Z88WHAH4Ayh8CNngjQPpZBn1G2Hsy7eIIp5Dna/wI
 H/ZSHmR9g77wWXf3hTZMQesdr8HXkWwm56qu/Uk4TxbVc3v7tLL42ovfaVqwgIz9BW6a
 MT0PjVp1NF9gvtOOBctvNjT60eRrUoCWjsO6MLRR+wedPH3gYgb42HTRzXGLAetFnKPw
 Ns5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794926336; x=1795531136;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nO2p7HPx1YN5dDLm50DyikiEwYxAB3wGJDZQA8K8ZkQ=;
 b=Gw9NX2Gc8WPsBBKCWQGD6/CN5lInhAHtK1HItHkcwgyKnlN5p8+xu5q8kO0xMwxwfy
 MebWPBhUGPCNtyohNbjb9ptTeUl4iJ80kSfC/afoZOa69lZ2eETtoE2qfU1fdyhx7P6L
 xUsCd41mSK5V3XuVWSP7kdfrh4iIUVbE9JXEIUzZjBAUuZAIdcaMOw9A2mb1UYvZdn73
 qbLH1MZheL1a1DGB1su4Znrt1INsZ4zd5aTYfCue6U4V/3NTOb02sVZ7FdDzxKbloRdo
 wPQkiC8Lcm+Z68pMuOuPX7A03Zo4/p2vDDSy4Dg68Hm48zCb/nbYqgZftlCpSS/NvHu6
 fQKg==
X-Gm-Message-State: APuU4Z/L0dY0aAygGWoudVTPqD2AjZB93Up8fA9AfWcArRCiafwZdXCe
 fmgg1ePrAT2k4C3PJ8g2dV95UtQUmfKZRkIf9r834Lc+lxoyIOrtgnof48BzmntpJYFtw5x3XoB
 k1Z5BnJL9qF36guec5Ch8jA1NWCrc8bpesKtotv1i4w==
X-Gm-Gg: AZFdTZe+lN6WuP1P0mUsOJtiLFq1aEoLoKkjV8PkdQtoE9zOJZYGY4VC5sDXG11Bwhb
 YNzsl+3vdf3VFhd8uYMaDbbe8yfdS3N+h28rol3FoXZMpK7hVZ6D/RxQ9LY17E5P4an+LFndrTm
 7LwMZHbwurcvIyroEp8C6dMQWLRj0BbeTXK9ETb0lo2od7JYolyLcBHx5IqMFkMudUUiPDo7MEZ
 F9YszlnB67btAw6H+Cuxh4Y5nVN0i2czorqbQ7MkPOXtMj8qRl1o7SuVKF8U9V6OdklmoTwKaYW
 1MGkeHaXBYMOkfdGmLPjObw7vFhR9dSQb3xrHHiYQgSagRXBNy1YaFligOGCohJl3RMAjmWra0w
 gMsaY27Y2ZLVj5PwZn6s3d15pWq15148QmwyE6EaENvA2S3bYso7UprhXsm3koPVNc72Dq8kx5u
 fikG/fi0TiYXEtD0E0niZd
X-Received: by 2002:a05:690e:1388:b0:67d:b559:9097 with SMTP id
 956f58d0204a3-67db559986emr2920916d50.105.1794926335783; Tue, 17 Nov 2026
 06:38:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260915203455.580999-1-den@openvz.org>
 <20260915203455.580999-3-den@openvz.org>
In-Reply-To: <20260915203455.580999-3-den@openvz.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Nov 2026 14:38:44 +0000
X-Gm-Features: AclHuK83RWfvWTUbx_jMRhN6Zp_5ycIwiIoL8HSdp7q8FTqhiufl8ZRrtnTbf5M
Message-ID: <CAFEAcA-Bc_Lev19s7=UjokZKjxTgDkZRYO-hbPMexj9BXqs2xQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] oslib: add qemu_debugger_attached()
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 15 Sept 2026 at 21:36, Denis V. Lunev <den@openvz.org> wrote:
>
> From: Denis V. Lunev <den@openvz.org>
>
> Code that watches for a hang has to tell a hang apart from a debugger
> stop, because under a debugger every thread stops and whatever liveness
> signal the watcher samples stops changing with them.
>
> Linux reports the tracer in /proc/self/status and Windows has
> IsDebuggerPresent(). Answer false elsewhere, which leaves the caller
> behaving as it did before the check.
>
> Match the Linux field at the start of a line. The Name: line holds
> fifteen characters of comm, enough to spell the field name and appear
> ahead of the real one.

Should we have a mechanism for the user to force this to
claim "no debugger present" ? You might want to debug the
watchdog mechanism itself, for instance, or maybe you're
running QEMU under something that looks like a debugger or
process tracer but which isn't going to do user-controlled
"stop for arbitrary time" (e.g. does the record-and-replay
tool "rr" appear as a tracer for these purposes?)

thanks
-- PMM

