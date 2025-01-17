Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7C3C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 16:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYopn-0004P2-MI; Fri, 17 Jan 2025 11:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYopm-0004Oq-F4
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:04:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYopl-0001de-1P
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737129872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=njhGBVroVL03ww1mizJrAIhWa1YMIPNBDlMZ0VxXxwo=;
 b=OKYWLm7/oYbnGocqDWVt7Kr+QApR1NV6BT8rXtLN/Qw1JVGB26lqwRc95bsa7eStsnzONm
 /EKjaxeAcHc5CbGHS5erOKE1z3wooRzuTWmxnjxNQdLyns4Q+uJYkvBdvYmnjZOKh8NPJ/
 dN8Rk3J3K6XKVoM18RbqkCpZsGJfFNA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-76AIXBRcMv2Jc7GpfvJhhw-1; Fri, 17 Jan 2025 11:04:28 -0500
X-MC-Unique: 76AIXBRcMv2Jc7GpfvJhhw-1
X-Mimecast-MFC-AGG-ID: 76AIXBRcMv2Jc7GpfvJhhw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3862c67763dso905945f8f.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 08:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737129866; x=1737734666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=njhGBVroVL03ww1mizJrAIhWa1YMIPNBDlMZ0VxXxwo=;
 b=Kz9phxPc4DW326DUkVgXgEojCdF5T/1PV5kmcgCM06lNwcx/g9xfU0tDpqQJ6NPItx
 9AqEAsgRtUozFU4uzJtR5vwCJL5EJ79NRTR18HIToOEUcy48W+2y4iUi/o6QuXKGefMZ
 4K883kXKcuTSHaeV22oC4Whc7RFKQssKNH4jJbaaZd2jG3LWS2C+YTXP8KxLC2vRY5jl
 U3ZIhMFVD10HFchB4eMGOwdGDUaKVUbicgdVq+CTbm0BLejJobTMjtp50zGtGzLlIzoY
 ILmp6hOK78dTK1vj+s7XeO4eUaINbN14+7ixuWkLQG2qOwXlh45iv0ypme4Tz6QXx8mX
 y6OQ==
X-Gm-Message-State: AOJu0YxWnhGRfAa1aWZmf/zh1LH4QjXq7CdEqavgd2uLc4AvPg2bv1r3
 /qN000Pyu49jdVT4qa+7BISlbyWzQmu2S24TeqxfzwQV7jVUkJa/2IVcLaU2b5CToNzaqIoaBa7
 P9xS8VeC8hqShXkblES9N2a2723yjTykuNq64aZxLEcDsBIWPLqje1MjR1ljiZNOTu6VqLAoOes
 0rAM80zvh4K4e5uuqdJEIrhDArEQg=
X-Gm-Gg: ASbGnctOOPE8IE2wMmR8AAyEzASgmRLna5QKIR0NRc87b4xSi5WFaShsg3NfTtsBY25
 gR2ZToXALJEOp2aMdGYWB+85U0jQz2eCV8PHDr+k=
X-Received: by 2002:a05:6000:178e:b0:38a:a043:eacc with SMTP id
 ffacd0b85a97d-38bf5655a55mr2523939f8f.1.1737129866483; 
 Fri, 17 Jan 2025 08:04:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzUQG8JHauR7g2u7AS0mOEBL7RjV3wfORRJlhVLBUE/cfGT1NjUJLZ259qEB4di6/mglqcE7gY3vCdWsHFRjI=
X-Received: by 2002:a05:6000:178e:b0:38a:a043:eacc with SMTP id
 ffacd0b85a97d-38bf5655a55mr2523908f8f.1.1737129866124; Fri, 17 Jan 2025
 08:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20250107155406.53161-1-pbonzini@redhat.com>
 <87plklfn0k.fsf@draig.linaro.org>
In-Reply-To: <87plklfn0k.fsf@draig.linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 17 Jan 2025 17:04:05 +0100
X-Gm-Features: AbW1kvbnYKV-bhF6Ov88Q2o4imd6L-QWuiLnqf_iQJQxv-0pY_BPNt8u79Uluco
Message-ID: <CABgObfbuqxuO95-PRB-D49xcLhRnym7XaLwSOVkDhOJbwdKLUA@mail.gmail.com>
Subject: Re: [PATCH] rust: add --check-cfg test to rustc arguments
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.79,
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

On Fri, Jan 17, 2025 at 5:01=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > rustc will check that every reachable #[cfg] matches a list of
> > the expected config names and values.  Recent versions of rustc are
> > also complaining about #[cfg(test)], even if it is basically a standard
> > part of the language.  So, always allow it.
>
> Hmm this breaks the non-project CI builds even further (I as hoping it
> would help):

You hoped right; the patch has a typo (sorry about that) and needs to
print 'cfg(test)'. The correct patch is included in my latest pull
request.

Do not worry too much about failures in the nightly Rust job unless
you're working on Rust itself; it's there so that future breakage is
detected early, as in this case of a compiler change that had a
matching cargo change.

Paolo


