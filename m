Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C99ECA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 13:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoj2A-0003I3-Ap; Wed, 20 Aug 2025 09:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uoj25-000394-MY
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 09:39:19 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uoj23-0006RC-5F
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 09:39:16 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b9edf504e6so3159251f8f.3
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755697152; x=1756301952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUOX5PJUguUtDljhpkBlo+epoQbTPDPgp+HE1D55F4I=;
 b=UDaaKItEZvB6+Id8e+3Eu0shoRyK1Eaq7TeV6r6hGufYFeN9AZ3EB64qh4X7N/USX6
 AxwWvN/WonpmYLt95kmsrLHZYGlhCJf27qH+pIx4wpnJguLTZ9jrnenF4BNRhhMQTEyp
 yRgb7PPnK4JyMK9kcCbwSMPzthjl5rCn+g7wbJAPfMK3APY8NEtP734gQwV+SztEWza0
 w3dB4ue/UuWHSyAhg1TQjQBaxIIy65E8e9KCaRtUH7TBToDjWKR0DMbB0HfuQM6wyO0R
 R+Uob5QmYLPaVdqGXnn1hufYsDtgO0doK/Jjd3TXRdgB9ELqFsyab46HQDfJA3h9nVXj
 PicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755697152; x=1756301952;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nUOX5PJUguUtDljhpkBlo+epoQbTPDPgp+HE1D55F4I=;
 b=cpMBTEc5GF1cRsR6b1/9e9dg/NXuuLVZmiX+nRPN46YGks/TVBBVdAPQ7c+k2GmVQ1
 /c50K2O+P80cb7eKFBik3EyPcDDl5dLbJ3S6e2rZjfw5ps97EvdoDgINj/gUcviZ7pfI
 mzOYaax76f7i4CHJb3kOBeDVuu38Qv2yhG7qafTn9EgBKe4KNriGUYn+O4eyp7uQAV8v
 +/gYNmW4nsDNFU/Mrj9Jqa8ahZJ2Ybb1pFqNDttIunKyCHre7igFVqzZDrz6EgVnymL7
 tmxZNmwq0fWUT7WJ7nHKUMBY3BmShF+DpAEJUqnhcYccdGpK3JbLF6s+FMjaqgY6JsFl
 /oKg==
X-Gm-Message-State: AOJu0YxTn+LNTLfdGRFPVF30odvq0dtNbikbUlNZ6YP/WjFdmdqvUO9E
 CuOF6DliEokjskMn1NaRkPbDjDjOYHaRt7IE7YMg+kTTE6CQHXFJEOQs6Ik/1p0YkKp8IFSnQVu
 0V+GukWY=
X-Gm-Gg: ASbGncsxoWROBcXZYYikiczj2EwfeIBoj4CqwtW3UBbdki/5AwhRHkyXu8HSmKp5Gzc
 oTcQMqRvkE983a297hWCj8qe9emkWF5hX+WYx7R6naNluDETpG5U6fYVRq3zqBf3GaFNZLIH5/h
 pZ1lQGd8ytCOn71Sr26T1aPgbNr5p6wjCuLHG55jSZyuvduyvstFzbfPoQA1pkP5u2HCPteDpbj
 wRgu0cuyggPFsiAT0Gj6uJSRNFptZVCHHtaCU1yFmxVLP2bwjkcgbjryM7pvG7krdgQkkUnMhOh
 bPCDD9i9VsfHu0YQ79p5Pa6E6SZbj5x7iO19bS1N1u1IyTQkJgI17Tsw9zFpM6FohDh4x455wvi
 IJJt3hQWWJoKwR3u6RbEgOpk=
X-Google-Smtp-Source: AGHT+IGdGAUt05BAXk7afsPv5Bh1zdnj2Y6euxhwKHJU416cTLZAX50RmPPnWIi0KctBvwkrGFEZSw==
X-Received: by 2002:a05:6000:4014:b0:3a4:eb80:762d with SMTP id
 ffacd0b85a97d-3c3300fc206mr2052866f8f.56.1755697152063; 
 Wed, 20 Aug 2025 06:39:12 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c0777892basm7690222f8f.56.2025.08.20.06.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 06:39:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2B4565F898;
 Wed, 20 Aug 2025 14:39:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,  Mauro
 Matteo Cascella <mcascell@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: list qemu-security@nongnu.org as security
 contact
In-Reply-To: <20250820124417.1391747-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 20 Aug 2025 13:44:17
 +0100")
References: <20250820124417.1391747-1-berrange@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 20 Aug 2025 14:39:09 +0100
Message-ID: <87o6sakt8i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The qemu-security@nongnu.org list is considered the authoritative
> contact for reporting QEMU security issues. Remove the Red Hat
> security team address in favour of QEMU's list, to ensure that
> upstream gets first contact. There is a representative of the
> Red Hat security team as a member of qemu-security@nongnu.org
> whom requests CVE assignments on behalf of QEMU when needed.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

