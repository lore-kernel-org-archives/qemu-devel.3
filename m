Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321E2C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 12:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YAG-0006MY-BO; Fri, 18 Sep 2026 08:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x7YAC-0006MJ-A2
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 08:58:00 -0400
Received: from smtpout9.mo539.mail-out.ovh.net ([51.210.91.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x7YAA-0005Nk-FR
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 08:58:00 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4hmXj62Mwtz3whc;
 Fri, 18 Sep 2026 12:57:45 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Fri, 18 Sep 2026 12:57:45 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.54.155])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hmXj560p9z46dc; Fri, 18 Sep 2026 12:57:45 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 6F9D92404095; Fri, 18 Sep 2026 12:57:44 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S0059e7ada71-e3a7-4b4d-a2d3-80c2bcc843b3,
 01C0A6A7AF07A599AABFC2B7F4468695F1AF3DAB) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <7e899975-94f7-4357-947c-03fdc98f39fa@kaod.org>
Date: Fri, 18 Sep 2026 14:57:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] hw/misc/aspeed_sbc: Fix ABR and secure boot state
 reporting
To: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260918065347.3713868-1-kane_chen@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260918065347.3713868-1-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 3839600158360251403
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE9MMIhMj/df46my9jT52dJu5Y+W0FWn2lV0zDGQ4mhsihVi7d6rJgK6TitH6GbPe2ztee5ZsPsBPiJpIuAqXbLWH0mRZEMMxzmD987CHFpTh5RpCq9ggZj0V3+Gg3ICbh2VNM0O6mOV1XiYLTe5EPx1BoPEiaOcb8p1IQkMV9uTKDgIETjXX2o2gyWzDtfOsQGKPiK8+zCKWMkpIw6vsziTw5y/rT+w7QFZxcHLxqNShRk3Yz3xA8skjp7W5+6a2FVtmczTOjYwfBiUj19Z+CE17Fh2LpxEpsposqNS4ac0B/o+HWNJYprHtc1vfiEVcuaR4Y8K62dAwcJ3XAtPyJrncHGEW9XXWzPlULQXAhQOsex5pWtjZIPVfi7K9OZmsIFUzEgLr9j9Uvxv9GYrw5a9nQiQiT88874Sgeq/fwSQK3yrtpthx5FtgWzftVcB2E11yQjYJaJM/HmJEfisNVKreHt6eIWsL4Hnmt7+5D2B8I8NSaZXe8bk5D8OHXBDqmPT6AXSobSqOmyX1Dk2ppy6UB96WDJ63Hb6BbuvRWYMTk2M2O2bwYi0QJ699YNdqSQVS0pAAPKvW7wQqD6bgBtAwkk+afVxCO/yQkYk7zkVaO2RTCOR7E3ugjwwr2esOeK82QblMowftnSaJXilibKpIec6dKJ6nM8SiMqbCTf/g
DKIM-Signature: a=rsa-sha256; bh=lGK8WtdbcGCl3bzaf6psuUhZXMlIfqKfKn1FC1J0ue8=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1789736267; v=1;
 b=Y0dv3eoFXFaUclGPlxTkSjT6M8gVj7ZiudhffrcuozmYiu9YssQOuyyngmk1Rrv3SFyJyN8T
 MHyFlcjw95QPKNVhQY3aMn2yb5/66wd7FOqwF9Kj5gyetC/ExaEJ+KDYeu9iPTzMUpz3r7qeIWq
 C66/Qb2ozF0XlnW1sVUHU4qmLORuZ81Jhex76odOpkgKi3t7T8cp8PtIPJoB9S4ogo716WQ0gi8
 aOpxy2dq/8F16lHwliEeyMMnE0jQOMrFul+o/1wh0FeLhFnEx+39BplbmQc3+1w701I3u+8Dq6j
 mETuz/TPVYmAERIOElcjpLfvR1N7DJqGDIIWky9C9ep2g==
Received-SPF: pass client-ip=51.210.91.48; envelope-from=clg@kaod.org;
 helo=smtpout9.mo539.mail-out.ovh.net
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

On 9/18/26 08:53, Kane Chen wrote:
> The ABR and secure boot states are currently controlled by the
> "emmc-abr" and "signing-settings" machine properties.
> 
> On real hardware, these states are determined by the OTP configuration
> and reflected in the SBC status registers. This series updates the
> model to derive the ABR and secure boot states from OTP instead, and
> removes the corresponding machine properties.
> 
> The series also consolidates the OTP layout definitions and adds
> helpers for reading OTP configuration and strap settings.
> 
> Any feedback or suggestions are appreciated!
> 
> Kane
> ---
> 
> ChangeLog
> ---------
> v2:
> - Move OTP layout definitions to aspeed_otp.h
> - Add helpers for reading OTP configuration and strap settings
> - Derive ABR and secure boot states using the new OTP helpers
> 
> v1:
> - Initial version
> 
> ---
> 
> Kane-Chen-AS (3):
>    hw/nvram/aspeed_otp, hw/misc/aspeed_sbc: Consolidate OTP layout
>      definitions
>    hw/misc/aspeed_sbc: Derive ABR state from OTP config straps
>    hw/misc/aspeed_sbc: Derive secure boot state from OTP config
> 
>   include/hw/misc/aspeed_sbc.h  |  3 --
>   include/hw/nvram/aspeed_otp.h | 32 ++++++++++++
>   hw/misc/aspeed_sbc.c          | 97 +++++++++++++++++------------------
>   hw/nvram/aspeed_otp.c         | 63 +++++++++++++++++++++++
>   4 files changed, 143 insertions(+), 52 deletions(-)
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


