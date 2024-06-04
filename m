Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DA1C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUSp-0002wj-Rr; Tue, 04 Jun 2024 09:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEUSn-0002qa-PK
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:44:33 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEUSk-0001NK-6x
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:44:33 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6f93d757f29so304352a34.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717508668; x=1718113468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mw8aBGHWa99UpGfMMfElA0JKWo2FyfpUf/m2xh8af6U=;
 b=sfj7CdcJAEUpX7YpBOtmbyaT7xlzfqb4BkVyj1cbJ0jGUWGhjOKY9DBaf4ePxb8t3o
 2+cKQsVzpzWBlj0PfGVlkEkmS7YPdAes1V3s5/VC6SSeDWyXNMJruCcozXYKQHYH4ucS
 lPF8QDjrKeu1rLlgnIK9qgAZVRZvV8aDYRoCfPXrUQJq0ayCXr1C0tFJ+NrCyJTfjMDv
 KUFUroRHhQxUGJkpFmtHB40/KJb7Gk8wo8XuPH6BUMxfc5fZbk2et3Fc5xntfjaoDkCr
 GTxCESHInB7hrnvdF4q+xGGSOR4vle5jLofeSoc3AtR4vT0KqvCyf6o+8AW8Xt0IjP2o
 a08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717508668; x=1718113468;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mw8aBGHWa99UpGfMMfElA0JKWo2FyfpUf/m2xh8af6U=;
 b=TpYMAKt8S9TmOjhHEnStkIc9FNR0NhRw/rotWkkZF+GxOtUdnPPyBpB9xNkmkpmP7Y
 tOdndeIGCC9NcAgvA9f9CqgiuFkZfr4su/miqEReS3otf7/i1glOzKpxzVVCHl7nTTbi
 5teOHZ0HFygR3055zV2vUFgE0b5k8dOlO41REE6YnAAE9XhJONosjIcIuUnieWzJYWpH
 zZcZheQ9QJwNaDnAfvBGIco1bwLmlAWb8D7399xgdPXwVcEyPNEHvmHW9rA5BhkHc+KF
 R/NlctZTThSnWZCss7/S0LGp4ohFDGXnRbHKb56ErtKmG5rawTw/sjkVegN+hH6g6G+p
 ezYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUccgn3V68hZFAOmDFf14ItcFzR1JVeSi5qqrxFDUWT2pFZgOWCZY9+4igPrQgv/+OWtXPF/N3V+DAFsJU6yeWXHbxv45c=
X-Gm-Message-State: AOJu0YyY2GbI9XvL9k9v2cQvC2NF+IBZ3jiNwt7YUNDlBCaf3Sx3Cv3X
 BCwXCFSGQIkcpamGPTUptVe1OSrgXwEW2XfYktx+isDFH0IhYXDW3pxGEGHXgXHQWjDDOWpkkx3
 i
X-Google-Smtp-Source: AGHT+IH/nuExecAf9B4pHWqL8wy7DUnRTut/zZdIfVIFOfKH49yFlZAPIREeb/ejEwnZaGa/w6/Qrg==
X-Received: by 2002:a05:6808:1585:b0:3d1:bff2:6525 with SMTP id
 5614622812f47-3d1e348422cmr14837713b6e.2.1717508667744; 
 Tue, 04 Jun 2024 06:44:27 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14?
 ([2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d1e1a461f4sm1809255b6e.37.2024.06.04.06.44.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 06:44:27 -0700 (PDT)
Message-ID: <fa80ab87-c079-4b18-b033-57bd6acc769b@linaro.org>
Date: Tue, 4 Jun 2024 08:28:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] target/i386: fix INHIBIT_IRQ/TF/RF handling for
 VMRUN
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240604071833.962574-1-pbonzini@redhat.com>
 <20240604071833.962574-8-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240604071833.962574-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/4/24 02:18, Paolo Bonzini wrote:
>  From vm entry to exit, VMRUN is handled as a single instruction.  It
> uses DISAS_NORETURN in order to avoid processing TF or RF before
> the first instruction executes in the guest.  However, the corresponding
> handling is missing in vmexit.  Add it, and at the same time reorganize
> the comments with quotes from the manual about the tasks performed
> by a #VMEXIT.
> 
> Another gen_eob() task that is missing in VMRUN is preparing the
> HF_INHIBIT_IRQ flag for the next instruction, in this case by loading
> it from the VMCB control state.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/sysemu/svm_helper.c | 46 +++++++++++++++++++++--------
>   target/i386/tcg/translate.c         |  5 ++++
>   2 files changed, 38 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

