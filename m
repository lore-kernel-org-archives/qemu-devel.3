Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2B0C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 07:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHeE6-0006A8-Ch; Wed, 21 May 2025 03:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uHeE3-00069i-7e
 for qemu-devel@nongnu.org; Wed, 21 May 2025 03:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uHeE1-0004LK-24
 for qemu-devel@nongnu.org; Wed, 21 May 2025 03:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747813850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQjtfDqthdj6UgTYkt5Wrllq7IC2KUYUX4S2fZW54vs=;
 b=ghYrc2ycYxeFuYp+Q5QAiJznrD0wYSiJaMRJC1IOPVVhuX73aLLLEmEj98JwsHz+S/I9GC
 5q8Wn0g71kdBKExr5GJxnBsVbkTFokbANXay7DR8L10vEpH+l8Tx+FIo6sP30CcpomF7p1
 7l8trNwSCsggnQ7WvcnAE0bfK3EVg/M=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-EDHL4SgZO0mTG_YgkdBuhA-1; Wed, 21 May 2025 03:50:49 -0400
X-MC-Unique: EDHL4SgZO0mTG_YgkdBuhA-1
X-Mimecast-MFC-AGG-ID: EDHL4SgZO0mTG_YgkdBuhA_1747813848
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7394772635dso4828087b3a.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 00:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747813848; x=1748418648;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yQjtfDqthdj6UgTYkt5Wrllq7IC2KUYUX4S2fZW54vs=;
 b=kWAknTYmj63an5TLnyvYO6yRAAXo2xzaI/f2BLN9LJrbTRO2FibqPOB3FCWdTQpvfT
 YpdlOniicAQAhvIzjo8ABTDAUrZxRpMoCtkOrWzf9oc7A1tz01EkBj+g31zcSM98J518
 KmXTUrC5rketHw06d3mvLa9sr9N/OzMWfno4byHAJOIFPrxqnjhSqcYIHnNQxuBnjRMX
 sI4eKEFO2uggQZ0A7Qu4vHRbxe0TjcX3hF3RV+JZvYOvyAPpU2l7TVIhVgnlcm/trfkg
 qHZ6RX5BybDKWgy1Es40MPM9ilOCebRnqhhSeiDwoVl8bJYwjZyVYKhTbosxLbhMKSdu
 UPcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU5y3H10z/qjNejnrxJwPSFokWULNmW1CvGbEhEtxltpTob/knnRIn9LHVpSc6aLyPv2xwU4O7Ctwk@nongnu.org
X-Gm-Message-State: AOJu0YwF73Ti4gCVlSrydyGmYeYDMwDMFCXJJmNZXPpI7Otpoxm1Omhi
 FxGepDWFc1c4IhasAw79sr4xP+3ru5bR9WCrXSEoOoTR6vNQGTGWs6q9xoMKshWRRU5uko/sngO
 Rwk6zC+LfiCCGhJnYMNM8Xfwq112mYnTXxcJ0RRuPUp+6Fyg04WwyacOG
X-Gm-Gg: ASbGncsq8e58rVGI9tJq1cpS4hXbt8a/Fz6ZXSFintkkMYFuL9BILV+fAcogcd94ryV
 rpwILVZT3GzVRmIQK6NF2vZvWmhu1fb4b0afSeghI8sI8UH8i1US7630WZ8n/qg1BNFXVksghoF
 09J0YE+wtOxO4QstnqZD04IQEbix8ZkKoRLL6Lt/FhLB6SigKqSLclVj+s0YG6Vk8XCDkb4VT/p
 1T0A6EfzHOWwIQUQj1ZI1gp9SablWVaMh3CnwmRa9Otc7wxH+Gq59pa8EKjkOHetzZe87plKuGm
 6QebT0FnhVaEl1fk9d4erER1Odd2
X-Received: by 2002:a05:6a00:2d0a:b0:740:6f69:8d94 with SMTP id
 d2e1a72fcca58-742acba67c1mr24984291b3a.0.1747813848144; 
 Wed, 21 May 2025 00:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTmj42VnrLsO/xM6V4Bbj95+EQ8sbTw7OPnFifz7KfsdUHR0QVAVIoah6xuXtp3Yi1Prdz9w==
