Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA79CC47422
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 03:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSTt0-0002S6-NZ; Tue, 23 Jan 2024 22:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rSTsx-0002Rs-89
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 22:25:07 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rSTsu-0003Uu-7Z
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 22:25:06 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6dd82bfa998so1120421b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 19:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706066703; x=1706671503;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fv6nX1nT6FHqqgih140bJQrhgI5kOzjdQ6P6m+RbG3A=;
 b=vnmUuHnSHRkeQzrx4CTsDn/Pf+rQYdIAZWa+rcjXuaU0l/RM3qOueJBDdPb1/erGf8
 ZtrxFdGZlOiClx/XO5T0OrmXqHAZwwnZlOAaXAYT8i7gebA1f7qAfqF35m5jwBsXxOdE
 IGz/utxFtGL3cZr5JZ+ADoigdbQwVDV1wGsyazc2S/ZE+oNJGbAkHPo9uzgctXcRkyDW
 DjWqCXDb/0FFiNVgjw1EBEBNigv/NrcJ0g2Vzk5ZT2x2bM38dsVrFzNnNfxD0uD8SdPj
 tgAJnqvgcQLVhz2Acl+1hiho91KB7ceH75csl+Tzs3gYlql9ri4YMlEk06BrIUvHIhqU
 8VPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706066703; x=1706671503;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fv6nX1nT6FHqqgih140bJQrhgI5kOzjdQ6P6m+RbG3A=;
 b=UJuGHJyCpnzm+oqeuMKKw+ZQaX8koYNnnVSPFlEORQ8MqiOSBWo48f2CV86BklDKnR
 6IR0U3AabaQamoD15O45XCH9EoLh03J94IafYUoM70ZrDvL56QikBoRSHikXCKmukroB
 xNh1EBaTI7ooP1JkvP1JFeuczvjdeLS0fWRR7dp7ADslYdmTyQPq/TPVP4flOJbvkmfo
 I8YH1TSp12f/cNqcXE7y9a1yDQFNi8kvHLwlv5N1fC87Eaw/mU7EKxhAt1jNE995VqTf
 i6BhEOD+zGF3+WbgN2pBUfvehkXvptLSUJ9bTX9PODxtJuHFB5C/8AQXdqUJlapxOxUw
 CECA==
X-Gm-Message-State: AOJu0Yza+y3bjcYETwGYPyFhL/uCxvQbUb4vx3gDNX2EUpN7xo4NMs4r
 0YdHkrR013A2ChfsF9wDgHbOtO/iJN8DupB8L4cG6Qa/BmI2TqdQJDF52+3xmos=
X-Google-Smtp-Source: AGHT+IGgFjt1sQZSE6dTD7MKQnqvztxdMOAI6fww3+x30v9cyvjOCy3fRAgfgZyLcAJzoDv0MCmBTA==
X-Received: by 2002:a05:6a20:938c:b0:19c:3264:ab1e with SMTP id
 x12-20020a056a20938c00b0019c3264ab1emr293878pzh.15.1706066702769; 
 Tue, 23 Jan 2024 19:25:02 -0800 (PST)
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 ls30-20020a056a00741e00b006dbe42b8f75sm4280182pfb.220.2024.01.23.19.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 19:25:02 -0800 (PST)
Message-ID: <a68637a0-8fea-4f09-ac05-1d3ac482f3ab@daynix.com>
Date: Wed, 24 Jan 2024 12:25:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/cutil: Allow relocatable install with prefix /
Content-Language: en-US
To: Bin Meng <bin.meng@windriver.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240123100640.1865139-1-bin.meng@windriver.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240123100640.1865139-1-bin.meng@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
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

On 2024/01/23 19:06, Bin Meng wrote:
> When configuring QEMU with --prefix=/, the generated QEMU executables
> can't be relocated to other directories. Add an additional test logic
> in starts_with_prefix() to handle this.

What about setting "" as CONFIG_PREFIX in Meson when --prefix=/ ?

CONFIG_PREFIX is expected not to have the ending slash. --prefix needs 
the ending slash for the root, but it is just a quirk of Meson, which is 
probably better to be handled in Meson, too.

Regards,
Akihiko Odaki

