Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D11E6C617
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 08:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIOXs-00062Y-MP; Tue, 03 Dec 2024 03:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIOXq-00060M-JI
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 03:46:10 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIOXp-0006Dp-03
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 03:46:10 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 463C1180C3C
 for <qemu-devel@nongnu.org>; Tue,  3 Dec 2024 09:45:56 +0100 (CET)
Received: (qmail 2369 invoked by uid 990); 3 Dec 2024 08:45:56 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Tue, 03 Dec 2024 09:45:56 +0100
MIME-Version: 1.0
Date: Tue, 03 Dec 2024 08:45:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <181b9b53a258257df1b24e7bfb8b0e6fc590c25f@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 01/11] plugins: add types for callbacks related to
 certain discontinuities
To: qemu-devel@nongnu.org
In-Reply-To: <5e624b7244f1b0b294b28cd513aab04b6b294b1d.1733063076.git.neither@nut.email>
References: <cover.1733063076.git.neither@nut.email>
 <5e624b7244f1b0b294b28cd513aab04b6b294b1d.1733063076.git.neither@nut.email>
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-3) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:subject:date;
 bh=WyZz+dEcn8hSgA8haBBWbpT0nCmtP7CXyXsL4TtD8OQ=;
 b=FG5R9HIGH/bY0f7Q2wNmZkKniK1pSPATezUBS6K3E+uEEV3iYAe87nnrBqV0Ni1LmgIMlOsf/p
 NMtZ7Mn55ss4sOjtKUsUrDIKTtVK1nEaBKgtmUe4qyZCG6LzvCmZJi9G8LUPYO5RU6hjb/HGb1H4
 t3XIjAr63z7US4RAt73yh+F6HjICZ8kwILHQo30td//e2J4BirQFxzqLDaeBg3gAsa2ffvWNbGmq
 wqpfNFM2tXvRRPdl8d5jnL4Ly+cC/MtpNfLJeBQRyls5Uzk5frtjLJfGWDLO0QMc0ZOVKI8/TojF
 HAjm1LmGXwfaf2bQTvlhYsLGgYHfMDsW0KVE8KOAO4GG6QMZ0akLZA19fM+t3Bp6zc+s1PjHbsTF
 6X6XwAGdSwJUg3H4EzSqlja8acmmAob4E8c3+Ypc/qQe8xrU6ldv35Yh1dLWTEzOQkQv3MSUGCXJ
 RZefqIIT3Aq+HZvhD8gGy+O0smH+7H6sY1je16SWwAApMuJo3iQ04YlbU8gx7zuFU8jnJ4w82VFT
 70Vcb0vyA5ZFj60ba7b+op7GYMRRfRXC3iYgBEShHH3HnAwEqPGl9P04rgx0sMck+SeEp+zvwg1G
 AeoOLvMfQRVeaCcEV16wjnqaRe0VIIn34yu5rLC4gTqXf6ToSPhx3fJWalIev38N3HPhEHxMgcrA
 c=
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

Hi,

December 2, 2024 at 8:26 PM, "Julian Ganz" wrote:
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 0fba36ae02..9c67374b7e 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -154,6 +154,49 @@ typedef void (*qemu_plugin_vcpu_simple_cb_t)(qemu_=
plugin_id_t id,
<snip>
> +/**
> + * typedef qemu_plugin_vcpu_discon_cb_t - vcpu discontinuity callback
> + * @vcpu_index: the current vcpu context
> + * @type: the type of discontinuity
> + * @from_pc: the source of the discontinuity, e.g. the PC before the
> + * transition
> + * @to_pc: the PC pointing to the next instruction to be executed
> + *
> + * The excact semantics of @from_pc depends on @the type of discontinu=
ity. For
> + * interrupts, @from_pc will point to the next instruction which would=
 have
> + * been executed. For exceptions and host calls, @from_pc will point t=
o the
> + * instruction that caused the exception or issued the host call. Note=
 that
> + * in the case of exceptions, the instruction is not retired and thus =
not
> + * observable via general instruction exec callbacks. The same may be =
the case
> + * for some host calls such as hypervisor call "exceptions".

Some more notes about this bit: I originally tried to make the from_pc
semantics independent from the type of event, i.e. either of the two
cases. I obviously did not succeed in doing so. As, in most cases, the
instruction pointed to by from_pc is not observable via exec callbacks
I could also not test this behaviour in the testing plugin (see patch
11). I am therefore in favor for dropping the from_pc for the next
iteration of this patch series.

> + */
> +typedef void (*qemu_plugin_vcpu_discon_cb_t)(qemu_plugin_id_t id,
> + unsigned int vcpu_index,
> + enum qemu_plugin_discon_type type,
> + uint64_t from_pc, uint64_t to_pc);
> +
>  /**
>  * qemu_plugin_uninstall() - Uninstall a plugin
>  * @id: this plugin's opaque ID
> --=20
>=202.45.2
>

Regards,
Julian

