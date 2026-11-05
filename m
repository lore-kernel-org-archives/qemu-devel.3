Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A2E606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EIE4F7KC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOwFZ-0000J3-Ja; Thu, 05 Nov 2026 07:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xOwFX-0000Ip-PG
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:07:23 -0500
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xOwFV-0000Ep-OL
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:07:23 -0500
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-36a1947498bso5030966eec.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 04:07:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793880439; cv=none;
 d=google.com; s=arc-20260327;
 b=PiiNhNPzJpy5p+icOGsjKP41OgOWOT29sy+f/5px5RQQNJ7xD7x5wxnOs1ZFDYiNRi
 v0vr3B5SejKb1oQhzI7qQ8An2t6rnjrhkaK6AOoIdjpCetZT0RmeMTO2ICNgZSAdDbCj
 4g9kFWYQNRIbX+DN2QUvdCZV1O9jnCrq+yJj4OBIu0o4J5qLwcUiXOo8zp/lEQTctHj5
 Z5d+JTsMqBGw9ryuPmMZ2XYWKBrLW2WECv54hBrhqNgR/3LADMMd4JKKshrCn4fN5nVm
 gbSz+ou8jefq5p15gKFxcOcUPoFLqxLImcbKueRzar+phjbH9YxC8+fCFq8SRpC8CmBa
 H6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4/eomsD7v1iprj8WZ3te3V71u9E7lWBiN6w2Xe1hLgo=;
 fh=ouvYxzE8zeNcUhxOzySM2B4B2JfIaNKS3rgo8mZw+iY=;
 b=X4XmaE7lyfcnojticc8Ve0rgVdczyolFWCqb1qMfaZrkDrDR7bKnKvBqKxRvzL+aEu
 ltPcgje2TbkkzXZ7HnLpTK+5FgXSBtlk4X/S8bchTjaddnD9sStUHZFUELiIrtv1fcxM
 b7B6efahC3IEO9yopLzgSvKIbDlNgvAAu9h2JRca375+1EIdXACOrGoQFTvMnWHNMH3b
 +XeCeYnFunKtVvWcKb3LB2VSuVtMEz6729z3p7qdnnep7boFPjaqcdOEa+xYoxg/GJP1
 ERXKI08VbjAnwLWpHAH2AyTpWjHkQOvew1PHnt2Qr54bHpmxEeZkcavHHdgAG5dJ0c3p
 0EEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793880439; x=1794485239; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4/eomsD7v1iprj8WZ3te3V71u9E7lWBiN6w2Xe1hLgo=;
 b=EIE4F7KCmOS39WrOY4rH0vHb8Mx0FkvgHsZfluOr5OeuZuFYk2/xAD58k8PzPRqA3t
 tXB1f5OpKa0DQRITlvSq/iRsXrGgWTnqlGx07zPw+HKOT7sEr/h0uE1HGveAVcHUYq6g
 6tJWnLwmOaH4wxwzmyLshoH6GUkekW/0YJTeVff1Zub0o69bEGQoD+T8K5WVrrMyKjor
 Arw9l1g5US93ZGwqxY53zAbkKIBmOyTYgrMHMysx4cDQEZVHYNklmp399ZVl6QS9bUI/
 OHS5KDHk8KovSpB/MXXVYZx05R21nyKfZhlI6OvOi3iLWBHHA06L5T6h3U5DYa3Y3QyT
 MJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793880439; x=1794485239;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4/eomsD7v1iprj8WZ3te3V71u9E7lWBiN6w2Xe1hLgo=;
 b=TXn7Kipf9aviNgUYTuXDsQSwC2mCmQDn2D12ncuNiqh8Td5+nXD8uYl+zECkp858Js
 rtAXu3JGOLtfAdYd8E6heG59pUY0MiJgJQ1wwBL6fOgYZD4uNOIM65w5tCMVGlC4tG6W
 1fKDgX85fKTMo9TbokIfrCCt2n98WrJsqnDSRRKEaJRle3Yd793u42johUD6rysl3lnv
 P98x8NMsUVITQ4ulIqaDvWESYPZhko6Jkx8FDSZEokqrXTVEKdHCq+GU9NQNdlxz79uC
 xW7hOekPb4aO1lJORRExq91HcewXpfC5c7nVD74uH/Q1ZghtNcm0j72fZ5EEFsYsAN9D
 oUog==
