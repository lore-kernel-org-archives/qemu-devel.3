Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F12EDA6AE
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 16:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxT3a-0007fN-TC; Tue, 03 Mar 2026 11:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxT3Y-0007f7-NP
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:57:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxT3W-0001f1-3P
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772557027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kyxRRsx7YBxPySu3vdb3mmraSeCnrpXZyYi+7K8ETcc=;
 b=go7xwLPFpDosNSxsktRFGOL+/hQbHa74nHVEaDHmwPK1MsunWjAvITh+Xs+wjhyZkAFRyo
 jfTRN8zz68Mr4pcqNZ+W1J9Di3UIVNX7++a6CjIr3qlp2lNYCafAyqmkhyOUUysipxEQjd
 +Vf6Ug57PsKT6m+04HvErumJMVq4ZJQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-GEiYWHQTM_-ZxLE99ndLCA-1; Tue, 03 Mar 2026 11:57:06 -0500
X-MC-Unique: GEiYWHQTM_-ZxLE99ndLCA-1
X-Mimecast-MFC-AGG-ID: GEiYWHQTM_-ZxLE99ndLCA_1772557026
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-899f757514bso155687746d6.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 08:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772557026; x=1773161826; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kyxRRsx7YBxPySu3vdb3mmraSeCnrpXZyYi+7K8ETcc=;
 b=NtEMldcen/WsL9rkiC+5AUbNQMzONj5gY8sdVWrjrjAftNY3E29apbXiqRK6SkaWxo
 rxOBXaMIIwkyGi4qQ+9dVhEJqRWOoGyM/6eSBkiwTLeAzrPWcA8qe7UqHSXbU5n1xhrL
 nS+e4dhQWG86OthZft1ECN6eaHj3o/EuAsNtXWmxH+QdlS9ZT6fb17tahGSsHid79G06
 MlZOsemHdkKIVnDdl69W3s88ciVTfveiM2RolP4YmX/zDZkSfcTdscfv6lVhuj6CmGfK
 Ka13ON9omozC0r3mOWbZAM2oSk2pJzNOCCMxV6OfiMP9kuEc6pP73E9+0MSMCklDfhDn
 S2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772557026; x=1773161826;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kyxRRsx7YBxPySu3vdb3mmraSeCnrpXZyYi+7K8ETcc=;
 b=c5yXckul/WYEu8Od8gDvPs+e6f9rgHIZ1uMJ04g8d0EE1A0Owl4IWI4oTEyiVeq7RL
 XVqHTqKVfP6b+a1quJMHhgcVrG+0zyOjhavN+/ofUQogjncR+7u+PCLwbqtegt3/vXJs
 Lx/JTBiNs7MAk6wFNoVJbBvtOpPOFFAh5JWOho4zB/A/CtS2Z7/aRThUViWvl+Z2G/Ky
 uKineOvFKr6YjjL4JHk0c7hOM+wIDtzd0BVANfC2OAec4mH5QCME8qZuOl0k3HEx8Fc2
 HgodpJcLTvQ4C+ZUvV00y+4lo5SDCbE550jKoEEW1K3fEKlFfdoG0FErlKKrQ+KQQHbD
 sL8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuZ830/v+y4Ts86CMczlSleMTcZIeTmo9RA6nHp2Asl9yzpov4uZ/0iPZHNwl1n9oefo5PnvE9NLOU@nongnu.org
X-Gm-Message-State: AOJu0YxBcRMbGxLaxgJGkRGFlpcZu7lgZ9j9HhpV9PnmINcwSjjU5rlp
 Dw/+W+lENU3N8y/6F5w/H6cjz0d3Nn4gJc0rUZGizDCj6k9l/HuGKACaNo+5rCSKPvp7JzPlwIl
 mHBYTYE+cOCPFrYNHlDkeZtCWoQW1VIn6fszhGw9reJv6VxZB1+Ldw6xK
X-Gm-Gg: ATEYQzyd3BiaL1HF2clz+Fqj4oZFkNn+rlreiToSeK/hBIQdz3NlUW9xz/O/fxSBTWC
 3RgGwHddnSH1y8CxnNfjT4LyiH/+7QQu9jfRJJGpI2PFi2FT1M9A5Tsb0o7XSg/lbZZDHbbrBB9
 EQE/AT1YvC3vQmYO4gmImciFQbn5upbP/ZryeWGhBPQLIqXnMPlLIsn2+6u0C1LS/PZNzl6Lx8V
 vtNHvzsVIlNDh6rJe5zbG9YQ74/DJm9E/hZYa3focNktV5Yxx8qPrTPB1aazqX3NdW7T/uGZEX5
 0+MKOSr+ZGWo24eVynMvMUHE7dTS4KL4AccNgI6WvHYdi4nu1kyi70VIpj1keSVXXgzLYLttTjs
 Zd2K1vJy8COMqNA==
X-Received: by 2002:a05:6214:493:b0:896:fd01:1306 with SMTP id
 6a1803df08f44-899d1ea768bmr252508816d6.59.1772557026024; 
 Tue, 03 Mar 2026 08:57:06 -0800 (PST)
X-Received: by 2002:a05:6214:493:b0:896:fd01:1306 with SMTP id
 6a1803df08f44-899d1ea768bmr252508076d6.59.1772557025235; 
 Tue, 03 Mar 2026 08:57:05 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899ef69b089sm67734136d6.46.2026.03.03.08.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 08:57:04 -0800 (PST)
Date: Tue, 3 Mar 2026 11:56:53 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 16/16] migration/vmstate-types: move to new migration
 APIs
Message-ID: <aacS1YUD0xesMufw@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-17-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220210214.800050-17-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Feb 21, 2026 at 12:02:14AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

Likewise.. one trivial thing to mention below..

[...]

>  /* 32 bit int. See that the received value is the same than the one
>     in the field */
>  
> -static int get_int32_equal(QEMUFile *f, void *pv, size_t size,
> -                           const VMStateField *field)
> +static bool load_int32_equal(QEMUFile *f, void *pv, size_t size,
> +                             const VMStateField *field, Error **errp)
>  {
> +    ERRP_GUARD();
>      int32_t *v = pv;
>      int32_t v2;
>      qemu_get_sbe32s(f, &v2);
>  
>      if (*v == v2) {
> -        return 0;
> +        return true;
>      }
> -    error_report("%" PRIx32 " != %" PRIx32, *v, v2);
> +
> +    error_setg(errp, "%" PRIx32 " != %" PRIx32, *v, v2);
>      if (field->err_hint) {
> -        error_printf("%s\n", field->err_hint);
> +        error_append_hint(errp, "%s\n", field->err_hint);

According to doc for error_append_hint():

/*
 * Append a printf-style human-readable explanation to an existing error.
 * If the error is later reported to a human user with
 * error_report_err() or warn_report_err(), the hints will be shown,
 * too.  If it's reported via QMP, the hints will be ignored.
 * Intended use is adding helpful hints on the human user interface,
 * e.g. a list of valid values.  It's not for clarifying a confusing
 * error message.
 * @errp may be NULL, but not &error_fatal or &error_abort.
 * Trivially the case if you call it only after error_setg() or
 * error_propagate().
 * May be called multiple times.  The resulting hint should end with a
 * newline.
 */

It may be ignored if the errp will be finally persisted in MigrationState.

Not a huge deal because I believe we also do error_report_err()
somewhere.. but if we want, I think we could use error_append() to make the
hint available to both.

This comment applies to all 5 similar occurances in this patch.

>      }
> -    return -EINVAL;
> +    return false;
>  }

-- 
Peter Xu


