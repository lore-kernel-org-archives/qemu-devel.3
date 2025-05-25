Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE35C5AE59
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 20:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJIP5-0003iN-Ml; Sun, 25 May 2025 16:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uJIOy-0003h9-AE
 for qemu-devel@nongnu.org; Sun, 25 May 2025 16:57:01 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uJIOv-00047R-S8
 for qemu-devel@nongnu.org; Sun, 25 May 2025 16:56:59 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 78BDD17F958
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:56:54 +0200 (CEST)
Received: (qmail 13292 invoked by uid 990); 25 May 2025 20:56:54 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 25 May 2025 22:56:54 +0200
From: Julian Ganz <neither@nut.email>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Julian Ganz <neither@nut.email>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 03/25] plugins: add hooks for new discontinuity related
 callbacks
Date: Sun, 25 May 2025 22:56:41 +0200
Message-ID: <20250525205645.4366-1-neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <edf78ed0-7ada-467e-86de-47e2515588bc@linaro.org>
References: <cover.1747666625.git.neither@nut.email>
 <70c5a0d487731b08e803240061a97bfc110bfbcb.1747666625.git.neither@nut.email>
 <edf78ed0-7ada-467e-86de-47e2515588bc@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.559494)
 MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: 0.340505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=GvLZhGStly8KgnaFxTu/xQIpcmdTkidUVdTCXtT3myI=;
 b=Jwj6p3E4Ae8woF/m8gXHWvX+TZpopIeD7Js1i2NDgnBrVCwtFlUc5LREpivpPAyrTv8qWFloE7
 x7lVKTejhhvh+Pgup8S5VPfUarN0oQ37pMA1K6/b3L1Tj46zcXcqY5HDlp9cTltsnccfhvls+OAQ
 PHOFfffSMY8N9mZB+eFUZ8DwU+t0Xd+slla/M+zZPmfLNtKemVE9Ln/EKuR4HeEdIkNein8jT+IN
 T/m0XALm9bZKPhXa8UgKpSPOs4+/3UQNRED8ExZ3Su3FWxoNKZEkePIDnp8U+EACeEK9XCibOsIW
 YYeGxc7HgMbSs2soKlab2HUIoN91Gyn+AYOIQTWg2FxBcEVN9Ex9rATJ4B28VkLMZVHp8U0F+Kra
 nWLiTdf4v1W6nfSTAqicXiCn+5eEF0x2PgSfCgNWRJUQyVafXFAHYMSdX5DFwcP2y2NQmqBOhZfT
 oV6jkk0lO9K7YRoeZV4CMVyAHan5YRIIwlMOIZnVmvTuAjp67w9ubeL7Hw0MX8NvJZY/5WEHcTWn
 tD/SBMDUkMRiheBTwgg5dLOEZ2QFsY0GgzoJphvkMvjqOh4AIA3b8polKTfCqBwtpLHFLWamzzUg
 bNh08uFh/lNQt5c1CAbY0nyiIo1N6ATNXsULbZLHrEnf5NXU+HAtkV9AunPJvfjSwFX345q4yCjY
 s=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Richard,

CC-ing all the maintainers again.

Richard Henderson wrote:
> On 5/19/25 16:19, Julian Ganz wrote:
> > +QEMU_DISABLE_CFI
> > +static void plugin_vcpu_cb__discon(CPUState *cpu,
> > +                                   enum qemu_plugin_discon_type type,
> > +                                   uint64_t from)
> > +{
> > +    struct qemu_plugin_cb *cb, *next;
> > +    enum qemu_plugin_event ev;
> > +    uint64_t to = cpu->cc->get_pc(cpu);
> > +
> > +    if (cpu->cpu_index < plugin.num_vcpus) {
> > +        switch (type) {
> > +        case QEMU_PLUGIN_DISCON_INTERRUPT:
> > +            ev = QEMU_PLUGIN_EV_VCPU_INTERRUPT;
> > +            break;
> > +        case QEMU_PLUGIN_DISCON_EXCEPTION:
> > +            ev = QEMU_PLUGIN_EV_VCPU_EXCEPTION;
> > +            break;
> > +        case QEMU_PLUGIN_DISCON_HOSTCALL:
> > +            ev = QEMU_PLUGIN_EV_VCPU_HOSTCALL;
> > +            break;
> 
> No point passing in QEMU_PLUGIN_DISCON_* only to covert it to QEMU_PLUGIN_EV_*.

It easily looks that way, and I myself stubled upon this at least one or two
times, but `type` is the enum we pass to the callback a few lines down and part
of the public plugin API. `ev` on the other hand is the offset in the `cb_list`.
So some translation is neccessary, unfortunately.

Regards,
Julian

