Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81C9E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJTcZ-0002tP-63; Fri, 06 Dec 2024 03:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJTcV-0002t7-4S; Fri, 06 Dec 2024 03:23:27 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJTcS-0005R8-Ju; Fri, 06 Dec 2024 03:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733473404; x=1765009404;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=d0bBf2aJq8qJrZoVZcY56IO4lvha0pWpGB3hXm0gvmA=;
 b=j5tO/07TmJWVc2rWRMkNuK+hyqrxTdGR+pu9MQRiXEn6J9WCZozY8rvy
 HRVh3cWao9xch2BOdftXOD8eoYo2gZhEOwLZjEnSCae7jkGB5eUlMufG3
 ktoN4V17XceaFpDPetNLn25r/IY9Y+iydBAKF3G/UdrQGcJXNektuHONc
 DJjkVgER/nwTJWJwjrgM1ina0M7WKs+WD3Ps4827BPjqMHVR+yNbUDhqY
 sBV997mtAOVoK+CuvLtLnY9oev4s+nUk61eDaNUqFKdqM7DAWI76LSkav
 cxCrn87wuGpVYPlt6MDTQbNBAPIi++dYFmDTCWjQWv67hTnsvoqD4oO9y w==;
X-CSE-ConnectionGUID: GlDiDHhzTKKrnJKZsW8VeA==
X-CSE-MsgGUID: 4SklLraBStaMg4r4YrjdWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33941573"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; d="scan'208";a="33941573"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2024 00:23:19 -0800
X-CSE-ConnectionGUID: ligpvUqCQP+Ei2gTyr+14g==
X-CSE-MsgGUID: kL1r/oqaToOgHmxHrad7RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; d="scan'208";a="125188180"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 06 Dec 2024 00:23:16 -0800
Date: Fri, 6 Dec 2024 16:41:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 06/13] rust: add bindings for memattrs
Message-ID: <Z1K4uc+XJIypkNaw@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-7-zhao1.liu@intel.com>
 <b34733f3-1525-4e35-8c07-f84ad56b01e0@linaro.org>
 <1f008c2a-aaf6-497d-becd-f36f5d9aea17@redhat.com>
 <edfa85a7-2963-46d8-8b02-4d22ec1aeee6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edfa85a7-2963-46d8-8b02-4d22ec1aeee6@linaro.org>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Dec 05, 2024 at 05:51:42PM -0600, Richard Henderson wrote:
> Date: Thu, 5 Dec 2024 17:51:42 -0600
> From: Richard Henderson <richard.henderson@linaro.org>
> Subject: Re: [RFC 06/13] rust: add bindings for memattrs
> 
> On 12/5/24 12:30, Paolo Bonzini wrote:
> > On 12/5/24 19:15, Richard Henderson wrote:
> > > On 12/5/24 00:07, Zhao Liu wrote:
> > > > The MemTxAttrs structure is composed of bitfield members, and bindgen is
> > > > unable to generate an equivalent macro definition for
> > > > MEMTXATTRS_UNSPECIFIED.
> > > 
> > > I'm happy to move away from bit fields to uint32_t or suchlike to
> > > enable MEMTXATTRS_UNSPECIFIED be a compile-time constant.
> > 
> > Yeah, if we go from
> > 
> > typedef struct MemTxAttrs {
> >      unsigned int unspecified:1;
> >      unsigned int secure:1;
> >      unsigned int space:2;
> >      unsigned int user:1;
> >      unsigned int memory:1;
> >      unsigned int requester_id:16;
> >      unsigned int pid:8;
> > } MemTxAttrs;
> > 
> > to
> > 
> > typedef struct MemTxAttrs {
> >      uint8_t unspecified;
> >      uint8_t secure;
> >      uint8_t space;
> >      uint8_t user;
> >      uint8_t memory;
> >      uint8_t pid;
> >      uint16_t requester_id;
> > } MemTxAttrs;
> > 
> > is still decently packed and simplifies things a lot.  Zhao, can you
> > submit that as an independent patch?
> Hmm.  I'd been thinking of uint32_t and hw/registerfields.h, but I have not
> scoped the size of that conversion.
> 
> But short of that, please use 'bool' not 'uint8_t' for those single-bit flags.
> 

Sure! Thank u both!

BTW, may I ask why you favor bool over uint8_t, and is it because they
are indeed just 0/1 as well? :)

Thanks,
Zhao



