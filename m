Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6C9CFC52F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 09:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0HoL-000878-AZ; Mon, 14 Oct 2024 05:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1t0HoI-00086q-JB
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 05:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1t0HoG-0000TI-2B
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 05:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728899774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7iFQT2OAKGtYdIV1x9Qa8ogTSEQHYw9aI7vbwQyNlw=;
 b=YXA/mKSlVu7LZSB8EyTe8B2gG/43kqZR/Xi/Ue/f0Wd8WN0E0yLpvprivvhSqqhq/7BUYt
 GQzTw5t1DFx7zkHnKeIVbjt7FZGbiuYfQER3TdHPwwdK8N84AqylPtbi4yWwFyefj1U93q
 nGdS9S08IpDh6wtNd00Ikb2acknM0kk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-d0G3p0A4OaGsjA1e2BvAZA-1; Mon, 14 Oct 2024 05:56:12 -0400
X-MC-Unique: d0G3p0A4OaGsjA1e2BvAZA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7afd01249f1so1277042185a.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 02:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728899772; x=1729504572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7iFQT2OAKGtYdIV1x9Qa8ogTSEQHYw9aI7vbwQyNlw=;
 b=vk3N5ioAm/UOvH7+zgxNVpnpqZXfOxPZgHCubrUUqPQzHmpiSKO5MQYBAhcb1s2QLb
 kWgNWC1dzuCOajXu6RPFAoOu0xHTDCd+vPfbqrG6LS9KQlErCRqNxvm61HrhS7YbJBNW
 yBcxpHjYtK+ZqrTiEzUWcugCg/TFv9r53+0OemmQzHU8KVcdZsIWWbRm4rRl9c906Ty+
 H80CGRvwCJTIGHuOEeBVKl4szVdRz6qufSQtoI9yDrBwu7NjjTGrMRjxowxpwSaU7Wr+
 XN4mRP554Z0LTmmCKZmTVwAcu5In9Orsn/uKcyWZMciLc3HuoGte6hSLa0drNAOpSFd0
 gTjg==
X-Gm-Message-State: AOJu0Yx7ArfZ9dHreFPddN+6Rgji+++bc49ADgCTkIOknIilGcRj9yBa
 sdPFhyX0JVpnvZhJYjLlZGZby62mPbpRqBjzYwDi9cnn1tYmKiv2Nh96QxhrrQSFze5M5Ct+wbQ
 hEOqiPa8NGDH1BOAVglKeZ9cinvlR9kDNGRdw/ewaezbhBwru1wQjjrf+fAr2cJwyF/q8Zs1XzT
 GYRJzJSuKsAPt7ZHHaxtkl0mi2ILg=
X-Received: by 2002:a05:620a:4408:b0:7a2:bb:2cc8 with SMTP id
 af79cd13be357-7b120fb791amr1391179385a.18.1728899772004; 
 Mon, 14 Oct 2024 02:56:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv7VeTYS8WP9PHN7U5URRSQ/WW5/5lYbS4D4llTkUvkjzcFg0soK8aFziMBkANxM0MYNzguAsOxXfKydXi6gk=
X-Received: by 2002:a05:620a:4408:b0:7a2:bb:2cc8 with SMTP id
 af79cd13be357-7b120fb791amr1391177685a.18.1728899771730; Mon, 14 Oct 2024
 02:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ0YB0a-MdVWVoXqGjpRtToVcX-HXA=vRfVOO9VOvcutxvvmkg@mail.gmail.com>
In-Reply-To: <CAJ0YB0a-MdVWVoXqGjpRtToVcX-HXA=vRfVOO9VOvcutxvvmkg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 14 Oct 2024 13:56:00 +0400
Message-ID: <CAMxuvax4hEWJP2homSfr0VyzB7P_QX6f8cHr=L=Vz1X+bfN0OQ@mail.gmail.com>
Subject: Re: What is the status of the performance of D-Bus? Should it be used?
To: Anston Sorensen <ansorensen1118@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Anston

On Sun, Oct 13, 2024 at 5:23=E2=80=AFAM Anston Sorensen
<ansorensen1118@gmail.com> wrote:
>
> Normally, D-Bus should be used for direct input/output with QEMU (if only=
 local access is needed). The driver is not in a good state and needs to be=
 replaced though, correct? Should I still use D-Bus, or is there an alterna=
tive that is better at the moment?
>
>

-display dbus can be used for local UI. (I am working on RDP server
for remoting, fwiw)

You can use -display dbus with libmks: https://gitlab.gnome.org/GNOME/libmk=
s

In the long term, imho the various UI and remoting solutions in QEMU
can be all external processes (and code base eventually).


