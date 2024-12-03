Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E08DE74AC8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 19:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIY9y-00087H-9s; Tue, 03 Dec 2024 14:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIY9x-000879-3L
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 14:02:09 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIY9u-00020d-Av
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 14:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=O0+lBKty7D0NaVgsn7Mgh/tEf3xXvtploIQ+VVqiCG0=; b=CWE2Vbq7njOS7g5
 iDsBQvSa7cOiN26bcOEbYAywlJeO7sDd55O8QKSfU5E+IFgviXtpI/ePTc/v2s12fsk+ZKrakAjnB
 dYyiMJ+fPMzQb+I6ycL16pn8k9aySJDZ/aQ9BOjA8JjnKIhlNZYGQknDSEESQ4YHk/dxKSq8N2Tcm
 YE=;
Date: Tue, 3 Dec 2024 20:05:05 +0100
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org, ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [RFC PATCH v1 01/43] Add option to enable/disable helper-to-tcg
Message-ID: <vsk3f7dzcxyubzycaj2xacw6xsn43tqkrkjhywalif3jfndc2v@lyhm4f63grxi>
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-2-anjo@rev.ng>
 <c478cbc8-6684-4a8d-bd88-724d48098c36@linaro.org>
 <240aa88b-7ac4-4852-9c40-4fb5d8fbd89a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <240aa88b-7ac4-4852-9c40-4fb5d8fbd89a@redhat.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 22/11/24, Paolo Bonzini wrote:
> On 11/22/24 18:30, Richard Henderson wrote:
> > On 11/20/24 19:49, Anton Johansson wrote:
> > > Adds a meson option for enabling/disabling helper-to-tcg along with a
> > > CONFIG_* definition.
> > > 
> > > CONFIG_* will in future commits be used to conditionally include the
> > > helper-to-tcg subproject, and to remove unneeded code/memory when
> > > helper-to-tcg is not in use.
> > > 
> > > Current meson option is limited to Hexagon, as helper-to-tcg will be
> > > included as a subproject from target/hexagon.  This will change in the
> > > future if multiple frontends adopt helper-to-tcg.
> > > 
> > > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > > ---
> > >   meson.build                   | 7 +++++++
> > >   meson_options.txt             | 2 ++
> > >   scripts/meson-buildoptions.sh | 5 +++++
> > >   3 files changed, 14 insertions(+)
> > 
> > Looks ok.  Could probably stand another set of meson eyes.
> > 
> > Acked-by: Richard Henderson <richard.henderson@linaro.org>
> 
> /me bows
> 
> Since the subproject has a pretty hefty (and specific) set of
> dependencies, please make this a "feature" option.  This allows
> subprojects/helper-to-tcg to disable itself if it cannot find
> a dependency or otherwise invokes error(), without breaking the
> build.  The --enable-hexagon-helper-to-tcg flag however *will*
> force the subproject to be buildable, just like all other
> QEMU feature options.
> 
> Something like this:
> 
> 
> ########################
> # Target configuration #
> ########################
> 
> # a bit gross to hardcode hexagon, but acceptable given the name of the option
> helper_to_tcg = subproject('helper-to-tcg', get_option('hexagon_helper_to_tcg') \
>    .disable_auto_if('hexagon-linux-user' not in target_dirs))
> 
> 
> and replace helper_to_tcg_enabled throughout with helper_to_tcg.found().
> 
> > > +  if helper_to_tcg_enabled
> > > +    config_target += {
> > > +      'CONFIG_HELPER_TO_TCG': 'y',
> > > +    }
> > > +  endif
> 
> Here I would add instead add CONFIG_HELPER_TO_TCG (maybe renamed to
> TARGET_HELPER_TO_TCG) in configs/targets/) and add before the loop:
> 
> ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
> if not helper_to_tcg.found()
>   # do not define it if it is not usable
>   ignored += ['TARGET_HELPER_TO_TCG']
> endif
> 
> Paolo
> 

Makes sense, appreciate it!:) There's always something new to learn about meson

//Anton

