Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333B7606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TW2FpnL7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNnjO-0003lp-0q; Mon, 02 Nov 2026 03:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xNnjH-0003lN-Mz
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 03:49:24 -0500
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xNnjE-0006Mf-PF
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 03:49:22 -0500
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-36a1947498bso767545eec.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 00:49:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793609357; cv=none;
 d=google.com; s=arc-20260327;
 b=Y909Y+k3nOK3tG0Lu2kfpFZdpjFoab95UsQWMMqSChN9gnB6GOq5PRvdgm8oLLByy4
 t7d1ra54cBf1oGpe1V7qd0rd+xhMHKlsFhanta3vv4faWtcDp329w8AAXLlBX/YwwSay
 pAEye044Fr/y6Xh7+oww+1OXXypdBD/0fAWkE+8gpbVOdicWUVY6pRzAJfjI4hPLoXja
 xVLB5GZm7lZlNAoBToZSC+/nLF/s1pEeyoeyS7+ARiquCF9f9uD3IT1P/rN0/MMJxSlR
 9B61zflN+1yXQ1zk2omUMWhsta0W4OTZKcrG2d0G4a1QWKHOq33ZxpPiDrPgK/b5dBzF
 1img==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Uyc8qxIX9A1yCH7rHNFkAtmiQKrDVxBPIQMXan2tnhw=;
 fh=ouvYxzE8zeNcUhxOzySM2B4B2JfIaNKS3rgo8mZw+iY=;
 b=JKsCBy0vORewUdt2PqpGgU+rGTs84ZFwWB3ZIMu/zxwwneTN81NcVD8vnsnMLz6xpB
 WbX8pp+iroYOTpXk8LOY1OjS12jWujM7RBhUYrSAu2X5gAc4RzyWlJ6ukZpLnwnHJOeF
 Cktc8RiLu0etUYdA8wMwN184H8hP8JLISc7Uur8cxRyRXj03/rrjyNH1dY3vysFRACId
 RnBdd8vaT15DyB6TAROm6CirRBcZRtixw8dQgvaE902+ZzdfrzlyCA+tILJqXM/sPZWk
 Uewf2DOOCJlC6SwId0yR7tmaEekCcc17HOd+iv/7mDev8Q4QI+3r1CDTUsaQOIU6WDzp
 mcSA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793609357; x=1794214157; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Uyc8qxIX9A1yCH7rHNFkAtmiQKrDVxBPIQMXan2tnhw=;
 b=TW2FpnL7mgAWPMsQNKgUq4SXytWEVIEQ57oW2bPe8VZ4gGFxl9at4D3jmtvVyHYD9m
 57mAEeeIISFxcnlM8sIPQQZzCkyXVmdLkx8QhDWjqSa13UN/wa3LtC2rWF5ldx/dqlY0
 Rzd2cUj3ns9gtttmICtYUqdwvK7xHLDE2e2z5AI6a7ZA7Nk7sPicVjtDtAcebVjgYdqA
 HfBx0/KPHAr7CzXuqZkbWUZ+4rJctUQARJbQACsCsCWxht36TLJIw+BOHNV5G3or2Qb7
 WWnOINUWeln+/NgIIihY58ScXr5T5jpo/ZXmoRSNwnrSkpllltY3jOXurJConmsHHWhv
 iwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793609357; x=1794214157;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uyc8qxIX9A1yCH7rHNFkAtmiQKrDVxBPIQMXan2tnhw=;
 b=PwuSKI7aXj/qH6nPSEI+Io8DaqtUhP0KVH3H7PVwKOquB68miEKCZCTmnk3MspbPKz
 x3+G2hoL1JnZdaSfoMU4esPuoZ/NjPM6FrAT55M5lmwQvOWLMO2ZrIltbcgkAo1oh/+/
 aMQhmKlaBRNnZNrI4REDi70Gu8C0wUi1W5+OYlbuZB56ar0g0hUZ6Jui9Jcld6La0Dam
 JLV6LQ2a5rpuZ4cLA1EOl8QneFe4yPxeEsh0VIFzO7nBtHE4YX+ub0Hj0KHZ1e6VzmaE
 x/pP5Z/xpHR1RXvOH0VkwtS184UlST1ZgzCECUsiMGoGJscBoktYSL4VfrVphYBWtBPg
 SNJQ==
X-Gm-Message-State: AFq9FYKKwzvbCNtc6/YoB3Jf7Ys4lNdwmOkTsSQYQcOS9EGYdCN4OUuk
 mhhBGwwI814fQOnvE6VX/9blo5Rz8ISpPWDaUdyDU4c4B61cBAPujoFqj3QkhTcfBXYTq98IayC
 nZSRdqRBqB75KVT+jWKjtIeyK8qX+ovQ=
