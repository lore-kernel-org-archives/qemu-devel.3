Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB100C35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuDU8-0000mo-KN; Mon, 17 Mar 2025 12:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuDU6-0000lj-5o
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:38:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuDU0-0000JU-36
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742229506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bEmzBwDzV2ARU9KIpCy4vtKofjMO7s2CMmEtnd0Vrg0=;
 b=RyytO96hjFWllcUpgt1krMotXwFftm67KfGnI7/KkQCvMeFS6KRR0cMr0KHbrvEEpjEOrJ
 ih/rEcveTjfuzsTEeh9jGRQ6WXMju1ha5QQhQ9qZpS6SBXtp+bwY0N5vhfRsgEpJIdNfdo
 M6sEkWqo5bKOXdxv7d01oK+R4es8e4o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-7tg8IKISMPSXITtsKqfXWA-1; Mon, 17 Mar 2025 12:38:24 -0400
X-MC-Unique: 7tg8IKISMPSXITtsKqfXWA-1
X-Mimecast-MFC-AGG-ID: 7tg8IKISMPSXITtsKqfXWA_1742229503
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912aab7a36so1968715f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742229502; x=1742834302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bEmzBwDzV2ARU9KIpCy4vtKofjMO7s2CMmEtnd0Vrg0=;
 b=TTDiFXKHgwmo+3MaNOyDgasc1dX+oKdq73O9jKix5LaYgfcJnPoiZnKhKEhblJ5GLD
 nL5XzZzOksvEAOm64uA1svd3STIM7fzNVuUUm2xjVHAN+qiubTld4xjhRhQmxgRXXMgK
 KjD5QcjL/D4oNRrwHnAmqB834VJ2MyO0NHQBRDHEn8WIn5M5bzFRDewejse7CSWIkWfd
 P55+HzZlbCp2/OWcx+QBGQ72hURhMiKVL40hmPN2jtrsdFQF8u3zhyuvboBgnwFn8nem
 jpqUYHQRwzSJ1jt1BaSzmHKHfmNxZZybV6OOkdIKQwyuOKc0MF7ZdKBxA37wL8D9HgRi
 9LLQ==
X-Gm-Message-State: AOJu0Yzq0EWBrge5fH9bmk3jPGYkYj0Wu8/by6SoE6hXDah8Sf8E30va
 HwzAJ10fOptlGKHVIGpfDYpPaZjOxiw5y2jarSYMSdKcHx6D+aI2+c+6hpAt6T0KnwycoKHw0G2
 Rch6uDc7KaSUj+XThlxTMC6gYfiUrvMt4jxqI3Blq14viOt+ZLxAGuGc33dhTMZsABsqaci1Dpe
 clhbFitfo2YnL4ej1Z5nKDOQUEJ/aK4LdE540=
X-Gm-Gg: ASbGncvuNc7vFzANU+lajLbag2B57PcKCvhxj1POprgcPc+yw/is+QMB8a73DIH2R/q
 euYn8T2tSSK5WPacpmC+qbvl/uU4r1wZrt9qhtjCMDBnUaZZSJF6NoZzziOxw646KuIVNS4LMjA
 ==
X-Received: by 2002:a05:6000:1a87:b0:391:4559:8773 with SMTP id
 ffacd0b85a97d-397200aff6fmr13337932f8f.51.1742229502529; 
 Mon, 17 Mar 2025 09:38:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX4Kk0XBAFFDgxsLVqj+1XmlEtot7zd+148M2uOBoT/b4cy5cmxHqz8+TqGTAbuQjCnv/V3KQ96IBJikxMbEw=
X-Received: by 2002:a05:6000:1a87:b0:391:4559:8773 with SMTP id
 ffacd0b85a97d-397200aff6fmr13337914f8f.51.1742229502223; Mon, 17 Mar 2025
 09:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250317151236.536673-1-zhao1.liu@intel.com>
 <20250317151236.536673-13-zhao1.liu@intel.com>
In-Reply-To: <20250317151236.536673-13-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 17 Mar 2025 17:38:10 +0100
X-Gm-Features: AQ5f1Jo7SZaKH_Ysp1az4PA95opN_bD7_hqGIh0kxkC6VCj6NSMp-YzwwEoNC10
Message-ID: <CABgObfaqFHb8AkHLj8enX3NCSAUUOhP_pPZ6chbBR6rUk6826Q@mail.gmail.com>
Subject: Re: [PATCH 12/17] rust/vmstate: Support version field in vmstate
 macros
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Mar 17, 2025 at 3:52=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
> Add "version =3D *" in vmstate macros to help set version_id in
> VMStateField.

Could it use a ".with_min_version(2)" annotation (or something similar) ins=
tead?

Paolo

> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  rust/qemu-api/src/vmstate.rs | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
> index 3d4c50ca86f9..bb41bfd291c0 100644
> --- a/rust/qemu-api/src/vmstate.rs
> +++ b/rust/qemu-api/src/vmstate.rs
> @@ -197,7 +197,7 @@ pub const fn vmstate_varray_flag<T: VMState>(_: Phant=
omData<T>) -> VMStateFlags
>  /// and [`impl_vmstate_forward!`](crate::impl_vmstate_forward) help with=
 this.
>  #[macro_export]
>  macro_rules! vmstate_of {
> -    ($struct_name:ty, $field_name:ident $(, [0 .. $num:ident $(* $factor=
:expr)?])? $(,)?) =3D> {
> +    ($struct_name:ty, $field_name:ident $(, [0 .. $num:ident $(* $factor=
:expr)?])? $(, version =3D $version:expr)? $(,)?) =3D> {
>          $crate::bindings::VMStateField {
>              name: ::core::concat!(::core::stringify!($field_name), "\0")
>                  .as_bytes()
> @@ -211,6 +211,7 @@ macro_rules! vmstate_of {
>                  $struct_name,
>                  $field_name
>              )),
> +            $(version_id: $version,)?
>              ..$crate::call_func_with_field!(
>                  $crate::vmstate::vmstate_base,
>                  $struct_name,
> @@ -442,7 +443,7 @@ macro_rules! vmstate_unused {
>  #[doc(alias =3D "VMSTATE_STRUCT")]
>  #[macro_export]
>  macro_rules! vmstate_struct {
> -    ($struct_name:ty, $field_name:ident $(, [0 .. $num:ident $(* $factor=
:expr)?])?, $vmsd:ident, $type:ty $(,)?) =3D> {
> +    ($struct_name:ty, $field_name:ident $(, [0 .. $num:ident $( * $facto=
r:expr)? ])?, $vmsd:ident, $type:ty $(, version =3D $version:expr)? $(,)?) =
=3D> {
>          $crate::bindings::VMStateField {
>              name: ::core::concat!(::core::stringify!($field_name), "\0")
>                  .as_bytes()
> @@ -455,6 +456,7 @@ macro_rules! vmstate_struct {
>              size: ::core::mem::size_of::<$type>(),
>              flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
>              vmsd: &$vmsd,
> +            $(version_id: $version,)?
>              ..$crate::zeroable::Zeroable::ZERO
>           } $(.with_varray_flag_unchecked(
>                    $crate::call_func_with_field!(
> --
> 2.34.1
>


