Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7CA606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M5QPAOJS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN8kO-0002YJ-77; Sat, 31 Oct 2026 09:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xN8kM-0002Y4-ET
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 09:03:46 -0400
Received: from mail-qk2-x01.google.com ([2607:f8b0:4864:34::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xN8kK-0006fU-VQ
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 09:03:46 -0400
Received: by mail-qk2-x01.google.com with SMTP id
 d75a77b69052e-534b7b19206so10861211cf.0
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 06:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793451824; cv=none;
 d=google.com; s=arc-20260327;
 b=YqZbo2FKgVEKQIDqi1U2bBiio+E/2N5m5G6pQUq25J+1bJcE7e8V1mDwvxJqi+C06Y
 /GJpqpNm38KDJeB/SBeySSd+e5q2RrXcZjGoHOG60DEu0g84BSuhZK1E+JDV8hwLV45J
 0LE9WSdVpcndzB0n1WtNZ8x615sj55mZGLk9sL+DZ115zWYAtLkM9I8C8wpzVnxtHoud
 RdxfHyrUqgrDgGyKdoBOQq9NZYUy6nwRW1zZnobFzjJq5Y8juJOqipOUkcH9esmHyVkq
 pTqN0IxjzSbmb7afNPz+imzn/u5MDqwv6NGLjy0SiYCdK81zQjOz4tZWSHHHr65RzFg1
 6j3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=81hA2BAJ0CH6xDTbL6IG5M7Re7R0iTUS3HxX916hbUE=;
 fh=xstARF0ZwselbUhOm666/USMzGlNtVenayhoulrajug=;
 b=P4PhDs9HRjTsu90AtQAsb8+Yggh3aJlHNJ1vJoBpcoC8hHjJ+DbOIna++GzC3Vb/aE
 WQnQ6a7Hxpdje8mCZkXKyoZQFr2KQBz0prSo5gVu84lz9uMlcowJ02wvT9pf2KvmRiYO
 eB6GqeWybKOaa8yD8aCogpdUYRKIPivQ3VQwMBp/sknmOU9vAmWJ4pmQ1QlqDSUiEZ3j
 ZZ3OnBxBLzyLwuzgdUJrTz8dI3OwCmLi+JT2kNsnYdBCSjHNxBHdKOiIs54Gm/BCX/To
 02mTb35rIbQ+eJkVCfhPlsR9W12jxrhKU9HLSwyhnEHtL7SvRSvXc8of7QHb0FFI8L4L
 EpMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793451824; x=1794056624; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=81hA2BAJ0CH6xDTbL6IG5M7Re7R0iTUS3HxX916hbUE=;
 b=M5QPAOJSeNbvAcsYDEr89vUIHYUKcoQDxWMO/BMvhSzU5QxXkeLuIMkeHVvbJxlccp
 EbY4cAvk1nFC+05bBMYWH7Xoti3rsPvjKuS2v+36PSEk3O4iRRuI4PTqziJLdMbguhwX
 7VtPRL/auvRl/RmIS63cGuKSqJTyoarrpgFUpsf7ITome1pXNhuJ+6q+K4nKSuGCJVoo
 Xtzg30vC29F24PXlIUMQvluzuJK/6TLtbh7dt6XcghTYhY4ZUVgNi18wYLhiBXwhbNGt
 Xvc7k2pE/k5ILkm7Lt7LtHwL34fOz7mTPym1iD7uvuYfOA8xaSNMuJMPGvoAlHKtnj8I
 j8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793451824; x=1794056624;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=81hA2BAJ0CH6xDTbL6IG5M7Re7R0iTUS3HxX916hbUE=;
 b=aNFfQxi+1PmkejTBEMJUA4fPtnmyPe9Tr9XKBavnUsZ61fXhMKpLhUWwfJpm1Rgl9s
 21S6aVaAKTkrt+q3yRSnrO8tksg/4fjZdZSgTVaZ2GSI/ozHzTefwHLiWWCii4fIlRAD
 +2emd+7QvUyrN353+U4Yps4qgOJLtrTtxQOq9nn2nBj7lntpERftNieEsTuhL3dC/f9f
 rDNqimXzsonYxA18wQGdO3LnwLME8tPkYQ5yUA9/3SjHWhxDUNt/O3bn4Xh72Sl3iuNl
 hc56EMQBezKx3TAOKklolrlaKLjoYHdoYs/DLuraemTqSchcS2pnfknXsv+wJLwnauTh
 y7vg==
X-Gm-Message-State: AFq9FYKLOv67d1M+63vywtrM8wImLchTKxLfV9gmNn/4o/J4/jigJjgu
 pfI7BkbxVBWq83+7NQ0JDx0Ugrq6uVkIP4MMR5AL/kSagNDEWHDcPSJVHCPmmFdTpCYkvONYp8d
 QFGwj2Ba4MrgsK6EBZXvMawUXE4pcC4I=
X-Gm-Gg: AYBFou06SUNmIj90UDM4RrSD0XsUdGbaTD2vDWretsW4rM/3bQlt1rjFghvjN8fOlUX
 y9dkD/prl4YbxfBqwHHooKahu7zHud590VmTlzBqBM+MWw5lCtV/oTczrhyz9OY7GecQcm4st+x
 SPx7qnYzUnfuP/G7VyZUm2npM2zjz/JwRwwi4m5iW4GZOWbeTCh4zb9IQv5vvLIAW9bbp3t/MN2
 XKanxCn/xyGIWCoy0Xe0KxxDn71Wmft1FeNlRjld8JagZSnmS3PQhKwv1VhSKCom6sJx4L8DQNF
 4W8I8aCPzIDyDjSwDGQtFesPs2ulcrWdLjmIT+RJ77fCENgskXDFNa9pyWRkNYw3HyyxvjHJdeu
 qIQtYV6pPdLtjHRyIa7uitHkScUL+nhMj5GZmlAFrm9Gr/ot1T0n8vvKxBH0/nrtBOOx4
X-Received: by 2002:a05:622a:342:b0:536:780e:8f42 with SMTP id
 d75a77b69052e-542b7046270mr86545681cf.33.1793451823677; Sat, 31 Oct 2026
 06:03:43 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CALU8FV9KC48FC2FGahqSh2uEqyedy-QZAgZ9qgap147d=Hr-+Q@mail.gmail.com>
 <1a022cad-2010-4b1a-bef7-ae9effe0b12b@linaro.org>
In-Reply-To: <1a022cad-2010-4b1a-bef7-ae9effe0b12b@linaro.org>
From: mdspan <mdspan.github@gmail.com>
Date: Sat, 31 Oct 2026 07:03:32 -0600
X-Gm-Features: AclHuK9J7vUYqRkaBCC0w3DmnY8uoTQ0kaSy7brGn3yGlrmWvrzhv94Pm8z8664
Message-ID: <CALU8FV9M7+Cm4m963Fx_-g+TGiZXVxe6mUiKkzax5f=Gn6Odsw@mail.gmail.com>
Subject: Re: [RFC] target/i386: design for TCG emulation of LAM
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, zhao1.liu@intel.com, 
 laurent@vivier.eu, deller@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:34::1;
 envelope-from=mdspan.github@gmail.com; helo=mail-qk2-x01.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 14:20, Richard Henderson wrote:
> In particular, arm requires the complete address, including tagging, to
> be available for any raised exception.  So clipping the address at any
> other place loses that information.  Dunno if that applies to LAM.

It doesn't for LAM. LAM masking applies before paging, so CR2 gets
the masked address (ISE 319433-048, section 6.5). The non-canonical
case riases #GP, which doesn't report an address.

One change would touch common code: tlb_flush_range_locked() compares
large_page_addr in all 64 bits, so INVLPG of the untagged address
misses a large page entered under a tagged alias. I'd compare under
the flush mask:

    if (((addr + len - 1) & d->large_page_mask & mask) =3D=3D
        (d->large_page_addr & mask)) {

If that's fine, I'll post the system-mode series.

On Wed, Oct 21, 2026 at 6:20=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/21/26 12:57, mdspan wrote:
> > Ping.
> >
> > Paolo, Richard: does masking in get_physical_address(), with TLB
> > entries kept per tag and INVLPG flushing all aliases through
> > tlb_flush_page_bits_by_mmuidx(), look acceptable to you? I have a
> > prototype of items 1 and 2 and can post it as an RFC series if that
> > would be easier to review.
>
> Yes, this is what we do in target/arm for top-byte-ignore.
>
> In particular, arm requires the complete address, including tagging, to
> be available for any raised exception.  So clipping the address at any
> other place loses that information.  Dunno if that applies to LAM.
>
> r~

