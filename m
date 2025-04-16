Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2075C369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 14:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u54Ab-0003rr-6r; Wed, 16 Apr 2025 10:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u54AZ-0003rU-5q
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 10:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u54AW-0002UU-KW
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 10:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744815314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8k4hbvnVBE5NT46pE/eA216fxOP0iSRwhvbt2nPxxSA=;
 b=XHXNS7Dff7Uu2civ3rkWNlcmj7obs9YbadM0e7IqzybwQvbBXpBuaEL0nr7rYJjEO48iSP
 0iKNG1Xftd3U1783UkoeEbb0YV0inUmnAt1tzbxp20/W4g+Tyjj+qstiuyP+a0iFm9Jxa9
 NLZ3W0TUnNRMhoceVbgiMFiO5kDTX0E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-GgnaVlpdP2CTa3nnRee8Rg-1; Wed, 16 Apr 2025 10:55:13 -0400
X-MC-Unique: GgnaVlpdP2CTa3nnRee8Rg-1
X-Mimecast-MFC-AGG-ID: GgnaVlpdP2CTa3nnRee8Rg_1744815312
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf5196c25so41879105e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 07:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744815312; x=1745420112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8k4hbvnVBE5NT46pE/eA216fxOP0iSRwhvbt2nPxxSA=;
 b=i9GZ1rFQU3ppA1iK5/uKN/s2bl1i2He6dH+vdylMRPewIZ3EYFPmO4PmfNz7Y+i+Yg
 lcipNniWQangsTwBLQkxKouPRBUzfQJiMJu0VYbiiEtECoCLni5Ehln+Gy5Pl/WN+RRC
 190bwyXphEl+9eYzrRcuRfEtgWAJyWrQCfO05w0VteVpNgkT4szP8D3rDjzv09N28Hk2
 UbhFQ+0Yxuiq28OoPXwXWEnlHhEblmYLye+/vkVZSR9hV4gALiyuYwzbQ02z4OidpsXs
 F4Hkbv7mI+jfOjsCbCskguZk3c+SCsNNAZcyXX73H9K5yoTFTC1S2xZA+QBDnSXj0NTC
 J3Pw==
X-Gm-Message-State: AOJu0YyHD5HxZa5pg0tR9OjPQselqCxZTLGcO7G265Gme03zk0e59arZ
 QR+K/sERzqv3bUpfB0t+Ta4qPe+O8anJQ3tSkwCiJzt/FhfmqcTh2LRdTYSsMerk1W9ZM82KxWZ
 t29kWbNtaZPctlg4CugYT7PF8VipZtBzmeMK1EZI3OKCiDxgKC2n6Cr4xJgrOZRVazOn1H4uWrK
 BZUifLKEnJOPzfKRUOrc47HxAweg4=
X-Gm-Gg: ASbGncvKzowtUA7k+3AWpwBRPsG7jL2qpvOD6aEoUHbu1e6Ihek1in504uYdel87F/7
 xncvMZMB7WvXy7CvEzInSIryB8NMrKyAABwwvJMDdRn2SqPozw7H4VbjAT1AOl+vWQiGhVw==
X-Received: by 2002:a05:6000:2403:b0:39e:cbca:7156 with SMTP id
 ffacd0b85a97d-39ee5b13b8amr2330425f8f.1.1744815312219; 
 Wed, 16 Apr 2025 07:55:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVS6kT7x/9sfaEfRsEirgQyobPpFesppbcThOD6gcb1m5d4F3BLdw1KKLu5RUcPvvCyxijsL8Qg+awn9nPSSw=
X-Received: by 2002:a05:6000:2403:b0:39e:cbca:7156 with SMTP id
 ffacd0b85a97d-39ee5b13b8amr2330411f8f.1.1744815311844; Wed, 16 Apr 2025
 07:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250414144943.1112885-1-zhao1.liu@intel.com>
 <20250414144943.1112885-2-zhao1.liu@intel.com>
In-Reply-To: <20250414144943.1112885-2-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 16 Apr 2025 16:54:59 +0200
X-Gm-Features: ATxdqUFv8219Hv1r0jg_CXUGgNLFkj4kgOR8-kXLqbOIkNEdVzAyBECRRYXQqLw
Message-ID: <CABgObfY8GfLZ5WJwRKTKGTb=qs4-QxsXb9=L9E4z8d9D8AoCJg@mail.gmail.com>
Subject: Re: [PATCH 1/9] rust/vmstate: Support field_exists check in
 vmstate_struct macro
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Apr 14, 2025 at 4:29=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> Unfortunately, at present it's not possible to have a const
> "with_exist_check" method to append test_fn after vmstate_struct (due
> to error on "constant functions cannot evaluate destructors" for `F`).

Nothing that std::mem::forget() can't fix. ;) We know that the
destructor is a no-op because FnCall is only implemented on zero-sized
functions.

Another problem with such a method, however, is that you need
VMStateField<T> for it to be type-safe. Implementing it on
bindings::VMStateField gives no guarantee that the type of the
argument to the function is the correct one. So this patch is okay
too, but perhaps add a comment (not necessarily a doc comment)
mentioning that VMStateField<T> is planned in order to remove the
extra argument?

Thanks,

Paolo


