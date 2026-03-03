Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9CCEC1430
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 12:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxOZ5-0000GH-5A; Tue, 03 Mar 2026 07:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vxOZ3-0000G9-IA
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:09:25 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vxOZ1-0008Vw-PB
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=OPBiVr346EyTl/03ztyzkKSgI0SQ5anOyQFtNEvbWNA=; b=PuGa1o80qUW5vcc
 lCFhehxiS86cC5t/Ab6NLHJQXRXemkhSItEuuyPFgvKzUzwcppCxx8JguVCSIhE4UKPrdz74DtA+/
 ObGdIGbQcYqtLB66zUcA9V6+7SLbA2QRcH+jQN1HZGz6qjrx+G/aKw3Psjf1vSIyGVFN0z+6kflBP
 48=;
Date: Tue, 3 Mar 2026 13:12:50 +0100
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, 
	Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 4/4] hppa: Use 44 bit physical addresses for PA-8700
Message-ID: <aabLOU6RXx6sioi6@hive.localdomain>
References: <20260302-hppa-c3600-v4-0-447a800da8cc@rev.ng>
 <20260302-hppa-c3600-v4-4-447a800da8cc@rev.ng>
 <a61583f6-7be3-4c7f-94f7-a21a69eba5d7@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a61583f6-7be3-4c7f-94f7-a21a69eba5d7@gmx.de>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 03/03/26, Helge Deller wrote:
> On 3/2/26 12:56, Anton Johansson via qemu development wrote:
> > This is in line with the PA-8700 specification.
> > 
> > As the SeaBIOS functional tests requires a 40 bit physical address space
> 
> 44 bit physical address space?

Hmm maybe I'm missing something then, the 44 bit functional tests still
hangs.  From what I can tell mapping of the PDC address space results in
physical addresses starting with 0xf00f0xxxxxx for 44 bits, whereas SeaBIOS
uses 0xf0f0xxxxxx, meaning we require 40 bits to work with SeaBIOS from
QEMUs side.

  hwaddr hppa_abs_to_phys_pa2_w0(CPUHPPAState *env, vaddr addr)
  {
      /*
       * See Figure H-10, "Absolute Accesses when PSW W-bit is 0",
       * combined with Figure H-11, as above.
       */
      if (likely(extract32(addr, 28, 4) != 0xf)) {
          ...
      } else if (extract32(addr, 24, 4) != 0) {
          ...
      } else {
          /*
           * PDC address space:
           * Figures H-10 and H-11 of the parisc2.0 spec do not specify
           * where to map into the 64-bit PDC address space.
           * We map with an offset which equals the 32-bit address, which
           * is what can be seen on physical machines too.
           */
          addr = (uint32_t)addr;
          addr |= -1ull << (hppa_phys_addr_bits(env) - 4);
      }
      return addr;
  }

please let me know if I'm missing something!:)

