Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5EBCD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdPg-0007qL-2F; Thu, 11 Jun 2026 07:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wXdPe-0007qC-Vt
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wXdPb-0005vu-QO
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781176646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7qcbo9Um2tsGYWOv/UswD+5S096bTkRZ87+AruqpHGw=;
 b=gTwpxRscQLUXyPenFWxS5k9+Ye62QlfxhLaGijfQ/QT6LEtlQ8qhTRFO8sXjLPlXvKeOMP
 X+R1AFKFOol3rgaltWIcxUewYcb2fAptrpzYlU1pcoBQ/ZXqC0m9tpykuzcR+mmgJkER+S
 QuEiz+Y6JwkyUftXWaXAII0Mh922U+c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-mkiTFMhyMNiwzzbwA9Ri6w-1; Thu, 11 Jun 2026 07:17:24 -0400
X-MC-Unique: mkiTFMhyMNiwzzbwA9Ri6w-1
X-Mimecast-MFC-AGG-ID: mkiTFMhyMNiwzzbwA9Ri6w_1781176644
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45ef2bd566bso4463236f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 04:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781176644; x=1781781444; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7qcbo9Um2tsGYWOv/UswD+5S096bTkRZ87+AruqpHGw=;
 b=Zb9vZg92TYmjogNHdTEgC4sOfcG0mbpvH6tqtb2t88GuRk63XXXomW1MAULd+5te2/
 27FRpKFNi9Mdqdx+O21NZiANX8pn0jaSB8ExtXRqou08g0rouQyGzGFSuGU1CE8BVr0Z
 S0gXWRde1IfJ2ZTyKGlB1oTw6pDA69aLEhUHzBWjkB3w5BSlWoGP5W1zs3WoqIn9Lnzx
 uVV1iVT06r0mO8Ug7sUzlGTW/GmAf5Zp/APYiZrpgW2gku0D8TYSyhtOJBvd2ZNoxJmQ
 Qe1uoJgK2R13ZG0tmPvSdYz6+qqI1OaZRBczDkRqgvE8Uo57jQszE7M6lWhmjP/mvV/I
 y/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781176644; x=1781781444;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7qcbo9Um2tsGYWOv/UswD+5S096bTkRZ87+AruqpHGw=;
 b=E4Jf6PR3nKsjtZYcDeg/upTerJ3vLFNi7SWVd3589CLUaPp25H9yAtV4Lu0UxqFB2K
 r995ZysuERIOLpqQxBDbvFCn1PKtMcbH+xE8iIFGeVaNQTaDDbRemPnwAcPgCqaMYjAn
 MkxagxKoElzvoVFkYbFYrtqbraO6pBU1Q08/sqqLldy10Z5B21zc5bUpvPmk3Tm9PlMu
 J1YTRscw7Rbr1i7Q76tNJl1wDlGAoZgJVBi4+TxIULVyVKsKrtFyReuLjZI3tTBKQZKD
 F5xdfe4XHEBdL+wpgd8R0wTT3OhA8ZcMQUGHGXw21BQZ82oV4qLMIhTmxgooRdtXpFLd
 z5CA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oJhv7IdUjtX3D4kd5t+slJ2VS0RBJFIKOJYugZGeNykY7rJ+mPF0RhyhMAueZ9KNuvj8xb8LtbMvf@nongnu.org
X-Gm-Message-State: AOJu0YwZv5oGzCoqnP47oVzQmaCGvEtOWdK5UWPn7PsqWRWyzMsRTQ6n
 rJojMi62TBFXQHSkRxmv8dStUJOgvbLWSarxtyLYSMR0YFHKXkDED6jORZCtzRoR7sG53ktVxf+
 GpikQz1RotwfaqVtdzvyb7y2g80Sx6CAteU8mvLaWR+fQ/jDIOH6Z7qLN
X-Gm-Gg: Acq92OHO/dUhu9DCKTgD0LuDF8I/tlb7N/5FBLpejfT6z6ZQxbfwWG7PJRhVajqvd1G
 DoFcvzGFmah9N6MDqwZIFMEadI6HCHkc51aa2JR3YC3RzQX8Y+rwwU+YrZLNY6J7Ts6+Z1gUbSo
 Rgzc7txD1by/behIoB2ZRzsNKbbZ6TF8oT+PbSv/aDzhv5waSi+SUM8jkbBfS5wkLuc5PFaud0B
 N8PJRbPDrEk/8PlSBjp8IWcGpBHKwjILQ3uiOQUSWMaUuVsT8b5Huc4yRQfiQduCsSPPBj+kAm+
 zRWiYdhUM2ZZG1y7A1xLg+xhdSLWebsSbL082hDpGK61uML/qJbCjzjYQlSvF9Wm00WdSAOHvGO
 kLFucpZTQm8/isPsLrgzs0EH6kzyMmBCQZGZCik53wdWY6VCrmSoOm53hw37TxAJ+F1x8nw==
X-Received: by 2002:a05:6000:4013:b0:460:3234:77d4 with SMTP id
 ffacd0b85a97d-460677eeb17mr3592346f8f.42.1781176643749; 
 Thu, 11 Jun 2026 04:17:23 -0700 (PDT)
X-Received: by 2002:a05:6000:4013:b0:460:3234:77d4 with SMTP id
 ffacd0b85a97d-460677eeb17mr3592282f8f.42.1781176643171; 
 Thu, 11 Jun 2026 04:17:23 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm138396728f8f.27.2026.06.11.04.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 04:17:22 -0700 (PDT)
Date: Thu, 11 Jun 2026 13:17:20 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] igvm: populate errp in stub functions
Message-ID: <aiqYzfMjIMheO7kC@leonardi-redhat>
References: <20260609-igvm_stubs-v1-1-5f39d6e0db4a@redhat.com>
 <aigULaw73khPNxoR@redhat.com> <aigUdNYq0YRtAZKt@leonardi-redhat>
 <ailrwxbi1i-xy37h@dobby.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ailrwxbi1i-xy37h@dobby.home.kraxel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On Wed, Jun 10, 2026 at 04:27:18PM +0200, Gerd Hoffmann wrote:
>  Hi,
>
>> No, when IGVM is not enabled in the build it's not possible to trigger
>> any of these stubs. On top of that, I don't think it is possible to trigger
>> these stubs even when igvm is enabled. This is because the only architecture
>> that implements igvm support in qemu is x86.
>
>We have these stubs mainly to avoid linker errors when compiling igvm
>support on !x86 architectures.  So we do compile igvm support for other
>architectures (or, to be exact, we compile the core igvm code once and
>link it into all qemu-system-$arch variants).
>
>Nevertheless I think that the stubs should not be reachable.  The igvm
>code already has checks like this ...
>
>    } else if (target_arch() == SYS_EMU_TARGET_X86_64) {
>        result = qigvm_x86_set_vp_context(data, vp_context->vp_index, errp);
>
>... so it should never try to call x86 support code on
>qemu-system-$somethingelse.
>
>On that base I think switching to asserts should be fine.  If we
>actually hit any assert the core code lacks a sanity check.
>
>take care,
>  Gerd
>

Right, I got confused by madt function not checking the arch.

Ignore this patch, I'll send a new series that improves madt and switches
to asserts.

Sorry for the confusion.

Thanks,
Luigi


