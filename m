Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432D3606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bHEj9YEK;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=f9T3EksZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSwcr-0001zU-Nl; Mon, 16 Nov 2026 08:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xSwcL-0001iK-Fc
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:19:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xSwcJ-00085s-JW
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794835166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nbb3H/Ya/DjaODjXZkzGJASO2vA628GoKhhZq7W2CeI=;
 b=bHEj9YEKMt1xBdqV9WZOvLVjHr4uia9UUDbp95/4PRh+pWgQWxtB/Leb7qdjaWaJD6s5FC
 qwl7RpunJs9n9nTb6kSydLSOWcp9JHLz8Qz6YcXD8JdGd0evWi2g5sGmcOB2Pak0AOriSp
 eENruA2mZ3TNzkPOxJSlUhYYfEUz8fg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-NATOeA-DPGOjYUKsPAl79A-1; Mon, 16 Nov 2026 08:19:25 -0500
X-MC-Unique: NATOeA-DPGOjYUKsPAl79A-1
X-Mimecast-MFC-AGG-ID: NATOeA-DPGOjYUKsPAl79A_1794835164
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48c6a1d4034so2289436f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 05:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794835164; x=1795439964; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nbb3H/Ya/DjaODjXZkzGJASO2vA628GoKhhZq7W2CeI=;
 b=f9T3EksZpO7ezhoBofDrPBb0y739Uv+K2htJ7fz7y07OKWb7LDJF35vY/38CzcKeMo
 gFsaALkfDhSoDUJrqFag8zLvwCHQe9PyNbbVYGj8EGbGwe5sYqY7uCTrEBpMKPRr85Rm
 ZBefnHKKued4btwPGjfwaN0zst4fpEdxILnFal3au8Li8jdpAiTKMhNx1Das30Kbld2+
 U9Su08jRLUaYY5cfDqXA4IZhv2yY8lleq8TWtoh7uYN5Azgo0Vz37HJ4Ayf9tA4uw1in
 w9QmfdxGFjQjYQQEBkq3OT1eNp8KZD55O/cCLrNjSmMYFNuQ9YM9Uze7m3SgBAEY7nsd
 TjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835164; x=1795439964;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nbb3H/Ya/DjaODjXZkzGJASO2vA628GoKhhZq7W2CeI=;
 b=Rv+N9Y4aYYk96zMWM/fQ7xJFhUOSQz7gt+5DobP40uMxs7pVPk+iiCMZFr3xQylSnX
 9d7JeUxhJCaoFNhBseZ/Y/plncgIVB5BIy7s/e8jegUYqkPHQAYvT8i2N9G71pRjJ/+a
 2kTo1pogMj1ImNHrH0rpBap0g5EnIZUjLgKjsbycajP8S4KjCJ9V4uwhY0OTL2u/Go5m
 LYL2BsCa9+3eKQt88DfHeJhrlNcG9SkS5nMpLcUD3UYmTiCrBerACgcXb9mhPLiewfbl
 TwoluN67bennaBRQRC7bbsGfRNU+ieoJoq2g3VuPSSSGqVAEIVnW76bGoWWschVFpTV7
 rmcw==
X-Forwarded-Encrypted: i=1;
 AL+hErGUgUblEX5rBdXIINVqNuxbdktMez4rmBT8rc5q4XT7yovqyUXKlrMp8u96S1GACYKaU0q3vr8tcC1A@nongnu.org
X-Gm-Message-State: APuU4Z+x09zfQsWjQDR0P9yXFB7NdvcJqG/W9p53KGnDHu7hcPzKW0tZ
 cONwmR3lcFbhCdwGit8FntEr3coZdUqj32vS4Oy8843hzIZ2FA6+/DMSFhfEkd2QO4wKQeZIscj
 QakuRpPwwf2TU92Qvs9Vq1ws6Uw9cQTXf6wz5QvxvyVVgwBM763djs5Qz
X-Gm-Gg: AZFdTZcWqDq1hlbFE1mjQ9TaRMJJ3vDST94wVw+UZAHZ6L+8zLo9I0Q2YnSsQEWJ/p/
 SfeozDGq/hV6LyAdq4VzVbL1EbcOeAXzIPxLQBtfEDc3ebTgLq1JcNeQj9JQH4DEyA1dvqKxUox
 ataxv3XsVTfN2pf7dYUktFACscHU1oeDVikkFC0BNasfynDxDVtjpfrsGXbvf1O/FE6IM1n/+05
 fij62+HPuwtx70r4hhPt2TekiigyKosDpdS5Fu5ymNnAD6XOmtUB4vuYuyRMj07rzIkPwk6IJ21
 vHkEbZhKdId6H1s9WOLmhyuGPVSQcNTF+6Fo20AvS9uYOxlceflLSeeN6OIr5FpUPihsXW2Dl5G
 mzTP/YhEiwV31wnBZO3RFHSxYuO4CTXQRFV3vH9g4pd0DDw==
X-Received: by 2002:a05:6000:22c6:b0:492:3982:a80c with SMTP id
 ffacd0b85a97d-49c712ac755mr23168685f8f.29.1794835163800; 
 Mon, 16 Nov 2026 05:19:23 -0800 (PST)
X-Received: by 2002:a05:6000:22c6:b0:492:3982:a80c with SMTP id
 ffacd0b85a97d-49c712ac755mr23168638f8f.29.1794835163393; 
 Mon, 16 Nov 2026 05:19:23 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5ff2cd05sm19976604f8f.31.2026.11.16.05.19.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 05:19:22 -0800 (PST)
Message-ID: <6a1faee1-8348-4368-9c98-06b113cf6ea6@redhat.com>
Date: Mon, 16 Nov 2026 14:19:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/26] hw/char: mark common serial / console devices as
 secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
 <20261113184254.2524253-20-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261113184254.2524253-20-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 13.11.26 um 19:42 schrieb Daniel P. Berrangé:
> These are needed as a baseline feature for many virtualization use
> cases on x86, PPC64 and s390x.
> 
> Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com> #sclpconsole(-lm)
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/char/debugcon.c       | 1 +
>   hw/char/sclpconsole-lm.c | 1 +
>   hw/char/sclpconsole.c    | 1 +
>   hw/char/serial-isa.c     | 1 +
>   hw/char/serial-pci.c     | 1 +
>   hw/char/serial.c         | 1 +
>   hw/char/spapr_vty.c      | 1 +
>   7 files changed, 7 insertions(+)
Reviewed-by: Thomas Huth <thuth@redhat.com>


