Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BD2606A33E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jCyh+4EV;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Fx6shxtT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOjHS-000160-Ai; Wed, 04 Nov 2026 17:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xOjHL-00015A-IY
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 17:16:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xOjHJ-0000RL-F1
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 17:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793830577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=Pe1gl2CV9G9curjbBNlxSRhjKcC2jFWfFqOrZ4w4kWE=;
 b=jCyh+4EVSmE3CNC+D6cCko3pFPvP9zHUxdLhJ6W9JfkxxjsqfsY86JW8jAsh9R+3R5njfs
 B5S1zMBjowbP+Ow6OcYN2fy0BnyVUXSV9DUzQ+UiB1GiO6AmPWr1Im9Wc1FPf1r3tUjSQL
 SmRImb8c1jDnM0dgLWa+2rH9odj1QNA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-sdZJe39rNhSyfh8wuEciqQ-1; Wed, 04 Nov 2026 17:16:16 -0500
X-MC-Unique: sdZJe39rNhSyfh8wuEciqQ-1
X-Mimecast-MFC-AGG-ID: sdZJe39rNhSyfh8wuEciqQ_1793830575
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b0e878f574so1312447b3.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 14:16:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793830575; cv=none;
 d=google.com; s=arc-20260327;
 b=KQoHNGamUuSKpmCHrtvBO9Apooc4l0sx9UI/rKuhuSjcWx94SWhxn3Oc1RwXJM7mxN
 FU3omkDrtlGatRUX5ztvCVJ4R6/ouMxqREnzsLSglDMDCoiT5CshFWrYicmR20iD3wUk
 Wb11q5g7IJNDGbB5xTZfagzpIwCPwS5YBdmroKieuSDU6aMbTI4vwLVb/WCwzFnMZ6XQ
 SyzyoE/BF7CWiamUyfIqQvYe1+mKbU8zgFobH7+2st+U1pdc19Rh+jobCP+sdAVFI0j7
 V8qbhaK8g58e4YWldhPRBXR1vvRhxIIvZEp77poiEVxlmRrDXVd6fPAZUWYCX8IHnl6e
 z4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Pe1gl2CV9G9curjbBNlxSRhjKcC2jFWfFqOrZ4w4kWE=;
 fh=o6WzRHm5E7uRlrofMkzzrgsDI7Ce0Cmybz714kKPa+o=;
 b=a1nlZ2eZA7zkRUV6CaoLqGEXaFJjg2gGwlgv/SgjRSSvgAzZ1hWztDZqZYjZl7t/T+
 Pz4H2Yy6Zx1a/xzv0eF/GB5uTwmISpgypMarIysImPVYr8cRC0dE59K+gJFC0bXbYVn1
 W+GEzGc2+TKaBq1EG0A1wecI9A6p8sECMHQpMZhCkKTJ7pxPUuQNicFZYr93Qpf1LMAb
 6gGDCPLL1nmfjfr1MHaQSTuNsExE+CwuR9SPIg7PkMHinbGPSa8dzUdI1NsewlQdAzMH
 tqyHmmu55mBfAaIEHaZM02I0rh6jByX6LRljLR5ZXT7d0vsmJ+GNyDHSwVmczpmcC5ux
 9o3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793830575; x=1794435375; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Pe1gl2CV9G9curjbBNlxSRhjKcC2jFWfFqOrZ4w4kWE=;
 b=Fx6shxtTW8F2aCKbj1PRlCXZOORFqbLmUvGhFEr4In6vYBqoofuvYCQxH658T36xuK
 fWx7bIrIa0CbEDjQS+dwbTBqXLCxIXXWsf0KL/I0xSBSVunoqA4szcQMG25WXaS7Fetj
 4MtVByyGiwZC8WkumksNktEL6HtfjHM6mOnxA++63qYdODbTEdZueUvhkdBOQhLrYimp
 aJBfXyZ/4vneMtZHhpjYjLJ0kOp+l51Kj82yUKW28zgH0V4tfsLnXm+PP49+YOhiwAS8
 gohbGBOoH+gpWSm+XEvIbR914rH16L1exM/GmSRqrlVT+JWQ4bjY4EK/pn8XXR//m9T7
 fRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793830575; x=1794435375;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pe1gl2CV9G9curjbBNlxSRhjKcC2jFWfFqOrZ4w4kWE=;
 b=zY4uOrgeP+DU5Izg2x0M6KuBvF3b30SM9OOHD8iLqbh9Vp5yZhvxy7Ozdacg+dJCRq
 ulbdAB1D6R4u+SvSQ0tVmBolEDOdRQjXNWP1w7IRi9XPQrlzfcbwGwCc7K8fjSe3sCiR
 JmkDfZt/fDxBoS8nqGPM7Zy73x144D6DcR69Wk077q5vpR3jMeNLLhnjFNg2IavOOMOo
 xCz3AxpOoL++AVw0Gq5lQ0dfvfeasq904m8qUvIl+UOTLM6HMUkUd5nM7WsbTJ7xPHgu
 +oQFPKtJ2RZVCW/PyJLZMtGYalRNsUP7YNjXnHQU96+yd5g8WzeZt0sTcmpSKTspOLl4
 1N0w==
