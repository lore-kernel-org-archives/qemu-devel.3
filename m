Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53792D15D8C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 13:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2scA-0004gH-Bn; Mon, 21 Oct 2024 09:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2sc8-0004eF-3S
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 09:38:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2sc4-0002BE-Ie
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 09:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729517901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMM96eFATp/mr3MSLSPxASOoy70jEwJunGSvwrg8+KY=;
 b=Q8q3QftC4ry83bNxxMxKb5AdBXDxzSeRNNXSGw7OTUqSSvAeQ9uTq480AkgJHuFI+47DAc
 EcomcmzPkbzFk7OQ9O7tV8tHbI4daeGyWHFE8I2dffqL8f0x9y/74gwOgu7HBi41DfqWVB
 qoNgmXji0TGP+gqlpkMJ0rCBrIE5nwE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-kthu2pPFMSOCVDJwFAR3iw-1; Mon, 21 Oct 2024 09:38:20 -0400
X-MC-Unique: kthu2pPFMSOCVDJwFAR3iw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d458087c0so3061036f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 06:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729517899; x=1730122699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMM96eFATp/mr3MSLSPxASOoy70jEwJunGSvwrg8+KY=;
 b=JD5pXg0oIlIjJzsnfsiUNqqrLeZJg1xSL1LclEN5teB+9nusbRkV/I2DsTR79Ontrp
 mj0v+vWVWngF7KLEoSmhoisI/uf9omPxnfihZXgiMZwO00Uyh5h8xgp+1XMdhZ2MnE8A
 S2SwSqq3eVhqVqvyuGTpjRyxEQMPBEsNrsth/khgsnnM+FwdXOLnW6aYZoUbRxwB6MT+
 fJLX8KT2Xmm9sZVIRvFNkrI/j1U7ByhbBk3/NQQJhyL6NzMuCVZYCtsbobmAnVqKosM4
 EFDrDW9i0H/OOtUXTXlGXwXWTBDvHNNlaJXDZbaZpg7ssZUbpMYazM6qeBsJKhNftgU+
 V5LA==
X-Gm-Message-State: AOJu0YyLtptX/sIl2SnTy/00G+prcOneqtfnd6jJCZ6tGlCcF0gAOBwm
 DSpJ4TtGQqWdzSZZSXQzqKt1p7nsGxbf+NWZVJnSft+/+MnxcfoEWj31BG3wp7++xFlldVg5tMj
 VXfQacx4RY6aUK5C1/9atlCMPxA2R8rhFM/+XhKiblQTGv76bxoH7qwqhBDE9YoSQMTu7En5ZHP
 19V++3NDRdxcA8cE+4ZW6+UwXuBcQ=
X-Received: by 2002:a5d:5d86:0:b0:37e:d92f:c24a with SMTP id
 ffacd0b85a97d-37ed92fc3e8mr4395196f8f.7.1729517898798; 
 Mon, 21 Oct 2024 06:38:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGET4WszUqYnzArPpArDcupDhj+L0AaKdY2dhgB/hdP/DqpaR6QGPa5Bg4+FdCgx4GaHKvlSiXT6pSymAKVtyc=
X-Received: by 2002:a5d:5d86:0:b0:37e:d92f:c24a with SMTP id
 ffacd0b85a97d-37ed92fc3e8mr4395186f8f.7.1729517898474; Mon, 21 Oct 2024
 06:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-4-pbonzini@redhat.com>
 <ZxX1jSkJ3Muk11zC@intel.com>
In-Reply-To: <ZxX1jSkJ3Muk11zC@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Oct 2024 15:38:06 +0200
Message-ID: <CABgObfa6G0Seobc5jLsxEFSRXu4qf-1U7vEEix6pCX=wfsjsPw@mail.gmail.com>
Subject: Re: [PATCH 03/16] rust: pass rustc_args when building all crates
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 21, 2024 at 8:16=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
> unsafe_op_in_unsafe_fn is allowed in
> rust/qemu-api/src/lib.rs. So should we wrap the bindings in a separate
> lib (similar to the rust/bindings in the Linux kernel)?
>
> This way, the special lint settings can be applied only to the binding
> files, while the default lint checks can cover the other user
> development code.
>
> In addition, another thing that confuses me is why bindgen still
> generates code that does not follow the unsafe_op_in_unsafe_fn
> requirement. It seems that bindgen has supported unsafe_op_in_unsafe_fn
> since v0.62 [1, 2], but binding code we generated still violates
> unsafe_op_in_unsafe_fn. Is this a bug of bindgen?

The plan is to support older versions of bindgen (0.60.x) as long as
Debian has them. One possibility to fix this is, as you said, to use a
completely separate crate. Another is to add #![allow()] to just the
bindings module, for example by changing bindgen.rs to

#![allow(...)]
include!("bindgen.rs.inc")

This is related to the fact that we don't have yet a good way to run
"clippy", because "cargo clippy" needs the bindgen.rs file. So we
should probably look at these issues at once.

Paolo


