Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9D9C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 20:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJIdb-0007PQ-6r; Mon, 17 Jun 2024 16:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJIdW-0007It-8C
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 16:07:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJIdU-0000Oe-J6
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 16:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718654847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GbEHh9hfPYjzaQ5aBtqbkED5sk2Jbnv71gxM1kiFPmw=;
 b=SPF2yqTw3hVEI7DnExnTjfVL9HhETyyzAxs18F3XHGn+E0+X2+uq7YN2oJ9MVemS4CePbG
 Ct4ShVj22+TI02lQ9xG9mHaOuayhUhVMk0nAroJx92DA0dHpsje6BlsEz3E2DfY9huC1UW
 XUcMuTZ5G8HskmX03xhCW2dVHOMIeIw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-YeF7lB2ON9iOl33R3Xuj6Q-1; Mon, 17 Jun 2024 16:07:25 -0400
X-MC-Unique: YeF7lB2ON9iOl33R3Xuj6Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-357766bb14fso2577375f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 13:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718654844; x=1719259644;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GbEHh9hfPYjzaQ5aBtqbkED5sk2Jbnv71gxM1kiFPmw=;
 b=iJBgTPqz8T8bMgpLLy3qUTqzCKzFZIGBpzL5ikzlRjnhXNvsWlx7cjbpRGNygH/iT4
 UUcI56N/EBdHMXSUOKMbbNxWbucAna/F/qIMr57zlSxlC7cYTxXoHsrq4kOoJLvhMx8i
 mma5t4dC9EciHa4DlvtyXMxZqTaLjyDH+UJIviPfUjpjannAx3OCgJBw0oMs3IE2OgUl
 Lm3t7hNWDkk8d7uJX1SN5mQH7sEp5iwctL6GD3uirASkgQS5WvFYUkU4cKaInfgD61Lm
 7R3qMCN4MmPUmWgwegOt43xPxQdceYLCsDLENHx6t4dDMB/zxKxbciKitmS8r93nBanc
 3Kkw==
X-Gm-Message-State: AOJu0YzFHRKinWkG8W52FUc8+bL4Z9jaAZmh4ZWY53oOqlwUZQf5//nj
 f1HEzH0owqKhBnPeuZIiGqy57NIhCDCPGyiuC7Ga7Cr8dzGI9pogtP+DocxQ0TOfSDoc9vQ3el3
 U2xV62FwxBAGZs6jdyYpoy/wXguKpmcGCXHOmRo9N/Vtu08I8poO8GOZpHqcbEIToyKbTRjyom1
 H3Tu6Ukvjmw3Ag5CX3/+jwhtVhY70=
X-Received: by 2002:a5d:6912:0:b0:360:9398:8b25 with SMTP id
 ffacd0b85a97d-36093988b9fmr3409505f8f.70.1718654844479; 
 Mon, 17 Jun 2024 13:07:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE341AxzqTcIIU+iMb2LCazwsNpif41445Kl2xeqD0DdZTEuBQseNGhO7vIAo9cxRgiiICXUykYykrx/tbPHq4=
X-Received: by 2002:a5d:6912:0:b0:360:9398:8b25 with SMTP id
 ffacd0b85a97d-36093988b9fmr3409497f8f.70.1718654844104; Mon, 17 Jun 2024
 13:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240617161210.4639-1-richard.henderson@linaro.org>
In-Reply-To: <20240617161210.4639-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 17 Jun 2024 22:07:09 +0200
Message-ID: <CABgObfbn4oss5G3ronS_tzLAP2S2oVp7ygo2GUWtVXko4i8Hbg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] target/i386: Reorg push/pop within seg_helper.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On Mon, Jun 17, 2024 at 6:12=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Hi Paolo,
>
> Thanks for offering to do the work to fix the memory access issues
> identified by Robert.
>
> Here is a code dump from this weekend that I noodled with -- it is
> prep work only, not intending to change any semantics, but it may
> be helpful in finishing the work.
>
> I considered adding a MemOp member to the structure, which would
> allow the push/pop subroutine to choose the correct access width,
> which would allow the callers to stop having 3 nearly identical
> code paths.  But I didn't quite get that far, and I don't yet
> know if that would really work out wrt long-mode.

Thanks, I had something working but your patch 3 is definitely
prettier so I'll just rebase on top of these three.

Paolo


