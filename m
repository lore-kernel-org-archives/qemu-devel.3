Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034D9C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 17:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxs4v-0001g0-Gw; Fri, 19 Apr 2024 13:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rxs4t-0001fq-Mq
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 13:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rxs4s-0002UR-4N
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 13:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713547868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kELSDjQKcxMH0rH4wKpp8GVCY2WnciF1LOFNzGFGje4=;
 b=g0jfSsMM9U+WTXe+A98Qluh9+YRC9XwZdOTQwQ4xmaXDcANesqlkf1KweyE6tQF7CgHaRU
 ZWT6q0aEpBGIP2ViOFBCsj8BvV3+RakKsSqEAEBKSc6MzybsgseyPTfkMJi+5xaYMXnG1Y
 Gb6rVFDq9hcKHDrlCIcVTOZYi2crya0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-P55XGgEZMQKem9yryIzcWw-1; Fri, 19 Apr 2024 13:31:06 -0400
X-MC-Unique: P55XGgEZMQKem9yryIzcWw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-343f1064acaso1449675f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 10:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713547865; x=1714152665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kELSDjQKcxMH0rH4wKpp8GVCY2WnciF1LOFNzGFGje4=;
 b=WiuA2mjI1MC114hcLvwxFoc4y9FAq30oeEXiDdOpJJZwG0gbC9fCnXlTI2wuRTx9xm
 QtFkLAy/5+33sCuapIElPWYIIUbd7s0eqBhb9jr/iHg4/WIMSZjlwgc7v5T2vRemkKoF
 23a3mkeI1k+xMavbAdMi5qIQqUeEzolnuwvZElnZnJzZcqnojtkKVEFalWDqSfVh2sLg
 U95omSI7i/RUZ4QkaQeUV176vVdrIae+TYIczOofqVdVV4f7dnk4QeWfGmnOARK8w5L6
 KpVH2QhJt67+dbaHQ9nXrdw7PbeyIIZBu855FGCjRwldPuV/XDE93TNsPxM47Xot4AK8
 j2gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0nxcMloE7p9qZkqUC6m5R//A6NphsKgm/KPcgBqLv+KQUOAvWQfcmUaVq929BgZ+7JUN+omONdMar8RT95TkVXdIwtFY=
X-Gm-Message-State: AOJu0YxBrzg56MUdaagpGyLml5i+cUIChOQlBY6eHjWj4EtgH8RwF5YF
 yCXlPZU8rhhptYl9raGoN+KacCmCUPW2vY8/rYoTR7du4mcqVuEOeGv+/9zQLYm4aGjZRPXSRyC
 4ZNMC46fp8P2AIsbv6rTz9Va5t4JvWhcqyx2DNgfqhstiexXOhXtV1MCyyxfy7VRxg65O4IhJkR
 N9fWeOwyDxyW25iw2mC7lyzbD4mFs=
X-Received: by 2002:a05:6000:10c:b0:346:c0f6:8b8 with SMTP id
 o12-20020a056000010c00b00346c0f608b8mr2375882wrx.12.1713547865587; 
 Fri, 19 Apr 2024 10:31:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDQcA9FTLmI7BLf/YSRubyxznpvFv5aaGJwqzVNhzos8S+YQ1JWfpqlMLyn8EL1VnwPSUaogrQo6T5vDwegE4=
X-Received: by 2002:a05:6000:10c:b0:346:c0f6:8b8 with SMTP id
 o12-20020a056000010c00b00346c0f608b8mr2375867wrx.12.1713547865246; Fri, 19
 Apr 2024 10:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240411121434.253353-1-aharivel@redhat.com>
 <CABgObfamLi+Nz1sTC7PaDFg6jXT=4521SO11gbTysBo08jyp3g@mail.gmail.com>
 <ZiANq0CG08nWA7sL@redhat.com>
In-Reply-To: <ZiANq0CG08nWA7sL@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 Apr 2024 19:30:53 +0200
Message-ID: <CABgObfb0EDd2dAhY6gdXtDcrZ+tYktNf=aTwU9hYSJEPK49ekw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add support for the RAPL MSRs series
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Anthony Harivel <aharivel@redhat.com>, mtosatti@redhat.com,
 qemu-devel@nongnu.org, vchundur@redhat.com, rjarry@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 17, 2024 at 7:58=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> > > However, one question remains unanswered pointing the issue with the
> > > location of "/var/local/run/qemu-vmsr-helper.sock", created by
> > > compute_default_paths(). QEMU is not allowed to reach the socket here=
.
> >
> > If I understand correctly the question, that is expected. This is a
> > privileged functionality and therefore it requires manual intervention
> > to change the owner of the socket and allow QEMU to access it.
>
> In the systemd case, it will set the owner and mode, but in the
> non-system case, I wonder if it worth making this helper program
> have "--socket-owner" and "--socket-mode" args, so it can create
> the socket with the right mode/owner immediately, rather than
> expecting the admin to manuall chmod+chown after start the
> helper

I think a better idea would be to contribute them to
systemd-socket-activate, and just launch the helper that way. It's
mostly a testing tool, but tbh if you're not using systemd you're on
your own. If you write an init script for example, that would be the
place where you put the chmod/chown.

Paolo


