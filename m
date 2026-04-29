Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B979FFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI0PU-0004R2-Vm; Wed, 29 Apr 2026 04:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wI0PO-0004QD-NA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:36:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wI0PN-0007zQ-8v
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777451796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52gWwmPnwekOSbUdQK4Ka4J854ivbj25GsoneAkk3ck=;
 b=Lq1EmGqikK7dYJDyLu9Xt8orlpFANAXnUQAocWQGQ3Lz3v4OMiV1EZlHl+Pelh66AOiZn6
 StX8br4Fx/5JgSRuGZH28jEFaCjVyuIs2RkclIAebGom8AKimYyOaTRQ9IQPydYheQa2dz
 d7Hg+o0ZT5DMBqoRJ2V+C5C67KipLFM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-2wXAITtJMW22cpE4O41Jiw-1; Wed,
 29 Apr 2026 04:36:33 -0400
X-MC-Unique: 2wXAITtJMW22cpE4O41Jiw-1
X-Mimecast-MFC-AGG-ID: 2wXAITtJMW22cpE4O41Jiw_1777451792
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7CCE195608B; Wed, 29 Apr 2026 08:36:31 +0000 (UTC)
Received: from localhost (unknown [10.44.22.34])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FB861800480; Wed, 29 Apr 2026 08:36:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 4/6] qom/object: add object_class_get_list_by_name_prefix
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Anton Johansson <anjo@rev.ng>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260428234519.1812371-5-pierrick.bouvier@oss.qualcomm.com>
References: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
 <20260428234519.1812371-5-pierrick.bouvier@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 12:36:03 +0400
Message-Id: <177745176385.2166241.2869123011864084966.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1896;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8le0V1VYBSGkxSc1z327vQD0o86nj6zGUQhIvZLAXLo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8cL3fISFygaaUhTUmafMVrbMgCUkwzUHYN24P
 JCbuw5CW7yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafHC9wAKCRDa6OEJdZac
 5VwBD/9BbD7IzBuW1GGmokzEeJYDxD0gWV+Nyt9YvnujHXY3OsHM+YBs1p1iSTWw9KHzphjA6TC
 DxLuizeZdvn0rj1zFay+GU2pwTKiVsTX5i9DNv2KA7w7XshpMh96Cjoknj/UJUYPQ9uBVIHpCD0
 Rs+n6wRu4IyvOtGsIsnVkpS7E/K9nrhc69gSZJwqK1iwOzB4P04cV0WlMAIcWZe9DqaK38+20l2
 H1xqyyQzhKsAIR0UoHZRIdesZcchzt8TTWLQrNNkaqLaXjQlhqdhnOwAdM86WqhWWpU66/Pdzj1
 ZaRhQHdP+A7AGAcZmnpRS5eDgSRmrGvvEvLDFXzrTkTBk4pe2jE6hTdZIhacFbB1sNh6OWzYcK9
 Dig/ygmyzxHBRr/23Y/d8rkoOTSIYJCWIVKgSfJ8YV4C9SL/KIZDcm7afDTMUB25iIFZTj9JuZs
 0pxaiNxcWVsnau62TyPVcf+3cPhxsKkV1lvlY8Tk881H5m5nFIChYWx3RSG6Y+fbkggoNN1VrTe
 pvYknq1WiiRLozdTIsDqzx6JhYVpY48gigDYba78g7gBVNetaYMSc2vWapGd43uB6saxU2m8A9A
 0opoPs5JQ/zw8kOyUBtLfGTVzmTIiUrCOEnOMA4tj8z0ugOpDFoz3Qq/2RGn/zltYYXcKTdsoup
 6lSjwinoMHd5THw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 28 Apr 2026 16:45:17 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 510885218ba..a6d7b3874a7 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1033,6 +1033,19 @@ GSList *object_class_get_list(const char *implements_type,
>  GSList *object_class_get_list_sorted(const char *implements_type,
>                                bool include_abstract);
>  
> +/**
> + * object_class_get_list:

Should be "object_class_get_list_by_name_prefix:".

> + * @name_prefix: Name prefix for type to filter for.
> + * @include_abstract: Whether to include abstract classes.
> + *
> + * To the opposite of object_class_get_list, only matching types are

Suggest "Unlike object_class_get_list,"

>
> diff --git a/qom/object.c b/qom/object.c
> index f981e270440..14527108a2e 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1062,6 +1062,30 @@ static void object_class_foreach_tramp(gpointer key, gpointer value,
>      data->fn(k, data->opaque);
>  }
>  
> +static void object_class_foreach_match_name_prefix(gpointer key, gpointer value,
> +                                                   gpointer opaque)
> +{
> +    OCFData *data = opaque;
> +    TypeImpl *type = value;
> +    ObjectClass *k;
> +
> +    const char *name_prefix = data->implements_type;

Perhaps the "implements_type" field should be renamed.

> [ ... skip 11 lines ... ]
> +    }
> +
> +    data->fn(k, data->opaque);
> +}
> +
>  void object_class_foreach(void (*fn)(ObjectClass *klass, void *opaque),

I wonder if we introduce MODULE_INIT_TARGET_INFO, is this all needed?
since only TargetInfo types would be registered..

Suggest: "Unlike object_class_get_list,"

Suggest: "Unlike object_class_get_list,"

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


