Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CEFC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvsw-0002jO-4r; Fri, 02 Feb 2024 10:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVvsv-0002jE-Ip
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:55:21 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVvst-0000Ha-Ta
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:55:21 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40fc65783e5so6420005e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706889318; x=1707494118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9YCGNLX6VVZ4ROjQfemGqIeAfklglJZiiRwXx6Ag3EY=;
 b=aGrR/nxvbMsJ9rmgRQcm4ImBOrC8Uxwzn7Oz/Hb+u2lvSZNcS3NgpWam+iLa/0gxvn
 V0HmRvNrgzopcIz/3eiouCSmytG2l8NFf5GTFUGB7xzzt1KO0BVEHLBwbhzZjw1qK8fE
 us3i+4KlP22xD3XBsN+fOVXKp524jueouFr1fuXTPDODLy7JlbhbCDAZjHemEXl4bu/J
 5iykhdz7kAZPb7cWwEQMLy/5qpMTn3zLD8JMrijoK385NgHyBplB6VR/NkdFMGL8tnHY
 XZyjvwBPRvyPZ+X/HKLZ7zT7F1vebKWBXl0QsRDs8uXQuAdEsCB1nxMB/PLextpW9nIs
 Oqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706889318; x=1707494118;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YCGNLX6VVZ4ROjQfemGqIeAfklglJZiiRwXx6Ag3EY=;
 b=AmtlG4RiaOs7lF4bsOJEQixJFuXo43DXczlUuj8+yIJp2QZM7kNpGaNJ7zTsHunpfm
 CBVxVk0fdUKuqQivxgIvmBTAHcy2yKnbDtO1dCXEEYQSPt0vHOlC2XINkSgkUim+vtp9
 0DQx9Y53oKNNg+toS1SqiJyEDglfp39+UnYS5vFQf+gu/P1WKblsDQE6rpoB8Rcd2e9h
 JpJsdzXV4tuzwE412JQGL3j2GcyYLGIOGFw51js881e6SufNtPexZe8Fd21KDHwnzlk4
 Q9pAW6RXOTQSBHs3kKzR0ZqF0Fvv0tfG2sKwa9/F6f6jsg/yeXDPx+kuNbICl6Nkge8o
 ZBuw==
X-Gm-Message-State: AOJu0YzkOsBLU0HP/hv+wlu9hfRnrc1v9rZ3+9C4U9h3j5NogPkYomoR
 DnrQAK0eB1IOxRo31KlJWS2ld6WiR/W4oi17kSIYEPzOMYUdTKIDWX17HotSHEk=
X-Google-Smtp-Source: AGHT+IE5b7hBINj4H0Cr1O7HwDMv2orpahi3twhEyqapVo/h/aZm55v2D9WrusilBk2Hxydr4Z4Tnw==
X-Received: by 2002:a05:600c:4589:b0:40e:8fe8:a173 with SMTP id
 r9-20020a05600c458900b0040e8fe8a173mr4260233wmo.4.1706889317819; 
 Fri, 02 Feb 2024 07:55:17 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUJN8H7K7IXl5JtyI4JUrny6Lr3fP/6+YqsHnen6fXJSioe2RhbTbcLjXTrEfE9U9+STvID2xN8U7P8+0t4UEQ+K23GkPIkzmPCAyP80/Zg1ARrMLdyMzbYipzG
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t15-20020a05600c450f00b0040fb01d61a3sm267722wmo.18.2024.02.02.07.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:55:17 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1BF3A5F9D3;
 Fri,  2 Feb 2024 15:55:17 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>, Mark Burton <mburton@qti.qualcomm.com>
Subject: KVM/QEMU Community Call 6th Feb Agenda Items
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 02 Feb 2024 15:55:17 +0000
Message-ID: <87mssij1y2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,

The KVM/QEMU community call is at:

  https://meet.jit.si/kvmcallmeeting
  @
  6/2/2024 14:00 UTC

As I'll be away Philippe has volunteered to run the meeting.

So far we have one agenda item which is to discuss next steps from
Markus' post about dynamic modelling:

  Message-ID: <87o7d1i7ky.fsf@pond.sub.org>
  Date: Wed, 31 Jan 2024 21:14:21 +0100
  Subject: Dynamic & heterogeneous machines, initial configuration: problems

If there are any other agenda items you would like to discuss then
please respond to this email.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

