Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53771C61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 20:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNdpk-00062B-HC; Fri, 06 Jun 2025 16:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNdpe-00061j-98
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 16:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNdpc-0005OG-Ln
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 16:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749242306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2cEaHHF39zwOaGSf8oP9Urzl+JS+gL8hfVK/Xc7PD+4=;
 b=eK3si5T/7uWmyt3Y+j5Kpycxkujhw8/S7PvcAdtt78taZ20hgk3V6EJv0IPpa6SnigY9j9
 PkJbTKeL88IcCZ5DnGQomKQM5P7mAbwoMcJjEkLwO1wMf1SOtT503o2+/wW6v/x4hxMRjI
 RIzLSugjDUjEiYcm/vvQd2KXUNCpJak=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-k3FZIA6GNGWAgMBjur4ZZA-1; Fri, 06 Jun 2025 16:38:25 -0400
X-MC-Unique: k3FZIA6GNGWAgMBjur4ZZA-1
X-Mimecast-MFC-AGG-ID: k3FZIA6GNGWAgMBjur4ZZA_1749242304
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4eec544c6so1264971f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 13:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749242304; x=1749847104;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2cEaHHF39zwOaGSf8oP9Urzl+JS+gL8hfVK/Xc7PD+4=;
 b=Ene+EB0eCmchmyIzfLq0Pk9luoI/e5nTATscCUNVFynrCbZAffVAw4W3rXZp2tIzdL
 ZYYfTyWRGFYjKmAcx58Gf9hFT5eux5GWbniihj8+vxNL1dcrzT4CaTAKS/0X6uZEkaiI
 NE6Ti9/cTERP80JGc2HE5xT1M9tMJmUvCsevbTSN1ZB0ScQHBzPOVRkQDHTZXFS0wLBP
 G7IBYOhGUZ2G690HHALz6YpJTMMb9LNUCqKx/hr7YjJFLCP4f92Kezrdyxt/cQJLPlZO
 8yP33ZEmwnG8Ov3v6/vMyKLU2CT1U16Xtan+LiQ7/3LbBz5o2nxkwwcEAnvr5VRBzGNd
 GKvA==
X-Gm-Message-State: AOJu0YyAIN8eGirAiw6W/GbRnYk2hcr7Hljl0eOBrJIbZksenrCYj5xo
 3+E+urK2wuU5pXDJ7png0WhYwiOqRTXw2uN73X9au8mdNicKGbgSBVmlMb2T4rkmXUFmJqtWzIh
 RGaZgzuYLbDiFBHaf3KbB2BPFAQhJCAHpTbSj5/Loyx3JtgnN40YPEdJjg/NC+XkECqPdWX3QMo
 drlzcRkh7UamLvp4GAVNnfCty3/RDKXQQ=
X-Gm-Gg: ASbGnctQ1mHtYoMoagcQvT7UD2IUnDh7SYGO0ku9m80+n08deyqmqDqkEEALzMTgusM
 mjW8Y5Y3keMgHg30ITFsHthHx0KKNprtdQGPN3OapsV8PWl4iN9Qr+Am58exMYfsZo0dNkPla3o
 dwmw==
X-Received: by 2002:a05:6000:3110:b0:3a4:e002:5f97 with SMTP id
 ffacd0b85a97d-3a5319b4c50mr4028737f8f.1.1749242304391; 
 Fri, 06 Jun 2025 13:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRyXt5rWxjHsvtIWzLRYBIq4BveHy9Qsa73+yCDBaN9HHU8oNJkyU4RXHaWlIrNY+J1MCgaF1kko3+D8zce5k=
X-Received: by 2002:a05:6000:3110:b0:3a4:e002:5f97 with SMTP id
 ffacd0b85a97d-3a5319b4c50mr4028719f8f.1.1749242304011; Fri, 06 Jun 2025
 13:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250605132427.404551-1-pbonzini@redhat.com>
 <b41eb6f4-96b8-47bf-90cf-e4918a613dcf@daynix.com>
In-Reply-To: <b41eb6f4-96b8-47bf-90cf-e4918a613dcf@daynix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 6 Jun 2025 22:38:12 +0200
X-Gm-Features: AX0GCFve54j8UsQtotGRBeyIIQJBVAk_ayq4bXMXKOI3udX0_3BHmiI9rEzzl-E
Message-ID: <CABgObfYZ2mH5ogfjPG3Xmp7jpay7CPHh7L=phSTXzT344VWhgA@mail.gmail.com>
Subject: Re: [PATCH v5 00/13] Improve futex usage
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, devel@daynix.com, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Fri, Jun 6, 2025 at 11:46=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
> This conditional is unnecessary; docs/about/build-platforms.rst says we
> only supports MinGW.
>
> I failed to catch this problem because I ran MinGW on Windows, which is
> case-insensitive. Since it is case-insensitive, the lowercase name will
> work for the OS too.

Possibly, but better safe than sorry... The official name is the uppercase =
one.

Paolo


