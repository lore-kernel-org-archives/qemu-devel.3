Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94538C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 06:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtiWm-0000pE-GO; Mon, 08 Apr 2024 02:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rtiWf-0000oE-EU
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rtiWd-0000qu-SB
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712557839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iGzLK3czGePL9m9ql0J3Fwp6slobwJuzD9NnhH8+SIQ=;
 b=NFZQWIrxGWs1P5mDBvkVyD+ekUIxA77gTsy9dppptPtZF+sst2dWcMBYdMR3cgrn8e2OFF
 DC8DzezVHCSkAb/l8LHvIbxtXR26eNhq/Kgqlvh+i2XtTOY6Cg74BxUYjmUYlPyd2TEaPQ
 PxVNYQUozThOPGJ8ctIybql7dVnPa2k=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-b5L0MfHBMPiwmvIUmoXWsg-1; Mon, 08 Apr 2024 02:30:36 -0400
X-MC-Unique: b5L0MfHBMPiwmvIUmoXWsg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2a4f128896aso551421a91.1
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 23:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712557835; x=1713162635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iGzLK3czGePL9m9ql0J3Fwp6slobwJuzD9NnhH8+SIQ=;
 b=eyJC2cvVGQG7DBnemQeTT6NDjYS80eVw3isUf9hGX6csT/dU2GiUKuKBp/9A+fp2g+
 TQanWhwg6HLuBd+2Jchb4mtp2e0ywCqKlD4v7Tfr5H5yWlu0fDs0QfqkoRZJNhtTJV8i
 CQc/yRWAD74IGj94ZgQLdNEcPhWRVBon2TGhaWyfuRiBN7zxhlz+LD7AnnEspzOSSjdI
 RvlceSfQ4Q2wVyCQsVcU7ExUsr9WFCmE6fDinxHxvUx0RVgggexoxF74VwFkER/UxW1E
 bORYdSlP3K9iYB2mq+Z+Ho/EB9Yik1Rv44LIaY3AWRCCAFOC5pIT4FGF4EjJjz58dUQg
 xVpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX7vtpxzf/eA4tumhqcYKqo4qCpagGB/XDy/d+ufUFVfJtV90js3/hZkjRgabOGziNWOFeoaiB4v62/VEooZo5nQb0jLs=
X-Gm-Message-State: AOJu0YyWf6+eQzBxhN9f3zkXjQtMkNNUgynavRlcMb8hYbzcDHibTAFz
 nwIHhR2aMnLVOXqWmG3RDCn/0mTR+H+8i9HWXzwVsLSlUvYlu1ce5hr2Ym+qtoQUK1EWWm7yuhe
 oDj+WXaJ+ahdfpZPtpyOOjVNYzJ5m83jX1+1GT7YjW/uOLm6lt+lCDeYsE1VX9RhSizzEZFG5WY
 cpwFCRR2qhnpMkdjfBEFc1F0UFElh3kbuCBHU=
X-Received: by 2002:a17:90b:3907:b0:2a5:575:c58d with SMTP id
 ob7-20020a17090b390700b002a50575c58dmr2929285pjb.16.1712557834985; 
 Sun, 07 Apr 2024 23:30:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv2KEaddExcqbpEHn7EJA7Bk78lLm8ULOQiR/QA1YSwNk7019/SrTkh5pdU/RpmROMOV5nX5CDDcL3b8uGC2U=
X-Received: by 2002:a17:90b:3907:b0:2a5:575:c58d with SMTP id
 ob7-20020a17090b390700b002a50575c58dmr2929275pjb.16.1712557834658; Sun, 07
 Apr 2024 23:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240329110420.1865664-1-andrew@daynix.com>
In-Reply-To: <20240329110420.1865664-1-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Apr 2024 14:30:23 +0800
Message-ID: <CACGkMEuBRwx7kptS971Bto0MY=YgX+YdHBEZ=9kA3CW4FMd=QA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ebpf: Added traces back. Changed source set for eBPF
 to 'system'.
To: Andrew Melnychenko <andrew@daynix.com>
Cc: yuri.benditovich@daynix.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Mar 29, 2024 at 7:30=E2=80=AFPM Andrew Melnychenko <andrew@daynix.c=
om> wrote:
>
> There was an issue with Qemu build with "--disable-system".
> The traces could be generated and the build fails.
> The traces were 'cut out' for previous patches, and overall,
> the 'system' source set should be used like in pre-'eBPF blob' patches.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---

Queued for 9.1

Thanks


