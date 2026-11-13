Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2C2606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YxfsewAv;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Xy5q2dxE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRr8j-00076n-29; Fri, 13 Nov 2026 08:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRr8h-00076M-G6
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 08:16:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRr8f-00066d-RR
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 08:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794575780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxcFGcMzVSHxbZbPFb2IRx5k96Z4j+YtnkDUld+r9pY=;
 b=YxfsewAvB+j4UvT/bGgU/+04mIxfkvOBQqP9ZR+wqZunyGEtArd2hk7Jgfure7AcxWzJs3
 5Nihl1NH32fboNyRNF+AvBMpl1HImWRjEk+uVHvoYMxNnTAjiQypFYuXxN0W3qSsoVAieV
 81yew62XuE9q/UsrSIiGvuv0opfkFWk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-7OlGc6zpPQuxbHi2JHPYkw-1; Fri, 13 Nov 2026 08:16:17 -0500
X-MC-Unique: 7OlGc6zpPQuxbHi2JHPYkw-1
X-Mimecast-MFC-AGG-ID: 7OlGc6zpPQuxbHi2JHPYkw_1794575776
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6b65682a122so1403258a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 05:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794575776; x=1795180576; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wxcFGcMzVSHxbZbPFb2IRx5k96Z4j+YtnkDUld+r9pY=;
 b=Xy5q2dxEI5GncSCLiID+Ls5Glxy2fJp4bQGJgiVoBMF726djTlAwhbfyGAU2iaCCsG
 d2rA7iBP2ejpikesL3nze2ou/ejykrdbpj5LToeAeFxfmn9JTBXEQtABm+OG3vd9QXmA
 vmlMWKdKFM5RKxjKyRbABuu64SeB8V57T3j3hugoGfV4NQmNmZ2nVE0GDNJxSPrQj7JW
 RlJUyLn8SE1qURccVmOdjfyJcpFq6V+J/Syx5vQ40vbaal/cMb5vKxbM7PD1XL5acd8A
 qtnvbhmTpIrILW7q4ecysiLpTGv5eI+C0bwQKLkN58QXOuCo/byC3OFiQh5cKwAbqVK7
 +BpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794575776; x=1795180576;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wxcFGcMzVSHxbZbPFb2IRx5k96Z4j+YtnkDUld+r9pY=;
 b=ctZXIZjjnl8a3axPLSsDR8Upt+5M9uDLBoQmJZ9NWnI0CJ2RMR1aQ449HqoVxS6VVu
 COXCO0Z62bB6ttA/ezy/coIdR/ic6+gUSis4VG4QKRfBZgKuDPxXeljuoEUloQTiQdlY
 Wuy6BB1Wv1cXxIL4FkT3AnWufFNG8iqUJc1nijdt4jvDZ0lliRViDo6oyLmkG6IsO82g
 QIck+AJMMNOcMNh9XdYYcjr7KfrhHeJse4pvGtgXJ+78CVGDxhHQzfdvmapKS49bZuij
 mdpIe89I2LH7nbgxKRY032Zy29+WfIuUL4ZUzcx18bJa85sjc85b8pU/T/5AMLps0P0P
 UOgQ==
X-Gm-Message-State: APuU4Z+vRhYdD/yKTMo/lpvVYXnyCYaZwARiIl5LXGAH8yygUiplyCk0
 apE4kj8h0PQNBJ6HlWDjau/sH1fPzUx4b7YsQ+08Sl8Htw0hNQJ8j6VSumU13k4Vi3JCwjEQPsj
 lmUrC53PE+Kld0g17dEmHZqe1+quhF0LKiKhQEK1FNvZR7CswPJLWNf4z
X-Gm-Gg: AYBFou3lEkpVDO3uEaalXdwolXnzOSWQ+Pngr67X14aDgI++nSdtevTg68+fvng4Sep
 4UdlypkqPovolId7n8h3dcYFDMw29+VHlxVmIJwV8s/VHBRjM/6MPY9BGQoWsmIK9JZUpJfEWKX
 Xl7Upy20bcoK64OGoOkqvnnQOVAJaQ6OaUEyt168iJ7USsg2GMIFBVWbUX6FXUvr+jobUdD68ni
 mxV74dnb04k/y61OgsNkAQeT9N5jHCfxydOqMLDkTQ5ULDpbnAa1+4j5KloH8QS9f888sMTcFfT
 VnzV4few9n+QOrrDIZ/xiZovAzutKDoOeIafK1IXtilPgjD70mUrUi8Ais4YZH+ne3iyUgcZE4N
 2dZp0OH4GI/2x0fPT0GGdXJqXZXiSMjt8oio=
