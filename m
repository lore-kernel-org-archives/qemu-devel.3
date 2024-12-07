Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B85E7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 13:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJvA2-0005K9-6a; Sat, 07 Dec 2024 08:47:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJvA0-0005Jm-P3
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 08:47:52 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJv9y-0005nD-Vx
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 08:47:52 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 39E04180C09
 for <qemu-devel@nongnu.org>; Sat,  7 Dec 2024 14:47:48 +0100 (CET)
Received: (qmail 27804 invoked by uid 990); 7 Dec 2024 13:47:48 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sat, 07 Dec 2024 14:47:48 +0100
MIME-Version: 1.0
Date: Sat, 07 Dec 2024 13:47:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <7bfbd34424d0662e6a0ac25348bd5269a93edb2e@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
To: "Richard Henderson" <richard.henderson@linaro.org>, "Pierrick Bouvier"
 <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>, "Alexandre
 Iooss" <erdnaxe@crans.org>, "Mahmoud Mandour" <ma.mandourr@gmail.com>
In-Reply-To: <21c28157-6d3b-4b07-9dd6-241b3198be93@linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
 <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
 <0e4171ca0baa8727c0bbec7a25fd72d8b8e1e4b8@nut.email>
 <997e809f-832c-4bbd-b27e-a722ac835b34@linaro.org>
 <450f3beedf979437fa3de8bfab1ee72f66c67ada@nut.email>
 <cda016be-c82e-4b54-a506-22afe6ec2eb2@linaro.org>
 <c850ee89e15d2775e7c0137a218286e7060874dd@nut.email>
 <867d8a3a-ddf4-4655-9bfc-51c1a2ad8203@linaro.org>
 <b02abe90-d57b-4010-aace-1b47d92e5c26@linaro.org>
 <70666b89-1f04-4615-ae16-e1eefac2a446@linaro.org>
 <21c28157-6d3b-4b07-9dd6-241b3198be93@linaro.org>
X-Rspamd-Bar: +
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.089371) MIME_GOOD(-0.1)
X-Rspamd-Score: 1.310628
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=EJAXzIOg13VeVv7XmzTaCBez5ObSuyLDZhZeI6z+RoI=;
 b=rGBrqbx2PYGmlGV2kF1u9yn7lxwa58HtPxXQB94M1FraqNBozA18XMxKLeMvymIWJ63JBE+S11
 0iAsThtaoxU9irSVgjFuhjE+mb2y+PBnbQXwFIN/Eh2i053mEV8sHplI0CFP+5dXSRRuw0rH/JOJ
 vZ8Mbs9hUNZSSynCW37mZqT3u3BXYY1G5mhvC3mr4LUnjWiFsK4xIZvyVOZ+9xsxSmTqRsc+Ir2V
 OTBnyuZ9xYOWFwkdWE1aZdNre7Ja0EPIRRbHaTQncVinCtdI+6ig0uSEuR7jb7B1cqdpKhJXbmBY
 mG01aQtBoTlqQDl1+t3i6mo6JXGrM1qp9KI4k3ilZqFKDpD5A13M7bf9xwOHKDieT272l8uWML13
 4Oj7Vk9Wv5fP/hoXIiOLY69X1bSH2TLfX2lhlKxF3kLuAjEZklTHJ72iAFNMa6t5UC0GV/1WPoSH
 Y93m2AGGJZ57MZ4rWnvGSWcyE5HuNgDaIcGcE3TGabrhm+QDocRgINaBU8TN8+Q3j1g3ISU5CQis
 HkQCNGBuaorFpdgl91rnw+SJd8X9p+nA9NrKCu5dBeitl0I7+nwlslC2gXuspn/yrp1LIG0md/ir
 wszGI13mwiODCmi8VEAzy9CiYDnLf0IHoHHD0FdTGiNij9fAl1MA9d2c1PFMs3TVYZChySbUcbkF
 Y=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Richard,

December 6, 2024 at 11:56 PM, "Richard Henderson" wrote:
> On 12/6/24 14:40, Pierrick Bouvier wrote:
>=20
>=20>=20
>=20> Do we have an architecture agnostic pc representation, or do we hav=
e to add this for every > target in {arch}_cpu_exec_interrupt?
> >=20
>=20We have CPUClass.get_pc, which is almost certainly what you want.

I was wondering about this but honestly failed to do so until the
current series was done. I'll definitely use this for to_pc in the next
iteration. I'll still need to gather from_pc "manually", but that's ok.

> The call to TCGCPUOps.cpu_exec_interrupt is only a hint that an interru=
pt might be ready: interrupts can still be masked, etc.
>=20
>=20 From the current bool return value you can tell if a discontinuity a=
ctually occurred. But if you want to categorize that event in any way you=
 need to update each architecture.
>=20
>=20You could simplify such updates by changing the return type from bool=
 to an enum. While you would have to simultaneously update all targets fo=
r the change in function signature, if you select enumerators such that 0=
 -> no-op and 1 -> uncategorized, then you can also tell if a target has =
been updated. Because this is still C, the current return true/false stat=
ements will Just Work. :-)
>=20
>=20On the other hand, the previous patches to add plugin calls to each c=
pu_exec_interrupt are in the end approximately the same level of difficul=
ty, and is more straightforward, so YMMV.

Good to hear. I think I'll stick to the current setup. It likely also
probably makes things easier or less awkward if the API is extended to
cover things like branches and jumps in the future.

Regards,
Julian