X-Received: by 2002:a05:6a00:2d0a:b0:740:6f69:8d94 with SMTP id
 d2e1a72fcca58-742acba67c1mr24984268b3a.0.1747813847657; 
 Wed, 21 May 2025 00:50:47 -0700 (PDT)
Received: from smtpclient.apple ([115.96.138.222])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a986b38bsm9067550b3a.129.2025.05.21.00.50.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 May 2025 00:50:47 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <63vckbpscnedivwx3qgucmhi6xiyebtpwqhkft4jelklujy6dz@wp6ibjvbtbox>
Date: Wed, 21 May 2025 13:20:29 +0530
Cc: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tsirkin <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Dionna Amalie Glaze <dionnaglaze@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6CAF9D54-073B-44E8-8C8F-B27F92E208B3@redhat.com>
References: <CAK3XEhNS10gKLh6SKeSc9cKi+_qwu3+Yu5rAkni5h7tYS59D5g@mail.gmail.com>
 <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
 <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
 <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
 <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <Z9vSeF67fNazkxBh@8bytes.org>
 <4p7orqixni5m3444l53isxe5awdwasrb5e5bu6wu4phhycqpir@z22wgnaxowsg>
 <CAK3XEhNeB29eaPxZ_1Cc7WfEzOGZZPcvTc5uC1XAdtG0uNfDRw@mail.gmail.com>
 <h2s75tkddnrmodbbr7hxugrivpbhq7cfpbmhmgqmnn5mlafedk@jhv5cobgtjkc>
 <63vckbpscnedivwx3qgucmhi6xiyebtpwqhkft4jelklujy6dz@wp6ibjvbtbox>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.2)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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



> On 8 Apr 2025, at 1:41=E2=80=AFPM, Gerd Hoffman <kraxel@redhat.com> =
wrote:
>=20
>  Hi,
>=20
>> Which means we are back to the single firmware image.  I think it =
makes
>> sense to continue supporting classic rom images (which can also be
>> loaded via -bios).  Any use case which needs more fine-grained =
control
>> must use igvm.  We can use format bits in both capabilities and =
control
>> fields to indicate what the hypervisor supports and what has been
>> uploaded to the firmware image region.  See interface header file =
draft
>> below.
>=20
> Updated draft. =20

Is everyone OK with this latest draft version of the interface? Can we =
assume that this is more or less how the final hypervisor interface =
would look on QEMU?=20

> Idea is to go all-in on IGVM and support IGVM only.  We
> keep the format bit, but more to make things future-proof (have the
> option to support other formats should the need arise at some point in
> the future) and not because we plan to support multiple formats today.
>=20
> So we are down to this:
>=20
> --------------------------- cut here ------------------------
>=20
> /*
> * igvm only vmfwupdate interface rewrite
> */
>=20
> struct vmfwupdate {
>    // VMM capabilities, see VMFWUPDATE_CAP_*, read-only.
>    uint64_t capabilities;
>    // control bits, see VMFWUPDATE_CTL_*
>    uint64_t control;
>=20
>    // address and size of the firmware update image.  Will be cleared =
on
>    // firmware update and reset.
>    uint64_t fw_image_addr;
>    uint16_t fw_image_size;
> };
>=20
> // --- format bits, used by both 'capabilities' and 'control' ---
> // igvm
> #define VMFWUPDATE_FORMAT_IGVM           (1 << 32)
>=20
> // --- 'control' field bits ---
> // disable vmfwupdate interface
> #define VMFWUPDATE_CTL_DISABLE            (1 << 0)
>=20
> --------------------------- cut here ------------------------
>=20
> All other details will be offloaded to IGVM.  We will need some IGVM
> format updates for that:
>=20
> * Add a parameter to specify the location of the payload (i.e.
>   the UKI, or some container format in case we want pass on more
>   than just one efi binary).
> * Add a page types for db/dbx signature databases where we can
>   store either the signing key or the authenticode hash of the
>   payload.
>=20
> take care,
>  Gerd
>=20