X-Gm-Gg: AYBFou3r7YKUEI/ksJ42CO4l+GkLQlWv3dNYmkEie9n8x0FPp+ntAxBoKJsiAJ2+PJQ
 NOzEnYI+meMHNjIXMfaGReeHiUQw4Z9tNqm5u16iadPdjz8LMCjWhFExpkwkymVZ/lSLbU7XMCT
 p5iE3AbqBjRRLlTI5kK9kuFi89yUwocljr4vvxWFEEazB2EHKkXSzEWw6/wAezXe4pwnkmALjBt
 R6/RBHLx2CUAQDLjrQg6Bll9HYcCYNig4VcZN46O349yl93A8ag7H7OC7Ab7B4ayWarAm5xPHOY
 bvgxS+M8aazFLbtHep9TOm/qB8tpCnDMDKoRPrjb2PLuzoQvvtqdQ0qKNyufqXPQ4p/2KURFp82
 GE9Scg68BoayKgbCy07D/C70t3x1CEwejbAv8JUx9FzJVtq7IUCjO7PQFyKO3g9amuAem
X-Received: by 2002:a05:693c:6092:b0:369:f3b8:2c54 with SMTP id
 5a478bee46e88-36a423f0f70mr15916289eec.30.1793609356813; Mon, 02 Nov 2026
 00:49:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101201717.3911097-1-armbru@redhat.com>
 <20261101201717.3911097-15-armbru@redhat.com>
 <179359759593.3177668.4375922821610706196.b4-review@b4>
 <8733tjvgb3.fsf@pond.sub.org> <87ld7bsk50.fsf@pond.sub.org>
In-Reply-To: <87ld7bsk50.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 2 Nov 2026 12:49:04 +0400
X-Gm-Features: AclHuK-2yhvr52xygWmBHAy_m2qwtIhZIaXRkYI3RNvHnyF-r7vGg7LFt_ly7mI
Message-ID: <CAJ+F1CLedXx_ciowZMnKmEThLAuKOO8tcV91E8P6yKs3_XqW_Q@mail.gmail.com>
Subject: Re: [PATCH v8 14/56] qom: New object_property_add() etc. parameter
 @qapi_type
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 12:40=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Marc-Andr=C3=A9, may I have your R-by with the appended fixup?
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 9338f0b986..70d8ea3e29 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1189,7 +1189,7 @@ void object_unref(void *obj);
>   */
>  ObjectProperty *object_property_try_add(Object *obj, const char *name,
>                                          const char *type,
> -                                        QAPITypeInfo *qapi_type,
> +                                        const QAPITypeInfo *qapi_type,
>                                          ObjectPropertyAccessor *get,
>                                          ObjectPropertyAccessor *set,
>                                          ObjectPropertyRelease *release,
> diff --git a/qom/object.c b/qom/object.c
> index f244bff6ae..cd0590c3fd 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1340,7 +1340,7 @@ void object_unref(void *objptr)
>
>  ObjectProperty *
>  object_property_try_add(Object *obj, const char *name, const char *type,
> -                        QAPITypeInfo *qapi_type,
> +                        const QAPITypeInfo *qapi_type,
>                          ObjectPropertyAccessor *get,
>                          ObjectPropertyAccessor *set,
>                          ObjectPropertyRelease *release,
> @@ -1358,7 +1358,7 @@ object_property_try_add(Object *obj, const char *na=
me, const char *type,
>          for (i =3D 0; i < INT16_MAX; ++i) {
>              char *full_name =3D g_strdup_printf("%s[%d]", name_no_array,=
 i);
>
> -            ret =3D object_property_try_add(obj, full_name, type, NULL,
> +            ret =3D object_property_try_add(obj, full_name, type, qapi_t=
ype,
>                                            get, set, release, opaque, NUL=
L);
>              g_free(full_name);
>              if (ret) {
> @@ -1401,8 +1401,8 @@ object_property_add(Object *obj, const char *name, =
const char *type,
>                      ObjectPropertyRelease *release,
>                      void *opaque)
>  {
> -    return object_property_try_add(obj, name, type, NULL, get, set, rele=
ase,
> -                                   opaque, &error_abort);
> +    return object_property_try_add(obj, name, type, qapi_type,
> +                                   get, set, release, opaque, &error_abo=
rt);
>  }
>
>  ObjectProperty *

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

