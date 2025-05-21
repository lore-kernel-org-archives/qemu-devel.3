Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77376C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 08:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHefP-0004ou-Ns; Wed, 21 May 2025 04:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHefI-0004n2-LJ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHefA-0000A0-U4
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747815532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oBjkbO7ab/Bs8vweaRnYdvEsyUdC25nLwFE9KdD0if0=;
 b=RnV0ssiiKwNdF5KpU4U5XzR9IWkBMLdZrPqBztm1Jpqb2gey9taWKHxlWgPCFNM+SsRABf
 Dn9coLJPoe51Tl+zuUx8naDjygppSipJXqw19NWo5Qhq/fjeK0HkG/yc4CVU5nyZ7IvLzH
 RduQrlkQc4D/NeIvQsxRHa80LwH0GYw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-V2xEAnyeNN-NF8Y5L6dY6A-1; Wed, 21 May 2025 04:18:50 -0400
X-MC-Unique: V2xEAnyeNN-NF8Y5L6dY6A-1
X-Mimecast-MFC-AGG-ID: V2xEAnyeNN-NF8Y5L6dY6A_1747815529
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a35c86b338so3781437f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 01:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747815528; x=1748420328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oBjkbO7ab/Bs8vweaRnYdvEsyUdC25nLwFE9KdD0if0=;
 b=XmxJULkypScf7J7Wsmoi5UDAVSNYxZQEQEyyvhDPGpt86y1SoU+PVDE/tHqWrIyQdm
 WQGUdOlT0UzwV4KanygAAONVmdoZSWOGNVHrGctM2TEY+RAQHzb2zQxPjoVrooSPpV1T
 DgGaRcxO4StCoMVrtRUebmEAIjEBYtixFa89vHvSnugORs3YYzT5iFCI9w3Wa43eqYY0
 y1Dz4Cu8nOBXNfiUYLaXidUakwLyXafPGXd8HP87VylEqBNtADzVDO/gYFoGpe7sS4CJ
 O0hLDPBVW+C3VGUsdzGWK2luMQzyRwFjo1GAiBp/duYA4hdgu3fNY8rL6ZfcrAbI0pqF
 vBXg==
X-Gm-Message-State: AOJu0YyCKgW7odVNhGDl3+eXsVJGpazBQARy1BdT6nas61m0kXmeAXDQ
 8hNDiYp+ln1STk46yQO5ZSNGOxqdN77sVyYXF6uaXxl+wbyK6F2y+h5Cs6jaR9cXz8CFgML8z3q
 4IUYFi35JxWYAnhAHt+Yy96vRPDonBJ4qV3mLHfQ//FfAkEBP8xWqqFDH0ZZGAuE8iFcx81L47i
 FEgrNRQ0bSavYT6kv8g9VLJ6tXdM0qEUPMd9kGT36r
X-Gm-Gg: ASbGncsXOhAfbcH3l+dFytdFx6XzVn3Y8T4NjlbQbzLwwx2Op1fCOZbewFS1pqIF7CC
 mT57odxcFgphaiW1iPXNAukk9GG7NA312Cnx0++R7d3rd4uEi/zdc9PdRCPk2ho6b5xw3PM8KHi
 9UZL1JF07ECeZA8DmysdQ/RDTnKJvtB+3SVgOcma9i8PoLjt8UbpuXOGwStiJ+9zPM/ee6m/rKz
 jJ0xcH3Kx2EUuYzlC7ce0s0CTdjZszriQpuO3lGzqd8IU90ucI7N0/SORz58XYCUQyNcjZ2N+Cg
 1j4nSJ1jpMg8Hw==
X-Received: by 2002:a05:6000:e4e:b0:3a3:6273:802f with SMTP id
 ffacd0b85a97d-3a36273835emr15122793f8f.14.1747815528042; 
 Wed, 21 May 2025 01:18:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsg/GqmklxmQ7sz4QFR1LXhEFG9K6O4Ar6IkiF6h+ieSZuCuV56zTQtlu5fzkXbeXsXhXonA==
X-Received: by 2002:a05:6000:e4e:b0:3a3:6273:802f with SMTP id
 ffacd0b85a97d-3a36273835emr15122764f8f.14.1747815527546; 
 Wed, 21 May 2025 01:18:47 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f78b2f19sm58652665e9.32.2025.05.21.01.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 01:18:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-rust@nongnu.org,
 manos.pitsidianakis@linaro.org
Subject: [RFC PATCH 0/6] rust: make usage of bitmasks and bitfields nicer
Date: Wed, 21 May 2025 10:18:39 +0200
Message-ID: <20250521081845.496442-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This adds or modifies some of the early choices that were done when
writing the pl011 crate.  Now that the implementation is safe and
readable, it's possible to look at the code as a whole, see what
looks ugly and fix it.

To see the effect on the pl011 code, jump at patches 2 and 4.  But
overall the focus is on "ugly" constant declarations of two kinds.

