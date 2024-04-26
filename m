Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD82C19F4F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 13:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0LKG-00063J-TZ; Fri, 26 Apr 2024 09:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s0LKF-00062k-Er
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:09:15 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s0LKD-0000Lm-Pm
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:09:15 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a58872c07d8so584192466b.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 06:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714136952; x=1714741752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91IgtVUDnXBK5WysQZanFK5Z68XuoGIH0YOefggoZ3s=;
 b=LB4TOaRPY8OffY18HX6BJ4chWiszPI0CZtA0Ogl7Pfchj2QYQgXbZOgl6VRToAdRYh
 1z9jve2+Liymje0X3Zbnu3kH/oJRybTj9nDB7sbeDzf+kRWjhiv8TDbKV8+d2AH0t3Ld
 zeKpAg8E1nQUWNaHhzJol4iuVG1gxGRDM3LBr+JJ4Xb0ZSi594gkxZvnqHHWm3MNje46
 /tl+ocaJI9GVk7ZonIaxzCNZipngpGeyv+UYh/A71rpifb+41Bo1uoyGKNwhSkgfsFXv
 RblBhDagrppB2avbl7uki7Vlj9M87xvij6niZYsvPDFCE4PhmM68IwijKOALx+yLUBBL
 oOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714136952; x=1714741752;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91IgtVUDnXBK5WysQZanFK5Z68XuoGIH0YOefggoZ3s=;
 b=Vzz78J4ckbETOiPLzSbjFCDy95c+srfZp+CtmMznSrZY3fYA+Quqx9miv5N/FBFEME
 UKGNf17S3r/WilDkOvakTqe5z2BAr8fRW9aHMpjda/+h1YPGoTISc0oVl0thjBj1Ko7Q
 lOcW6KoQ9vYGEI//ssd5oGtl4FfDU/qhwz3INKeaexAozmTYCzaBjWdzGL1a+sAB0as3
 Z5LeXIiSZx0oKTO1iB8RNyfQMiyts27OT9Irx2VMQ2s1KEeA0JMCU2epTTvu1+T3Riz3
 /IlGlOvsT0iNXqaw83VOn3om34PV9F6cIJEj/VBVmFuizU2rh4QRZmR/IQTPldus6SLy
 zu0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO/CP5fWlhaMW2/9LjowzGnqKTqzK9JpwkUjlV7zn1XPZq+o49ocgLs6KH9WWJ93WGcjOcZzOMlRpqGSVv85yBE45VOUA=
X-Gm-Message-State: AOJu0YzvI7EIrSSwIsRh9GGBVsvlw34JrVyLeCnpwtCX+YX2MTK1rBVh
 GbSuTDU8mG5XTGN3zxLZDvX+gnf3KZTYOfbyGHc0rKvFdfCDxkTE
X-Google-Smtp-Source: AGHT+IGfAfvY9VJk61m3zYhu63EnEn2Ot8kxLnFzKnqifPUkO+u46IOwK+m3MT2YxHLqNojK3VhWSA==
X-Received: by 2002:a17:906:a293:b0:a58:8602:ffa1 with SMTP id
 i19-20020a170906a29300b00a588602ffa1mr2162462ejz.19.1714136951999; 
 Fri, 26 Apr 2024 06:09:11 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-014-131-109.89.14.pool.telefonica.de.
 [89.14.131.109]) by smtp.gmail.com with ESMTPSA id
 am19-20020a170906569300b00a55bce09954sm5611759ejc.34.2024.04.26.06.09.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 06:09:11 -0700 (PDT)
Date: Fri, 26 Apr 2024 13:09:10 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 0/4] X86: Alias isa-bios area and clean up
In-Reply-To: <4362d061-599a-49bd-aa52-1d440c0eb621@linaro.org>
References: <20240422200625.2768-1-shentey@gmail.com>
 <4362d061-599a-49bd-aa52-1d440c0eb621@linaro.org>
Message-ID: <F1310F4F-63C3-4A7F-983A-6B515D21FEB8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 25=2E April 2024 08:07:43 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <ph=
ilmd@linaro=2Eorg>:
>On 22/4/24 22:06, Bernhard Beschow wrote:
>> This series changes the "isa-bios" MemoryRegion to be an alias rather t=
han a
>> copy in the pflash case=2E This fixes issuing pflash commands in the is=
a-bios
>> region which matches real hardware and which some real-world legacy bio=
ses I'm
>> running rely on=2E Furthermore, aliasing in the isa-bios area is alread=
y the
>> current behavior in the bios (a=2Ek=2Ea=2E ROM) case, so this series co=
nsolidates
>> behavior=2E
>
>
>> Bernhard Beschow (4):
>>    hw/i386/pc_sysfw: Remove unused parameter from pc_isa_bios_init()
>
>To reduce respin churn, I'm queuing the first patch via hw-misc=2E

Nice!

