Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFADC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 19:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1sox-0003tI-7n; Tue, 30 Apr 2024 15:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s1sow-0003ss-AC
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s1sou-0000tk-AX
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714504035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJpNdPoW5AeokHjHTvmv36hOVXCG6XeRuiauWm9m//k=;
 b=SQfuis2/7KSAby+3ydgx6dyKacgWzbl9hHkIrUtLa5QvUMKZnBS7zPEOdwTDbeQXgX7b0x
 oDeVGlz8CjK4ZMM4MS+pi1oqS+6xjcBp2k1fNrG9j6+5wu4Jbtd4bnHVZDcwB1beT50JZF
 iMPSzwCTYyMAEGz13wskIpN9OJ2I+d0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-VK4oaWVCOdaZjOes6Qz-lA-1; Tue, 30 Apr 2024 15:07:11 -0400
X-MC-Unique: VK4oaWVCOdaZjOes6Qz-lA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-34d9b4d3a4fso475412f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 12:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714504030; x=1715108830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hJpNdPoW5AeokHjHTvmv36hOVXCG6XeRuiauWm9m//k=;
 b=Uyn5zqdN1lwt0pxI0ZQ9IcYXFo+tHh/bOz69eqPgleEn9ypUjDiZ+XFMwL0YglAvQr
 s27qs8xJ97whh4JL9lU79i0KKOV4afExBw7Mt/j1dPnqcvHB/mmqpDDKfNzsOvJQTPZB
 POKeOSFdNE3voLDetRU8w2FBDZdaBg4l2OWFmO+2gPAkNc8TXxaRGj6urCAb3arGyJTu
 kuySzMKHyDmIkwMN/vsOCi8JiDCjGEFLFK7R6E1RZ/jgyoMKg9b8CzE4pFhhJQpKY+DJ
 IfT71KpDMCDw5rfO0Kjx2WAM3FyYOx4iyZ2MWKwNZLdreimJrvLgcPXHgaML5azBEb5Y
 SvFg==
X-Gm-Message-State: AOJu0YyIH42/pmSvInyzbW9SsAXkbJmgE01ZovRw5ReTj5m4DLVWJq8B
 49n365gSTAP1crIUgPAWvpzfxSxzy2MKBrY9guXynVOLPzE9m+ng0AYP44d4DiDqcRz3EW/Apfa
 Whx/n4CC/C6gtGdaZaxqHSDe0cRU8BKfQk2fAqSh/EyzycFAbbGutmsjHMrMdX9HJP27u8tpkCq
 w+kya7iZ0S1c7BeyxV4XFN0K3qlSfIGXSPgas=
X-Received: by 2002:adf:ed4f:0:b0:34d:a59b:e074 with SMTP id
 u15-20020adfed4f000000b0034da59be074mr455383wro.8.1714504029944; 
 Tue, 30 Apr 2024 12:07:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUbUab3ivZvOKWDDCrnYj02bZyrIjF2ANzumhPduATkkzlyIxLUSiV6LVxZ1TKhMBe3tnciAAOyin/ZE7VaIk=
X-Received: by 2002:adf:ed4f:0:b0:34d:a59b:e074 with SMTP id
 u15-20020adfed4f000000b0034da59be074mr455372wro.8.1714504029539; Tue, 30 Apr
 2024 12:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240423150951.41600-1-pbonzini@redhat.com>
 <20240423150951.41600-56-pbonzini@redhat.com>
 <CAFEAcA9SFtGDu2Xhna3tEqnWcGbfNW-uxhQqdxoTq=SN56eh=A@mail.gmail.com>
In-Reply-To: <CAFEAcA9SFtGDu2Xhna3tEqnWcGbfNW-uxhQqdxoTq=SN56eh=A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Apr 2024 21:06:57 +0200
Message-ID: <CABgObfbfP=bmny=AOZS1L5v=UJnqf7KB+BAMCG9KhOoFN0z+Ug@mail.gmail.com>
Subject: Re: [PULL 55/63] kvm: handle KVM_EXIT_MEMORY_FAULT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Chao Peng <chao.p.peng@linux.intel.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Fri, Apr 26, 2024 at 3:40=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
> > +    addr =3D memory_region_get_ram_ptr(mr) + section.offset_within_reg=
ion;
> > +    rb =3D qemu_ram_block_from_host(addr, false, &offset);
>
> ...and this call to qemu_ram_block_from_host() will only initialize
> offset if it does not fail (i.e. doesn't return NULL)...
>
> I think this code should either handle the case where
> qemu_ram_block_from_host() fails, or, if it is impossible
> for it to fail in this situation, add an assert() and a
> comment about why we know it can't fail.

The assertion is in memory_region_get_ram_ptr(), but Coverity
understandably cannot see it.

Similar to other code in hw/virtio/virtio-balloon.c, this code is
using memory_region_get_ram_ptr() as a roundabout way to go from
MemoryRegion (in this case MemoryRegionSection) to RAMBlock.  The
right fix is to introduce memory_region_get_ram_block() and use it.

Paolo


