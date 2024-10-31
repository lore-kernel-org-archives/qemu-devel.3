Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2072D767FA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 19:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6auC-00060J-0h; Thu, 31 Oct 2024 15:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6au9-0005zv-LY
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 15:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6au6-0001Uh-Je
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 15:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730403140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o/vwXC5JmUV9a25MdBRvgwoBQUq/oFzhyUR5/1LIRjA=;
 b=Mixy6G/EnHQKk3vZxp5r8b3dkuENh71AHH7FBzyQfJBZUxpstKjxyIESPtILmehk/j+y9s
 pR1/2Aavls++wLY0evsWKDBgZCgSBiDzkPrxOZo4VwUrfA2rulm6wNNJjNqJtZvzB8Z7aE
 pBjrkwXfWMoHpApcIc2a+5+EtfUcpRA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-ZvYbUVqrMB-0nGUKZScZqg-1; Thu, 31 Oct 2024 15:32:19 -0400
X-MC-Unique: ZvYbUVqrMB-0nGUKZScZqg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4609594e306so47354111cf.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 12:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730403138; x=1731007938;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o/vwXC5JmUV9a25MdBRvgwoBQUq/oFzhyUR5/1LIRjA=;
 b=VSIKjDUBD0qB4+4Y1Z+n0vHjQ7I8CWUeQzunj11Lq6NIMYIcCPq7KQXJd5YZHbhzX5
 KVr72nZQTpVhty8zU5i1P8Hd3oE6yz+2JhD0699vwcWh7fJ7K6DN/APs9DQ/GAoxwruq
 1ivXvunr6150220gC4Kfv4bV85226Jfv1t2j3FvepIUwKgEkS77hPTuYrbB/8poP9EY+
 hcVNMGNHPwDlrnkGDOKdMdk1gMP0oXmZNWyl86M9xWlY/SD+y+dqXwW7lbT86nHSikWF
 C8gI1lNz/EjrD/tFTsh+lk2PU/iOs7TPXKHDAPshkgw3zING6DWpw/TpDDQJSJzHwy7m
 B5OA==
X-Gm-Message-State: AOJu0YyS2FCvb+TngAbqq+86qUnQMM9ZOEqAyz1SiwrMHVJK8Cj2eqX1
 vvf/0jftE9MkxBGDcG6u0LkpmVro1aMJes8btlY4EyZrBgE3/ephyDAOLvnxbVkDG0tI+ldxX/H
 TtQDbpE1ziv9CYoV1myKgxRfbFwIlqPJWHU68vhgIZySWt+M32HpS
X-Received: by 2002:ac8:584c:0:b0:461:2221:3120 with SMTP id
 d75a77b69052e-462ad0adbb5mr56842671cf.0.1730403138424; 
 Thu, 31 Oct 2024 12:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj7Gk3NBDAoymovgKQ/Dt55wB5vP6RzB1R7vrpuqvLQILf/HlEhh2c1zOQnWWsEkXzCAOscg==
X-Received: by 2002:ac8:584c:0:b0:461:2221:3120 with SMTP id
 d75a77b69052e-462ad0adbb5mr56842401cf.0.1730403138040; 
 Thu, 31 Oct 2024 12:32:18 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad161f33sm10705051cf.78.2024.10.31.12.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 12:32:17 -0700 (PDT)
Date: Thu, 31 Oct 2024 15:32:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 5/5] qom: enforce use of static, const string with
 object_new()
Message-ID: <ZyPbPtkMBClKLa2Y@x1n>
References: <20241031155350.3240361-1-berrange@redhat.com>
 <20241031155350.3240361-6-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031155350.3240361-6-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Oct 31, 2024 at 03:53:50PM +0000, Daniel P. Berrangé wrote:
> Since object_new() will assert(), it should only be used in scenarios
> where the caller knows exactly what type it is asking to be created,
> and can thus be confident in avoiding abstract types.
> 
> Enforce this by using a macro wrapper which types to paste "" to the
> type name. This will generate a compile error if not passed a static
> const string, forcing callers to use object_new_dynamic() instead.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  include/qom/object.h | 12 +++++++++++-
>  qom/object.c         |  2 +-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 8c2f3551c5..6a21cb6ca0 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -637,7 +637,17 @@ Object *object_new_with_class(ObjectClass *klass, Error **errp);
>   *
>   * Returns: The newly allocated and instantiated object.
>   */
> -Object *object_new(const char *typename);
> +
> +/*
> + * NB, object_new_helper is just an internal helper, wrapped by
> + * the object_new() macro which prevents invokation unless given
> + * a static, const string.
> + *
> + * Code should call object_new(), or object_new_dynamic(), not
> + * object_new_helper().
> + */
> +Object *object_new_helper(const char *typename);

Nit; personally I'd call it object_new_internal().  No strong opinions.

> +#define object_new(typename) object_new_static(typename "")

Interesting trick on const check.. I see why the test cases need change
now.  Feel free to ignore the comment there then..

Could be an improvement to enforce error checks on new dynamic allocations.
This should be better than my patch 1 indeed.

Thanks,

-- 
Peter Xu


