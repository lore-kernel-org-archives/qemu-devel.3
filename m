Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C838C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 10:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Gj0-0004nL-Tc; Fri, 25 Apr 2025 06:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u8Giv-0004mN-LY
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u8Git-00020C-Uu
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745578558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wqr21zxEYE/NhAdiygtSLWhkEgPBghQdYnYjU0re6O0=;
 b=BqRMLET73bM3VDOISRHPmZjsWVZEreBr9Xiq3PF3XmR6y/4a2OuB8Q/UrGds+0knayl2Oj
 /5b1mVFXtk9z0ghwkyvkZgervmdJpquVjMkSrKJj9KWoqHwiVlzVcrLUX6IPXyWqWl0JyG
 0ayBnhswAt2YEWilU0GvumLGxrKoAQA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-qH3yBjelPzq8nF0qKg5s7Q-1; Fri, 25 Apr 2025 06:55:55 -0400
X-MC-Unique: qH3yBjelPzq8nF0qKg5s7Q-1
X-Mimecast-MFC-AGG-ID: qH3yBjelPzq8nF0qKg5s7Q_1745578554
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39ef89b862dso1075637f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 03:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745578552; x=1746183352;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqr21zxEYE/NhAdiygtSLWhkEgPBghQdYnYjU0re6O0=;
 b=aPolIw23G50rLcCpQiYRZcipIb5nnpAeBj7G3OjneNyubQ+luhL0zwiDzFyn14Y4Dc
 W6UGQWVDVAfOboQ7aYh/aX7jR+ROW6cxyP+s8EnR728l7l0EvUYEiGwmAjnIcPEGVQAs
 Sxv/TSjlpSUec8MraaoJDRlQzNmYPbncoKIwOt87wOT0qvu5qh3+ywlxy86JujpCLcKi
 nas+zqBtqjVoC7pDuqW5qql6tsD97OEqYWZUtJMhg5GVe0RyM7587krHqxB1xWmcFtsi
 augQH8Zsd/YpQZexbdrWU0IbpBVvPirlDek1ci8SQasb29Yck/b7JY3Fo2+f8aP5Cerh
 PJow==
X-Gm-Message-State: AOJu0YzfHuzSisFWePuoMDBrDsKgoI3NptnX03Rra4JbRJR4MuUeVzD3
 N8iUoHn0azaZDMyGQQNRs56KT/YbRLpY1Hek0okHJMkv3QWKq2kIZCAJuFc9HSjtTbd6ffIxtwU
 4mei1F3Bo40Kz0posG6yiHLOv/Nr+gb4vAx6vHMb9l4/kCJ5znGqc8rEIuJEbXzUwlakl8V137g
 JnJAIadgHIvPhwdEUvVnehq55+QICJczkgeFc=
X-Gm-Gg: ASbGncvJcL4ZSN0YRRoU1saXIh0y0B5/1Ikc6xsAyPfLSfs5r1mGid6HDbKdz8hH8cB
 OalH1QsUXbM3fO4inEfKOqPw72EiH1hx+ni+5KLUEykHaKOP/GlbBh1o9MdgAFAOfOrHZYQ==
X-Received: by 2002:a05:6000:22c2:b0:39c:1258:7e18 with SMTP id
 ffacd0b85a97d-3a074f8929fmr1380741f8f.57.1745578552638; 
 Fri, 25 Apr 2025 03:55:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExx7Addi9PM9KIl2BYlF6s9XCHjBXjHbTkjwNwNbSqjANvK/bU0K8Li0X5QH129RmVjjAewnAJcvVFtaT1vOE=
X-Received: by 2002:a05:6000:22c2:b0:39c:1258:7e18 with SMTP id
 ffacd0b85a97d-3a074f8929fmr1380731f8f.57.1745578552354; Fri, 25 Apr 2025
 03:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <CAKmqyKO=-QhuKNAKJBXfGiwPdSt=uT6M16pgVJENLxgEiy5Adg@mail.gmail.com>
 <c0dd76b5-da8d-4193-9ea1-5fb5e55b35a8@redhat.com>
In-Reply-To: <c0dd76b5-da8d-4193-9ea1-5fb5e55b35a8@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Apr 2025 12:55:39 +0200
X-Gm-Features: ATxdqUFAfJIdR3-svTaEvFg8V3wCKeOT3O4ndEXv9E71Oa8dam-14icCA4MhlUs
Message-ID: <CABgObfYy53Z-LsW2QNdWdtEhnXq9=2f9aDdZHZrou4sNQN_ZYQ@mail.gmail.com>
Subject: Re: [PATCH 10.1 v3 00/27] target/riscv: SATP mode and CPU definition
 overhaul
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 24, 2025 at 4:39=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> > Thanks!
> >
> > Applied to riscv-to-apply.next
>
> As Daniel noticed, I was expecting
> https://lore.kernel.org/qemu-devel/20250210133134.90879-1-philmd@linaro.o=
rg/
> to get in before this series.
>
> If you need a version that applies without that series, you can pull
> from branch riscv-for-alistair of https://github.com/bonzini/qemu.

More conflicts have appeared so I've updated the branch and will also
send v4 for review.

Paolo


