Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB866C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 09:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujDbN-0008M1-2t; Tue, 05 Aug 2025 05:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ujDbL-0008Fy-D9
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 05:04:55 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ujDbG-0004hA-HA
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 05:04:55 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b8db5e9b35so2016498f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 02:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754384685; x=1754989485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d0TquHe6aujG1ZvHKoEoj2bNkQDkMgTQri0zlDDL/k8=;
 b=B5kV4wGzA4ozqChm+51iSKn0TwJ/IKq8ERZ61RBIeHNY69F4DL64e8d6e+x3tMrCat
 6U/yVB0U6RnsctguAuklUGbaDqoPUbEyv9PkOBlunDnaywb5hYKFXI3uTqlJ/ZjUH8E2
 Fs3Rg7aNf7oKQQsGxzo+Lp87oZ25gfa9Ov6cHA59c7XvrhoeCbXoalwXnC1/d4k1jODx
 wBaErqVE4RHwGAi249KySyshKm2Z+Lic66ekWDI68Q1Je1mgkS3AW3SKxTHxre+hWDgI
 92L5fpA2Iu53wYz5+BvG+TtaoyMNf13KWwMD/6MXbs2fcqTNDSzASyGCpMAIOqkwnDhN
 J1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754384685; x=1754989485;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d0TquHe6aujG1ZvHKoEoj2bNkQDkMgTQri0zlDDL/k8=;
 b=d6RJePw3kVkfENWCCjaNgBUOPrP/954zAebyoIcga4+x7VKrY/uHFC2kjjgnuCBoNv
 1+NN5KAhmntIt5OL5Foe02jAVY1Z+LKk/yP9/oM7o1tZEsYmBkRXLoBdZVUKpglFUPJ5
 F+4CYCWKwUVJJtWDEli8GfYMDKSxnre3xzKTIImxtmrQ5uPIpeMI+TLTkTNYuG2n+lTn
 JPxUMx0byn3jhhlseO1PihiGW5pDaDXm2R9uOom1HLaxfQw0KDtm7DYMZ8CxxVuq2azj
 WwLZMLRjM7luIxhenchGdKcTNP4xUEQWAIWS0d0+/JHRifKfqQ9kMPCP5BatUJWwqyQs
 u00A==
X-Gm-Message-State: AOJu0YzNDOBZXR2fLvsMvaAZAct3qEyJzZ/rpdP61jkVluEKFBYx5RWN
 xdg8ga6+nd4WNOtNmHQ2MskJr7iRB/ByNqOVf2xIKANY7yy/43lYHN32ZehyatAHEu66tnG17oa
 rvkJW
X-Gm-Gg: ASbGncvpvKs+DFpIvUduNFxctrj7My74A9Z7BN/ceMpQcsP/wPtw2zlGMVcrU6mg5hZ
 WLOs9cYZ5ii2COrAwvlV97ZFgbLo6o3sAHBKGU66EwiXeQE9kIeoQcRoDHOJBud+lcMhY3faoFQ
 z8RJPg1S/vSCARalXEWWk/Gtk00qpCjmWYm3Eb0MLfYp0JAOJaYEMHyaq4LekO2dJB29+FCS/9B
 VCFByAoGAs5Dq9o8EQkx0QJKvkwXu/UtYUJOU/q/9ac43pF0zoXv3IatHdtbdaL8D1shKzhTb6Y
 W+n1AaV9XKnVfyUuUjYqwPb7OmDHGJlZdGyPu3cc+ZaOLinXsfvWu/JyZwmkAyKnLf8uMcHnHkA
 /YUMtD9XxjBrFNW+Uiyrr4F4=
X-Google-Smtp-Source: AGHT+IEngfRKAY2uudxdiNwXDmbhIqiqPPdXk8ImSkjxpPKzqKnuByzDkNWPUoH9MNyY7znlmqou6Q==
X-Received: by 2002:a05:6000:1445:b0:3b7:9477:f4ad with SMTP id
 ffacd0b85a97d-3b8d94b9f95mr9032283f8f.36.1754384684811; 
 Tue, 05 Aug 2025 02:04:44 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589536acc9sm245561505e9.6.2025.08.05.02.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 02:04:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D96C05F7E9;
 Tue, 05 Aug 2025 10:04:42 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] readthedocs: don't build extra formats
In-Reply-To: <aJGunKewK5aulbLr@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 5 Aug 2025 08:11:24 +0100")
References: <20250804162959.330060-1-alex.bennee@linaro.org>
 <aJGunKewK5aulbLr@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 05 Aug 2025 10:04:42 +0100
Message-ID: <87cy9a5ec5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

> On Mon, Aug 04, 2025 at 05:29:59PM +0100, Alex Benn=C3=A9e wrote:
>> We don't build the PDFs ourselves for the hosted docs and it looks
>> like rtd can't manage building PDFs now they have gone over a certain
>> size. Disable the extra formats so we can at least have the online
>> stuff again.
>
> Regardless of build problems, IMHO, we should not have been building
> the PDFs as no effort is being made to validate that the content is
> formatting well under the layout constraints of PDFs

True.

I will say the one thing I have found PDFs good for is uploading the
docs into a LLM context like NotebookLM. Otherwise you end up having to
add individual links which a) is a pain and b) is a potential DDoS
source if the model keeps hitting the host which as I'm sure everyone is
aware is a problem for FLOSS archives at the moment.

I would hope longer term there are better solutions for archiving our
docs as context if we want to provide it to things like bug assistants
or auto-reviews. I noticed virtiofsd is now using GitLabs AI tools to
aid MR processing.

>
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .readthedocs.yml | 2 --
>>  1 file changed, 2 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

