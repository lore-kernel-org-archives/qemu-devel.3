Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2454EC87FD1
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0kk-0003rj-9n; Mon, 04 Aug 2025 15:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uizys-0004gU-2E
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:32:18 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uizyq-0007k0-8D
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:32:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-458aee6e86aso21349155e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754332334; x=1754937134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kIVHPeNREOasjblXv0MvtDf3SMmn6Uxj8YOOKExKakM=;
 b=tLeEhi2AJIHI4CTDA0XdLHqDMezj1inQ98023YmzPZr+uk68LO2GAXdT/Hq1jfCgOi
 6K9ZZiIxKSiJSI7RPyrFIkeDT6SvEMLdbFCQmmFRHBY+dAdqDQ+hNpFU5d7T1DtU8RB9
 pGQOFW7MgmkyCdc0zri6eDG88UZiRSnNj/baqabnSWagSLp7uoWyEuLfvC1ss7GQkrWk
 2yj2TemS+7nRv9jdkofLz+hQJ0aVerCQABn2vn3bPKhrMP+v0+1XsRybHWPuzFhKJ2pf
 32/PK9Zt/EDrdRgjsRvZLhjyKW6CoBqnQXei+Ws8FbxcNO8CQ+V+I/O+myC+L8BibrN3
 ctOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754332334; x=1754937134;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kIVHPeNREOasjblXv0MvtDf3SMmn6Uxj8YOOKExKakM=;
 b=VkBzzoyMCy5XaCUOv9iWYDTpiJT/6FE4Lo8drMG/KkLsJVrVMp9I81PbXPjN6OdSJv
 fMPWI1x+G9DZp16SkVZWOYuILnrILGCQqp7qx2t8D9u9FHJ5HR+nTlewe7T4VTLpNq8g
 iPBDaO5VPo2f24PVHsKuvuUGrklUzNBg8i3fHR1YTTAOT4FvVPDDg8uP02Aq2Q8wmzkp
 9t2cYgWtTrOuNMxpiGmoj13yA4VGu+ZNto6AhWKyk9Wzp8WkJrFV8BYv5zzwWco/+xxx
 k+07k//bh/pqkB2PHzCo17LGMh7obpyDzJPf/sIYdcTX1wBSaS96r3eSmaOhWQ7Osqmu
 I90A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV6S3tBaN6l0Gx2bTL/GwXuR8aVnTDYT1HQDx1uUygS/nGnAX0bsPtm9mFkhCYlaMnkxi7n1szmqLN@nongnu.org
X-Gm-Message-State: AOJu0YwitHZ7/F3iQT3DnPk3k9PHlo4Ld6fpckZRu3qnLGM2nfaxyE6t
 1ns9ZfSHt0bX6UWw9lUOyegLQaRTRrayv9Jo6SCmvlnsldvY9rWna3PoXTKgLZzQsac=
X-Gm-Gg: ASbGncvarGa52lxMe9ZCN4lry9xfTUDILceWRpyTNnL3aPBIkEiD0T0gvzbiIPCierH
 +OCk2tXu2SdovGR1uCa7S7R8494bI9QhpA4DBwv0m8EdRAW2AIk+0FuQCMm/jLMF4Wt9i0pXH8g
 c67YvCn0jANCL5MM7Ddtol9zLdSVEN4lqr+yWLX3nYmQZLf9V8Yj/DLSHcNXvjB1hwKkn9VzVy1
 7xSWTwb7kRUcvBQQEZLCFn5kYgMSD4sW88H7eH/PZNp8gFQU1pg/kizp9+zlfHLdhrcSplsI41u
 Bs3AgjBr/1t9uyDRJOjS+146hO+O7HpWy9cVYpHEysWERXlCyq2l9HHKVFs+Kw/TOKCz4wH6OM/
 idRdzotEXwpALkZxnLinsFgE=
