Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E63C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 18:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhCbz-00078Q-Gu; Mon, 04 Mar 2024 13:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhCbe-00073k-6G
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 13:00:09 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhCbb-0005Xd-C2
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 13:00:05 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56759dc7ea6so1543304a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 10:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709575200; x=1710180000; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AbER+RqTKoi+5I2EG7Rs1aQ1u7X7U8VnbldI9vxiMOg=;
 b=xuraTLSELiq2T1t3qpfUnpSKe2h7FIVS8dxiQIDkpiAE4bbw/3YXSHktPiYT1qy66k
 b+ABTf1cTrMkNrOI6Z1NRh1GEzuV4j/dpa28P+UkRAhDCzMIJ20MB1hIpJX1T/es3DEQ
 6fq8p747kzBZOPjwwJlAm+YgJNOSF8a4KKo6Lum9qsEj8wCHCS6UNeItIVUAr1XMGYhJ
 XCoN+tXXL6s+6BN+qjLm6cLh7rWB0PsztS6+Le0vO4aXkpedzhX69OifBHWR0RmQrady
 dP4x4q4SG1BEHKtRJ+mbemeeIoNov721wDZfE2jx16WKyq19RWQrI65/qK0xI+w9pAwZ
 OXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709575200; x=1710180000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AbER+RqTKoi+5I2EG7Rs1aQ1u7X7U8VnbldI9vxiMOg=;
 b=AeYNuO2yRq8zr38WJ0WsdziUR7JbfQHrqpTj1ARXb9BNIAQxsrEfyKsfao+3G9kTLq
 i+bc3lJ1B9Wa6MaClcT63SjQ6tkxAfima8Q4T/Fiwmv3Eit7ik1JQaZxyRt5YDwyoNdj
 SHbTun/6OANUzH109gGx7CM8gKXOqnHebZF0OW8Cg2WqhHzRY1AsFkoc8tYHKB4LxBLy
 9DI88Lx3cWgQRQAE7SuRqkUfdWgd/GAiz6L/37TWUazmsTgumnscltdMaNIbu+ogU1bU
 PsRNNmGeIZzbCAXfNn1h9UOiK762Xc/hmdPh3b1XaKiVNHf0xNkAmmm3QJxTppLrBZzP
 u6JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsbHnrJDXi9LQ5gApRvbHeAy1bu5J4EbFerpumrzYrBNx/Ue5nXBHza0TnlKbEjKpmNbE/lzhuQ+EcfAC0JFSz0fIAPLQ=
X-Gm-Message-State: AOJu0YyIU4awpoI19wvy0rdkXccnOp5gd6jnmKxkLtSjvOAr+Qwmx2+w
 IQWx/6zNyA6LbH3/0SefdQvhSeFZZqfr5UT7vYjwfvwpf+dvpvobMGFukGct1Ji6lkAhKI98TBl
 JF7rDEWRevsdQ0hYzcon6qz7UnEr6IsGn/X/MHw==
X-Google-Smtp-Source: AGHT+IHUsXXMULg0+3Kdu8ambwLixem2BO/XwKzDM7bA4yCl0t1SI18S78qO3EM3IOq58HfuAnT/6xXQ00GyiIT8Pgc=
X-Received: by 2002:a50:cb84:0:b0:566:51fa:3640 with SMTP id
 k4-20020a50cb84000000b0056651fa3640mr6573965edi.6.1709575199842; Mon, 04 Mar
 2024 09:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
 <20240303-elf2dmp-v1-5-bea6649fe3e6@daynix.com>
In-Reply-To: <20240303-elf2dmp-v1-5-bea6649fe3e6@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 17:59:48 +0000
Message-ID: <CAFEAcA8hQ4NEWZcqaC8ciBj101fzHnovTWPvXxFB8ShVAShvjw@mail.gmail.com>
Subject: Re: [PATCH 5/7] contrib/elf2dmp: Use rol64() to decode
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Sun, 3 Mar 2024 at 10:52, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> rol64() is roubust against too large shift values and fixes UBSan
> warnings.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

