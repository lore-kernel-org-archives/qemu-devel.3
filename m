Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B2EC02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 16:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcoEg-0005F4-5B; Tue, 28 Jan 2025 11:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tcoEe-0005Ea-44
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:14:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tcoEb-0002Zs-Lr
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738080859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kc8enLSj1HDrlTEGHcsZbJOKRFBv8ol2f9z+k40dNvE=;
 b=cNUP6y3A2XUu1Sk/5kbxQwjP83s30PdkesfBbXFeM78WNqVuewAj9OjGQkbe+Y5hK4MQQT
 zypPjA4BiRIGbiJrl1Opp2uPuQPejaHNGmwSEvn+wKmJ4Zxv89pD8lwLqFs4NMEJa/3Ve0
 wZKtaDcgKkt+f+MMQwHElpPhFZA7Nso=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-MfKLQGi-MF-fh-RHpmgIfg-1; Tue, 28 Jan 2025 11:12:00 -0500
X-MC-Unique: MfKLQGi-MF-fh-RHpmgIfg-1
X-Mimecast-MFC-AGG-ID: MfKLQGi-MF-fh-RHpmgIfg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43673af80a6so42921885e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 08:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738080710; x=1738685510;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kc8enLSj1HDrlTEGHcsZbJOKRFBv8ol2f9z+k40dNvE=;
 b=WEVCyRsGhj9oSruSlHrQKL8Vx3tEFZx88i4zhHeEpbmynKfiw3pP/JngDoU55GAH7m
 Haj64wAk3Ss90WUB66IQ9QyhOg0SRWwVVyTJc7buSaY1p8ewib/MhDKHBaSxHMRqcIPE
 nHw0i7ew8+oA1tBzzxUN1dgSQIZ39dpXin3WG9ngwgbqNjEFIOPEliHctSBgtoW+ScU5
 Jk+mXRkCsJ5rgHjdhEtyOdRFIf/5F2ouKoOLcmVY+/q44aDxN+HreNbIn/vqBlYxjMNz
 apiEXRq31dSL5chlcEeE+gtuMCi1V3FNoAvvrf3L6bluJYcSP/MJwCYjskOYUDOI7gHa
 a+2A==
X-Gm-Message-State: AOJu0YxGod3gEhxojZLXsR+IiBphGh6Am5MPGyxKVX4yN0johxgiIQc5
 1ODAyUvl+RYy4SvuF6DwoQ00aOPVbEZZ1PiZTOlfCeU1yOdrFUBrGKJAfQn/JYHaaiuVOXoWo6S
 iWz1R+e9f6sCYhqa/4RrA4FuPcMwwxCwcitbRQGtfsR0bE3+DfEyXY8+5zWgBpK4=
X-Gm-Gg: ASbGncv2kyiE/pqzShk4+Qv7+lZes8GZZ1+yj4UpsZRc5gTsg7k5kEzY4jttStOCSEW
 8VSudBI5+9esuIiiT77ElCrqS7hZWSVYf7HRuqKK2AeaJbmp9llocb2L0M6vwMc+szMPYXoTnWK
 coQtZYUZD3lcwcCU/ndKNU0o+PllVTjodBgn+V3LFjxU5pL9ZZTXOEF/CgZIZ+OVwX6LkyGNIFo
 +C6X746u+pNTKrhxeTr2PgVZv2YSOStdfQBP05PtgyMPDZCevmWI1EokQjTLmyVcFOIbBxkDnVx
 EWhFIgs=
X-Received: by 2002:a05:600c:3acd:b0:438:c18c:5ad8 with SMTP id
 5b1f17b1804b1-438c18c5b00mr150188555e9.31.1738080709801; 
 Tue, 28 Jan 2025 08:11:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPldeE1c+RDHGCGrgGaD/5eRUzA3OmQ84wDsxMwx+u3n3eTx9TtEgY1cZKqCKKnrhBR1fogg==
X-Received: by 2002:a05:600c:3acd:b0:438:c18c:5ad8 with SMTP id
 5b1f17b1804b1-438c18c5b00mr150188305e9.31.1738080709429; 
 Tue, 28 Jan 2025 08:11:49 -0800 (PST)
Received: from [192.168.10.3] ([151.95.59.125])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188928sm14409962f8f.45.2025.01.28.08.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 08:11:48 -0800 (PST)
Message-ID: <935c6d55-eb55-44e8-9903-aef05c2f97a6@redhat.com>
Date: Tue, 28 Jan 2025 17:11:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/48] i386, rust changes for 2024-01-24
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20250128112439.1225171-1-pbonzini@redhat.com>
 <CAJSP0QWJ=qkA2Bzih7nGq5K=YrJRqUOt85RAGL=mj3MEjAW6ug@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAJSP0QWJ=qkA2Bzih7nGq5K=YrJRqUOt85RAGL=mj3MEjAW6ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/28/25 15:19, Stefan Hajnoczi wrote:
> thread '<unnamed>' panicked at 'already borrowed',
> rust/qemu-api/libqemu_api.rlib.p/structured/cell.rs:450:5
> note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
> fatal runtime error: failed to initiate panic, error 5
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/8972076251/artifacts/browse/build/tests/functional/arm/test_arm_tuxrun.TuxRunArmTest.test_armv7be/

Hmm, this one does not reproduce locally.  I've started a
QEMU_CI_AVOCADO_TESTING run.

> Do you want to include a patch that sets RUST_BACKTRACE=1 in the test
> environment so the backtrace is captured in the logs?
Yeah, I'll send one in the next version of the pull request.  The 
BqlRefCell issues are easy to track (because you cannot drop the BQL 
while you have an outstanding borrow, unlike regular Rust RefCells), but 
you do need a backtrace...

Paolo


