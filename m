Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52FEC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 11:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkM6H-0004v1-MC; Tue, 18 Feb 2025 06:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1tkM6E-0004tt-Sb
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:49:14 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1tkM6A-0001lg-RP
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:49:12 -0500
Received: from kitsune.suse.cz (unknown [10.100.12.127])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0B7572116B;
 Tue, 18 Feb 2025 11:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739879349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VldoEI0HDZvLWDmPT25esxL5GUCoKa8MBkB2tncs4dY=;
 b=GUYJby5Hp8MdYXLNXbYb/wMcxgyM3EZLdBTXYxdSb4VPD7pVENX9xnDk6Qr4MX8fEkEf+r
 8KQzj9vkWbD32Hdf5rA3Cw50hXUxCMk+rGZMCNtV+voIuvhYO2S2OYJ/RspiO9CutF4OYZ
 MPbHf4t2AW5c00Pxn49YyYTJVnu3pOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739879349;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VldoEI0HDZvLWDmPT25esxL5GUCoKa8MBkB2tncs4dY=;
 b=J5071pe5+PDsFmQM/aJ6k+BpyhrozP0L0jO/ZC1+1JZOD/Ac+ejShLw3KHiW1WrcVPsLvp
 nNYibzPMDeD8xABQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739879349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VldoEI0HDZvLWDmPT25esxL5GUCoKa8MBkB2tncs4dY=;
 b=GUYJby5Hp8MdYXLNXbYb/wMcxgyM3EZLdBTXYxdSb4VPD7pVENX9xnDk6Qr4MX8fEkEf+r
 8KQzj9vkWbD32Hdf5rA3Cw50hXUxCMk+rGZMCNtV+voIuvhYO2S2OYJ/RspiO9CutF4OYZ
 MPbHf4t2AW5c00Pxn49YyYTJVnu3pOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739879349;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VldoEI0HDZvLWDmPT25esxL5GUCoKa8MBkB2tncs4dY=;
 b=J5071pe5+PDsFmQM/aJ6k+BpyhrozP0L0jO/ZC1+1JZOD/Ac+ejShLw3KHiW1WrcVPsLvp
 nNYibzPMDeD8xABQ==
Date: Tue, 18 Feb 2025 12:49:07 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: ROM files and non-x86
Message-ID: <Z7Rzs7S0M6t9RFjo@kitsune.suse.cz>
References: <a430de0f-1c27-4c52-97d4-b881efa47131@tls.msk.ru>
 <Z7RpEvbg7ecBN1vf@kitsune.suse.cz> <Z7RuaFVFBaOh2Gm0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7RuaFVFBaOh2Gm0@redhat.com>
X-Spamd-Result: default: False [-3.74 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MIXED_CHARSET(0.56)[subject];
 NEURAL_HAM_SHORT(-0.20)[-0.980]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_ZERO(0.00)[0]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=msuchanek@suse.de; helo=smtp-out1.suse.de
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

On Tue, Feb 18, 2025 at 11:26:32AM +0000, Daniel P. Berrangé wrote:
> On Tue, Feb 18, 2025 at 12:03:46PM +0100, Michal Suchánek wrote:
> > Hello,
> > 
> > this came up because these rom files are somewhat difficult to build on
> > non-x86, and distributions that have problem with distributing blobs
> > verbatim may be missing them.
> 
> How is the proposal going to help distros though ? Even if QEMU stops
> using the redundant ROMs from qemu-system-aarch64, they're still going
> to be needed by qemu-system-x86_64, which will be shipped on all arch
> hosts. So surely *all* non-x86 build targets still need to be able
> to cross-compile the x86 ROMs.

Or make arangements for cross-architecture installation of the package.
So long as you want to do x86 emulatated machine on non-x86 that also
boots from network it would be a problem to not have the iPXE roms. And
similar for Arm/RiscV/Loongarch which are also supported by iPXE but
need a different architecture-specific ROM to be bootable. Not sure how
well that actually works with qemu.

Thanks

Michal