X-Gm-Message-State: APuU4Z/Uq0NhaPjOF0WWyddpc3L0jCc67ry4coQOhSraCLsn7iTzTF8G
 1ARNEKmrBDD0TaFKJV3azj1SSXTYiubLy0SWJ7eVjw3LDIbgCYkaa3M9QjlUVdmxDOLosTKiXqx
 8pJDRKecFRhAvuAMAkslzrUDcPNwjwm8tNO6TqicTLo8TLeL9xYpQl7KGOei01W4HD9e8b9GUVf
 4c8wC0niAo3gmO7txx8sXCSSXRzNTSYjf6l5LElt5O2w==
X-Gm-Gg: AYBFou1djzqSKJicAnU7rPSq9rf8pDdN2xmJz6CtsDSzL7W1ZhmsapvSBweM+ZJfM39
 aNf9QMDiSrDebFnt9WhIw5zIpFE1tZ2QNyXwVlbQYaYjkZCGXO7VD0/Jttcs2QKQWfUUErdN/9S
 26RET+/WSxlRMUtrMM7DMGjbe6WR3jQyLRTsO24F5cCGmIHifZaV9I79epiJGPZ25HJ2yfxixc5
 MNFLUUO58O7zgMO
X-Received: by 2002:a05:690e:a49:b0:679:9310:6581 with SMTP id
 956f58d0204a3-67c035d441bmr619829d50.23.1793830575366; 
 Wed, 04 Nov 2026 14:16:15 -0800 (PST)
X-Received: by 2002:a05:690e:a49:b0:679:9310:6581 with SMTP id
 956f58d0204a3-67c035d441bmr619814d50.23.1793830574807; Wed, 04 Nov 2026
 14:16:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: John Snow <jsnow@redhat.com>
Date: Wed, 4 Nov 2026 17:16:03 -0500
X-Gm-Features: AclHuK9pFrT4_O8OOWrcXshL1x2iM7sn80P0-FgzTzD9lN-ruqtrtyLjCQRA5IA
Message-ID: <CAFn=p-Z=RGEO-sTgRR549LkQbdfjR-zfnb8GASV8XnQf4TrwAw@mail.gmail.com>
Subject: input-keymap sizes
To: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Heya!

I've been looking into producing minimal QEMU configurations for
sandboxing, and as part of that, I've been auditing "what exactly
takes up room in our QEMU binary?"

One of the things that came up was that input-keymap.c burns over 250
KiB of .rodata all by itself; all of the keymaps we generate for QEMU
are included statically in one big blob and are linked with every last
build.

There's a few things we could do about this;

(1) We can split out each keymap into its own object file, which
allows us to link only the keymaps we need for the features we have
enabled. Dan Berrange wrote a quite POC for this and the results look
good at a glance. We need new linker flags to automatically prune
unused keymaps from the build, or enhanced meson-fu to
deterministically exclude them. Either way, it's likely a worthwhile
pursuit. In a microvm-only build configuration I've been testing with,
this immediately dropped us from 250KiB to 180KiB.

(2) The x11 keymap used by ui/input-barrier.c and ui/gtk.c - all by
itself - consumes 128KIB for its keymap. This is because although the
x11_to_linux keymap has fewer than 512 total entries, it allocates
this in a const array with 64K entries in it so it can span keycodes
0x00 to 0xff and 0xff00 to 0xffff.

It's the second one I am concerned about. At first I thought that I
might be able to write a "condensed" table that uses 0 - 255 and then
remaps 65,280 - 65,535 onto 256-511 and then take (index & 0x1ff) on
lookup table input, but I realize that the entire unmodified table is
passed off to gd_get_keymap() in ui/gtk.c where I can't inject those
index transformations.

Does anyone have any suggestions on how to help shave the x11_to_linux
keymap down to a more reasonable size? I doubt we need 128KB when 1KB
could theoretically hold everything we need.

--js


