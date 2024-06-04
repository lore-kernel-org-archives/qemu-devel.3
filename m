Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B270C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 14:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUsh-00051H-Dx; Tue, 04 Jun 2024 10:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEUsg-0004zd-Fx
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEUse-0003TG-W4
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717510276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hjv0ULnzk6a+MQc/vvUsxT8xWsDptnpgGJZNwRJl6yo=;
 b=X1eMVz2sV01I2x4tNnJc57hPrY1Lg0UnlNFnsKJcm1XdsywNHaPIPVSbAmnvs6/J0IrHTx
 QjlQfZ5uTNv+1Q+UD/0KElc0GGI1ZThvJZmySRxbv7xQll6KMlKeHDWoc6rSxhN01qUmAt
 SSsW7Ho+SRVwqsOMAQwXFTzfPpahfiA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-bYs5EE-gOB-kWPP7cGiXEA-1; Tue, 04 Jun 2024 10:11:14 -0400
X-MC-Unique: bYs5EE-gOB-kWPP7cGiXEA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-6c5b00ee620so3545968a12.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717510271; x=1718115071;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjv0ULnzk6a+MQc/vvUsxT8xWsDptnpgGJZNwRJl6yo=;
 b=PyKjyo1+W0T9rzMgaI7xFgJEM2smxAq5x9+iMbmQrC3UL1N6+t1Xazs7QHsnr7r5rF
 63bns/Sr7DUg8ZwkJX7PwL6whmGx0Pw8P4zKVbY7itc1wucCLX1AfTPU3wzBmCsKLZfQ
 DN3CnTrKNogP8RTDbYfDwp8YwXcWUqr9F8iqLi49Vo2QWc82U2VmLDJkQEGfht80lm7H
 CT+rDks5TXGLD3qrzXLsrEQpEXxg3QReujP/Q62MIQycPpmnwyo4WFMQTt4Caq2GW6ki
 i+2c6cQxQLL9ZUcF0oUNeZtMR0q2O5ZYAhI916zC69GHAAURT8rAVEeh5rfCLSRbSVFZ
 XE5Q==
X-Gm-Message-State: AOJu0YyZJATvT88zaOKekn6GPxq6wxjGGd/6QhhGodk7dXfciOdqAlhk
 RgEoGLXj1FieCeFd/8B0P/rugVqFC3PW1OzaKdSn4UzSe6cSHcCW/GQtLLtINFOKjpH9g7YxJQB
 sHbwpT+Xp3BzXM1iEDGDdEOWw7mpR+CMe1xzkQNMLSHUNJ4uPmHGBatVnViVvJcKt647i7D7G3S
 XINyNVXYYg46YZO4pE/laep0i5eyBGY6I0WhY=
X-Received: by 2002:a17:90a:f490:b0:2bd:ad66:5b14 with SMTP id
 98e67ed59e1d1-2c1dc58fd87mr12226473a91.25.1717510270777; 
 Tue, 04 Jun 2024 07:11:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsPE9VSXFb58K2JfYy5a0EJLfYPr2tEBeVaeFs/VeHK1eYPMoZ9B2r8WsT07ElReFc3u3AAXa2z5c86fXqktc=
X-Received: by 2002:a17:90a:f490:b0:2bd:ad66:5b14 with SMTP id
 98e67ed59e1d1-2c1dc58fd87mr12226453a91.25.1717510270400; Tue, 04 Jun 2024
 07:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240604071833.962574-1-pbonzini@redhat.com>
 <20240604071833.962574-9-pbonzini@redhat.com>
 <0dc2521f-7d7c-48c1-943e-b71566284450@linaro.org>
 <8855bd45-9b9c-485d-b737-2f23f0da6406@linaro.org>
In-Reply-To: <8855bd45-9b9c-485d-b737-2f23f0da6406@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Jun 2024 16:10:54 +0200
Message-ID: <CABgObfak+jqkr=wQvxfz9D9CHt3fgRzu4L5tcZbmOJabtEBTxg@mail.gmail.com>
Subject: Re: [PATCH 08/11] target/i386: fix INHIBIT_IRQ/TF/RF handling for
 PAUSE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jun 4, 2024 at 3:49=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> Oh, based on the next patch, it would appear that PAUSE does not single-s=
tep properly
> because it sets EXCP_INTERRUPT, and end-of-insn single-step depends on ex=
ception_index =3D=3D
> -1.  I'm thinking of the bottom of cpu_tb_exec().

I'm not sure we're talking of the same thing, but that's why I'm
calling helper_rechecking_single_step() before setting EXCP_INTERRUPT.

Paolo