X-Google-Smtp-Source: AGHT+IGb8nOLwmSu45vOb6T09NbPiCvpUWTlYP362mV0pcQvJMqWmCakY0T8CkAuLNaR+Qr6bWz9QA==
X-Received: by 2002:a05:600c:3109:b0:459:d3d0:6507 with SMTP id
 5b1f17b1804b1-459d3d06751mr48200625e9.32.1754332334239; 
 Mon, 04 Aug 2025 11:32:14 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee621adsm180820365e9.30.2025.08.04.11.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 11:32:13 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 41C4C5F76F;
 Mon, 04 Aug 2025 19:32:12 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>,  qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v4 1/2] target/arm: Increase MAX_PACKET_LENGTH for SME
 ZA remote gdb debugging
In-Reply-To: <CAFEAcA8o4wEHHDXVj0Fcc3i8g+49psY7YSf1AqGiGe9vNuXiQA@mail.gmail.com>
 (Peter Maydell's message of "Mon, 4 Aug 2025 17:49:09 +0100")
References: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
 <20250722201404.2368507-2-vacha.bhavsar@oss.qualcomm.com>
 <875xf36qyk.fsf@draig.linaro.org>
 <CAFEAcA8o4wEHHDXVj0Fcc3i8g+49psY7YSf1AqGiGe9vNuXiQA@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 04 Aug 2025 19:32:12 +0100
Message-ID: <87ikj3545v.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 4 Aug 2025 at 16:34, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com> writes:
>>
>> > This patch increases the value of the MAX_PACKET_LEGNTH to
>> > 131100 from 4096 to allow the GDBState.line_buf to be large enough
>> > to accommodate the full contents of the SME ZA storage when the
>> > vector length is maximal. This is in preparation for a related
>> > patch that allows SME register visibility through remote GDB
>> > debugging.
>> >
>> > Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
>> > ---
>> > Changes since v3:
>> > - this patch was not present in version 3
>> >
>> >  gdbstub/internals.h | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/gdbstub/internals.h b/gdbstub/internals.h
>> > index bf5a5c6302..b58a66c201 100644
>> > --- a/gdbstub/internals.h
>> > +++ b/gdbstub/internals.h
>> > @@ -11,7 +11,7 @@
>> >
>> >  #include "exec/cpu-common.h"
>> >
>> > -#define MAX_PACKET_LENGTH 4096
>> > +#define MAX_PACKET_LENGTH 131100
>>
>> This is a rather large expansion for something that ends up in a static =
at:
>>
>>     char line_buf[MAX_PACKET_LENGTH];
>>
>> I think maybe its time to get rid of this hardcoded define and make line=
_buf a
>> dynamically re-sizeable buffer along the lines of str_buf and mem_buf.
>> In fact make it a GString and we can get rid of line_buf_index as well.
>
> What exactly is the packet/response where MAX_PACKET_LENGTH is
> causing problems? The commit message doesn't say.

I assume it would be the g/G or p/P packets. The docs don't seem to say
anything about them splitting them across multiple packets.

> In general I thought the gdbstub protocol was supposed to handle a
> fixed packet length (e.g. in handle_query_xfer_features() the response
> packet indicates truncation via "l" vs "m" so the gdb end knows it needs
> to send another request to get the rest of the data). So if we run
> into something which seems to be fixed by raising MAX_PACKET_LENGTH
> I would first want to look at whether the underlying problem is
> that we're not indicating to gdb "this data is incomplete, you'll
> need to ask for more of it" or something of that nature.

The docs reference "bulk transfers":

  =E2=80=98PacketSize=3Dbytes=E2=80=99

      The remote stub can accept packets up to at least bytes in length.
      GDB will send packets up to this size for bulk transfers, and will
      never send larger packets. This is a limit on the data characters
      in the packet, not including the frame and checksum. There is no
      trailing NUL byte in a remote protocol packet; if the stub stores
      packets in a NUL-terminated format, it should allow an extra byte
      in its buffer for the NUL. If this stub feature is not supported,
      GDB guesses based on the size of the =E2=80=98g=E2=80=99 packet respo=
nse.


>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

