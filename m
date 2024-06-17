Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05C7C2BA15
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 13:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJC35-0002RR-QC; Mon, 17 Jun 2024 09:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sJC34-0002R4-C2
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 09:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sJC32-00058i-3a
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 09:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718629523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Y4y3xCjdobtpYMRY8oPv3IwIwhNcXF7Okmc8yMpWAxs=;
 b=ZSTUkTpiDKODlyNUUB/7A5mTBWMgw4rEjRH6YF9cEQPt9kWBirSQQRGNsTowYzMxj6MzFM
 JZsPHBY0HWB39fE79OQKjnLQ2eJFMB+pOJCndMG/GVJf73wP0jvgKL5LtA1y3VQJLQ7PVv
 kooII3A9+LDNR2olEgDtLN31Fs1AqpI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-FvaxYny3N1WQsqhxQc4tBA-1; Mon, 17 Jun 2024 09:05:19 -0400
X-MC-Unique: FvaxYny3N1WQsqhxQc4tBA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-62f43c95de4so89385647b3.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 06:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718629518; x=1719234318;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y4y3xCjdobtpYMRY8oPv3IwIwhNcXF7Okmc8yMpWAxs=;
 b=vvCIQ+ig0RgiX0gEIk5oqFaMPWBd2h8YdKs3uj8R9vxiKSE5lUUSa1vGML79lP5urk
 /oq7I3maY5uKadgGknIRCMOitGoVuCTlVOjnZFUr8MCq43K4+IT1z2o+FFtMblX0bW22
 j06iU1OQ5iENEHVUgtfKJEfZ4uxUOwX6FfX6Otqsce+kiHtbnPO1FjI2Klzn37CTD0I7
 kPD/5sY0fLKROoUYtZRW61MQ7Wby4Np+9KjZ3Uy+p1lNkH4ymNr4cW+hnT+I0bZJXj+x
 4Taebs2cQzNj7VMnXfnOOCpTQkxWhnsFVMM8v7EkHZsvkli8qmnrO1w+2bwiUxYkH+NI
 x8Ng==
X-Gm-Message-State: AOJu0YyCZCl2/fr4YeE4lvdlrQEPytROiVgpJpmZTj9nOD3CK39UATe4
 2Ilcj/QtemTCbJb8vfADkkSi1eRQiddKs08Fz6nPvwMqE+cpawD/BuuHEw2dMLgHDYlH18irwuZ
 unwbNA+OEcPX447dTDbNHfU/5cepji4BUeIGn0Zbs3edryR3fD7k6ZOUK7tNhtZ6oSLzWj/Arap
 3eK9eLd207+LQToAOW8yJ8IyQF7OMJXDekSP/WvQ==
X-Received: by 2002:a25:908:0:b0:dff:435b:ca99 with SMTP id
 3f1490d57ef6-dff435bcf8amr2755861276.41.1718629518207; 
 Mon, 17 Jun 2024 06:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSZQKcLHFga3GO+ELBOWwGdc79BOlSxpnrfAljEKfO18UfnTkyBssqcGy/MSp4anoVllGJHp0QB6bWRPRWGPA=
X-Received: by 2002:a25:908:0:b0:dff:435b:ca99 with SMTP id
 3f1490d57ef6-dff435bcf8amr2755833276.41.1718629517827; Mon, 17 Jun 2024
 06:05:17 -0700 (PDT)
MIME-Version: 1.0
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 17 Jun 2024 16:05:07 +0300
Message-ID: <CAPMcbCpER8hvza6fO8D5Pt-8TN4fx8yP-YR0o8WSorOE44dmJw@mail.gmail.com>
Subject: Guest agent guest-exec memory usage
To: QEMU <qemu-devel@nongnu.org>
Cc: Dehan Meng <demeng@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Roth <michael.roth@amd.com>, Daniel Berrange <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e93346061b159d54"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000e93346061b159d54
Content-Type: text/plain; charset="UTF-8"

Hi All,

During the investigation of a possible memory leak in the `guest-exec`
command of guest-agent, I found unexpected behavior for me. When we execute
the `guest-exec` command with `capture-output = true`, guest-agent stores
stdout/stderr until someone calls `guest-exec-status`.

Just for testing, I executed the `man man` command 1000 times with
`capture-output = true` and guest-agent allocated 36Mb to store the results
and it fully depends on output size.

I want to ask your opinion about this behavior. Is this behavior expected
or not? Should we store all output forever or should we limit it by memory
size/execution time/execution count?

Best Regards,
Konstantin Kostiuk.

--000000000000e93346061b159d54
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<br><br>During the investigation of a possible memo=
ry leak in the `guest-exec` command of guest-agent, I found unexpected beha=
vior for me. When we execute the `guest-exec` command with `capture-output =
=3D true`, guest-agent stores stdout/stderr until someone calls `guest-exec=
-status`. <br><br>Just for testing, I executed the `man man` command 1000 t=
imes with `capture-output =3D true` and guest-agent allocated 36Mb to store=
 the results and it fully depends on output size.<br><br><div>I want to ask=
 your opinion about this behavior. Is this behavior expected or not? Should=
 we store all output forever or should we limit it by memory size/execution=
 time/execution count?</div><div><br></div><div><div dir=3D"ltr" class=3D"g=
mail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Be=
st Regards,</div><div>Konstantin Kostiuk.</div></div></div></div></div>

--000000000000e93346061b159d54--


