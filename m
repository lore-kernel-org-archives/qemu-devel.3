Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52388C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh2W0-00024s-J6; Tue, 07 Jul 2026 05:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1wh2Vz-00024e-GH
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:54:55 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1wh2Vx-0004Mx-VB
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:54:55 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-84777f07641so252672b3a.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783418092; x=1784022892; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C1kuAWVFGPwzKIMEV/1OoK6MgcXBa4QWrCoPfDjdzTk=;
 b=lFxLBh+O8EaR9FWQ/3gYBB+Aw6u5CgyuvU/C1mcMLXmzwK5lwDrj6q4kuehVwlFCWV
 4Ic1ITiOKCgZip43knJANqqQpWPYrMmr00T+Q/fwP46zseWu3WNX3+SAsMEGggdctH3e
 AsXwdsf6VuueNShqayYxfqdTsR8VAIOYSwJ8HCjgxPj9uz4ap+GwlM2+Kwiz6N802cE8
 g+YvzKKPHH00Q3awzIk2TqRZxh9X2uRt9PU91PZC8QjRm0m1JcZ+CvaiXiZphcNrl2W/
 cUt+X0MpUgPYeGsNSsuoUBVysLVDiZyAmP7qxumUtBpR+0rKvCxSrqa9A/OaHmLvMaOl
 4gnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783418092; x=1784022892;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C1kuAWVFGPwzKIMEV/1OoK6MgcXBa4QWrCoPfDjdzTk=;
 b=Y8A0XiUhV/6OYlzT2A2So9uCUnvqehswDl6HX209GfkhZ9x9Vf3VksWZPawp50eaYm
 Bsdevf8aR4O5khPET3WDIkJDyO1Hyox+ckVy7W1fHfhLkUYixnmKmg8TIQK1i6ZPcntk
 SlHVDZTsrdNoJli+ipEAXgLotRaDCB6CPdUpqeuP2XSf0YBF/UqSx/CsQzylO1GsR7N/
 aEuYfgqlwGXwnqIRnrWygQiZUvaA44nh3eeSNBiqpVPTi4iYtuwohYTRHiux2s8yk+0J
 RIhnc9vcgoBBpNApCbQXmmtzRBKNQmFwRTxrQoXWnbxofPbzvIIomszm6wnKnQDw70pI
 9zGg==
X-Gm-Message-State: AOJu0Yzz4T7IM74LlEqGpB6sonmVp8HB8Rtrd+eG1K0SabWMtbtvJ1P9
 yKjpywNX47B5FDHFH/QiRRn/TnvleeVDljN63KBXBBy10t3d8rm6k/s9
X-Gm-Gg: AfdE7cku7km6jNnDX0GQm3pmVdy6EhKERdNkeA9voMDCmFURN7pCtQsFKsqCSJqlff0
 PUWkpunEoMv1Rqurk9GPKff1n2572+YkCxuilWR+7C8pUBcqQg687KGFhQUurFFtr0ZaCi1dn/k
 leQRchLVhTMsfSMB33fb+3odFUfW9SN7bYjLFsPYvWalFLpA9J8/BWNptPVDrhwy20B1PmvkH5V
 S7nDyAbGLlJBozEY3yswJUhU+UdOk5ivBubyVTq4FEz6EQtgA7URP8oZYkl01augGYiSXQdSiIp
 M3QaB5BGQrhb5i0dGkUdyeB984lIqg3WUVoLyma+h2Ibo9M+MmXPhemlxqZfT0tCuUGjBwKSPWf
 4PdtbvnMxSrJFRsynMSNC4xVYwkNHCsg69Ns6Y56VGzNp7dWk6WoM6M4S7889bhjgqLDF5U11Dm
 5iPaNmNlcqJBBoLjgyCmNpPTM=
X-Received: by 2002:a05:6a21:3383:b0:3bf:75c3:ff9b with SMTP id
 adf61e73a8af0-3c03c43737cmr11853619637.1.1783418091937; 
 Tue, 07 Jul 2026 02:54:51 -0700 (PDT)
Received: from smtpclient.apple ([2406:4440:0:105::41:a])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5afcb672fsm658600a12.11.2026.07.07.02.54.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jul 2026 02:54:51 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] qemu-options: Enable the -enable-kvm option for loongarch
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <693c31c8-a3f9-4cd2-8374-e4638ff34d92@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 17:54:36 +0800
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7580A0A6-4937-470F-99F8-0B94163D7B54@gmail.com>
References: <20260705-add-loong64-kvm-v1-1-aa8b85ecfa32@gmail.com>
 <2d2e2609-ff6d-448d-9a78-9e9b6b9a9ec2@oss.qualcomm.com>
 <B737D5FB-43B3-478D-BD78-E5A2A8296B6A@gmail.com>
 <693c31c8-a3f9-4cd2-8374-e4638ff34d92@oss.qualcomm.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=shankerwangmiao@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Hi,

> 2026=E5=B9=B47=E6=9C=887=E6=97=A5 17:50=EF=BC=8CPhilippe =
Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 7/7/26 11:01, Miao Wang wrote:
>> Hi,
>>> 2026=E5=B9=B47=E6=9C=887=E6=97=A5 16:57=EF=BC=8CPhilippe =
Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> Hi,
>>>=20
>>> On 4/7/26 21:50, Miao Wang via B4 Relay wrote:
>>>> From: Miao Wang <shankerwangmiao@gmail.com>
>>>> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
>>>> ---
>>>>  qemu-options.hx | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>>> index =
e44b47de68137120da9979fb081d0c108f13179c..c7dbbd01e73367380fcf653fa8d0d187=
95dde9a7 100644
>>>> --- a/qemu-options.hx
>>>> +++ b/qemu-options.hx
>>>> @@ -5164,7 +5164,7 @@ ERST
>>>>  DEF("enable-kvm", 0, QEMU_OPTION_enable_kvm, \
>>>>      "-enable-kvm     enable KVM full virtualization support\n",
>>>>      QEMU_ARCH_ARM | QEMU_ARCH_I386 | QEMU_ARCH_MIPS | =
QEMU_ARCH_PPC |
>>>> -    QEMU_ARCH_RISCV | QEMU_ARCH_S390X)
>>>> +    QEMU_ARCH_RISCV | QEMU_ARCH_S390X | QEMU_ARCH_LOONGARCH)
>>>>  SRST
>>>>  ``-enable-kvm``
>>>>      Enable KVM full virtualization support. This option is only
>>>=20
>>> Isn't the legacy option for "-accel kvm"? (Apparently since commit
>>> 303d4e865b7 which is from September 2010). Maybe we should get rid
>>> of the '-enable-kvm' use in examples / scripts...
>> Yes, but I noticed that there are still users of it. I believe that
>> either we can fully remove this option or we should enable this
>> option for every architecture for which kvm is actually supported.
>=20
> Why do you want to add this legacy option to an architecture which is
> newer than the new CLI option and don't even need it listed at all in
> the help message?

That's because utilities and scripts may expect that there should be
an unified option to enable kvm acceleration. "-enable-kvm" might be
their choice. However, if "-enable-kvm" is considered legacy and new
users should switch to "-accel kvm", I can accept it, not moving
this patch forward.

Cheers,

Miao Wang


