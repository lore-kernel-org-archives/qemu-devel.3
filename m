Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E909CD4F54
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 21:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQu4v-00014J-7y; Sat, 23 May 2026 17:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastienb.sc@gmail.com>)
 id 1wQsmd-00054D-FA
 for qemu-devel@nongnu.org; Sat, 23 May 2026 16:17:21 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sebastienb.sc@gmail.com>)
 id 1wQsmb-0008Jk-2Z
 for qemu-devel@nongnu.org; Sat, 23 May 2026 16:17:19 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bdbac72ac1fso592833366b.3
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 13:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779567434; x=1780172234; darn=nongnu.org;
 h=disposition-notification-to:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QkBjN0PMKJ1IeG+FwoI0Y5J0Z4iXVr4KI+53dPiOt2A=;
 b=WRum3Q2e+ioaGJIfJMOCBoV/Mas7EZ02CR7rCE5GFG3TrgAlVAtGYe2fG3vHdLYIzI
 GhcrwOwBJ3q4COxRRsCz0dxBqaBLQR6Ne3L415lyBP2LmpHjg7+L2ACS0/udINbKRHEi
 CKCDn8+fGYIPmntXJOhVbRnu97fU6Z6oMtJjATqzmRM725kpTdKjJ2NELQSTWpioOhSt
 u+Srxq8i9mgVtAb3bwqtaHpo8yCIMTswhegn2fIY/vVZ2SW2BQ/5oLjH1Q+qOfIsBecI
 eXW8Q7gEgfG4HlmNkSkqbXyVUdz+TF5fGz17XWyg3ksO3DuusISJe2SADfIWTToIEFDT
 V+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779567434; x=1780172234;
 h=disposition-notification-to:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QkBjN0PMKJ1IeG+FwoI0Y5J0Z4iXVr4KI+53dPiOt2A=;
 b=BLHoFdXOIifWWD1G1BjSsGg/En/cvIdlFsob+jmldNsXXGZEfL7jngCjTAPzHJbP2o
 qPJb2Nei25mUAEFDZibvAsV5odB4++Nkv2IOrlqYpZ5qa8Aopx07tZNIecbPWErrhoq0
 vaJoLeVf8VjKstYM+rWLi7tKXfSNKsMRasfuB9dfkshg7SaU0qD4BSNViWfZc2aERqn6
 gb+GlCMTFAX+G6LhxJHHSWRlmjplanLgty7Vc0cFo9tlWGAJhdRJhU947codsmJsAEEX
 q4VRWXu6fQ0vJRtMvLn1POMBzNgQhtkIzKHaW4a0NUZHQF47LrjkGHFr8zQ4CoP2dJpp
 OeEA==
X-Gm-Message-State: AOJu0YzYJYNyCQd3jezOWQOsn3lSUWcFy6zUODJH61qQ0TT10oljMCjp
 Mru3vB7jSdrbATMEajBwhgsFRNhG5XbXcVXTvkFM4I/uf+IFcn0jlvmiJvUnug==
X-Gm-Gg: Acq92OEA6DCyAkfe8RIH0NvERlZvCi42s58diXw6oWg+ZG7s900i3+mX1s1Usj81KS9
 /JGi75GprC5sY5P2ZR9a1X1qbX03DdpLRDbH3E3FLQa3jnrXmiQ4IH4hJrwUjz50oF+t9ZUbuWo
 tSYnHRsFlnGHQWJRNsJwiX2U2zQ4VPhJWsrDGXhiW3HQ++INshMkjOo0hCh1OmTvgKYPnCUR8Y7
 poLn1Uui/dGHLfy52j4+oJUPiF694rGVVVcoxBQXqTmmKs3BZxwXIYyE/PmbhDB32z1+yDoS9gL
 Ul6m3tsdXatlIJiUz74jF7JGENc2Tn2FoktkjVMtxUDgdAuA04qqHyJ5vxhoAnIJFTSRXlvwaqN
 4aa6rk8MLVus5CYwzKgAaLjA+AsLd1craf10yJaAmV2z10MGDRlUG/fl9z3lNQM2yWPkko4RGsS
 zCI0Vgtky63UD/3bMBioAoh69nMCKJEYUvZYQtPza/avezCYeyEJKPBqCW0NleFc/fwwW1e5Nxb
 ktUn1FILc8=
