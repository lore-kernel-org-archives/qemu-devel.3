Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0A4D3A697
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 20:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5sWK-0000fe-NR; Tue, 29 Oct 2024 16:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t5sWF-0000fG-NM
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 16:08:49 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t5sWD-0000Aq-8a
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 16:08:46 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7180ab89c58so3023728a34.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 13:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730232522; x=1730837322; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=egpZkoNRhocGja0LxHpjqqxUHMRtS/AkYTsO1oJFueo=;
 b=C0xfBDW5eSfuWjyXHy6/UKoGbd6L/K1K6IHj2GSl98McCihfoRGYQKMkSJeNNZiI4z
 ohdtULx+Uv01Qfi1GM4trvFCvisClF35UvY6zw8iggzp4lzpPWNEQx2dq3dPwTwGEC3P
 OApOGozjXbie1RRMnx/DZZeUPAuZirdDfK8dRelB1fnnKRSqrAbYNzmXkumC1VHMcfML
 CqJCwyKHNrOJGzMqWChcUW8d/PykSxEgjrnpmXF3E01bRAoCDW5Me4+qUigYs2x9i9e1
 IyRsve6XMhtdxqt/Gp1WY7MwjvM1LKbXIqmHc021B6gxM/i32bauIrqXBXgoibFcQN5J
 KkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730232522; x=1730837322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=egpZkoNRhocGja0LxHpjqqxUHMRtS/AkYTsO1oJFueo=;
 b=SKc3P+Yk3A4PoM5w7gznYQIcFfVOIqVOaMf5C4BHzWzLdqJeLcIoYJfOiPb5Q+Wd/W
 OquYX852VC3sOG3LF3/hj1XlNmEwXjcSzijeZ/fckUM85DK+TOHand5ZD1V93F5AIZRN
 2v4aKYpA/ddzRY6PP2A/jQIjIuBo+4F+UzEdsYpBwyBDz03EgIMi49ZXtMufhC1nixCH
 kG1f+fQtvA4EpRNKBsHlTRgQAErd8vgut1bzFXSBVdistb04MhFXQYfjPXHR9hApkasd
 B7T1nSOQnc0vOAx2N7PF+CV7M615qs/lFnHKJM2TAyT9nhdwUgdFZUbCBvI2uk/mdG4X
 +TiA==
X-Gm-Message-State: AOJu0Ywm8KnTEUHwYRoisJjVcDRfeuLQLR2xVbBntzct+W6D6gPYBDvj
 n2gDkVACcWfyfG/aoQ0U2QNvzNl/50p2LQCvd7fKXlbzW+8ofCkIEh8jBJ7+u3iVwZAJAxTLD2y
 YcQCaF+gxEkaOfVaHOY0i0L67Ntc=
X-Google-Smtp-Source: AGHT+IHexexWjhXel3YT5miqHqOeduyz4JnfFL9SEibwpkwrX6cH6T66Cu0seiGcgMEGYQTXqaxW5ucR92h5RGuEK9A=
X-Received: by 2002:a05:6808:648d:b0:3e6:4652:a4c5 with SMTP id
 5614622812f47-3e64652a5a3mr8054282b6e.26.1730232522531; Tue, 29 Oct 2024
 13:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20241008211727.49088-1-dorjoychy111@gmail.com>
 <5839222b-4d61-419b-80a2-cc7afb36abc9@amazon.com>
 <CAFfO_h5HquFuWQSo0n009dgi48Qoi_5MdRFuHOuHMGWNB2Q8+A@mail.gmail.com>
 <CAFfO_h4QCDc5qTP_U+-c0NTxPh5J53x876e5aVskMHx28OUerQ@mail.gmail.com>
 <54fe9ff2-ee5c-42dc-adb0-b4131a496a0a@redhat.com>
In-Reply-To: <54fe9ff2-ee5c-42dc-adb0-b4131a496a0a@redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 30 Oct 2024 02:08:44 +0600
Message-ID: <CAFfO_h7pFJUkm=BgJwyMYoVfj5GOb8oGivfcPfu9UrSix19_Ow@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] AWS Nitro Enclave emulation support
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, Alexander Graf <graf@amazon.com>, 
 stefanha@redhat.com, slp@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com, 
 berrange@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=dorjoychy111@gmail.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi Paolo,

On Wed, Oct 30, 2024 at 1:32=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 10/23/24 16:27, Dorjoy Chowdhury wrote:
> > On Wed, Oct 16, 2024 at 7:58=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@=
gmail.com> wrote:
> >>
> >> Ping
> >>
> >> This patch series has been reviewed by Alex. I am not sure if it needs
> >> more review. If not, maybe this can be picked up for merging. Thanks!
> >>
> >
> > Gentle ping.
> >
> > This patch series has been reviewed by Alex and there hasn't been any
> > more reviews. it would be great if this could be picked up for
> > merging. Thanks!
>
> Hi,
>
> sorry about the delay -- the patches failed CI and I didn't have much
> time to investigate until now.
>
> The issues are basically:
>
> 1) some rST syntax errors
>
> 2) failures on non-Linux due to lack of VHOST_USER
>
> 3) failures on 32-bit due to uint64_t/long mismatch.
>
>
> While fixing (2) I also moved the dependency on libcbor and gnutls from
> meson to Kconfig, and added --enable-libcbor to configure.  I also split
> hw/core/eif.c to a separate symbol, just to simplify reproducing the
> 32-bit failure on the right commit.
>
> And finally, VIRTIO_NSM should default to no (the nitro-enclave machne
> takes care of selecting it).
>
> No big deal; it's easier done than described.  See attached patch for
> the differences.
>

Thanks for fixing. The attached patch looks great to me. I just have
one suggestion. Now that the CONFIG_* symbols have the dependencies
listed explicitly in the Kconfig files, maybe we don't need the
explicit dependencies in the meson.build files? For example, the
following line in hw/core/meson.build file:
system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib,
libcbor, gnutls])
can be changed to:
system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c')])

I am not sure if zlib is a required dependency for QEMU, probably not
needed to be listed above as well. I am just guessing.

Same goes for files added in hw/virtio/meson.build.

Thanks!

Regards,
Dorjoy

