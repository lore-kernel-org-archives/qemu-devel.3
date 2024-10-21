Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D327D15DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 15:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2tvG-0000QM-SU; Mon, 21 Oct 2024 11:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2tvF-0000Q7-6x
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:02:17 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2tvC-0002na-P5
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729522935; x=1761058935;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=CBmnK50kHKPX2WZ5rEY88VHDRhyNYz2aXRI1lQbPYyA=;
 b=FrMRC+yrVSZTyLi+jtXU1EDf9s+BkXVc3lVV2T3+Sx6vRM+F6MWEegjh
 v+/o+czLY2gxwREGrMrza4/oMfNTGt21DGDRzZJDpCc887Uu8r/bNS8uz
 /mV3MNmg8Q5Iz8oilnKloyuHyU0CpyTZikPhi+3W8OYqGrHILabkdYB2R
 jaH5gNosdTUjUW7e0/Ikp3lRY+C95LNJlYa1gmd8/MiKXFWmJooAQYaMk
 yFMwsytwAB4bvJyPS0DVy1/cJy7SaoR1HjukzImYAhMrfpNCB8CD6URQS
 klXEBhdQ7ROuxRjHBgK0d3OKV7QoGjI4sIlpY8WGz/2eReT8q+fEXQLw1 g==;
X-CSE-ConnectionGUID: 3a6XFYnNSmyNRja4EAxLrA==
X-CSE-MsgGUID: x6IY37nlS0G/EUUO/mEUeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28887276"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="28887276"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2024 08:02:11 -0700
X-CSE-ConnectionGUID: 6ChuHoqvSMOmOvU+/UoH+w==
X-CSE-MsgGUID: fxDKoIxrQLGh3yQ5h2M0cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; d="scan'208";a="83558638"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 21 Oct 2024 08:02:09 -0700
Date: Mon, 21 Oct 2024 23:18:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: Re: [Question] What is the =?gb2312?Q?defi?=
 =?gb2312?B?bml0aW9uIG9mIKGwcHJpdmF0ZaGx?= fields in QOM?
Message-ID: <ZxZwwe1ULIUqEdKN@intel.com>
References: <ZxPZ5oUDRcVroh7o@intel.com>
 <CAFEAcA8m4OeDHopFxCL3MP-cmu-PO5=2+MjNBG7YCudpKdoqDA@mail.gmail.com>
 <ZxZjqypRL7d2rMuQ@intel.com>
 <CAFEAcA-imJJQO=WAmCAHBY1MtszuPyyaD9OHWMRx88h-fjVvsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-imJJQO=WAmCAHBY1MtszuPyyaD9OHWMRx88h-fjVvsw@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIMWL_WL_HIGH=-0.421, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

On Mon, Oct 21, 2024 at 03:20:39PM +0100, Peter Maydell wrote:
> Date: Mon, 21 Oct 2024 15:20:39 +0100
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: Re: [Question] What is the definition of ¡°private¡± fields in
>  QOM?
> 
> On Mon, 21 Oct 2024 at 15:12, Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > Hi Peter,
> >
> > On Mon, Oct 21, 2024 at 10:25:07AM +0100, Peter Maydell wrote:
> > > Date: Mon, 21 Oct 2024 10:25:07 +0100
> > > From: Peter Maydell <peter.maydell@linaro.org>
> > > Subject: Re: [Question] What is the definition of ¡°private¡± fields in
> > >  QOM?
> > >
> > > On Sat, 19 Oct 2024 at 16:54, Zhao Liu <zhao1.liu@intel.com> wrote:
> > > >
> > > > Hi maintainers and list,
> > > >
> > > > In the QOM structure, the class and object structs have two members:
> > > > parent_class and parent_obj, which are often marked as "< private >" in
> > > > the comment.
> > > >
> > > > I couldn¡¯t find information on why to define ¡®private¡¯ and ¡®public¡¯,
> > > > even in the earliest QOM commits and the patch emails I could find.
> > >
> > > This is a rather old thing which I think was originally
> > > borrowed from glib's commenting convention.
> > >
> > > I'm fairly sure that we decided a while back that they were entirely
> > > unnecessary, so you don't need to add them in new code. (I can't
> > > actually find anything with a quick list search about that though
> > > so maybe I'm misremembering.)
> >
> > Thanks for your explanation! So I understand that directly accessing
> > parent_obj/parent_class is actually allowed.
> 
> No, you shouldn't do that. You can use a QOM cast of the
> object pointer to the relevant parent class if you need to
> treat it as an instance of the parent class.
>
> What I mean by "the private/public markers are unnecessary" is
> that they don't tell the reader anything, because all the fields
> in a QOM device struct are private.

This time I really understand the question of whether it's okay to
directly access parent_obj/parent_class. :-)

> If you're not in the implementation of that class, then you shouldn't
> really be directly touching any of the fields in the state struct.
> (In some places we take a shortcut and do it. But really it's almost
> never necessary.)

Thank you for your further explanation! I hadn¡¯t noticed that. So, for
other code (code outside the class/object implementation) to access the
fields other than parent_obj/parent_class of class/state struct, the
most ideal way would be to use the set/get property interfaces as
much as possible instead of accessing them directly, right?

Regards,
Zhao


