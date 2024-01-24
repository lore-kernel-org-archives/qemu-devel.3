Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F5EC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 15:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSfRK-00007P-Ts; Wed, 24 Jan 2024 10:45:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSfRC-0008VF-FJ
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 10:45:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSfRA-0000wN-Ob
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 10:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706111111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m7QSduLCD9UZmx8953/h3p9B588CwdshGsfplZH7YIs=;
 b=CYfoRv0A10wG/HHXUtbqHoZAn0frpZ9+/TZz2fFIGTtlsDtishKNoLy+XmbINCp2bCQHrF
 6GNHia5cKfMmjo/XBZwEAmxXn0W5KOp2nMsswZuzLJhKS10aOHeTt200IcsszjhfHvGD8r
 4mdwSpCYtaKY/WF7fSwv5CrWnX9ZJjQ=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-lTtQEggBOG2X3DSvQmsSUA-1; Wed, 24 Jan 2024 10:45:09 -0500
X-MC-Unique: lTtQEggBOG2X3DSvQmsSUA-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7d2df8a3e4dso1928838241.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 07:45:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706111109; x=1706715909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m7QSduLCD9UZmx8953/h3p9B588CwdshGsfplZH7YIs=;
 b=kACL4Mr1F3McdR/Z1nHYYA3NcQDo7KgzcqkqOIl07agWFMgyx+rw64Cfb7ejDtq+1c
 9AxuDoAfcKVaLkrsWvciN5S97ELZbTu969dlIbitGiSvCHZ7LWttNgoGpED8TQ6Hf2LF
 db0aVzE5/aIPg6y9NnbfyKk2vCVGiIM9frlM9bhmplfuhwQO6kskT4lO9Jb5so92xGZh
 sEN2Ry2fgqMCfBTIzIkiNxqIMfjRO11X1eWFXyH6zIn88P8BkC97q3/TgV9IR8eX/E7T
 L1DywCuw0JAKWKfUVRympgjMzuO5JFCjLCWiqp5skIXdI91UyYdiwoJumsL4rbCcqUib
 clow==
X-Gm-Message-State: AOJu0YyKLrXnaRGU8oUS4dUS58Uk+l8PL9SJvQCFHNTwSyY4nkgsRmPQ
 cieEtqh8EhrpqsAUSF12P7yLAXzmWOkRVvNploAomQco+ABZEPW50d+9yNgpTDItn8hmteeC1D9
 pZFREm54n7rXqS6rVDCX0NvHQonGVU1IBmRmVoQZG/dLFE0s53ysbPNVrmDzV0y7ACOK0yy6W65
 crtkx0vz/9iKCWkhDYAOXHTyzdvks=
X-Received: by 2002:a67:f4ca:0:b0:468:ca4:2aab with SMTP id
 s10-20020a67f4ca000000b004680ca42aabmr4519712vsn.14.1706111108917; 
 Wed, 24 Jan 2024 07:45:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLRoheWULT/N4zwyWPVSosqSEy8Vfth0+/DxI2aAgElbuadX1hGZW3zmf3fVKV9XrBsUAzh9zi4I4buOUMlGM=
X-Received: by 2002:a67:f4ca:0:b0:468:ca4:2aab with SMTP id
 s10-20020a67f4ca000000b004680ca42aabmr4519705vsn.14.1706111108587; Wed, 24
 Jan 2024 07:45:08 -0800 (PST)
MIME-Version: 1.0
References: <20240122153409.351959-1-pbonzini@redhat.com>
 <87ede77lp8.fsf@draig.linaro.org>
In-Reply-To: <87ede77lp8.fsf@draig.linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 24 Jan 2024 16:44:56 +0100
Message-ID: <CABgObfZ+9wDOpdTw6WuD=mRcpxpSu4mPwmkzym87qYBdUgvtOw@mail.gmail.com>
Subject: Re: [PATCH v2] cpu-exec: simplify jump cache management
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
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

On Tue, Jan 23, 2024 at 11:02=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
> However I would note that TranslationBlock has the comment:
>
>      * jmp_lock also protects the CF_INVALID cflag; a jump must not be ch=
ained
>      * to a destination TB that has CF_INVALID set.
>
> which I don't think holds true.

It does, both

    /* make sure the destination TB is valid */
    if (tb_next->cflags & CF_INVALID) {
        goto out_unlock_next;
    }

and

    qatomic_set(&tb->cflags, tb->cflags | CF_INVALID);

are protected by jmp_lock.  And if something is chaining to a
CF_INVALID translation block before tb_phys_invalidate() sets the
flag, it is cleaned up by

    tb_remove_from_jmp_list(tb, 0);
    tb_remove_from_jmp_list(tb, 1);
    tb_jmp_unlink(tb);

before tb_phys_invalidate() returns.

Paolo


