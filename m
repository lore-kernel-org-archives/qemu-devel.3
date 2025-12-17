Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CBFD6552B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 09:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVoIw-0002UG-A5; Wed, 17 Dec 2025 04:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ftyghome@gmail.com>)
 id 1vVmuV-0004kt-Tl
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 03:29:27 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ftyghome@gmail.com>)
 id 1vVmuU-0003Lw-Df
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 03:29:27 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-bddba676613so4020919a12.2
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 00:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765960165; x=1766564965; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rpgGzsQwkP/V40oPcXipiJ6+ToLxsTnhovHkKKGAa3k=;
 b=hsohHSAT7iOWNh3zWK9gtQsUdzX365yxvMH/nROcGRXDwmNt906+TT711oVtayCtRO
 r9/8/tgBiSLRi+sjoN8ucC+j/bgStd6Id/BtefQ/FiI359gE+VUOc7t3b1OIiiJh7G5v
 py7RnupTc+3ws0rQB9E0sBpRBTPiMLmzJp4cYsGFLLg2Dn8YECujO70+HJqHgwovOF3J
 7pCZD6MlDiUc9byJXRHtBJU54uX5U8kU/dNPqW4x6/ayNjExqFbd+NanZGhdpW3dkSQj
 suBqobk5CQw8OVyggceSSiOD1WUOL2LMJSlCXy71A1p+Gg5l4cCdShoh+cPjM0wiuQUu
 +Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765960165; x=1766564965;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rpgGzsQwkP/V40oPcXipiJ6+ToLxsTnhovHkKKGAa3k=;
 b=RLHsp3qFbeVXRrye2g/Qpfk61J6Hs0dNydauyXRRp1vX0WTg6zwzXLkB1cJev87bn1
 jf16jNWl+Yr4FFDwyMyIt77Oc6o2CX9VMy6EoddF7Q0PgVo6bth+4dK6DS+4vABmalLu
 NQHzeKzlpFs3Qp6gmXi4CnlMPrsoD0wyxawSzy3o1ZX3Qpn6FvUUhViNhC9KkyqjiRcR
 xS62oCvDR0oyDHCBdqINmw6tY9BmgD4JQ48FB3xGIMCgFfq+EkFEbvTRHNDCUmWBaUv/
 Vytv3JU2Os4NWOIVM4SZVOXu4WQ+rKHUX/Hql659e7eqa9CGFBCBDjzES3kSIRjjRCfR
 5N9w==
X-Gm-Message-State: AOJu0YwDjEHIzFvdTLo9YkRGTV7jBaAeJsNcfNEIVAZG1utibGtNj+ce
 hJKILG6HlVZhfcHXj3j1Xrv3ejYrbUBBwRCl1XGbeyRwMA2/+a/A0Kdv
X-Gm-Gg: AY/fxX5dmo8o85jnA7rAlc+LF/cep6s38OF0BvW57Bjhrol36z8ACcc4NgrwEwuO9aR
 +7L88jgrhwGneYGmNtSp0LnnEIYW1KmSbZ9Zjs2IS/kgekiTi/ayQuohllP/hem4XmtCOeNNr6P
 y84lXSzGvqG0UY6/2bperFCaAAg3RgOSf4lASdjHWPe+eazgEShlH65k46LIL8PCm2wkzRkWAcy
 fLL6Juh52RHX/a8UTNFdq/T37j24dynIz38J5nXs/H2cJURm6qTs2mejUKzxpyizNhFdH3HuA1T
 B7ggoy2HSveTF6Wnuct6lviF6kpZBcWtpn3FOyj2z0y9uv6yt7tGi3Iz1Mq6dpAOESBTGI26sfq
 vaiey0R5x1CgEG+xVxws2O0Wr7Cgj4T8r7FPlIYQu8Hnhf/jhi8lL2nxmt3r3UCmL4Wuoebtz1f
 e1yb4IKAj6g13OOg==
X-Google-Smtp-Source: AGHT+IGWejYqgPbG3dcwQ6g+BCJ2vmm4PVmRvsaMTwwwOia+UQj58mCAd6z2rfd6A+AUTO4vaTktMA==
X-Received: by 2002:a05:7022:1b0c:b0:11b:ceee:a49f with SMTP id
 a92af1059eb24-11f349a17bdmr11846021c88.8.1765960164286; 
 Wed, 17 Dec 2025 00:29:24 -0800 (PST)
Received: from smtpclient.apple ([38.207.158.2])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11f2e30497fsm60950284c88.15.2025.12.17.00.29.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Dec 2025 00:29:23 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.3\))
Subject: Re: [PATCH] qdev: fix error handling in set_uint64_checkmask
From: Zesen Liu <ftyghome@gmail.com>
In-Reply-To: <877bulo6uf.fsf@pond.sub.org>
Date: Wed, 17 Dec 2025 16:29:10 +0800
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C473C747-650C-49CD-ACFB-A6802677D9D9@gmail.com>
References: <20251217-qdev-fix-v1-1-bd33ea463220@gmail.com>
 <877bulo6uf.fsf@pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.3)
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=ftyghome@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Dec 2025 04:58:03 -0500
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

Thanks for the review and for updating the tags. :)

> On Dec 17, 2025, at 16:22, Markus Armbruster <armbru@redhat.com> =
wrote:
>=20
> Zesen Liu <ftyghome@gmail.com> writes:
>=20
>> When specifying lbr_fmt=3DVALUE in cpu options with an invalid VALUE, =
error_setg() gets triggered twice, causing an assertion failure in =
error_setv() which requires *errp to be NULL, preventing meaningful =
error messages from being displayed.
>>=20
>> Fix this by checking visit_type_uint64()'s return value and returning =
early on failure, consistent with other property setters like =
set_string().
>>=20
>=20
> Let's add
>=20
>  Fixes: 18c22d7112a7 (qdev-properties: Add a new macro with bitmask =
check for uint64_t property)
>  Cc: qemu-stable@nongnu.org
>=20
>> Signed-off-by: Zesen Liu <ftyghome@gmail.com>
>> ---
>> hw/core/qdev-properties.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>> index 422a486969..0930d64252 100644
>> --- a/hw/core/qdev-properties.c
>> +++ b/hw/core/qdev-properties.c
>> @@ -494,7 +494,9 @@ static void set_uint64_checkmask(Object *obj, =
Visitor *v, const char *name,
>>     const Property *prop =3D opaque;
>>     uint64_t *ptr =3D object_field_prop_ptr(obj, prop);
>>=20
>> -    visit_type_uint64(v, name, ptr, errp);
>> +    if (!visit_type_uint64(v, name, ptr, errp)) {
>> +        return;
>> +    }
>>     if (*ptr & ~prop->bitmask) {
>>         error_setg(errp, "Property value for '%s' has bits outside =
mask '0x%" PRIx64 "'",
>>                    name, prop->bitmask);
>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>=20
> We haven't tagged rc4.  I'll post a PR right away, so we have a chance
> to get this fix into 10.2.
>=20


