Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAB8606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vxv0u64L;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ij15nCFw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlWm-00042v-Lv; Tue, 27 Oct 2026 14:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xLlWl-00042g-Rs
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xLlWj-0002RU-Gq
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793124238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahlQyaQG+Zpn+OKorM+DHXta4ggVksdpC/pIMQdAHXo=;
 b=Vxv0u64LdkPwJWuAVcjna8XdxOjtJdbr7HM/tuRncY6k2OSdrQXhSGqhPZBsZ79vZnYZF+
 7HqoqvBNHvwhHptEWo30ziq3yNyfi8iSjVvaYoDKdDFts00+oau9u1VzmI2aBoA21vB8I+
 E5BfA31ZL1AAlqjZUJQOpQ0FH0Jh3vY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-Cinq9GSzPee0slFENd2LcA-1; Tue, 27 Oct 2026 14:03:57 -0400
X-MC-Unique: Cinq9GSzPee0slFENd2LcA-1
X-Mimecast-MFC-AGG-ID: Cinq9GSzPee0slFENd2LcA_1793124236
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48b00febba3so66699f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 11:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793124236; cv=none;
 d=google.com; s=arc-20260327;
 b=cFp3ow2zt20UPEdRysrnTQpD1U5hszRr3THnUg2PzToRt7FmROPrs4K+wisQZvhWgD
 F2AWIA/2FFkhV2IUI6BJ5uzlYrZiUcK0laqBkjhXNVnk27dpgj7h+o8Sq8GwHnS4UCGz
 Etk6jxHqafjMjAVIZRu2nOAgFI8oXClAxCu79+p8h+gUKpiqJR+WvmUa/lrMf9wcuKK1
 CBhpxwunbeP3V5z9h7BGbqWQBi3hnW4PSu7LWqLcUrG08cFs9Lf5RaAoWbzrjXGHjVa1
 jFX0Uyetwe1OjU/s5R922stqYQSol0nQwBE09z6kDmgur1LaOJh4Uyaz1vZWSXKtbRt5
 mZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ahlQyaQG+Zpn+OKorM+DHXta4ggVksdpC/pIMQdAHXo=;
 fh=ZfBJxjf2ccPHY+LbDhVlckDEAQhXh3eoaNlicB+nr2A=;
 b=fkMEsNr2e7JZlKn00rcy+45XvdJ1pdnvTalKw4y7A85guUFR6Ma4iuD1ZOfLyuqRLX
 9QdeyKQfHXAT7kBP0iD3Qlt0sSGphZ3qh6gxvHBe1ap2hWs9VFP9WJAEwbY04yA9UJJL
 e+90gfa9JDFGy/TghhmqnEJSGR67cpJ5RSzTBUKMrRqoWnFhOqFsMUh8yrojGWoaQCCS
 fnt1cqIhHbYNkUx//6dhkcTjxihhZF0Qk8gwqWe46ZE9KJmYwUK4SKUOTRArw6UDRw79
 lpb7VB8ip8z8mo1p1nwqKjGytsEUMwdWzNVfgzYOooMKerbdwRHMpSnePIuUbIotGWlr
 4J4A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793124236; x=1793729036; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ahlQyaQG+Zpn+OKorM+DHXta4ggVksdpC/pIMQdAHXo=;
 b=Ij15nCFw8EObM7weNq27bqvShcmAw6idRGitcA8M/A3Yx6Ur+W4YZ0+ZJRRs/1sfMw
 HcIA39ZrZOTVOLyyRKZgsdH8bvbGLeHHbhwr+kHmDNGI++0nHFVT/viZGkFl1UiEMg9C
 F4EGmop/8g2OZHKxkp8jjV2DR45QfhsD0Mr5y6OmR+McvCB3iw1PyB7M0l7+ZmQEYcye
 +sNLUYI8cSs62ZFErQkDI8q8jv7HSC0bOZk6E5L+e0W+wyofnZVbcYIOllj/00Ae9cb6
 +M0Suyrcm7o9KyBqr3/QaUTONjUmxn9MZNXaGIlap4UWLm0sSBatdyfhfImdyhG4QUlF
 2IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793124236; x=1793729036;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ahlQyaQG+Zpn+OKorM+DHXta4ggVksdpC/pIMQdAHXo=;
 b=KUpXw74u5D1gkta9USRm852y+U1XbcpCT68dpWu7efgTMZkz++eUVZ1NErrLtKAVTu
 G/VJO10RCwSXS3rA2A3VlU2jNr0p8qadu4gf8CSz6AilTvwKJFmkPklsZ0ZuVeMThcRB
 jGw+S9n39nJfPougWf+djVTudTzNthQxjx+QCBgNXJv9siXQznDQBXSRVIJrRLLymnUt
 0uzuY75IUGW0w82efqzdoFjBp7pWq9yuBr/qpNn8ETo2NSPv9IMHyCcSt4Klag0Pgvit
 /r9f8Bv1CBZdfRcq8tRaMzMpHCG39BuG2MrJ1THOmbq6kOiF4Eb47Vu9kD7BbNeUzdUj
 mYAg==
