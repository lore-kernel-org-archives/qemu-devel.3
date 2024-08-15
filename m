Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A681C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 18:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sefMB-0001Sb-EG; Thu, 15 Aug 2024 14:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sefM8-0001Ru-S7
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 14:37:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sefM7-00043l-BS
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 14:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723747069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aNrBoy2xYlL30RPuBCpkA0cPY/KlSdDcI9uwsOeh+5c=;
 b=c7cQGt9zbi+bEyMh0cViwUsX0wOw/1dIm5wiJ3TX++HqjFM3B8bwD9SVhJcSqpZGfgVsAX
 87TX83oqWhAZAY4DxZi96U7G8zdlTL28proqx/6rITMBuAXdzvsS2AjUImBG1+zJchbtt6
 vzRdn0NwfUj3y6tdrXe/a25nUn3FSzs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-ZK9748cnMMSnhVT5FFkXQg-1; Thu, 15 Aug 2024 14:37:48 -0400
X-MC-Unique: ZK9748cnMMSnhVT5FFkXQg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3688010b3bfso794772f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 11:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723747066; x=1724351866;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNrBoy2xYlL30RPuBCpkA0cPY/KlSdDcI9uwsOeh+5c=;
 b=ZMEdtO4Ki5H7SubxAFBqOMuWldm6VFwguuWuWiTGAz0J3zxhI7MF97wDr4WPR4ooYJ
 v59qzG6O1ZXBEkCMa9CH9jRWW4GBH+57vbGH5VFT7lMwqxE87HAwMnwFfl83xxCm+0U6
 VdF7Oe6YSPR70tpnyKs7F6BfVey6BcLmSVgLgg/5J25S4arBP5Bk0/HdyPX81V54EPQr
 8gO2003oWwZ95hzKEZvYixzI4jga90BFDUIBJWYhXJmS/4c1VO2FyZiWldOyPsk8iDrF
 IvZs+wE/31jRFxN0/CwvkL7omCwrbdXNFtIIdFckPmm4AOgpidr6yN+0xE0BacXbgj6p
 a5ww==
X-Gm-Message-State: AOJu0YwWZLKPyMprp9kYpMtVCphPxE7CUcYdk1hvVjtGS+/rsjQfWVYw
 V9YqFFWeclE4VrMVrHk0YUstptFaT6RrSapeZWq0ePCkT01r0Fq4zzR4eKEI3yOdp1QLnXx0P6x
 p1gC0JUDq1U3CHpmPgaPLhjalSt8uLyISGTCs6axEEMTSFxW84hrJJVioMFC3m2X7IHJbqK/l4O
 i74jdMVMwIhj7AAHjR0l3coY+GFtc=
X-Received: by 2002:a5d:5a15:0:b0:371:8e9c:e608 with SMTP id
 ffacd0b85a97d-371946a1a0dmr295781f8f.52.1723747066589; 
 Thu, 15 Aug 2024 11:37:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG620hCfl+odW0HGRQMAmYAQS4jVOoxnZeIzuk7jhIVX5kixquoiZgqpO6SPTH+TbfJD4S2sGVBB9kMURbj880=
X-Received: by 2002:a5d:5a15:0:b0:371:8e9c:e608 with SMTP id
 ffacd0b85a97d-371946a1a0dmr295754f8f.52.1723747066178; Thu, 15 Aug 2024
 11:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <CABgObfa8GTo06hm0oDT+GUy-_6z=FVH2xnLWFcpm39_=_p4LNQ@mail.gmail.com>
 <f31bac22-5fcc-4f01-9eb3-c9512daa41d7@linaro.org>
In-Reply-To: <f31bac22-5fcc-4f01-9eb3-c9512daa41d7@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Aug 2024 20:37:34 +0200
Message-ID: <CABgObfZ2qiOg3WYerO7nUP4U+726f2=ToBiTdi=Jx18DRNkxhQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] build contrib/plugins using meson
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Aug 15, 2024 at 8:04=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
> > One argument from moving contrib/plugins to meson is that the Windows
> > case depends on libqemu_plugin_api.a which is built with meson(*);
> > that said, libqemu_plugin_api.a should be installed - which would
> > justify it being used from an "external" makefile.
>
> You need meson to build this lib in the first place, so I guess that
> 99.9% of the people writing a plugin will have a qemu source tree (with
> access to plugin headers), and first compile the lib.

Note that the lib is built at configure time, not Make time.  It's not
a normal library.

> I am not convinced by the scenario where people build this out of tree
> to be honest, but I may be wrong.

The idea is that people copy the Makefile, and yeah I'm not sure
either if they do it but it can be useful.

Paolo


