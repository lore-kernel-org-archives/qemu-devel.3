Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEBDC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 01:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLuuG-0004jZ-AN; Mon, 24 Jun 2024 21:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLuuE-0004jA-Fg
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 21:23:34 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLuuC-0003vV-LE
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 21:23:34 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f9fb3ca81bso19370895ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 18:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719278611; x=1719883411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wIV8mJ8dC1ERy8ICi4jfpNZ2SdSbypDJloDbSX7Z+xg=;
 b=K82u10QxT/sdoMm0rP+M4lURywbFlm8N519beiin73o7KVgUyy7btwkwVSqfpuyzW+
 aCHi9prDH6wsOwCmK+Ujles/HE5iNwGM/MYlZWEKdpbDWxdvP/Xk/Xn12nnF3LA3RFxk
 Qx+GGD3bnJcdsdJ+eL4RYIS9Q4j4oIUhjS2BRkC59FrE905Kj0ZgG6UkYN25Bwr6bXq/
 nsBX6iAxbOS6lcI+5sgbYM5UvZraji2HPPSiw5lZolMocAF1gbmnL/lUBuNd0tBa8WOf
 AA+cuaLMtQX1XDvcZEuNTpFy+xeDLuvI189SMx3aMxXpJMXby56L9piS573Axg1X8AZh
 3mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719278611; x=1719883411;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wIV8mJ8dC1ERy8ICi4jfpNZ2SdSbypDJloDbSX7Z+xg=;
 b=jVGHpjC/p8EBaqaDScpscSkesuHb/Mfy3LtYsSIYtl0mr9/hllKzhVLPmp/SPI9lfg
 V1I4Jic2OSx9xlINGNCfd16nf08EsxKyC7nQOyYyaXou6RNYriMP2/Canm5qMQvjcH6x
 9Kng+2uXiQ08UTjwj6TNQXhmwUHMIzbXnydLYdUUzcfcf5pRio1Hb6N17lRzGSrZ5xxt
 g4Rmm9zBA1ZasmyS3FJZ5x01XnKYNgoYcChnczMmiEwsK1o3ldg1/g9j/EZi7SECc1oS
 yrPYeSMNEPmKFp7vz3RuZjIX4fkUM3keC/t/Y2+bu3sxHGaJUrytfmm2Zi3CU+XePkec
 DnIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvuGAujHd04M4Wy026BODkEKx1PCixWo1dPohzAdG6dubtReaU1KLfu+YvmY9yqrl/8/doFIAWhn2gPSB4arboXvdGJG0=
X-Gm-Message-State: AOJu0Yza5R52lDxhH6IIbFAbI+x3p2FBb/XzHt2UKlDUNErQ0lzuXtQN
 t876z5CGl9Ek1hDBaFCJJg8MuZBDWjFI04W9GdbP4pn5SRjzRRldL4pukrifC2M=
X-Google-Smtp-Source: AGHT+IH96PNFPshPRvE8lut4+ECReIz5kuoDBYIv+aQGKJSR1FtM5uPpZoDjqHqjQZodqHz3D5jmSQ==
X-Received: by 2002:a17:902:c40e:b0:1f6:e8ee:54a6 with SMTP id
 d9443c01a7336-1fa2413d097mr69446135ad.59.1719278610539; 
 Mon, 24 Jun 2024 18:23:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fa3ba68559sm27343245ad.274.2024.06.24.18.23.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 18:23:29 -0700 (PDT)
Message-ID: <d21eb8e0-0567-4922-9cce-3197c54c1bf0@linaro.org>
Date: Mon, 24 Jun 2024 18:23:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] maintainer updates (plugins, gdbstub)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240624101836.193761-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240624101836.193761-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 6/24/24 03:18, Alex Bennée wrote:
> The following changes since commit c9ba79baca7c673098361e3a687f72d458e0d18a:
> 
>    Merge tag 'pull-target-arm-20240622' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2024-06-22 09:56:49 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git  tags/pull-maintainer-june24-240624-1
> 
> for you to fetch changes up to fce3d48038e9f38e3e342a59f76c7f9f9b043ed2:
> 
>    accel/tcg: Avoid unnecessary call overhead from qemu_plugin_vcpu_mem_cb (2024-06-24 10:15:23 +0100)
> 
> ----------------------------------------------------------------
> maintainer updates (plugins, gdbstub):
> 
>    - add missing include guard comment to gdbstub.h
>    - move gdbstub enums into separate header
>    - move qtest_[get|set]_virtual_clock functions
>    - allow plugins to manipulate the virtual clock
>    - introduce an Instructions Per Second plugin
>    - fix inject_mem_cb rw mask tests
>    - allow qemu_plugin_vcpu_mem_cb to shortcut when no memory cbs

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


