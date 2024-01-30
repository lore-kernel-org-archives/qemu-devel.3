Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2DBC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 20:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUuWC-0004Az-Ee; Tue, 30 Jan 2024 15:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rUuWA-0004Ap-Al
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 15:15:38 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rUuW7-0006Mu-0n
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 15:15:38 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-58e256505f7so2115183eaf.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 12:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706645731; x=1707250531; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=REUXrXnuJ7Xa2mxo3Z41o5PpH3dUV0+Zue19WtSRxzA=;
 b=faqd9fSKfJCHxSwGEDhjRw8J04Ciinu1pQQTteCXqsQoSPqcLKXdEz3B+NOudmkY/e
 Lyp6fGtzWKbU3dY8DfpgEIwGPxoBIbUWQhbKGD2YlXcnUj/YEWoZR4kScf2S68Lkzqqo
 tJT0uhrwy96gPAF39SVqyj9KMw/CnGIilrslBLK1Xnkow/mc8Cgz6C7gs30VHPuetNbi
 dm3qZHZNAViY+pLzyZYI4HlBX37VjPHZZpuiB7WsayLh+dZgU0Sg/7CzSqaYroZjGOQO
 TYnyDTp+HF2Rvxu1k0/Ntebk9q/htvjIahPfw0WRA5AiMNsLdH0GFKMcVpo/M8e1QUNZ
 E4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706645731; x=1707250531;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=REUXrXnuJ7Xa2mxo3Z41o5PpH3dUV0+Zue19WtSRxzA=;
 b=VbIk52EQ+xW/KzNJsy43SGrQDEtFDHH+hN1nsVMgNf5nShI1PbQKE8k2myDHy6gunA
 n5VQjC/U1Y3cshLrrj7w15BwMzSTdZJ8+9N9MbXj5WNMtGQKzs6Af3jejk/oYHZ/q/AY
 fhwvz1isVNsIJb9Trzeeuk1MshiZ7J3H8MRTQ7HsjthJmYFZs1jOQraNoYccqLQw93TW
 qtE1iTlNGY0A89c2JV3U29iHPpa/2XLi9BljYjFi/mYSzxA5wno2tCGoaECPoUMvdbic
 pnf21mfPBAX+dDm/70ty1nQMxn8V/TzrbRiaTjfsH8yn/VzMvpiONpjIng3DlAQzoTvM
 fpXw==
X-Gm-Message-State: AOJu0YyzdWzoMD0abUIhsCv69QMOOdl6jCnpHgqt7fF6zgp/ldZ296Ez
 GHTOCCWcOtuMhCTYc3C48Jt1AK/e80tUxF4fHIZWCticvYgai3LxJ68Cx6gWTOnWpJ610z4n0Gh
 OajkDdZ3XHV9tNzSfORegtvZW6uo=
X-Google-Smtp-Source: AGHT+IH8LiBNVjJpb9Td+TSmmyPlPnk6ONWUSG3n0mAvXHJFpzZBNLW/7ka32OOU0d30P16WzGF05Ovkf5jSZ89L8SA=
X-Received: by 2002:a4a:b819:0:b0:599:b548:e5f6 with SMTP id
 g25-20020a4ab819000000b00599b548e5f6mr6514558oop.4.1706645731236; Tue, 30 Jan
 2024 12:15:31 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QX9TQ-=PD7apOamXvGW29VwJPfVNN2X5BsFLFoP2g6USg@mail.gmail.com>
 <834f4e79-7495-42b3-b6b1-aa614c03d15e@csgraf.de>
In-Reply-To: <834f4e79-7495-42b3-b6b1-aa614c03d15e@csgraf.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 30 Jan 2024 15:15:18 -0500
Message-ID: <CAJSP0QUmBuToTt9_s0EG8uh+4Q5A=NmtcmRrkkrH5kjWD4=iqg@mail.gmail.com>
Subject: Re: Call for GSoC/Outreachy internship project ideas
To: Alexander Graf <agraf@csgraf.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Alberto Faria <afaria@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 German Maglione <gmaglione@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Richard W.M. Jones" <rjones@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, Song Gao <gaosong@loongson.cn>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Bernhard Beschow <shentey@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Sean Christopherson <seanjc@google.com>,
 Marc Zyngier <maz@kernel.org>, 
 "Koira, Eugene" <eugkoira@amazon.nl>, "Yap, William" <williyap@amazon.com>, 
 "Bean, J.D." <jdbean@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 30 Jan 2024 at 14:16, Alexander Graf <agraf@csgraf.de> wrote:
> === Implement -M nitro-enclave in QEMU  ===
>
> '''Summary:''' AWS EC2 provides the ability to create an isolated
> sibling VM context from within a VM. This project implements the machine
> model and input data format parsing needed to run these sibling VMs
> stand alone in QEMU.

Thanks, Alex. I have added this project to the wiki and added a few
links (e.g. EIF file format). Feel free to edit:

https://wiki.qemu.org/Google_Summer_of_Code_2024#Implement_-M_nitro-enclave_in_QEMU

Stefan

