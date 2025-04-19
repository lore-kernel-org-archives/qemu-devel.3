Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4EDC369BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 13:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u67sz-0003qY-5x; Sat, 19 Apr 2025 09:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajmalsadath243@gmail.com>)
 id 1u62kZ-00086w-Nh
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 03:36:31 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajmalsadath243@gmail.com>)
 id 1u62kY-0005tA-Ac
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 03:36:31 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aca99fc253bso376961866b.0
 for <qemu-devel@nongnu.org>; Sat, 19 Apr 2025 00:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745048188; x=1745652988; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CVvF8XGG+iCQEYIOPrd/TOM8q0cBJv3iJExH4zzVHvs=;
 b=KLUrGdNZXl75pcBSNKPVG/zBMFdRAhuRnSbfk50eIjXOEyWYIstH+pbjo4Wg7uwBJf
 nXZmKvpG60F7Qzqvun6ClATkqfREnKqNdsqaH+u3XRsVibWTwx8ZMHVozgAeCjs/QJje
 H+lZpPC++sCDX8Ha1PD9aDoVEC0mD0rQ1TnWBj3a7IHFvCqS3oAupdpya7eLeRZDTPUV
 1YLPBkJShEj31R22S7Eum0FJrp/YGFA2rrNz5kpUAifKR4jCgn3a5paV96bm2HKHENtZ
 kLxdAhOHSeDckFj/8KcNrwfX0OE1/I/p5FgAp7pViAJ89naSZzx8G+9NVnv4Ke5hxO3A
 5HkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745048188; x=1745652988;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CVvF8XGG+iCQEYIOPrd/TOM8q0cBJv3iJExH4zzVHvs=;
 b=fZwy0Q8IF0C6WS1vhDOSkbsw8HG4wXePaRp2TXXVZjDt1HMsA9K7YIsbbxsmU788G8
 9XE0WVeguzkhjuz4cBuzFNP18ayhgu3+G5W64Yrkz5VGqnBdokffseXIaOtrURTJ0PDm
 QNo3sPWTbrHZcUEEDMxPw1KyhTLebleGkanjWMrTmhJaxhrRQn/+xW3jWXWvFkL5P6tB
 qwUL8mb4EurGyM2LTU4eeEMD3rjFitHlGK63aIl6jVSm1AbBGtCm7mcJDkCQUslBPDp7
 TFuaMGnFcyH+7tdo0XTBt/s7EROukSPeRoZb1a9J+J2Yc7SHcSniczflFeCxVOlC7/00
 oBOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUAMWYpbw5Z11ia+VmttV2Wp8rVxjoTc8IChG746hsMzRQH3qBpq48WWTXiuZpjEPLP3wKAuB6nMYS@nongnu.org
X-Gm-Message-State: AOJu0Yz3bTcLspv5pwOSbrZdM8+G5CWyCXHbmFsEuGIgCMuvBGJfXuAj
 LdzXtrOIU0kj+Kwk/ijvPruPHL5YmwF25fRZVmwCA3rdL1V0SDpJTwuDYw63ZRUSktCZCxt/bzx
 fADvQ4AzAc1DeUpf7F2htChhxKQ==
X-Gm-Gg: ASbGncuvy4EUtip7APkz1D+z2pHngDah5NDtYZxkWbh62ZD6VcSgj3i7Xtn50EzhoZr
 PWL6Hxw1mQaPLoaBVNSr6znk2tsaokvPYNBnntm/TzpUuAPsm6ZlG4OP3LpHH6pEVhQ7YDhvRth
 0EsIB3bJ3yqVzNfxV0+3w=
X-Google-Smtp-Source: AGHT+IFcV1EijPZvKW3frVvIVAcMuqzlL+ulQSyDnq1x1FMlwubtThr63v0tlomPkr7qwOJTNJqzm6YQX6LIN/EMaSI=
X-Received: by 2002:a17:907:2cc7:b0:ac7:82b3:7ad with SMTP id
 a640c23a62f3a-acb74dd54acmr438817166b.46.1745048188030; Sat, 19 Apr 2025
 00:36:28 -0700 (PDT)
MIME-Version: 1.0
From: Ajmal K <ajmalsadath243@gmail.com>
Date: Sat, 19 Apr 2025 13:06:16 +0530
X-Gm-Features: ATxdqUH8aqZoi9hLULvDr4PvIA2yw6065NT-wgJ_Fcjq0n1a2D1wpFwqflgML18
Message-ID: <CALz97HabXuukgtvT2ba-tpVpANHsvUpOujtftttLXxgYUuUhFA@mail.gmail.com>
Subject: Re: [PATCH v3] timer: Fix a race condition between timer's callback
 and destroying code
To: venture@google.com
Cc: jansene@google.com, jpcottin@google.com, mett@google.com, 
 pbonzini@redhat.com, qemu-devel@nongnu.org, rkir@google.com
Content-Type: multipart/alternative; boundary="0000000000005d19b306331cb1c6"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=ajmalsadath243@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 19 Apr 2025 09:05:31 -0400
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

--0000000000005d19b306331cb1c6
Content-Type: text/plain; charset="UTF-8"

Good

Ajuz

--0000000000005d19b306331cb1c6
Content-Type: text/html; charset="UTF-8"

<div dir="auto"><div><br></div><div dir="auto"><br></div><div dir="auto">Good</div><div><br></div><div data-smartmail="gmail_signature">Ajuz</div></div>

--0000000000005d19b306331cb1c6--

