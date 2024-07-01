Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D74C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 19:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sON0M-0003gw-4b; Mon, 01 Jul 2024 15:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sON0J-0003gi-JY
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:47:59 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sON0H-0003pn-7i
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:47:58 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-424adaa6ceeso21482435e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 12:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719863274; x=1720468074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D9xZjbh34W8VeIbCWIb6xKE5KF/7biAnGtRGhPnlVWA=;
 b=k79sHY9Uu/HNyJCRbKHad2Gs1gEAfVzPNCWk9EsTmaWql69MSrXEAWIxZM4zYuzzw6
 UNn1lObH65RADYf2G7mx088O2fwfVToo5AXNKCcIkc8gWtIo4iUZT3Q7YBs9LyhTsGtq
 kWLsyArcG1wTm88pXND004nfZTSJL4/7ZguJ4rPpcTlwzSDuOJTCl3mi4QBBnzrtoedc
 N20EGusXc8Wocu95kdj+HXGrdD+Qx0uX/2Vx5CLt0DrZ+axnlsBXvZNn9eP9lrJ6SSzM
 iGe2pCVzb7GQYsvyHEbRAE0FSo+aO322vtbNL7TQ+vXh9b7V8oMqA3tfwg4d9JGIreH9
 uYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719863274; x=1720468074;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D9xZjbh34W8VeIbCWIb6xKE5KF/7biAnGtRGhPnlVWA=;
 b=EDU6wT3/d+wCyHQ8A2l1AdelmlIYPV4QwcTmrgRoSfu4xFrhdedgh0/xCS6elq7FVh
 +O5Ml0xiPANgIBwc/6O0afYAEnXBlN0gFoDnKyDllU1zfKk7vmDJGZBf4M5FIVC+0uVE
 INlHXZvb7no0d0Ib4VM+2E8siXAoiRkYs3VnVO9l0LbrxsJRvs5A82Od+7ArVxPri4mT
 dfyWw69hct9Gr8fRXt8M3j3empq/CcH8dagBuUFcCBClBnrsTVbwZQqfrLvegiJGOYvf
 2REi1aNWZqMn1bOQ32xLjqI9H7zEOGhQNo1LjYPaREh4n+fVrJwfvPqQxCJ7slEQdiUr
 BGlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtKbIeiTkypQT43zarpoWroBI5butPqtoUf5wdz0ssJ4AmTYLYTXQ+fdMoTbtleHyJIvG/zVRiOL3Svzqluxf+aoNBP+M=
X-Gm-Message-State: AOJu0YwSHLz5IIW0tHe6y6kz3EolEE1ehPF98f4zFet+bQ9a6rItfN9U
 GAiYyEvMLpiu6nVD+ZYPEWd0GM2VQQcW9TGJvdoqd/HKe6uYYfkhjTX/1GUin2U=
X-Google-Smtp-Source: AGHT+IFRzlX20gz+1JJThZGCa2ODHG3w2xSB0vlScz+BiaCRNfYMwL89BUomc1YbQoUJZGx2wnSOZg==
X-Received: by 2002:a05:600c:230d:b0:425:6510:d8ec with SMTP id
 5b1f17b1804b1-4257a02fcb3mr45215245e9.23.1719863274131; 
 Mon, 01 Jul 2024 12:47:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4258014f8b7sm71621655e9.41.2024.07.01.12.47.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 12:47:53 -0700 (PDT)
Message-ID: <c64583da-71a9-4a0c-8e0d-269899d1e116@linaro.org>
Date: Mon, 1 Jul 2024 21:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] system/vl.c: parse all -accel options
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, ajones@ventanamicro.com,
 Thomas Huth <thuth@redhat.com>
References: <20240701133038.1489043-1-dbarboza@ventanamicro.com>
 <20240701133038.1489043-3-dbarboza@ventanamicro.com>
 <5e0c57ef-d06d-4cdc-8d5b-3adec8263c5f@linaro.org>
 <CABgObfZzVN+CuCpYOpLqYERht_ipk4Xv_oydWi59WytyQtddsA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfZzVN+CuCpYOpLqYERht_ipk4Xv_oydWi59WytyQtddsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 1/7/24 18:43, Paolo Bonzini wrote:
> On Mon, Jul 1, 2024 at 4:34 PM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> In principle, a Reviewed-by tag is just stating that you don't know of
> any issues that would prevent the patch being included. However, as a
> frequent participant to the project, your Reviewed-by tag carries some
> weight and, to some extent, it is also a statement that you understand
> the area being modified.  A Reviewed-by from an experienced
> contributor may even imply that you could take the patch in one of
> your pull requests. (*) That makes it even more important to
> understand the area.
> 
> I would expect that anyone with an understanding of command line
> parsing would know 1) what -accel kvm -accel tcg does, and 2) what
> .merge_lists does; and this would be enough to flag an issue
> preventing the patch from being included.

I admit I haven't reviewed what .merge_lists does but went to look
at its use cases (I see 'git grep -wW merge_lists' in my history)
and mis-read:

util/keyval.c-370- * - lists are concatenated
util/keyval.c-371- *
util/keyval.c-372- * - dictionaries are merged recursively
util/keyval.c-373- *
util/keyval.c-374- * - for scalar values, @merged wins
util/keyval.c-375- *
util/keyval.c-376- * In case an error is reported, @dest may already 
have been modified.
util/keyval.c-377- *
util/keyval.c-378- * This function can be used to implement semantics 
analogous to QemuOpts's
util/keyval.c:379: * .merge_lists = true case, or to implement -set for 
options backed by QDicts.

which made me confident enough with the patch description:

  > and now it's safe to activate 'merge_lists' for 'qemu_accel_opts'.
  > This will merge all accel options in the same list

OTOH I wasn't clear about the first patch and knew this one depends
on it, so if the first is wrong, this one is automatically discarded.

> To be clear, I don't expect reviews to be perfect. But in this case
> I'm speaking up because the patch is literally a one line declarative
> change, and the only way to say "I've reviewed it" is by understanding
> the deeper effects of that line.

Don't blame the review but the reviewer :) Reviews aim to be
perfect, unfortunately the human beings sending them aren't
(at least I am not, as I just proved).

Thankfully maintainers are gatekeepers on their areas and can
catch issues like that. I duly noted "my Reviewed-by tag carries
some weigh" and could confuse other maintainers, and will think
it twice before posting it on topics I'm unsure. Thanks for
taking the time to warn me.

Regards,

Phil.

> Also, I think it's fair that the submitter didn't spot the problem;
> it's okay to send out broken patches, that's part of the learning
> experience. :)
> 
> Paolo
> 
> (*) as opposed to Acked-by, where your review probably has been more
> conceptual than technical, and that you don't really want to take the
> patch in a pull request.




