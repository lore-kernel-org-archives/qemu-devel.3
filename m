Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3E3C61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 10:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ1T3-00082r-EP; Fri, 13 Jun 2025 06:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uQ1T0-00082e-8z
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 06:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uQ1Sx-0006ms-P9
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 06:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749809812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=erIZkqETjTGrmHx+fuOarayRy42APKSrEU1DfliGPLE=;
 b=H0CZ+lkuidbLvYKF9Wsf4n1l/0ON0EifcN5N8Zq9wzwZ8+DOLfu3aOcw/XkbcP7Y4JUUcE
 4rx9S0+jfhIG07PWq6S5h6GaewlVXDW44K6Au4p9O3WkKHhEAanzGaqUaNHfnFmFrC6XZJ
 i4eB9LBj2J+coww8BE2msRS62LOJm44=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-K5hpP2YlNFuQrCuO0HxKfA-1; Fri, 13 Jun 2025 06:16:51 -0400
X-MC-Unique: K5hpP2YlNFuQrCuO0HxKfA-1
X-Mimecast-MFC-AGG-ID: K5hpP2YlNFuQrCuO0HxKfA_1749809810
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b2fb347b3e4so1276803a12.3
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 03:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749809810; x=1750414610;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erIZkqETjTGrmHx+fuOarayRy42APKSrEU1DfliGPLE=;
 b=F06F3u+pAgzXw4TyuwFB4M4G5APyTtucWRNUwWXT3Wph3c3cMIF921zslDLVs0XAlU
 1hGgfoOPLVpt8yFnm7CUA5qy08jyac0orNc0mA+CTdqVH/nXOcRXXG0aqNSQ09hhtUvF
 UzS/VLG0YvWL51xvEpnb/3/G9FC7+0gdMjxokRMoAn0ZbstWrYYzMHhtyXUs5PmJcO0n
 rUT6FglAMPZQSLyPPZUuxoSmh7Kzb7f2vinSNeGCCkbUrKddfLMONdFzi0N6FGjdQ3Pn
 U3R4r8I50zoOeeypKZ3Po9zOLTNk0OqTmp9vWu0k5zP45t79KBlHbsLRxaC3vR/Nw2r5
 mqLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoAl0i58pO9m0qHUN486KwcDiEpiliC8VbOi75YnG9zalbJpTMoywPvqVoCPO/I7Smr/0FWqxRRZgh@nongnu.org
X-Gm-Message-State: AOJu0YxmRKFofSqbE042e9gv17hWkpAexmONM4Nqa7v5dx2tk8xHExZF
 gBxegEKk0OKMWGptZs4UseUuRWWXzWZ7zHxSssmyb9Y4AuJCZeKTR0T2QZs63/7GobbvKSBT6bz
 lkmFwbJNw4PDmxH/GFzJ937180+8VWM2OEn3ymR/N44J4Rjlr7pY5KUld
X-Gm-Gg: ASbGncvc6OYkniY6xMimepHIsMeW7WY0iW0pF/y3R6DXOfWtMEoVl8Lpg7DMSmzGHRY
 CeWCd9NKC5PekhIlbjfXisbNK3bVtFDIb30MTS96XjOHch4zZFPXHja9x82cFuuP9ZAAcYzk6B/
 76xFlL8XnhkmPkNCNS4wt9RO4nQ+Di1MfieQVUnLlxJlvS9vPlmbrC/hPfRdgF+4JpsuQFMaIYe
 fRntwKWZr791VBp3Eg+qTjj2nBSM0bS1Ia34/E4NCv5jbef3cuy9XwvxkfrbBwYEcBRwbmpoyo5
 R1hrq2F3ddBzk/BBp9HjUERx1M3AdLPx5ilhfkPD
X-Received: by 2002:a05:6a21:9013:b0:201:8a13:f392 with SMTP id
 adf61e73a8af0-21fad01056cmr3572465637.20.1749809810236; 
 Fri, 13 Jun 2025 03:16:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnjV/wUCRIG4RHR8oq8uzqy/XG1af9+QjQ4mShJKr4qEppZ5aY4bdJomqhKNHjs9uiLJwGSw==
X-Received: by 2002:a05:6a21:9013:b0:201:8a13:f392 with SMTP id
 adf61e73a8af0-21fad01056cmr3572439637.20.1749809809841; 
 Fri, 13 Jun 2025 03:16:49 -0700 (PDT)
Received: from smtpclient.apple ([223.235.162.140])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74890005f47sm1276055b3a.51.2025.06.13.03.16.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Jun 2025 03:16:49 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.4\))
Subject: Re: [PATCH v2] hw/acpi: Fix GPtrArray memory leak in crs_range_merge
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <aEvpxGwmxXrUBVRn@redhat.com>
Date: Fri, 13 Jun 2025 15:46:35 +0530
Cc: Li Zhijian <lizhijian@fujitsu.com>, qemu-devel <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Michael Tsirkin <mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C90068F-D8B6-4CBC-B1F7-2FB381776C3D@redhat.com>
References: <20250613085110.111204-1-lizhijian@fujitsu.com>
 <aEvpxGwmxXrUBVRn@redhat.com>
To: Daniel Berrange <berrange@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 13 Jun 2025, at 2:35=E2=80=AFPM, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Fri, Jun 13, 2025 at 04:51:10PM +0800, Li Zhijian wrote:
>> This leak was detected by the valgrind.
>>=20
>> The crs_range_merge() function unconditionally allocated a GPtrArray
>> 'even when range->len was zero, causing an early return without =
freeing
>> the allocated array. This resulted in a memory leak when an empty =
range
>> was processed.
>>=20
>> Instead of moving the allocation after the check (as previously =
attempted),
>> use g_autoptr for automatic cleanup. This ensures the array is freed =
even
>> on early returns, and also removes the need for the explicit free at =
the
>> end of the function.
>>=20
>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>> ---
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

>=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    =
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            =
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    =
https://www.instagram.com/dberrange :|



