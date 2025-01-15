Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C789C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 16:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6XH-0006k5-MP; Wed, 15 Jan 2025 11:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.cooper@cloud.com>)
 id 1tY6XC-0006eS-0C
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 11:46:26 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew.cooper@cloud.com>)
 id 1tY6X9-0002we-2j
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 11:46:25 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d9f06f8cf2so5527854a12.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 08:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1736959581; x=1737564381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jfVZOgROECUa2tEcjDX9j+CT/akKl22KV7shucLuS+o=;
 b=ia4CmMYit8dqODgyakJqkC/oyyw0VgIwn205nlcuo1WqGfMYFqxJHfFb5TnFtIm2cX
 VGqb9/W/zPX+fQlDgzTjctfUd900wYBAyrS7pQf5ierA9a+8/oUh8x8BkXZ1kZu0nWRP
 ZNrgsmQk7WQtR6VpknHTmfU62W8aGot6ptNgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736959581; x=1737564381;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfVZOgROECUa2tEcjDX9j+CT/akKl22KV7shucLuS+o=;
 b=E4QaLIdpqUtekTQ/1pFHbgPy2zlLJCYn6oONC5Ks6m/C/Cf7MFssBgyG+MI4wldZJO
 YZMeM3lrMNB0vEqQMAIowpz4RQ+OYHwumWg2sb1NUykOINxeNLL7F36uN3I7zOtSjwWC
 m3FomM+2umavNefaQ3Z63cvdQ+uUnniOtiZ3zP29KzKi+SLv/PGP9GJCDjB1f+qvd4KT
 JLqprTvUHy2NSbpuo6eMcQ1KOBHA8HJ76RXdI0BwEnu39w5K3VosjfI8TOVtlHEKnZzH
 DyV++OOPtuGU/PFNe31Qob+HCSwZryKayjrtJ3988lW0W5+Y1QmhgWQ4t0LHy0ipbLQb
 Ru6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+Havb0nPPa4fF76NAGtqjtfOL+fHIeB9zwfRBxBMeA2gL2AU9XJ8OfHF7nbXFLI0e+uxwy7VxtLiO@nongnu.org
X-Gm-Message-State: AOJu0Yznw6m3+L2IXw8HELJLEAOHZDwvC4fUJhqKDYclC97zyekG1UE8
 s53NLT5f96Mm+w9EHy0gzH1x9FQkHA5NJodO7ONn+Up+EUVIYnzE30ftCOn6BSk=
X-Gm-Gg: ASbGncvw0wSFKFLlbU3UCE9LQDiN+3KFbF2ZiJ9RreS9/KjT4nuAT1cJx583on0eJaY
 oZClTg9qQwE6ZWWTBjzwLTgQFUprQirVU7a5XDsGuOend27hnHiM3C/d2f/3tn+nVHAPHjbP9KO
 tkGIJcBG+zHL8Fxzzj3Kx1b2kOUoIfgxUHK2dyy9LJvDJawp2nIkjiP621vQpQATHEqojaHeOaP
 bB1bqnnTxiX8cfWMxgWKxCbtUVJW/282UQQ3a2LIrDTkig5snJnNHcFpfExoSBUCQ==
X-Google-Smtp-Source: AGHT+IG9fwelL/D1La5pjNNAMd5O1WUger0zgOHHaIfFhCoUhFkGEau2NPSm8M/aLbMcdXbqStHbhg==
X-Received: by 2002:a05:6402:254b:b0:5d8:a46f:110b with SMTP id
 4fb4d7f45d1cf-5d972e17033mr29190036a12.17.1736959580989; 
 Wed, 15 Jan 2025 08:46:20 -0800 (PST)
Received: from [10.81.35.177] ([46.149.103.9])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99046a195sm7385437a12.57.2025.01.15.08.46.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 08:46:20 -0800 (PST)
Message-ID: <43161e04-a32e-4ef5-a310-84b7bfc9d50d@citrix.com>
Date: Wed, 15 Jan 2025 16:46:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] xen: do not use '%ms' scanf specifier
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org
References: <20250115163542.291424-1-dwmw2@infradead.org>
 <20250115163542.291424-3-dwmw2@infradead.org>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250115163542.291424-3-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=andrew.cooper@cloud.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 15/01/2025 4:27 pm, David Woodhouse wrote:
> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> index adfc4efad0..85b92cded4 100644
> --- a/hw/xen/xen-bus.c
> +++ b/hw/xen/xen-bus.c
> @@ -650,6 +650,16 @@ int xen_device_frontend_scanf(XenDevice *xendev, const char *key,
>      return rc;
>  }
>  
> +char *xen_device_frontend_read(XenDevice *xendev, const char *key)
> +{
> +    XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
> +
> +    g_assert(xenbus->xsh);
> +
> +    return xs_node_read(xenbus->xsh, XBT_NULL, NULL, NULL, "%s/%s",
> +                        xendev->frontend_path, key);;

Double ;;

~Andrew