X-Received: by 2002:a17:907:26c5:b0:bd1:d244:ca24 with SMTP id
 a640c23a62f3a-bdd236022bbmr514737766b.14.1779567433534; 
 Sat, 23 May 2026 13:17:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e1a:3730:a090:1f76:7779:8016?
 ([2a01:e0a:e1a:3730:a090:1f76:7779:8016])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc62d3f21sm214895166b.44.2026.05.23.13.17.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 May 2026 13:17:12 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------ECcRVrFPwlT9vaULTTBTAxUu"
Message-ID: <70e8ed39-3e00-4c95-a2e6-b10faf3a8b9e@gmail.com>
Date: Sat, 23 May 2026 22:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
From: Sebastien Brat <sebastienb.sc@gmail.com>
Subject: [BUG] input-linux: grab toggle doesn't propagate to mouse when
 keyboard is declared before mouse
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=sebastienb.sc@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 GB_FREEMAIL_DISPTO=0.499, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 23 May 2026 17:40:16 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a multi-part message in MIME format.
--------------ECcRVrFPwlT9vaULTTBTAxUu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

|Hello,

I found a bug in ui/input-linux.c affecting evdev grab toggle propagation
between keyboard and mouse devices.

## Summary

When using evdev passthrough with input-linux objects, the grab toggle
(e.g. ctrl-ctrl) only releases the keyboard but not the mouse, leaving
the mouse permanently grabbed by the VM.

## Root cause

In input_linux_complete(), the initialization order is:

     input_linux_toggle_grab(il);           /* initial grab */
     QTAILQ_INSERT_TAIL(&inputs, il, next); /* insert into list */

When the keyboard is declared before the mouse in the VM configuration,
the keyboard initializes first: it grabs and inserts itself into inputs.
At this point, the mouse is not yet in the list.

The exact failure condition was confirmed via strace: when keyboard is
declared before mouse, toggling only produces EVIOCGRAB(0) on the
keyboard fd. The mouse fd receives no ioctl at all, meaning it is never
reached by the propagation loop in input_linux_toggle_grab().

Declaring the mouse before the keyboard in the XML fixes the issue:
both fds correctly receive EVIOCGRAB(0) on toggle.

The exact reason why insertion order affects runtime toggle propagation
requires further investigation, but the fix is confirmed to work.

## Suggested fix

In input_linux_complete(), insert the device into inputs BEFORE calling
input_linux_toggle_grab(), so that all devices are visible to each other
during initialization:

     /* current (buggy) */
     input_linux_toggle_grab(il);
     QTAILQ_INSERT_TAIL(&inputs, il, next);

     /* suggested fix */
     QTAILQ_INSERT_TAIL(&inputs, il, next);
     input_linux_toggle_grab(il);

## Steps to reproduce

1. Configure two input-linux evdev devices in libvirt XML:
    - keyboard: grab='all', grabToggle='ctrl-ctrl', repeat='on'
    - mouse: no grab_all
    - keyboard declared BEFORE mouse in XML
2. Start VM
3. Press left ctrl + right ctrl to toggle
4. Keyboard returns to host, mouse stays grabbed by VM

## Expected behavior

Toggle releases both keyboard and mouse simultaneously.

## Actual behavior

Only keyboard is toggled. Mouse remains permanently grabbed by VM.
Confirmed via strace: only fd for keyboard receives EVIOCGRAB(0),
mouse fd receives no ioctl at toggle time.

## Environment

- QEMU version: 10.0.8 (Debian 1:10.0.8+ds-0+deb13u1+b2)
- Host OS: Debian Trixie
- libvirt version: 11.3.0
- Host CPU: AMD (iGPU), Guest GPU: NVIDIA GeForce RTX 5060 (PCIe 
passthrough)

