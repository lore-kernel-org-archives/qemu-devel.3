Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD68EC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 06:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN4T9-0004yW-1n; Thu, 05 Jun 2025 02:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uN4T7-0004y3-57
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 02:52:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uN4T5-00019X-1h
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 02:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749106369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8qxelnSse5rapuj+2Nw93Nio8dw7MNX2AQ81J5FPQDc=;
 b=Lug/gZMyoeIpWCQlzzaPi2PSGdx1UFD9TBDGJ4AIJmWGCx/b5cyCsLnSsqJIpqR70esh9p
 sfqfXh6mWiM/BgLIRi1XPN7PPvHfhDXhf++gwH7RzM+umiedq5XlNnStKl4yhX3VGIzzmY
 yvEqCgDncrdlMeouyLh2JBoJc5kiJxY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-S58FyI0vN_2kZuinN_v7EQ-1; Thu, 05 Jun 2025 02:52:47 -0400
X-MC-Unique: S58FyI0vN_2kZuinN_v7EQ-1
X-Mimecast-MFC-AGG-ID: S58FyI0vN_2kZuinN_v7EQ_1749106366
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad56a52edc5so55492466b.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 23:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749106366; x=1749711166;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8qxelnSse5rapuj+2Nw93Nio8dw7MNX2AQ81J5FPQDc=;
 b=Xov20zvpQNNchoR127yAvg2Y5xCpdm5LuMwdObakbn1C7flAE4391QoySfLx/8oU6j
 lMK7ovtzaRR0c9ddCbDMg0ouyxYMTDk+tPGiKGRTtUvPjJmS4t+BocNz8Mu4MUcjVsPP
 tL5VRLWOEvAaQNHnVL77t+lTI1yezj9l/+BZl9hzvpnAQt981kuju+QgfFm+IbuZeUg4
 HXxaLRwE+FqZjklepuADhV0CZjWf6USDMiKJ95dtQJMRksrx6dXqCcjQvrvN4irtCP/A
 v3DWMEoRVPu+oD68/nTV35cy4unQk4WiytsFoe8cXitK5PmVFhExrwPhLzw5Pjn37lOu
 gc4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU82v4ZevktEFBxoBdIEa4JkfD9YkKQzUZOGlilawyXQ++yM/smAurv38LW7JP327M/wS71EqKlGFFj@nongnu.org
X-Gm-Message-State: AOJu0Yyp9pZWwu+vrNr8gXJ2PcHc5aGTNC1JoUI4eFO5Ekz+uVXejqK2
 503gtfxdktBLvMNzHaDG7X9mWRhE2k3qgRZWg9ZWsKyN7iTIWlrRmfZFwxlMyWXCrszGNCopJqv
 WywggUVJPA464qUuQyBgW5FGSlJLJnzxJEmf8YP8cEG4IUccTSjh7RVEe
X-Gm-Gg: ASbGncuuAWxnGR/kp3F2PaVaKuGOAob/j64Va9Yki7UD2ESZAWd3+nob7+m9TPCmDlM
 APP2qk2XRqA0PlowL/ZaBQPTRkODUP5hDzoLMn93u266Z3izbwFyng4L+LbmS1y+dwxBocyYsF1
 JRdZkz3AfoVKzxAfEDV/+6IHf90cCnYM15lrtSc1XilP2Sbqy8lsbDGfL9agbCEMXjxJjCNC3Sb
 K4eat+Xtz7OL/ZUiuprnyvDGvGK+rcUopNLdjSi8cU9Q8uLPu2Mza3LDoJey5yPyvRKfk58Yuy7
 tPT/vWSS0KmyzJKVi+tkN2ZO5+zRU4eZNpFwqei8hiIjPmOl4nqm+g==
X-Received: by 2002:a17:907:60ca:b0:ad8:89c7:2735 with SMTP id
 a640c23a62f3a-addf8fe2d0bmr580286266b.58.1749106366315; 
 Wed, 04 Jun 2025 23:52:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxRtF8POw4Hyd7k7hKJIpt1QbKoeel/o+jrsY/gkZEbwvVVFJfxHGSwSk/snWwM+lJv96hvw==
X-Received: by 2002:a17:907:60ca:b0:ad8:89c7:2735 with SMTP id
 a640c23a62f3a-addf8fe2d0bmr580284966b.58.1749106365962; 
 Wed, 04 Jun 2025 23:52:45 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-42-50-214.web.vodafone.de.
 [109.42.50.214]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5dd043edsm1226692166b.96.2025.06.04.23.52.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 23:52:45 -0700 (PDT)
Message-ID: <58abce8b-c5c2-4fd1-a32c-2d887445097d@redhat.com>
Date: Thu, 5 Jun 2025 08:52:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ppc kvm: support of 64K guest page size with 4K host pagesize?
To: Michael Tokarev <mjt@tls.msk.ru>, QEMU Development
 <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Greg Kurz <groug@kaod.org>
References: <0392df3f-c9fc-4372-a131-f0a7c3313c9c@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <0392df3f-c9fc-4372-a131-f0a7c3313c9c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 05/06/2025 08.34, Michael Tokarev wrote:
> There's a bug report filed in debian against qemu,
> https://bugs.debian.org/1107288 - saying kvm on ppc does not
> work on debian (anymore) due to qemu requesting unrealistic
> (non-existing) page size of 64K on a host which only has 4K.
> 
> I don't know much about PPC, - what's the issue here? Should
> qemu use the same page size for kvm as on the host?

Looking at

  https://gitlab.com/qemu-project/qemu/-/commit/2309832afdaf8d6451ebc2e81bace8eb8ea41293

it seems like this was done on purpose? David, do you remember why 
auto-detecting was not a good idea here?

Anyway, seems like there is a hpt-max-page-size property that could be used 
to set the value manually - maybe you could suggest that to the user as a 
work-around?

  Thomas


