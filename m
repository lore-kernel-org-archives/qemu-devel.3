Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFABFD2B921
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 12:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8J2I-0005DR-UQ; Tue, 05 Nov 2024 07:51:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8J2H-0005CU-OF
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 07:51:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8J2G-0000dS-9J
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 07:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730811111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rz5i9SDTFWF1AWqjRBHvJduXNqcIM/lHLqGPKP0+5rg=;
 b=ihqfuEknePvlBpac9AU2N8SmEHPbGruJ6i5cVwhIWyNL8BJTKlthSCyqdtVwPDF8tVhNJp
 4SmalT2DKogu+ajnCru4+DdxQj2Ep6c7BOTErrVDcDujRQl7pYVAGkoUox1dqA0gXxXwKA
 y+2hnHBcE8A7F8Zb2Wga7S6yEhEZw+4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-AOYm80RZNE-d5pnVF0a0Lw-1; Tue, 05 Nov 2024 07:51:50 -0500
X-MC-Unique: AOYm80RZNE-d5pnVF0a0Lw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d95264eb4so2872599f8f.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 04:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730811109; x=1731415909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rz5i9SDTFWF1AWqjRBHvJduXNqcIM/lHLqGPKP0+5rg=;
 b=FiB723VZ3X5pUtK4Xg4LeXEuAQGbTHpnLYP8UDl+Ir4PKSGS63deigbZdV6m3mAPDm
 vIsyyuwKci5RGWy7BNQj77VkZcAK68OG/88gP4We1WApZ7COkxAv7A6YQ6mta/Vudg3j
 4kFygXFud0iWdxiykVRy3gZcOtpBzTaUMeTClq8EcYZO5iuHvluCBLzkz2KXSyJsDXwI
 qBjaw77s8LQbTG4CkQk2Mml84vC2zniIz5vjk6QJAe5eC23hNvPjAbQAT+u6ocFfB217
 3ZvKVDYDhwzTCPE8oWUi68er0i5suNr88m9F7WC7SVzDgvdRsWn/NV3RzFQFWwVrFoT/
 w2MA==
X-Gm-Message-State: AOJu0Yxat/+vsUWbwSnzXJQ447yjoTx5ixQwFf9WsV1SziwQi5gCVMlx
 vxmOvBf1HCHKdEcBZRkSIJItPY7la/Q3jHtZgzLmX5vgBiYMDKQ46OCBlU71czzpZrl/5FTnm3C
 TYujLpukecqV0At9E72eJbBC+XhO+swpVUNWjopEF3lUOnn35LnaZi4yBJz+ULCOUcnVg1sbeT6
 FlDKgt/ioA/GLogIG90uyU6aM/y50=
X-Received: by 2002:a05:6000:18ad:b0:381:d890:b554 with SMTP id
 ffacd0b85a97d-381d890b5c7mr6466059f8f.53.1730811108964; 
 Tue, 05 Nov 2024 04:51:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZm7rj5sjRtyA2zOeDfJBvOSezyNqjVvS357y8WFqrlzHzRgQnENZW5ezF0HRzGYjqBH/bi0cUN6Y5vXi+KM0=
X-Received: by 2002:a05:6000:18ad:b0:381:d890:b554 with SMTP id
 ffacd0b85a97d-381d890b5c7mr6466034f8f.53.1730811108579; Tue, 05 Nov 2024
 04:51:48 -0800 (PST)
MIME-Version: 1.0
References: <20241031175214.214455-1-pbonzini@redhat.com>
 <20241031175214.214455-24-pbonzini@redhat.com>
 <CAFEAcA_mJtsuqSOnDfBLuX+cTuAmDHksRhGA3jq=5tUS5RKn4A@mail.gmail.com>
In-Reply-To: <CAFEAcA_mJtsuqSOnDfBLuX+cTuAmDHksRhGA3jq=5tUS5RKn4A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 5 Nov 2024 13:51:35 +0100
Message-ID: <CABgObfbYzNMQDmEwYpXBgsUJ2V+br5QMHh4B9vWSdFxxg6wvNA@mail.gmail.com>
Subject: Re: [PULL 23/49] hw/core: Add Enclave Image Format (EIF) related
 helpers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
 Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Nov 5, 2024 at 12:44=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
> Hi; Coverity raises a couple of potential issues with the
> read_eif_file() function in this commit, which are both
> "Coverity assumes the file we're reading is untrusted and is
> unsure that we're correctly sanitizing data from it before use".
> Could somebody who understands the use case here check whether
> these need addressing?

Both are reasonable to fix, even if the use case would not make them
security sensitive. I'll prepare and send a patch.

Paolo

> CID 1564855 "overflowed integer argument" --
> basically eif_header.section_offsets[i] is from the data
> file and is a uint64_t, but we pass it to fseek() in
> read_eif_file. fseek() takes a signed offset, so if the
> section_offset in the file header is very large it will
> be unexpectedly treated as a negative number.
>
> CID 1564859 "untrusted value as argument" --
> in the "default" case for handling a section type
> we call g_malloc() with the uint64_t size from the header.
> If the file data is bogus we might try to allocate a
> huge amount of memory, which will cause g_malloc() to
> kill QEMU.
>
> thanks
> -- PMM
>