X-Gm-Message-State: AFq9FYKKRr6g3Be2JpYKV6v8LewvpsaUQWCF/smIFrL9iTGMQxsH6ZLo
 nfOKWxSxRJDp6Z6wAXCKQININ8CPPvLB+0f5Wo0JMrcxSH59McwhSnusI2oSd3N51xXUPPkzcBQ
 Dzf+zhq/XCI/viUAL8zWcVwRmysfbr5hV649ywBo2f21WkJSm7VwOdvdlCvrZl81idW8CtN/vEy
 Ecj3WXpO7LslWeRbt6xtNDQcGLy+HclLo=
X-Gm-Gg: AYBFou0UraDd5rN3ZKM/NnW8colClLfQ+IXmIpdlH8iQmaEdG/6T6U9aQJSLVhW8zPG
 LEOCJ13jpPbPNlUpmVa5vqep/tAFKOXDRRr0U/KyeNfdY04CPQOdsk3MaBfH8+X2JYxBwMNcqkE
 0ZAF5zVYYHNqQtU6SISQ6dAlXDfBuZDRQ3gs0QD6P4yqcvmD8o/Jl24uIwPI+gwUmv2uD8/bli2
 7mkUBFg1FCgfOnUPgzgRwTo+YlHsLaVD0OMRtfMxJXGyY+rMj+wQFARPP/wnA==
X-Received: by 2002:a05:6000:29d3:b0:48e:261b:a49d with SMTP id
 ffacd0b85a97d-48e5d5c38d3mr296210f8f.15.1793124236191; 
 Tue, 27 Oct 2026 11:03:56 -0700 (PDT)
X-Received: by 2002:a05:6000:29d3:b0:48e:261b:a49d with SMTP id
 ffacd0b85a97d-48e5d5c38d3mr296181f8f.15.1793124235798; Tue, 27 Oct 2026
 11:03:55 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <87zevzqaz3.fsf@draig.linaro.org>
In-Reply-To: <87zevzqaz3.fsf@draig.linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Oct 2026 19:03:28 +0100
X-Gm-Features: AclHuK-ZNp2V9gI_1kp71uPCyeLqGeKdEP2uwHSqVvxBb8dOUkcz2F4yGCJPV0M
Message-ID: <CABgObfa5fOCwoPzsmEHgN6wsvtWWaAb65+41uF5go3xYbTo2sQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 7:01=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > Until now QEMU's code provenance policy declined any contribution
> > believed to include or derive from AI-generated content.  A blanket ban
> > was easy to maintain while LLM output was rarely usable on its own, but
> > as the tools improved an absolute prohibition has become harder to
> > justify and enforce.
> <snip>
> > +LLM-assisted and LLM-created contributions
> > +''''''''''''''''''''''''''''''''''''''''''
> > +
> > +Use of generative AI can be classified in the following four buckets:
> > +
> > +- "background" assistance, such as completion and code review.  This d=
oes
> > +  not need disclosure.
> > +
> > +- small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of c=
ode)
> > +  are allowed with disclosure.  Splitting a submission in multiple par=
ts
> > +  is **not** a valid way to bypass this rule; repeated, frequent posti=
ng
> > +  of such fixes must follow the rule for full contributions.
> > +
> > +- use of LLMs to help generating parts of a larger patch---test cases,
> > +  adaptations of existing code, boilerplate code for a new API, a tool=
 to
> > +  help performing mechanical changes, etc.  These are generally allowe=
d;
> > +  disclosure is highly recommended for non-trivial, functional code.
>
> Personally I'm happy with the next bit but if there is still
> disagreement about the wording could we merged the policy updates up to
> this point and defer larger contributions until we see what the
> practical effects are on the list?

The problem is that, for all intents and purposes, we are already
receiving such larger contributions. This is why I wanted to have
something about them in the policy.

My plan was to discuss at QEMU Summit, though unfortunately it will be
rather sparsely populated this year.

Paolo