First, bitmasks.  These are currently written like this:

    const IRQMASK: [u32; 6] = [                
      Interrupt::E.0 | Interrupt::MS.0 | Interrupt::RT.0 | Interrupt::TX.0 | Interrupt::RX.0,
      ...
    }

Here the issue is threefold: 1) the repeated "Interrupt::"; 2) the
ugly ".0" and 3) the type of IRQMASK is not "Interrupt" to avoid further
".0"s elsewhere.

All this can be fixed by abstracting this kind of bitmasks, and the go-to
solution for Rust is called "bitflags".  However, it does not solve the
constant declaration part so I'm rolling my own here, while keeping it
similar to bitflags so it's not completely foreign to Rust developers.
It's a bit simpler and it has the extra expression parsing functionality,
so that the above becomes:

    const IRQMASK: [Interrupt; 6] = [                
      bits!(Interrupt: E | MS | RT | TX | RX)
      ...
    }

(this specific case can also be written simply as "Interrupt::all()",
because all bits are set, but still).


Second, while the "bilge" crate is very nice it was written with the
expectation that const traits would be stable Real Soon.  They didn't
and we're left with stuff like

    pub const BREAK: Self = Self { value: 1 << 10 };

So this series replaces "bilge" with an alternative implementation of
bitfields called (less cryptically) "bitfield-struct".  Now, there is a
trade-off here.  It is described more in detail in patch 4, but roughly
speaking:

++ bitfield-struct supports "const" well

+ bitfield-struct is much smaller than bilge, so that it is possible
  to remove a bunch of subprojects

- bitfield-struct requires manual size annotations for anything that is
  not a primitive type (bool, iNN or uNN); this is especially annoying
  for enums

It's important that the disadvantages affect only the definition of
the type.  Code that *uses* the type is the same or better, for example
the above const declaration becomes:

    pub const BREAK: Self = Self::new().with_errors(Errors::BREAK);

This "with_*()" convention is in fact the same that it's used for
VMState declarations, such as in ".with_version_id(N)", so there is some
consistency too.

Again, I do like "bilge" and I think it's usage of arbitrary-width
types like "u4" is very nice and readable.  If it ever grows "const"
capabilities it's certainly possible to come back to it, but right
now I feel that the trade-off leans towards the switch.

Paolo


Paolo Bonzini (6):
  rust: add "bits", a custom bitflags implementation
  rust: pl011: use the bits macro
  rust: qemu-api-macros: add from_bits and into_bits to
    #[derive(TryInto)]
  rust: subprojects: add bitfield-struct
  rust: pl011: switch from bilge to bitfield-struct
  rust: remove bilge crate

 rust/Cargo.lock                               |  75 +--
 rust/Cargo.toml                               |   2 +
 rust/bits/Cargo.toml                          |  19 +
 rust/bits/meson.build                         |  12 +
 rust/bits/src/lib.rs                          | 441 ++++++++++++++++++
 rust/hw/char/pl011/Cargo.toml                 |   4 +-
 rust/hw/char/pl011/meson.build                |  12 +-
 rust/hw/char/pl011/src/device.rs              |  51 +-
 rust/hw/char/pl011/src/registers.rs           | 145 +++---
 rust/meson.build                              |   4 +
 rust/qemu-api-macros/src/bits.rs              | 227 +++++++++
 rust/qemu-api-macros/src/lib.rs               |  60 ++-
 rust/qemu-api/src/vmstate.rs                  |  34 +-
 subprojects/.gitignore                        |   8 +-
 subprojects/arbitrary-int-1-rs.wrap           |  10 -
 subprojects/bilge-0.2-rs.wrap                 |  10 -
 subprojects/bilge-impl-0.2-rs.wrap            |  10 -
 subprojects/bitfield-struct-0.9-rs.wrap       |   7 +
 subprojects/either-1-rs.wrap                  |  10 -
 subprojects/itertools-0.11-rs.wrap            |  10 -
 .../bitfield-struct-0.9-rs/meson.build        |  36 ++
 subprojects/proc-macro-error-1-rs.wrap        |  10 -
 subprojects/proc-macro-error-attr-1-rs.wrap   |  10 -
 23 files changed, 917 insertions(+), 290 deletions(-)
 create mode 100644 rust/bits/Cargo.toml
 create mode 100644 rust/bits/meson.build
 create mode 100644 rust/bits/src/lib.rs
 create mode 100644 rust/qemu-api-macros/src/bits.rs
 delete mode 100644 subprojects/arbitrary-int-1-rs.wrap
 delete mode 100644 subprojects/bilge-0.2-rs.wrap
 delete mode 100644 subprojects/bilge-impl-0.2-rs.wrap
 create mode 100644 subprojects/bitfield-struct-0.9-rs.wrap
 delete mode 100644 subprojects/either-1-rs.wrap
 delete mode 100644 subprojects/itertools-0.11-rs.wrap
 create mode 100644 subprojects/packagefiles/bitfield-struct-0.9-rs/meson.build
 delete mode 100644 subprojects/proc-macro-error-1-rs.wrap
 delete mode 100644 subprojects/proc-macro-error-attr-1-rs.wrap

-- 
2.49.0


