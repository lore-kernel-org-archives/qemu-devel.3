Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34493C369B5
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 09:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4G0y-0007kA-BU; Mon, 14 Apr 2025 05:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u4G0q-0007iy-NC
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:21:56 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u4G0p-0002Wb-8F
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:21:56 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39bf44be22fso2501577f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 02:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744622513; x=1745227313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKuG67cDvlVvOBW6UV+qoE/VyMuO7mMc8OlnfLWIOqc=;
 b=jw2nHfMZbyhTG8B5Myl82VEajjmQHTtz2fP/CyHZglI1bDxaaAsJEHnz2C0i9GuOxu
 LRxqvAvIH1WxmXKar4LFGpciSWiXzMfQS+5ibqxawyFqYZ5sf+6QIts9QFft3hRYbv9b
 b1HkAj0CTs+Kq51Ox1iFh4ly5oCu3AvleyRU0QcO70xX0zQ6a5yMks/56nDuJLnpQdAm
 Grq90LCh63OYUR1rQV4S8v1TxLU+T7+vHxMXsbRVU2xcm7df2gWKra9+BIcS+4P93fMd
 gGaX0Ov8Ko0AYzeIa4EAmf8MwDkMfLKZy5Yj6zwFhE8rkbVsKgnCy32bglP5QvhbVPbj
 oL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744622513; x=1745227313;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jKuG67cDvlVvOBW6UV+qoE/VyMuO7mMc8OlnfLWIOqc=;
 b=vh6/nVD+x8aRv3yuVhx0YTsiCBAbI3LAHkdR0Y1uZjp7qnAj7iO/sIfclaO0Mua3aC
 hNMPgOXOv2uJ1WWUR7gHRrRoLEvUOQS5QI0zHpRHvtTqpZj+bqLWcKl3EGuLCJwGfyRv
 syvHBT/B6QufrE0dPNs2rU6r3pIXU8sYjBTkah/nzo7vQmZ10CkVIAwfePgb+aH6tNzu
 7xnqzhi6avFY5I5cTD1+wx34z5k+eGBVdPXCqWA/3wDKGgQ8/hwENOTjqDX2WI6wZC4y
 IS8c0aZWtuvaGmaS0aomWfA/HhIfGqejJTqm8V9AWp/UkazfNxxZgOQCRapvqi+2tOf8
 OaTw==
X-Gm-Message-State: AOJu0YwenBdbzG5C/5kQKR+sU6+70StuWU1cPjocJmNB9znP4g1FInu6
 c8s3wPL+jTj5PpmXlOEuMLV2qDjTP+blSHN7Zl/soVJ1FgwslmlyFW6/++s6gEg=
X-Gm-Gg: ASbGnctflwvQWIZqo5JQ3eLWPOQUZsuuN/bBcEVEyoQQpb9NPpY7I7Md5dIifKQRTyP
 Yephr+W+RY5S+JviR5zM5zMH5YwPD9cOMS84sEfa4DVgietUJ0MxWbzAtehBt3R4V0q0nEni9X0
 B+TcxB+ifhEyp+ukVvVBoaZfhelg1ru3M2+8PX0v2hRxo+bqGmw3Aby8FKKPGPzXQWs2S5kfuYV
 oIp1i6O+SkixZfZfWxLV52u8jTfoI338XDh4n395HOVon9GWbjsUW0w3NAdqEsQj0B2mYYMRaFa
 cQD6L65yzfosESicjg7GPhScutWlplOepePrZsfBf+4=
X-Google-Smtp-Source: AGHT+IG+vp6BYMSx4lc+xEpAE3RNbbMQrALNQmLaGyMtI1XGyKdkWdhOYWBKAw3EszAPUPRb0AwP6g==
X-Received: by 2002:a05:6000:2582:b0:391:2c0c:1270 with SMTP id
 ffacd0b85a97d-39ea51d3250mr9462100f8f.1.1744622513255; 
 Mon, 14 Apr 2025 02:21:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae963c15sm10650559f8f.13.2025.04.14.02.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 02:21:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 191EC5F8A5;
 Mon, 14 Apr 2025 10:21:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  stefanha@gmail.com,
 philmd@linaro.org
Subject: Re: [PATCH for-10.0] docs: Document removal of 64-bit on 32-bit
 emulation
In-Reply-To: <20250412164315.36161-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sat, 12 Apr 2025 09:43:15 -0700")
References: <20250412164315.36161-1-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 14 Apr 2025 10:21:52 +0100
Message-ID: <87r01vdrnz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> With acce728cbc6c we disallowed configuring 64-bit guests on
> 32-bit hosts, but forgot to document that in removed-features.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

