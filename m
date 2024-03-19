Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8AFC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 08:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmUYg-0002zk-9u; Tue, 19 Mar 2024 04:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmUYf-0002zc-Am
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 04:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmUYd-0007dV-TY
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 04:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710835851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dEmvhT7VW8fpzVmhzK4eUAKWs92qKL+AwFEcxfM0KlI=;
 b=MwJzdD4VZ6j1MesnZ18TtTv7x6bDRx9bWGEEFfE1bQg2ZsVScyOrnaE2NbforQqf/6rPZA
 cq70tQfLT78VUqemp6JSz7CU1g5msBEwsUTie8TWjlTK8spUWnTkd6wTIQKdgDGU5XrySY
 1XHGnVR7VPSXAi/T48EazYHp8NJyrqE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-DGESZiU1MzWlDDwefdCesA-1; Tue, 19 Mar 2024 04:10:49 -0400
X-MC-Unique: DGESZiU1MzWlDDwefdCesA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33ed5ddd744so883563f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 01:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710835848; x=1711440648;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dEmvhT7VW8fpzVmhzK4eUAKWs92qKL+AwFEcxfM0KlI=;
 b=IBrhJjopDsHlPJjc/YrHP3bamMUe5DhpwbROKOCFP7RPhE5zGa58+L571YLHBYOB3p
 8On5FuRPVoWaY8UoNIoeJeIMgfktX+MK6e23H2OnsJkMoqJ92yHKqjwSnRC1HsTkBD9L
 Cs1hQcko519Mhf4BveGheQRBiWGWx9I4kKIaajqbKNw/x9adnN+XAJIlYWQ7oRM9Ni76
 6brO6MUeTdbIHxzDdhxHE+RLC1a1CM7cCr5IWM4p1VImBDR846Q8Z99zB2xdl2luvGG0
 OBzVrA/cln9Rh75in6vlC1UlyYrOj+wr0jNdUAVBACwF0/UKijtzKML1uUoD047VZDvr
 nz8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPEhHb4Ls1gkCwQ+OHwl30cnVUNfr1J6jFf/yO4OW/RDQsD1N905ctBEKsIApAHdOM2T9HFhQAhd6CgztlLbyI2wgFrJU=
X-Gm-Message-State: AOJu0YxM4LAosfAhH0+LwLguRun+UDtobOtamV5mGiAJ7WCF0NQ3Veyb
 DtqYwuI2xuTJ2naKLbBEO2VpxztFXAKwKrBzSfM4lHFy4VYnquig5QxezgsumvSjQVwqaZcXJBN
 FBmEWlouAykb0XAIhzxJaBzbTj3ITerlGBF1VJoqweJXCBOzzh0Z8
X-Received: by 2002:a05:6000:904:b0:341:8688:a0ae with SMTP id
 cw4-20020a056000090400b003418688a0aemr1054251wrb.50.1710835847996; 
 Tue, 19 Mar 2024 01:10:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbA6lv+RpaD3oKobQOW4QlpZfaGALSLelBtt1mbkLiyGjx9+FzvWdn468fNCV+GekULTHXgA==
X-Received: by 2002:a05:6000:904:b0:341:8688:a0ae with SMTP id
 cw4-20020a056000090400b003418688a0aemr1054236wrb.50.1710835847674; 
 Tue, 19 Mar 2024 01:10:47 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-50.web.vodafone.de.
 [109.43.177.50]) by smtp.gmail.com with ESMTPSA id
 ba12-20020a0560001c0c00b0033fc06f2d84sm7487216wrb.109.2024.03.19.01.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 01:10:47 -0700 (PDT)
Message-ID: <47044645-3b72-4c86-8406-19a2e01f2d57@redhat.com>
Date: Tue, 19 Mar 2024 09:10:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3 for 9.0] chardev: lower priority of the HUP GSource in
 socket chardev
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240318182330.96738-1-berrange@redhat.com>
 <20240318182330.96738-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240318182330.96738-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 18/03/2024 19.23, Daniel P. Berrangé wrote:
> The socket chardev often has 2 GSource object registered against the
> same FD. One is registered all the time and is just intended to handle
> POLLHUP events, while the other gets registered & unregistered on the
> fly as the frontend is ready to receive more data or not.
> 
> It is very common for poll() to signal a POLLHUP event at the same time
> as there is pending incoming data from the disconnected client. It is
> therefore essential to process incoming data prior to processing HUP.
> The problem with having 2 GSource on the same FD is that there is no
> guaranteed ordering of execution between them, so the chardev code may
> process HUP first and thus discard data.
> 
> This failure scenario is non-deterministic but can be seen fairly
> reliably by reverting a7077b8e354d90fec26c2921aa2dea85b90dff90, and
> then running 'tests/unit/test-char', which will sometimes fail with
> missing data.
> 
> Ideally QEMU would only have 1 GSource, but that's a complex code
> refactoring job. The next best solution is to try to ensure ordering
> between the 2 GSource objects. This can be achieved by lowering the
> priority of the HUP GSource, so that it is never dispatched if the
> main GSource is also ready to dispatch. Counter-intuitively, lowering
> the priority of a GSource is done by raising its priority number.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   chardev/char-socket.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


