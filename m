Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78351C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 17:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOL96-0003Ti-Et; Mon, 01 Jul 2024 13:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOL93-0003Qq-ES
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 13:48:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOL91-0002Nu-EE
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 13:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719856129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NzDbtnZrRe/jgNGoRzgJrpVHVeJsa6XR+2IR058eiXA=;
 b=UCRZtwzbIlaW3DECvi6uJbN33J5FkM0IkY4mFXD88l5bB+AiX57F1fRb3ktVAYOJopg6vn
 Ugr8StcioK5R7TyPdvLzAFxtYEt88i5UUVmAai0fLIVVt8Sovjt+6llKIPjOTgw7u9Erio
 0d8JZI56jZBYCKDmB7WcEPz++UfU9tA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-hSWdVbLaOfSGu8VApCk74w-1; Mon, 01 Jul 2024 13:48:47 -0400
X-MC-Unique: hSWdVbLaOfSGu8VApCk74w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-363edbfc61dso1700366f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 10:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719856126; x=1720460926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NzDbtnZrRe/jgNGoRzgJrpVHVeJsa6XR+2IR058eiXA=;
 b=KIwT+QtjVXyoJUyPODx8LnUJIPJoa6pYNhOXUPfUijE7wcZJvg8cHyVPOsSqZYyXIN
 sGPlih/RjRtPME613tIKMT2yohDwFtdAqUnOxp8F68wE47kXIEIfbnud8iocFApljsYr
 Z7ZoDWRkfKKVYzlVwlNWkyHG4ZeeDowq5BWI9qdd6TppOLS7EvD8o8kMuinHUxnaJDH6
 7d3if0uK2acgGZMx9wgma4bT3iD90Bj15XT5bg1+4oCJiJ4kk6DuoTgvSoc7K/bKqatp
 6LpUJR8S9YOaR0USSKsBy05cfAIgVqsESOqod+/MBsR2+g9K2STjQ+MJoxe/hHnrB4kb
 0h4Q==
X-Gm-Message-State: AOJu0YwY954nfLgfb9W2O0euNRV1ipzGQtY6KrX4BUwaUkoWStWwqjQi
 l4oW5MkKbUgIwY97NZmhgA9Y60999TwxG2p8tvhseuUjJWkSRhTek3Fe1IPEsJSCoUhTXwXziS5
 Nd4X+wdHHc5H8QocEv1qbQ8qoNYJn3A/xDcMKUbEfKYFgaEKOWTvBv1TDtkJTbht8odKG/OOz8/
 2/O9uzmCd26hzHRCZMu9bo8H4RvGU=
X-Received: by 2002:a5d:45c2:0:b0:360:9175:2c33 with SMTP id
 ffacd0b85a97d-367756a3b9bmr4403132f8f.8.1719856126738; 
 Mon, 01 Jul 2024 10:48:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDUsPcSAmK6Op0etzt9qp82L3CYi+9XR4iA5U6t1/92uBV58zSmUtCOkB9yOhia6Qvj4iNMEJwukczTW5ZJpo=
X-Received: by 2002:a5d:45c2:0:b0:360:9175:2c33 with SMTP id
 ffacd0b85a97d-367756a3b9bmr4403120f8f.8.1719856126354; Mon, 01 Jul 2024
 10:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240701025115.1265117-1-richard.henderson@linaro.org>
In-Reply-To: <20240701025115.1265117-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 1 Jul 2024 19:48:33 +0200
Message-ID: <CABgObfYq5Ti6UC7Os9nhyi5XU0VmLvT80rF2tZ4hR9A7cRHjBg@mail.gmail.com>
Subject: Re: [PATCH 0/5] target/i386: CCOp cleanups
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 1, 2024 at 4:51=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
> While debugging #2413, I spent quite a bit of time trying to work
> out if the CCOp value was incorrect.  I think the following is a
> worthwhile cleanup, isolating potential problems to asserts.

Hi Richard,

no objections at all to introducing more asserts. I think keeping the
array is a better underlying implementation for cc_op_live() however.

I'm also not very fond of mixing "sized" and "unsized" CCOps in the
4..7 range, there's no real reason why CC_OP_DYNAMIC and CC_OP_CLR
must be close to CC_OP_EFLAGS and the ADCOX CCOps.  I also think it's
clearer to keep CC_OP_POPCNT[BWLQ] (even though in practice only one
will be used because popcnt needs zero extension anyway).

As an aside, I'm wondering if CC_OP_CLR is particularly important; I
expect "xor reg, reg" to be followed by more ALU operations most of
the time and to not be followed by a jump, so it only saves a spill if
xor reg, reg is followed by a lot or store. If gen_XOR used either
CC_OP_LOGICn or CC_OP_EFLAGS for "xor reg, reg", the values in
decode->cc_op_* (CC_OP_DST=3D0 for CC_OP_LOGICn; CC_OP_SRC=3DCC_Z|CC_P for
CC_OP_EFLAGS) would be constant and wouldn't add to register pressure.

Paolo


