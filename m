Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A926C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 14:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbKIh-0005ZP-Gh; Fri, 24 Jan 2025 09:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <internetarchivedownloads@gmail.com>)
 id 1tbE9d-0001U0-Dy
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 02:31:01 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <internetarchivedownloads@gmail.com>)
 id 1tbE9c-00041F-0D
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 02:31:01 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2a3d8857a2bso1029513fac.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 23:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737703856; x=1738308656; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kd3wmFk6s0Otq/AAAGtttQFgxB4F6buOK8YR3fDNyVk=;
 b=WjD0Ajn3qN52icmI0N8Ju1Enn9+F4rTnREEfzQdUh/NPoPQ9SZODVpOD3RkFOYXkhb
 Gb2G8w2rvJua9SoHzrJdtPdzewx5vL3gvL3IfV/qE5wFj1ASUTKOGnBDEB6n/sQhGu0H
 z05RxAH/mkvvsuJbRosJRbfLK9bjpDLzF6YY+UtZuDpe9UnlxPXn80Chr+oo2LRR4YiD
 tpH5XjndEHr9gQkSkM7q8c+Wb928eEZttR93ffMajFhadkDouEbRUb/a1ubkFnRbTUTr
 qHnOXsdTFysQOGh0AaJQt6rAbUknDP1ePaSjL71HmpRcBxvQr+ij9yYqIk38NHLiN342
 0UpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737703856; x=1738308656;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kd3wmFk6s0Otq/AAAGtttQFgxB4F6buOK8YR3fDNyVk=;
 b=EY50ALxlV2ITao0F7xmKL3mjsS60TCx3CDZCz8Hwnnme1EArCEAcFX5iHCZfWHK8mp
 x1SP9D+pN4qDpPSbKaZIB3lckpBHrA3Bi7fFvu9mSBQ2JmC+reJCcskiYoRB2u+IJPqx
 leE9yPrHp+z/vmm81wbfFkjDj1hqrg5g7b77Alk3HVKZsl941i61KlBVsdpBHcArQWF/
 ftZrZ8ycto7evLDKQBEwfR5Uf/RcebfoTpbEXqbqPUUwbzNjUccFeUf+Z0BI68UB5y+S
 4i+ZTnodU/rQsGeqMsFc+krO/Pzbpl6S+956F6hBmMoY0GZWkznw1K8fgioyTq0dsfb+
 ZOoQ==
X-Gm-Message-State: AOJu0YzG8GJRRD73TSpDd+Vix/cMCHC3dQMwplTkzBN82t6am31xHIkD
 jFX6tjmDSI+iyNemqItTOAvNuoRH+FEjrOQNZD0m1BtEgr1Q6mMOPWXqT8MMgcBjw67opBREhuf
 S7OdyE76n64/a1fDwctiC/C3iYFwTzBfI
X-Gm-Gg: ASbGncu3vZ+2UoJkAAXuBMNN3LCqFCpvAIc7F9bXlR+VjHize7mlcrtEbNG3rTwhjAp
 sXrcytp8YSenqiCb1P7zMPJWRKWXP/geNMjV1O+TM5SNjM/lIvHofKpyopM6v5Z6Ys7wfzi3HuJ
 ag5C1vybobfqk8pHpboII=
X-Google-Smtp-Source: AGHT+IF5uwy7MI+OuWmZtUC+X4hy1wGfMpkDKEXGUroDab4dVmtcY9XNcQ1ygr/fxIbsBogBW/5sWS5n5ibK2ohO0V8=
X-Received: by 2002:a05:6870:a54c:b0:29e:32e7:5f17 with SMTP id
 586e51a60fabf-2b1c0b50fd3mr18395246fac.28.1737703856255; Thu, 23 Jan 2025
 23:30:56 -0800 (PST)
MIME-Version: 1.0
From: internetarchive <internetarchivedownloads@gmail.com>
Date: Thu, 23 Jan 2025 23:30:45 -0800
X-Gm-Features: AWEUYZkVBe_iyqDfbepkmTseu8jGKFuWxjH4bpHQ0n2ANiS-X1qO46_eyEuqzIA
Message-ID: <CAEq-4_OVvPALS5wT0KD+ogDvpNgEYPRcMi_TR46BXBRDd_v1QQ@mail.gmail.com>
Subject: Basic question about QEMU emulation
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000013bb0e062c6eb574"
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=internetarchivedownloads@gmail.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jan 2025 09:04:44 -0500
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

--00000000000013bb0e062c6eb574
Content-Type: text/plain; charset="UTF-8"

Hello, I have a basic question about emulation by QEMU when there is no
hardware peripheral. How does QEMU emulate wifi functionality for VMs if
the underlying hardware doesn't have wifi RF module ? Basically, how does
it give the user of the VM internet access through WiFi ? This question can
be generalized as how does QEMU emulate a peripheral when it is not present
?

--00000000000013bb0e062c6eb574
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"color:rgb(27,29,34);font-family:Inter,Twemo=
ji,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,Arial,Helvetica=
,sans-serif,&quot;Noto Color Emoji&quot;;font-size:15px;letter-spacing:-0.1=
32px;background-color:rgb(240,242,245)">Hello, I have a basic question abou=
t emulation by QEMU when there is no hardware peripheral. How does QEMU emu=
late wifi functionality for VMs if the underlying hardware doesn&#39;t have=
 wifi RF module ? Basically, how does it give the user of the VM internet a=
ccess through WiFi ? This question can be generalized as how does QEMU emul=
ate a peripheral when it is not present ?</span></div>

--00000000000013bb0e062c6eb574--

