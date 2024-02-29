Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6A2C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 12:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rffcw-00071k-V6; Thu, 29 Feb 2024 07:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rffcv-00071U-LW
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 07:35:05 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rffct-0000IV-C4
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 07:35:05 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-565a3910f86so1355270a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 04:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709210100; x=1709814900; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QsW6yhR7XApu1msK5N/EYtXk7TTWXJpMR9V2i7yEhNg=;
 b=k4+xh01P1VJ/U/QsFkM8wOwCJLyzrwm1lWXtZ5c5nS4vSEibzhPE9oT4i7bAlHLHcB
 Di+2YS16/A7AhSeMRbuyogL0MViKBkZlXyRK7/Tio4hnOnVe0bYH/fhdXiPJft5eaEVA
 AOdCNsEHRSVgO0+HAY2zUrP9DgAS7AM2A/qhWnW0FigK+i+d+qpndu/f+g8KZxCTVF4P
 Wd56hMogBwNuDqatUWTLo7Ap7zdtS671CAm7EE9GGS/KnusJK33Mx+o8IYonQhxUsdGH
 AA+GhwmJofZPr9NGkFEA5zrH7MexY8hsvJYpZ+e8Vr5BHRF0+OJuSsu2Tc1F6fyhpQJf
 9BVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709210100; x=1709814900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QsW6yhR7XApu1msK5N/EYtXk7TTWXJpMR9V2i7yEhNg=;
 b=mGO4188/3LyF9n3Ei87KhqYj8cl4jC4FOhaLCGK215HKGWZSIbSYApy0IpULL6zCea
 jUhAUk381xBveKoft316HnGADOO2ikG3ztZ2+i5FvzRP8gB465XRDdJVFgVGgPZKooZ1
 F9EEaH5RwHpxa21QvzabXXjzYDSJBMy4s8IS18A3ulwWTFmersagU0QCftdGjdDUaD9j
 fOAeyNU/OjzpH2i1FhvIQiApqoHKbyozKeXiUBNcv/HoFhqrfuc7keULxYYkz6oX6V6m
 iyYWeWGft9unK+dmujG+FRZXJmLoccCOo2359DXfFnt57WhhyziWPJPaQQnrqV1zUkQk
 /hCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAhTuUM8HvWOrMvKhpLhmRtUqmBukurQG5NAceWps87/IhPKBIRCvAmiQfFYmJYDOrh7nchCP1xFA0kmtLVHGo3SgjAYo=
X-Gm-Message-State: AOJu0Yzu5aq7SVseCnjsItDL+9LaPzQah9nejuOsZFfqSR20ARnO82Fc
 Jyf0koASTqsQfwzSQh8lZ95DihKm3VGdK0x2EvioadyALG9fZx4t/OmSie3ax+ueqV/V6SvstJr
 kt68BT8yEw4kiRPLyuHenF+oqjBTDNi7abyY0nw==
X-Google-Smtp-Source: AGHT+IHfu9zRkBsAM+Sxqti+GmYUh4ES/5yRRro1upqVi3mGT14nvwLombxBHr3woGb/R+JtNLgv24JoVBujQyJXtSo=
X-Received: by 2002:a05:6402:230e:b0:565:ee3c:8c7d with SMTP id
 l14-20020a056402230e00b00565ee3c8c7dmr1387446eda.31.1709210100421; Thu, 29
 Feb 2024 04:35:00 -0800 (PST)
MIME-Version: 1.0
References: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
 <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
 <b9937680-8c0b-46f6-86ef-55139562e2c4@canonical.com>
 <CAFEAcA_Bshua2BQTfOb3D1aF27ayELEt9TcQM8hkQdKaih3xHw@mail.gmail.com>
 <9c64be5c-25b8-421d-966a-bdac03dfe37c@canonical.com>
 <CAFEAcA92s+3Q3ud=zOjsyvuqZ=BjwXt3OY0n5mO_iDXovQpoRQ@mail.gmail.com>
 <20240229105900.0000490e@Huawei.com>
 <CAFEAcA_O2QPwCPE0HS9g0saEA3XbuVS_UGtRpe_o4tLRrc6Ksg@mail.gmail.com>
 <bf3e44c8-a6ad-48b6-8825-ba8ce0dd19f8@canonical.com>
In-Reply-To: <bf3e44c8-a6ad-48b6-8825-ba8ce0dd19f8@canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Feb 2024 12:34:48 +0000
Message-ID: <CAFEAcA85nwJ-qfzFVYBY0kiD7mEtr5UHRD_X_s=Vv7eaoHD_bA@mail.gmail.com>
Subject: Re: [PATCH, v2] physmem: avoid bounce buffer too small
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Mattias Nissler <mnissler@rivosinc.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 29 Feb 2024 at 11:17, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> > But yes, I'm not surprised that CXL runs into this. Heinrich,
> > are you doing CXL testing, or is this some other workload?
>
> I am running the UEFI Self-Certification Tests (SCT) on EDK 2 using:
>
> qemu-system-riscv64 \
>        -M virt,acpi=off -accel tcg -m 4096 \
>        -serial mon:stdio \
>        -device virtio-gpu-pci \
>        -device qemu-xhci \
>        -device usb-kbd \
>        -drive
> if=pflash,format=raw,unit=0,file=RISCV_VIRT_CODE.fd,readonly=on \
>        -drive if=pflash,format=raw,unit=1,file=RISCV_VIRT_VARS.fd \
>        -drive file=sct.img,format=raw,if=virtio \
>        -device virtio-net-device,netdev=net0 \
>        -netdev user,id=net0
>
> This does not invoke any CXL related stuff.

Hmm, that doesn't seem like it ought to be running into this.
What underlying memory region is the guest trying to do
the virtio queue access to?

-- PMM

