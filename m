Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04081C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 11:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZqXF-00044W-4G; Tue, 13 Feb 2024 06:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rZqXD-00044A-5r
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:01:07 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rZqX8-0006ZM-0B
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707822055; x=1708426855; i=deller@gmx.de;
 bh=qfwTPC6Qr+gCCLIefPdVA8Iq+L8d2vdQwItSQ1qKEEM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Wic0zEoFmw/JoZPxVdMkbIyNIPeCiZJGb52kHTsdMSZgwNFI/bCEdTM02HCRV+BN
 4fEvPSAIVHIHRaV+06VE/YkW3Cms7d8ry7huwT7lGnTI9BVYeYHCojeNjKIyU/qrR
 Uj6pT4X/x03GyMFYhAFcaiwAx1hdyI+PgJ2WOjTNi7+BIKJmCNA9liYlKfSKvVckp
 5MUGq0EajW0JeQJdxgIbOuYpXxqKiDMp2A7tpXFktiT8ilIYvTuVeI7WIuZaZMQhg
 alz9ETLRZ+L9hTtSLTmpDVWGC+kgtKzKZCqHe1rEWn3rzl37CAWHowpesg3cg6f4u
 UUYs02uvN+bRFxaxfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.153.170]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIwzA-1rFPy92lyM-00KTby; Tue, 13
 Feb 2024 12:00:55 +0100
Message-ID: <ebcf7d0b-17d8-409d-a07b-0399d7071eac@gmx.de>
Date: Tue, 13 Feb 2024 12:00:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] Hppa64 patches
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: deller@kernel.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>
References: <20240211122909.5807-1-deller@kernel.org>
 <CAFEAcA-4ck9Ro-9x13veOqL-165i7q8w17HP7KDN_5uNj2RVEg@mail.gmail.com>
 <71756c3b-467d-4416-884d-e4aeed3482ba@gmx.de>
 <CAFEAcA_CQ6PKHyvg9qKeWDJpkbTu8rv=TCm3GemJmKQCrjPNuA@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAFEAcA_CQ6PKHyvg9qKeWDJpkbTu8rv=TCm3GemJmKQCrjPNuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IWxEsFDYBcvdc+jrYeN2QeATeNH7ZYe6ZEFBsEkpTp1+9f2JDZg
 nudr7C/fA9+IJASBGKdwUtPt7EzSxpTRBrSRo75Dw28rmvVHev892xBBK8GRxLnb0eAC7MI
 FUTvpobKYCY8j/8XXyGw6eR+0V8Dp1zFt6Rb19pxTY+HylDR2g+GVVRFtFJwLpygF5AM/8C
 YwDYr1tZzaYDFf2bvkgVw==
UI-OutboundReport: notjunk:1;M01:P0:NOa3vcXTFlo=;r10lpqIqt53RB2oPoZI/syzHXc/
 mvPO0nldlCsoEoqXC1FXRyRSnLihNqdR6cmgqGc0sdJZ+scjBmURRo0Gpdd7aw8xcyyhu+ubi
 MDALwXRz+aVLvKznHm7AWH1mMuyShvloXzBHryupdhnEcmd9zejcoXKhBcN8ttNbGOw+R1Tz2
 3f5Papz0O2h0QArev/NBXJW2SKRaCnhLJGMYhTM0/L5s27xjD4Rtva7b+/O0M/myW1JaWFfT/
 +6cbz3psOC9UxZSEAltf4K9oFrUVPgEhjzQXPeL3nZr3IMwam1r6MbgEHDYx+KT44AUYoX4KD
 dTOBdkyYMGZul/tiH3Rf1nk1ua1AMgYoy8w83kxBi7v0qnyh88fTbZugaZK1+I1uJB+2aqtd1
 bHyCMGRLJk82S9twmSn0bbJcHrqcaxBImYKQJlgRU0nhMw9ZVtiL7f1FgobjZU1NO2cZjnBCR
 wJge7Jfy89r8X3pcFGAt22eDuOYv3k4Hk/O0xZBXmSsLy/M6zLBGvqfhYtGH+N5pt0AH2UWCj
 PhvRkxzMFpDatWF8mjbVRxxkXDuAKFbk0Pcphluk3L8vmmYlAsfx4dBm+iBe9602YTIO1rUoK
 JHhlhW2//i+lrAO4QmkDVyIr/RW8W603F8E0LeM2gkhH9f/hBKbCJX+iSA3SDnQ1BRPfG6Io0
 mT8JditpUIHH5tES+EiRr2L2pkuudpOGrXsYpjjbFR2Ob37uioQRlfx5g1d6fjdZEUjq6cKkM
 ZguH+VshCHcd2Vi4HQxUmvCdYWFcEA+qFJj6bxEcfAgJSP+yquPfmAERhyllDlRAY/7xMU3x4
 Ho2jLglFYOcOkANZFLSre2AliPjEo5d3Ythh80t1puyRc=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2/13/24 10:10, Peter Maydell wrote:
> On Mon, 12 Feb 2024 at 23:04, Helge Deller <deller@gmx.de> wrote:
>>
>> On 2/12/24 22:16, Peter Maydell wrote:
>>> This fails "make check", eg:
>>> https://gitlab.com/qemu-project/qemu/-/jobs/6154451100
>>>
>>> because when the qom-test etc tests run qemu-system-hppa, it
>>> barfs with "qemu-system-hppa: no firmware provided".
>>>
>>> That kind of firmware check needs to not fire when
>>> using the qtest accel.
>>
>> Ok. But how do people usually work around this kind of issue?
>> Test if the qtest accel is in use?
>> Ignore if the firmware can't be loaded?
>> Any hint would be great!
>
> There's a qtest_enabled() function -- see eg hw/mips/malta.c
> for an example of skipping the "fail on no firmware" check
> when it's enabled. (There are a bunch of others in the tree too.)

Yes, I found that....
I've used that function in the latest pull request which I sent...
Thanks!
Helge