X-Gm-Message-State: APuU4Z9dbL7v5QUdcFnP6n0pLVuLUNg6e2ZQg/27dvN22G6Jj7YkZcaY
 qkf0yL6KJ3n9pWBhofa5bS3GOKzfnMHF9EWokbkvi7Oq1gsfLqMC3NfXTAShK2i5rJLPEnOYsaQ
 mtS4BG4VCXBCs8Nlh14Lqm7JRwpz5aEE=
X-Gm-Gg: AYBFou1nS48NgqH+BMBlLWcFwhIWfNOrUEERPAenmB4CzJfygpMzyzhpmZzfUHUirXj
 L6sjzx6Lket6nocgA7v2WEFeVKoC3KCrmGi5I9xQo7mjCfbjjXHwf2p/isPItj7zuXE473P3Cu5
 VjhoNc+dK0ikfuWy/dLIrAB9CtpFLZQ4+mCZMiagFq1gXHWD78V5arHt0QYOOs30pHQdip4JqL+
 KqKgiC8bj5jbN4fCh6jsydnckmYA9yT+mwkTXAlP+EXVeqO7OM0xFqBGxB9r4Frpk1FmON8zOCy
 Mr+t7Rl7EcRFk9n4HyU3n06NEGv94HbiazCq0E7dp0bll8paH+ftDyJhOVen2aON2wGpw2TS6gw
 sB7aPYf7OfStahcnjZnKQIcsrJGrGYYflys9xC0SnrB/ZrDRuNKAvGZRonAAHZ81hHdv7
X-Received: by 2002:a05:7300:7a8d:b0:369:fe4c:b48f with SMTP id
 5a478bee46e88-36a420583a6mr23668633eec.0.1793880439150; Thu, 05 Nov 2026
 04:07:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105102530.1848823-1-armbru@redhat.com>
 <20261105102530.1848823-4-armbru@redhat.com>
In-Reply-To: <20261105102530.1848823-4-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 5 Nov 2026 16:07:05 +0400
X-Gm-Features: AclHuK8bAymtHvsmqTklzbThTwLoxNoX5mWCTvwo9lwUPAsyAmWuuwdS7JLHL7A
Message-ID: <CAJ+F1CJWEF4riNzmgFpQjDo5bXF+pNTW7A-WKhwdRL3xQ3FDZQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] qapi/qom: Make @qapi-type mandatory in output of
 qom-list etc.
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

On Thu, Nov 5, 2026 at 2:27=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Commit 0eee31cf108 (qapi/qom: add qapi-type to qom-list,
> qom-list-properties, qom-list-get) had to make @qapi-type optional to
> enable incremental conversion to QAPI-aware property registration.
> This conversion is now complete: @qapi-type is always present.  Make
> it mandatory.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  qapi/qom.json | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 32a5926936..cc642c7ba9 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -36,8 +36,7 @@
>  #        graph.
>  #
>  # @qapi-type: the name of the property's type as it appears in the
> -#     output of ``query-qmp-schema``.  Absent if the type does not
> -#     occur there.  (since 11.2)
> +#     output of ``query-qmp-schema``.  (since 11.2)
>  #
>  # @description: if specified, the description of the property.
>  #
> @@ -52,7 +51,7 @@
>  { 'struct': 'ObjectPropertyInfo',
>    'data': { 'name': 'str',
>              'type': 'str',
> -            '*qapi-type': { 'type': 'str', 'features': [ 'unstable' ] },
> +            'qapi-type': { 'type': 'str', 'features': [ 'unstable' ] },
>              '*description': 'str',
>              '*default-value': 'any' } }
>
> @@ -65,8 +64,7 @@
>  #     `ObjectPropertyInfo`.
>  #
>  # @qapi-type: the name of the property's type as it appears in the
> -#     output of ``query-qmp-schema``.  Absent if the type does not
> -#     occur there.  (since 11.2)
> +#     output of ``query-qmp-schema``.  (since 11.2)
>  #
>  # @value: the value of the property.  Absent when the property cannot
>  #     be read.
> @@ -80,7 +78,7 @@
>  { 'struct': 'ObjectPropertyValue',
>    'data': { 'name': 'str',
>              'type': 'str',
> -            '*qapi-type': { 'type': 'str', 'features': [ 'unstable' ] },
> +            'qapi-type': { 'type': 'str', 'features': [ 'unstable' ] },
>              '*value': 'any' } }
>
>  ##
> --
> 2.55.0
>
>

