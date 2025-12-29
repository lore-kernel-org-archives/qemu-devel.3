Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413D0E92FDE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 21:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaKbe-0002WZ-R4; Mon, 29 Dec 2025 16:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaKbR-0002W6-K5
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 16:16:33 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaKbP-0008TX-UG
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 16:16:33 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a110548cdeso131188925ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 13:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767042989; x=1767647789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qhFsOZyvBBszKZWunrdffetKMiWyonnb2R4wITLXaZg=;
 b=XyvjS/0AWY3ANkIm54Kg7vjri9rE5bD1Z5BKtKUbfwRfJ9Xv9a/mqKUf3MZt8VPi9V
 SnSYdSjV5Xg+zB+yEz2yQnXh+w52AMu8C4EurJ2SlBDYwS6LMGCplWHHGY6wBgrYh9Ob
 GWR/U1DFFoJsqsTuWyrarBydkVz09ztlFBNg7xSb8G+tcNZokqz4nSTgbSbNq2VkEDH1
 L0KH6iMApQFnhoP88lUDq0LvEwNMB3r9DELjA7nJ3jc5CzRJS4zGxrubAO5ipSBpoTcM
 i9bglONtANtoXaXog9+zoUozqETHC/8BEm1Qn4nkuC7W6vr8wGT7IFcpVOdoRaAel2Vc
 nAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767042989; x=1767647789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qhFsOZyvBBszKZWunrdffetKMiWyonnb2R4wITLXaZg=;
 b=PRqKKsDznjf+JNhfZt92znM2AqM33YkCnOwjJJ5iGiO0tZwRIWbVLfwL2m7mz+0xHa
 FaoUPBtC/kKRHExFiuVG8sJYlUT99YDRSW9cod+2hx6em8z0QO6rOSSiViemQIZ+Q6tC
 ZuLMFLYHVg0UhSh9zQT80hYlaGAM2nlbQQvJjB1p/J9GqMD2nYk3ah8+vgQeIFLVVQMb
 hcR/OCFakQgThzua9H5fYojt7baI14JI94/p81n8hyhPLIIbCEod9zvb+RXmVfWgO3Lt
 QcsajqKEeVQ4EM3fAP3BjYLx0LoZH33VvO8L5kyxskG5kuM85Ip6XhjxcoPiizl5ElpN
 OfjQ==
X-Gm-Message-State: AOJu0YzLnDAdPzoN0bi8qW4utmGhQvixHw1hlrXpqDB85/3CY/htAsQl
 CDGH/m7JE7qnnm+9wH8iMWHcr+a1Ba9SsF6sVyqnL05v/vY+wPb92iNm+A2QDd5Db3Y=
X-Gm-Gg: AY/fxX43e7OOgL6VX/mVGgdEtfnmXiZeoLyo+KgeVYaAMDlBbGmW46Gp0DYrCNdDDOu
 MyZJvRYPhORbY/MVLxv8BaNo1quI1JAWehbyKstaQtrI02Safu8nodvtrX0y5MMyCx7y41cTYqG
 TfzCNybdmZmJ1z2fmY7jbNFLFCOXoY0t57Q59c+35SXcbjP2cPwMgo/x9krSsagodZP8/4V/gTi
 vAN9pX0wPKuc2YfNRIrZI5uMg17sAkC+oDVU+igGKa52kUw3hk9EX23KRL0cVC5G7SumSkrdObx
 r3p/Q9qnncYkZhJ/z7tTbX4e4/VxjSMqFzig7UZJTtARCC202h04JLKo4Kd1aai5YNkZZ/PLikv
 TxlxwIYCUVe5OUTLvV4O9dIJZvYIIWttkpZ1v7zoUouhCiFmTfDGDa4uT/fA4HVQhhdyDjE+mMi
 F3ygqkaOQSQO+rlH+cuWS0mvbnFZ8PccOrfYc4OH0Kbnkj4F7A8rokrcH3
X-Google-Smtp-Source: AGHT+IEGt52KsPDYD4kZ/T/EKTKTWuY3l6wP4cc7Qhm9l5w3PkTsTalivjc5D+ZGTBaFT/NH/WE3jQ==
X-Received: by 2002:a17:902:ccd1:b0:2a2:f465:1273 with SMTP id
 d9443c01a7336-2a2f4651332mr282066605ad.35.1767042988982; 
 Mon, 29 Dec 2025 13:16:28 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d20dsm281656315ad.67.2025.12.29.13.16.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Dec 2025 13:16:28 -0800 (PST)
Message-ID: <3bb036dc-e38a-4879-bdae-34e1f0ae0ba9@linaro.org>
Date: Mon, 29 Dec 2025 13:16:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 11/28] whpx: reshuffle common code
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
 <20251228235422.30383-12-mohamed@unpredictable.fr>
 <c8bba373-0ff1-4acc-ac3e-7157b3627247@linaro.org>
 <2F12B75F-5AE5-494A-96E8-5B0766804685@unpredictable.fr>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2F12B75F-5AE5-494A-96E8-5B0766804685@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 12/29/25 1:11 PM, Mohamed Mediouni wrote:
> 
> 
>> On 29. Dec 2025, at 19:46, Pierrick Bouvier 
>> <pierrick.bouvier@linaro.org> wrote:
>>
>> ERROR: New file 'accel/whpx/whpx-common.c' must not have license 
>> boilerplate header text, only the SPDX-License-Identifier, unless this 
>> file was copied from existing code already having such text.
> 
> Hello,
> 
> Deliberately didn’t do it because it’s copying chunks of the existing 
> x86_64 WHPX backend.
> 
> Should I still do it despite that?
>

I think you can remove the GPL boilerplate part yes.

> Thank you,
> -Mohamed


