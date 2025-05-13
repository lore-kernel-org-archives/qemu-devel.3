Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5602CC3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 07:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEjyj-0004s3-Vi; Tue, 13 May 2025 03:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uEjyg-0004rc-1i
 for qemu-devel@nongnu.org; Tue, 13 May 2025 03:23:02 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uEjyd-0007Wj-Lt
 for qemu-devel@nongnu.org; Tue, 13 May 2025 03:23:01 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id D066218013E
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 09:22:48 +0200 (CEST)
Received: (qmail 32643 invoked by uid 990); 13 May 2025 07:22:48 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Tue, 13 May 2025 09:22:48 +0200
MIME-Version: 1.0
Date: Tue, 13 May 2025 07:22:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <94d24d5eea72d7f628f90b68e29d7a8eb7a578c3@nut.email>
TLS-Required: No
Subject: Re: [PATCH v4 04/23] contrib/plugins: add plugin showcasing new
 dicontinuity related API
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>, "Alexandre
 Iooss" <erdnaxe@crans.org>, "Mahmoud Mandour" <ma.mandourr@gmail.com>
In-Reply-To: <fd63b27c-e1e2-4741-ab86-911c14a27bca@linaro.org>
References: <cover.1746968215.git.neither@nut.email>
 <4ed6d35c186719fd20d4abe5c73b80b0901a96fa.1746968215.git.neither@nut.email>
 <fd63b27c-e1e2-4741-ab86-911c14a27bca@linaro.org>
X-Rspamd-Bar: -
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.721752) MIME_GOOD(-0.1)
X-Rspamd-Score: -1.321752
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=3XvcxIZLnr+OVQuqsrLH5Am/djl/kP4YTH6WOZZ8uKg=;
 b=E10UHtDmNsGGDl3FlyhlyU6beRGS+dazUBR3cmG76CDMi6szfRSTCakYLD0uyiMPMWBH4Zqu/R
 pFD25zkxEY/0NRjGo/stJhYTlFkeWcSglb5irg2jjDBK440v8Gwyi/YLvFvv3CeJ//LoACoH9aoQ
 pssEhzrv74bH1l9jwuzMDI1V1BRX1askU7ZWfNhTaKLiPf0ln80InsM9dmmAO6BPmNZR5lgWqypd
 o2N2bfE36kAK/+iLbcosO6zMGBR7c2HNu1iDuICmX+spNhH9hEwMdv1ySqF3Jag+Na/5wTfuG8Gm
 BkX2/IDxmbyfe20zSvN0ESp52s3ynkHv7aICbRoihkhXoJWsfV2B/KJr+7PZXg8eQAu62xcWsxIu
 In7fPuE/8gdUU7AwYbu1LmUdbDXDHpclriNKYNpgAKklf2AN5iUQJWu7tORroadt0P3XcZnwy+n6
 0TpJm0fzoWUA3l2lwvFnQsPOT62bqmG0r6J9dXUMW21PWP/GNI80uBwuN5w1dbzr4siyrBf20sc4
 R2rE4hDB20h14oTjEhyDQAa9J/z9zpKBMBWRtz+if0GexYQN7JPm+WYgQnfhpo5CMw7zCrNHmdXH
 n6Vtm95Kgvp4jtAUjjMv9YJ/wUl39zAsHdPW4XNE7vtCTug8nd1YOpjcdAlyvR5ORfIsY+47MPOJ
 Y=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NEW_PRODUCTS=1.25,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Pierrick,

May 13, 2025 at 12:45 AM, Pierrick Bouvier wrote:
> On 5/11/25 6:13 AM, Julian Ganz wrote:
>=20
>=20>=20
>=20> We recently introduced new plugin API for registration of discontin=
uity
> >  related callbacks. This change introduces a minimal plugin showcasin=
g
> >  the new API. It simply counts the occurances of interrupts, exceptio=
ns
> >  and host calls per CPU and reports the counts when exitting.
> >  Signed-off-by: Julian Ganz <neither@nut.email>
> >  ---
> >  contrib/plugins/meson.build | 3 +-
> >  contrib/plugins/traps.c | 100 ++++++++++++++++++++++++++++++++++++
> >  docs/about/emulation.rst | 8 +++
> >  3 files changed, 110 insertions(+), 1 deletion(-)
> >  create mode 100644 contrib/plugins/traps.c
> >  +typedef struct {
> >  + uint64_t interrupts;
> >  + uint64_t exceptions;
> >  + uint64_t hostcalls;
> >  + bool active;
> >=20
>=20The scoreboard is automatically resized only when a new vcpu is initi=
alized, so if an entry is present, it means it's present by definition.
> Thus, you can remove the active field.

In plugin_exit we iterate over all VCPUs and retrieve the corresponding
entry via qemu_plugin_scoreboard_find, which will initialize a new
entry if one didn't exist at that point. We used the active field to
distinguish between entries we created and those created while printing
the results.

Using qemu_plugin_num_vcpus instead of storing max_vcpus will
(probably) solve this issue. I'll check to make sure and then remove
this field.

> > +} TrapCounters;
> >  +
> >  +static struct qemu_plugin_scoreboard *traps;
> >  +static size_t max_vcpus;
> >  +
> >=20
>=20You can use qemu_plugin_num_vcpus() instead of keeping a copy of max_=
vcpus. It returns the number of vcpus started, which guarantees you'll fi=
nd associated entries in any scoreboard.

Thanks, I must have missed that function.

Regards,
Julian

