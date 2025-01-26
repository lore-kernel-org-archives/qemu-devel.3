Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC5DC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 04:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbuEe-0007mG-3X; Sat, 25 Jan 2025 23:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nick.papadonis.ml@gmail.com>)
 id 1tbuEd-0007m4-2A
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 23:26:59 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nick.papadonis.ml@gmail.com>)
 id 1tbuEb-0004tj-Ki
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 23:26:58 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-216401de828so59792425ad.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 20:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737865615; x=1738470415; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kL2xsdrOnpr15mkXB4icwUVZU58Nskq50fd1hbGUv3c=;
 b=gQrZ0aR9LVqsQz85oWYw+9tk8o+p1pO3ZQaOo2knonwTzZnZy1wXadu8OJxxuj2VPQ
 SW/ZDgQN7eJ9c0aEC1fzpj9f8bnIpREzxX5b/oba1SRysLLkj1Wtk0nZQzdMF9RwIFsb
 A+FMXhwGKTj9lLQ0tfEhXIlp3gmq/GP4RiYTT7AfSpekbzk6TW+qaoOGLaeHq08FFmv9
 hN63ahX/jcbSExWEkSUdBd4oDfZ9bZxopDCV+0cSEfAIkczQFXcPn0qhbt87BoSxMtta
 kZYjosuQrw8JhZeYvsolWG70Y8QFlEv5KKofsUYMT/Wgt7RsWNOpk9bcbfNJdckXEx8R
 LmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737865615; x=1738470415;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kL2xsdrOnpr15mkXB4icwUVZU58Nskq50fd1hbGUv3c=;
 b=BaPAeTOURkvmq5BVJNqt2RxUO5VxZlNjlIsiZbEEeaaXXNurODjIv/QpzDxlyzycSU
 hMWG++wXwpxetQ8Pj2KU3gRk0YGqvKAnHPmawjduD9wXj1zESMRWVEaX+spx3kq/Eu6z
 xW6UVkEdGLedql/1pDOE1OiisGVZl1yR2wbvSJxg0KpKXaISFOjA1XolUOMQWdMES27A
 JfX+HahT28vg798bWgW41wFD3ybg0exA+vM0fdrJKUFLrOaIBE7YiHxP8OqJIwNKE67n
 73pxE71PyI8quVmGM0lmtixTvGlhF1bSRjlhXT8IVFJwfKz8j30CJ1VLuat9iSMd2Ocd
 OcZQ==
X-Gm-Message-State: AOJu0YzIzpxpFzQcjk30hfxJfO0qLDhSTMF0ZaBL4SMztOjYjVjsI/ux
 +x/GMtZB13Jti6SHx04yO6XxB/nTgT3fQsfYniwM5a5sqZHLtAkw/RJ0XB4jbyDtAFyLECwY3Lk
 3SAAWD1yDveW0IWiS9kwK9iqAkeKUcw==
X-Gm-Gg: ASbGnctQy674x12pxAJYnkzicgzkyavmOGyhvgC94KWyyrAC5AGx0zwk4SeyrvgyfbJ
 +xULtPkFNM5qdKyu6999yt2ilMLMwfXoAZW/Ri1+DbenJbik5Rk4DjvUR41ZIUjWws1CnS+zIHL
 9qaXYXHO/ALl3BQlunWA==
X-Google-Smtp-Source: AGHT+IHsK0m4fijcTfsXoSGNcbE2+lXYPTo1nCAF17I1mYuYpoYeidNykZAKi2ROh/aq1rXUqfNBEgdwF9jeeKNRGC0=
X-Received: by 2002:a05:6a20:3951:b0:1e1:a716:316a with SMTP id
 adf61e73a8af0-1eb21482c50mr48209560637.10.1737865615306; Sat, 25 Jan 2025
 20:26:55 -0800 (PST)
MIME-Version: 1.0
From: Nicholas Papadonis <nick.papadonis.ml@gmail.com>
Date: Sat, 25 Jan 2025 23:26:44 -0500
X-Gm-Features: AWEUYZkZ03AxSeDWFhA-R9dmM6Nv_vdF30yqm4liBj3UkI3wY9cYKFcQMpS_Uww
Message-ID: <CAKD0t1JkVt4wV-EyOu4pUNzT1zkMZ8=izjFu-_0DcsYD+0+syg@mail.gmail.com>
Subject: SPARC64 Support and Solaris 10
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000aaf9a6062c945e5b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=nick.papadonis.ml@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000aaf9a6062c945e5b
Content-Type: text/plain; charset="UTF-8"

How is the support for SPARC64?

Is anyone able to run Solaris 10?

--000000000000aaf9a6062c945e5b
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">How is the support for SPARC64?<div><br></div><div>Is anyone able to run Solaris 10?</div></div>

--000000000000aaf9a6062c945e5b--

