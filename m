Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058C6D74951
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 07:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t62k1-0003sc-4x; Wed, 30 Oct 2024 03:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t62jz-0003sT-Gv
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 03:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t62jx-00088P-ID
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 03:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730271813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q4j57kksS9xgjHSdzNfzKns2zXcKv1f5vhWKTmEsWtQ=;
 b=ccmmExoeaVcubNjRU9M9BlSZw8h8Fwrpjqrqz1SSVagieWeKKvrewQKz9ENZLNm6rPFZM7
 WQzo8iX5yeaRFDcS16w/gvcnfesRwn2JuD/Gu7qLx+8m9mD5tE2vQ1qe2dEibTOKdqzuaO
 xDBNOKs6dSfM/pUAvBTJA95ix90NnpA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-C1RguKAyOoeEcaEESObGyw-1; Wed, 30 Oct 2024 03:03:30 -0400
X-MC-Unique: C1RguKAyOoeEcaEESObGyw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d5116f0a6so3030308f8f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 00:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730271809; x=1730876609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q4j57kksS9xgjHSdzNfzKns2zXcKv1f5vhWKTmEsWtQ=;
 b=R3k99Bud3sv+qWa9lS8eeSgkd/RJtBxNFo+TeZosnbrYpps5DrnXnmma5ApZcEs4K1
 5Z01zng3epQxVBtvNeZI3kzx1b18nOkUx6BKScdyUIMi51v1YKHRLRlXTBY444VYsNVm
 Wgo992Ud9fj+6eRLNhPInFF/ZAoNp8cxE2sWtMdVw8rxHZJg1mVubKz0Afpo72WoFrkR
 lbXxvpmveinHIHtcMsGvilf0+ux0eEL8uLXezH0EhSBoN49VC/N4HFdhCrpEujOOHGMg
 EPRZtEXd2omB5U+4iKcyjzIZfhjY5vHvO2pS+KaYYl07gqCu9Luh+tb6xNDel6sT8TiC
 1hZA==
X-Gm-Message-State: AOJu0Yy4VifjxKNU4ExFEI9JJdfK+HNuC86Gx1Zc5/BIOdYxAzlb4vIO
 VU381zRn30ZDG64UcaJ9THVE5dvnXaMEiQKTlJEziHwclFCT+WCFWkBVsC+1JjJGIChq9eyzSu9
 G/A91janOMMSrswOqkqA2XXG9QDgYXSj8eCI8yf4D99yydnnve9+WhEXT0H9fq8YiF3xOvsIaBv
 RzQ5jBGTxN+6AYAsN9WN9QFcLQitY=
X-Received: by 2002:adf:f884:0:b0:37c:d1bc:2666 with SMTP id
 ffacd0b85a97d-380610f9e30mr10567096f8f.4.1730271809520; 
 Wed, 30 Oct 2024 00:03:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbA1VbNyTLXWuAlDagv49tGyik044NLENkgGf+LX/oWhNnTOuIYEYYj9Ef7Ffoh6YWqDo2jkZVBDi1WCjJnWM=
X-Received: by 2002:adf:f884:0:b0:37c:d1bc:2666 with SMTP id
 ffacd0b85a97d-380610f9e30mr10567076f8f.4.1730271809176; Wed, 30 Oct 2024
 00:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241008211727.49088-1-dorjoychy111@gmail.com>
 <5839222b-4d61-419b-80a2-cc7afb36abc9@amazon.com>
 <CAFfO_h5HquFuWQSo0n009dgi48Qoi_5MdRFuHOuHMGWNB2Q8+A@mail.gmail.com>
 <CAFfO_h4QCDc5qTP_U+-c0NTxPh5J53x876e5aVskMHx28OUerQ@mail.gmail.com>
 <54fe9ff2-ee5c-42dc-adb0-b4131a496a0a@redhat.com>
 <CAFfO_h7pFJUkm=BgJwyMYoVfj5GOb8oGivfcPfu9UrSix19_Ow@mail.gmail.com>
In-Reply-To: <CAFfO_h7pFJUkm=BgJwyMYoVfj5GOb8oGivfcPfu9UrSix19_Ow@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 30 Oct 2024 08:03:00 +0100
Message-ID: <CABgObfbftKsxNkQeW_zv+tyCATM+hDC3JrhLtFVH1H2144QWpw@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] AWS Nitro Enclave emulation support
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, Alexander Graf <graf@amazon.com>, 
 stefanha@redhat.com, slp@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com, 
 berrange@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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

On Tue, Oct 29, 2024 at 9:08=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmai=
l.com> wrote:
> Thanks for fixing. The attached patch looks great to me. I just have
> one suggestion. Now that the CONFIG_* symbols have the dependencies
> listed explicitly in the Kconfig files, maybe we don't need the
> explicit dependencies in the meson.build files? For example, the
> following line in hw/core/meson.build file:
> system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib,
> libcbor, gnutls])
> can be changed to:
> system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c')])
>
> I am not sure if zlib is a required dependency for QEMU, probably not
> needed to be listed above as well. I am just guessing.

No, because the dependencies are not automatically added to all
compiler and linker commands.  Having them in the "add" call lets the
compiler find include files and the linker add the dependency to the
executable.

As an aside,

  if foo.found()
    system_ss.add(files('x.c'))
  endif

can be written

  system_ss.add(when: foo, if_true: files('x.c'))

and "when:" supports multiple entries.  But in this case it's okay to
put it only in "if_true", since the dependency is handled in the
Kconfig files and guaranteed to be present.

Paolo


