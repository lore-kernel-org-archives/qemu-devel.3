Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D4FC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKMKt-0005Pb-Ci; Thu, 20 Jun 2024 14:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKMKs-0005PI-9e
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKMKq-0000YS-NY
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718907395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cOFo9a1pSEO6rzVfFmPzkV8fcGmbPGcrohOuXMRJmDY=;
 b=Of+HXwmNDy7tfJ5Erd4W5uapnfyOXRlzvK+B+O7bhhY+FcSEHKAO/himooKewpVER4pARc
 QHjaaSCxaYhBwe5rib95CrAIKmxSLZSzNQ578g3ni5YqXWMNCWlL34fFww8vxUpi5jpEEH
 AbrpwWdgZb6OP/WUBT0kZsv3mR3Rl5g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-g7viuyHqP2OjGMHVoFJy5w-1; Thu, 20 Jun 2024 14:16:34 -0400
X-MC-Unique: g7viuyHqP2OjGMHVoFJy5w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-362763f8d2eso571557f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718907393; x=1719512193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cOFo9a1pSEO6rzVfFmPzkV8fcGmbPGcrohOuXMRJmDY=;
 b=LVuNOiu7FZu/V1xRs2JuV6vTUV2X3/0KV/Ten8+YK6RikgcrGR+yNisM/nT2zvDAxG
 6tlFQdhY1/i/te/4m5DGQE4E9MZShELMEz2nrtEdupDQkj+oyjGAKlR8Wl1Mlp50ADnX
 GAitPV1vY9N2KjHlPnFHJ/CCFKMPweQ/Y4MV1+SbJXPcdUfCa4QHP330kgJzbMzhiu1T
 2h6ZOMjxZG4wTd+6ndn56XjGHZJ+AUagUAgega4nRE+RiBjwAWAlU2y2+76ytboLV+lw
 v/LmvAgKviTlvea7uU0rOK/Cu0gChPcCZlDQ+hqk7EeQPIVEmlknpJgpvvcaRuxtIF8b
 r7fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjzYmltfdUt8CMA1SfajCEaJLwuXp2yfvqEwngQ4MKFz+IqVWh0TuCTrnW9WDbn2+PnRLwMZxCJA3Oy6tOY+S3EbqOmzc=
X-Gm-Message-State: AOJu0YzLmDtipQ9myzkGHX7aWi3RatUOo+31GuYtafG+6IHQDJhOPp0E
 4CmcApCUP/0y9ICR4HO/kwUljkfp9l3yPnxplo4HmcPQtf18+lm6BUWHS3mBo0DRBC/JZuEAY75
 7IsAhWmXJ9GAcpSiokbncZDjiveHfmVGdmRVzye9aYxq3qFRCOG9uqShD6pv18ZzZAlWf6WlNtr
 d3oOPzSJGV2V4Tbby9sm0CoSz5w/4=
X-Received: by 2002:a5d:6152:0:b0:360:709c:5040 with SMTP id
 ffacd0b85a97d-363171e2b5bmr4566082f8f.2.1718907393218; 
 Thu, 20 Jun 2024 11:16:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3RXCJkRVg1RdRzXAtPMEs6FUnYu2qK8+8trm7/jok4nQ6l59EkV2ZcGXydyxhVm94AZVMlkK19OjcC7Kdq+M=
X-Received: by 2002:a5d:6152:0:b0:360:709c:5040 with SMTP id
 ffacd0b85a97d-363171e2b5bmr4566069f8f.2.1718907392923; Thu, 20 Jun 2024
 11:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240618224604.879275-1-rkir@google.com>
 <4b3d0472-8b06-403a-9ab8-553aa858fb7f@redhat.com>
 <92be5dcf-c793-4c29-9a55-910b59c4c2c0@linaro.org>
In-Reply-To: <92be5dcf-c793-4c29-9a55-910b59c4c2c0@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 20 Jun 2024 20:16:17 +0200
Message-ID: <CABgObfbo=aLW7RhjymNDJpMbUXWNRQ2_LccdXqKKVrCq5o75bg@mail.gmail.com>
Subject: Re: [PATCH 3/3] exec: use char* for pointer arithmetic
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org, jansene@google.com,
 mett@google.com, jpcottin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

On Thu, Jun 20, 2024 at 8:14=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/20/24 11:06, Paolo Bonzini wrote:
> > On 6/19/24 00:46, Roman Kiryanov wrote:
> >> void* pointer arithmetic is not in the
> >> C standard. This change allows using
> >> the QEMU headers with a C++ compiler.
> >>
> >> Google-Bug-Id: 331190993
> >> Change-Id: I5a064853429f627c17a9213910811dea4ced6174
> >> Signed-off-by: Roman Kiryanov <rkir@google.com>
> >
> > Would it work instead to declare MemoryRegionCache's ptr field as char*=
?
>
> I prefer to use char* only where there are strings.  For unstructured dat=
a such as
> MemoryRegionCache, void* is more appropriate.

Or uint8_t*... I agree about char*, but unless casts are needed, I
find uint8_t and void pointers to be more or less interchangeable.

The problem is that casts are a bit uglier and (while unlikely in this
particular case) more subject to bit rot.

Paolo


