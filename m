Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E32C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuDTg-0000Jg-C3; Mon, 17 Mar 2025 12:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuDT5-0008QT-3G
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:37:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuDSz-0000CP-Di
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742229444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MYcG2QNzGLgZ5qOapiCQwiKdaL5WSa5O/uWHhdEsv0s=;
 b=MfTB4Ut8YVmOomAgLSyCnNF9PQ5cf+UIzHm+J4AoJOVxpP0gVQTCP48N3cpCVD3Z6gigAv
 VCZqchQRtBgwgdKjs2Gw/mZ26B4LFAPp1UgZeM0ApmZbgap6nd1so2cvx070JOq7JmXF2Q
 fSa10giIp/funaiCQMJPE1AhbN0snZc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-dbinH2sCOF-7o0huG_YX1A-1; Mon, 17 Mar 2025 12:37:19 -0400
X-MC-Unique: dbinH2sCOF-7o0huG_YX1A-1
X-Mimecast-MFC-AGG-ID: dbinH2sCOF-7o0huG_YX1A_1742229438
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43935e09897so14590875e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742229438; x=1742834238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MYcG2QNzGLgZ5qOapiCQwiKdaL5WSa5O/uWHhdEsv0s=;
 b=YPpBAbHF/ifht9rtiRPqfpGP5MajVSz59lWxL5LqMJGUXq35DIVN1Mz7OcQPxpXP8C
 DKN0APX+fWkS5Dmp/uYQXdI0u+v7crt/2zLBLJoAU9gnmFV1iEE9NvaB06rIzkuv817O
 XiDFNQ65CbIvNu8T1vxlO8Y9qknP80C4z5sifcO0rqrNpw/+ArwgwC7Ia46TbxOFF5Xd
 SWA2juzhRctImPZR3lxD78Jibfx3zaxCg6LjI5RMyByiQjbpCrTThUH8Uyxex7P0Sw6l
 32W2iwyjm3AW/2aaqk2M8KCYvu+W4ymGzaRz88cjmfRk/ERH0OZuddAdg66b5PKvWyxK
 X05Q==
X-Gm-Message-State: AOJu0YygsQ3esNG8hJ6S6aYHWijkiY7vzifPXGTtQ7X1roPOZFcLoLsW
 OEK39y63KfHNHLxCklEYzrUsaUIxCewtXTqddBS8ZqhTkIC7PjWam6+8cUs8fXVlxtRGKOtsmSk
 k7b7cM9bDZwtlJPoZk1eLlXhVXplu0J4sFxEInzJ3lkNe9pBrqdHqLMhgpeec+evntSImOq04Hx
 hhloquvu+063pfAqEZ/qxgpvrgwS4=
X-Gm-Gg: ASbGncvDKgQ324q5BKJGgyNE8kqsRDyrd9tAPKZsBQEqyjCJlyMs62R016Vr5KeJ2FO
 FBvx3386Xbp9v2XNoZoCoc/lxF5tZH9P31JaFW+rk75YoU6EuuK72Zm29HypdOUQFn81oMBM83Q
 ==
X-Received: by 2002:a05:600c:3146:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-43d1ecb1019mr126759415e9.18.1742229438335; 
 Mon, 17 Mar 2025 09:37:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWG4Q/ohnbmNVUxrxjBS/NH5I3UPo8Ioxwqxuzt+uGeKI/yIx6nCjidbR4Gb3D5eqs1tl4oZNQ4MGlTYSt/OY=
X-Received: by 2002:a05:600c:3146:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-43d1ecb1019mr126759235e9.18.1742229437984; Mon, 17 Mar 2025
 09:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250317151236.536673-1-zhao1.liu@intel.com>
 <20250317151236.536673-4-zhao1.liu@intel.com>
In-Reply-To: <20250317151236.536673-4-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 17 Mar 2025 17:37:06 +0100
X-Gm-Features: AQ5f1Jo23zt-CpUQ-vUNM8JLpBuZDcSWBhmWsNpWuWyxlwTgTsz0OWMlqEPAc4U
Message-ID: <CABgObfYrdpkTGFfDKFGK7zkHJVW5Tn2q=tXw6d97m4P_3ZNdrA@mail.gmail.com>
Subject: Re: [PATCH 03/17] rust/vmstate: Add a prefix separator ", " for the
 array field in vmstate macros
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

On Mon, Mar 17, 2025 at 3:52=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> The fields are separated by ",", so it's necessary to add ", " in array
> field to avoid matching failure.

This is not a field though, the only (intended) fields are name and
field. It's meant to mimic the slice since &a[0..n].

Paolo

> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  rust/qemu-api/src/vmstate.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
> index 9533b1250fa5..94efbd8bb735 100644
> --- a/rust/qemu-api/src/vmstate.rs
> +++ b/rust/qemu-api/src/vmstate.rs
> @@ -202,7 +202,7 @@ pub const fn vmstate_varray_flag<T: VMState>(_: Phant=
omData<T>) -> VMStateFlags
>  /// and [`impl_vmstate_forward!`](crate::impl_vmstate_forward) help with=
 this.
>  #[macro_export]
>  macro_rules! vmstate_of {
> -    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:e=
xpr)?])? $(,)?) =3D> {
> +    ($struct_name:ty, $field_name:ident $(, [0 .. $num:ident $(* $factor=
:expr)?])? $(,)?) =3D> {
>          $crate::bindings::VMStateField {
>              name: ::core::concat!(::core::stringify!($field_name), "\0")
>                  .as_bytes()
> @@ -435,7 +435,7 @@ macro_rules! vmstate_unused {
>  #[doc(alias =3D "VMSTATE_STRUCT")]
>  #[macro_export]
>  macro_rules! vmstate_struct {
> -    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:e=
xpr)?])?, $vmsd:expr, $type:ty $(,)?) =3D> {
> +    ($struct_name:ty, $field_name:ident $(, [0 .. $num:ident $(* $factor=
:expr)?])?, $vmsd:expr, $type:ty $(,)?) =3D> {
>          $crate::bindings::VMStateField {
>              name: ::core::concat!(::core::stringify!($field_name), "\0")
>                  .as_bytes()
> --
> 2.34.1
>