|

|Regards|

|Sébastien Brat|

--------------ECcRVrFPwlT9vaULTTBTAxUu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <code>Hello,<br>
      <br>
      I found a bug in ui/input-linux.c affecting evdev grab toggle
      propagation<br>
      between keyboard and mouse devices.<br>
      <br>
      ## Summary<br>
      <br>
      When using evdev passthrough with input-linux objects, the grab
      toggle<br>
      (e.g. ctrl-ctrl) only releases the keyboard but not the mouse,
      leaving<br>
      the mouse permanently grabbed by the VM.<br>
      <br>
      ## Root cause<br>
      <br>
      In input_linux_complete(), the initialization order is:<br>
      <br>
          input_linux_toggle_grab(il);           /* initial grab */<br>
          QTAILQ_INSERT_TAIL(&amp;inputs, il, next); /* insert into list
      */<br>
      <br>
      When the keyboard is declared before the mouse in the VM
      configuration,<br>
      the keyboard initializes first: it grabs and inserts itself into
      inputs.<br>
      At this point, the mouse is not yet in the list.<br>
      <br>
      The exact failure condition was confirmed via strace: when
      keyboard is<br>
      declared before mouse, toggling only produces EVIOCGRAB(0) on the<br>
      keyboard fd. The mouse fd receives no ioctl at all, meaning it is
      never<br>
      reached by the propagation loop in input_linux_toggle_grab().<br>
      <br>
      Declaring the mouse before the keyboard in the XML fixes the
      issue:<br>
      both fds correctly receive EVIOCGRAB(0) on toggle.<br>
      <br>
      The exact reason why insertion order affects runtime toggle
      propagation<br>
      requires further investigation, but the fix is confirmed to work.<br>
      <br>
      ## Suggested fix<br>
      <br>
      In input_linux_complete(), insert the device into inputs BEFORE
      calling<br>
      input_linux_toggle_grab(), so that all devices are visible to each
      other<br>
      during initialization:<br>
      <br>
          /* current (buggy) */<br>
          input_linux_toggle_grab(il);<br>
          QTAILQ_INSERT_TAIL(&amp;inputs, il, next);<br>
      <br>
          /* suggested fix */<br>
          QTAILQ_INSERT_TAIL(&amp;inputs, il, next);<br>
          input_linux_toggle_grab(il);<br>
      <br>
      ## Steps to reproduce<br>
      <br>
      1. Configure two input-linux evdev devices in libvirt XML:<br>
         - keyboard: grab='all', grabToggle='ctrl-ctrl', repeat='on'<br>
         - mouse: no grab_all<br>
         - keyboard declared BEFORE mouse in XML<br>
      2. Start VM<br>
      3. Press left ctrl + right ctrl to toggle<br>
      4. Keyboard returns to host, mouse stays grabbed by VM<br>
      <br>
      ## Expected behavior<br>
      <br>
      Toggle releases both keyboard and mouse simultaneously.<br>
      <br>
      ## Actual behavior<br>
      <br>
      Only keyboard is toggled. Mouse remains permanently grabbed by VM.<br>
      Confirmed via strace: only fd for keyboard receives EVIOCGRAB(0),<br>
      mouse fd receives no ioctl at toggle time.<br>
      <br>
      ## Environment<br>
      <br>
      - QEMU version: 10.0.8 (Debian 1:10.0.8+ds-0+deb13u1+b2)<br>
      - Host OS: Debian Trixie<br>
      - libvirt version: 11.3.0<br>
      - Host CPU: AMD (iGPU), Guest GPU: NVIDIA GeForce RTX 5060 (PCIe
      passthrough)<br>
      <br>
    </code>
    <p><code>Regards</code></p>
    <p><code>Sébastien Brat</code></p>
  </body>
</html>

--------------ECcRVrFPwlT9vaULTTBTAxUu--

