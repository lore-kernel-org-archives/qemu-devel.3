Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E509CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xET1I-00060S-Bt; Wed, 07 Oct 2026 10:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xET0o-0005w3-U3
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xET0m-0003qN-CH
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791384770;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HAZaTDbmzLtKjrc7uvqIaUN09tuURsaX8c1k28FhV5I=;
 b=cu8b7CKUDp/SBob/2bKr7Dq87vWTlYABwh9kicPxjFQwOJNrpLcai5ast+miKrHEKDym1+
 sHTQXI+65PoJ+rAWYTzZ57i5Peg7VkZFH2mhUNlOaXRq5B81qj2aoQoCIS5Zn5Ao2pZkJt
 U8loTAy4g+PwYzH1ER6pWFbWqXA52To=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-bS_4uY-ZOW2RGV5dJBv8Tg-1; Wed,
 07 Oct 2026 10:52:47 -0400
X-MC-Unique: bS_4uY-ZOW2RGV5dJBv8Tg-1
X-Mimecast-MFC-AGG-ID: bS_4uY-ZOW2RGV5dJBv8Tg_1791384766
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 059A81955D93; Wed,  7 Oct 2026 14:52:46 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F4AB427; Wed,  7 Oct 2026 14:52:44 +0000 (UTC)
Date: Wed, 7 Oct 2026 15:52:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: luoyonggang@gmail.com, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] meson.build: export TARGET_ARCH_VARIANT in target
 config
Message-ID: <asZcuW82odzLVZ_l@redhat.com>
References: <20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com>
 <20261006182558.151956-2-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE8mDS9dadJzb_rt9ofj+g7T_-Mn20TRMMia0HOeu2bvkw@mail.gmail.com>
 <52b6baff-e692-4379-a724-3e9ae968110c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52b6baff-e692-4379-a724-3e9ae968110c@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 07, 2026 at 07:28:59AM -0700, Pierrick Bouvier wrote:
> On 10/7/2026 12:48 AM, Yonggang Luo wrote:
> > On Wed, Oct 7, 2026 at 12:03 PM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> For now, TARGET_ARCH only contains 32 vs 64 bit arch. The variants,
> >> based on endianness, are accessible through TARGET_NAME. However,
> >> TARGET_NAME is a string, and thus can't be concatenated to generate code
> >> and retrieve matching SYS_EMU_TARGET enum entry.
> >> Thus, export this information in TARGET_ARCH_VARIANT as an unquoted
> >> identifier.
> >>
> >> There is one more subtlety, user binaries have extra targets that are
> >> not present in SYS_EMU_TARGET, like armeb.
> >> Thus, for user binaries, simply export TARGET_ARCH.
> > 
> > 
> >>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >> ---
> >>  meson.build | 11 +++++++++--
> >>  1 file changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/meson.build b/meson.build
> >> index cae1591cd28..9bcfe84daba 100644
> >> --- a/meson.build
> >> +++ b/meson.build
> >> @@ -3288,7 +3288,14 @@ default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
> >>  actual_target_dirs = []
> >>  fdt_required = []
> >>  foreach target : target_dirs
> >> -  config_target = { 'TARGET_NAME': target.split('-')[0] }
> >> +  target_name = target.split('-')[0]
> >> +  config_target = { 'TARGET_NAME': target_name }
> >> +  if target.endswith('linux-user')
> >> +    config_target += { 'TARGET_ARCH_VARIANT': 'TARGET_ARCH' }
> > 
> > If TARGET_ARCH_VARIANT or just called (TARGET_NAME_ENUM) is just a
> > direct mapping of target_name regardless linux-user/bsd-user/softmmu,
> > the logic would
> > be simpler. That would need add more enum to SYS_EMU_TARGET, the
> > current form is:
> > ##
> > # @SysEmuTarget:
> > #     The comprehensive enumeration of QEMU system emulation
> > #     ("softmmu") targets.  Run "./configure --help" in the project
> > #     root directory, and look for the \*-softmmu targets near the
> > #     "--target-list" option.  The individual target constants are not
> > #     documented here, for the time being.
> > #
> > # @rx: since 5.0
> > #
> > # @avr: since 5.1
> > #
> > # @loongarch64: since 7.1
> > #
> > # @hexagon: since 11.0
> > #
> > # .. note:: The resulting QMP strings can be appended to the
> > #    "qemu-system-" prefix to produce the corresponding QEMU
> > #    executable name.  This is true even for "qemu-system-x86_64".
> > #
> > # Since: 3.0
> > ##
> > { 'enum' : 'SysEmuTarget',
> >   'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i386',
> >              'loongarch64', 'm68k', 'microblaze', 'mips', 'mips64',
> >              'mips64el', 'mipsel', 'or1k', 'ppc',
> >              'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
> >              'sh4eb', 'sparc', 'sparc64', 'tricore',
> >              'x86_64', 'xtensa', 'xtensaeb' ] }
> > 
> > 
> > The list target names that missing from SysEmuTarget:
> > 
> > Comparing the target-name prefixes of `configs/targets/*.mak` with the
> > `SysEmuTarget` enum in `qapi/machine.json`, the following seven names are
> > missing. All are Linux-user-only targets.
> > 
> > | Target name | Config |
> > |---|---|
> > | `aarch64_be` | `configs/targets/aarch64_be-linux-user.mak` |
> > | `armeb` | `configs/targets/armeb-linux-user.mak` |
> > | `microblazeel` | `configs/targets/microblazeel-linux-user.mak` |
> > | `mipsn32` | `configs/targets/mipsn32-linux-user.mak` |
> > | `mipsn32el` | `configs/targets/mipsn32el-linux-user.mak` |
> > | `ppc64le` | `configs/targets/ppc64le-linux-user.mak` |
> > | `sparc32plus` | `configs/targets/sparc32plus-linux-user.mak` |
> > 
> > All `*-softmmu` and `*-bsd-user` target names match enum entries.
> > 
> > This comparison uses names derived from config filenames, not the
> > `TARGET_ARCH` values inside those configs.
> > 
> > By doing this I think it would be more consistent.
> > If these target names are removed in future, then just remove it from
> > SysEmuTarget
> > along with. So SysEmuTarget is just a direct mapping of TARGET_NAME. Though
> > The comment of SysEmuTarget needs updated, it's not just about softmmu, but also
> > for linux-user and bsd-user. But the fact is, with the current
> > changes. *-user also
> > used SysEmuTarget as an enum.
> > 
> > 
> > And TARGET_ARCH should also be exported by TargetInfo for other usage.
> > And it's enums is the subset
> > of enum SysEmuTarget
> >
> 
> I tend to agree, but didn't find a real reason to do this change (yet).
> Also, I would be in favor to rename SysEmuTarget since in EmuTarget,
> since it would now be decoupled from system emulation only.
> 
> @Daniel: Would you be favor to see such a change? I know that
> introspection/QAPI is related to system emulation, and I'm not
> completely sure adding user targets is the right move at this moment.

The QAPI type names are purely internal - they're not exposed to
clients of QMP, so we can (and have) renamed the types in the
past.

If SysEmuTarget gains some more enum values that correspond
to linux-user targets, that would be visible when introspecting
the QAPI schema. I don't think that is a problem though - it is
always possible for SysEmuTarget to return a bunch of names, for
which there is no binary. All that matters really is that
query-target returns the right name.

So I think the rename + extra targets is fine.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


