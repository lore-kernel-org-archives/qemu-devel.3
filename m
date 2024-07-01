Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4906C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOGWH-0005Jn-8F; Mon, 01 Jul 2024 08:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOGWF-0005JJ-13
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:52:31 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOGWD-0004Iq-4F
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:52:30 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57d044aa5beso278248a12.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719838347; x=1720443147; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+LMafpKmFBDDikYX++w6UgFdZ8FIIUfn9QKSkngifKE=;
 b=mq035MXQ6nHMseK+g73kotblWz7rx037b+roGnaw8Fn2iv2O1YPV5EjSIWAtZcbl14
 OPVCjHa0wnmpHasrFAgptSrm6ids9u3RMwE10oYBodvO1qaTO/94eaHZXgbXcpzPCmsJ
 cugkgSgaMTiKOvUEVlejJFdNqysOapN1migUnXyIPRANQjMwUt4NARmQXWfJevZbzhxd
 LQBj6L8EeBH+zjuJ1abRxcsdd8rLinaVkNxbT1OH7aFsiS2Xpen3xZYLqW+qTBeYrFSn
 6sE6/n2wup9K7oVfFSonRWt8TGCIuXJwxcoX6eRXv4MbBl7TZEbSSZaSRQHNIfpJtZAu
 vbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719838347; x=1720443147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+LMafpKmFBDDikYX++w6UgFdZ8FIIUfn9QKSkngifKE=;
 b=P2sEFEKe64xYv8dBE3YJzOtLomMcUbbfP4I58A/kuxqkkNBXNx9WK+gxbcC89hAZ2B
 qJDB7JQKnT/FD2grBelJnd6TZg/O9YXwjhXaCokaabgICdl/EOXV+Ik9ejbyzT7b+put
 CUGhNDhngxfMSk1xUojadKNk0/+K+DxV46bIcU6jd5iTQ3GUW8I+nDwT1VvBVizL/weM
 2K9t2RBzGMfTuhHCeI+coGK+0NdrPjQlupKasK4kCRiqb33q0X+y1KRXaMOxvDgAsItK
 Yg9iBAQ4zzp0w40LP6Td9UL7ZAtD5VDO8lBGR/Js8IVmLqZ2QTrG1d0CYODgHxz3/heu
 b3RQ==
X-Gm-Message-State: AOJu0Yzj5IoW7CcnCONpsAVzeg4F6cURZo7ev0KXG/Do6vv31NS0pPYq
 Avb+/3+bDKBiTSFAyHvpFkyOf3gpH5N00M972HXz0vxnE2dDZRMJ2bs5sF1BlaY8bafpC2y6b/9
 w1huxmVYHy+CF+7evueJQ+r5DT6cNhF6pzqgMUg==
X-Google-Smtp-Source: AGHT+IGbB11Sj9qYuwOPF8ZCNsWROd4FZMF3oT8RwqR4d9RUvzB2XZu0dEufdTNwruWVs9XvEReblFLaCXBhooCVO0k=
X-Received: by 2002:a05:6402:190a:b0:57d:2db9:15e8 with SMTP id
 4fb4d7f45d1cf-587a0635e64mr3657718a12.34.1719838347131; Mon, 01 Jul 2024
 05:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1719690591.git.balaton@eik.bme.hu>
 <e3ffd0f6ef8845d0f7247c9b6ff33f7ee8b432cf.1719690591.git.balaton@eik.bme.hu>
In-Reply-To: <e3ffd0f6ef8845d0f7247c9b6ff33f7ee8b432cf.1719690591.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2024 13:52:16 +0100
Message-ID: <CAFEAcA-9W++mV4B2AUBN5O8ZazPYdO6BhCg7PpfKXbW=frzneg@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw: Move declaration of IRQState to header and add
 init function
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Sat, 29 Jun 2024 at 21:01, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> To allow embedding a qemu_irq in a struct move its definition to the
> header and add a function to init it in place without allocating it.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Yes, I think this makes sense, and I'm not quite sure
why we don't support it already (probably just historical
inertia -- the qemu_irq APIs were written before QOM
and when the whole design was oriented around an
"allocate and return a pointer" style rather than
allowing for embedding structs).

-- PMM