X-Received: by 2002:a05:6402:23d1:b0:6b5:7d7b:8e9b with SMTP id
 4fb4d7f45d1cf-6b7c0d092eamr1901685a12.39.1794575776257; 
 Fri, 13 Nov 2026 05:16:16 -0800 (PST)
X-Received: by 2002:a05:6402:23d1:b0:6b5:7d7b:8e9b with SMTP id
 4fb4d7f45d1cf-6b7c0d092eamr1901654a12.39.1794575775825; 
 Fri, 13 Nov 2026 05:16:15 -0800 (PST)
Received: from localhost ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c605e5b2fsm5435074f8f.40.2026.11.13.05.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 05:16:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 14:16:14 +0100
Message-Id: <DMU40PL5P526.2IC1F99D8AW9@redhat.com>
Subject: Re: [PATCH 4/9] hw/usb/dev-mtp: Handle invalid characters in
 utf16_to_str()
From: "Tommaso Califano" <tcalifano@redhat.com>
To: <marcandre.lureau@redhat.com>, "Tommaso Califano" <tcalifano@redhat.com>
Cc: <qemu-devel@nongnu.org>, "Markus Armbruster" <armbru@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>, "Junjie Cao"
 <junjie.cao@linux.dev>, <qemu-stable@nongnu.org>
X-Mailer: aerc 0.22.0
References: <20261112174907.158825-1-tcalifano@redhat.com>
 <20261112174907.158825-5-tcalifano@redhat.com>
 <179455878072.754321.10848127829960266585.b4-review@b4>
In-Reply-To: <179455878072.754321.10848127829960266585.b4-review@b4>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Nov 13, 2026 at 9:33 AM CET, marcandre.lureau wrote:
>> wcstombs(NULL, wstr, 0) returns (size_t)-1 when the string contains a
>> character that cannot be converted. The return value was not checked, so
>> dlen + 1 wrapped to 0, g_malloc(0) returned NULL, and
>> usb_mtp_write_metadata() dereferenced it in strchr().
>>=20
>> Use size_t, return NULL on conversion failure, and reject the
>> filename in usb_mtp_write_metadata() when that happens.
>>=20
>> Cc: qemu-stable@nongnu.org
>> Fixes: 6de02a13232a ("usb-mtp: fix utf16_to_str")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
>> Suggested-by: Hui Peng <https://gitlab.com/benquike>
>> Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
>> Message-ID: <20261112174907.158825-5-tcalifano@redhat.com>
>> ---
>>  hw/usb/dev-mtp.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
>> index 1a26f681ce5f..7233470558db 100644
>> --- a/hw/usb/dev-mtp.c
>> +++ b/hw/usb/dev-mtp.c
>> @@ -1563,7 +1563,8 @@ static void usb_mtp_cancel_packet(USBDevice *dev, =
USBPacket *p)
>>  static char *utf16_to_str(uint8_t len, uint8_t *str16)
>>  {
>>      wchar_t *wstr =3D g_new0(wchar_t, len + 1);
>> -    int count, dlen;
>> +    int count;
>> +    size_t dlen;
>>      char *dest;
>> =20
>>      for (count =3D 0; count < len; count++) {
>> @@ -1572,9 +1573,13 @@ static char *utf16_to_str(uint8_t len, uint8_t *s=
tr16)
>>      }
>>      wstr[count] =3D 0;
>> =20
>> -    dlen =3D wcstombs(NULL, wstr, 0) + 1;
>> -    dest =3D g_malloc(dlen);
>> -    wcstombs(dest, wstr, dlen);
>> +    dlen =3D wcstombs(NULL, wstr, 0);
>
> Can we replace this function with g_utf16_to_utf8() which is not
> sensible to locale. If not, a comment could be useful.

Sure. I wasn=E2=80=99t aware of that function, but it does seem like a perf=
ect
fit. Thanks!

Thanks,
Tommaso


