Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B907FCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6YI-0007zZ-KJ; Wed, 29 Oct 2025 09:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6Xy-0007ld-H7
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:49:06 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6Xq-0003hu-AT
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:49:06 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47721743fd0so4091795e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 06:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761745734; x=1762350534; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m4FI7htY6fyZ9UuoHzS9j6zJSgM8JX/GsD7HtcGfcFQ=;
 b=AkbhhVWbskujT+1PxEk4JfMBTVyDHwSKcj4LLBKo4YJc6b+7lLLaqQDtCwyUB4Up/9
 8lF0aOVoIVzZaQHK2HCenpGioiXD8iA3yxq5TXTmkVh9S+2BmN6PBdUtV5J7pXZcKLkk
 w/8idWZ3z2KObWPWxcAtuVks6vs+uQnWAwR3mQDGxhvWP97uBk63q+RpPOOhzGekiTCq
 evDd8hhxvgAuqpGrGaxVRvBRSQxU7W/XzSevdQ3eiKfd6p0220BEimU6N7z0YBJ7t6Qo
 CtyiZPpC7xenVvvmEjNVDSrrGbyvVSkLjFPtO4ni76pbIWDh4IDvHAUrGHKPDY0o40Kk
 gyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761745734; x=1762350534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m4FI7htY6fyZ9UuoHzS9j6zJSgM8JX/GsD7HtcGfcFQ=;
 b=TVgO8PlXvp4CFxi5IXVc3GYobOLp/4TEa+0Et7+l9DHHpcTaZmDqVoevaPul+LbI1o
 Dr7iBblBd6/kTrNh6azAB2+FN8NjwwR61bYKR0DJhB/DohClAwqT9JCJHBHSwJpq1Ly8
 eTNb039kc+XcCsYEVU8HCJILwCwiefp5dO7QgPuVRNhxzlK1GNTFbyihQZGxLL1BFyzO
 BbYgHsunZ0ej/Uo9U3CiAtSsWp9aO2oGQIaYtnmKXzqLW7jeKKnYXVAqewo88eTPEY/q
 NnJbcgr2Db2lVQ0GHylTaLqHFjQ203TEppOkxfr4D+R/cEURjKqo1YdI9pp/g91ZsfIF
 bm2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbkXEfNOjzLr6fNcGChG+lmYXPHLXYRPsr3Dl45R0cET9gS1nbmihJRsm5bN8gGw88lGeicq9CvW4R@nongnu.org
X-Gm-Message-State: AOJu0YxyVx7gvyMFJl3jPnm//R/00RzEhCNfDKKFXKyXIEhVtlIVpH1b
 /Hn+Ewpg3KTSsMLYGBGaybVpm6xYnR8SoAUP5e62UC7CsyKMrCHh/PEIaoBtz9gdtGo=
X-Gm-Gg: ASbGnctfVJkaluWGWRUa/HVAzOVDlTroudyFrAloNHgjXsb6mKANQ0uXvDINtsEgpsj
 +cnSO07FtGeIisfD6shbzVUIxWN8+YuoB9VZGzenNZOheRopOEqrU2ymA/ocHXZ+kyqKixgjSte
 dBFpxaMxYR0iZKnJxp6B6A9bGfuyjwwdwbsKzkjuvJbhKizcFkXe46toDXFycxawMzC8WPPoheh
 7Zx42cA8npgVmyDFeideTkjw7xwZGmPprflrTgsH7wnEsPTiDF1VTMekcdFKfism95iZCAQZSEw
 FA8QCw3Vw0w9PxDpTRoowaK6K1Yvb+iSWAYz9E9LUv8NkiS6jSd8rBZ3Bu+Hb74nTL7Sv/el4sn
 7/vSktQfAFEeE2Sx98y2mM1hydoSSLY/wFO0dqlUA0MvbtvUvL6SFMbjXtzvjxfCqdJflFydoxS
 A9AtNjC+8DOIPCeqo1ufvNAh7l8KAyfMe65BAabWZ2jJM=
X-Google-Smtp-Source: AGHT+IGITpEhoQK2d72zOHA7jX4ykmByEFPMEURlWXsfenTSz8ElaEP2jkYIYthvqniNVxqnZ1ANPg==
X-Received: by 2002:a05:600c:46cc:b0:471:95a:60c9 with SMTP id
 5b1f17b1804b1-4771e19ac2dmr30581595e9.8.1761745733951; 
 Wed, 29 Oct 2025 06:48:53 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47718493c61sm45224905e9.4.2025.10.29.06.48.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 06:48:53 -0700 (PDT)
Message-ID: <3a096bf8-863f-4d58-a60e-b0979d73d185@linaro.org>
Date: Wed, 29 Oct 2025 14:48:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/35] audio: remove some needless headers
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jan Kiszka <jan.kiszka@web.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Volker_R=C3=BCmelin?=
 <vr_qemu@t-online.de>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
 <20251027151045.2863176-22-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-22-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/10/25 16:10, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.h       | 1 -
>   audio/audio.c       | 3 ---
>   audio/dbusaudio.c   | 2 --
>   audio/dsoundaudio.c | 1 -
>   audio/mixeng.c      | 4 +++-
>   audio/noaudio.c     | 2 --
>   audio/wavaudio.c    | 3 ---
>   audio/wavcapture.c  | 1 -
>   8 files changed, 3 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


