Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6E3D3C919
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 15:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2BmK-0001XB-PN; Sat, 19 Oct 2024 11:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2BmJ-0001Wz-5c
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 11:54:07 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2BmG-0006yR-Hi
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 11:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729353244; x=1760889244;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=jcLgcrq/lakvwSQ6mwTfSGUhu6IwsQgJswmReLdnNUQ=;
 b=P80uNctogF3S4Tg5eY2Irc0bYijpymYzatQzT66BTDSkB3DmNVZLYjeI
 DFD6qydpRSDTebjdoLD4I0Va3rg8FCygPykIDRb4Ks4aUebPuAQasuXFx
 yLF3NxstV3TxcYlmAhUljhzoPQKdfZ4cwUnh5eco+9Wi7/sbjWwhkVN7N
 Ryx8chtyFdD0g/kB35UYjKFC/MKnHXaOBVu4RBSNa+prphuAFASzDDP8T
 LWmEaazLXih/GJsXotEVaqo5j0ydGUrKEo5X/fqn25wpLUu2yehltghms
 zSwG7i0HXj/D/0FCPfOnqPybPfA7KLL562USqNomlqQcvDWoUQq2pgCht A==;
X-CSE-ConnectionGUID: 82LWl9NrTmqlNrjsIcqkDg==
X-CSE-MsgGUID: fuHH01THSb6yyQAgAqFPgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="40269529"
X-IronPort-AV: E=Sophos;i="6.11,216,1725346800"; d="scan'208";a="40269529"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2024 08:54:00 -0700
X-CSE-ConnectionGUID: ZvwRPPGAR6y9HKDVPNwUTA==
X-CSE-MsgGUID: hfhBTUYtSYS0EXFC7OHj4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,216,1725346800"; d="scan'208";a="102435466"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 19 Oct 2024 08:53:58 -0700
Date: Sun, 20 Oct 2024 00:10:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [Question] What is the =?gb2312?Q?definiti?=
 =?gb2312?B?b24gb2YgobBwcml2YXRlobE=?= fields in QOM?
Message-ID: <ZxPZ5oUDRcVroh7o@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

Hi maintainers and list,

In the QOM structure, the class and object structs have two members:
parent_class and parent_obj, which are often marked as "< private >" in
the comment.

I couldn¡¯t find information on why to define ¡®private¡¯ and ¡®public¡¯,
even in the earliest QOM commits and the patch emails I could find.

Does ¡®private¡¯ refer to the internal implementation code of QOM, or does
it refer to the specific code that defines and implements this object
and its class?

I understand the original idea of private field indicates it cannot be
accessed directly out of the "private" scope.

Regards,
Zhao


