Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5A5CFA452
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 17:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3eug-0003Ne-JD; Wed, 23 Oct 2024 13:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1t3eue-0003NJ-Br
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 13:12:48 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1t3euc-0004vn-21
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 13:12:47 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 4E5631804CA
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 19:12:41 +0200 (CEST)
Received: (qmail 19269 invoked by uid 990); 23 Oct 2024 17:12:41 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Wed, 23 Oct 2024 19:12:41 +0200
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 17:12:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <nenut@skiff.uberspace.de>
Message-ID: <ec6b6c1f81730e6b73e8cf7c4b2cb2f48598918a@skiff.uberspace.de>
TLS-Required: No
Subject: Re: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, "Julian Ganz"
 <neither@nut.email>, qemu-devel@nongnu.org
In-Reply-To: <31c78f6d-7154-41c5-be46-3ca4974fc6f4@linaro.org>
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org>
 <8929cd79ce653b55e7cb166300782cb13727da3b@skiff.uberspace.de>
 <f7e574bb-a780-4f5b-a511-ab9f0aa86f31@linaro.org>
 <ab29d100610abcc59ce2305a1ace1ac0b53340a3@skiff.uberspace.de>
 <2419ec6e-3d4e-4d6d-a738-7615c99ed60c@linaro.org>
 <0696c7fc52d1d58002f0a8be7e7502f57fd61d24@skiff.uberspace.de>
 <28f647ca-0b88-4a01-90d3-4cc4450e0d1d@linaro.org>
 <fd9c687a05ccdcdf5a589a15fcecb38074da7c1d@skiff.uberspace.de>
 <31c78f6d-7154-41c5-be46-3ca4974fc6f4@linaro.org>
X-Rspamd-Bar: --
X-Rspamd-Report: BAYES_HAM(-2.435389) MIME_GOOD(-0.1)
X-Rspamd-Score: -2.535389
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=nenut@skiff.uberspace.de; helo=mailgate02.uberspace.is
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Hi, Pierrick,

October 23, 2024 at 6:39 PM, "Pierrick Bouvier" wrote:
>=20
>=20So we could have something like:
>=20
>=20/* plugin side */
> void on_cf_event(qemu_plugin_cf_event_type, uint64_t from, uint64_t to)=
 {
>  ...
> }

We also need the VCPU id, but yes.

> /* API side */
> void qemu_plugin_register_vcpu_syscall_cb(
> qemu_plugin_id_t id, qemu_plugin_cf_event_type type, qemu_plugin_regist=
er_vcpu_cf_cb);
>=20
>=20We thus would have a new callback type qemu_plugin_vcpu_cf_cb_t added=
.
>=20
>=20For registering several events, we might define enum values for types=
 indexed on every bit, so we can directly xor the enum to register severa=
l types. (same idea than existing qemu_plugin_mem_rw, but for more values=
, with a specific ALL value covering all possibilities).
>=20
>=20Does that match what you were thinking?

Yes.

Regards,
Julian

