Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBD2C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 17:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqbUl-0000AA-VC; Fri, 07 Mar 2025 12:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tqbUh-00006h-Ng
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 12:28:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tqbUg-00087X-C3
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 12:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741368495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LT1/mLVrR27HX2+KjkcyUxv1hIeIghS1k2wdRFOIQNM=;
 b=fIJ/adwV6ms2ZTANn/UAQnmEBanP+5uAUIBnR5AQtlqXlwzt0OyQak92RRxUpk0foIVOlH
 CQHch4JTaeJ0Qw0NHMKGUpwnsTu3oPiLndFDe0+nO31hSTzdKz3hugAVgIFldIi8TGLy4H
 zzYt8BUfgedebGWyuVpSNJx27rmoEaQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-rVH4Vac4MqmV4-uxFiZaAw-1; Fri, 07 Mar 2025 12:28:14 -0500
X-MC-Unique: rVH4Vac4MqmV4-uxFiZaAw-1
X-Mimecast-MFC-AGG-ID: rVH4Vac4MqmV4-uxFiZaAw_1741368494
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6e8cf10d1c2so43407906d6.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 09:28:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741368494; x=1741973294;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LT1/mLVrR27HX2+KjkcyUxv1hIeIghS1k2wdRFOIQNM=;
 b=o0T7yZP3UK41tr4Y4RK98zZdvRcm2GP0HImrHZd1AoQshdSHVbyAIdalOeShIBdch/
 Rsf80A2xH7m8vErnqhg/JGIjv7xQwETaDKhrn08dZ8Y2PUs224rMHdwkKUVfQ055nh0K
 QiAk/DIeFWWOH1dNAvaChIMqy80VBDn0sZqHc8QzHg/nGj+UQQYeBIRv4gq4mgEDKcS+
 vtLbADFRU1mJFOim7S9hz7KluBzSuq+tEwazpEHn6P0i3ZMfxkrGIZqHY+o5sITMSvjd
 8cj4D1yXqmweop/4ZPP+b6rV4Iv4ecmmftIa+s+CsHmJzHZp8tLlV6XCC2b0Y7jPwwJA
 lNBg==
X-Gm-Message-State: AOJu0YzI1zkzTRVMaI/QF98ro5VIB6WtstkTlUP0fulO7dKtQKovU6Ny
 o99WAnGzi9cJSlgNFMXo0GS/3OYq0nBCV6+LLKrka7AjaPvL4s4PlbS2X3GgcSrnq9WHquLAgJf
 qDpxzyW+aSwh+8JWJkjxx9AP/vFT9SNjwUKjKT6//5lXHQDSyqoRM
X-Gm-Gg: ASbGnctN4UxJ8iqbnzd2lT0cxjLawxWltfESc+SGBgVwjB94cIHVNO4MBKKciP0HD7i
 um7mFNsQ6qNKNq5WtaIxXF9lckutkWab5DY35gmlpP0J1WThZg6YIc1Gsx6NeMhHgWNBep3+QGn
 SIjCkzUEr7es487Nhh5QZFx0Yt+fDylK0CLsRGClOFewSBDG57TCcIZPYFjpW3fszt1buavP4xP
 yoJ0JFFDcukaClZGmIYVOYCr0BRU8qIo1iTboEs8rlvaRlSD+n46OWoeg6DZGgwWqQX1GMlbecc
 X+n3ChI=
X-Received: by 2002:a05:6214:202b:b0:6e8:fee2:aadb with SMTP id
 6a1803df08f44-6e900642dacmr58731726d6.27.1741368493767; 
 Fri, 07 Mar 2025 09:28:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK4fQSgX6M4M5k9wMk1gXBIpSW7STSGnag28OO+B+aWK3eoj1S0sRTj4NoBqIbg7kT5uaFUA==
X-Received: by 2002:a05:6214:202b:b0:6e8:fee2:aadb with SMTP id
 6a1803df08f44-6e900642dacmr58731436d6.27.1741368493437; 
 Fri, 07 Mar 2025 09:28:13 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f717097dsm21559526d6.111.2025.03.07.09.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 09:28:12 -0800 (PST)
Date: Fri, 7 Mar 2025 12:28:10 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 2/2] migration: Move compression docs under multifd
Message-ID: <Z8ssqi0OW5TELSzW@x1.local>
References: <20250307134203.29443-1-farosas@suse.de>
 <20250307134203.29443-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307134203.29443-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Mar 07, 2025 at 10:42:03AM -0300, Fabiano Rosas wrote:
> The current migration compression documentation applies only to
> multifd. Now that we have a multifd section, move the compression
> documentation under it.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


